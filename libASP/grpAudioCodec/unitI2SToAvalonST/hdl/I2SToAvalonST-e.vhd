library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity I2SToAvalonST is

  generic (
    gDataWidth    : natural := 24;      -- Avalon ST interface Datawidth
    gDataWidthLen : natural := 5    -- Number of bits to represent gDataWidth
    );

  port (
    -- clk and reset
    iClk    : in std_logic;             -- clk
    inReset : in std_logic;             -- low active reset

    -- audio codec interface
    iDAT  : in std_logic;
    iLRC  : in std_logic;
    iBCLK : in std_logic;

    -- Avalon ST source left and right channel
    oLeftData  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    oLeftValid : out std_logic;                                -- valid

    oRightData  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    oRightValid : out std_logic                                 -- valid

    );
end entity;
