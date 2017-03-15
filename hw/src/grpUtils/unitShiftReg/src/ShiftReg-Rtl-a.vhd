-------------------------------------------------------------------------------
-- Title      : Shift Register
-------------------------------------------------------------------------------
-- File       : ShiftReg-Rtl-a.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description: Shift Register
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-03-07  1.0      fxst    Created
-------------------------------------------------------------------------------

architecture Rtl of ShiftReg is
  type aShiftReg is array (0 to gShiftRegLength-1) of std_ulogic_vector(gRegLength-1 downto 0);  -- type of the intern shift register

  signal ShiftReg : aShiftReg;          -- intern shift register

begin  -- architecture Rtl

  doShiftReg : process (iClk, inResetAsync) is
  begin  -- process shiftReg
    if inResetAsync = not('1') then       -- asynchronous reset (active low)
      ShiftReg <= (others => (others => '0'));
    elsif rising_edge(iClk) then        -- rising clock edge
      ShiftReg(0) <= iData;
      for i in 1 to gShiftRegLength-1 loop
        ShiftReg(i) <= ShiftReg(i-1);
      end loop;
    end if;
  end process doShiftReg;

  oData <= ShiftReg(to_integer(iSelOutReg));        -- output

end architecture Rtl;
