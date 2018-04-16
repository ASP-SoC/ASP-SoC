-------------------------------------------------------------------------------
-- Title       : Equalizer
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
--               Handles two channels, left and right.
-------------------------------------------------------------------------------

architecture Rtl of Equalizer is
  ---------------------------------------------------------------------------
  -- Types
  ---------------------------------------------------------------------------
  type aRegister is record
    justAValue : std_ulogic;
  end record aRegister;

  constant cInitFirParam : aRegister := ( justAValue => '0' );

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  signal R   : aRegister := cInitFirParam;
  signal nxR : aRegister := cInitFirParam;

  ---------------------------------------------------------------------------
  -- Wires
  ---------------------------------------------------------------------------
  signal left_data   : std_ulogic_vector(aso_left_data'range);
  signal left_valid  : std_ulogic;
  signal right_data  : std_ulogic_vector(aso_right_data'range);
  signal right_valid : std_ulogic;

begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  aso_left_data   <= left_data;
  aso_left_valid  <= left_valid;
  aso_right_data  <= right_data;
  aso_right_valid <= right_valid;

  ---------------------------------------------------------------------------
  -- Instantiations
  ---------------------------------------------------------------------------
  -- left channel
  LeftEqInst : entity work.EqualizerSingleCh
    port map (
        csi_clk     => csi_clk,
        rsi_reset_n => rsi_reset_n,

       -- Avalon MM Slave Port s0
        avs_s0_write     => avs_s0_write,
        avs_s0_address   => avs_s0_address,
        avs_s0_writedata => avs_s0_writedata,

        -- Avalon ST sink
        asi_data  => asi_left_data,
        asi_valid => asi_left_valid,

        -- Avalon ST source
        aso_data  => left_data,
        aso_valid => left_valid
    );

  -- right channel
  RightEqInst : entity work.EqualizerSingleCh
    port map (
        csi_clk     => csi_clk,
        rsi_reset_n => rsi_reset_n,

       -- Avalon MM Slave Port s0
        avs_s0_write     => avs_s0_write,
        avs_s0_address   => avs_s0_address,
        avs_s0_writedata => avs_s0_writedata,

        -- Avalon ST sink
        asi_data  => asi_right_data,
        asi_valid => asi_right_valid,

        -- Avalon ST source
        aso_data  => right_data,
        aso_valid => right_valid
    );

  ---------------------------------------------------------------------------
  -- Memory processes
  ---------------------------------------------------------------------------
  -- Register process
  Reg : process (csi_clk, rsi_reset_n) is
  begin
    if (rsi_reset_n = cResetActive) then
      R <= cInitFirParam;
    elsif rising_edge(csi_clk) then
      R <= nxR;
    end if;
  end process Reg;

end architecture Rtl;
