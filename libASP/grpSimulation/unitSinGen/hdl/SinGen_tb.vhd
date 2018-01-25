-------------------------------------------------------------------------------
-- Title      : Testbench for design "SinGen"
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.Global.all;

-------------------------------------------------------------------------------

entity SinGen_tb is

end entity SinGen_tb;

-------------------------------------------------------------------------------

architecture Bhv of SinGen_tb is

  -- component generics
  constant periode_g     : time := 100 us;
  constant sample_time_g : time := 200 ns;

  -- component ports
  signal data_o       : audio_data_t;
  signal data_valid_o : std_ulogic;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.SinGen
    generic map (
      periode_g     => periode_g,
      sample_time_g => sample_time_g)
    port map (
      clk_i        => Clk,
      data_o       => data_o,
      data_valid_o => data_valid_o);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here

    wait;
  end process WaveGen_Proc;



end architecture Bhv;

-------------------------------------------------------------------------------
