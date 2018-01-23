-------------------------------------------------------------------------------
-- Title       : Finite Impulse Response Filter
-- Author      : Steiger Martin <martin.steiger@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Simple FIR filter structure for damping, amplifying and 
--				 compounding audio signals -> TESTING UNIT
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  --try to use this library as much as possible.
use IEEE.fixed_pkg.all;
use work.pkgFIR.all;
use work.Global.all;

entity tbFIR is
end entity;


architecture Bhv of tbFIR is

constant cNumberOfAddressLines : natural := 4;
constant cDataWidth : natural := 24;

signal DataClk : std_ulogic := '0';
signal FIRClk : std_ulogic := '0';
signal DataIn  : sfixed(-1 downto -24):= to_sfixed(0.0, -1, -24);
signal DataOut : real;

signal address : std_logic_vector(cNumberOfAddressLines-1 downto 0) := (others => '0');
signal avs_write : std_logic := cInactivated;
signal avs_writedata : std_logic_vector(31 downto 0) := (others => cInactivated);
signal avs_read : std_logic;
signal avs_readdata : std_logic_vector(31 downto 0);

signal asi_valid : std_logic := cInactivated;
signal asi_data : std_logic_vector(cDataWidth - 1 downto 0);
signal aso_valid : std_logic;
signal aso_data : std_logic_vector(cDataWidth - 1 downto 0);

signal reset : std_logic := cnInactivated;

subtype res_type is std_logic_vector (0 to asi_data'length-1);

begin

SineGen : entity work.sinewave(Behavioral)
port map(
	clk => DataClk,
	dataout => DataOut
);

DataIn <= to_sfixed(DataOut, 0, -23);
asi_data <= res_type(DataIn);

FIR : entity work.FIR(Rtl)
port map
(
 csi_clk => FIRClk,
 rsi_reset_n =>  reset, 

 avs_s0_address => address, 
 avs_s0_write => avs_write,
 avs_s0_writedata => avs_writedata,
 --avs_s0_read => avs_read, 
 avs_s0_readdata => avs_readdata,

 -- AudioSignals: streaming interface
 asi_valid => asi_valid,
 asi_data => asi_data,
 aso_valid => aso_valid,
 aso_data => aso_data
);

VALIDSTROBE: entity work.StrobeGen(Rtl)
generic map (gClkFrequency => 50E6,
	     gStrobeCycleTime => 21 us)
port map(
    iClk         			=> FIRClk,
    inResetAsync	=> reset,
    oStrobe      		=> asi_valid
);

--**********************************************
-- clock of the FIR => has to be way higher 
-- than input data clock
--**********************************************
FIRCLOCK : process(FIRClk)
begin

FIRClk <= not(FIRClk) after 20 ns; --Abtastfrequenz des Filters => verwendeter FPGA-Takt

end process;

--**********************************************
-- clock of the input signal 
--**********************************************
CLOCK : process(DataClk)
begin

DataClk <= not(DataClk) after 30 us; --Sinus-Gen: 30 Samples werden für volle Periode ausgegeben => clk/30 ergibt die Frequenz
end process;

Stimul : process is
begin

reset <= cnActivated after 1 us, cnInactivated after 10 us;

address <= "0000" after 100 us, "0001" after 200 us, "0010" after 300 us, "0011" after 400 us, "0100" after 500 us,
		   "0101" after 600 us, "0110" after 700 us, "0111" after 800 us, "1000" after 900 us, "1001" after 1000 us,
		   "1010" after 1100 us, "1011" after 1200 us, "1100" after 1300 us, "1101" after 1400 us, "1110" after 1500 us, 
		   "1111" after 1600 us, "0000" after 2000 us;

avs_writedata <= "00000000000000000000000000000000" after 2100 us, "00000000001100000010000000100001" after 2300 us; -- 000000000,01000000000000000000000 0,3759804964

avs_write <= cActivated after 90 us, cInactivated after 2500 us;

wait;

end process;

end architecture;
