-------------------------------------------------------------------------------
-- Title      : Strobe Generator
-- Project    : General IP
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------

architecture Rtl of StrobeGen is

  constant cClkCycPerStrobeCyc : natural :=
    gClkFrequency / (1 sec / gStrobeCycleTime);
  constant cClkCounterHighIndex : natural := LogDualis(cClkCycPerStrobeCyc);

  signal ClkCounter : unsigned(cClkCounterHighIndex downto 0);

begin  -- architecture Rtl

  -- Count the number of Clk cycles from strobe pulse to strobe pulse.
  GenStrobe : process (iClk, inResetAsync) is
  begin  -- process GenStrobe

    -- Asynchronous reset
    if inResetAsync = cnActivated then

      ClkCounter <= to_unsigned(0, ClkCounter'length);
      oStrobe <= cInactivated;

    -- Rising clk edge
    elsif iClk'event and iClk = '1' then

      if ClkCounter = cClkCycPerStrobeCyc-1 then
        ClkCounter <= (others => '0');
        oStrobe    <= cActivated;
      else
        ClkCounter <= ClkCounter+1;
        oStrobe    <= cInactivated;
      end if;

    end if;
  end process GenStrobe;

end architecture Rtl;
