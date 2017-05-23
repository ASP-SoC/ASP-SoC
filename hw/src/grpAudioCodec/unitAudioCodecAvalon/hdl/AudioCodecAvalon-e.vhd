library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AudioCodecAvalon is

  generic (
    gDataWidth : natural := 24);        -- Avalon ST DatawidthodecAvalon; 

  port (

    -- clk and reset
    csi_clk     : in std_logic;         -- clk
    rsi_reset_n : in std_logic;         -- low active reset

    -- audio codec interface
    AUD_ADCDAT  : in    std_logic;
    AUD_ADCLRCK : inout std_logic;
    AUD_BCLK    : inout std_logic;
    AUD_DACDAT  : out   std_logic;
    AUD_DACLRCK : inout std_logic;
    AUD_XCK     : out   std_logic;

    -- Avalon ST sink left and right channel
    asi_left_data  : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    asi_left_valid : in std_logic;                                -- valid

    asi_right_data  : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    asi_right_valid : in std_logic;                                -- valid

    -- Avalon ST source left and right channel
    aso_left_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    aso_left_valid : out std_logic;                                -- valid

    aso_right_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    aso_right_valid : out std_logic                                 -- valid

    );
end entity;
