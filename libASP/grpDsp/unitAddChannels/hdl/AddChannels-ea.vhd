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

    -- Avalon ST sink left and right channel
    asi_a_data  : in std_logic_vector(data_width_g-1 downto 0);
    asi_a_valid : in std_logic;
    asi_b_data  : in std_logic_vector(data_width_g-1 downto 0);
    asi_b_valid : in std_logic;

    -- Avalon ST source result of channel a + b
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

begin  -- architecture Rtl

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
  scale_add: process (ch_a, ch_b)  is
    variable a_scaled, b_scaled : result_t := (others => '0');
  begin  -- process
    a_scaled := ch_a * fact_a_g;
    b_scaled := ch_b * fact_b_g;
    res <= resize(a_scaled + b_scaled, res); 
  end process;

  -- convert result to avalon stream
  aso_data  <= to_slv(res);
  aso_valid <= asi_b_valid;

end architecture Rtl;
