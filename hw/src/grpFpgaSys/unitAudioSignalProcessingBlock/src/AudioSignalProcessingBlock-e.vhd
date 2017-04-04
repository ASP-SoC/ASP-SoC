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

  port (
    -- clk and reset
    clk     : in std_logic;             -- clk
    reset_n : in std_logic;             -- low active reset

    -- enable effect, '1' effect on else effect off and signal is passed
    -- without modification
    iEnable : in std_logic;

    -- debug interface
    oDebug : out std_logic_vector(23 downto 0);  -- debug vector

    -- to audio avalon streaming source
    to_audio_left_channel_data  : out std_logic_vector(23 downto 0);  -- left channel data
    to_audio_left_channel_valid : out std_logic;  -- left channel valid
    --to_audio_left_channel_ready : in  std_logic;  -- left channel ready

    to_audio_right_channel_data  : out std_logic_vector(23 downto 0);  -- right channel data
    to_audio_right_channel_valid : out std_logic;  -- right channel valid
    --to_audio_right_channel_ready : in  std_logic;  -- right channel ready

    -- from audio avalon streaming sink
    from_audio_left_channel_data  : in  std_logic_vector(23 downto 0);  -- left channel data
    from_audio_left_channel_valid : in  std_logic;  -- left channel valid
    --from_audio_left_channel_ready : out std_logic;  -- left channel ready

    from_audio_right_channel_data  : in  std_logic_vector(23 downto 0);  -- right channel data
    from_audio_right_channel_valid : in  std_logic;  -- right channel valid
    --from_audio_right_channel_ready : out std_logic;  -- right channel ready

    -- memory mapped slave
    avalon_read       : in  std_logic;                      -- read
    avalon_write      : in  std_logic;                      -- write
    avalon_chipselect : in  std_logic;                      -- chipselect
    avalon_writedata  : in  std_logic_vector(31 downto 0);  -- writedata
    avalon_byteenable : in  std_logic_vector(3 downto 0);   -- byteenable
    avalon_readdata   : out std_logic_vector(31 downto 0)   -- readdata

    );

end entity AudioSignalProcessingBlock;
