-------------------------------------------------------------------------------
-- Title       : Multiply
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Unit Multiply multiplies L and R channel with a factor
-------------------------------------------------------------------------------

architecture Rtl of Multiply is

  ---------------------------------------------------------------------------
  -- Types and constants
  ---------------------------------------------------------------------------
  subtype aMuxSel is std_logic_vector (3 downto 0);
  signal MuxSel : aMuxSel;

  constant cSilence : std_logic_vector(gDataWidth-1 downto 0) := (others => '0');


begin

  -- combinatoric output logic
  out_mux : process(MuxSel, asi_left_data, asi_left_valid, asi_right_data, asi_right_valid) is
    variable L, R : std_logic_vector(gDataWidth-1 downto 0);
  begin  -- process out_mux

    -- mute left channel
    case MuxSel(3) is
      when '0'    => L := asi_left_data;
      when '1'    => L := cSilence;
      when others => L := (others => 'X');
    end case;

    -- mute right channel
    case MuxSel(2) is
      when '0'    => R := asi_right_data;
      when '1'    => R := cSilence;
      when others => R := (others => 'X');
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
            aso_left_data   <= (others => 'X');
            aso_left_valid  <= 'X';
            aso_right_data  <= (others => 'X');
            aso_right_valid <= 'X';
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
            aso_left_data   <= (others => 'X');
            aso_left_valid  <= 'X';
            aso_right_data  <= (others => 'X');
            aso_right_valid <= 'X';
        end case;

      when others =>
        aso_left_data   <= (others => 'X');
        aso_left_valid  <= 'X';
        aso_right_data  <= (others => 'X');
        aso_right_valid <= 'X';

    end case;

  end process out_mux;

  -- MM INTERFACE for configuration
  SetConfigReg : process (csi_clk, rsi_reset_n) is
  begin
    if rsi_reset_n = not('1') then      -- low active reset
      MuxSel <= (others => '0');
    elsif rising_edge(csi_clk) then     -- rising 
      if avs_s0_write = '1' then
        MuxSel <= avs_s0_writedata(MuxSel'range);
      end if;
    end if;
  end process;


end architecture Rtl;
