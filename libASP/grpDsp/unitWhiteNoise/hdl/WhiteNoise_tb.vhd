-------------------------------------------------------------------------------
-- Title      : Testbench for design "WhiteNoise"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : WhiteNoise_tb.vhd
-- Author     :   <fxst@FXST-PC>
-- Company    : 
-- Created    : 2017-12-12
-- Last update: 2017-12-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-12-12  1.0      fxst	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.Global.all;

-------------------------------------------------------------------------------

entity WhiteNoise_tb is

end entity WhiteNoise_tb;

-------------------------------------------------------------------------------

architecture bhv of WhiteNoise_tb is

  constant strobe_time : time := 1 sec/real(44117);

  -- component generics
  constant data_width_g  : natural := 24;
  constant lfsr_length_g : natural := 24;

  -- component ports
  signal csi_clk           : std_logic := '1';
  signal rsi_reset_n       : std_logic;
  signal coe_sample_strobe : std_logic;
  signal avs_s0_write      : std_logic;
  signal avs_s0_writedata  : std_logic_vector(31 downto 0);
  signal aso_data          : std_logic_vector(data_width_g-1 downto 0);
  signal aso_valid         : std_logic;


begin  -- architecture bhv

  -- component instantiation
  DUT: entity work.WhiteNoise
    generic map (
      data_width_g  => data_width_g,
      lfsr_length_g => lfsr_length_g)
    port map (
      csi_clk           => csi_clk,
      rsi_reset_n       => rsi_reset_n,
      coe_sample_strobe => coe_sample_strobe,
      avs_s0_write      => avs_s0_write,
      avs_s0_writedata  => avs_s0_writedata,
      aso_data          => aso_data,
      aso_valid         => aso_valid);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;

    -- sample strobe generation
  sample_strobe : process is
  begin  -- process
    wait for strobe_time;
    wait until rising_edge(csi_clk);
    coe_sample_strobe <= '1';
    wait until rising_edge(csi_clk);
    coe_sample_strobe <= '0';
  end process;

  -- waveform generation
  WaveGen_Proc: process
  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    avs_s0_write <= '0';
    avs_s0_writedata <= (others => '-');

    wait for 100 ns;

    -- enable
    avs_s0_write <= '1';
    avs_s0_writedata(0) <= '1';
    wait until rising_edge(csi_clk);
    avs_s0_write <= '0';
    avs_s0_writedata(0) <= '-';

    wait for 50000 ns;

    -- disable
    avs_s0_write <= '1';
    avs_s0_writedata(0) <= '0';
    wait until rising_edge(csi_clk);
    avs_s0_write <= '0';
    avs_s0_writedata(0) <= '-';

    wait for 50000 ns;

    -- enable
    avs_s0_write <= '1';
    avs_s0_writedata(0) <= '1';
    wait until rising_edge(csi_clk);
    avs_s0_write <= '0';
    avs_s0_writedata(0) <= '-';

    wait;
  end process WaveGen_Proc;

  
end architecture bhv;

