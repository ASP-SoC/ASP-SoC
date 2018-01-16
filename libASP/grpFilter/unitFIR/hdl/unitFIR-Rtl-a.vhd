-------------------------------------------------------------------------------
-- Title       : Finite Impulse Response Filter
-- Author      : Steiger Martin <martin.steiger@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Simple FIR filter structure for damping, amplifying and 
--				 compounding audio signals
-------------------------------------------------------------------------------

architecture Rtl of FIR is

constant sfixed_high : integer := 0;
constant sfixed_low  : integer := -(gDataWidth-1);
constant sfixed_no_ovf : integer := -(gDataWidth/2 -1);

type CoeffArray is array (gNumberOfCoeffs - 1 downto 0) of sfixed(sfixed_high downto sfixed_low);
type aStage is array(gNumberOfCoeffs - 1 downto 0) of sfixed(sfixed_high downto sfixed_low); -- register array for input values

signal Coeff    : CoeffArray := (Coeff'high => to_sfixed(0.5, sfixed_high, sfixed_low), others => to_sfixed(0.0, sfixed_high, sfixed_low)); 	--coeffs for internal FIR calculation

-- *************************
-- FSM STATE DEFINES
-- *************************
type aFilterState is (IDLE, MULT);

-- *************************
-- RECORDS
-- *************************
type filt_record is record
	FiltData : sfixed(sfixed_high downto sfixed_low);	-- filtered data
	StageCnt : integer range 0 to gNumberOfCoeffs;		-- stage index
	CoeffCnt : integer range 0 to gNumberOfCoeffs;		-- coeff index
	State	 : aFilterState;							-- FSM state
	Stages   : aStage;
	valid	 : std_ulogic;								-- valid signal if filtering for current input value is finished
	WriteIndex : integer range 0 to gNumberOfCoeffs;	-- write index for stage ring buffer
	ReadIndex : integer range 0 to gNumberOfCoeffs;		-- read index for stage ring buffer
	NumOfReads : integer;								-- check signal for number of reads from stages and coeffs
	LastFiltered : sfixed(sfixed_high downto sfixed_low);	-- filtered value from last iteration (if input valid signal doesn't appear)
end record;

-- *************************
-- DEFAULT RECORD VALUES
-- *************************
constant filt_def_config : filt_record := (
	to_sfixed(0.0, sfixed_high, sfixed_low),
	0,
	0,
	IDLE,
	(others => to_sfixed(0.0, sfixed_high, sfixed_low)),
	cInactivated,
	0,
	1,
	0,
	to_sfixed(0.0, sfixed_high, sfixed_low)
);

signal R, NxR : filt_record;

subtype result_type is std_logic_vector (gDataWidth-1 downto 0); -- for casting sfixed to std_logic_vector

-- ***************************
-- RAMSTYLE OPTIONS
-- ***************************
attribute ramstyle : string;
attribute ramstyle of Coeff : signal is "MLAB";	 -- implemented as synchronous RAM
--attribute ramstyle of Stages : signal is "MLAB"; -- implemented as ringbuffer

begin

-- ******************************************************************************
-- READ FROM AND WRITE INTO COEFFICIENT RAM AREA
-- ******************************************************************************
RAMReadWrite: process(csi_clk)
begin
	if (rising_edge(csi_clk)) then
		--if(avs_s0_write = cActivated) then
			if(unsigned(avs_s0_address)) < gNumberOfCoeffs then -- write into RAM
				Coeff(to_integer(unsigned(avs_s0_address))) <= to_sfixed(avs_s0_writedata(gDataWidth - 1 downto 0), sfixed_high, sfixed_low);
			end if;
		--end if;
		
		--if(to_integer(unsigned(avs_s0_address)) < gNumberOfCoeffs) then
			avs_s0_readdata(gDataWidth-1 downto 0) <= result_type(Coeff(to_integer(unsigned(avs_s0_address))));
			avs_s0_readdata(avs_s0_readdata'high downto gDataWidth) <= (others => cInactivated);
			--avs_s0_readdata(avs_s0_readdata'high downto gDataWidth) <= (others => cInactivated);
		--end if;
	end if;
end process;

-- ******************************************************************************
-- REGISTER PROCESS FOR FILTER
-- ******************************************************************************
REG: process(csi_clk, rsi_reset_n)
begin
if (rsi_reset_n = cnActivated) then 
	R <= filt_def_config;
elsif (rising_edge(csi_clk)) then 
	R <= NxR;
end if;
end process;

-- ******************************************************************************
-- COMBINATORICAL PROCESS: FOR MULTIPLICATION AND STORING WITHIN THE STAGES
-- ******************************************************************************
COMB: process(R, asi_valid, asi_data, Coeff)

-- TEMPORARY VARIABLES, NO STORING FUNCTION
variable tmp : sfixed(sfixed_high downto sfixed_low);
variable tmp_b : sfixed(sfixed_high downto sfixed_low);
variable tmp_stages : sfixed(sfixed_high downto sfixed_no_ovf);
variable tmp_coeffs : sfixed(sfixed_high downto sfixed_no_ovf);
begin

	-- default assignments
	NxR <= R;
	tmp := to_sfixed(0.0, sfixed_high, sfixed_low);
	tmp_b := to_sfixed(0.0, sfixed_high, sfixed_low);
	tmp_stages := to_sfixed(0.0, sfixed_high, sfixed_no_ovf);
	tmp_coeffs := to_sfixed(0.0, sfixed_high, sfixed_no_ovf);
	
	case(R.State) is 
	
	when 	IDLE 	=> 		-- wait until input data is valid
		if asi_valid = cActivated then 
			NxR.FiltData <= to_sfixed(0.0, sfixed_high, sfixed_low);	 -- reset tmp filter data
			NxR.State	<= MULT;										 -- set next stage
			NxR.StageCnt <= R.ReadIndex;
		end if;
		NxR.valid <= cInactivated;
		NxR.NumOfReads <= 0;
	when 	MULT 	=>		-- multiply stages and coefficients
	
			NxR.valid <= cInactivated;
			NxR.Stages(R.WriteIndex) <= to_sfixed(asi_data, sfixed_high, sfixed_low); 		-- write new data into stages
	
			if (R.CoeffCnt < gNumberOfCoeffs and R.StageCnt < gNumberOfCoeffs) then  --multiply (ATTENTION: size <= 32 Bit)
				tmp_stages := resize(R.Stages(R.CoeffCnt), tmp_stages);
				tmp_coeffs := resize(Coeff(R.CoeffCnt), tmp_coeffs);
				tmp := resize((tmp_stages * tmp_coeffs), tmp);
				tmp_b := resize(tmp + resize(R.FiltData, tmp), tmp_b);
				NxR.FiltData <= resize(tmp_b, NxR.FiltData);
				NxR.CoeffCnt <= R.CoeffCnt + 1;
				NxR.StageCnt <= R.StageCnt + 1;
				NxR.NumOfReads <= R.NumOfReads + 1;
			end if;
			
			
			if (R.CoeffCnt >= gNumberOfCoeffs-1) then -- coefficients finished
				NxR.CoeffCnt <= 0;
			end if;
			
			if (R.StageCnt >= gNumberOfCoeffs-1 and R.NumOfReads < gNumberOfCoeffs) then -- restart (ringbuffer read not finished)
				NxR.StageCnt <= 0;
			end if;
		
			if (R.NumOfReads >= gNumberOfCoeffs-1) then -- stages finished
				NxR.StageCnt <= 0;
				
				if(R.WriteIndex >= gNumberOfCoeffs-1) then 
					NxR.WriteIndex <= 0;
				else 
					NxR.WriteIndex <= R.WriteIndex + 1;
				end if;
				
				if(R.ReadIndex >= gNumberOfCoeffs-1) then 
					NxR.ReadIndex <= 0;
				else 
					NxR.ReadIndex <= R.ReadIndex + 1;
				end if;
				
				NxR.valid <= cActivated;
				NxR.State <= IDLE;
				
				NxR.LastFiltered <= R.FiltData;
				
			end if;
			
	when 	others 	=> NxR.State <= IDLE;
	end case;
end process;

aso_valid <= R.valid;
aso_data  <= to_slv(R.FiltData) when R.valid = cActivated else to_slv(R.LastFiltered);

end architecture Rtl;