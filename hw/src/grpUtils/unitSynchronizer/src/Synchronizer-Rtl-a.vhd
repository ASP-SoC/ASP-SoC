architecture Rtl of Synchronizer is

  signal Meta : std_logic_vector(gRange-1 downto 0);

begin

  Sync : process(iClk, inRstAsync)
  begin
    if inRstAsync = '0' then            -- low active async reset
      Meta  <= (others => '0');
      oSync <= (others => '0');
    elsif rising_edge(iClk) then        -- rising clk edge
      Meta  <= iAsync;                  -- 1st register
      oSync <= Meta;                    -- 2nd register
    end if;
  end process;

end;
