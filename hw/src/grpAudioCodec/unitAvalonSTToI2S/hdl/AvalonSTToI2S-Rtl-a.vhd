architecture Rtl of AvalonSTToI2S is

  type aInputState is (Waiting, LeftChannel, RightChannel);
  type aRegion is (Tx, Idle);

  -- bclk set, for sync and delay
  type aSyncSet is record
    Meta : std_logic;
    Sync : std_logic;
    Dlyd : std_logic;
  end record;

  constant cInitValSync : aSyncSet := (
    Meta => '0',
    Sync => '0',
    Dlyd => '0'
    );

  type aRegSet is record
    State               : aInputState;  -- current state
    Region              : aRegion;
    BitIdx              : unsigned(gDataWidthLen-1 downto 0);  -- current bit index in data
    Bclk                : aSyncSet;     -- bclk signals
    Lrc                 : aSyncSet;     -- left or rigth channel
    LeftBuf, LeftData   : std_logic_vector(gDataWidth-1 downto 0);  -- left input data
    RightBuf, RightData : std_logic_vector(gDataWidth-1 downto 0);  -- right input data
  end record;

  constant cInitValR : aRegSet := (
    State     => Waiting,
    Region    => Idle,
    Bclk      => cInitValSync,
    Lrc       => cInitValSync,
    BitIdx    => (others => '0'),
    LeftData  => (others => '0'),
    LeftBuf   => (others => '0'),
    RightData => (others => '0'),
    RightBuf  => (others => '0')
    );

  signal R, NxR : aRegSet;

begin  -- architecture Rtl

  -- register process
  Reg : process(iClk, inReset)
  begin
    -- low active reset
    if inReset = '0' then
      R <= cInitValR;
    -- rising clk edge
    elsif rising_edge(iClk) then
      R <= NxR;
    end if;
  end process;

  Comb : process (R, iLRC, iBCLK, iLeftValid, iRightValid) is
  begin  -- process

    -- default
    NxR <= R;

    -- sync input and delay
    NxR.Bclk.Meta <= iBCLK;
    NxR.Bclk.Sync <= R.Bclk.Meta;
    NxR.Bclk.Dlyd <= R.Bclk.Sync;

    NxR.Lrc.Meta <= iLRC;
    NxR.Lrc.Sync <= R.Lrc.Meta;
    NxR.Lrc.Dlyd <= R.Lrc.Sync;


    -- read right data from stream
    if iRightValid = '1' then
      NxR.RightBuf <= iRightData;       -- read data
    end if;

    -- read left data from stream
    if iLeftValid = '1' then
      NxR.LeftBuf <= iLeftData;         -- read data
    end if;

    if R.State = LeftChannel or R.Region = Idle then
      NxR.RightData <= R.RightBuf;      -- read data
    end if;

    if R.State = RightChannel or R.Region = Idle then
      NxR.LeftData <= R.LeftBuf;        -- read data
    end if;

    case R.State is

      -- waiting for input data
      when Waiting =>
        -- reset bit index to max index
        NxR.BitIdx <= to_unsigned(gDataWidth-1, NxR.BitIdx'length);

        if R.Lrc.Dlyd = '0' and R.Lrc.Sync = '1' then
          -- rising edge on LRC - Left Channel
          NxR.State  <= LeftChannel;
          NxR.Region <= Tx;

        elsif R.Lrc.Dlyd = '1' and R.Lrc.Sync = '0' then
          -- falling edge on LRC - Right Channel
          NxR.State  <= RightChannel;
          NxR.Region <= Tx;
        end if;


      when LeftChannel =>

        case R.Region is
          when Tx =>
            oDAT <= R.LeftData(to_integer(R.BitIdx));

            -- falling edge on BCLK
            if R.Bclk.Dlyd = '1' and R.Bclk.Sync = '0' then
              -- check bit index
              if R.BitIdx = 0 then
                -- end of frame
                NxR.Region <= Idle;
                -- reset bit index to max index
                NxR.BitIdx <= to_unsigned(gDataWidth-1, NxR.BitIdx'length);
              else
                -- decrease bit index
                NxR.BitIdx <= R.BitIdx - 1;
              end if;
            end if;

          when Idle =>
            -- set output DAT to zero
            oDAT <= '0';

            if R.Lrc.Sync = '0' then
              -- Right Channel
              NxR.State  <= RightChannel;
              NxR.Region <= Tx;
            end if;

        end case;

      when RightChannel =>

        case R.Region is
          when Tx =>
            oDAT <= R.RightData(to_integer(R.BitIdx));

            -- falling edge on BCLK
            if R.Bclk.Dlyd = '1' and R.Bclk.Sync = '0' then
              -- check bit index
              if R.BitIdx = 0 then
                -- end of frame
                NxR.Region <= Idle;
                -- reset bit index to max index
                NxR.BitIdx <= to_unsigned(gDataWidth-1, NxR.BitIdx'length);
              else
                -- decrease bit index
                NxR.BitIdx <= R.BitIdx - 1;
              end if;
            end if;

          when Idle =>
            -- set output DAT to zero
            oDAT <= '0';

            if R.Lrc.Sync = '1' then
              -- Right Channel
              NxR.State  <= LeftChannel;
              NxR.Region <= Tx;
            end if;

        end case;

    end case;

  end process;

end architecture Rtl;
