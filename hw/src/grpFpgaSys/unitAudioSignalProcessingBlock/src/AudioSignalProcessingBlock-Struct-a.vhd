architecture Struct of AudioSignalProcessingBlock is
  -- intern audio signals
  signal sfixed_output_right : sfixed(-1 downto -24);
  signal sfixed_output_left  : sfixed(-1 downto -24);
  signal sample_strobe_right : std_ulogic;
  signal sample_strobe_left  : std_ulogic;

begin  -- architecture Struct

  -------------------------------------------------------------------------------
  -- ASP-Block instantiation
  -- use signals:
  -- clk                        - clock
  -- reset_n                    - low active async reset
  -- sample_strobe_right        - right sample strobe
  -- sample_strobe_left         - left sample strobe
  -------------------------------------------------------------------------------

  -- generate strobes
  sample_strobe_right <= to_audio_right_channel_ready; --and from_audio_right_channel_valid;
  sample_strobe_left  <= to_audio_left_channel_ready; -- and from_audio_left_channel_valid;

  Flanger_right : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 1024)
    port map (
      inResetAsync  => reset_n,
      iClk          => clk,
      iEnable       => sample_strobe_right,  --from_audio_right_channel_valid,
      iData         => to_sfixed(from_audio_right_channel_data, -1, -24),
      iSelFlangeLen => (others => '1'),
      oData         => sfixed_output_right);

  -- right channel output
  to_audio_right_channel_data  <= to_slv(sfixed_output_right) when iEnable = '1'  -- convert to std_ulogic_vector
                                  else from_audio_right_channel_data; 
  to_audio_right_channel_valid <= sample_strobe_right;  --from_audio_right_channel_valid;

  Flanger_left : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 1024)
    port map (
      inResetAsync  => reset_n,
      iClk          => clk,
      iEnable       => sample_strobe_left,
      iData         => to_sfixed(from_audio_left_channel_data, -1, -24),
      iSelFlangeLen => (others => '1'),
      oData         => sfixed_output_left);

  -- left channel output
  to_audio_left_channel_data  <= to_slv(sfixed_output_left) when iEnable = '1' -- convert to std_ulogic_vector
                                 else from_audio_left_channel_data;  
  to_audio_left_channel_valid <= sample_strobe_left;  --from_audio_left_channel_valid;

  --to_audio_left_channel_data  <= std_logic_vector(signed(from_audio_left_channel_data) / 1);
  --to_audio_left_channel_valid <= from_audio_left_channel_valid;

  -- map ready signal from sink to source
  from_audio_left_channel_ready  <= to_audio_left_channel_ready;
  from_audio_right_channel_ready <= to_audio_right_channel_ready;

  -- debug
  oDebug(0) <= to_audio_right_channel_ready;
  oDebug(1) <= from_audio_right_channel_valid;
  oDebug(2) <= sample_strobe_right;

  oDebug(3) <= to_audio_left_channel_ready;
  oDebug(4) <= from_audio_left_channel_valid;
  oDebug(5) <= sample_strobe_left;

  oDebug(6) <= clk;
  oDebug(7) <= reset_n;


  -------------------------------------------------------------------------------


end architecture Struct;
