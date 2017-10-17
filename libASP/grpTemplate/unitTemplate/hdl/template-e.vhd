-------------------------------------------------------------------------------
-- Title       : Signal Delay Left and Right
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Unit delays left and right channel independent. Each channel's
--               delay can be configured separately.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Delay is

    generic (
        gMaxDelay    : natural :=   100;    -- [ms] maximum delay (until a value is shifted through)
        gNewDataFreq : natural := 48000;    -- [Hz] frequency, with which new data is stored in the SR
        gDataWidth   : natural :=    24     -- bitwidth of a single register
    );
    port (
        csi_clk          : in  std_logic;
        rsi_reset_n      : in  std_logic;

        -- Avalon MM Slave Port s0 - used for config parameters
        avs_s0_write     : in  std_logic;
        avs_s0_address   : in  std_logic_vector( 2 downto 0);
        avs_s0_writedata : in  std_logic_vector(31 downto 0);

        -- Avalon ST sink left and right channel
        asi_left_data   : in std_logic_vector(gDataWidth-1 downto 0);
        asi_left_valid  : in std_logic;
        asi_right_data  : in std_logic_vector(gDataWidth-1 downto 0);
        asi_right_valid : in std_logic;

        -- Avalon ST source left and right channel
        aso_left_data   : out std_logic_vector(gDataWidth-1 downto 0);
        aso_left_valid  : out std_logic;
        aso_right_data  : out std_logic_vector(gDataWidth-1 downto 0);
        aso_right_valid : out std_logic
    );

end entity Delay;
