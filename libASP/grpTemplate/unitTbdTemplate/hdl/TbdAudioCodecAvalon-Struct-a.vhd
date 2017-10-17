-------------------------------------------------------------------------------
-- Title       : Audio Codec Avalon
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Top Level Entity Testbed, Audio Codec Avalon
-------------------------------------------------------------------------------

architecture Struct of TbdAudioCodecAvalon is

  component Audio is
    port (
      reset_reset_n : in    std_logic := 'X';
      clk_clk       : in    std_logic := 'X';
      audio_clk_clk : out   std_logic;
      i2s_adcdat    : in    std_logic := 'X';
      i2s_adclrck   : in    std_logic := 'X';
      i2s_bclk      : in    std_logic := 'X';
      i2s_dacdat    : out   std_logic;
      i2s_daclrck   : in    std_logic := 'X';
      i2c_SDAT      : inout std_logic := 'X';
      i2c_SCLK      : out   std_logic
      );
  end component Audio;

begin

  u0 : component Audio
    port map (
      reset_reset_n => KEY(0),
      clk_clk       => CLOCK_50,
      audio_clk_clk => AUD_XCK,
      i2s_adcdat    => AUD_ADCDAT,
      i2s_adclrck   => AUD_ADCLRCK,
      i2s_bclk      => AUD_BCLK,
      i2s_dacdat    => AUD_DACDAT,
      i2s_daclrck   => AUD_DACLRCK,
      i2c_SDAT      => FPGA_I2C_SDAT,
      i2c_SCLK      => FPGA_I2C_SCLK
      );

end architecture Struct;
