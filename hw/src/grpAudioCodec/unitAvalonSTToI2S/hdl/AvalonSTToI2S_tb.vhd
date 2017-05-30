-------------------------------------------------------------------------------
-- Title      : Testbench for design "AvalonSTToI2S"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : AvalonSTToI2S_tb.vhd
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
-- 2017-05-23  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity AvalonSTToI2S_tb is

end entity AvalonSTToI2S_tb;

-------------------------------------------------------------------------------

architecture Bhv of AvalonSTToI2S_tb is

  -- component generics
  constant gDataWidth    : natural := 8;
  constant gDataWidthLen : natural := 5;

  -- component ports
  signal iClk        : std_logic := '1';
  signal inReset     : std_logic := '0';
  signal iLRC        : std_logic := '0';
  signal iBCLK       : std_logic := '1';
  signal oDAT        : std_logic;
  signal iLeftData   : std_logic_vector(gDataWidth-1 downto 0);
  signal iLeftValid  : std_logic := '0';
  signal iRightData  : std_logic_vector(gDataWidth-1 downto 0);
  signal iRightValid : std_logic := '0';

begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.AvalonSTToI2S
    generic map (
      gDataWidth    => gDataWidth,
      gDataWidthLen => gDataWidthLen)
    port map (
      iClk        => iClk,
      inReset     => inReset,
      iLRC        => iLRC,
      iBCLK       => iBCLK,
      oDAT        => oDAT,
      iLeftData   => iLeftData,
      iLeftValid  => iLeftValid,
      iRightData  => iRightData,
      iRightValid => iRightValid);

  -- clock generation
  iClk <= not iClk after 10 ns;

  -- BCLK generation
  iBCLK <= not iBCLK after 10 us;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    inReset <= '1' after 10 ns;

    iLeftData <= "11110001" after 100 ns,
                 "00000000" after 500 ns;

    iLeftValid <= '1' after 100 ns,
                  '0' after 120 ns;

    iRightData <= "10001111" after 400 ns,
                  "00000000" after 600 ns;

    iRightValid <= '1' after 400 ns,
                   '0' after 420 ns;

    iLRC <= '0' after 0 ns,
            '1' after 30 us,
            '0' after 600 us;

    wait;
  end process WaveGen_Proc;



end architecture Bhv;


