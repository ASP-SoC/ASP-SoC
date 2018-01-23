-------------------------------------------------------------------------------
-- Title      : Global Project Package
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- Description: Global definitons
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

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

  -- default sample rate
  constant default_sample_rate_c : natural := 44117;
  constant sample_time           : time    := 1 sec / real(default_sample_rate_c);

  -- data width
  -- for streaming interface and audio data
  constant data_width_c : natural := 24;

  -- intern data type for audio signals and coeffs
  subtype audio_data_t is u_sfixed(0 downto -(data_width_c-1));

  -- constant for audio data
  constant silence_c : audio_data_t := (others => '0');
  constant one_c     : audio_data_t := (0      => '0', others => '1');

  ------------------------------------------------------------------------------
  -- Function Definitions
  ------------------------------------------------------------------------------
  -- function log2 returns the logarithm of base 2 as an integer
  function LogDualis(cNumber : natural) return natural;

  function ResizeTruncAbsVal(arg : u_sfixed; size_res : u_sfixed) return sfixed;

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

  function ResizeTruncAbsVal(arg      : u_sfixed;  -- input
                             size_res : u_sfixed)  -- for size only
    return sfixed is

    variable vLSB : u_sfixed(arg'range) := (size_res'right => '1', others => '0');
    variable vTmp : u_sfixed(arg'left + 1 downto arg'right);
    variable vRes : u_sfixed(size_res'range);
  begin

    if (size_res'length < arg'length) and arg(arg'left) = '1' then
      vTmp := arg + vLSB;
    else
      vTmp := '0' & arg;
    end if;

    vRes := resize(vTmp, size_res, fixed_saturate, fixed_truncate);

    return vRes;
  end function;


end Global;
