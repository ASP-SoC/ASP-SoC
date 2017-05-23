-------------------------------------------------------------------------------
-- Title      : File Writer for Simulation
-------------------------------------------------------------------------------
-- File       : FileWriter-Bhv-a.vhd
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

architecture Bhv of FileWriter is
 	
	signal Data    : signed(gDataWidth-1 downto 0);
	signal NxData  : signed(gDataWidth-1 downto 0);

	file outputFile : text open write_mode is gOutputFileName;

begin
   
	Registers : process(inResetAsync, iClk) is
	begin
		if inResetAsync = '0' then
		  Data <= (others => '0');
		elsif rising_edge(iClk) then
		  Data <= iDataToWrite;
		end if;
	end process;

	-- writes new line to file
	CombWriteFile : process(Data, iStrobe) is
		variable outputLine  : LINE;
		variable outputValue : integer;
	begin
		if iStrobe = cActivated then 
		   write(outputLine, to_integer(Data));
		   writeline(outputFile, outputLine);
		end if;
	end process;
   
end architecture Bhv;
