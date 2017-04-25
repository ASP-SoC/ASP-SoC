-------------------------------------------------------------------------------
-- Title      : File Reader for Simulation, Testbench
-------------------------------------------------------------------------------
-- File       : tbFileReader-Bhv-ea.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: reads .txt files with linewise testdata, example how to use it
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

entity tbFileReader is
end tbFileReader;

architecture Bhv of tbFileReader is

	constant cDataWidth : natural := 24;

	signal Clk      : std_ulogic := '0';
	signal Strobe   : std_ulogic := '0';
	signal nReset   : std_ulogic := '0';
	signal DataRead : signed(cDataWidth-1 downto 0);

begin

	Clk <= not Clk after 10 ns; -- generate 50 MHz clk
	nReset <= '0' after  0 ns,
	          '1' after 50 ns;

	StrobeGen : entity work.StrobeGen 
	generic map (
		gClkFrequency    => 50E6,
		gStrobeCycleTime => 50 ns -- generate 20 MHz read frequency
	)
	port map (
		iClk         => Clk,
		inResetAsync => nReset,
		oStrobe      => Strobe
	);
	
	ReadFile : entity work.FileReader
		generic map (
			gDataWidth     => cDataWidth,
			gInputFileName => "testfiles/input102.txt"
		)
		port map (
			iClk         => Clk,
			inResetAsync => nReset,
			iStrobe      => Strobe,
			oDataOut     => DataRead
		);
			  
end architecture Bhv;
