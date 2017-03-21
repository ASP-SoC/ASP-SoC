-------------------------------------------------------------------------------
-- Title      : Audio Flanger
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- File       : Flanger-e.vhd
-- Author     : Haberleitner David
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2017-03-07  1.0      Haberleitner    Created
-- 2017-03-08  1.1      Steinbacher     Edited
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

use work.Global.all;

entity Flanger is
  generic (
    gSigLen      : natural := 24;       -- length of the signal
    gRegisterLen : natural := 256);     -- length of the internal register]

  port (
    inResetAsync : in std_ulogic;       -- async low active reset
    iClk         : in std_ulogic;       -- clk
    iEnable      : in std_ulogic;       -- enable audio shift

    iData : in sfixed(-1 downto -gSigLen);  -- audio input

    -- output register selection
    iSelFlangeLen : in unsigned(LogDualis(gRegisterLen)-1 downto 0);

    oData : out sfixed(-1 downto -gSigLen));  -- audio output

end Flanger;
