-------------------------------------------------------------------------------
-- Title       : Testbench Equalizer
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
--               Handles two channels, left and right.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbEqualizer is
end entity tbEqualizer;

architecture bhv of tbEqualizer is
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
