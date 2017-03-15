-------------------------------------------------------------------------------
-- Title      : Testbench for design "ShiftReg"
-------------------------------------------------------------------------------
-- File       : ShiftReg_tb.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description: 
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

entity ShiftReg_tb is
end entity ShiftReg_tb;

architecture Bhv of ShiftReg_tb is

  -- component generics
  constant cRegLength      : natural := 8;
  constant cShiftRegLength : natural := 32;

  -- component ports
  signal nResetAsync : std_ulogic;
  signal InputData   : std_ulogic_vector(cRegLength - 1 downto 0);
  signal SelOutReg   : unsigned(LogDualis(cShiftRegLength) - 1 downto 0);
  signal OutputData  : std_ulogic_vector(cRegLength - 1 downto 0);

  -- clock
  signal Clk : std_ulogic := '1';

begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.ShiftReg
    generic map (
      gRegLength      => cRegLength,
      gShiftRegLength => cShiftRegLength)
    port map (
      inResetAsync => nResetAsync,
      iClk         => Clk,
      iData        => InputData,
      iSelOutReg   => SelOutReg,
      oData        => OutputData);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    nResetAsync <= '0',
                   '1' after 10 ns;

    InputData <= "01010101" after 0 ns,
                 "00000001" after 200 ns;

    SelOutReg <= to_unsigned(20, SelOutReg'length) after 0 ns,
                 to_unsigned(10, SelOutReg'length) after 200 ns;

    wait;
  end process WaveGen_Proc;

end architecture Bhv;


