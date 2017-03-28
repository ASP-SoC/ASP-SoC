library ieee;
use ieee.std_logic_1164.all;

entity tbSynchronizer is
end;


architecture Bhv of tbSynchronizer is

  -- ------------------------------------------------------
  -- add your code here (signal, constant, ... declaration)
  -- ------------------------------------------------------
  signal Clk          : std_logic := '1';
  signal nRstAsync    : std_logic;
  signal D            : std_logic_vector(0 downto 0);

begin

  DUT: entity work.Synchronizer(Rtl)
    port map (
      iClk       => Clk,
      inRstAsync => nRstAsync,
      iAsync         => D,
      oSync         => open
      );

  Clk <= not Clk after 10 ns; -- T/2 = 10ns; T = 20ns; f = 50 MHz

  TestSequence : process is
  begin
    nRstAsync <= '0';
    wait for 500 ns;
    nRstAsync <= '1';

  -- ------------------
  -- add your code here
  -- ------------------
    D <= (others => '0');
    wait for 100 ns;
    D <= (others => '1');
    wait for 100 ns;
    D <= (others => '0');
    wait for 100 ns;

    wait for 9000 ns;

    wait;
  end process TestSequence;

end;
