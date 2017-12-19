-------------------------------------------------------------------------------
-- Title      : Testbench for design "ValidExtractor"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ValidExtractor_tb.vhd
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
-- 2017-12-12  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity ValidExtractor_tb is

end entity ValidExtractor_tb;

-------------------------------------------------------------------------------

architecture bhv of ValidExtractor_tb is

  constant strobe_time : time := 1000 ns;

  -- component generics
  constant data_width_g : natural := 24;

  -- component ports
  signal csi_clk           : std_logic := '1';
  signal rsi_reset_n       : std_logic;
  signal asi_valid         : std_logic := '0';
  signal asi_data          : std_logic_vector(data_width_g-1 downto 0) := (others => '0');
  signal aso_valid         : std_logic;
  signal aso_data          : std_logic_vector(data_width_g-1 downto 0);
  signal coe_sample_strobe : std_logic;

begin  -- architecture bhv

  -- component instantiation
  DUT : entity work.ValidExtractor
    generic map (
      data_width_g => data_width_g)
    port map (
      csi_clk           => csi_clk,
      rsi_reset_n       => rsi_reset_n,
      asi_valid         => asi_valid,
      asi_data          => asi_data,
      aso_valid         => aso_valid,
      aso_data          => aso_data,
      coe_sample_strobe => coe_sample_strobe);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;

  -- strobe generation
  valid : process is
  begin  -- process
    wait for strobe_time;
    wait until rising_edge(csi_clk);
    asi_valid <= '1';
    wait until rising_edge(csi_clk);
    asi_valid <= '0';
  end process;

  -- waveform generation
  WaveGen_Proc : process
  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    wait;
  end process WaveGen_Proc;



end architecture bhv;

-------------------------------------------------------------------------------
