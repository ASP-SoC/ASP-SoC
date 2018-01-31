-------------------------------------------------------------------------------
-- Title       : Avalon MM to Avalon ST Testbench
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Memory Mapped Slave to Avalon Streaming with Left and Right Channel
--               Used to stream audio data from the soc linux t the fpga
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity MMtoST_tb is

end entity MMtoST_tb;

-------------------------------------------------------------------------------

architecture Bhv of MMtoST_tb is

  -- component generics
  constant data_width_g     : natural := 24;
  constant fifo_depth_g     : natural := 128;
  constant fifo_adr_width_g : natural := 8;

  -- component ports
  signal csi_clk           : std_logic;
  signal rsi_reset_n       : std_logic;
  signal avs_s0_chipselect : std_logic;
  signal avs_s0_write      : std_logic;
  signal avs_s0_read       : std_logic;
  signal avs_s0_address    : std_logic_vector(1 downto 0);
  signal avs_s0_writedata  : std_logic_vector(31 downto 0);
  signal avs_s0_readdata   : std_logic_vector(31 downto 0);
  signal irs_irq           : std_logic;
  signal asi_left_valid    : std_logic;
  signal asi_left_data     : std_logic_vector(data_width_g-1 downto 0);
  signal asi_right_valid   : std_logic;
  signal asi_right_data    : std_logic_vector(data_width_g-1 downto 0);
  signal aso_left_valid    : std_logic;
  signal aso_left_data     : std_logic_vector(data_width_g-1 downto 0);
  signal aso_right_valid   : std_logic;
  signal aso_right_data    : std_logic_vector(data_width_g-1 downto 0);

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture Bhv

  -- component instantiation
  DUT: entity work.MMtoST
    generic map (
      data_width_g     => data_width_g,
      fifo_depth_g     => fifo_depth_g,
      fifo_adr_width_g => fifo_adr_width_g)
    port map (
      csi_clk           => csi_clk,
      rsi_reset_n       => rsi_reset_n,
      avs_s0_chipselect => avs_s0_chipselect,
      avs_s0_write      => avs_s0_write,
      avs_s0_read       => avs_s0_read,
      avs_s0_address    => avs_s0_address,
      avs_s0_writedata  => avs_s0_writedata,
      avs_s0_readdata   => avs_s0_readdata,
      irs_irq           => irs_irq,
      asi_left_valid    => asi_left_valid,
      asi_left_data     => asi_left_data,
      asi_right_valid   => asi_right_valid,
      asi_right_data    => asi_right_data,
      aso_left_valid    => aso_left_valid,
      aso_left_data     => aso_left_data,
      aso_right_valid   => aso_right_valid,
      aso_right_data    => aso_right_data);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture Bhv;

-------------------------------------------------------------------------------
