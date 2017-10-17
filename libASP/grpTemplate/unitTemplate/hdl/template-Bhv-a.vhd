-------------------------------------------------------------------------------
-- Title       : Signal Delay Left and Right
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Unit delays left and right channel independent. Each channel's
--               delay can be configured separately.
-------------------------------------------------------------------------------

architecture Bhv of Delay is

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

    -- Left Channel
    SR_LEFT : entity work.ShiftRegRam
    generic map (
      gMaxDelay     => gMaxDelay,
      gNewDataFreq  => gNewDataFreq,
      gWidth        => gDataWidth
    )
    port map (
      csi_clk              => csi_clk,
      rsi_reset_n          => rsi_reset_n,
      iActualLength        => ConfigReg(0),
      audio_in_valid       => asi_left_valid,
      iData                => asi_left_data,
      audio_out_valid      => aso_left_valid,
      oData                => aso_left_data
    );

end architecture Bhv;
