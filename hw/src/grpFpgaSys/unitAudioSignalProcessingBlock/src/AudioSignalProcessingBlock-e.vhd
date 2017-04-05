-------------------------------------------------------------------------------
-- Title      : Audio Signal Processing Block
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- File       : AudioSignalProcessingBlock-e.vhd
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
-- 2017-03-14  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

entity AudioSignalProcessingBlock is
  generic(
    gDataWidth : natural := 24
    );

  port (
    -- clk and reset
    clk     : in std_logic;             -- clk
    reset_n : in std_logic;             -- low active reset

    -- enable effect, '1' effect on else effect off and signal is passed
    -- without modification
    iEnable : in std_logic;

    -- debug interface
    oDebug : out std_logic_vector(23 downto 0);  -- debug vector

    -- Avalon ST source
    source_data    : out std_logic_vector(gDataWidth-1 downto 0);  -- data
    source_valid   : out std_logic;                                -- valid
    source_channel : out std_logic;                                -- channel

    -- Avalon ST sink
    sink_data    : in std_logic_vector(gDataWidth-1 downto 0);  -- data
    sink_valid   : in std_logic;                                -- valid
    sink_channel : in std_logic;                                -- channel

    -- memory mapped slave
    avalon_read       : in  std_logic;                      -- read
    avalon_write      : in  std_logic;                      -- write
    avalon_chipselect : in  std_logic;                      -- chipselect
    avalon_writedata  : in  std_logic_vector(31 downto 0);  -- writedata
    avalon_byteenable : in  std_logic_vector(3 downto 0);   -- byteenable
    avalon_readdata   : out std_logic_vector(31 downto 0)   -- readdata

    );

end entity AudioSignalProcessingBlock;
