-------------------------------------------------------------------------------
-- Title       : Direct Digital Synthesis
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : DDS with RAM Table, Table can be defined over MM Interface
-- The Phase Incremen can also be set over an extra MM Interface
-------------------------------------------------------------------------------

architecture Rtl of Dds is

  -- RAM
  subtype entry_t is u_sfixed(0 downto -(wave_table_width_g-1));
  type memory_t is array (wave_table_len_g-1 downto 0) of entry_t;

  signal wave_table : memory_t;

  signal ram_addr : natural range 0 to wave_table'length-1;
  signal ram_d    : entry_t;

  -- phase increment register
  signal phase_inc : natural range 0 to 2**phase_bits_g;

  -- phase register
  signal phase : unsigned(phase_bits_g-1 downto 0);

  -- output signal
  signal dds_data : u_sfixed(0 downto -(data_width_g-1));


begin  -- architecture rtl


  -----------------------------------------------------------------------------
  -- RAM

  -- write ram
  ram_wr : process (csi_clk) is
  begin  -- process ram_wr
    if rising_edge(csi_clk) then        -- rising clock edge
      wave_table(to_integer(unsigned(avs_s0_address))) <=
        to_sfixed(avs_s0_writedata(wave_table_width_g-1 downto 0), wave_table(0));
    end if;
  end process ram_wr;

  -- read ram
  ram_rd : process (csi_clk) is
  begin  -- process ram_rd
    if rising_edge(csi_clk) then        -- rising clock edge
      ram_d <= wave_table(ram_addr);
    end if;
  end process ram_rd;

  -----------------------------------------------------------------------------
  -- Avalon MM Slave Port s1
  -- phase increment register
  phase_inc_reg : process (csi_clk, rsi_reset_n) is
  begin  -- process phase_inc_reg
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      phase_inc <= 0;
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if avs_s1_write = '1' then
        phase_inc <= to_integer(unsigned(avs_s1_writedata));
      end if;
    end if;
  end process phase_inc_reg;

  -----------------------------------------------------------------------------
  -- Avalon ST source
  aso_data <= to_slv(dds_data);
  aso_valid <= coe_sample_strobe;

  -----------------------------------------------------------------------------
  -- DDS

  -- calculate next phase
  phase_calc: process (csi_clk, rsi_reset_n) is
  begin  -- process phase_cals
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      phase <= to_unsigned(0, phase'length);
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if coe_sample_strobe = '1' then
        phase <= phase + phase_inc;
      end if;
    end if;
  end process phase_calc;

  -- calculate wave table address from phase
  ram_addr <= to_integer(phase(phase'left downto phase'right + phase_dither_g));

  -- resize data read from ram to size of output data
  dds_data <= resize(ram_d, dds_data'left, dds_data'right);

  -----------------------------------------------------------------------------
  
end architecture rtl;
