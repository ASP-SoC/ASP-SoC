-------------------------------------------------------------------------------
-- Title       : Avalon MM to Avalon ST
-- Author      : Franz Steinbacher
-------------------------------------------------------------------------------
-- Description : Memory Mapped Slave to Avalon Streaming with Left and Right Channel
--               Used to stream audio data from the soc linux t the fpga
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MMtoST is

  generic (
    data_width_g     : natural := 24;
    fifo_depth_g     : natural := 128;
    fifo_adr_width_g : natural := 8     -- log2(fifo_depth_g) , at least 4
    );

  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    -- memory mapped interface s0
    avs_s0_chipselect : in  std_logic;
    avs_s0_write      : in  std_logic;
    avs_s0_read       : in  std_logic;
    avs_s0_address    : in  std_logic_vector(1 downto 0);
    avs_s0_writedata  : in  std_logic_vector(31 downto 0);
    avs_s0_readdata   : out std_logic_vector(31 downto 0);

    -- interrupt sender
    irs_irq : out std_logic;

    -- avalon streaming left and right channel
    asi_left_valid  : in std_logic;
    asi_left_data   : in std_logic_vector(data_width_g-1 downto 0);
    asi_right_valid : in std_logic;
    asi_right_data  : in std_logic_vector(data_width_g-1 downto 0);

    aso_left_valid  : out std_logic;
    aso_left_data   : out std_logic_vector(data_width_g-1 downto 0);
    aso_right_valid : out std_logic;
    aso_right_data  : out std_logic_vector(data_width_g-1 downto 0)
    );

end entity MMtoST;

architecture Rtl of MMtoST is

  -- audio in registers
  signal read_interrupt_en : std_ulogic;
  signal clear_read_fifos  : std_ulogic;
  signal read_interrupt    : std_ulogic;

  -- audio out registers
  signal write_interrupt_en : std_ulogic;
  signal clear_write_fifos  : std_ulogic;
  signal write_interrupt    : std_ulogic;

  -- fifospace registers
  signal left_channel_read_available  : unsigned(fifo_adr_width_g-1 downto 0);
  signal right_channel_read_available : unsigned(fifo_adr_width_g-1 downto 0);

  signal left_channel_write_space  : unsigned(fifo_adr_width_g-1 downto 0);
  signal right_channel_write_space : unsigned(fifo_adr_width_g-1 downto 0);

  -- audio signal
  signal new_left_channel_audio  : std_logic_vector(data_width_g-1 downto 0);
  signal new_right_channel_audio : std_logic_vector(data_width_g-1 downto 0);

  -- read and write strobes
  signal rd_left  : std_ulogic;
  signal rd_right : std_ulogic;
  signal wr_left  : std_ulogic;
  signal wr_right : std_ulogic;

  -- address constants
  constant control_c   : std_logic_vector(1 downto 0) := "00";
  constant fifospace_c : std_logic_vector(1 downto 0) := "01";
  constant leftdata_c  : std_logic_vector(1 downto 0) := "10";
  constant rightdata_c : std_logic_vector(1 downto 0) := "11";

