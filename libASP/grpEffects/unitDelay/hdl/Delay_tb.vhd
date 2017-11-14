-------------------------------------------------------------------------------
-- Title      : Testbench for design "Delay"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : Delay_tb.vhd
-- Author     : free-hat  <free_hat@freehat-Ultrabook>
-- Company    : 
-- Created    : 2017-11-14
-- Last update: 2017-11-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-11-14  1.0      free_hat	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity Delay_tb is

end entity Delay_tb;

-------------------------------------------------------------------------------

architecture bhv of Delay_tb is

  -- component generics
  constant gMaxDelay  : natural := 1024;
  constant gDataWidth : natural := 24;

  -- component ports
  signal csi_clk          : std_logic := '1';
  signal rsi_reset_n      : std_logic;
  signal avs_s0_write     : std_logic;
  signal avs_s0_writedata : std_logic_vector(31 downto 0);
  signal asi_data         : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_valid        : std_logic;
  signal aso_data         : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_valid        : std_logic;


begin  -- architecture bhv

  -- component instantiation
  DUT: entity work.Delay
    generic map (
      gMaxDelay  => gMaxDelay,
      gDataWidth => gDataWidth)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_writedata => avs_s0_writedata,
      asi_data         => asi_data,
      asi_valid        => asi_valid,
      aso_data         => aso_data,
      aso_valid        => aso_valid);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here

    rsi_reset_n <= '0';
    avs_s0_write <= '0';
    avs_s0_writedata <= std_logic_vector(to_unsigned(10,avs_s0_writedata'length));
    asi_data <= (others => '0');
    --asi_valid <= '0';
    
    wait for 100 ns;
    rsi_reset_n <= '1';

    wait for 50 ns;
    avs_s0_write <= '1';

    wait for 50 ns;
    avs_s0_write <= '0';

    wait for 50 ns;
    asi_data <= (others => '1');


    wait for 30 ms;
    
    avs_s0_writedata <= std_logic_vector(to_unsigned(1,avs_s0_writedata'length));
    avs_s0_write <= '1';
    wait for 20 ns;
    avs_s0_write <= '0';

    asi_data <= (others => '0');

    wait for 10 ms;

    
    avs_s0_writedata <= std_logic_vector(to_unsigned(0,avs_s0_writedata'length));
    avs_s0_write <= '1';
    wait for 20 ns;
    avs_s0_write <= '0';

    asi_data <= (others => '1');

    wait for 10 ms;

    
    avs_s0_writedata <= std_logic_vector(to_unsigned(gMaxDelay-1,avs_s0_writedata'length));
    avs_s0_write <= '1';
    wait for 20 ns;
    avs_s0_write <= '0';

    asi_data <= (others => '0');

    wait for 20 ms;
    
    wait;
  end process WaveGen_Proc;


  -- purpose: generate a valid signal every 1/48kHz
  -- type   : combinational
  -- inputs : 
  -- outputs: asi_valid
  valid_48khz: process is
  begin  -- process valid_48khz
    wait until csi_clk = '0';
    asi_valid <= '1';
    wait until csi_clk = '1';
    wait until csi_clk = '0';
    asi_valid <= '0';
    wait for 20 us;
  end process valid_48khz;

end architecture bhv;

-------------------------------------------------------------------------------

configuration Delay_tb_bhv_cfg of Delay_tb is
  for bhv
  end for;
end Delay_tb_bhv_cfg;

-------------------------------------------------------------------------------
