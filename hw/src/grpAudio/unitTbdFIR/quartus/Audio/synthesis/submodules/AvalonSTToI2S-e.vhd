library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AvalonSTToI2S is

  generic (
    gDataWidth    : natural := 24;      -- Avalon ST interface Datawidth
    gDataWidthLen : natural := 5    -- Number of bits to represent gDataWidth
    );

  port (
    -- clk and reset
    iClk    : in std_logic;             -- clk
    inReset : in std_logic;             -- low active reset

    -- audio codec interface
    iLRC  : in  std_logic;
    iBCLK : in  std_logic;
    oDAT  : out std_logic;

    -- Avalon ST sink left and right channel
    iLeftData  : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    iLeftValid : in std_logic;                                -- valid

    iRightData  : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    iRightValid : in std_logic                                 -- valid

    );
end entity AvalonSTToI2S;
