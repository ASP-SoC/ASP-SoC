architecture Struct of AudioCodecAvalon is

begin  -- architecture Struct

  -- Avalon ST to I2S
  AvalonSTToI2S_1 : entity work.AvalonSTToI2S
    generic map (
      gDataWidth    => gDataWidth,
      gDataWidthLen => gDataWidthLen)
    port map (
      iClk        => csi_clk,
      inReset     => rsi_reset_n,
      iLRC        => AUD_DACLRCK,
      iBCLK       => AUD_BCLK,
      oDAT        => AUD_DACDAT,
      iLeftData   => asi_left_data,
      iLeftValid  => asi_left_valid,
      iRightData  => asi_right_data,
      iRightValid => asi_right_valid);

  -- I2S to Avalon ST
  I2SToAvalonST_1 : entity work.I2SToAvalonST
    generic map (
      gDataWidth    => gDataWidth,
      gDataWidthLen => gDataWidthLen)
    port map (
      iClk        => csi_clk,
      inReset     => rsi_reset_n,
      iDAT        => AUD_ADCDAT,
      iLRC        => AUD_ADCLRCK,
      iBCLK       => AUD_BCLK,
      oLeftData   => aso_left_data,
      oLeftValid  => aso_left_valid,
      oRightData  => aso_right_data,
      oRightValid => aso_right_valid);


end architecture Struct;
