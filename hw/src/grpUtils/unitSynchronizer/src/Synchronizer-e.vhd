-- snyc an async signal with two flip-flops
library ieee;
use ieee.std_logic_1164.all;

entity Synchronizer is
  generic (
    gRange : natural := 1               -- signal width
    );
  port (
    iClk       : in  std_logic;         -- clk
    inRstAsync : in  std_logic;         -- low active async reset
    iAsync     : in  std_logic_vector(gRange-1 downto 0);  -- async signal
    oSync      : out std_logic_vector(gRange-1 downto 0)   -- sync signal
    );
end;
