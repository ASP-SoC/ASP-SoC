
module Audio (
	audio_clk_clk,
	clk_clk,
	i2c_SDAT,
	i2c_SCLK,
	i2s_adcdat,
	i2s_adclrck,
	i2s_bclk,
	i2s_dacdat,
	i2s_daclrck,
	reset_reset_n);	

	output		audio_clk_clk;
	input		clk_clk;
	inout		i2c_SDAT;
	output		i2c_SCLK;
	input		i2s_adcdat;
	input		i2s_adclrck;
	input		i2s_bclk;
	output		i2s_dacdat;
	input		i2s_daclrck;
	input		reset_reset_n;
endmodule
