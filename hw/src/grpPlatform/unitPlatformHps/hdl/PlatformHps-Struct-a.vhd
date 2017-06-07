architecture Struct of PlatformHps is

  component Platform is
    port (
      clk_clk                        : in    std_logic                     := 'X';  -- clk
      i2c_SDAT                       : inout std_logic                     := 'X';  -- SDAT
      i2c_SCLK                       : out   std_logic;  -- SCLK
      i2s_adcdat                     : in    std_logic                     := 'X';  -- adcdat
      i2s_adclrck                    : in    std_logic                     := 'X';  -- adclrck
      i2s_bclk                       : in    std_logic                     := 'X';  -- bclk
      i2s_dacdat                     : out   std_logic;  -- dacdat
      i2s_daclrck                    : in    std_logic                     := 'X';  -- daclrck
      keys_export                    : in    std_logic_vector(2 downto 0)  := (others => 'X');  -- export
      leds_export                    : out   std_logic_vector(9 downto 0);  -- export
      memory_mem_a                   : out   std_logic_vector(14 downto 0);  -- mem_a
      memory_mem_ba                  : out   std_logic_vector(2 downto 0);  -- mem_ba
      memory_mem_ck                  : out   std_logic;  -- mem_ck
      memory_mem_ck_n                : out   std_logic;  -- mem_ck_n
      memory_mem_cke                 : out   std_logic;  -- mem_cke
      memory_mem_cs_n                : out   std_logic;  -- mem_cs_n
      memory_mem_ras_n               : out   std_logic;  -- mem_ras_n
      memory_mem_cas_n               : out   std_logic;  -- mem_cas_n
      memory_mem_we_n                : out   std_logic;  -- mem_we_n
      memory_mem_reset_n             : out   std_logic;  -- mem_reset_n
      memory_mem_dq                  : inout std_logic_vector(31 downto 0) := (others => 'X');  -- mem_dq
      memory_mem_dqs                 : inout std_logic_vector(3 downto 0)  := (others => 'X');  -- mem_dqs
      memory_mem_dqs_n               : inout std_logic_vector(3 downto 0)  := (others => 'X');  -- mem_dqs_n
      memory_mem_odt                 : out   std_logic;  -- mem_odt
      memory_mem_dm                  : out   std_logic_vector(3 downto 0);  -- mem_dm
      memory_oct_rzqin               : in    std_logic                     := 'X';  -- oct_rzqin
      reset_reset_n                  : in    std_logic                     := 'X';  -- reset_n
      switches_export                : in    std_logic_vector(9 downto 0)  := (others => 'X');  -- export
      xck_clk                        : out   std_logic;  -- clk
      hps_io_hps_io_gpio_inst_GPIO53 : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO53
      hps_io_hps_io_gpio_inst_GPIO54 : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO54
      hex0_2_export                  : out   std_logic_vector(20 downto 0);  -- export
      hex3_5_export                  : out   std_logic_vector(20 downto 0)  -- export
      );
  end component Platform;

  signal hex0_2, hex3_5 : std_logic_vector(20 downto 0);

begin  -- architecture Struct

  -- hex 
  HEX0 <= not hex0_2(6 downto 0);
  HEX1 <= not hex0_2(13 downto 7);
  HEX2 <= not hex0_2(20 downto 14);
  HEX3 <= not hex3_5(6 downto 0);
  HEX4 <= not hex3_5(13 downto 7);
  HEX5 <= not hex3_5(20 downto 14);

  u0 : component Platform
    port map (
      clk_clk => CLOCK_50,              --      clk.clk

      i2c_SDAT => FPGA_I2C_SDAT,        --      i2c.SDAT
      i2c_SCLK => FPGA_I2C_SCLK,        --         .SCLK

      i2s_adcdat  => AUD_ADCDAT,        --      i2s.adcdat
      i2s_adclrck => AUD_ADCLRCK,       --         .adclrck
      i2s_bclk    => AUD_BCLK,          --         .bclk
      i2s_dacdat  => AUD_DACDAT,        --         .dacdat
      i2s_daclrck => AUD_DACLRCK,       --         .daclrck

      keys_export        => KEY(3 downto 1),   --     keys.export
      leds_export        => LEDR,              --     leds.export
      memory_mem_a       => HPS_DDR3_ADDR,     -- memory.mem_a
      memory_mem_ba      => HPS_DDR3_BA,       --       .mem_ba
      memory_mem_ck      => HPS_DDR3_CK_P,     --       .mem_ck
      memory_mem_ck_n    => HPS_DDR3_CK_N,     --       .mem_ck_n
      memory_mem_cke     => HPS_DDR3_CKE,      --       .mem_cke
      memory_mem_cs_n    => HPS_DDR3_CS_N,     --       .mem_cs_n
      memory_mem_ras_n   => HPS_DDR3_RAS_N,    --       .mem_ras_n
      memory_mem_cas_n   => HPS_DDR3_CAS_N,    --       .mem_cas_n
      memory_mem_we_n    => HPS_DDR3_WE_N,     --       .mem_we_n
      memory_mem_reset_n => HPS_DDR3_RESET_N,  --       .mem_reset_n
      memory_mem_dq      => HPS_DDR3_DQ,       --       .mem_dq
      memory_mem_dqs     => HPS_DDR3_DQS_P,    --       .mem_dqs
      memory_mem_dqs_n   => HPS_DDR3_DQS_N,    --       .mem_dqs_n
      memory_mem_odt     => HPS_DDR3_ODT,      --       .mem_odt
      memory_mem_dm      => HPS_DDR3_DM,       --       .mem_dm
      memory_oct_rzqin   => HPS_DDR3_RZQ,      --       .oct_rzqin

      reset_reset_n => KEY(0),          --    reset.reset_n

      switches_export => SW,            -- switches.export

      xck_clk => AUD_XCK,               --      xck.clk

      hps_io_hps_io_gpio_inst_GPIO53 => HPS_LED,  --   hps_io.hps_io_gpio_inst_GPIO53
      hps_io_hps_io_gpio_inst_GPIO54 => HPS_KEY,  --         .hps_io_gpio_inst_GPIO54

      hex0_2_export => hex0_2,          --   hex0_2.export
      hex3_5_export => hex3_5           --   hex3_5.export
      );



end architecture Struct;
