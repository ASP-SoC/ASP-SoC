architecture Struct of AudioSignalProcessingBlock is
  -- intern audio signals
  signal sfixed_output : sfixed(-1 downto -24);

begin  -- architecture Struct

  -------------------------------------------------------------------------------
  -- ASP-Block instantiation
  -- use signals:
  -- clk                        - clock
  -- reset_n                    - low active async reset
  -- channel_left_input         - left  channel input
  -- channel_right_input        - right channel input
  -- channel_left_output        - left  channel output
  -- channel_right_output       - right channel output
  -------------------------------------------------------------------------------

  Flanger_1 : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 32)
    port map (
      inResetAsync  => reset_n,
      iClk          => clk,
      iEnable       => from_audio_right_channel_valid,
      iData         => to_sfixed(from_audio_right_channel_data, -1, -24),
      iSelFlangeLen => (others => '1'),
      oData         => sfixed_output);

  to_audio_right_channel_data  <= to_slv(sfixed_output);  -- convert to std_ulogic_vector
  to_audio_right_channel_valid <= from_audio_right_channel_valid;


  to_audio_left_channel_data  <= from_audio_left_channel_data;
  to_audio_left_channel_valid <= from_audio_left_channel_valid;

  from_audio_left_channel_ready  <= to_audio_left_channel_ready;
  from_audio_right_channel_ready <= to_audio_right_channel_ready;


  -------------------------------------------------------------------------------


end architecture Struct;
