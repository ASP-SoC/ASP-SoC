-------------------------------------------------------------------------------
-- Title       : Finite Impulse Response Filter
-- Author      : Steiger Martin <martin.steiger@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Simple FIR filter structure for damping, amplifying and 
--				 compounding audio signals
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.pkgFIR.all;

entity FIR is

generic 
(
gDataWidth 		: natural := 24;					-- bit width of audio data
gNrAddressLines : natural := 4;  					-- address lines necessary for filter coefficient addressing
gNumberOfCoeffs : natural := 16	-- number of available coefficients
);

port 
(
 ----------------------------------------------------
 -- 			avalon mm signals                  --
 ----------------------------------------------------
 csi_clk 			: in  std_logic;										-- AVALON clock
 rsi_reset_n 		: in  std_logic;										-- coefficient and data reset
 avs_s0_address 	: in  std_logic_vector(gNrAddressLines-1 downto 0);		-- coefficient address
 avs_s0_write 		: in  std_logic;										-- write enable
 avs_s0_writedata 	: in  std_logic_vector(31 downto 0);					-- coefficient to be written
 --avs_s0_read 		: in  std_logic;										-- read enable
 avs_s0_readdata 	: out std_logic_vector(31 downto 0);					-- read coefficient

 ----------------------------------------------------
 --             streaming interface                --
 ----------------------------------------------------
 asi_valid 			: in  std_logic;										-- input signal valid
 asi_data 			: in  std_logic_vector(gDataWidth - 1 downto 0);		-- input audio signal
 aso_valid 			: out std_logic;										-- output data valid
 aso_data 			: out std_logic_vector(gDataWidth - 1 downto 0)			-- output audio signal
 );

 begin

 assert (gDataWidth = 24)
 report "ERROR: DataWidth is out of range!"
 severity failure;
 
 --assert(gNumberOfCoeffs <= cOrder)
 --report "ERROR: larger number of coefficients than cOrder (pkgFIR.vhd) is not recommended"
 --severity failure;
 
 --assert(gNumberOfCoeffs <= 2**gNrAddressLines)
 --report("ERROR: not eough address lines to reach every coefficient")
--severity failure;

end entity FIR;
