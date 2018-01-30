-------------------------------------------------------------------------------
-- Title       : Avalon MM to Avalon ST
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Memory Mapped Slave to Avalon Streaming with Left and Right Channel
--               Used to stream audio data from the soc linux to the fpga
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MMtoST is

  generic (
    data_width_g : natural := 24;
    fifo_depth_g : natural := 128);

  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- memory mapped interface s0
    avs_s0_chipselect : in  std_logic;
    avs_s0_write      : in  std_logic;
    avs_s0_read       : in  std_logic;
    avs_s0_address    : in  std_logic_vector(1 downto 0);
    avs_s0_writedata  : in  std_logic_vector(31 downto 0);
    avs_s0_readdata   : out std_logic_vector(31 downto 0);



    -- avalon streaming
    asi_left_valid  : in std_logic;
    asi_left_data   : in std_logic_vector(data_width_g-1 downto 0);
    asi_right_valid : in std_logic;
    asi_right_data  : in std_logic_vector(data_width_g-1 downto 0);

    aso_left_valid  : out std_logic;
    aso_left_data   : out std_logic_vector(data_width_g-1 downto 0);
    aso_right_valid : out std_logic;
    aso_right_data  : out std_logic_vector(data_width_g-1 downto 0)
    );

end entity MMtoST;
