-------------------------------------------------------------------------------
-- Title       : Equalizer
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
-------------------------------------------------------------------------------

-- ROM Structure
--  All Filter Coefficients : cNumberOfBands*cEQBAndpassOrder
--
-- RAM1 Structure "RAM_Gain" (Memory Mapped Configuration)
--  Gain Values : cNumberOfBands
--
-- RAM2 Structure "RAM"
--  Fir Calc Values : cEQBAndpassOrder
--
-- Registers
--  cNumberOfBands : BP Results

architecture Rtl of Equalizer is
  ---------------------------------------------------------------------------
  -- Types
  ---------------------------------------------------------------------------
  type aFirState is (NewVal, FirMultSum, MultGains);

  type aFirParam is record
    firState     : aFirState;
    writeAddrIn  : natural range 0 to LogDualis(gBPCoeff(0)'length)-1;
    readAddrIn   : natural range 0 to LogDualis(gBPCoeff(0)'length)-1;
    coeffAdr     : natural range 0 to LogDualis(gBPCoeff(0)'length)-1;
    gainAdr      : natural range 0 to LogDualis(cNumberOfBands)-1;
    activeFir    : natural range 0 to LogDualis(cNumberOfBands)-1;
    valDry       : std_ulogic;
    valWet       : std_ulogic;
    dDry         : aFilterCoeff;
    FirSum       : aFilterCoeff;
    FirMulRes    : aFilterCoeff;
    GainSum      : aFilterCoeff;
    FirResReg    : aMemory(0 to cNumberOfBands-1);
    AfterGainReg : aMemory(0 to cNumberOfBands-1);
  end record aFirParam;

  constant cInitFirParam : aFirParam := ( firState     => NewVal,
                                          writeAddrIn  => 0,
                                          readAddrIn   => 0,
                                          coeffAdr     => 0,
                                          gainAdr      => 0,
                                          activeFir    => 0,
                                          valDry       => '0',
                                          valWet       => '0',
                                          dDry         => (others => '0'),
                                          FirSum       => (others => '0'),
                                          FirMulRes    => (others => '0'),
                                          GainSum      => (others => '0'),
                                          FirResReg    => (others => (others => '0')),
                                          AfterGainReg => (others => (others => '0'))
                                        );

  function romInit return aMemory is
    variable rom : aMemory(0 to cEQBAndpassOrder*cNumberOfBands);
    variable idx : natural := 0;
  begin
    for i in 0 to cNumberOfBands-1 loop
      for adr in 0 to cEQBAndpassOrder loop
        rom(idx) := to_sfixed(gBPCoeff(i)(adr), rom(idx));
        idx      := idx + 1;
      end loop;
    end loop;
    return rom;
  end romInit;

  procedure incr_addr (
    signal in_addr  	: in  natural;
    signal out_addr 	: out natural) is
  begin
    if (in_addr = (gBPCoeff(0)'length - 1)) then
      out_addr <= 0;
    else
      out_addr <= in_addr + 1;
    end if;
  end incr_addr;

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  signal CoeffRom : aMemory(0 to cEQBAndpassOrder) := romInit;
  signal InputRAM : aMemory(0 to cEQBAndpassOrder) := (others => (others => '0'));
  signal GainRAM  : aMemory(0 to cNumberOfBands-1) := (others => (others => '0'));

  signal nxR      : aFirParam    := cInitFirParam;
  signal R        : aFirParam    := cInitFirParam;

  signal actInDat : aFilterCoeff := (others => '0');
  signal actCoeff : aFilterCoeff := (others => '0');
  signal actGain  : aFilterCoeff := (others => '0');

  ---------------------------------------------------------------------------
  -- Wires
  ---------------------------------------------------------------------------
  signal bp_valid : std_ulogic;

begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  aso_data  <= std_ulogic_vector(R.GainSum);
  aso_valid <= R.valWet;

  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- FSMD
  ----------------------------------------------------------------------------
  FSM : process (asi_data, asi_valid, R) is
  begin

    nxR <= R;

    case R.firState is
      when NewVal =>
        nxR.valWet <= '0';
        nxR.FirSum <= (others => '0');

        if asi_valid = '1' then
          nxR.firState <= FirMultSum;
          incr_addr(R.readAddrIn,nxR.readAddrIn);
        end if;

      when FirMultSum =>
        nxR.FirMulRes <= ResizeTruncAbsVal(actInDat * actCoeff, R.FirMulRes);
        nxR.FirSum    <= ResizeTruncAbsVal(R.FirSum + R.FirMulRes, R.FirSum);

        incr_addr(R.coeffAdr, nxR.coeffAdr);
        incr_addr(R.readAddrIn, nxR.readAddrIn);

        -- all bandpasses calculated?
        if R.coeffAdr = gBPCoeff(0)'length-1 then
          nxR.coeffAdr <= 0;
          nxR.gainAdr  <= 0;
          nxR.firState <= MultGains;

          incr_addr(R.writeAddrIn, nxR.writeAddrIn);
        end if;

        -- active FIR already calculated all values?
        if R.readAddrIn = InputRAM'length-1 then
          nxR.activeFir <= R.activeFir + 1;
        end if;

      when MultGains =>
        -- multiply FirResult with respective gain
        nxR.AfterGainReg(R.gainAdr) <= ResizeTruncAbsVal(
            R.FirResReg(R.gainAdr) * actGain, R.AfterGainReg(R.gainAdr));

        -- sum up gained values
        nxR.GainSum <= ResizeTruncAbsVal(R.GainSum + R.AfterGainReg(R.gainAdr), R.GainSum);

        if R.gainAdr = GainRam'length-1 then
          nxR.gainAdr  <= 0;
          nxR.firState <= NewVal;
          nxR.valWet   <= '1';
        else
          nxR.gainAdr <= R.gainAdr + 1;
        end if;

        when others =>
        nxR.firState <= NewVal;
    end case;
  end process FSM;

  ---------------------------------------------------------------------------
  -- Memory processes
  ---------------------------------------------------------------------------

  -- RAM that holds input values
  Input_RAM : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if asi_valid = '1' then
        InputRAM(R.writeAddrIn) <= to_sfixed(asi_data,InputRAM(0));
      end if;
     actInDat <= InputRAM(R.readAddrIn);
    end if;
  end process Input_RAM;

    -- ROM that holds filter coefficients
  Coeff_ROM : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
     actCoeff <= CoeffROM(R.coeffAdr);
    end if;
  end process Coeff_ROM;

  -- MM INTERFACE for gain configuration, memory is part of RAM
  ConfigGains : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if avs_s0_write = '1' then
        GainRAM(to_integer(unsigned(avs_s0_address)))
            <= to_sfixed(avs_s0_writedata, GainRAM(0));
      end if;
    actGain <= GainRAM(R.gainAdr);
    end if;
  end process ConfigGains;

  -- Register process
  Reg : process (csi_clk, rsi_reset_n) is
  begin
    if (rsi_reset_n = cResetActive) then
      R <= cInitFirParam;
    elsif rising_edge(csi_clk) then
      R <= nxR;
    end if;
  end process Reg;

end architecture Rtl;
