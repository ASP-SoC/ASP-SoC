-------------------------------------------------------------------------------
-- Title       : Signal Delay Left and Right
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Unit delays left and right channel independent. Each channel's
--               delay can be configured separately.
-------------------------------------------------------------------------------

architecture Rtl of Template is

  ---------------------------------------------------------------------------
  -- Wires
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  type aConfigReg is array (0 to 1) of unsigned(31 downto 0);
  signal ConfigReg : aConfigReg := (others => (others => '0'));

begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  aso_left_data   <= asi_left_data;
  aso_left_valid  <= asi_left_valid;
  aso_right_data  <= asi_right_data;
  aso_right_valid <= asi_right_valid;

  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Logic
  ---------------------------------------------------------------------------

  -- MM INTERFACE for configuration
  SetConfigReg : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if avs_s0_write = '1' then
        ConfigReg(to_integer(unsigned(avs_s0_address)))
          <= unsigned(avs_s0_writedata);
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------
  -- Instantiations
  ---------------------------------------------------------------------------


end architecture Rtl;
