-------------------------------------------------------------------------------
-- Title       : Direct Digital Synthesis
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : DDS with RAM Table, Table can be defined over MM Interface
-- The Phase Increment and Enable can also be set over an extra MM Interface
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.sin_4096.all;

entity Dds is

  generic (
    -- number of bits for the streaming interface
    data_width_g           : natural := 24;
    -- amount of bits for the phase register
    phase_bits_g           : natural := 20;
    -- phase register dither bist
    phase_dither_g         : natural := 8;
    -- number of bits for the waveform rom entries
    wave_table_width_g     : natural := 14;
    -- number of wave table entries
    wave_table_len_g       : natural := 4096;
    -- number of bits to address the wave table
    -- shoud be log dualis of wave_table_len_g
    wave_table_addr_bits_g : natural := 12
    );

  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- sample strobe
    coe_sample_strobe : in std_logic;

    -- Avalon MM Slave Port s0 - used for dds table
    avs_s0_write     : in std_logic;
    avs_s0_address   : in std_logic_vector(wave_table_addr_bits_g-1 downto 0);
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon MM Slave Port s1 - used for phase increment and enable
    -- not enable also clear the phase register
    -- address + 0 => enable register (1 bit) : '1' => enable, '0' => not enable
    -- address + 1 => phase increment (phase_bits_g bits) => 0 no phase increment
    avs_s1_write     : in std_logic;
    avs_s1_address   : in std_logic;
    avs_s1_writedata : in std_logic_vector(31 downto 0);

    -- Avalon ST source
    aso_data  : out std_logic_vector(data_width_g-1 downto 0);
    aso_valid : out std_logic
    );

end entity Dds;
