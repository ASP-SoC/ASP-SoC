-------------------------------------------------------------------------------
-- Title       : Direct Digital Synthesis
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : DDS with RAM Table, Table can be defined over MM Interface
-- The Phase Incremen can also be set over an extra MM Interface
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dds is
  generic (
    
    );

  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- sample strobe
    coe_sample_strobe : in std_logic;

    -- Avalon MM Slave Port s0 - used for dds table
    avs_s0_write     : in std_logic;
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon MM Slave Port s1 - used for phase increment
    avs_s0_write     : in std_logic;
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon ST source
    aso_data  : out std_logic_vector(gDataWidth-1 downto 0);
    aso_valid : out std_logic
    );
  
end entity Dds;
