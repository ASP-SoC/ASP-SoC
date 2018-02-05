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

type aCoeffArray is array (gMaxNumCoeffs - 1 downto 0) of sfixed(sfixed_high downto sfixed_low);

subtype aStageAddr is integer range 0 to gMaxNumCoeffs -1;

type aStage is array(0 to gMaxNumCoeffs -1) of sfixed(sfixed_high downto sfixed_low); -- register array for input values


-- *************************
-- FSM STATE DEFINES
-- *************************
type aFilterState is (IDLE, MULT);

-- *************************
-- RECORDS
-- *************************
type filt_record is record
	FiltData : sfixed(sfixed_high downto sfixed_low);	-- filtered data
	MovSample : sfixed(sfixed_high downto sfixed_low);
	StageCnt : integer range 0 to gMaxNumCoeffs;		-- stage index
	CoeffCnt : integer range 0 to gMaxNumCoeffs;		-- coeff index
	State	 : aFilterState;							-- FSM state
    valid	 : std_ulogic;								-- valid signal if filtering for current input value is finished
	WriteIndex : integer range 0 to gMaxNumCoeffs;	-- write index for stage ring buffer
	ReadIndex : integer range 0 to gMaxNumCoeffs;		-- read index for stage ring buffer
	NumOfReads : integer;								-- check signal for number of reads from stages and coeffs
	FiltOut : sfixed(sfixed_high downto sfixed_low);	-- filter output data
end record;

-- *************************
-- DEFAULT RECORD VALUES
-- *************************
constant filt_def_config : filt_record := (
	to_sfixed(0.0, sfixed_high, sfixed_low),
	to_sfixed(0.0, sfixed_high, sfixed_low),
	0,
	0,
	IDLE,
	--(others => to_sfixed(0.0, sfixed_high, sfixed_low)),
	cInactivated,
	0,
	1,
	0,
	to_sfixed(0.0, sfixed_high, sfixed_low)
);


-- create the ram memory for the coefficients and the stages (the delayed values z^-1)
signal Coeff		: aCoeffArray;
signal Stages	: aStage ;

-- create the structures for the FSM
signal R, NxR : filt_record;

subtype result_type is std_logic_vector (gDataWidth-1 downto 0); -- for casting sfixed to std_logic_vector

begin

-- ******************************************************************************
-- READ FROM AND WRITE INTO COEFFICIENT RAM AREA
-- ******************************************************************************
RAMReadWrite: process(csi_clk)
begin
	if (rising_edge(csi_clk)) then
		if(avs_s0_write = cActivated) then
			if(unsigned(avs_s0_address)) < gMaxNumCoeffs then -- write into RAM
				Coeff(to_integer(unsigned(avs_s0_address))) <= to_sfixed(avs_s0_writedata(gDataWidth - 1 downto 0), sfixed_high, sfixed_low);
			end if;
		end if;

		avs_s0_readdata(gDataWidth-1 downto 0) <= result_type(Coeff(to_integer(unsigned(avs_s0_address))));
			
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
variable tmp_stages : sfixed(sfixed_high downto sfixed_low);
variable tmp_coeffs : sfixed(sfixed_high downto sfixed_low);
begin

	-- default assignments
	NxR <= R;
	tmp := to_sfixed(0.0, sfixed_high, sfixed_low);
	tmp_b := to_sfixed(0.0, sfixed_high, sfixed_low);
	tmp_stages := to_sfixed(0.0, sfixed_high, sfixed_low);
	tmp_coeffs := to_sfixed(0.0, sfixed_high, sfixed_low);
	
	case(R.State) is 
	
	when 	IDLE 	=> 		-- wait until input data is valid
		if asi_valid = cActivated then 
			NxR.FiltOut <= R.FiltData;
			NxR.FiltData <= to_sfixed(0.0, sfixed_high, sfixed_low);	 -- reset tmp filter data
			NxR.MovSample <= to_sfixed(asi_data, sfixed_high, sfixed_low);
			NxR.State	<= MULT;										 -- set next stage
			
			NxR.StageCnt <= R.ReadIndex;
			NxR.NumOfReads <= 0;
			NxR.CoeffCnt <= 0;	-- reset the sub FSM
		end if;
		NxR.valid <= cInactivated;

	when 	MULT 	=>		-- multiply stages and coefficients
	
			-- NxR.valid <= cInactivated;
			Stages(R.WriteIndex) <= R.MovSample; --to_sfixed(asi_data, sfixed_high, sfixed_low); 		-- write new data into stages
			-- TODO: do exchange stages value and movSample
			
			--NxR.MovSample <= Stage
			--TODO: check the overflow of stagecnt
			if (R.CoeffCnt < gMaxNumCoeffs ) then --and R.StageCnt < gNumberOfCoeffs) then  --multiply (ATTENTION: size <= 32 Bit)
				
				-- do multiplication of one sample
				tmp_coeffs := Coeff(R.CoeffCnt);
				tmp_stages := Stages(R.StageCnt);
				tmp := resize((tmp_coeffs *tmp_stages), tmp);
				--tmp_b := resize(tmp + resize(R.FiltData, tmp), tmp_b);
				
				-- do the addition of all coefficients
				NxR.FiltData <= resize(tmp + R.FiltData, NxR.FiltData);
				
				
				-- NxR.FiltData <= tmp_b;
				
				NxR.CoeffCnt <= R.CoeffCnt + 1;
				NxR.StageCnt <= R.StageCnt + 1;
				NxR.NumOfReads <= R.NumOfReads + 1;
			end if;
			
			if (R.StageCnt >= gMaxNumCoeffs-1) then -- restart (ringbuffer read not finished)
				NxR.StageCnt <= 0;
			end if;
		
			if (R.NumOfReads >= gMaxNumCoeffs-1) then -- stages finished
				
				if(R.WriteIndex >= gMaxNumCoeffs-1) then 
					NxR.WriteIndex <= 0;
				else 
					NxR.WriteIndex <= R.WriteIndex + 1;
				end if;
				
				if(R.ReadIndex >= gMaxNumCoeffs-1) then 
					NxR.ReadIndex <= 0;
				else 
					NxR.ReadIndex <= R.ReadIndex + 1;
				end if;
				
				NxR.valid <= cActivated;
				NxR.State <= IDLE;
				
			end if;
			
	when 	others 	=> NxR.State <= IDLE;
	end case;
end process;

--aso_valid <= asi_valid;
aso_valid <= R.valid;
aso_data  <= to_slv(R.FiltOut); --when R.valid = cActivated else to_slv(R.LastFiltered);

end architecture Rtl;
