-------------------------------------------------------------------------------
-- Title       : Equalizer
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
-------------------------------------------------------------------------------

--
-- THIS UNIX MUST BE INSTANTIATED TWICE IN A WRAPPER UNIT
--
-- BECAUSE ENTITY Equalizer ONLY HANDLES A SINGLE CHANNEL
--
-- INTERFACE TEMPLATE SEE END OF THIS FILE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Global.all;
use work.PkgEqualizer.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.fixed_float_types.all;

entity Equalizer is
  generic (
      gDataWidth : natural := 24;       -- bitwidth of a single register
      gBPCoeff   : aEQBandpassSet := (  -- filter coefficients
          0  => (cCoeffBandpass0),
          1  => (cCoeffBandpass1),
          2  => (cCoeffBandpass2),
          3  => (cCoeffBandpass3),
          4  => (cCoeffBandpass4),
          5  => (cCoeffBandpass5),
          6  => (cCoeffBandpass6),
          7  => (cCoeffBandpass7),
          8  => (cCoeffBandpass8),
          9  => (cCoeffBandpass9))
  );
  port (
      csi_clk          : in  std_logic;
      rsi_reset_n      : in  std_logic;

      -- Avalon MM Slave Port s0 - used for config parameters
      avs_s0_write     : in  std_logic;
      avs_s0_address   : in  std_logic_vector( 2 downto 0);
      avs_s0_writedata : in  std_logic_vector(31 downto 0);

      -- Avalon ST sink, single channel
      asi_data   : in std_logic_vector(gDataWidth-1 downto 0);
      asi_valid  : in std_logic;

      -- Avalon ST source, single channel
      aso_data   : out std_logic_vector(gDataWidth-1 downto 0);
      aso_valid  : out std_logic

-- INTERFACE THAT WRAPPER UNIT MUST PROVIDE:
--      -- Avalon ST sink left and right channel
--      asi_left_data   : in std_logic_vector(gDataWidth-1 downto 0);
--      asi_left_valid  : in std_logic;
--      asi_right_data  : in std_logic_vector(gDataWidth-1 downto 0);
--      asi_right_valid : in std_logic;
--
--      -- Avalon ST source left and right channel
--      aso_left_data   : out std_logic_vector(gDataWidth-1 downto 0);
--      aso_left_valid  : out std_logic;
--      aso_right_data  : out std_logic_vector(gDataWidth-1 downto 0);
--      aso_right_valid : out std_logic
  );
end entity Equalizer;
