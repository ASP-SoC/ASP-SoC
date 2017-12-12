-------------------------------------------------------------------------------
-- Title       : Avalon Valid Extractor
-- Author      : David Haberleitner
-------------------------------------------------------------------------------
-- Description : Provide valid signal as avalon and also as conduit
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ValidExtractor is
  generic (
    -- stream data width
    data_width_g : natural := 24);
  port (
    csi_clk     : in std_logic;
    rsi_reset_n : in std_logic;

    asi_valid : in std_logic;
    asi_data  : in std_logic_vector(data_width_g-1 downto 0);

    aso_valid : out std_logic;
    aso_data  : out std_logic_vector(data_width_g-1 downto 0);

    coe_sample_strobe : out std_logic
    );

end entity ValidExtractor;

architecture Rtl of ValidExtractor is

begin  -- architecture Rtl

  aso_valid <= asi_valid;
  aso_data  <= asi_data;

  coe_sample_strobe <= asi_valid;

end architecture Rtl;
