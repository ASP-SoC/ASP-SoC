-------------------------------------------------------------------------------
-- Title       : Signal Delay Left and Right
-- Author      : David Haberleitner
-------------------------------------------------------------------------------
-- Description : Delays one channel dynamically by a value accessable via a
-- MemoryMapped interface using RAM-Blocks
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Delay is

  generic (
    gMaxDelay  : natural := 1024;  -- maximum delay n cycles (delay (in sec) = 1/fsamp * gMaxDelay)
    gDataWidth : natural := 24          -- bitwidth of a single register
    );
  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- Avalon MM Slave Port s0 - used for config parameters
    avs_s0_write     : in std_logic;
    avs_s0_address   : in std_logic_vector(2 downto 0);
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon ST sink
    asi_data  : in std_logic_vector(gDataWidth-1 downto 0);
    asi_valid : in std_logic;

    -- Avalon ST source
    aso_data  : out std_logic_vector(gDataWidth-1 downto 0);
    aso_valid : out std_logic
    );

end entity Delay;
