library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.fixed_pkg.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.pkgFIR.all;

entity FIR is

generic 
(
gDataWidth : natural := 24;
gNrAddressLines : natural := 4
);

port 
(
 -- avalon mm signals
 csi_clk : in std_logic;
 rsi_reset_n : in std_logic;

 avs_s0_address : in std_logic_vector(gNrAddressLines-1 downto 0);
 avs_s0_write : in std_logic;
 avs_s0_writedata : in std_logic_vector(31 downto 0);
 avs_s0_read : in std_logic;
 avs_s0_readdata : out std_logic_vector(31 downto 0);

 -- AudioSignals: streaming interface
 asi_valid : in std_logic;
 asi_data : in std_logic_vector(gDataWidth - 1 downto 0);
 aso_valid : out std_logic;
 aso_data : out std_logic_vector(gDataWidth - 1 downto 0)
 );

 begin

 assert (gDataWidth = 24)
 report "ERROR: DataWidth is out of range!"
 severity error;

end entity FIR;


architecture Struct of FIR is

type aStage is array(0 to cOrder - 1) of sfixed(-1 downto -gDataWidth); -- register array for input values

--signal defines
signal Coeff    : CoeffArray := (others => to_sfixed(0.0, -1, -gDataWidth)); 	--coeffs for internal FIR calculation
signal NxCoeff  : CoeffArray := (others => to_sfixed(0.0, -1, -gDataWidth)); 	--coeffs for internal FIR calculation
signal Out_Data : sfixed(-1 downto -24) := to_sfixed(0.0, -1, -gDataWidth);
signal Stages   : aStage := (others => to_sfixed(0.0, -1, -gDataWidth));


begin
--**********************************************************
-- Load coefficients of the FIR with Avalon MM Master
--**********************************************************
WriteCoeffs: process(avs_s0_address, avs_s0_write, avs_s0_writedata, Coeff)
begin
NxCoeff <= Coeff;
if(avs_s0_write = cActivated) then
	if(to_integer(unsigned(avs_s0_address)) < cOrder) then
		NxCoeff(to_integer(unsigned(avs_s0_address))) <= to_sfixed(avs_s0_writedata(gDataWidth - 1 downto 0), -1, -gDataWidth);
	end if;
end if;
end process;

RegisterProc : process(csi_clk)
begin
if(rsi_reset_n = cnActivated)then
	Coeff <= (others => to_sfixed(0.0, -1, -gDataWidth));
elsif(rising_edge(csi_clk)) then
	Coeff <= NxCoeff;
end if;
end process;

--**********************************************************
-- Store last N input data and shift after every clock cycle
--**********************************************************
S: process(csi_clk, rsi_reset_n)
begin
if(rsi_reset_n = cnActivated) then
	Stages <= (others => to_sfixed(0.0, -1, -gDataWidth));
	
elsif rising_edge(csi_clk) then
	for i in cOrder - 1 downto 1 loop
		Stages(i) <= Stages(i-1);-- shifting input data
	end loop;
	Stages(0)<= to_sfixed(asi_data, -1, -gDataWidth); -- loading input data
end if;
end process S;

--**********************************************************
-- multiply and add the input register with the coefficients
--**********************************************************
MAC: process(csi_clk, asi_valid, Stages)

variable temp_b : sfixed(-1 downto -gDataWidth) := to_sfixed(0.0, -1, -gDataWidth);
variable sig_b  : sfixed(-1 downto -gDataWidth) := to_sfixed(0.0, -1, -gDataWidth);

variable tmp : sfixed(-1 downto -2*gDataWidth) := to_sfixed(0.0, -1, -2*gDataWidth);

begin

if rising_edge(csi_clk) then 

	if asi_valid = cActivated then
	
	sig_b := to_sfixed(0.0, -1, -gDataWidth);
	
	for i in 0 to cOrder - 1 loop
		-- Multiplication and accumulation
		tmp := Coeff(i) * Stages(i);
		--temp_b:= resize(Coeff(i) * Stages(i), temp_b);
		temp_b:= tmp(-1 downto -gDataWidth);
		sig_b := resize(sig_b + temp_b, sig_b); -- implicite sign extension

	end loop;
	
	Out_Data <= sig_b;
	
	aso_valid <= cActivated;
	
	else

	aso_valid <= cInactivated;
	
	end if;

	
end if;
end process MAC;

aso_data <= to_slv(Out_Data);

end architecture;