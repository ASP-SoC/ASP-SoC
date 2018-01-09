-------------------------------------------------------------------------------
-- Title      : Equalizer Project Package
-------------------------------------------------------------------------------
-- Description: Type definitions and filter coefficients for unit Equalizer
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Equalizer is

  constant cNumberOfBands    : natural :=  10;
  constant cFilterCoeffWidth : natural :=  24;
  constant cEQBandpassOrder  : natural := 128;

  subtype aFilterCoeff is u_sfixed(0 downto -(cFilterCoeffWidth-1));
  type aMemory is array (natural range <>) of aFilterCoeff;

  type aEQBandpassSet is array(natural range<>) of aMemory(0 to cEQBandpassOrder);

--  type aEQBandpassSet is record
--    Bandpass0  : aMemory(0 to cEQBandpassOrder);
--    Bandpass1  : aMemory(0 to cEQBandpassOrder);
--    Bandpass2  : aMemory(0 to cEQBandpassOrder);
--    Bandpass3  : aMemory(0 to cEQBandpassOrder);
--    Bandpass4  : aMemory(0 to cEQBandpassOrder);
--    Bandpass5  : aMemory(0 to cEQBandpassOrder);
--    Bandpass6  : aMemory(0 to cEQBandpassOrder);
--    Bandpass7  : aMemory(0 to cEQBandpassOrder);
--    Bandpass8  : aMemory(0 to cEQBandpassOrder);
--    Bandpass9  : aMemory(0 to cEQBandpassOrder);
--  end record;

  constant cCoeffBandpass0 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass1 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass2 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass3 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass4 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass5 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass6 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass7 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass8 : aMemory(0 to cEQBandpassOrder) := (

  );
  constant cCoeffBandpass9 : aMemory(0 to cEQBandpassOrder) := (

  );

  ------------------------------------------------------------------------------
  -- Function Definitions
  ------------------------------------------------------------------------------
  function ResizeTruncAbsVal (
    arg      : u_sfixed;  -- input
    size_res : u_sfixed)  -- for size only
    return sfixed;

end Equalizer;

package body Equalizer is

  function ResizeTruncAbsVal (
    arg : u_sfixed;
	size_res : u_sfixed)
	return sfixed is
	variable lsb : u_sfixed(size_res'range) := (others => '0');
	variable tmp : u_sfixed(size_res'high+1 downto size_res'low) := (others => '0');
  begin
    lsb(lsb'low) := '1';
	tmp(size_res'range) := resize(arg => arg,
										left_index => size_res'high,
										right_index => size_res'low,
										round_style => fixed_truncate,
										overflow_style => fixed_saturate);

    if tmp < 0 and arg > -1 then
	  tmp := tmp(size_res'range) + lsb;
	end if;
	return tmp(size_res'range);
  end function ResizeTruncAbsVal;

end Equalizer;
