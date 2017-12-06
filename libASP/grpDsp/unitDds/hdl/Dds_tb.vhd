-------------------------------------------------------------------------------
-- Title      : Testbench for design "Dds"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : Dds_tb.vhd
-- Author     :   <fxst@FXST-PC>
-- Company    : 
-- Created    : 2017-12-06
-- Last update: 2017-12-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-12-06  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Global.all;
use work.sin_4096.all;

-------------------------------------------------------------------------------

entity Dds_tb is
end entity Dds_tb;

-------------------------------------------------------------------------------

architecture Bhv of Dds_tb is

  -- component generics
  constant data_width_g           : natural := 24;
  constant phase_bits_g           : natural := 20;
  constant phase_dither_g         : natural := 8;
  constant wave_table_width_g     : natural := 14;
  constant wave_table_len_g       : natural := 4096;
  constant wave_table_addr_bits_g : natural := 12;

  -- component ports
  signal csi_clk           : std_logic := '1';
  signal rsi_reset_n       : std_logic;
  signal coe_sample_strobe : std_logic;
  signal avs_s0_write      : std_logic;
  signal avs_s0_address    : std_logic_vector(wave_table_addr_bits_g-1 downto 0);
  signal avs_s0_writedata  : std_logic_vector(31 downto 0);
  signal avs_s1_write      : std_logic;
  signal avs_s1_writedata  : std_logic_vector(31 downto 0);
  signal aso_data          : std_logic_vector(data_width_g-1 downto 0);
  signal aso_valid         : std_logic;


begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.Dds
    generic map (
      data_width_g           => data_width_g,
      phase_bits_g           => phase_bits_g,
      phase_dither_g         => phase_dither_g,
      wave_table_width_g     => wave_table_width_g,
      wave_table_len_g       => wave_table_len_g,
      wave_table_addr_bits_g => wave_table_addr_bits_g)
    port map (
      csi_clk           => csi_clk,
      rsi_reset_n       => rsi_reset_n,
      coe_sample_strobe => coe_sample_strobe,
      avs_s0_write      => avs_s0_write,
      avs_s0_address    => avs_s0_address,
      avs_s0_writedata  => avs_s0_writedata,
      avs_s1_write      => avs_s1_write,
      avs_s1_writedata  => avs_s1_writedata,
      aso_data          => aso_data,
      aso_valid         => aso_valid);

  -- clock generation
  csi_clk <= not csi_clk after 20 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;
    wait;
  end process WaveGen_Proc;



end architecture Bhv;

-------------------------------------------------------------------------------
