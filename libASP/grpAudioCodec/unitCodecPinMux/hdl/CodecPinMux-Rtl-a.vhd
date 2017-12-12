

architecture Rtl of CodecPinMux is

    signal config : std_ulogic := '0';

begin

  -- MM INTERFACE for configuration
  SetConfigReg : process (iClk) is
  begin
    if inReset = '0' then
      config <= '0';
    elsif rising_edge(iClk) then
      if avs_s0_write = '1' then
        config <= avs_s0_writedata(0);
      end if;
    end if;
  end process;

  -- from out
  oADCDAT <= iADCDAT_CODEC when config = '0' else iADCDAT_GPIO;
  oADCLRC <= iADCLRC_CODEC when config = '0' else iADCLRC_GPIO;
  oBCLK <= iBCLK_CODEC when config = '0' else iBCLK_GPIO;
  oDACLRC <= iDACLRC_CODEC when config = '0' else iDACLRC_GPIO;
  -- from _in
  oDACDAT_CODEC <= iDACDAT when config = '0' else '0';
  oDACDAT_GPIO <= iDACDAT when config = '1' else '0';
end architecture;