-------------------------------------------------------------------------------
-- Title       : Direct Digital Synthesis Testbench
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : DDS with RAM Table, Table can be defined over MM Interface
-- The Phase Incremen can also be set over an extra MM Interface
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

use work.Global.all;
use work.sin_4096.all;

-------------------------------------------------------------------------------

entity Dds_tb is
end entity Dds_tb;

-------------------------------------------------------------------------------

architecture Bhv of Dds_tb is

  constant strobe_time : time := 1 sec/real(default_sample_rate_c);

  -- component generics
  constant data_width_g           : natural := 24;
  constant phase_bits_g           : natural := 20;
  constant phase_dither_g         : natural := 8;
  constant wave_table_width_g     : natural := 14;
  constant wave_table_len_g       : natural := 4096;
  constant wave_table_addr_bits_g : natural := 12;

  -- component ports
  signal csi_clk           : std_logic                                           := '1';
  signal rsi_reset_n       : std_logic                                           := '0';
  signal coe_sample_strobe : std_logic                                           := '0';
  signal avs_s0_write      : std_logic                                           := '0';
  signal avs_s0_address    : std_logic_vector(wave_table_addr_bits_g-1 downto 0) := (others => '0');
  signal avs_s0_writedata  : std_logic_vector(31 downto 0)                       := (others => '0');
  signal avs_s1_write      : std_logic                                           := '0';
  signal avs_s1_address    : std_logic                                           := '0';
  signal avs_s1_writedata  : std_logic_vector(31 downto 0)                       := (others => '0');
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
      avs_s1_address    => avs_s1_address,
      avs_s1_writedata  => avs_s1_writedata,
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

  -- write sinus table into ram
  avs_s0 : process is
  begin  -- process avs_s0
    for idx in 0 to sin_table_c'length-1 loop
      wait until rising_edge(csi_clk);
      avs_s0_address <= std_logic_vector(to_unsigned(idx, avs_s0_address'length));
      avs_s0_write   <= '1';
      avs_s0_writedata(wave_table_width_g-1 downto 0)
        <= to_slv(to_sfixed(sin_table_c(idx), 0, -(wave_table_width_g-1)));
    end loop;  -- idx
  end process avs_s0;

  -- waveform generation
  WaveGen_Proc : process

    -- write function for mm interface
    procedure avs_s1_wr (
      constant addr : in std_ulogic;
      constant data : in natural) is
    begin
      avs_s1_address   <= addr;
      avs_s1_writedata <= std_logic_vector(to_unsigned(data, avs_s1_writedata'length));
      avs_s1_write     <= '1';
      wait for 20 ns;
      avs_s1_write     <= '0';
    end avs_s1_wr;

  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    for i in 0 to wave_table_len_g loop
      wait until rising_edge(csi_clk);
    end loop;

    wait for 20 ns;
    -- enable
    avs_s1_wr('0',1);

    -- phase increment
    wait for 5000 ns;
    avs_s1_wr('1',4096);
    wait for 10 ms;
    avs_s1_wr('1',10000);
    wait for 10 ms;
    avs_s1_wr('1',3000);
    wait;
  end process WaveGen_Proc;



end architecture Bhv;

-------------------------------------------------------------------------------
