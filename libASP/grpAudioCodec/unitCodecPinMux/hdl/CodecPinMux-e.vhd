library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CodecPinMux is

  generic (
    gDataWidth    : natural := 24;      -- Avalon ST interface Datawidth
    gDataWidthLen : natural := 5        -- Number of bits to represent gDataWidth
    );

  port (
    -- clk and reset
    iClk    : in std_logic;             -- clk
    inReset : in std_logic;             -- low active reset

    -- Avalon MM Slave Port s0 - used for config parameters
    avs_s0_write     : in std_logic;
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- audio codec interface (from Codec)
    iADCDAT_CODEC  : in std_logic;
    iADCLRC_CODEC  : in std_logic;
    iBCLK_CODEC : in std_logic;
    iDACLRC_CODEC : in std_logic;
    oDACDAT_CODEC : out std_logic;

    -- audio codec interface (from GPIO)
    iADCDAT_GPIO  : in std_logic;
    iADCLRC_GPIO  : in std_logic;
    iBCLK_GPIO : in std_logic;
    iDACLRC_GPIO : in std_logic;
    oDACDAT_GPIO : out std_logic;

    -- audio codec interface output
    oADCDAT  : out std_logic;
    oADCLRC  : out std_logic;
    oBCLK : out std_logic;
    oDACLRC : out std_logic;
    iDACDAT : in std_logic

    );
end entity;
