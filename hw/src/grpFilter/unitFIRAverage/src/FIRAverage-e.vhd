-------------------------------------------------------------------------------
-- Title      : FIR Average
-------------------------------------------------------------------------------
-- File       : FIRAverage-e.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: FIR Average Filter
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date       : Version   Author          Description
-- 2017-03-28 : 1.0       Michael Wurm    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIRAverage is
   generic (
     gNumAverages : natural := 100;
     gDataWidth   : natural := 8
   );
   port ( iClk         : in  std_ulogic;
	      inResetAsync : in  std_ulogic;
	      iStrobe      : in  std_ulogic;
          iDataIn      : in  signed(gDataWidth-1 downto 0);
          oDataOut     : out signed(gDataWidth-1 downto 0)
		);
end FIRAverage;