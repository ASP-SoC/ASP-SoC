architecture Struct of PlatformHps is

  -- qsys component
  component Platform is
    port (
      clk_clk                         : in    std_logic                     := 'X';  -- clk
      dds_left_strobe_export          : in    std_logic                     := 'X';  -- export
      dds_right_strobe_export         : in    std_logic                     := 'X';  -- export
      hex0_2_export                   : out   std_logic_vector(20 downto 0);  -- export
      hex3_5_export                   : out   std_logic_vector(20 downto 0);  -- export
      hps_io_hps_io_emac1_inst_TX_CLK : out   std_logic;  -- hps_io_emac1_inst_TX_CLK
      hps_io_hps_io_emac1_inst_TXD0   : out   std_logic;  -- hps_io_emac1_inst_TXD0
      hps_io_hps_io_emac1_inst_TXD1   : out   std_logic;  -- hps_io_emac1_inst_TXD1
      hps_io_hps_io_emac1_inst_TXD2   : out   std_logic;  -- hps_io_emac1_inst_TXD2
      hps_io_hps_io_emac1_inst_TXD3   : out   std_logic;  -- hps_io_emac1_inst_TXD3
      hps_io_hps_io_emac1_inst_RXD0   : in    std_logic                     := 'X';  -- hps_io_emac1_inst_RXD0
      hps_io_hps_io_emac1_inst_MDIO   : inout std_logic                     := 'X';  -- hps_io_emac1_inst_MDIO
      hps_io_hps_io_emac1_inst_MDC    : out   std_logic;  -- hps_io_emac1_inst_MDC
      hps_io_hps_io_emac1_inst_RX_CTL : in    std_logic                     := 'X';  -- hps_io_emac1_inst_RX_CTL
      hps_io_hps_io_emac1_inst_TX_CTL : out   std_logic;  -- hps_io_emac1_inst_TX_CTL
      hps_io_hps_io_emac1_inst_RX_CLK : in    std_logic                     := 'X';  -- hps_io_emac1_inst_RX_CLK
      hps_io_hps_io_emac1_inst_RXD1   : in    std_logic                     := 'X';  -- hps_io_emac1_inst_RXD1
      hps_io_hps_io_emac1_inst_RXD2   : in    std_logic                     := 'X';  -- hps_io_emac1_inst_RXD2
      hps_io_hps_io_emac1_inst_RXD3   : in    std_logic                     := 'X';  -- hps_io_emac1_inst_RXD3
      hps_io_hps_io_qspi_inst_IO0     : inout std_logic                     := 'X';  -- hps_io_qspi_inst_IO0
      hps_io_hps_io_qspi_inst_IO1     : inout std_logic                     := 'X';  -- hps_io_qspi_inst_IO1
      hps_io_hps_io_qspi_inst_IO2     : inout std_logic                     := 'X';  -- hps_io_qspi_inst_IO2
      hps_io_hps_io_qspi_inst_IO3     : inout std_logic                     := 'X';  -- hps_io_qspi_inst_IO3
      hps_io_hps_io_qspi_inst_SS0     : out   std_logic;  -- hps_io_qspi_inst_SS0
      hps_io_hps_io_qspi_inst_CLK     : out   std_logic;  -- hps_io_qspi_inst_CLK
      hps_io_hps_io_sdio_inst_CMD     : inout std_logic                     := 'X';  -- hps_io_sdio_inst_CMD
      hps_io_hps_io_sdio_inst_D0      : inout std_logic                     := 'X';  -- hps_io_sdio_inst_D0
      hps_io_hps_io_sdio_inst_D1      : inout std_logic                     := 'X';  -- hps_io_sdio_inst_D1
      hps_io_hps_io_sdio_inst_CLK     : out   std_logic;  -- hps_io_sdio_inst_CLK
      hps_io_hps_io_sdio_inst_D2      : inout std_logic                     := 'X';  -- hps_io_sdio_inst_D2
      hps_io_hps_io_sdio_inst_D3      : inout std_logic                     := 'X';  -- hps_io_sdio_inst_D3
      hps_io_hps_io_usb1_inst_D0      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D0
      hps_io_hps_io_usb1_inst_D1      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D1
      hps_io_hps_io_usb1_inst_D2      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D2
      hps_io_hps_io_usb1_inst_D3      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D3
      hps_io_hps_io_usb1_inst_D4      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D4
      hps_io_hps_io_usb1_inst_D5      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D5
      hps_io_hps_io_usb1_inst_D6      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D6
      hps_io_hps_io_usb1_inst_D7      : inout std_logic                     := 'X';  -- hps_io_usb1_inst_D7
      hps_io_hps_io_usb1_inst_CLK     : in    std_logic                     := 'X';  -- hps_io_usb1_inst_CLK
      hps_io_hps_io_usb1_inst_STP     : out   std_logic;  -- hps_io_usb1_inst_STP
      hps_io_hps_io_usb1_inst_DIR     : in    std_logic                     := 'X';  -- hps_io_usb1_inst_DIR
      hps_io_hps_io_usb1_inst_NXT     : in    std_logic                     := 'X';  -- hps_io_usb1_inst_NXT
      hps_io_hps_io_spim1_inst_CLK    : out   std_logic;  -- hps_io_spim1_inst_CLK
      hps_io_hps_io_spim1_inst_MOSI   : out   std_logic;  -- hps_io_spim1_inst_MOSI
      hps_io_hps_io_spim1_inst_MISO   : in    std_logic                     := 'X';  -- hps_io_spim1_inst_MISO
      hps_io_hps_io_spim1_inst_SS0    : out   std_logic;  -- hps_io_spim1_inst_SS0
      hps_io_hps_io_uart0_inst_RX     : in    std_logic                     := 'X';  -- hps_io_uart0_inst_RX
      hps_io_hps_io_uart0_inst_TX     : out   std_logic;  -- hps_io_uart0_inst_TX
      hps_io_hps_io_i2c0_inst_SDA     : inout std_logic                     := 'X';  -- hps_io_i2c0_inst_SDA
      hps_io_hps_io_i2c0_inst_SCL     : inout std_logic                     := 'X';  -- hps_io_i2c0_inst_SCL
      hps_io_hps_io_i2c1_inst_SDA     : inout std_logic                     := 'X';  -- hps_io_i2c1_inst_SDA
      hps_io_hps_io_i2c1_inst_SCL     : inout std_logic                     := 'X';  -- hps_io_i2c1_inst_SCL
      hps_io_hps_io_gpio_inst_GPIO09  : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO09
      hps_io_hps_io_gpio_inst_GPIO35  : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO35
      hps_io_hps_io_gpio_inst_GPIO48  : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO48
      hps_io_hps_io_gpio_inst_GPIO53  : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO53
      hps_io_hps_io_gpio_inst_GPIO54  : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO54
      hps_io_hps_io_gpio_inst_GPIO61  : inout std_logic                     := 'X';  -- hps_io_gpio_inst_GPIO61
      i2c_SDAT                        : inout std_logic                     := 'X';  -- SDAT
      i2c_SCLK                        : out   std_logic;  -- SCLK
      keys_export                     : in    std_logic_vector(2 downto 0)  := (others => 'X');  -- export
      leds_export                     : out   std_logic_vector(9 downto 0);  -- export
      memory_mem_a                    : out   std_logic_vector(14 downto 0);  -- mem_a
      memory_mem_ba                   : out   std_logic_vector(2 downto 0);  -- mem_ba
      memory_mem_ck                   : out   std_logic;  -- mem_ck
      memory_mem_ck_n                 : out   std_logic;  -- mem_ck_n
      memory_mem_cke                  : out   std_logic;  -- mem_cke
      memory_mem_cs_n                 : out   std_logic;  -- mem_cs_n
      memory_mem_ras_n                : out   std_logic;  -- mem_ras_n
      memory_mem_cas_n                : out   std_logic;  -- mem_cas_n
      memory_mem_we_n                 : out   std_logic;  -- mem_we_n
      memory_mem_reset_n              : out   std_logic;  -- mem_reset_n
      memory_mem_dq                   : inout std_logic_vector(31 downto 0) := (others => 'X');  -- mem_dq
      memory_mem_dqs                  : inout std_logic_vector(3 downto 0)  := (others => 'X');  -- mem_dqs
      memory_mem_dqs_n                : inout std_logic_vector(3 downto 0)  := (others => 'X');  -- mem_dqs_n
      memory_mem_odt                  : out   std_logic;  -- mem_odt
      memory_mem_dm                   : out   std_logic_vector(3 downto 0);  -- mem_dm
      memory_oct_rzqin                : in    std_logic                     := 'X';  -- oct_rzqin
      reset_reset_n                   : in    std_logic                     := 'X';  -- reset_n
      switches_export                 : in    std_logic_vector(9 downto 0)  := (others => 'X');  -- export
      xck_clk                         : out   std_logic;  -- clk
      i2s_codec_iadcdat               : in    std_logic                     := 'X';  -- iadcdat
      i2s_codec_iadclrc               : in    std_logic                     := 'X';  -- iadclrc
      i2s_codec_ibclk                 : in    std_logic                     := 'X';  -- ibclk
      i2s_codec_idaclrc               : in    std_logic                     := 'X';  -- idaclrc
      i2s_codec_odacdat               : out   std_logic;  -- odacdat
      i2s_gpio_iadcdat                : in    std_logic                     := 'X';  -- iadcdat
      i2s_gpio_iadclrc                : in    std_logic                     := 'X';  -- iadclrc
      i2s_gpio_ibclk                  : in    std_logic                     := 'X';  -- ibclk
      i2s_gpio_idaclrc                : in    std_logic                     := 'X';  -- idaclrc
      strobe_export                   : out   std_logic;  -- export
      white_noise_left_strobe_export  : in    std_logic                     := 'X';  -- export
      white_noise_right_strobe_export : in    std_logic                     := 'X';  -- export
      i2s_gpio_odacdat                : out   std_logic   -- odacdat
      );
  end component Platform;

  signal hex0_2, hex3_5 : std_logic_vector(20 downto 0);
  signal keys_p         : std_logic_vector(2 downto 0);
  signal sample_strobe  : std_ulogic;

