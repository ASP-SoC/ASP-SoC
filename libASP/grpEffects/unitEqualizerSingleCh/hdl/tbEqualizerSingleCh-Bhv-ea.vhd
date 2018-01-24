-------------------------------------------------------------------------------
-- Title       : Testbench Equalizer Single Channel
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbEqualizerSingleCh is
end entity tbEqualizerSingleCh;

architecture bhv of tbEqualizerSingleCh is
  ---------------------------------------------------------------------------
  -- Constants
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Signals
  ---------------------------------------------------------------------------
  signal Clk : std_ulogic := '0';

begin

    ---------------------------------------------------------------------------
    -- Signal assignments
    ---------------------------------------------------------------------------
    Clk <= not Clk after 10 ns;

    ---------------------------------------------------------------------------
    -- Instantiations
    ---------------------------------------------------------------------------

end architecture bhv;
