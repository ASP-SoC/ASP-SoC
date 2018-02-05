-------------------------------------------------------------------------------
-- Title       : Add Channels Testbench
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Scale Channels with an factor and add
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

use work.Global.all;
use work.sin_4096.all;

-------------------------------------------------------------------------------

entity AddChannels_tb is
end entity AddChannels_tb;

-------------------------------------------------------------------------------

architecture Bhv of AddChannels_tb is

  --constant strobe_time : time := 1 sec/real(44117);
  constant strobe_time : time := 200 ns;

  -- component generics
  constant data_width_g : natural := 24;
  constant fact_a_g     : real    := 0.5;
  constant fact_b_g     : real    := 0.5;

  -- component ports
  signal csi_clk          : std_logic                     := '1';
  signal rsi_reset_n      : std_logic                     := '0';
  signal avs_s0_write     : std_logic                     := '0';
  signal avs_s0_writedata : std_logic_vector(31 downto 0) := (others => '0');
  signal asi_a_data       : std_logic_vector(data_width_g-1 downto 0);
  signal asi_a_valid      : std_logic;
  signal asi_b_data       : std_logic_vector(data_width_g-1 downto 0);
  signal asi_b_valid      : std_logic;
  signal aso_data         : std_logic_vector(data_width_g-1 downto 0);
  signal aso_valid        : std_logic;

  signal result : sfixed(0 downto -(data_width_g-1));

  -- audio data
  signal sample_strobe : std_ulogic   := '0';
  signal audio_data    : sfixed(0 downto -(data_width_g-1)) := (others => '0');

begin  -- architecture Bhv

  result <= to_sfixed(aso_data, result);
  
  -- component instantiation
  DUT : entity work.AddChannels
    generic map (
      data_width_g => data_width_g,
      fact_a_g     => fact_a_g,
      fact_b_g     => fact_b_g)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_writedata => avs_s0_writedata,
      asi_a_data       => asi_a_data,
      asi_a_valid      => asi_a_valid,
      asi_b_data       => asi_b_data,
      asi_b_valid      => asi_b_valid,
      aso_data         => aso_data,
      aso_valid        => aso_valid);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;

  -- sample strobe generation
  strobe : process is
  begin  -- process
    wait for strobe_time;
    wait until rising_edge(csi_clk);
    sample_strobe <= '1';
    wait until rising_edge(csi_clk);
    sample_strobe <= '0';
  end process;

  -- sinus as audio data
  aud_data : process is
  begin  -- process
    for idx in 0 to sin_table_c'length-1 loop
      wait until rising_edge(sample_strobe);
      audio_data <= to_sfixed(sin_table_c(idx), 0, -(data_width_g-1));
    end loop;  -- idx
  end process aud_data;

  -- channel a and b with sinus
  asi_a_data  <= to_slv(to_sfixed(real(0.5), 0, -(data_width_g-1)));
  asi_b_data  <= to_slv(audio_data);
  --asi_b_data  <= (others => '0');
  asi_a_valid <= sample_strobe;
  asi_b_valid <= sample_strobe;

  -- waveform generation
  WaveGen_Proc : process
  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    avs_s0_write     <= '0';
    avs_s0_writedata <= (others => '-');

    -- pass a
    avs_s0_write                 <= '1';
    avs_s0_writedata(1 downto 0) <= "00";
    wait until rising_edge(csi_clk);
    avs_s0_write                 <= '0';
    avs_s0_writedata(1 downto 0) <= "--";

    wait for 500000 ns;

    -- pass b
    avs_s0_write                 <= '1';
    avs_s0_writedata(1 downto 0) <= "01";
    wait until rising_edge(csi_clk);
    avs_s0_write                 <= '0';
    avs_s0_writedata(1 downto 0) <= "--";

    wait for 500000 ns;

    -- sum a + b
    avs_s0_write                 <= '1';
    avs_s0_writedata(1 downto 0) <= "10";
    wait until rising_edge(csi_clk);
    avs_s0_write                 <= '0';
    avs_s0_writedata(1 downto 0) <= "--";

    wait for 500000 ns;

    -- mute
    avs_s0_write                 <= '1';
    avs_s0_writedata(1 downto 0) <= "11";
    wait until rising_edge(csi_clk);
    avs_s0_write                 <= '0';
    avs_s0_writedata(1 downto 0) <= "--";

    wait;
  end process WaveGen_Proc;


end architecture Bhv;

-------------------------------------------------------------------------------
