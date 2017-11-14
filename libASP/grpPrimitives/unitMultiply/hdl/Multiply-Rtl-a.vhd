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
  subtype audio_data_t is sfixed(0 downto -(gDataWidth-1));

  constant silence_c : audio_data_t := (others => '0');

  signal left_fact  : audio_data_t;
  signal right_fact : audio_data_t;

  signal left_data, right_data : audio_data_t;

  signal right_buf : audio_data_t;
  signal right_valid_pending : std_ulogic;

begin

  calc : process (csi_clk, rsi_reset_n) is
  begin  -- process calc
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      right_buf <= silence_c;
      right_valid_pending <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge

      right_valid_pending <= '0';
      
      
    end if;
  end process calc;


  -- MM INTERFACE for configuration
  SetConfigReg : process (csi_clk, rsi_reset_n) is
    variable factor : audio_data_t := silence_c;
  begin
    if rsi_reset_n = not('1') then      -- low active reset
      left_fact  <= silence_c;
      right_fact <= silence_c;
    elsif rising_edge(csi_clk) then     -- rising 
      if avs_s0_write = '1' then
        -- convert std_logic_vector to sfixed
        factor := to_sfixed(avs_s0_writedata(gDataWidth-1 downto 0), 0, -(gDataWidth-1));
        case avs_s0_address is
          when '0' =>                   -- factor of left channel
            left_fact <= factor;
          when '1' =>                   -- factor of right channel
            right_fact <= factor;
          when others => null;
        end case;
      end if;
    end if;
  end process;


end architecture Rtl;
