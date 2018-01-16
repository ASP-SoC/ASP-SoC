-------------------------------------------------------------------------------
-- Title       : White Noise Generator
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : White Noise Generation with an maximum tap LFSR
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.lfsr.all;

entity WhiteNoise is

  generic (
    -- number of bits for the streaming interface
    data_width_g  : natural := 24;
    -- number of bits for the lfsr
    lfsr_length_g : natural := 24);

  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- sample strobe
    coe_sample_strobe : in std_logic;

    -- Avalon MM Slave Port s0 - used for enable
    -- writedata[0] = 0 => disabled
    -- writedata[1] = 1 => enabled
    avs_s0_write     : in std_logic;
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon ST source
    aso_data  : out std_logic_vector(data_width_g-1 downto 0);
    aso_valid : out std_logic

    );

begin
  -- plausibility checks
  assert lfsr_length_g >= data_width_g
    report "lfsr length must be equal or greater than data width"
    severity failure;

end entity WhiteNoise;

architecture Rtl of WhiteNoise is

  -- enable lfsr and output
  signal enable : std_ulogic;

  -- lfsr
  signal lfsr_state : std_ulogic_vector(lfsr_length_g downto 1);

  -- noise
  signal white_noise : u_sfixed(0 downto -(data_width_g-1));

begin  -- architecture Rtl

  -- MM slave for enable
  s0_config : process (csi_clk, rsi_reset_n) is
  begin  -- process
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      enable <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if avs_s0_write = '1' then
        enable <= avs_s0_writedata(0);
      end if;
    end if;
  end process;

  -- lfsr white noise generation
  lfsr_gen : process (csi_clk, rsi_reset_n) is
  begin  -- process lfsr_gen
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      lfsr_state <= (others => '0');
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if coe_sample_strobe = '1' and enable = '1' then
        lfsr_state <= lfsr_nx_state(lfsr_state);
      elsif enable = '0' then
        lfsr_state <= (others => '0');
      end if;
    end if;
  end process lfsr_gen;

  white_noise <= to_sfixed(lfsr_state(data_width_g downto 1), white_noise);

  -- avalon stream
  aso_valid <= coe_sample_strobe;
  aso_data  <= to_slv(white_noise);


end architecture Rtl;
