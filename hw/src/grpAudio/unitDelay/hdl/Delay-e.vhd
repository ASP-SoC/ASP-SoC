-------------------------------------------------------------------------------
-- Title      : Signal Delay Left and Right
-------------------------------------------------------------------------------
-- File       : Delay-e.vhd
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Delay is

	generic (
		gMaxDelay    : natural :=   100;    -- [ms] maximum delay (until a value is shifted through)
		gNewDataFreq : natural := 48000;    -- [Hz] frequency, with which new data is stored in the SR
		gDataWidth   : natural :=    24     -- bitwidth of a single register
	);
	port (
		csi_clk          : in  std_logic;   -- clk
		rsi_reset_n      : in  std_logic;   -- low active reset

		-- Avalon MM Slave Port s0 - used to config parameters
		avs_s0_write     : in  std_logic;                      -- write
		avs_s0_address   : in  std_logic_vector( 2 downto 0);  -- address
		avs_s0_writedata : in  std_logic_vector(31 downto 0);  -- writedata
		avs_s0_readdata  : out std_logic_vector(31 downto 0);  -- readdata

		-- Avalon ST sink left and right channel
		asi_left_data  : in std_logic_vector(gDataWidth-1 downto 0);    -- data
		asi_left_valid : in std_logic;                                  -- valid

		asi_right_data  : in std_logic_vector(gDataWidth-1 downto 0);   -- data
		asi_right_valid : in std_logic;                                 -- valid

		-- Avalon ST source left and right channel                      
		aso_left_data  : out std_logic_vector(gDataWidth-1 downto 0);   -- data
		aso_left_valid : out std_logic;                                 -- valid

		aso_right_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
		aso_right_valid : out std_logic                                 -- valid
	);

end entity Delay;
