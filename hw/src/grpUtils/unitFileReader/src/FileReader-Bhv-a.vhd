-------------------------------------------------------------------------------
-- Title      : File Reader for Simulation
-------------------------------------------------------------------------------
-- File       : FileReader-Bhv-a.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: reads .txt files with linewise testdata
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date       : Version   Author          Description
-- 2017-03-28 : 1.0       Michael Wurm    Created
-------------------------------------------------------------------------------

architecture Bhv of FileReader is
 	
	signal Data    : std_ulogic_vector(gDataWidth-1 downto 0);
	signal NxData  : std_ulogic_vector(gDataWidth-1 downto 0);

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
		   readline(inputFile, inputLine);
		   read(inputLine, inputValue);
		   NxData <= std_ulogic_vector(to_signed(inputValue,gDataWidth));
		end if;
	end process;
   
end architecture Bhv;
