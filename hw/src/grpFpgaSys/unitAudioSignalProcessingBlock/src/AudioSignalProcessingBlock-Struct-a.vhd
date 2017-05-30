architecture Struct of AudioSignalProcessingBlock is

  -- local register declarations
  type aRegSet is record
    FlangerLength : std_logic_vector(31 downto 0);
  end record;

  constant cInitValR : aRegSet := (
    FlangerLength => (others => '0')
    );

  signal reg_set : aRegSet;

  -- intern audio signals
  signal sfixed_output_right : sfixed(-1 downto -24);
  signal sfixed_output_left  : sfixed(-1 downto -24);
  signal sample_strobe_right : std_ulogic;
  signal sample_strobe_left  : std_ulogic;
  signal strobe_right_valid  : std_ulogic;
  signal strobe_left_valid   : std_ulogic;

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
  readability : process (avs_s0_address, reg_set) is
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
  -- sample_strobe_right        - right sample strobe
  -- sample_strobe_left         - left sample strobe
  -------------------------------------------------------------------------------

  -- generate strobes
  sample_strobe_right <= asi_valid when asi_channel = '1' else '0';
  sample_strobe_left  <= asi_valid when asi_channel = '0' else '0';

  --Flanger_right : entity work.Flanger
  --  generic map (
  --    gSigLen      => 24,
  --    gRegisterLen => 64)
  --  port map (
  --    inResetAsync  => rsi_reset_n,
  --    iClk          => csi_clk,
  --    iValid        => sample_strobe_right,
  --    iData         => to_sfixed(asi_data, -1, -24),
  --    iSelFlangeLen => unsigned(reg_set.FlangerLength(5 downto 0)),
  --    oValid        => strobe_right_valid,
  --    oData         => sfixed_output_right);

  --Flanger_left : entity work.Flanger
  --  generic map (
  --    gSigLen      => 24,
  --    gRegisterLen => 64)
  --  port map (
  --    inResetAsync  => rsi_reset_n,
  --    iClk          => csi_clk,
  --    iValid        => sample_strobe_left,
  --    iData         => to_sfixed(asi_data, -1, -24),
  --    iSelFlangeLen => unsigned(reg_set.FlangerLength(5 downto 0)),
  --    oValid        => strobe_left_valid,
  --    oData         => sfixed_output_left);

  -- output
  --aso_data <= to_slv(sfixed_output_right) when iEnable = '1' and strobe_right_valid = '1'  -- convert to std_ulogic_vector
  --            else to_slv(sfixed_output_left) when iEnable = '1' and strobe_left_valid = '1'  -- convert to std_ulogic_vector
  --            else (others => '0') when iEnable = '1'
  --            else asi_data;

  --aso_valid <= strobe_right_valid when iEnable = '1' and strobe_right_valid = '1'
  --             else strobe_left_valid when iEnable = '1' and strobe_left_valid = '1'
  --             else '0' when iEnable = '1'
  --             else asi_valid;

  --aso_channel <= '1' when strobe_right_valid = '1'
  --               else asi_channel when iEnable = '0'
  --               else '0';  -- channel selection

  --aso_data <= asi_data when iEnable = '0'
  --            else (others => '0');

  --aso_valid <= asi_valid when iEnable = '0'
    --           else '0';

  --aso_channel <= asi_channel when iEnable = '0'
  --               else '0';

  aso_data    <= asi_data;
  aso_valid   <= asi_valid;
  aso_channel <= asi_channel;


  -- debug
  oDebug(0) <= asi_channel;
  oDebug(1) <= asi_valid;
  oDebug(2) <= sample_strobe_right;
  oDebug(3) <= sample_strobe_left;

  oDebug(6) <= csi_clk;
  oDebug(7) <= rsi_reset_n;


  -------------------------------------------------------------------------------


end architecture Struct;