begin  -- architecture Struct

  -- hex
  HEX0 <= not hex0_2(6 downto 0);
  HEX1 <= not hex0_2(13 downto 7);
  HEX2 <= not hex0_2(20 downto 14);
  HEX3 <= not hex3_5(6 downto 0);
  HEX4 <= not hex3_5(13 downto 7);
  HEX5 <= not hex3_5(20 downto 14);

  --keys
  keys_p <= not KEY(3 downto 1);

  -- qsys system
  u0 : component Platform
    port map (
      clk_clk => CLOCK_50,              --      clk.clk

      i2c_SDAT => FPGA_I2C_SDAT,        --      i2c.SDAT
      i2c_SCLK => FPGA_I2C_SCLK,        --         .SCLK

      i2s_codec_iadcdat => AUD_ADCDAT,  -- CODEC I2S Interface
      i2s_codec_iadclrc => AUD_ADCLRCK,
      i2s_codec_ibclk   => AUD_BCLK,
      i2s_codec_idaclrc => AUD_DACLRCK,
      i2s_codec_odacdat => AUD_DACDAT,

      i2s_gpio_iadcdat => GPIO_1_D2,    -- GPIO I2S Interface
      i2s_gpio_iadclrc => GPIO_1_D3,
      i2s_gpio_ibclk   => GPIO_1_D4,
      i2s_gpio_idaclrc => GPIO_1_D5,
      i2s_gpio_odacdat => GPIO_1_D6,

      keys_export => keys_p,            --     keys.export
      leds_export => LEDR,              --     leds.export

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

      hps_io_hps_io_gpio_inst_GPIO35  => HPS_ENET_INT_N,
      hps_io_hps_io_emac1_inst_TX_CLK => HPS_ENET_GTX_CLK,
      hps_io_hps_io_emac1_inst_TXD0   => HPS_ENET_TX_DATA(0),
      hps_io_hps_io_emac1_inst_TXD1   => HPS_ENET_TX_DATA(1),
      hps_io_hps_io_emac1_inst_TXD2   => HPS_ENET_TX_DATA(2),
      hps_io_hps_io_emac1_inst_TXD3   => HPS_ENET_TX_DATA(3),
      hps_io_hps_io_emac1_inst_MDIO   => HPS_ENET_MDIO,
      hps_io_hps_io_emac1_inst_MDC    => HPS_ENET_MDC,
      hps_io_hps_io_emac1_inst_RX_CTL => HPS_ENET_RX_DV,
      hps_io_hps_io_emac1_inst_TX_CTL => HPS_ENET_TX_EN,
      hps_io_hps_io_emac1_inst_RX_CLK => HPS_ENET_RX_CLK,
      hps_io_hps_io_emac1_inst_RXD0   => HPS_ENET_RX_DATA(0),
      hps_io_hps_io_emac1_inst_RXD1   => HPS_ENET_RX_DATA(1),
      hps_io_hps_io_emac1_inst_RXD2   => HPS_ENET_RX_DATA(2),
      hps_io_hps_io_emac1_inst_RXD3   => HPS_ENET_RX_DATA(3),

      hps_io_hps_io_qspi_inst_SS0 => HPS_FLASH_NCSO,
      hps_io_hps_io_qspi_inst_CLK => HPS_FLASH_DCLK,
      hps_io_hps_io_qspi_inst_IO0 => HPS_FLASH_DATA(0),
      hps_io_hps_io_qspi_inst_IO1 => HPS_FLASH_DATA(1),
      hps_io_hps_io_qspi_inst_IO2 => HPS_FLASH_DATA(2),
      hps_io_hps_io_qspi_inst_IO3 => HPS_FLASH_DATA(3),

      hps_io_hps_io_sdio_inst_CMD => HPS_SD_CMD,
      hps_io_hps_io_sdio_inst_CLK => HPS_SD_CLK,
      hps_io_hps_io_sdio_inst_D0  => HPS_SD_DATA(0),
      hps_io_hps_io_sdio_inst_D1  => HPS_SD_DATA(1),
      hps_io_hps_io_sdio_inst_D2  => HPS_SD_DATA(2),
      hps_io_hps_io_sdio_inst_D3  => HPS_SD_DATA(3),

      hps_io_hps_io_gpio_inst_GPIO09 => HPS_CONV_USB_N,
      hps_io_hps_io_usb1_inst_D0     => HPS_USB_DATA(0),
      hps_io_hps_io_usb1_inst_D1     => HPS_USB_DATA(1),
      hps_io_hps_io_usb1_inst_D2     => HPS_USB_DATA(2),
      hps_io_hps_io_usb1_inst_D3     => HPS_USB_DATA(3),
      hps_io_hps_io_usb1_inst_D4     => HPS_USB_DATA(4),
      hps_io_hps_io_usb1_inst_D5     => HPS_USB_DATA(5),
      hps_io_hps_io_usb1_inst_D6     => HPS_USB_DATA(6),
      hps_io_hps_io_usb1_inst_D7     => HPS_USB_DATA(7),
      hps_io_hps_io_usb1_inst_CLK    => HPS_USB_CLKOUT,
      hps_io_hps_io_usb1_inst_STP    => HPS_USB_STP,
      hps_io_hps_io_usb1_inst_DIR    => HPS_USB_DIR,
      hps_io_hps_io_usb1_inst_NXT    => HPS_USB_NXT,

      hps_io_hps_io_spim1_inst_CLK  => HPS_SPIM_CLK,
      hps_io_hps_io_spim1_inst_MOSI => HPS_SPIM_MOSI,
      hps_io_hps_io_spim1_inst_MISO => HPS_SPIM_MISO,
      hps_io_hps_io_spim1_inst_SS0  => HPS_SPIM_SS,

      hps_io_hps_io_uart0_inst_RX => HPS_UART_RX,
      hps_io_hps_io_uart0_inst_TX => HPS_UART_TX,

      hps_io_hps_io_gpio_inst_GPIO48 => HPS_I2C_CONTROL,
      hps_io_hps_io_i2c0_inst_SDA    => HPS_I2C1_SDAT,
      hps_io_hps_io_i2c0_inst_SCL    => HPS_I2C1_SCLK,
      hps_io_hps_io_i2c1_inst_SDA    => HPS_I2C2_SDAT,
      hps_io_hps_io_i2c1_inst_SCL    => HPS_I2C2_SCLK,

      hps_io_hps_io_gpio_inst_GPIO53 => HPS_LED,
      hps_io_hps_io_gpio_inst_GPIO54 => HPS_KEY,

      hps_io_hps_io_gpio_inst_GPIO61 => HPS_GSENSOR_INT,

      hex0_2_export => hex0_2,
      hex3_5_export => hex3_5,

      dds_left_strobe_export          => sample_strobe,
      dds_right_strobe_export         => sample_strobe,
      strobe_export                   => sample_strobe,
      white_noise_left_strobe_export  => sample_strobe,
      white_noise_right_strobe_export => sample_strobe
      );

end architecture Struct;
