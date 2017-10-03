library ieee;
use ieee.std_logic_1164.all;
--use ieee.fixed_pkg.all;


library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
 
package pkgFIR is

-- ************************************************************
-- filter constants
-- ************************************************************
constant cOrder      : natural := 11;  -- order of the filter
constant cBitRange   : natural := 24; -- bit range of input data
--constant cCoeffRange : natural := 8;  -- number of coefficients

--*************************************************************
-- constants fro activating and deactivating std_ulogic flags
--*************************************************************
constant cActivated 	: std_ulogic := '1';
constant cInactivated 	: std_ulogic := '0';
constant cnActivated 	: std_ulogic := '0';
constant cnInactivated 	: std_ulogic := '1';

type CoeffArray is array (0 to cOrder - 1) of sfixed(-1 downto -24);

--typedef for coefficients (b[] = nominator, a[] = denominator)
--for a FIR only b[] is neccessary

end package;