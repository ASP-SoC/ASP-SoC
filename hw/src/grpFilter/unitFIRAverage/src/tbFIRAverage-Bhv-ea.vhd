-------------------------------------------------------------------------------
-- Title      : Testbench FIR Average for Simulation
-------------------------------------------------------------------------------
-- File       : tbFIRAverage-Bhv-ea.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: reads .txt files with linewise testdata 
--              and applies FIR Average Filter
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

use std.textio.all;

entity tbFIRAverage is
end tbFIRAverage;

architecture Bhv of tbFIRAverage is

	constant cDataWidth   : natural := 16;
	constant cNumAverages : natural := 50;

	signal Clk          : std_ulogic := '0';
	signal Strobe       : std_ulogic := '0';
	signal nReset       : std_ulogic := '0';
	signal DataRead     : signed(cDataWidth-1 downto 0);
	signal DataFiltered : signed(cDataWidth-1 downto 0) := (others=>'0');

begin
   
	Clk <= not Clk after 10 ns; -- generate 50 MHz clk
	nReset <= '0' after  0 ns,
	          '1' after 50 ns;

 	Filter : entity work.FIRAverage
	generic map (
		 gNumAverages => cNumAverages,
		 gDataWidth   => cDataWidth
		)
	port map ( 
		iClk         => Clk,
		inResetAsync => nReset,
		iStrobe      => Strobe,
		iDataIn      => DataRead,
		oDataOut     => DataFiltered
		);
	
	ReadFile : entity work.FileReader
	generic map (
			gDataWidth     => cDataWidth,
			gInputFileName => "testfiles/testinput_sin.txt"
		)
	port map (
			iClk         => Clk,
			inResetAsync => nReset,
			iStrobe      => Strobe,
			oDataOut     => DataRead
		);
		
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
			  
end architecture Bhv;
