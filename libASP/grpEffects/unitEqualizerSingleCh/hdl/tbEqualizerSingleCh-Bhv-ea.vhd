-------------------------------------------------------------------------------
-- Title       : Testbench Equalizer Single Channel
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Bandpasses equally distributed on frequency range (10Hz-20kHz)
--               each with a configurable factor
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbEqualizerSingleCh is
end entity tbEqualizerSingleCh;

architecture bhv of tbEqualizerSingleCh is
  ---------------------------------------------------------------------------
  -- Constants
  ---------------------------------------------------------------------------
  constant cDataWidth : natural := 24;
  ---------------------------------------------------------------------------
  -- Signals
  ---------------------------------------------------------------------------
  signal Clk       : std_ulogic := '0';
  signal nReset    : std_ulogic := '0';
  signal s0_write  : std_ulogic;
  signal s0_addr   : std_ulogic_vector( 3 downto 0) := (others => '0');
  signal s0_wrdata : std_ulogic_vector(31 downto 0) := (others => '0');
  signal dryValid  : std_ulogic := '0';
  signal dryData   : std_ulogic_vector(cDataWidth-1 downto 0) := (others => '0');
  signal wetValid  : std_ulogic := '0';
  signal wetData   : std_ulogic_vector(cDataWidth-1 downto 0) := (others => '0');

begin

  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------
  Clk    <= not Clk after 10 ns;
  nReset <= '1' after 100 ns;
  dryValid <= not dryValid after 227 ns; -- ca. 44117 Hz

  ---------------------------------------------------------------------------
  -- Instantiations
  ---------------------------------------------------------------------------
  DUT : entity work.EqualizerSingleCh
    port map (
        csi_clk     => Clk,
        rsi_reset_n => nReset,

       -- Avalon MM Slave Port s0
        avs_s0_write     => s0_write,
        avs_s0_address   => s0_addr,
        avs_s0_writedata => s0_wrdata,

        -- Avalon ST sink
        asi_data  => dryData,
        asi_valid => dryValid,

        -- Avalon ST source
        aso_data  => wetData,
        aso_valid => wetValid
    );

end architecture bhv;
