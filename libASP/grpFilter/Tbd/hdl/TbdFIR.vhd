library ieee;
use ieee.std_logic_1164.all;

entity TbdFIR is
  port(

    -- Clock
    Clock_50 : in std_logic;

    -- KEYs
    KEY : in std_logic_vector(0 downto 0);

    -- Audio
    AUD_ADCDAT  : in  std_logic;
    AUD_ADCLRCK : in  std_logic;
    AUD_BCLK    : in  std_logic;
    AUD_DACDAT  : out std_logic;
    AUD_DACLRCK : in  std_logic;
    AUD_XCK     : out std_logic;

    -- I2C for Audio and Video-In
    FPGA_I2C_SCLK : out   std_logic;
    FPGA_I2C_SDAT : inout std_logic

    );
end entity TbdFIR;
