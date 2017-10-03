architecture Struct of TbdFIR is

  component Audio is
    port (
      reset_reset_n : in    std_logic := 'X';  -- reset_n
      clk_clk       : in    std_logic := 'X';  -- clk
      audio_clk_clk : out   std_logic;         -- clk
      i2s_adcdat    : in    std_logic := 'X';  -- adcdat
      i2s_adclrck   : in    std_logic := 'X';  -- adclrck
      i2s_bclk      : in    std_logic := 'X';  -- bclk
      i2s_dacdat    : out   std_logic;         -- dacdat
      i2s_daclrck   : in    std_logic := 'X';  -- daclrck
      i2c_SDAT      : inout std_logic := 'X';  -- SDAT
      i2c_SCLK      : out   std_logic          -- SCLK
      );
  end component Audio;

begin  -- architecture Struct

  u0 : component Audio
    port map (
      reset_reset_n => KEY(0),          --     reset.reset_n
      clk_clk       => CLOCK_50,        --       clk.clk
      audio_clk_clk => AUD_XCK,         -- audio_clk.clk
      i2s_adcdat    => AUD_ADCDAT,      --       i2s.adcdat
      i2s_adclrck   => AUD_ADCLRCK,     --          .adclrck
      i2s_bclk      => AUD_BCLK,        --          .bclk
      i2s_dacdat    => AUD_DACDAT,      --          .dacdat
      i2s_daclrck   => AUD_DACLRCK,     --          .daclrck
      i2c_SDAT      => FPGA_I2C_SDAT,   --       i2c.SDAT
      i2c_SCLK      => FPGA_I2C_SCLK    --          .SCLK
      );

end architecture Struct;
