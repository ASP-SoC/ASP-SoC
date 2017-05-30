-------------------------------------------------------------------------------
-- Title      : Audio Signal Processing Block
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- File       : AspBlock-e.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description: Template for a audio signal processing block
--              Avalon streaming interface for audio signal
--              Avalon memory mapped interface for configuration
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-05-16  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

entity AspBlock is
  generic(
    gDataWidth : natural := 24
    );

  port (
    -- clk and reset
    csi_clk     : in std_logic;         -- clk
    rsi_reset_n : in std_logic;         -- low active reset

    -- enable effect, '1' effect on else effect off and signal is passed
    -- without modification
    coe_enable : in std_logic;

    -- debug interface
    coe_debug : out std_logic_vector(23 downto 0);  -- debug vector

    -- Avalon ST source (output data)
    aso_left_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    aso_left_valid : out std_logic;                                -- valid

    aso_right_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    aso_right_valid : out std_logic;                                -- valid

    -- Avalon ST sink (input data)
    asi_left_data  : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    asi_left_valid : in std_logic;                                -- valid

    asi_right_data  : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    asi_right_valid : in std_logic;                                -- valid

    -- Avalon MM Slave Port s0 - provides config parameters
    avs_s0_write     : in  std_logic;                      -- write
    avs_s0_address   : in  std_logic_vector(2 downto 0);   -- address
    avs_s0_writedata : in  std_logic_vector(31 downto 0);  -- writedata
    avs_s0_readdata  : out std_logic_vector(31 downto 0)   -- readdata

    );

end entity AspBlock;
