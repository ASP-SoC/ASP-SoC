architecture Struct of TbdAudio is

  component AudioSubSystem is
    port (
      clk_clk               : in    std_logic := 'X';  -- clk
      reset_reset_n         : in    std_logic := 'X';  -- reset_n
      audio_config_i2c_SDAT : inout std_logic := 'X';  -- SDAT
      audio_config_i2c_SCLK : out   std_logic;         -- SCLK
      audio_i2s_ADCDAT      : in    std_logic := 'X';  -- ADCDAT
      audio_i2s_ADCLRCK     : in    std_logic := 'X';  -- ADCLRCK
      audio_i2s_BCLK        : in    std_logic := 'X';  -- BCLK
      audio_i2s_DACDAT      : out   std_logic;         -- DACDAT
      audio_i2s_DACLRCK     : in    std_logic := 'X';  -- DACLRCK
      audio_clk_clk         : out   std_logic          -- clk
      );
  end component AudioSubSystem;


begin  -- architecture Struct

  --AudioSystem : entity work.AudioSubSystem
  --  port map (
  --    clk_clk       => Clock_50,
  --    reset_reset_n => KEY(0)
  --    );

  u0 : component AudioSubSystem
    port map (
      clk_clk               => CLOCK_50,       --              clk.clk
      reset_reset_n         => KEY0,           --            reset.reset_n
      audio_config_i2c_SDAT => FPGA_I2C_SDAT,  -- audio_config_i2c.SDAT
      audio_config_i2c_SCLK => FPGA_I2C_SCLK,  --                 .SCLK
      audio_i2s_ADCDAT      => AUD_ADCDAT,     --        audio_i2s.ADCDAT
      audio_i2s_ADCLRCK     => AUD_ADCLRCK,    --                 .ADCLRCK
      audio_i2s_BCLK        => AUD_BCLK,       --                 .BCLK
      audio_i2s_DACDAT      => AUD_DACDAT,     --                 .DACDAT
      audio_i2s_DACLRCK     => AUD_DACLRCK,    --                 .DACLRCK
      audio_clk_clk         => AUD_XCK
      );

end architecture Struct;
