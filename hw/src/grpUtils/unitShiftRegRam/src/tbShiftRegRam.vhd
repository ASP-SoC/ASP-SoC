-------------------------------------------------------------------------------
-- Title      : Testbench for design "ShiftRegRam"
-------------------------------------------------------------------------------
-- File       : tbShiftReg.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author   Description
-- 2017-05-30  1.0      MikeW    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Global.all;

entity tbShiftRegRam is
end entity tbShiftRegRam;

architecture Bhv of tbShiftRegRam is

  -- component generics
  constant cMaxDelay       : natural :=     1;  -- ms
  constant cNewDataFreq    : natural := 48000;  -- Hz
  constant cWidth          : natural :=     8;  -- bit
  
  constant cDepth : natural := cMaxDelay*cNewDataFreq/1000;
  
  -- component ports
  signal nResetAsync  : std_ulogic;
  signal cfg_write    : std_ulogic;
  signal cfg_data     : std_logic_vector(cWidth-1 downto 0);
  signal inputData    : std_ulogic_vector(cWidth-1 downto 0);
  signal input_valid  : std_ulogic;
  signal outputData   : std_logic_vector(cWidth-1 downto 0);
  signal output_valid : std_ulogic;

  -- clock
  signal Clk : std_ulogic := '1';

begin

  -- component instantiation
  DUT : entity work.ShiftRegRam
    generic map (
		gMaxDelay     => cMaxDelay,
		gNewDataFreq  => cNewDataFreq,
		gWidth        => cWidth
	)
	port map (
		csi_clk              => Clk,
		rsi_reset_n          => nResetAsync,
		iActualLength        => to_unsigned(cDepth,32),
		audio_in_valid       => input_valid,
		iData                => std_logic_vector(inputData),
		audio_out_valid      => output_valid,
		oData                => outputData
	);

  -- generate 50 MHz clk
  Clk <= not Clk after 10 ns;

  -- waveform generation
  Stimul : process
  begin
    nResetAsync <= '0',
                   '1' after 10 ns;
	
	wait for 10 ns;
	
	for i in 0 to 2*cDepth loop -- shift twice as many values as the fifo is long
		inputData <= std_ulogic_vector(to_unsigned(i,inputData'length));
		input_valid <= '1';
		wait for 10 ns;
		input_valid <= '0';
		
		if i = 10 then
			wait for 50 ns;
		else
			wait for 10 ns;
		end if;

	end loop;
    wait;
  end process Stimul;

end architecture Bhv;
