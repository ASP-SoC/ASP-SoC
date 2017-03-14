library ieee;
use ieee.std_logic_1164.all;

entity TbdAudio is
  port(
    Clock_50 : in std_logic;            -- clk
    KEY0      : in std_logic  -- KEY0 as as low active async reset
    );
end entity TbdAudio;
