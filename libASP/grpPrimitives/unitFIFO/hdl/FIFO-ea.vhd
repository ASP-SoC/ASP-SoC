-------------------------------------------------------------------------------
-- Title       : FIFO
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : FIFO - memory
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO is

  generic (
    data_width_g : natural := 24;
    depth_g      : natural := 128;
    adr_width_g  : natural := 8);       -- log2(depth_g) - 1

  port (
    clk_i : in std_ulogic;
    rst_i : in std_ulogic;

    wr_i      : in  std_ulogic;         -- write enable
    rd_i      : in  std_ulogic;         -- read enable
    wr_data_i : in  std_ulogic_vector(data_width_g-1 downto 0);
    rd_data_o : out std_ulogic_vector(data_width_g-1 downto 0);

    full_o  : out std_ulogic;
    empty_o : out std_ulogic;

    -- used space
    space_o : out unsigned(adr_width_g-1 downto 0)
    );

end entity FIFO;

architecture Rtl of FIFO is

  type mem_t is array (0 to depth_g-1) of std_ulogic_vector(data_width_g-1 downto 0);
  signal memory : mem_t;

  subtype ptr_t is natural range 0 to depth_g-1;
  signal rd_ptr, wr_ptr : ptr_t;

  signal space       : unsigned(adr_width_g-1 downto 0);
  signal full, empty : std_ulogic;

  signal rd_data : std_ulogic_vector(data_width_g-1 downto 0);

begin  -- architecture Rtl

  -- memory
  wr_mem : process (clk_i) is
  begin
    if rising_edge(clk_i) then
      if wr_i = '1' then
        memory(wr_ptr) <= wr_data_i;
      end if;
    end if;
  end process wr_mem;

  rd_mem : process (clk_i) is
  begin
    if rising_edge(clk_i) then
      rd_data <= memory(rd_ptr);
    end if;
  end process rd_mem;

  -- pointer logic
  ptr_logic : process (clk_i, rst_i) is
    variable used_space : unsigned(adr_width_g-1 downto 0) := to_unsigned(0, adr_width_g);
  begin  -- process ptr_logic
    if rst_i = '0' then                 -- asynchronous reset (active low)
      rd_ptr <= 0;
      wr_ptr <= 0;
      space  <= to_unsigned(0, adr_width_g);
      full   <= '0';
      empty  <= '0';
    elsif rising_edge(clk_i) then       -- rising clock edge

      used_space := space;

      if wr_i = '1' and full = '0' then
        if wr_ptr = depth_g-1 then
          wr_ptr <= 0;
        else
          wr_ptr <= wr_ptr + 1;
        end if;
        used_space := used_space + 1;
      end if;

      if rd_i = '1' and empty = '0' then
        if rd_ptr = depth_g-1 then
          rd_ptr <= 0;
        else
          rd_ptr <= rd_ptr + 1;
        end if;
        used_space := used_space - 1;
      end if;

      space <= used_space;

      if wr_ptr = rd_ptr then
        empty <= '1';
      else
        empty <= '0';
      end if;

      if wr_ptr = (rd_ptr - 1) then
        full <= '1';
      else
        full <= '0';
      end if;


    end if;
  end process ptr_logic;

  -- output used space
  space_o <= space;
  empty_o <= empty;
  full_o  <= full;

  -- if fifo is empty - read silence
  rd_data_o <= rd_data when empty = '0'
               else (others => '0') when empty = '1'
               else (others => 'X');

end architecture Rtl;
