architecture Struct of UpAudioToAvalonST is

  --------------------------------------------------------------------------------------------
  -- source
  type aChannelState is (LEFT_CHANNEL, RIGHT_CHANNEL);

  -- Register structure of design
  type aRegSet is record
    signal DataInputState : aChannelState;
    signal data           : std_logic_vector(gDataWidth-1 downto 0);
    signal valid          : std_logic;
    signal channel        : std_logic;
  end record;

  constant cInitValR : aRegSet := (
    DataInputState => LEFT_CHANNEL,
    data           => (others => '0'),
    valid          => '0',
    channel        => '0'
    );

  -- All registers in design
  signal R, NxR : aRegSet;

  --------------------------------------------------------------------------------------------

  --------------------------------------------------------------------------------------------
  -- sink

  --------------------------------------------------------------------------------------------


begin  -- architecture Struct

  --------------------------------------------------------------------------------------------
  -- source

  StateReg : process (inRstAsync, iClk) is
  begin
    if reset_n = '0' then               -- low active reset
      R <= cInitValR;
    elsif rising_edge(clk) then         -- rising clk edge
      R <= NxR;
    end if;
  end process;

  Combinational : process (State, from_audio_left_channel_valid, from_audio_right_channel_valid)
  begin
    -- default
    NxR       <= R;
    NxR.valid <= '0';

    case R.DataInputState is

      when CHANNEL_LEFT =>
        if from_audio_left_channel_valid <= '1' then
          NxR.data           <= from_audio_left_channel_data;
          NxR.valid          <= '1';
          NxR.channel        <= '0';
          NxR.DataInputState <= CHANNEL_RIGHT;
        end if;

      when CHANNEL_RIGHT =>
        if from_audio_right_channel_valid <= '1' then
          NxR.data           <= from_audio_right_channel_data;
          NxR.valid          <= '1';
          NxR.channel        <= '1';
          NxR.DataInputState <= CHANNEL_LEFT;
        end if;

      when others => null;
    end case;
  end process;

  -- connect registers to ports
  audio_source_valid   <= R.valid;
  audio_source_data    <= R.data;
  audio_source_channel <= R.channel;

  --------------------------------------------------------------------------------------------


end architecture Struct;
