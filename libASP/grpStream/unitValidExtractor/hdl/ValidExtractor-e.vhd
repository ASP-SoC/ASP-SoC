-------------------------------------------------------------------------------
-- Title       : Channel Mux
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Unit Mux left and right channel
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ValidExtractor is
    port (
        asi_valid : in std_logic;
        aso_valid : out std_logic;
        val_strobe : out std_logic 
    );

end entity ValidExtractor;
