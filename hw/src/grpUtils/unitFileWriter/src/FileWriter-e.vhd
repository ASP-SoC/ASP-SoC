-------------------------------------------------------------------------------
-- Title      : File Writer for Simulation
-------------------------------------------------------------------------------
-- File       : FileWriter-e.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: writes input signal to .txt file with iStrobe;
--              data written linewise
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date       : Version   Author          Description
-- 2017-04-25 : 1.0       Michael Wurm    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Global.all;
use std.textio.all;

entity FileWriter is
   generic (
		gDataWidth     : natural := 8;
		gOutputFileName : string
   );
   port ( iClk         : in std_ulogic;
	      inResetAsync : in std_ulogic;
	      iStrobe      : in std_ulogic;
          iDataToWrite : in signed(gDataWidth-1 downto 0)
		);
end FileWriter;
