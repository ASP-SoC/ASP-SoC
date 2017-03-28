library ieee;
use ieee.std_logic_1164.all;

entity TbdAudio is
  port(

    -- Clock
    Clock_50    : in    std_logic;      -- 50 MHz Clk

    -- KEYs
    KEY        : in    std_logic_vector(3 downto 0);
    
    -- Audio
    AUD_ADCDAT  : in    std_logic;
    AUD_ADCLRCK : inout std_logic;
    AUD_BCLK    : inout std_logic;
    AUD_DACDAT  : out   std_logic;
    AUD_DACLRCK : inout std_logic;
    AUD_XCK     : out   std_logic;

    -- I2C for Audio and Video-In
    FPGA_I2C_SCLK : out   std_logic;
    FPGA_I2C_SDAT : inout std_logic;

    -- GPIO
    GPIO_1 : inout std_logic_vector(35 downto 0)

    );
end entity TbdAudio;
