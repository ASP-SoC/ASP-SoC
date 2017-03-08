-------------------------------------------------------------------------------
-- Title      : Testbench for design "StrobeGen"
-- Project    : General IP
-------------------------------------------------------------------------------
-- Author     : Copyright 2013: Markus Pfaff, Friedrich Seebacher
--                              
-- Standard   : Using VHDL'93
-- Simulation : Model Technology Modelsim
-- Synthesis  : Quartus II
-------------------------------------------------------------------------------
-- Description:
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

use work.Global.all;

--------------------------------------------------------------------------------

entity tbStrobeGen is

end entity tbStrobeGen;

--------------------------------------------------------------------------------

architecture Bhv of tbStrobeGen is

  -- constant definition
  constant cClkFrequency               : natural := 50E6;      -- 50 MHz
  constant cInResetDuration            : time    := 140 ns;
  -- component generics
  constant cNrClkCycles                : natural := 50;        -- 1 us 


  -- component ports
  signal Clk         : std_ulogic := cInactivated;
  signal nResetAsync : std_ulogic := cnInactivated;
  signal Strobe      : std_ulogic;

begin  -- architecture Bhv

  -- component instantiation
  DUT : entity work.StrobeGen
    generic map (
      gNrClkCycles => cNrClkCycles)
    port map (
      iClk         => Clk,
      inResetAsync => nResetAsync,
      oStrobe      => Strobe);

  Clk <= not Clk after (1 sec / cClkFrequency) / 2;

  nResetAsync <= cnInactivated after 0 ns,
                 cnActivated   after cInResetDuration,
                 cnInactivated after 2*cInResetDuration;


  -- Process to measure the frequency of the strobe signal and the
  -- active strobe time.
  DetermineStrobeFreq : process
    variable vHighLevel : boolean := false;
    variable vTimestamp : time := 0 sec;
  begin
    wait until (Strobe'event);
    if Strobe = '1' then
      vHighLevel := true;
      if now > vTimestamp then
        assert false
          report "Frequency Value (Strobe) = " &
                 integer'image((1 sec / (now-vTimestamp))) &
                 "Hz; Period (Strobe) = " &
                 time'image(now-vTimestamp)
          severity note;
	    end if;
      vTimestamp := now;
    elsif vHighLevel and Strobe = '0' and
          ((now-vTimestamp)<(1 sec / cClkFrequency)) then
      assert false
        report "Strobe Active Time: " & time'image(now-vTimestamp) & "; " &
               "Clock Cycle time: " & time'image((1 sec / cClkFrequency))
        severity error;
	  end if;

  end process DetermineStrobeFreq;

  -- Simulation is finished after predefined time.
  SimulationFinished : process
  begin
    wait for (10 sec / cClkFrequency)*cNrClkCycles;
    assert false
      report "This is not a failure: Simulation finished !!!"
      severity failure;
  end process SimulationFinished;
  
end architecture Bhv;
