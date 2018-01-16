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
  subtype audio_data_t is sfixed(0 downto -(data_width_g-1));

  constant silence_c : audio_data_t := (others => '0');

  signal left_fact  : audio_data_t;
  signal right_fact : audio_data_t;

  signal left_data, right_data : audio_data_t;

  signal right_buf         : audio_data_t;
  signal right_buf_pending : std_ulogic;

  signal fact      : audio_data_t;
  signal mult_data : audio_data_t;
  signal mult_res  : audio_data_t;

begin

  -- register process
  reg : process (csi_clk, rsi_reset_n) is
  begin  -- process calc
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      right_buf         <= silence_c;
      right_buf_pending <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if asi_left_valid = '1' and asi_right_valid = '1' then
        right_buf         <= to_sfixed(asi_right_data, 0, -(data_width_g-1));
        right_buf_pending <= '1';
      else
        right_buf_pending <= '0';
      end if;
    end if;
  end process reg;

  -- calc process
  calc : process (asi_left_valid, asi_left_data, asi_right_data, asi_right_valid, mult_res, left_fact, right_fact, right_buf) is
  begin  -- process calc

    -- default
    aso_left_data   <= (others => '0');
    aso_right_data  <= (others => '0');
    aso_left_valid  <= '0';
    aso_right_valid <= '0';

    fact      <= left_fact;
    mult_data <= to_sfixed(asi_left_data, 0, -(data_width_g-1));

    if asi_left_valid = '1' then
      aso_left_valid <= '1';
      aso_left_data  <= to_slv(mult_res);

    elsif asi_right_valid = '1' then
      aso_right_valid <= '1';
      fact            <= right_fact;
      mult_data       <= to_sfixed(asi_right_data, 0, -(data_width_g-1));
      aso_right_data  <= to_slv(mult_res);

    elsif right_buf_pending = '1' then
      aso_right_valid <= '1';
      fact            <= right_fact;
      mult_data       <= right_buf;
      aso_right_data  <= to_slv(mult_res);

    end if;

  end process calc;

  mult : process (fact, mult_data) is
  begin  -- process mult
    mult_res <= resize(mult_data * fact, 0, -(data_width_g-1));
  end process mult;

  
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
        factor := to_sfixed(avs_s0_writedata(data_width_g-1 downto 0), 0, -(data_width_g-1));
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
