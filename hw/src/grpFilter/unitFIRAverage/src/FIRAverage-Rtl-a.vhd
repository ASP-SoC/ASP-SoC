-------------------------------------------------------------------------------
-- Title      : FIR Average
-------------------------------------------------------------------------------
-- File       : FIRAverage-Rtl-a.vhd
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

architecture Rtl of FIRAverage is
 
	signal sum : signed(iDataIn'range) := (others => '0');

	type aShiftReg is array (0 to gNumAverages) of signed(iDataIn'range);
	signal ShiftReg : aShiftReg := (others => (others => '0'));

begin

	doShiftReg : process (iClk, inResetAsync) is
	begin
		if inResetAsync = '0' then     -- asynchronous reset (active low)
			ShiftReg <= (others => (others => '0'));
		elsif rising_edge(iClk) then   -- rising clock edge
		  if iStrobe = '1' then
			ShiftReg(0) <= iDataIn;
			for i in 1 to gNumAverages loop
				ShiftReg(i) <= ShiftReg(i-1);
			end loop;
		  end if;
		end if;
	end process doShiftReg;
	
	Filter : process(ShiftReg, iStrobe) is
	begin
	  if iStrobe = '1' then
		for i in 0 to gNumAverages-1 loop
		  sum <= sum + signed(ShiftReg(0) - ShiftReg(gNumAverages));
		end loop;
	  end if;
	end process;
	
	oDataOut <= sum / gNumAverages;
	
end architecture Rtl;
