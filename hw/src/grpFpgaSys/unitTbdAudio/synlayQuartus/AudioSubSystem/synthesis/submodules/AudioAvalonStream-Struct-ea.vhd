-------------------------------------------------------------------------------
-- Title      : Audio Avalon Stream Interface
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- File       : AudioAvalonStream-Struct-ea.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description: Avalon Streaming Component for intel_fpga qsys
--              the interface converts the 4 streams (left & right source/sink)
--              from the audio codec to 2 streams (source and sink)
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-03-14  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity AudioAvalonStream is

  port (
    clk   : in std_logic;               -- clk
    reset : in std_logic;               -- reset

    -- to audio avalon streaming source
    to_audio_left_channel_data  : out std_logic_vector(23 downto 0);  -- left channel data
    to_audio_left_channel_valid : out std_logic;  -- left channel valid
    to_audio_left_channel_ready : in  std_logic;  -- left channel ready

    to_audio_right_channel_data  : out std_logic_vector(23 downto 0);  -- right channel data
    to_audio_right_channel_valid : out std_logic;  -- right channel valid
    to_audio_right_channel_ready : in  std_logic;  -- right channel ready

    -- from audio avalon streaming sink
    from_audio_left_channel_data  : in  std_logic_vector(23 downto 0);  -- left channel data
    from_audio_left_channel_valid : in  std_logic;  -- left channel valid
    from_audio_left_channel_ready : out std_logic;  -- left channel ready

    from_audio_right_channel_data  : in  std_logic_vector(23 downto 0);  -- right channel data
    from_audio_right_channel_valid : in  std_logic;  -- right channel valid
    from_audio_right_channel_ready : out std_logic;  -- right channel ready

    -- audio avalon streaming source - signal from audio codec
    audio_source_data  : out std_logic_vector(47 downto 0);  -- left and right channel data
    audio_source_valid : out std_logic;  -- left and right channel valid
    audio_source_ready : in  std_logic;  -- left and right channel ready

    -- audio avalon streaming sink - signal to audio codec
    audio_sink_data  : in  std_logic_vector(47 downto 0);  -- left and right channel data
    audio_sink_valid : in  std_logic;   -- left and right channel valid
    audio_sink_ready : out std_logic    -- left and right channel ready

    );

end entity AudioAvalonStream;

architecture Struct of AudioAvalonStream is

begin  -- architecture Struct

  -- audio sink
  to_audio_left_channel_data   <= audio_sink_data(23 downto 0);
  to_audio_left_channel_valid  <= audio_sink_valid;
  to_audio_right_channel_data  <= audio_sink_data(47 downto 24);
  to_audio_right_channel_valid <= audio_sink_valid;
  audio_sink_ready             <= to_audio_left_channel_ready and to_audio_right_channel_ready;

  -- audio source
  audio_source_data(23 downto 0)  <= from_audio_left_channel_data;
  audio_source_data(47 downto 24) <= from_audio_right_channel_data;
  audio_source_valid              <= from_audio_left_channel_valid and from_audio_right_channel_valid;
  from_audio_left_channel_ready   <= audio_source_ready;
  from_audio_right_channel_ready  <= audio_source_ready;

end architecture Struct;
