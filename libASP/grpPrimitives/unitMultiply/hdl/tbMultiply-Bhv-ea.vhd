-------------------------------------------------------------------------------
-- Title       : Multiply
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Unit Multiply multiplies L and R channel with a factor
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity tbMultiply is
end entity tbMultiply;

architecture bhv of tbMultiply is

  constant gDataWidth : natural := 4;

  signal csi_clk          : std_logic                     := '1';
  signal rsi_reset_n      : std_logic;
  signal avs_s0_write     : std_logic;
  signal avs_s0_address   : std_logic;
  signal avs_s0_writedata : std_logic_vector(31 downto 0) := (others => '0');
  signal asi_left_data    : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_left_valid   : std_logic;
  signal asi_right_data   : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_right_valid  : std_logic;
  signal aso_left_data    : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_left_valid   : std_logic;
  signal aso_right_data   : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_right_valid  : std_logic;

  -- test time
  constant test_time_c : time := 20 ns;

  
begin

  DUT : entity work.Multiply
    generic map (
      gDataWidth => gDataWidth)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_address   => avs_s0_address,
      avs_s0_writedata => avs_s0_writedata,
      asi_left_data    => asi_left_data,
      asi_left_valid   => asi_left_valid,
      asi_right_data   => asi_right_data,
      asi_right_valid  => asi_right_valid,
      aso_left_data    => aso_left_data,
      aso_left_valid   => aso_left_valid,
      aso_right_data   => aso_right_data,
      aso_right_valid  => aso_right_valid);

  -- clk generation
  csi_clk <= not csi_clk after 10 ns;

  test_process : process is
  begin  -- process
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 10 ns;

    wait for 20 ns;


    wait;

  end process;


end architecture bhv;
