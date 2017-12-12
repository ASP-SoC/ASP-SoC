library ieee;
use ieee.std_logic_1164.all;

entity PlatformHps is
  port(

    -- Clock
    CLOCK_50 : in std_logic;

    -- LED
    LEDR : out std_logic_vector(9 downto 0);

    -- KEY
    KEY : in std_logic_vector(3 downto 0);

    -- Switches

    SW : in std_logic_vector(9 downto 0);

    --7SEG
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0);

    -- Audio
    AUD_ADCDAT  : in  std_logic;
    AUD_ADCLRCK : in  std_logic;
    AUD_BCLK    : in  std_logic;
    AUD_DACDAT  : out std_logic;
    AUD_DACLRCK : in  std_logic;
    AUD_XCK     : out std_logic;

    -- I2C for Audio and Video-In
    FPGA_I2C_SCLK : out   std_logic;
    FPGA_I2C_SDAT : inout std_logic;

    -- HPS
    HPS_DDR3_ADDR  : out std_logic_vector(14 downto 0);
    HPS_DDR3_BA    : out std_logic_vector(2 downto 0);
    HPS_DDR3_CK_P  : out std_logic;
    HPS_DDR3_CK_N  : out std_logic;
    HPS_DDR3_CKE   : out std_logic;
    HPS_DDR3_CS_N  : out std_logic;
    HPS_DDR3_RAS_N : out std_logic;
    HPS_DDR3_CAS_N : out std_logic;

    HPS_DDR3_WE_N    : out   std_logic;
    HPS_DDR3_RESET_N : out   std_logic;
    HPS_DDR3_DQ      : inout std_logic_vector(31 downto 0) := (others => 'X');
    HPS_DDR3_DQS_P   : inout std_logic_vector(3 downto 0)  := (others => 'X');
    HPS_DDR3_DQS_N   : inout std_logic_vector(3 downto 0)  := (others => 'X');
    HPS_DDR3_ODT     : out   std_logic;
    HPS_DDR3_DM      : out   std_logic_vector(3 downto 0);
    HPS_DDR3_RZQ     : in    std_logic                     := 'X';
    HPS_KEY          : inout std_logic;
    HPS_LED          : inout std_logic

    );
end entity PlatformHps;
