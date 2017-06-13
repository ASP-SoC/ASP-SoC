-------------------------------------------------------------------------------
-- Title      : Shift Register using RAM
-------------------------------------------------------------------------------
-- File       : ShiftRegRam-e.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: Shift Register that uses RAM as memory
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author    Description
-- 2017-05-30  1.0      MikeW     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Global.all;

entity ShiftRegRam is

  generic (
    gMaxDelay    : natural :=   100;    -- [ms] maximum delay (until a value is shifted through)
    gNewDataFreq : natural := 48000;    -- [Hz] frequency, with which new data is stored in the SR
    gWidth       : natural :=    24     -- bitwidth of a single register
	);

  port (
    csi_clk          : in  std_logic;   -- clk
    rsi_reset_n      : in  std_logic;   -- async low active reset
	
	iActualLength   : in unsigned(31 downto 0);
	
	-- Avalon ST Interface (for ShiftReg)
	iData           : in  std_logic_vector(gWidth-1 downto 0);  -- input data
    audio_in_valid  : in  std_logic;                             -- input data valid (set for 1 clk cycle)
	oData           : out std_logic_vector(gWidth-1 downto 0);   -- output data
	audio_out_valid : out std_logic                             -- output data valid (set for 1 clk cycle)
);  

begin

	assert gMaxDelay > 0 and gMaxDelay <= 100
		report "ShiftRegRam: delay time must be in range of 1-100 ms!"
		severity failure;
	
end entity ShiftRegRam;
