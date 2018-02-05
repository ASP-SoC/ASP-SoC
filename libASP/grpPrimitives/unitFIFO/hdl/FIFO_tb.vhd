-------------------------------------------------------------------------------
-- Title       : FIFO - testbench
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : FIFO - memory with overflow  overwrite bhv
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity FIFO_tb is

end entity FIFO_tb;

-------------------------------------------------------------------------------

architecture Bhv of FIFO_tb is

  -- component generics
  constant data_width_g : natural := 4;
  constant depth_g      : natural := 8;
  constant adr_width_g  : natural := 3;

  -- component ports
  signal rst_i     : std_ulogic;
  signal wr_i      : std_ulogic;
  signal rd_i      : std_ulogic;
  signal wr_data_i : std_ulogic_vector(data_width_g-1 downto 0);
  signal rd_data_o : std_ulogic_vector(data_width_g-1 downto 0);
  signal space_o   : unsigned(adr_width_g-1 downto 0);
  signal empty_o   : std_ulogic;
  signal full_o    : std_ulogic;
  signal clear_i   : std_ulogic;

  -- clock
  signal Clk : std_ulogic := '1';

begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.FIFO
    generic map (
      data_width_g => data_width_g,
      depth_g      => depth_g,
      adr_width_g  => adr_width_g)
    port map (
      clk_i     => Clk,
      rst_i     => rst_i,
      wr_i      => wr_i,
      rd_i      => rd_i,
      wr_data_i => wr_data_i,
      rd_data_o => rd_data_o,
      clear_i   => clear_i,
      empty_o   => empty_o,
      full_o    => full_o,
      space_o   => space_o);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin

    rst_i <= '0' after 0 ns,
             '1' after 40 ns;

    clear_i <= '0' after 0 ns,
               '1' after 200 ns;

    wr_i      <= '0';
    rd_i      <= '0';
    wr_data_i <= "0000";
    wait for 100 ns;

    wait until rising_edge(Clk);
    wr_data_i <= "0001";
    wr_i      <= '1';
    wait until rising_edge(Clk);
    wr_i      <= '0';
    wr_data_i <= "----";

    wait for 100 ns;
    wait until rising_edge(Clk);
    rd_i <= '1';
    wait until rising_edge(Clk);
    rd_i <= '0';

    wait;
  end process WaveGen_Proc;



end architecture Bhv;

-------------------------------------------------------------------------------
