architecture Struct of PlatformTbd is

  ------------------------------------------------------------------------------------
  -- intern signals
  ------------------------------------------------------------------------------------
  signal debug     : std_logic_vector(23 downto 0);
  signal nKey1Sync : std_logic_vector(0 downto 0);

  ------------------------------------------------------------------------------------
  -- component
  ------------------------------------------------------------------------------------

  component System is
    port (
      audio_clk_clk         : out   std_logic;                      -- clk
      audio_config_i2c_SDAT : inout std_logic := 'X';               -- SDAT
      audio_config_i2c_SCLK : out   std_logic;                      -- SCLK
      audio_i2s_ADCDAT      : in    std_logic := 'X';               -- ADCDAT
      audio_i2s_ADCLRCK     : in    std_logic := 'X';               -- ADCLRCK
      audio_i2s_BCLK        : in    std_logic := 'X';               -- BCLK
      audio_i2s_DACDAT      : out   std_logic;                      -- DACDAT
      audio_i2s_DACLRCK     : in    std_logic := 'X';               -- DACLRCK
      clk_clk               : in    std_logic := 'X';               -- clk
      reset_reset_n         : in    std_logic := 'X';               -- reset_n
      debug_export          : out   std_logic_vector(23 downto 0);  -- export
      enable_export         : in std_logic := 'X'                -- export
      );
  end component System;


begin  -- architecture Struct

  ------------------------------------------------------------------------------------
  -- DUT

  sys_platform : component System
    port map (
      audio_clk_clk         => AUD_XCK,        --        audio_clk.clk
      audio_config_i2c_SDAT => FPGA_I2C_SDAT,  -- audio_config_i2c.SDAT
      audio_config_i2c_SCLK => FPGA_I2C_SCLK,  --                 .SCLK
      audio_i2s_ADCDAT      => AUD_ADCDAT,     --        audio_i2s.ADCDAT
      audio_i2s_ADCLRCK     => AUD_ADCLRCK,    --                 .ADCLRCK
      audio_i2s_BCLK        => AUD_BCLK,       --                 .BCLK
      audio_i2s_DACDAT      => AUD_DACDAT,     --                 .DACDAT
      audio_i2s_DACLRCK     => AUD_DACLRCK,    --                 .DACLRCK
      clk_clk               => CLOCK_50,       --              clk.clk
      reset_reset_n         => KEY(0),         --            reset.reset_n
      debug_export          => debug,          --            debug.export
      enable_export         => KEY(1)--nKey1Sync(0)    --           enable.export
      );

  ------------------------------------------------------------------------------------
  -- sync key
  ------------------------------------------------------------------------------------
  SyncKey1 : entity work.Synchronizer
    generic map (
      gRange => 1)
    port map (
      iClk       => CLOCK_50,
      inRstAsync => KEY(0),             -- KEY0
      iAsync     => KEY(1 downto 1),    -- KEY1
      oSync      => nKey1Sync);

  ------------------------------------------------------------------------------------
  -- debug pins
  ------------------------------------------------------------------------------------
  GPIO_1(23 downto 0)  <= debug;            -- debug pins
  GPIO_1(35 downto 24) <= (others => '0');  -- GND

end architecture Struct;
