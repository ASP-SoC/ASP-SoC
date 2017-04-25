-------------------------------------------------------------------------------
-- Title      : File Reader for Simulation
-------------------------------------------------------------------------------
-- File       : FileReader-e.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: reads and outputs .txt files linewise testdata with iStrobe
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
use work.Global.all;
use std.textio.all;

entity FileReader is
   generic (
		gDataWidth     : natural := 8;
		gInputFileName : string
   );
   port ( iClk         : in  std_ulogic;
	      inResetAsync : in  std_ulogic;
	      iStrobe      : in  std_ulogic;
          oDataOut     : out signed(gDataWidth-1 downto 0)
		);
end FileReader;
