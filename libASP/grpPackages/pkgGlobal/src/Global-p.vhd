-------------------------------------------------------------------------------
-- Title      : Global Project Package
-- Project    :
-- $Id: $
-------------------------------------------------------------------------------
-- Description:
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Global is
  -----------------------------------------------------------------------------
  -- Definitions that are not project specific.
  -----------------------------------------------------------------------------
  -- Avoid the traps of inverted logic and make the code more text like by
  -- reducing numbers.
  constant cActivated   : std_ulogic := '1';
  constant cInactivated : std_ulogic := '0';

  -- Now the same for inverted logic.
  constant cnActivated   : std_ulogic := '0';
  constant cnInactivated : std_ulogic := '1';

  -- constants for generic parameter gEdgeDetector
  constant cDetectRisingEdge  : natural := 0;
  constant cDetectFallingEdge : natural := 1;
  constant cDetectAnyEdge     : natural := 2;

  -----------------------------------------------------------------------------
  -- Project specific definitions that will typically exist for every project.
  -----------------------------------------------------------------------------
  -- Reset polarity
  -- This constant is not used in this project. Instead a low active reset
  -- is used.
  constant cResetActive : std_ulogic := cnActivated;

  -- fract_real
  subtype fract_real is real range
    -1.0 to 0.99999999999999999999999999999999999999999999999999999999999999999;

  type fract_set_t is array (natural range<>) of fract_real;

  constant default_sample_rate_c : natural := 44117;

  ------------------------------------------------------------------------------
  -- Function Definitions
  ------------------------------------------------------------------------------
  -- function log2 returns the logarithm of base 2 as an integer
  function LogDualis(cNumber : natural) return natural;

end Global;


package body Global is

  -- Function LogDualis returns the logarithm of base 2 as an integer.
  -- Although the implementation of this function was not done with synthesis
  -- efficiency in mind, the function has to be synthesizable, because it is
  -- often used in static calculations.
  function LogDualis(cNumber : natural) return natural is
    -- Initialize explicitly (will have warnings for uninitialized variables
    -- from Quartus synthesis otherwise).
    variable vClimbUp : natural := 1;
    variable vResult  : natural := 0;
  begin
    while vClimbUp < cNumber loop
      vClimbUp := vClimbUp * 2;
      vResult  := vResult+1;
    end loop;
    return vResult;
  end LogDualis;


end Global;
