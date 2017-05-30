architecture Rtl of I2SToAvalonST is

  type aInputState is (Waiting, ReceivingSerData);

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
    State    : aInputState;             -- current state
    D        : std_logic_vector(gDataWidth-1 downto 0);  -- data
    BitIdx   : unsigned(gDataWidthLen-1 downto 0);  -- current bit index in data
    Bclk     : aSyncSet;                -- bclk signals
    Lrc      : aSyncSet;                -- left or rigth channel
    LeftVal  : std_logic;               -- left channel valid
    RightVal : std_logic;               -- right channel valid
  end record;

  constant cInitValR : aRegSet := (
    State    => Waiting,
    D        => (others => '0'),
    Bclk     => cInitValSync,
    Lrc      => cInitValSync,
    LeftVal  => '0',
    RightVal => '0',
    BitIdx   => (others => '0')
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

  Comb : process (R, iLRC, iBCLK) is
  begin  -- process

    -- default
    NxR <= R;

    -- reset valid flags
    NxR.LeftVal  <= '0';
    NxR.RightVal <= '0';

    -- sync input and delay
    NxR.Bclk.Meta <= iBCLK;
    NxR.Bclk.Sync <= R.Bclk.Meta;
    NxR.Bclk.Dlyd <= R.Bclk.Sync;

    NxR.Lrc.Meta <= iLRC;
    NxR.Lrc.Sync <= R.Lrc.Meta;
    NxR.Lrc.Dlyd <= R.Lrc.Sync;

    case R.State is

      -- waiting for input data
      when Waiting =>
        -- rising edge on LRC - Left Channel
        if (R.Lrc.Dlyd = '0' and R.Lrc.Sync = '1')
          -- falling edge on LRC - Right Channel
          or (R.Lrc.Dlyd = '1' and R.Lrc.Sync = '0') then

          NxR.BitIdx <= to_unsigned(gDataWidth-1, NxR.BitIdx'length);

          NxR.State <= ReceivingSerData;
        end if;

      when ReceivingSerData =>

        -- read input data
        NxR.D(to_integer(R.BitIdx)) <= iDAT;

        -- rising edge on BCLK
        if R.Bclk.Dlyd = '0' and R.Bclk.Sync = '1' then
          -- check bit index
          if R.BitIdx = 0 then
            -- end of frame
            NxR.State <= Waiting;

            if R.Lrc.Sync = '1' then
              -- left channel valid
              NxR.LeftVal <= '1';
            else
              -- right channel valid
              NxR.RightVal <= '1';
            end if;

          else
            -- decrease bit index
            NxR.BitIdx <= R.BitIdx - 1;
          end if;

        end if;

    end case;

  end process;

  -- output
  oLeftData   <= R.D;
  oLeftValid  <= R.LeftVal;
  oRightData  <= R.D;
  oRightValid <= R.RightVal;

end architecture Rtl;
