-------------------------------------------------------------------------------
-- Title      : Testbench for design "FirFilter"
-------------------------------------------------------------------------------
-- File       : FirFilter_tb.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.Global.all;
use work.sin_4096.all;

-------------------------------------------------------------------------------

entity FirFilter_tb is
end entity FirFilter_tb;

-------------------------------------------------------------------------------

architecture Bhv of FirFilter_tb is

  constant strobe_time : time       := 200 ns;
  signal sample_strobe : std_ulogic := '0';

  -- filter coeffs
  constant fir_coeffs_c : fract_set_t := (0.5, 0.0, 0.0, 0.0);

  -- component generics
  constant data_width_g       : natural := data_width_c;
  constant coeff_num_g        : natural := fir_coeffs_c'length;
  constant coeff_addr_width_g : natural := 4;

  -- component ports
  signal csi_clk          : std_logic                                       := '1';
  signal rsi_reset_n      : std_logic;
  signal avs_s0_write     : std_logic                                       := '0';
  signal avs_s0_address   : std_logic_vector(coeff_addr_width_g-1 downto 0) := (others => '0');
  signal avs_s0_writedata : std_logic_vector(31 downto 0)                   := (others => '0');
  signal avs_s1_write     : std_logic;
  signal avs_s1_writedata : std_logic_vector(31 downto 0);
  signal asi_valid        : std_logic;
  signal asi_data         : std_logic_vector(data_width_g-1 downto 0);
  signal aso_valid        : std_logic;
  signal aso_data         : std_logic_vector(data_width_g-1 downto 0);

  -- audio data
  signal data_in  : audio_data_t;
  signal data_out : audio_data_t;


begin  -- architecture Bhv

  data_out <= to_sfixed(aso_data, data_out);

  -- component instantiation
  DUT : entity work.FirFilter
    generic map (
      data_width_g       => data_width_g,
      coeff_num_g        => coeff_num_g,
      coeff_addr_width_g => coeff_addr_width_g)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_address   => avs_s0_address,
      avs_s0_writedata => avs_s0_writedata,
      avs_s1_write     => avs_s1_write,
      avs_s1_writedata => avs_s1_writedata,
      asi_valid        => asi_valid,
      asi_data         => asi_data,
      aso_valid        => aso_valid,
      aso_data         => aso_data);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;

  -- sample strobe generation
  --strobe : process is
  --begin  -- process
  --  wait for strobe_time;
  --  wait until rising_edge(csi_clk);
  --  sample_strobe <= '1';
  --  wait until rising_edge(csi_clk);
  --  sample_strobe <= '0';
  --end process;

  SinGen_1: entity work.SinGen
    generic map (
      periode_g     => 100 us,
      sample_time_g => strobe_time)
    port map (
      clk_i        => csi_clk,
      data_o       => data_in,
      data_valid_o => sample_strobe);

  -- sinus as audio data
  --aud_data : process is
  --begin  -- process
  --  for idx in 0 to sin_table_c'length-1 loop
  --    wait until rising_edge(sample_strobe);
  --    data_in <= to_sfixed(sin_table_c(idx), 0, -(data_width_g-1));
  --  end loop;  -- idx
  --end process aud_data;

  asi_data  <= to_slv(data_in);
  asi_valid <= sample_strobe;

  -- write coeffs
  avs_s0 : process is
  begin  -- process avs_s0
    for idx in 0 to coeff_num_g-1 loop
      wait until rising_edge(csi_clk);
      avs_s0_address                            <= std_logic_vector(to_unsigned(idx, avs_s0_address'length));
      avs_s0_write                              <= '1';
      avs_s0_writedata(data_width_g-1 downto 0) <= to_slv(to_sfixed(fir_coeffs_c(idx), 0, -(data_width_g-1)));
    end loop;  -- idx
  end process avs_s0;

  -- waveform generation
  WaveGen_Proc : process
  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    avs_s1_write     <= '0';
    avs_s1_writedata <= (others => '-');

    -- pass in to out
    avs_s1_write        <= '1';
    avs_s1_writedata(0) <= '0';
    wait until rising_edge(csi_clk);
    avs_s1_write        <= '0';
    avs_s1_writedata(0) <= '-';

    wait for 500000 ns;

    -- enable filter
    avs_s1_write        <= '1';
    avs_s1_writedata(0) <= '1';
    wait until rising_edge(csi_clk);
    avs_s1_write        <= '0';
    avs_s1_writedata(0) <= '-';


    wait;
  end process WaveGen_Proc;

end architecture Bhv;

-------------------------------------------------------------------------------
