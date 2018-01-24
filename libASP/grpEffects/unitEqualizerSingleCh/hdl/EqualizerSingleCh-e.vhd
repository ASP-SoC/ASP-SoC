-------------------------------------------------------------------------------
-- Title       : Equalizer Single Channel
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
--               Can only handle a single channel.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Global.all;
use work.PkgEqualizer.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.fixed_float_types.all;

entity EqualizerSingleCh is
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
  );
end entity EqualizerSingleCh;
