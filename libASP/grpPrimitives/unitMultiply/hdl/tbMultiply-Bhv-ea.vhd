-------------------------------------------------------------------------------
-- Title       : Multiply
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Unit Multiply multiplies L and R channel with a factor
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

use work.Global.all;
use work.sin_4096.all;

entity tbMultiply is
end entity tbMultiply;

architecture bhv of tbMultiply is

  --constant strobe_time : time := 1 sec/real(44117);
  constant strobe_time : time := 200 ns;

  constant data_width_g : natural := 24;

  constant left_fact  : real := 0.5;
  constant right_fact : real := 0.5;

  subtype audio_data_t is u_sfixed(0 downto -(data_width_g-1));



  signal csi_clk          : std_logic                     := '1';
  signal rsi_reset_n      : std_logic;
  signal avs_s0_write     : std_logic;
  signal avs_s0_address   : std_logic;
  signal avs_s0_writedata : std_logic_vector(31 downto 0) := (others => '0');
  signal asi_left_data    : std_logic_vector(data_width_g-1 downto 0);
  signal asi_left_valid   : std_logic;
  signal asi_right_data   : std_logic_vector(data_width_g-1 downto 0);
  signal asi_right_valid  : std_logic;
  signal aso_left_data    : std_logic_vector(data_width_g-1 downto 0);
  signal aso_left_valid   : std_logic;
  signal aso_right_data   : std_logic_vector(data_width_g-1 downto 0);
  signal aso_right_valid  : std_logic;

  signal left_data  : audio_data_t;
  signal right_data : audio_data_t;

  -- test time
  constant test_time_c : time := 20 ns;

  -- audio data
  signal sample_strobe, strobe2 : std_ulogic                           := '0';
  signal audio_data             : u_sfixed(0 downto -(data_width_g-1)) := (others => '0');


begin

  DUT : entity work.Multiply
    generic map (
      data_width_g => data_width_g)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_address   => avs_s0_address,
      avs_s0_writedata => avs_s0_writedata,
      asi_left_data    => asi_left_data,
      asi_left_valid   => asi_left_valid,
      asi_right_data   => asi_right_data,
      asi_right_valid  => asi_right_valid,
      aso_left_data    => aso_left_data,
      aso_left_valid   => aso_left_valid,
      aso_right_data   => aso_right_data,
      aso_right_valid  => aso_right_valid);

  left_data  <= to_sfixed(aso_left_data, 0, -(data_width_g-1));
  right_data <= to_sfixed(aso_right_data, 0, -(data_width_g-1));

  -- clk generation
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

  strobe_2 : process is
  begin
    wait until sample_strobe = '1';
    wait until rising_edge(csi_clk);
    strobe2 <= '1';
    wait until rising_edge(csi_clk);
    strobe2 <= '0';
  end process strobe_2;

  -- sinus as audio data
  aud_data : process is
  begin  -- process
    for idx in 0 to sin_table_c'length-1 loop
      wait until rising_edge(sample_strobe);
      audio_data <= to_sfixed(sin_table_c(idx), 0, -(data_width_g-1));
    end loop;  -- idx
  end process aud_data;

  -- channel left and right with sinus
  --asi_right_data  <= to_slv(to_sfixed(real(0.5), 0, -(data_width_g-1)));
  asi_right_data   <= to_slv(audio_data);
  asi_left_data   <= to_slv(audio_data);
  asi_right_valid <= sample_strobe;
  asi_left_valid  <= sample_strobe;

  test_process : process is
  begin  -- process
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    avs_s0_write <= '0';


    wait for 100 ns;
    -- write factors

    -- left
    avs_s0_address                            <= '0';
    avs_s0_writedata(data_width_g-1 downto 0) <= to_slv(to_sfixed(left_fact, 0, -(data_width_g-1)));
    avs_s0_write                              <= '1';
    wait for 20 ns;
    avs_s0_write                              <= '0';

    wait for 20 ns;
    -- right
    avs_s0_address                            <= '1';
    avs_s0_writedata(data_width_g-1 downto 0) <= to_slv(to_sfixed(right_fact, 0, -(data_width_g-1)));
    avs_s0_write                              <= '1';
    wait for 20 ns;
    avs_s0_write                              <= '0';

    wait;

  end process;


end architecture bhv;
