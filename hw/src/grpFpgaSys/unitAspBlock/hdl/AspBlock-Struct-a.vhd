architecture Struct of AspBlock is

  -- local register declarations
  type aRegSet is record
    FlangerLength : std_logic_vector(31 downto 0);
  end record;

  constant cInitValR : aRegSet := (
    FlangerLength => (others => '0')
    );

  signal reg_set : aRegSet;

  -- intern audio signals
  signal right_out       : sfixed(-1 downto -24);
  signal left_out        : sfixed(-1 downto -24);
  signal right_out_valid : std_ulogic;
  signal left_out_valid  : std_ulogic;

begin  -- architecture Struct

  -- Avalon MM Slave Port s0

  -- purpose: provide clearability & writeability to registerset
  reg : process (csi_clk, rsi_reset_n) is
  begin  -- process reg
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      reg_set <= cInitValR;
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if avs_s0_write = '1' then
        case avs_s0_address is
          when "000"  => reg_set.FlangerLength <= avs_s0_writedata;
          when others => reg_set.FlangerLength <= avs_s0_writedata;
        end case;
      end if;
    end if;
  end process reg;

  -- purpose: provide readability to all registers
  -- type   : combinational
  -- inputs : avs_s0_address
  -- outputs: avs_s0_readdata
  readability : process (avs_s0_address) is
  begin  -- process
    case avs_s0_address is
      when "000"  => avs_s0_readdata <= reg_set.FlangerLength;
      when others => avs_s0_readdata <= reg_set.FlangerLength;
    end case;
  end process;

  -------------------------------------------------------------------------------
  -- ASP-Block instantiation
  -- use signals:
  -- clk                        - clock
  -- reset_n                    - low active async reset
  -------------------------------------------------------------------------------

  Flanger_right : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 64)
    port map (
      inResetAsync  => rsi_reset_n,
      iClk          => csi_clk,
      iValid        => asi_right_valid,
      iData         => to_sfixed(asi_right_data, -1, -24),
      iSelFlangeLen => unsigned(reg_set.FlangerLength(5 downto 0)),
      oValid        => right_out_valid,
      oData         => right_out);

  Flanger_left : entity work.Flanger
    generic map (
      gSigLen      => 24,
      gRegisterLen => 64)
    port map (
      inResetAsync  => rsi_reset_n,
      iClk          => csi_clk,
      iValid        => asi_left_valid,
      iData         => to_sfixed(asi_left_data, -1, -24),
      iSelFlangeLen => unsigned(reg_set.FlangerLength(5 downto 0)),
      oValid        => left_out_valid,
      oData         => left_out);

  -- output

  aso_left_data <= to_slv(left_out) when coe_enable = '1'
                   else asi_left_data;
  aso_left_valid <= left_out_valid when coe_enable = '1'
                    else asi_left_valid;

  aso_right_data <= to_slv(right_out) when coe_enable = '1'
                    else asi_right_data;
  aso_right_valid <= right_out_valid when coe_enable = '1'
                     else asi_right_valid;

  --aso_left_data <= to_slv(left_out);
  --aso_left_valid <= left_out_valid;

  --aso_right_data <= to_slv(right_out);
  --aso_right_valid <= right_out_valid;

  --aso_left_data  <= asi_left_data;
  --aso_left_valid <= asi_left_valid;

  --aso_right_data  <= to_slv(right_out);
  --aso_right_valid <= right_out_valid;


  -- debug

  coe_debug(6) <= csi_clk;
  coe_debug(7) <= rsi_reset_n;


  -------------------------------------------------------------------------------

end architecture Struct;
