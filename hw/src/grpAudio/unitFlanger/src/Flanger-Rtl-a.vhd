-------------------------------------------------------------------------------
-- Title      : Audio Flanger
-- Project    : ASP-SoC
-------------------------------------------------------------------------------
-- File       : Flanger-Rtl-a.vhd
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

architecture Rtl of Flanger is

  type aInternReg is array (gRegisterLen downto 0) of sfixed(-1 downto -gSigLen);
  signal intern_register : aInternReg;  -- intern shift register
  signal sum             : sfixed(0 downto -gSigLen);  -- sum of two signals, 1 bigger than the signals

  constant cIntern_regZero : aInternReg := (others => (others => '0'));

begin  -- Rtl

  Flanger : process(inResetAsync, iClk)
  begin

    if inResetAsync = not '1' then         -- async low active reset
      intern_register <= cIntern_regZero;  -- reset intern reg
      sum             <= (others => '0');  -- reset sum

    elsif rising_edge(iClk) then
      if iEnable = '1' then             -- shift register
        intern_register(0) <= iData;

        for i in 1 to gRegisterLen loop  -- shift data through the internal registers
          intern_register(i) <= intern_register(i-1);
        end loop;

      end if;

      -- sum
      sum <= (intern_register(to_integer(iSelFlangeLen)) + iData);
    end if;

  end process;  -- Flanger



  -- output
  oData <= sum(0 downto -(gSigLen-1));  -- divide sum by two


end architecture Rtl;
