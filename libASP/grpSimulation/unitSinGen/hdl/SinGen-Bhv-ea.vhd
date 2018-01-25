-------------------------------------------------------------------------------
-- Title      : Sine Generator, only for simulation
-------------------------------------------------------------------------------
-- File       : SinGen-Bhv-ea.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.Global.all;

entity SinGen is

  generic (
    periode_g     : time := 100 us;
    sample_time_g : time := 200 ns
    );

  port (
    clk_i        : in  std_ulogic;
    data_o       : out audio_data_t;
    data_valid_o : out std_ulogic
    );

end entity SinGen;


architecture Bhv of SinGen is

begin  -- architecture Bhv

  sin_gen : process is
  begin  -- process sin_gen
    data_valid_o <= '0';
    wait for sample_time_g;
    wait until rising_edge(clk_i);
    data_o       <= to_sfixed(0.999999999999 * sin(MATH_2_PI * real(now/sample_time_g)/real(periode_g/sample_time_g)),0, -(data_width_c-1));
    data_valid_o <= '1';
    wait until rising_edge(clk_i);
  end process sin_gen;

end architecture Bhv;
