-------------------------------------------------------------------------------
-- Title      : Signal Delay Left and Right
-------------------------------------------------------------------------------
-- File       : Delay-Bhv-a.vhd
-- Author     : Michael Wurm
-------------------------------------------------------------------------------
-- Description: Unit delays left and right channel independent. Each channels
--              delay can be configured separately.
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author    Description
-- 2017-06-06  1.0      MikeW     Created
-------------------------------------------------------------------------------

architecture Bhv of Delay is

	constant cDelayLeftReg  : natural := 0;
	constant cDelayRightReg : natural := 1;
	
	type aConfigReg is array (0 to 1) of unsigned(31 downto 0);
	signal ConfigReg : aConfigReg := (others=> (others=>'0'));

begin

  ------- MM INTERFACE for delay config -------
  SetConfigReg : process (csi_clk) is
  begin
	if rising_edge(csi_clk) then 
		if avs_s0_write = '1' then
			ConfigReg(to_integer(unsigned(avs_s0_address)))
				<= unsigned(avs_s0_writedata);
		end if;
	end if;	
  end process;
  ----------------------------------------------
  
  ------- COMPONENT INSTANTIATION shiftreg -----

  -- Left Channel 
  SR_LEFT : entity work.ShiftRegRam
    generic map (
	  gMaxDelay     => gMaxDelay,
	  gNewDataFreq  => gNewDataFreq,
	  gWidth        => gDataWidth
	)
	port map (
	  csi_clk              => csi_clk,
	  rsi_reset_n          => rsi_reset_n,
	  iActualLength        => ConfigReg(cDelayLeftReg),
	  audio_in_valid       => asi_left_valid,
	  iData                => asi_left_data,
	  audio_out_valid      => aso_left_valid,
	  oData                => aso_left_data
	);
	
  -- Right Channel 
  SR_RIGHT : entity work.ShiftRegRam
    generic map (
	  gMaxDelay     => gMaxDelay,
	  gNewDataFreq  => gNewDataFreq,
	  gWidth        => gDataWidth
	)
	port map (
	  csi_clk              => csi_clk,
	  rsi_reset_n          => rsi_reset_n,
	  iActualLength        => ConfigReg(cDelayRightReg),
	  audio_in_valid       => asi_right_valid,
	  iData                => asi_right_data,
	  audio_out_valid      => aso_right_valid,
	  oData                => aso_right_data
	);
	
  ----------------------------------------------

end architecture Bhv;
