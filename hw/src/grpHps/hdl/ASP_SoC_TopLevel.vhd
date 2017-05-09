-- #############################################################################
-- DE1_SoC_top_level.vhd
--
-- BOARD         : DE1-SoC from Terasic
-- Author        : Sahand Kashani-Akhavan from Terasic documentation
-- Revision      : 1.5
-- Creation date : 04/02/2015
--
-- Syntax Rule : GROUP_NAME_N[bit]
--
-- GROUP  : specify a particular interface (ex: SDR_)
-- NAME   : signal name (ex: CONFIG, D, ...)
-- bit    : signal index
-- _N     : to specify an active-low signal
-- #############################################################################

library ieee;
use ieee.std_logic_1164.all;

entity ASP_SoC_TopLevel is
    port(

        -- CLOCK
        CLOCK_50         : in    std_logic;

        -- LED
        LEDR             : out   std_logic_vector(7 downto 0);

		  -- KEY
		  KEY					 : in		std_logic_vector(3 downto 0);
		
        -- SWITCHES
		
        SW               : in    std_logic_vector(7 downto 0);

        -- HPS
        HPS_DDR3_ADDR    : out   std_logic_vector(14 downto 0);
        HPS_DDR3_BA      : out   std_logic_vector(2 downto 0);
        HPS_DDR3_CAS_N   : out   std_logic;
        HPS_DDR3_CK_N    : out   std_logic;
        HPS_DDR3_CK_P    : out   std_logic;
        HPS_DDR3_CKE     : out   std_logic;
        HPS_DDR3_CS_N    : out   std_logic;
        HPS_DDR3_DM      : out   std_logic_vector(3 downto 0);
        HPS_DDR3_DQ      : inout std_logic_vector(31 downto 0);
        HPS_DDR3_DQS_N   : inout std_logic_vector(3 downto 0);
        HPS_DDR3_DQS_P   : inout std_logic_vector(3 downto 0);
        HPS_DDR3_ODT     : out   std_logic;
        HPS_DDR3_RAS_N   : out   std_logic;
        HPS_DDR3_RESET_N : out   std_logic;
        HPS_DDR3_RZQ     : in    std_logic;
        HPS_DDR3_WE_N    : out   std_logic;
        HPS_KEY_N        : inout std_logic;
        HPS_LED          : inout std_logic
    );
end entity ASP_SoC_TopLevel;

architecture rtl of ASP_SoC_TopLevel is

    component ASP_SoC_HPS is
		port (
			clk_clk                        : in    std_logic                     := 'X';             -- clk
			reset_reset_n                  : in    std_logic                     := 'X';             -- reset_n
			memory_mem_a                   : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                  : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                  : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                 : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n               : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n               : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n             : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                  : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                 : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                 : out   std_logic;                                        -- mem_odt
			memory_mem_dm                  : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin               : in    std_logic                     := 'X';             -- oct_rzqin
			hps_io_hps_io_gpio_inst_GPIO53 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
			hps_io_hps_io_gpio_inst_GPIO54 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
			switches_external_export       : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			leds_external_export           : out   std_logic_vector(7 downto 0)                      -- export
		);
	end component ASP_SoC_HPS;
begin
    u0 : component ASP_SoC_HPS
        port map (
            clk_clk                             => CLOCK_50,                             --                          clk.clk
            reset_reset_n                       => KEY(0),                       --                        reset.reset_n
            memory_mem_a                        => HPS_DDR3_ADDR,                        --                       memory.mem_a
            memory_mem_ba                       => HPS_DDR3_BA,                       --                             .mem_ba
            memory_mem_ck                       => HPS_DDR3_CK_P,                       --                             .mem_ck
            memory_mem_ck_n                     => HPS_DDR3_CK_N,                     --                             .mem_ck_n
            memory_mem_cke                      => HPS_DDR3_CKE,                      --                             .mem_cke
            memory_mem_cs_n                     => HPS_DDR3_CS_N,                     --                             .mem_cs_n
            memory_mem_ras_n                    => HPS_DDR3_RAS_N,                    --                             .mem_ras_n
            memory_mem_cas_n                    => HPS_DDR3_CAS_N,                    --                             .mem_cas_n
            memory_mem_we_n                     => HPS_DDR3_WE_N,                     --                             .mem_we_n
            memory_mem_reset_n                  => HPS_DDR3_RESET_N,                  --                             .mem_reset_n
            memory_mem_dq                       => HPS_DDR3_DQ,                       --                             .mem_dq
            memory_mem_dqs                      => HPS_DDR3_DQS_P,                      --                             .mem_dqs
            memory_mem_dqs_n                    => HPS_DDR3_DQS_N,                    --                             .mem_dqs_n
            memory_mem_odt                      => HPS_DDR3_ODT,                      --                             .mem_odt
            memory_mem_dm                       => HPS_DDR3_DM,                       --                             .mem_dm
            memory_oct_rzqin                    => HPS_DDR3_RZQ,                    --                             .oct_rzqin
            hps_io_hps_io_gpio_inst_GPIO53      => HPS_LED,      --                       hps_io.hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54      => HPS_KEY_N,      --                             .hps_io_gpio_inst_GPIO54
            leds_external_export			    => LEDR,  -- hps_leds_external_connection.export
			switches_external_export			=> SW
        );
end;