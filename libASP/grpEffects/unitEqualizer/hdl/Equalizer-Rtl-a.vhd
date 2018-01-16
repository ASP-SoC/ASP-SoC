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
  type aCoeffRom     is aMemory(0 to cEQBAndpassOrder*cNumberOfBands);
  type aInputRam     is aMemory(0 to cEQBAndpassOrder);
  type aGainRam      is aMemory(0 to cNumberOfBands-1);
  type aFirResReg    is aMemory(0 to cNumberOfBands-1);
  type aAfterGainReg is aMemory(0 to cNumberOfBands-1);

  type aFirState is (NewVal, FirMultSum, MultGains);

  type aFirParam is record
    firState     : aFirStates;
    writeAddrIn  : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    readAddrIn   : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    coeffAdr     : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    gainAdr      : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    activeFir    : unsigned(LogDualis(cNumberOfBands)-1 downto 0);
    valDry       : std_ulogic;
    valWet       : std_ulogic;
    dDry         : aFilterCoeff;
    FirSum       : aFilterCoeff;
    FirMulRes    : aFilterCoeff;
    GainSum      : aFilterCoeff;
    FirResReg    : aFirResReg;
    AfterGainReg : aFirResReg;
  end record aFirParam;

  constant cInitFirParam : aFirParam := ( firState     => NewVal,
                                          writeAddrIn  => (others => '0'),
                                          readAddrIn   => (others => '0'),
                                          coeffAdr     => (others => '0'),
                                          gainAdr      => (others => '0'),
                                          activeFir    => (others => '0'),
                                          valDry       => '0',
                                          valWet       => '0',
                                          dDry         => (others => '0'),
                                          FirSum       => (others => '0'),
                                          FirMulRes    => (others => '0'),
                                          GainSum      => (others => '0'),
                                          FirResReg    => (others => (others => '0')),
                                          AfterGainReg => (others => (others => '0'))
                                        );

  function romInit return aRomMem is
    variable rom : aCoeffRom := (others => (others => '0'));
    variable idx : natural;
  begin
    for i in 0 to cNumberOfBands-1 loop
      for adr in rom'range loop
        idx      := cEQBAndpassOrder*i + adr;
        rom(idx) := to_sfixed(gBPCoeff(idx), rom(idx));
      end loop;
    end loop;
    return rom;
  end romInit;

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  signal CoeffRom : aCoeffRom    := romInit;
  signal InputRAM : aInputRam    := (others => (others => '0'));
  signal GainRAM  : aGainRam     := (others => (others => '0'));

  signal nxR      : aFirParam    := cInitFirParam;
  signal R        : aFirParam    := cInitFirParam;

  signal readVal  : aFilterCoeff := (others => '0');
  signal coeffVal : aFilterCoeff := (others => '0');
  signal actGain  : aFilterCoeff := (others => '0');

  ---------------------------------------------------------------------------
  -- Wires
  ---------------------------------------------------------------------------
  signal bp_valid : std_ulogic;

begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  aso_data   <= R.GainSum;
  aso_valid  <= ;

  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- FSMD
  ----------------------------------------------------------------------------
  FSM : process (iDdry, iValDry, R) is
  begin

    nxR <= R;

    case R.firState is
      when NewVal =>
        nxR.valWet <= '0';
        nxR.FirSum <= (others => '0');

        if iValDry = '1' then
          nxR.firState <= FirMultSum;

          if R.readAddrIn = gBPCoeff(0)'length-1 then
            nxR.readAddrIn <= (others => '0');
          else
            nxR.readAddrIn <= R.readAddrIn + 1;
          end if;
        end if;

      when FirMultSum =>
        nxR.FirMulRes <= ResizeTruncAbsVal(actInDat * actCoeff, R.FirMulRes);
        nxR.FirSum    <= ResizeTruncAbsVal(R.FirSum + R.FirMulRes, R.FirSum);

        -- all bandpasses calculated?
        if R.coeffAdr = gBPCoeff(0)'length-1 then
          nxR.coeffAdr <= (others => '0');
          nxR.gainAdr  <= (others => '0');
          nxR.valWet   <= '1';
          nxR.firState <= MultGains;

          if R.writeAddrIn = gBPCoeff(0)'length-1 then
            nxR.writeAddrIn <= (others => '0');
          else
            nxR.writeAddrIn <= R.writeAddrIn + 1;
          end if;

        else
          nxR.firState <= FirMultSum;
          nxR.coeffAdr <= R.coeffAdr + 1;

          -- active FIR already calculated all values?
          if R.readAddrIn = InputRAM'length-1 then
            nxR.readAddrIn <= (others => '0');
            nxR.activeFir <= R.activeFir + 1;
          else
            nxR.readAddrIn <= R.readAddrIn + 1;
          end if;
        end if;

      when MultGains =>
        -- multiply FirResult with respective gain
        nxR.AfterGainReg(R.gainAdr) <= ResizeTruncAbsVal(
            R.FirResReg(R.gainAdr) * actGain, R.AfterGainReg(R.gainAdr));

        -- sum up gained values
        nxR.GainSum <= ResizeTruncAbsVal(R.GainSum + R.AfterGainReg(R.gainAdr), R.GainSum);

        if max gainAdr reached
         nxR.gainAdr <= others 0
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
  Input_RAM : process (iClk) is
  begin
    if rising_edge(iClk) then
      if iValDry = '1' then
        InputRAM(to_integer(R.writeAddrIn)) <= iDdry;
      end if;
     actInDat <= InputRAM(to_integer(R.readAddrIn));
    end if;
  end process Input_RAM;

    -- ROM that holds filter coefficients
  Coeff_ROM : process (iClk) is
  begin
    if rising_edge(iClk) then
     actCoeff <= CoeffROM(to_integer(R.coeffAdr));
    end if;
  end process Coeff_ROM;

  -- MM INTERFACE for gain configuration, memory is part of RAM
  ConfigGains : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if avs_s0_write = '1' then
        GainRAM(to_integer(unsigned(avs_s0_address)))
            <= to_sfixed(avs_s0_writedata, GainRAM(0);
      end if;
    actGain <= GainRAM(to_integer(R.gainAdr));
    end if;
  end process ConfigGains;

  -- Register process
  Reg : process (iClk, inResetAsync) is
  begin
    if (inResetAsync = cResetActive) then
      R <= cInitFirParam;
    elsif rising_edge(iClk) then
      R <= nxR;
    end if;
  end process Reg;

end architecture Rtl;
