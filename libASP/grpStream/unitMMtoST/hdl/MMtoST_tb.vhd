-------------------------------------------------------------------------------
-- Title       : Avalon MM to Avalon ST Testbench
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Memory Mapped Slave to Avalon Streaming with Left and Right Channel
--               Used to stream audio data from the soc linux t the fpga
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity MMtoST_tb is

end entity MMtoST_tb;

-------------------------------------------------------------------------------

architecture Bhv of MMtoST_tb is

  constant strobe_time_c : time := 1000 ns;

  -- component generics
  constant data_width_g     : natural := 24;
  constant fifo_depth_g     : natural := 128;
  constant fifo_adr_width_g : natural := 8;

  -- address constants
  constant control_c   : std_logic_vector(1 downto 0) := "00";
  constant fifospace_c : std_logic_vector(1 downto 0) := "01";
  constant leftdata_c  : std_logic_vector(1 downto 0) := "10";
  constant rightdata_c : std_logic_vector(1 downto 0) := "11";

  -- component ports
  signal csi_clk           : std_logic := '1';
  signal rsi_reset_n       : std_logic;
  signal avs_s0_chipselect : std_logic;
  signal avs_s0_write      : std_logic;
  signal avs_s0_read       : std_logic;
  signal avs_s0_address    : std_logic_vector(1 downto 0);
  signal avs_s0_writedata  : std_logic_vector(31 downto 0);
  signal avs_s0_readdata   : std_logic_vector(31 downto 0);
  signal irs_irq           : std_logic;
  signal asi_left_valid    : std_logic;
  signal asi_left_data     : std_logic_vector(data_width_g-1 downto 0);
  signal asi_right_valid   : std_logic;
  signal asi_right_data    : std_logic_vector(data_width_g-1 downto 0);
  signal aso_left_valid    : std_logic;
  signal aso_left_data     : std_logic_vector(data_width_g-1 downto 0);
  signal aso_right_valid   : std_logic;
  signal aso_right_data    : std_logic_vector(data_width_g-1 downto 0);


begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.MMtoST
    generic map (
      data_width_g     => data_width_g,
      fifo_depth_g     => fifo_depth_g,
      fifo_adr_width_g => fifo_adr_width_g)
    port map (
      csi_clk           => csi_clk,
      rsi_reset_n       => rsi_reset_n,
      avs_s0_chipselect => avs_s0_chipselect,
      avs_s0_write      => avs_s0_write,
      avs_s0_read       => avs_s0_read,
      avs_s0_address    => avs_s0_address,
      avs_s0_writedata  => avs_s0_writedata,
      avs_s0_readdata   => avs_s0_readdata,
      irs_irq           => irs_irq,
      asi_left_valid    => asi_left_valid,
      asi_left_data     => asi_left_data,
      asi_right_valid   => asi_right_valid,
      asi_right_data    => asi_right_data,
      aso_left_valid    => aso_left_valid,
      aso_left_data     => aso_left_data,
      aso_right_valid   => aso_right_valid,
      aso_right_data    => aso_right_data);

  -- clock generation
  csi_clk <= not csi_clk after 10 ns;

  std_gen : process is
  begin  -- process std_gen
    asi_left_valid  <= '0';
    asi_right_valid <= '0';
    wait for strobe_time_c;
    wait until rising_edge(csi_clk);
    asi_left_valid  <= '1';
    wait until rising_edge(csi_clk);
    asi_left_valid  <= '0';
    asi_right_valid <= '1';
    wait until rising_edge(csi_clk);
    asi_right_valid <= '0';
  end process std_gen;

  -- waveform generation
  WaveGen_Proc : process
    variable count_v : unsigned(data_width_g-1 downto 0) := (others => '0');
  begin
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 40 ns;

    asi_right_data <= std_logic_vector(count_v);
    asi_left_data  <= std_logic_vector(count_v);

    wait until rising_edge(csi_clk);
    avs_s0_chipselect <= '0';
    avs_s0_write      <= '0';
    avs_s0_read       <= '0';
    avs_s0_address    <= control_c;
    avs_s0_writedata  <= (others => '0');

    wait until rising_edge(csi_clk);
    avs_s0_chipselect <= '1';
    avs_s0_address    <= fifospace_c;
    wait for 20 * strobe_time_c;
    wait until rising_edge(csi_clk);
    avs_s0_address    <= control_c;

    -- read interrupt enable
    wait until rising_edge(csi_clk);
    avs_s0_address   <= control_c;
    avs_s0_writedata <= (0      => '1', 1 => '0', others => '0');
    avs_s0_write     <= '1';
    wait until rising_edge(csi_clk);
    avs_s0_write     <= '0';
    avs_s0_writedata <= (others => '0');

    -- write data
    wait until rising_edge(csi_clk);
    avs_s0_address   <= leftdata_c;
    avs_s0_read      <= '1';
    wait until rising_edge(csi_clk);
    avs_s0_read      <= '0';
    avs_s0_writedata <= (others => '1');
    wait until rising_edge(csi_clk);
    avs_s0_write     <= '1';
    wait until rising_edge(csi_clk);
    avs_s0_write     <= '0';

    wait for 1000 ns;

    for i in 0 to 1023 loop

      wait until rising_edge(asi_right_valid);
      asi_right_data <= std_logic_vector(count_v);
      asi_left_data  <= std_logic_vector(count_v);

      -- read value and write back
      wait until rising_edge(csi_clk);
      avs_s0_address   <= leftdata_c;
      avs_s0_read      <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_read      <= '0';
      avs_s0_writedata <= avs_s0_readdata;
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '0';

      wait until rising_edge(csi_clk);
      avs_s0_address   <= rightdata_c;
      avs_s0_read      <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_read      <= '0';
      avs_s0_writedata <= avs_s0_readdata;
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '0';


      count_v := count_v + 1;
    end loop;  -- i

    -- check empty flag
    for a in 0 to 30 loop
      -- read value and write back
      wait until rising_edge(csi_clk);
      avs_s0_address   <= leftdata_c;
      avs_s0_read      <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_read      <= '0';
      avs_s0_writedata <= avs_s0_readdata;
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '0';

      wait until rising_edge(csi_clk);
      avs_s0_address   <= rightdata_c;
      avs_s0_read      <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_read      <= '0';
      avs_s0_writedata <= avs_s0_readdata;
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '1';
      wait until rising_edge(csi_clk);
      avs_s0_write     <= '0';
    end loop;  -- a

    -- clear fifos
    wait until rising_edge(csi_clk);
    avs_s0_address   <= control_c;
    avs_s0_writedata <= (2      => '1', 3 => '1', others => '0');
    avs_s0_write     <= '1';
    wait until rising_edge(csi_clk);
    avs_s0_write     <= '0';
    avs_s0_writedata <= (others => '0');


    wait for 20 * strobe_time_c;

    assert false report "End of simulation!" severity failure;


    wait;
  end process WaveGen_Proc;



end architecture Bhv;

-------------------------------------------------------------------------------
