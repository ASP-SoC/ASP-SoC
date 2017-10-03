	Audio u0 (
		.audio_clk_clk (<connected-to-audio_clk_clk>), // audio_clk.clk
		.clk_clk       (<connected-to-clk_clk>),       //       clk.clk
		.i2c_SDAT      (<connected-to-i2c_SDAT>),      //       i2c.SDAT
		.i2c_SCLK      (<connected-to-i2c_SCLK>),      //          .SCLK
		.i2s_adcdat    (<connected-to-i2s_adcdat>),    //       i2s.adcdat
		.i2s_adclrck   (<connected-to-i2s_adclrck>),   //          .adclrck
		.i2s_bclk      (<connected-to-i2s_bclk>),      //          .bclk
		.i2s_dacdat    (<connected-to-i2s_dacdat>),    //          .dacdat
		.i2s_daclrck   (<connected-to-i2s_daclrck>),   //          .daclrck
		.reset_reset_n (<connected-to-reset_reset_n>)  //     reset.reset_n
	);

