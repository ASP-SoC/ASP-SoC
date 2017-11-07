-------------------------------------------------------------------------------
-- Title       : Channel Mux
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Unit Mux left and right channel
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity tbChannelMux is
end entity tbChannelMux;

architecture bhv of tbChannelMux is

  constant gDataWidth : natural := 4;

  signal csi_clk          : std_logic                     := '1';
  signal rsi_reset_n      : std_logic;
  signal avs_s0_write     : std_logic;
  signal avs_s0_writedata : std_logic_vector(31 downto 0) := (others => '0');
  signal asi_left_data    : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_left_valid   : std_logic;
  signal asi_right_data   : std_logic_vector(gDataWidth-1 downto 0);
  signal asi_right_valid  : std_logic;
  signal aso_left_data    : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_left_valid   : std_logic;
  signal aso_right_data   : std_logic_vector(gDataWidth-1 downto 0);
  signal aso_right_valid  : std_logic;

  -- test time
  constant test_time_c : time := 20 ns;

  -- testcases
  type testcase_t is record
    func      : std_logic_vector(3 downto 0);
    r_data    : std_logic_vector(gDataWidth-1 downto 0);
    l_data    : std_logic_vector(gDataWidth-1 downto 0);
    r_valid   : std_logic;
    l_valid   : std_logic;
    exp_r_d   : std_logic_vector(gDataWidth-1 downto 0);
    exp_l_d   : std_logic_vector(gDataWidth-1 downto 0);
    exp_r_val : std_logic;
    exp_l_val : std_logic;
  end record;

  -- test vector
  type test_array_t is array (natural range<>) of testcase_t;

  constant testcases : test_array_t := (
    -- straight
    ("0000", "0101", "1010", '1', '0', "0101", "1010", '1', '0'),
    -- cross R and L
    ("0001", "0101", "1010", '1', '0', "1010", "0101", '0', '1'),
    -- silence left and straight
    ("1000", "0101", "1010", '1', '0', "0101", "0000", '1', '0'),
    -- silence right and straight
    ("0100", "0101", "1010", '1', '0', "0000", "1010", '1', '0'),
    -- silence R and L and straight
    ("1100", "0101", "1010", '1', '0', "0000", "0000", '1', '0'),
    -- silence R and L and cross
    ("1101", "0101", "1010", '1', '0', "0000", "0000", '0', '1'),
    -- both L
    ("0010", "0101", "1010", '1', '0', "1010", "1010", '0', '0'),
    -- both L and silence L
    ("1010", "0101", "1010", '1', '0', "0000", "0000", '0', '0'),
    -- both R
    ("0011", "0101", "1010", '1', '0', "0101", "0101", '1', '1'),
    -- both R and silence R
    ("0111", "0101", "1010", '1', '0', "0000", "0000", '1', '1')
    );

begin

  DUT : entity work.ChannelMux
    generic map (
      gDataWidth => gDataWidth)
    port map (
      csi_clk          => csi_clk,
      rsi_reset_n      => rsi_reset_n,
      avs_s0_write     => avs_s0_write,
      avs_s0_writedata => avs_s0_writedata,
      asi_left_data    => asi_left_data,
      asi_left_valid   => asi_left_valid,
      asi_right_data   => asi_right_data,
      asi_right_valid  => asi_right_valid,
      aso_left_data    => aso_left_data,
      aso_left_valid   => aso_left_valid,
      aso_right_data   => aso_right_data,
      aso_right_valid  => aso_right_valid);

  -- clk generation
  csi_clk <= not csi_clk after 10 ns;

  test_process : process is
    -- test function
    procedure test (
      constant testcase    : in    testcase_t;
      variable error_count : inout natural) is
    begin  -- test

      -- inputs
      asi_left_data   <= testcase.l_data;
      asi_left_valid  <= testcase.l_valid;
      asi_right_data  <= testcase.r_data;
      asi_right_valid <= testcase.r_valid;

      avs_s0_write                 <= '1';
      avs_s0_writedata(3 downto 0) <= testcase.func;
      wait for 20 ns;
      avs_s0_write                 <= '0';

      wait for test_time_c;

      -- check outputs
      if (aso_left_data /= testcase.exp_l_d)
        or (aso_right_data /= testcase.exp_r_d)
        or (aso_left_valid /= testcase.exp_l_val)
        or (aso_right_valid /= testcase.exp_r_val)then
        assert false report
          "tbChannelMux : Output not as expected !"
          severity error;
        error_count := error_count + 1;
      end if;
    end test;

    -- error count
    variable error_count_v : natural := 0;
  begin  -- process
    rsi_reset_n <= '0' after 0 ns,
                   '1' after 10 ns;

    wait for 20 ns;

    for i in testcases'range loop
      test(testcases(i), error_count_v);
    end loop;

    if error_count_v = 0 then
      assert false report "tbChannelMux: test completed without errors, ending without failure." severity failure;
    else
      assert false report "tbChannelMux: test failed with " & integer'image(error_count_v) & " errors!" severity failure;
    end if;

    wait;

  end process;


end architecture bhv;
