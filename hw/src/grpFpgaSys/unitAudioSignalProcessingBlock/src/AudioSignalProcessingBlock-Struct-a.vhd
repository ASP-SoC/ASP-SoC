architecture Struct of AudioSignalProcessingBlock is
  -- intern audio signals
  signal channel_left_input, channel_right_input   : std_ulogic_vector(23 downto 0);
  signal channel_left_output, channel_right_output : std_ulogic_vector(23 downto 0);

  signal sfixed_output : sfixed(-1 downto -24);

begin  -- architecture Struct

  SyncProcess : process (clk, reset_n) is
  begin  -- process SyncProcess
    if reset_n = '0' then               -- asynchronous reset (active low)
      channel_left_input  <= (others => '0');
      channel_right_input <= (others => '0');

    elsif rising_edge(clk) then         -- rising clock edge

      if audio_sink_valid = '1' then
        channel_left_input  <= to_stdULogicVector(audio_sink_data(23 downto 0));
        channel_right_input <= to_stdULogicVector(audio_sink_data(47 downto 24));
      end if;

      if audio_source_ready = '1' then
        audio_source_valid <= '1';      -- if sink is ready set valid bit
      else
        audio_source_valid <= '0';
      end if;

    end if;
  end process SyncProcess;

  -- outputs
  audio_sink_ready <= '1';              -- enable stream

  -- audio streaming source
  audio_source_data(23 downto 0)  <= to_stdLogicVector(channel_left_output);
  audio_source_data(47 downto 24) <= to_stdLogicVector(channel_right_output);



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

  --ShiftReg_1 : entity work.ShiftReg
  --  generic map (
  --    gRegLength      => 24,
  --    gShiftRegLength => 1024)
  --  port map (
  --    inResetAsync => reset_n,
  --    iClk         => clk,
  --    iData        => channel_left_input,
  --    iSelOutReg   => (others => '1'),
  --    oData        => channel_left_output);


  --Flanger_1 : entity work.Flanger
  --  generic map (
  --    gSigLen      => 24,
  --    gRegisterLen => 256)
  --  port map (
  --    inResetAsync  => reset_n,
  --    iClk          => clk,
  --    iEnable       => audio_sink_valid,
  --    iData         => to_sfixed(channel_left_input, -1, -24),
  --    iSelFlangeLen => (others => '1'),
  --    oData         => sfixed_output);

  --channel_left_output <= to_sulv(sfixed_output);  -- convert to std_ulogic_vector

  channel_left_output  <= channel_left_input;
  channel_right_output <= channel_right_input;


  -------------------------------------------------------------------------------


end architecture Struct;
