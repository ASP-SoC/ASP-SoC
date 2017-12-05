-------------------------------------------------------------------------------
-- Title       : Signal Delay Left and Right
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Testing registers and function of unit
-------------------------------------------------------------------------------

entity tbDelay is
end entity tbDelay;

architecture bhv of tbDelay is
  ---------------------------------------------------------------------------
  -- Constants
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Signals
  ---------------------------------------------------------------------------

begin

  Delay_1 : entity work.Delay
    generic map (
      gMaxDelay  => gMaxDelay,
      gDataWidth => gDataWidth)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_address   => avs_s0_address,
      avs_s0_writedata => avs_s0_writedata,
      asi_data         => asi_data,
      asi_valid        => asi_valid,
      aso_data         => aso_data,
      aso_valid        => aso_valid);
  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------
  Clk <= not Clk after 10 ns;

  ---------------------------------------------------------------------------
  -- Instantiations
  ---------------------------------------------------------------------------

end architecture bhv;
