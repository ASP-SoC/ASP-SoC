-------------------------------------------------------------------------------
-- Title       : Avalon Valid Extractor
-- Author      : David Haberleitner
-------------------------------------------------------------------------------
-- Description : Provide valid signal as avalon and also as conduit
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