begin  -- architecture Rtl

  -- interrupt sender register
  irq_reg : process (csi_clk, rsi_reset_n) is
  begin  -- process irq_reg
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      irs_irq <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge
      irs_irq <= read_interrupt or write_interrupt;
    end if;
  end process irq_reg;

  -- memory mapped read
  mm_read : process (csi_clk, rsi_reset_n) is
  begin  -- process mm_read
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      avs_s0_readdata <= (others => '0');

    elsif rising_edge(csi_clk) then     -- rising clock edge
      if avs_s0_chipselect = '1' then
        -- default
        avs_s0_readdata <= (others => '0');

        -- select address
        case avs_s0_address is

          when control_c =>
            avs_s0_readdata(31 downto 10) <= (others => '-');
            avs_s0_readdata(9)            <= write_interrupt;
            avs_s0_readdata(8)            <= read_interrupt;
            avs_s0_readdata(7 downto 4)   <= (others => '-');
            avs_s0_readdata(3)            <= clear_write_fifos;
            avs_s0_readdata(2)            <= clear_read_fifos;
            avs_s0_readdata(1)            <= write_interrupt_en;
            avs_s0_readdata(0)            <= read_interrupt_en;

          when fifospace_c =>
            avs_s0_readdata(31 downto 24) <= std_logic_vector(left_channel_write_space);
            avs_s0_readdata(23 downto 16) <= std_logic_vector(right_channel_write_space);
            avs_s0_readdata(15 downto 8)  <= std_logic_vector(left_channel_read_available);
            avs_s0_readdata(7 downto 0)   <= std_logic_vector(right_channel_read_available);

          when leftdata_c =>
            avs_s0_readdata(data_width_g-1 downto 0) <= new_left_channel_audio;

          when rightdata_c =>
            avs_s0_readdata(data_width_g-1 downto 0) <= new_right_channel_audio;

          when others =>
            avs_s0_readdata <= (others => 'X');
        end case;
      else
        avs_s0_readdata <= (others => '0');
      end if;
    end if;
  end process mm_read;

  -- memory mapped write
  mm_write : process (csi_clk, rsi_reset_n) is
  begin  -- process mm_write
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      read_interrupt_en  <= '0';
      write_interrupt_en <= '0';
      clear_read_fifos   <= '0';
      clear_write_fifos  <= '0';

    elsif rising_edge(csi_clk) then     -- rising clock edge
      if avs_s0_chipselect = '1' and avs_s0_write = '1' then
        case avs_s0_address is
          when control_c =>
            read_interrupt_en  <= avs_s0_writedata(0);
            write_interrupt_en <= avs_s0_writedata(1);
            clear_read_fifos   <= avs_s0_writedata(2);
            clear_write_fifos  <= avs_s0_writedata(3);

          when leftdata_c =>

          when rightdata_c =>

          when others => null;
        end case;
      end if;

    end if;
  end process mm_write;

  -- interrupt behavior
  -- irq is set when the fifo is filled to 75% or more
  -- when less it will be cleared
  irq_bhv : process (csi_clk, rsi_reset_n) is
  begin  -- process irq_bhv
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      read_interrupt  <= '0';
      write_interrupt <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge

      -- read interrupt
      if read_interrupt_en = '1' then
        read_interrupt <= left_channel_read_available(fifo_adr_width_g-1)
                          or (left_channel_read_available(fifo_adr_width_g-2) and left_channel_read_available(fifo_adr_width_g-3))
                          or right_channel_read_available(fifo_adr_width_g-1)
                          or (right_channel_read_available(fifo_adr_width_g-2) and right_channel_read_available(fifo_adr_width_g-3));
      else
        read_interrupt <= '0';
      end if;

      -- write interrupt
      if write_interrupt_en = '1' then
        write_interrupt <= left_channel_write_space(fifo_adr_width_g-1)
                           or (left_channel_write_space(fifo_adr_width_g-2) and left_channel_write_space(fifo_adr_width_g-3))
                           or right_channel_write_space(fifo_adr_width_g-1)
                           or (right_channel_write_space(fifo_adr_width_g-2) and right_channel_write_space(fifo_adr_width_g-3));
      else
        write_interrupt <= '0';
      end if;

    end if;
  end process irq_bhv;


  -- combinatoric logic for read and write strobe
  rd_wr_stb : process is
  begin  -- process rd_wr_stb
    rd_left  <= '0';
    rd_right <= '0';
    wr_left  <= '0';
    wr_right <= '0';

    if avs_s0_chipselect = '1' then
      case avs_s0_address is

        when leftdata_c =>
          if avs_s0_read = '1' then
            rd_left <= '1';
          end if;

          if avs_s0_write = '1' then
            wr_left <= '1';
          end if;

        when rightdata_c =>
          if avs_s0_read = '1' then
            rd_right <= '1';
          end if;

          if avs_s0_write = '1' then
            wr_right <= '1';
          end if;

        when others => null;
      end case;
    end if;

  end process rd_wr_stb;


  -- st -> MM fifo
  asi_left_fifo : entity work.FIFO
    generic map (
      data_width_g => data_width_g,
      depth_g      => fifo_depth_g,
      adr_width_g  => fifo_adr_width_g)
    port map (
      clk_i     => csi_clk,
      rst_i     => rsi_reset_n,
      wr_i      => asi_left_valid,
      rd_i      => rd_left,
      wr_data_i => to_StduLogicVector(asi_left_data),
      rd_data_o => to_stdulogicvector(new_left_channel_audio),
      full_o    => open,
      empty_o   => open,
      space_o   => left_channel_read_available);

  -- st -> MM fifo
  asi_right_fifo : entity work.FIFO
    generic map (
      data_width_g => data_width_g,
      depth_g      => fifo_depth_g,
      adr_width_g  => fifo_adr_width_g)
    port map (
      clk_i     => csi_clk,
      rst_i     => rsi_reset_n,
      wr_i      => asi_right_valid,
      rd_i      => rd_right,
      wr_data_i => to_StduLogicVector(asi_right_data),
      rd_data_o => to_stdulogicvector(new_left_channel_audio),
      full_o    => open,
      empty_o   => open,
      space_o   => right_channel_read_available);

  -- MM -> st fifo
  aso_left_fifo : entity work.FIFO
    generic map (
      data_width_g => data_width_g,
      depth_g      => fifo_depth_g,
      adr_width_g  => fifo_adr_width_g)
    port map (
      clk_i     => csi_clk,
      rst_i     => rsi_reset_n,
      wr_i      => wr_left,
      rd_i      => asi_left_valid,
      wr_data_i => to_stdulogicvector(avs_s0_writedata(data_width_g-1 downto 0)),
      rd_data_o => to_stdulogicvector(aso_left_data),
      full_o    => open,
      empty_o   => open,
      space_o   => left_channel_write_space);

  -- MM -> st fifo
  aso_right_fifo : entity work.FIFO
    generic map (
      data_width_g => data_width_g,
      depth_g      => fifo_depth_g,
      adr_width_g  => fifo_adr_width_g)
    port map (
      clk_i     => csi_clk,
      rst_i     => rsi_reset_n,
      wr_i      => wr_right,
      rd_i      => asi_right_valid,
      wr_data_i => to_stdulogicvector(avs_s0_writedata(data_width_g-1 downto 0)),
      rd_data_o => to_stdulogicvector(aso_right_data),
      full_o    => open,
      empty_o   => open,
      space_o   => right_channel_write_space);

  -- delay valid with one clk cycle, because read needs one clk cycle
  dly_valid : process (csi_clk, rsi_reset_n) is
  begin  -- process dly_valid
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      aso_left_valid  <= '0';
      aso_right_valid <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge
      aso_left_valid  <= asi_left_valid;
      aso_right_valid <= asi_right_valid;
    end if;
  end process dly_valid;

end architecture Rtl;
