-------------------------------------------------------------------------------
-- Title      : File Reader for Simulation
-------------------------------------------------------------------------------
-- File       : FileReader-Bhv-a.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: reads and outputs .txt files linewise testdata with iStrobe
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date       : Version   Author          Description
-- 2017-03-28 : 1.0       Michael Wurm    Created
-- 2017-04-18 : 1.1       Michael Wurm    added report if EOF, to end simulation
-------------------------------------------------------------------------------

architecture Bhv of FileReader is
 	
	signal Data    : signed(gDataWidth-1 downto 0);
	signal NxData  : signed(gDataWidth-1 downto 0);

	file inputFile : text open read_mode is gInputFileName;

begin

	oDataOut <= Data;
   
	Registers : process(inResetAsync, iClk) is
	begin
		if inResetAsync = '0' then
		  Data <= (others => '0');
		elsif rising_edge(iClk) then
		  Data <= NxData;
		end if;
	end process;

	-- reads new line from file, which is a new value
	CombReadFile : process(Data, iStrobe) is
		variable inputLine  : LINE;
		variable inputValue : integer;
	begin
		NxData <= Data;
		if iStrobe = cActivated then 
		   if(not endfile(inputFile)) then
			   readline(inputFile, inputLine);
			   read(inputLine, inputValue);
		   else
   		      report "EOF reached in input file"
			  severity failure;
		   end if;

		   NxData <= to_signed(inputValue, gDataWidth);
		end if;
	end process;
   
end architecture Bhv;
