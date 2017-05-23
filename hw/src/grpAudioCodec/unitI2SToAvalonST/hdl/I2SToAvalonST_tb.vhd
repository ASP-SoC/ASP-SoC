-------------------------------------------------------------------------------
-- Title      : Testbench for design "I2SToAvalonST"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : I2SToAvalonST_tb.vhd
-- Author     :   <fxst@FXST-PC>
-- Company    : 
-- Created    : 2017-05-23
-- Last update: 2017-05-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-05-23  1.0      fxst	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity I2SToAvalonST_tb is
end entity I2SToAvalonST_tb;

-------------------------------------------------------------------------------

architecture Bhv of I2SToAvalonST_tb is

  -- component generics
  constant gDataWidth    : natural := 24;
  constant gDataWidthLen : natural := 5;

  -- component ports
  signal iClk        : std_logic := '1';
  signal inReset     : std_logic := '0';
  signal iDAT        : std_logic := '1';
  signal iLRC        : std_logic := '0';
  signal iBCLK       : std_logic := '1';
  signal oLeftData   : std_logic_vector(gDataWidth-1 downto 0);
  signal oLeftValid  : std_logic;
  signal oRightData  : std_logic_vector(gDataWidth-1 downto 0);
  signal oRightValid : std_logic;


begin  -- architecture Bhv

  -- component instantiation
  DUT: entity work.I2SToAvalonST
    generic map (
      gDataWidth    => gDataWidth,
      gDataWidthLen => gDataWidthLen)
    port map (
      iClk        => iClk,
      inReset     => inReset,
      iDAT        => iDAT,
      iLRC        => iLRC,
      iBCLK       => iBCLK,
      oLeftData   => oLeftData,
      oLeftValid  => oLeftValid,
      oRightData  => oRightData,
      oRightValid => oRightValid);

  -- clock generation
  iClk <= not iClk after 10 ns;

  -- BCLK generation
  iBCLK <= not iBCLK after 10 us;

  process (iBCLK) is
  begin  -- process
    if falling_edge(iBCLK) then
      iDAT <= not iDAT;
    end if;
  end process;


  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    inReset <= '1' after 10 ns;

    iLRC <= '0' after 0 ns,
            '1' after 30 us,
            '0' after 600 us;
    

    wait;
  end process WaveGen_Proc;

  

end architecture Bhv;

