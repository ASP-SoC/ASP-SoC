-------------------------------------------------------------------------------
-- Title       : Channel Mux
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Unit Mux left and right channel
-------------------------------------------------------------------------------

architecture Rtl of ChannelMux is

  ---------------------------------------------------------------------------
  -- Types and constants
  ---------------------------------------------------------------------------
  subtype aMuxSel is std_logic_vector (3 downto 0);

  constant cSilence : std_logic_vector(gDataWidth-1 downto 0) := (others => '0');

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  signal MuxSel : aMuxSel;


  signal L, R : std_logic_vector(gDataWidth-1 downto 0);

begin

  ---------------------------------------------------------------------------
  -- Output logic
  ---------------------------------------------------------------------------
  out_mux : process(MuxSel, asi_left_data, asi_left_valid, asi_right_data, asi_right_valid) is
  begin  -- process out_mux

    -- mute left channel
    case MuxSel(3) is
      when '0'    => L <= asi_left_data;
      when '1'    => L <= cSilence;
      when others => L <= (others => '-');
    end case;

    -- mute right channel
    case MuxSel(2) is
      when '0'    => R <= asi_right_data;
      when '1'    => R <= cSilence;
      when others => R <= (others => '-');
    end case;

    -- function cross or skip
    case MuxSel(1) is
      -- cross channels
      when '0' =>
        -- cross or straight
        case MuxSel(0) is
          when '0' =>                   -- straight
            aso_left_data   <= L;
            aso_left_valid  <= asi_left_valid;
            aso_right_data  <= R;
            aso_right_valid <= asi_right_valid;
          when '1' =>                   -- cross
            aso_left_data   <= R;
            aso_left_valid  <= asi_right_valid;
            aso_right_data  <= L;
            aso_right_valid <= asi_left_valid;
          when others =>
            aso_left_data   <= (others => '-');
            aso_left_valid  <= '-';
            aso_right_data  <= (others => '-');
            aso_right_valid <= '-';
        end case;

      -- skip channel
      when '1' =>
        -- both L or R
        case MuxSel(0) is
          when '0' =>                   -- both left
            aso_left_data   <= L;
            aso_left_valid  <= asi_left_valid;
            aso_right_data  <= L;
            aso_right_valid <= asi_left_valid;
          when '1' =>                   -- both right
            aso_left_data   <= R;
            aso_left_valid  <= asi_right_valid;
            aso_right_data  <= R;
            aso_right_valid <= asi_right_valid;
          when others =>
            aso_left_data   <= (others => '-');
            aso_left_valid  <= '-';
            aso_right_data  <= (others => '-');
            aso_right_valid <= '-';
        end case;

      when others =>
        aso_left_data   <= (others => '-');
        aso_left_valid  <= '-';
        aso_right_data  <= (others => '-');
        aso_right_valid <= '-';
    end case;



  end process out_mux;


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
        MuxSel <= avs_s0_writedata(MuxSel'range);
      end if;
    end if;
  end process;


end architecture Rtl;
