-------------------------------------------------------------------------------
-- Title       : Add Channels
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Scale Channels with an factor and add
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.Global.all;

entity AddChannels is

  generic (
    -- audio data width
    data_width_g : natural := 24;
    -- scale factor, because the additon can cause an overflow
    fact_a_g     : real    := 0.5;
    fact_b_g     : real    := 0.5
    );
  port (
    -- clk and reset
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- Avalon MM Slave Port s0 - used for config parameters
    -- config register width = 2 bit
    -- "00" pass channel a
    -- "01" pass channel b
    -- "10" sum of channel a + channel b
    -- "11" mute
    avs_s0_write     : in std_logic;
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon ST sink left and right channel
    asi_a_data  : in std_logic_vector(data_width_g-1 downto 0);
    asi_a_valid : in std_logic;
    asi_b_data  : in std_logic_vector(data_width_g-1 downto 0);
    asi_b_valid : in std_logic;

    -- Avalon ST source a, b, a+b or mute
    aso_data  : out std_logic_vector(data_width_g-1 downto 0);
    aso_valid : out std_logic
    );

end entity AddChannels;

architecture Rtl of AddChannels is

  subtype audio_data_t is u_sfixed(0 downto -(data_width_g-1));
  subtype result_t is u_sfixed(1 downto 2*(-(data_width_g-1)));

  -- channel a and b
  signal ch_a, ch_b : audio_data_t;
  signal res        : audio_data_t;

  -- config register
  subtype config_t is std_ulogic_vector(1 downto 0);
  signal config : config_t;

  constant pass_a_c  : config_t := "00";
  constant pass_b_c  : config_t := "01";
  constant sum_a_b_c : config_t := "10";
  constant mute_c    : config_t := "11";

begin  -- architecture Rtl

  -- MM INTERFACE for configuration
  SetConfigReg : process (csi_clk, rsi_reset_n) is
  begin
    if rsi_reset_n = not('1') then      -- low active reset
      config <= (others => '0');
    elsif rising_edge(csi_clk) then     -- rising 
      if avs_s0_write = '1' then
        config <= to_stdulogicvector(avs_s0_writedata(config'range));
      end if;
    end if;
  end process;

  -- convert avalon stream to sfixed format
  ch_b <= to_sfixed(asi_b_data, ch_b);

  -- store channel a in an register
  store_ch_a : process (csi_clk, rsi_reset_n) is
  begin  -- process store_ch_a
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      ch_a <= (others => '0');
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if asi_a_valid = '1' then         -- channel a valid
        -- convert avalon stream to sfixed format
        ch_a <= to_sfixed(asi_a_data, ch_a);
      end if;
    end if;
  end process store_ch_a;

  -- scale channels and add when channel b is valid
  scale_add : process (ch_a, ch_b) is
    variable a_scaled, b_scaled : result_t := (others => '0');
  begin  -- process
    a_scaled := ch_a * fact_a_g;
    b_scaled := ch_b * fact_b_g;
    res      <= resize(a_scaled + b_scaled, 0, -(data_width_g-1));
  end process;

  -- convert result to avalon stream
  out_mux : process (asi_a_data, asi_a_valid, asi_b_data, asi_b_valid, config,
                     res) is
  begin  -- process out_mux
    case config is
      when pass_a_c =>
        aso_data  <= asi_a_data;
        aso_valid <= asi_a_valid;

      when pass_b_c =>
        aso_data  <= asi_b_data;
        aso_valid <= asi_b_valid;
      when sum_a_b_c =>
        aso_data  <= to_slv(res);
        aso_valid <= asi_b_valid;
      when mute_c =>
        aso_data  <= to_slv(silence_c);
        aso_valid <= asi_a_valid;
      when others =>
        aso_data  <= (others => 'X');
        aso_valid <= 'X';
    end case;
  end process out_mux;



end architecture Rtl;
