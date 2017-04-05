architecture Struct of AudioSignalProcessingBlock is
  -- intern audio signals
  signal sfixed_output_right : sfixed(-1 downto -24);
  signal sfixed_output_left  : sfixed(-1 downto -24);
  signal sample_strobe_right : std_ulogic;
  signal sample_strobe_left  : std_ulogic;
  signal strobe_right_valid  : std_ulogic;
  signal strobe_left_valid   : std_ulogic;

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
  sample_strobe_right <= sink_valid when sink_channel = '1' else '0';
  sample_strobe_left  <= sink_valid when sink_channel = '0' else '0';

  Flanger_right : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 4096)
    port map (
      inResetAsync  => reset_n,
      iClk          => clk,
      iValid        => sample_strobe_right,
      iData         => to_sfixed(sink_data, -1, -24),
      iSelFlangeLen => (others => '1'),
      oValid        => strobe_right_valid,
      oData         => sfixed_output_right);

  Flanger_left : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 4096)
    port map (
      inResetAsync  => reset_n,
      iClk          => clk,
      iValid        => sample_strobe_left,
      iData         => to_sfixed(sink_data, -1, -24),
      iSelFlangeLen => (others => '1'),
      oValid        => strobe_left_valid,
      oData         => sfixed_output_left);

  -- output
  source_data <= to_slv(sfixed_output_right) when iEnable = '1' and strobe_right_valid = '1'  -- convert to std_ulogic_vector
                 else to_slv(sfixed_output_left) when iEnable = '1' and strobe_left_valid = '1'  -- convert to std_ulogic_vector
                 else sink_data;

  source_valid <= strobe_right_valid when iEnable = '1' and strobe_right_valid = '1'
                  else strobe_left_valid when iEnable = '1' and strobe_left_valid = '1'
                  else sink_valid;

  source_channel <= '1' when strobe_right_valid = '1' else '0';  -- channel selection

  --source_data    <= sink_data;
  --source_valid   <= sink_valid;
  --source_channel <= sink_channel;

  -- debug
  oDebug(0) <= sink_channel;
  oDebug(1) <= sink_valid;
  oDebug(2) <= sample_strobe_right;
  oDebug(3) <= sample_strobe_left;

  oDebug(6) <= clk;
  oDebug(7) <= reset_n;


  -------------------------------------------------------------------------------


end architecture Struct;
