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

entity AudiSignalProcessingBlock is

  port (
    clk     : in std_logic;             -- clk
    reset_n : in std_logic;             -- low active reset

    -- audio avalon streaming source - audio output
    -- 23 downto 0      left    channel
    -- 47 downto 24     right   channel
    audio_source_data  : out std_logic_vector(47 downto 0);  -- left and right channel data
    audio_source_valid : out std_logic;  -- left and right channel valid
    audio_source_ready : in  std_logic;  -- left and right channel ready

    -- audio avalon streaming sink - audio input
    -- 23 downto 0      left    channel
    -- 47 downto 24     right   channel
    audio_sink_data  : in  std_logic_vector(47 downto 0);  -- left and right channel data
    audio_sink_valid : in  std_logic;   -- left and right channel valid
    audio_sink_ready : out std_logic;   -- left and right channel ready

    -- memory mapped slave
    avalon_read       : in  std_logic;                      -- read
    avalon_write      : in  std_logic;                      -- write
    avalon_chipselect : in  std_logic;                      -- chipselect
    avalon_writedata  : in  std_logic_vector(31 downto 0);  -- writedata
    avalon_byteenable : in  std_logic_vector(3 downto 0);   -- byteenable
    avalon_readdata   : out std_logic_vector(31 downto 0)   -- readdata

    );

end entity AudiSignalProcessingBlock;
