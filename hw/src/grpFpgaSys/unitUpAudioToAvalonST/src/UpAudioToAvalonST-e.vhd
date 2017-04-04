-------------------------------------------------------------------------------
-- Title      : UpAudioToAvalonST
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- File       : UpAudioToAvalonST-e.vhd
-- Author     : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description:
-- 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-04-04  1.0      fxst    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UpAudioToAvalonST is
  generic(
    -- properties
    gDataWidth        : natural := 24;  -- data width
    gMaxChannel       : natural := 2;   -- max channel 
    gChannelPortWidth : natural := 1    -- channel port width
    );

  port (
    -- clk and reset
    clk     : in std_logic;             -- clk
    reset_n : in std_logic;             -- low active reset

    ------------------------------------------------------------------------------------------
    -- Altera UP Audio IP Core ST Interface
    ------------------------------------------------------------------------------------------
    -- to audio avalon ST source
    to_audio_left_channel_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- left channel data
    to_audio_left_channel_valid : out std_logic;  -- left channel valid

    to_audio_right_channel_data  : out std_logic_vector(gDataWidth-1 downto 0);  -- right channel data
    to_audio_right_channel_valid : out std_logic;  -- right channel valid

    -- from audio avalon ST sink
    from_audio_left_channel_data  : in std_logic_vector(gDataWidth-1 downto 0);  -- left channel data
    from_audio_left_channel_valid : in std_logic;  -- left channel valid

    from_audio_right_channel_data  : in std_logic_vector(gDataWidth-1 downto 0);  -- right channel data
    from_audio_right_channel_valid : in std_logic;  -- right channel valid

    ------------------------------------------------------------------------------------------
    -- Avalon ST Interface with channel selection
    ------------------------------------------------------------------------------------------
    -- source
    audio_source_data    : out std_logic_vector(gDataWidth-1 downto 0);
    audio_source_valid   : out std_logic;
    audio_source_channel : out std_logic_vector(gChannelPortWidth-1 downto 0);

    -- sink
    audio_sink_data    : in std_logic_vector(gDataWidth-1 downto 0);
    audio_sink_valid   : in std_logic;
    audio_sink_channel : in std_logic_vector(gChannelPortWidth-1 downto 0)

    );

end entity UpAudioToAvalonST;
