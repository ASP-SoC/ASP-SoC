---------------------------------------------------------------------*-vhdl-*--
-- File        : PwmGen-e.vhd
-- Description : <short overview about functionality>
--
-------------------------------------------------------------------------------
-- History (yyyy-mm-dd):
-- yyyy-mm-dd last update by firstname lastname
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

use work.Global.all;


entity Flanger is
  port (
    iClk           	: in  std_ulogic;
    inResetAsync 	: in  std_ulogic;
    iStrobe 		: in  std_ulogic;
    iData 			: in  sfixed(-1 downto -24);
    --
    oData 			: out sfixed(-1 downto -24));

end Flanger;
