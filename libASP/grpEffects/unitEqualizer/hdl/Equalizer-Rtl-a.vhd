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
  type aCoeffRom is aMemory(0 to cEQBAndpassOrder*cNumberOfBands);
  type aCoeffRam is aMemory(0 to cEQBAndpassOrder + cNumberOfBands*2);
  type aGainRam  is aMemory(0 to cNumberOfBands-1);
  type aBPResults is aMemory(0 to cNumberOfBands-1);

  type aFirState is (NewVal, FirMultSum, BpResultMult);

  type aFirParam is record
    firState  : aFirStates;
    writeAdr  : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    readAdr   : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    coeffAdr  : unsigned(LogDualis(gBPCoeff(0)'length)-1 downto 0);
    valDry    : std_ulogic;
    dDry      : aFilterCoeff;
    FirSum    : aFilterCoeff;
    FirMulRes : aFilterCoeff;
    GainMulRes : aFilterCoeff;
    GainSum    : aFilterCoeff;
    valWet     : std_ulogic;
  end record aFirParam;

  constant cInitFirParam : aFirParam := ( firState  => NewVal,
                                          writeAdr  => (others => '0'),
                                          readAdr   => (others => '0'),
                                          coeffAdr  => (others => '0'),
                                          valDry    => '0',
                                          dDry      => (others => '0'),
                                          FirSum    => (others => '0'),
                                          FirMulRes => (others => '0'),
                                          valWet    => '0');

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
  signal RAM      : aCoeffRam    := (others => (others => '0'));
  signal RAM_Gain : aGainRam     := (others => (others => '0'));
  signal BPResult : aBPResults   := (others => (others => '0'));
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
  aso_data   <= ;
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
                    nxR.firState <= MulSum;

                    if R.readAdr = gBPCoeff(0)'length-1 then
                        nxR.readAdr <= (others => '0');
                    else
                        nxR.readAdr <= R.readAdr + 1;
                    end if;
                end if;

            when MulSum =>
                nxR.FirMulRes <= ResizeTruncAbsVal(readVal * coeffVal, R.FirMulRes);

                if R.coeffAdr = gBPCoeff(0)'length-1 then
                    nxR.firState    <= NewVal;
                    nxR.coeffAdr    <= (others => '0');
                    nxR.valWet      <= '1';

                    if R.writeAdr = gBPCoeff(0)'length-1 then
                        nxR.writeAdr <= (others => '0');
                    else
                        nxR.writeAdr <= R.writeAdr + 1;
                    end if;

                else
                    nxR.coeffAdr <= R.coeffAdr + 1;

                    if R.readAdr = gBPCoeff(0)'length-1 then
                        nxR.readAdr <= (others => '0');
                    else
                        nxR.readAdr <= R.readAdr + 1;
                    end if;
                end if;

                nxR.FirSum <= ResizeTruncAbsVal(R.FirSum + R.FirMulRes, R.FirSum);

            when BpResultMult =>
                nxR.GainMulRes <= ResizeTruncAbsVal(BPResult(i) * actGain, R.GainMulRes);
                nxR.GainSum    <= ResizeTruncAbsVal(R.Gain + R.GainMulRes, R.GainSum);

            when others =>
                nxR.firState <= NewVal;
        end case;
    end process FSM;

  ---------------------------------------------------------------------------
  -- Register process
  ---------------------------------------------------------------------------

  -- Read and write RAM
  CoeffRAM : process (iClk) is
  begin
    if rising_edge(iClk) then
      if iValDry = '1' then
        RAM(to_integer(R.writeAdr)) <= iDdry;
      end if;
     readVal <= RAM(to_integer(R.readAdr));
    end if;
  end process CoeffRAM;

  -- MM INTERFACE for gain configuration, memory is part of RAM
  ConfigGains : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if avs_s0_write = '1' then
        RAM_Gain(to_integer(unsigned(avs_s0_address)))
            <= to_sfixed(avs_s0_writedata, RAM_Gain(0);
      end if;
    actGain <= RAM_Gain(to_integer(R.readAddr));
    end if;
  end process ConfigGains;

  Reg : process (iClk, inResetAsync) is
  begin
    if (inResetAsync = cResetActive) then
      R <= cInitFirParam;
    elsif rising_edge(iClk) then
      R <= nxR;
    end if;
  end process Reg;

end architecture Rtl;
