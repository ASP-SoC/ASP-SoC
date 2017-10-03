	component Audio is
		port (
			audio_clk_clk : out   std_logic;        -- clk
			clk_clk       : in    std_logic := 'X'; -- clk
			i2c_SDAT      : inout std_logic := 'X'; -- SDAT
			i2c_SCLK      : out   std_logic;        -- SCLK
			i2s_adcdat    : in    std_logic := 'X'; -- adcdat
			i2s_adclrck   : in    std_logic := 'X'; -- adclrck
			i2s_bclk      : in    std_logic := 'X'; -- bclk
			i2s_dacdat    : out   std_logic;        -- dacdat
			i2s_daclrck   : in    std_logic := 'X'; -- daclrck
			reset_reset_n : in    std_logic := 'X'  -- reset_n
		);
	end component Audio;

	u0 : component Audio
		port map (
			audio_clk_clk => CONNECTED_TO_audio_clk_clk, -- audio_clk.clk
			clk_clk       => CONNECTED_TO_clk_clk,       --       clk.clk
			i2c_SDAT      => CONNECTED_TO_i2c_SDAT,      --       i2c.SDAT
			i2c_SCLK      => CONNECTED_TO_i2c_SCLK,      --          .SCLK
			i2s_adcdat    => CONNECTED_TO_i2s_adcdat,    --       i2s.adcdat
			i2s_adclrck   => CONNECTED_TO_i2s_adclrck,   --          .adclrck
			i2s_bclk      => CONNECTED_TO_i2s_bclk,      --          .bclk
			i2s_dacdat    => CONNECTED_TO_i2s_dacdat,    --          .dacdat
			i2s_daclrck   => CONNECTED_TO_i2s_daclrck,   --          .daclrck
			reset_reset_n => CONNECTED_TO_reset_reset_n  --     reset.reset_n
		);

