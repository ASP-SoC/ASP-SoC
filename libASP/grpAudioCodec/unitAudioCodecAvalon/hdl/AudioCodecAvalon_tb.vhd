-------------------------------------------------------------------------------
-- Title      : Testbench for design "AudioCodecAvalon"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : AudioCodecAvalon_tb.vhd
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

entity AudioCodecAvalon_tb is

end entity AudioCodecAvalon_tb;

-------------------------------------------------------------------------------

architecture Bhv of AudioCodecAvalon_tb is

  -- component generics
  constant gDataWidth    : natural := 8;
  constant gDataWidthLen : natural := 5;

  -- component ports
  signal csi_clk         : std_logic := '1';
  signal rsi_reset_n     : std_logic := '0';
  signal AUD_ADCDAT      : std_logic;
  signal AUD_ADCLRCK     : std_logic;
  signal AUD_BCLK        : std_logic := '1';
  signal AUD_DACDAT      : std_logic;
  signal AUD_DACLRCK     : std_logic;
  signal asi_left_data   : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_left_valid  : std_logic;
  signal asi_right_data  : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_right_valid : std_logic;
  signal aso_left_data   : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_left_valid  : std_logic;
  signal aso_right_data  : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_right_valid : std_logic;

  signal LRC : std_logic := '0';


begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.AudioCodecAvalon
    generic map (
      gDataWidth    => gDataWidth,
      gDataWidthLen => gDataWidthLen)
    port map (
      csi_clk         => csi_clk,
      rsi_reset_n     => rsi_reset_n,
      AUD_ADCDAT      => AUD_ADCDAT,
      AUD_ADCLRCK     => AUD_ADCLRCK,
      AUD_BCLK        => AUD_BCLK,
      AUD_DACDAT      => AUD_DACDAT,
      AUD_DACLRCK     => AUD_DACLRCK,
      asi_left_data   => asi_left_data,
      asi_left_valid  => asi_left_valid,
      asi_right_data  => asi_right_data,
      asi_right_valid => asi_right_valid,
      aso_left_data   => aso_left_data,
      aso_left_valid  => aso_left_valid,
      aso_right_data  => aso_right_data,
      aso_right_valid => aso_right_valid);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;   -- 50MHz

  -- BCLK generation 48kHz
  AUD_BCLK <= not AUD_BCLK after 10 us;

  -- LRC generation
  LRC <= not LRC after 190 us;
  
  AUD_ADCDAT  <= AUD_DACDAT;
  AUD_ADCLRCK <= LRC;
  AUD_DACLRCK <= LRC;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here

    rsi_reset_n <= '1' after 10 ns;

    asi_left_data <= "11110001" after 0 ns;

    asi_left_valid <= '1' after 60 ns;


    asi_right_data <= "10001111" after 60 ns;

    asi_right_valid <= '1' after 80 ns;


    wait;
  end process WaveGen_Proc;



end architecture Bhv;
