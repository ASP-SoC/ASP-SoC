-------------------------------------------------------------------------------
-- Title       : Equalizer Single Channel
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable gain factor
--               Can only handle a single channel.
--               Multiplications are all serialized, so that only 1 hardware
--               multiplier is utilized.
-------------------------------------------------------------------------------

-- ROM Structure
--  All Filter Coefficients : cNumOfBands*cEQBAndpassOrder
--
-- RAM1 Structure "RAM_Gain" (Memory Mapped Configuration)
--  Gain Values : cNumOfBands
--
-- RAM2 Structure "RAM"
--  Fir Calc Values : cEQBAndpassOrder
--
-- Registers
--  cNumOfBands : BP Results

architecture Rtl of EqualizerSingleCh is
  ---------------------------------------------------------------------------
  -- Constants
  ---------------------------------------------------------------------------
  constant cNumCoeffsPerFIR : natural := cEQBAndpassOrder + 1;

  ---------------------------------------------------------------------------
  -- Types
  ---------------------------------------------------------------------------
  type aFirState is (NewVal, FirMultSum, MultGains);

  type aFirParam is record
    firState     : aFirState;
    writeAddrIn  : natural;-- range 0 to cNumCoeffsPerFIR-1;
    readAddrIn   : natural;-- range 0 to cNumCoeffsPerFIR-1;
    coeffAdr     : natural;-- range 0 to cNumCoeffsPerFIR-1;
    gainAdr      : natural range 0 to cNumOfBands-1;
    activeFir    : natural range 0 to cNumOfBands-1;
    valDry       : std_ulogic;
    valWet       : std_ulogic;
    dDry         : aFilterCoeff;
    FirSum       : aFilterCoeff;
    FirMulRes    : aFilterCoeff;
    GainSum      : aFilterCoeff;
    FirResReg    : aMemory(0 to cNumOfBands-1);
    AfterGainReg : aMemory(0 to cNumOfBands-1);
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

  ---------------------------------------------------------------------------
  -- Functions and Procedures
  ---------------------------------------------------------------------------

  -- initializes ROM with filter coefficients of bandpasses
  function romInit return aMemory is
    variable rom : aMemory(0 to cNumCoeffsPerFIR*cNumOfBands-1);
    variable idx : natural := 0;
  begin
    for i in 0 to cNumOfBands-1 loop
      for adr in 0 to cNumCoeffsPerFIR-1 loop
        rom(idx) := to_sfixed(gBPCoeff(i)(adr), rom(idx));
        idx      := idx + 1;
      end loop;
    end loop;
    return rom;
  end romInit;

  -- initializes RAM with gain values of 1
  function ramGainInit return aMemory is
    variable ram : aMemory(0 to cNumOfBands-1);
  begin
    for i in ram'range loop
      ram(i) := to_sfixed(0.99999999999999,ram(i));
    end loop;
    return ram;
  end ramGainInit;

  -- increments a value to maximum, with overflow handling
  procedure incr_addr (
    signal in_addr   : in  natural;
    signal out_addr  : out natural;
    constant maximum : in  natural) is
  begin
    if in_addr = (maximum - 1) then
      out_addr <= 0;
    else
      out_addr <= in_addr + 1;
    end if;
  end incr_addr;

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  signal CoeffRom : aMemory(0 to cNumCoeffsPerFIR*cNumOfBands-1) := romInit;
  signal GainRAM  : aMemory(0 to cNumOfBands-1)                  := ramGainInit;
  signal InputRAM : aMemory(0 to cNumCoeffsPerFIR-1)             := (others => (others => '0'));

  signal nxR      : aFirParam    := cInitFirParam;
  signal R        : aFirParam    := cInitFirParam;

  signal actInDat : aFilterCoeff := (others => '0');
  signal actCoeff : aFilterCoeff := (others => '0');
  signal actGain  : aFilterCoeff := (others => '0');

  ---------------------------------------------------------------------------
  -- Wires
  ---------------------------------------------------------------------------


begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  aso_data  <= to_slv(R.GainSum);
  aso_valid <= R.valWet;

  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- FSMD
  ----------------------------------------------------------------------------
  FSM : process (R, asi_valid, actInDat, actCoeff, actGain) is
  begin

    nxR <= R;

    case R.firState is
      when NewVal =>
        ------------------------------------------------------------
        -- Wait for new value to arrive.
        ------------------------------------------------------------
        nxR.valWet    <= '0';
        nxR.FirSum <= (others => '0');
        nxR.activeFir <= 0;

        if asi_valid = '1' then
          nxR.firState <= FirMultSum;
          incr_addr(R.readAddrIn, nxR.readAddrIn, cNumCoeffsPerFIR);
        end if;

      when FirMultSum =>
        ------------------------------------------------------------
        -- Multiply input data samples with respective coefficients.
        -- All bandpasses calculate their values in this state.
        ------------------------------------------------------------
        nxR.FirMulRes <= ResizeTruncAbsVal(actInDat * actCoeff, R.FirMulRes);
        nxR.FirSum    <= ResizeTruncAbsVal(R.FirSum + R.FirMulRes, R.FirSum);

        incr_addr(R.coeffAdr, nxR.coeffAdr, CoeffRom'length);
        incr_addr(R.readAddrIn, nxR.readAddrIn, cNumCoeffsPerFIR);

        -- all bandpasses calculated?
        if R.coeffAdr = CoeffRom'length-1 then
          nxR.coeffAdr <= 0;
          nxR.gainAdr  <= 0;
          nxR.firState <= MultGains;

          incr_addr(R.writeAddrIn, nxR.writeAddrIn, cNumCoeffsPerFIR);
        end if;

        -- active FIR already calculated all values?
        if R.readAddrIn = InputRAM'length-1 then
          nxR.FirResReg(R.activeFir) <= R.FirSum; -- store active FIR's result

          if R.activeFir = cNumOfBands-1 then  -- last bandpasses finished?
            nxR.activeFir <= 0;
          else
            nxR.activeFir <= R.activeFir + 1;
          end if;
        end if;

      when MultGains =>
        ------------------------------------------------------------
        -- Multiply each FIR result with respective gain
        ------------------------------------------------------------
        nxR.AfterGainReg(R.gainAdr) <= ResizeTruncAbsVal(
            R.FirResReg(R.gainAdr) * actGain, R.AfterGainReg(R.gainAdr));

        -- sum up gained values
        nxR.GainSum <= ResizeTruncAbsVal(R.GainSum + R.AfterGainReg(R.gainAdr), R.GainSum);

        if R.gainAdr = GainRam'length-1 then
          nxR.gainAdr  <= 0;
          nxR.valWet   <= '1';
          nxR.firState <= NewVal;
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
            <= to_sfixed(avs_s0_writedata(GainRAM(0)'length-1 downto 0), GainRAM(0));
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
