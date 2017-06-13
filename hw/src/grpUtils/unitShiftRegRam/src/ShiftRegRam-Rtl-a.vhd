-------------------------------------------------------------------------------
-- Title      : Shift Register using RAM
-------------------------------------------------------------------------------
-- File       : ShiftRegRam-Rtl-a.vhd
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

architecture Rtl of ShiftRegRam is
  
  -- number of values needed to reach gMaxDelay --> compute via _hw.tcl ???????
  constant cMaxDepth : natural := gMaxDelay*gNewDataFreq/1000;

  type aShiftReg is array (0 to cMaxDepth-1) of std_ulogic_vector(gWidth-1 downto 0);
  signal ShiftReg : aShiftReg := (others => (others=>'0')); -- initialize RAM with '0'

  -- set type of memory used
  attribute ramstyle : string;
  attribute ramstyle of ShiftReg : signal is "M10K";


begin

  doShiftReg : process (csi_clk) is
  begin
	if rising_edge(csi_clk) then  -- rising clock edge
	  audio_out_valid <= '0';
	  
      if audio_in_valid = '1' then 

        ShiftReg(0) <= std_ulogic_vector(iData);
        for i in 1 to to_integer(iActualLength)-1 loop
          ShiftReg(i) <= ShiftReg(i-1);
        end loop;
	  
		audio_out_valid <= '1'; -- new data was shifted to output, set valid for 1 cycle
	  end if;
    end if;
  end process doShiftReg;

  oData <= std_logic_vector(ShiftReg(to_integer(iActualLength-1))); -- output register at desired length

end architecture Rtl;
