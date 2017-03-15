-------------------------------------------------------------------------------
-- Title      : Shift Register
-------------------------------------------------------------------------------
-- File       : ShiftReg-e.vhd
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Global.all;


entity ShiftReg is

  generic (
    gRegLength      : natural := 24;    -- length of a single register
    gShiftRegLength : natural := 256);  -- length of the shift register

  port (
    inResetAsync : in  std_ulogic;      -- async low active reset
    iClk         : in  std_ulogic;      -- clk
    iData        : in  std_ulogic_vector(gRegLength - 1 downto 0);   -- input data
    iSelOutReg   : in  unsigned(LogDualis(gShiftRegLength) - 1 downto 0);  -- input to select output register
    oData        : out std_ulogic_vector(gRegLength - 1 downto 0));  -- output Data

end entity ShiftReg;
