-------------------------------------------------------------------------------
-- Title       : FIR - Filter
-- Author      : Franz Steinbacher, Michael Wurm
-------------------------------------------------------------------------------
-- Description : Finite Impule Response Filter with Avalon MM interface for
-- coeffs configuration.
-------------------------------------------------------------------------------

architecture RtlRam of DspFir is

  ----------------------------------------------------------------------------
  -- Types
  ----------------------------------------------------------------------------
  type aMemory is array (0 to gB'length-1) of
    aAudioData(0 downto -(gAudioBitWidth-1));

  type aFirStates is (NewVal, MulSum);

  type aFirParam is record
    firState : aFirStates;
    writeAdr : unsigned(LogDualis(gB'length)-1 downto 0);
    readAdr  : unsigned(LogDualis(gB'length)-1 downto 0);
    coeffAdr : unsigned(LogDualis(gB'length)-1 downto 0);
    valDry   : std_ulogic;
    dDry     : aAudioData(0 downto -(gAudioBitWidth-1));
    sum      : aAudioData(0 downto -(gAudioBitWidth-1));
    mulRes   : aAudioData(0 downto -(gAudioBitWidth-1));
    valWet   : std_ulogic;
  end record aFirParam;

  ----------------------------------------------------------------------------
  -- Constants
  ----------------------------------------------------------------------------
  constant cInitFirParam : aFirParam := (firState => NewVal,
                                         writeAdr => (others => '0'),
                                         readAdr  => (others => '0'),
                                         coeffAdr => (others => '0'),
                                         valDry   => '0',
                                         dDry     => (others => '0'),
                                         sum      => (others => '0'),
                                         mulRes   => (others => '0'),
                                         valWet   => '0'
                                         );

  ----------------------------------------------------------------------------
  -- Functions
  ----------------------------------------------------------------------------
  function romInit return aMemory is
    variable rom : aMemory := (others => (others => '0'));
  begin
    for adr in rom'range loop
      rom(adr) := to_sfixed(gB(adr), rom(adr));
    end loop;
    return rom;
  end romInit;

  procedure incr_addr (
    signal in_addr  : in  unsigned(LogDualis(gB'length)-1 downto 0);
    signal out_addr : out unsigned(LogDualis(gB'length)-1 downto 0)
    ) is
  begin
    if (in_addr = (gB'length - 1)) then
      out_addr <= (others => '0');
    else
      out_addr <= in_addr + 1;
    end if;
  end incr_addr;

  ----------------------------------------------------------------------------
  -- Signals
  ----------------------------------------------------------------------------
  signal InputRam : aMemory                                  := (others => (others => '0'));
  signal CoeffRom : aMemory                                  := romInit;
  signal R        : aFirParam                                := cInitFirParam;
  signal nxR      : aFirParam                                := cInitFirParam;
  signal readVal  : aAudioData(0 downto -(gAudioBitWidth-1)) := (others => '0');
  signal coeffVal : aAudioData(0 downto -(gAudioBitWidth-1)) := (others => '0');

begin

  ----------------------------------------------------------------------------
  -- Outputs
  ----------------------------------------------------------------------------
  oDwet   <= R.sum;
  oValWet <= R.valWet;

  ----------------------------------------------------------------------------
  -- FSMD
  ----------------------------------------------------------------------------
  Comb : process (R, iValDry, readVal, coeffVal) is
  begin

    nxR <= R;

    case R.firState is
      when NewVal =>
        nxR.valWet <= '0';
        nxR.sum    <= (others => '0');

        -- wait here for new sample
        if iValDry = '1' then
          nxR.firState <= MulSum;

          incr_addr(R.readAdr, nxR.readAdr);
        end if;

      when MulSum =>
        nxR.mulRes <= ResizeTruncAbsVal(readVal * coeffVal, nxR.mulRes);
        nxR.sum    <= ResizeTruncAbsVal(R.sum + R.mulRes, nxR.sum);

        if R.coeffAdr = gB'length-1 then
          nxR.firState <= NewVal;
          nxR.coeffAdr <= (others => '0');
          nxR.valWet   <= '1';

          incr_addr(R.writeAdr, nxR.writeAdr);
        end if;

        incr_addr(R.coeffAdr, nxR.coeffAdr);
        incr_addr(R.readAdr, nxR.readAdr);

      when others =>
        nxR.firState <= NewVal;
    end case;
  end process Comb;

  ----------------------------------------------------------------------------
  -- Read and write RAM
  ----------------------------------------------------------------------------
  AccessInputRam : process (iClk) is
  begin
    if rising_edge(iClk) then
      if iValDry = '1' then
        InputRam(to_integer(R.writeAdr)) <= iDdry;
      end if;

      readVal <= InputRam(to_integer(R.readAdr));
    end if;
  end process AccessInputRam;

  ----------------------------------------------------------------------------
  -- ROM
  ----------------------------------------------------------------------------
  AccessRom : process (iClk) is
  begin
    if rising_edge(iClk) then
      coeffVal <= CoeffRom(to_integer(R.coeffAdr));
    end if;
  end process AccessRom;

  ----------------------------------------------------------------------------
  -- Register process
  ----------------------------------------------------------------------------
  Regs : process (iClk, inResetAsync) is
  begin
    if inResetAsync = cResetActive then
      R <= cInitFirParam;
    elsif rising_edge(iClk) then
      R <= nxR;
    end if;
  end process Regs;

end architecture;
