-------------------------------------------------------------------------------
-- Title       : FIR - Filter
-- Author      : Franz Steinbacher, Michael Wurm
-------------------------------------------------------------------------------
-- Description : Finite Impule Response Filter with Avalon MM interface for
-- coeffs configuration.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.Global.all;

entity FirFilter is

  generic (
    -- audio data width
    data_width_g       : natural := 24;
    -- number of coeffs
    coeff_num_g        : natural := 16;
    -- log dualis of coeff_num_g
    coeff_addr_width_g : natural := 4
    );

  port (
    -- Sequential logic inside this unit
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- Avalon MM Slave Port s0 - used for filter coeffs
    avs_s0_write     : in std_logic;
    avs_s0_address   : in std_logic_vector(coeff_addr_width_g-1 downto 0);
    avs_s0_writedata : in std_logic_vector(31 downto 0);

    -- Avalon MM Slave Port s1 - used for enable
    -- enable register width = 1 bit
    -- '0' - pass input to output
    -- '1' - filter enabled
    avs_s1_write     : in std_logic;
    avs_s1_writedata : in std_logic_vector(31 downto 0);

    -- Avalon ST sink
    asi_valid : in std_logic;
    asi_data  : in std_logic_vector(data_width_g-1 downto 0);

    -- Avalon ST source
    aso_valid : out std_logic;
    aso_data  : out std_logic_vector(data_width_g-1 downto 0)

    );

end entity FirFilter;
