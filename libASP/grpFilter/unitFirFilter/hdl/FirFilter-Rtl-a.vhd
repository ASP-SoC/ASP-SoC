-------------------------------------------------------------------------------
-- Title       : FIR - Filter
-- Author      : Franz Steinbacher, Michael Wurm
-------------------------------------------------------------------------------
-- Description : Finite Impule Response Filter with Avalon MM interface for
-- coeffs configuration.
-------------------------------------------------------------------------------

architecture Rtl of FirFilter is

  ----------------------------------------------------------------------------
  -- Types
  ----------------------------------------------------------------------------
  type aMemory is array (0 to coeff_num_g-1) of audio_data_t;

  subtype audio_data_t is u_sfixed(0 downto -(data_width_g-1));

  type aFirStates is (NewVal, MulSum);

  type aFirParam is record
    firState : aFirStates;
    writeAdr : unsigned(coeff_addr_width_g-1 downto 0);
    readAdr  : unsigned(coeff_addr_width_g-1 downto 0);
    coeffAdr : unsigned(coeff_addr_width_g-1 downto 0);
    valDry   : std_ulogic;
    dDry     : audio_data_t;
    sum      : audio_data_t;
    mulRes   : audio_data_t;
    valWet   : std_ulogic;
  end record aFirParam;

  ----------------------------------------------------------------------------
  -- Constants
  ----------------------------------------------------------------------------
  constant cInitFirParam : aFirParam := (firState => NewVal,
                                         writeAdr => (others => '0'),
                                         readAdr  => (others => '0'),
                                         coeffAdr => (others => '0'),
                                         valDry   => '0',
                                         dDry     => (others => '0'),
                                         sum      => (others => '0'),
                                         mulRes   => (others => '0'),
                                         valWet   => '0'
                                         );

  ----------------------------------------------------------------------------
  -- Functions
  ----------------------------------------------------------------------------


  procedure incr_addr (
    signal in_addr  : in  unsigned(coeff_addr_width_g-1 downto 0);
    signal out_addr : out unsigned(coeff_addr_width_g-1 downto 0)
    ) is
  begin
    if (in_addr = (coeff_num_g - 1)) then
      out_addr <= (others => '0');
    else
      out_addr <= in_addr + 1;
    end if;
  end incr_addr;

  ----------------------------------------------------------------------------
  -- Signals
  ----------------------------------------------------------------------------
  signal InputRam : aMemory      := (others => (others => '0'));
  signal CoeffRam : aMemory;
  signal R        : aFirParam    := cInitFirParam;
  signal nxR      : aFirParam    := cInitFirParam;
  signal readVal  : audio_data_t := (others => '0');
  signal coeffVal : audio_data_t := (others => '0');

  -- enable register
  signal enable : std_ulogic;

  constant pass_in_to_out_c : std_ulogic := '0';
  constant filter_c         : std_ulogic := '1';

begin

  -----------------------------------------------------------------------------
  -- MM slave for enable
  -----------------------------------------------------------------------------
  s1_enable : process (csi_clk, rsi_reset_n) is
  begin  -- process
    if rsi_reset_n = '0' then           -- asynchronous reset (active low)
      enable <= '0';
    elsif rising_edge(csi_clk) then     -- rising clock edge
      if avs_s1_write = '1' then
        enable <= avs_s1_writedata(0);
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Coeff RAM 
  -----------------------------------------------------------------------------

  -- write ram
  ram_wr : process (csi_clk) is
  begin  -- process ram_wr
    if rising_edge(csi_clk) then        -- rising clock edge
      if avs_s0_write = '1' then
        CoeffRam(to_integer(unsigned(avs_s0_address))) <=
          to_sfixed(avs_s0_writedata(data_width_g-1 downto 0), CoeffRam(0));
      end if;
    end if;
  end process ram_wr;

  -- read ram
  ram_rd : process (csi_clk) is
  begin  -- process ram_rd
    if rising_edge(csi_clk) then        -- rising clock edge
      coeffVal <= CoeffRam(to_integer(R.coeffAdr));
    end if;
  end process ram_rd;

  -----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Outputs
  ----------------------------------------------------------------------------

  -- valid
  with enable select
    aso_valid <=
    asi_valid when pass_in_to_out_c,
    R.valWet  when filter_c,
    'X'       when others;

  -- data
  with enable select
    aso_data <=
    asi_data        when pass_in_to_out_c,
    to_slv(R.sum)   when filter_c,
    (others => 'X') when others;


  ----------------------------------------------------------------------------
  -- FSMD
  ----------------------------------------------------------------------------
  Comb : process (R, asi_valid, readVal, coeffVal) is
  begin

    nxR <= R;

    case R.firState is
      when NewVal =>
        nxR.valWet <= '0';
        nxR.sum    <= (others => '0');

        -- wait here for new sample
        if asi_valid = '1' then
          nxR.firState <= MulSum;

          incr_addr(R.readAdr, nxR.readAdr);
        end if;

      when MulSum =>
        nxR.mulRes <= ResizeTruncAbsVal(readVal * coeffVal, R.mulRes);
        nxR.sum    <= ResizeTruncAbsVal(R.sum + R.mulRes, R.sum);

        if R.coeffAdr = coeff_num_g-1 then
          nxR.firState <= NewVal;
          nxR.coeffAdr <= (others => '0');
          nxR.valWet   <= '1';

          incr_addr(R.writeAdr, nxR.writeAdr);
        end if;

        incr_addr(R.coeffAdr, nxR.coeffAdr);
        incr_addr(R.readAdr, nxR.readAdr);

      when others =>
        nxR.firState <= NewVal;
    end case;
  end process Comb;

  ----------------------------------------------------------------------------
  -- Read and write RAM
  ----------------------------------------------------------------------------
  AccessInputRam : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if asi_valid = '1' then
        InputRam(to_integer(R.writeAdr)) <= to_sfixed(asi_data, InputRam(0));
      end if;

      readVal <= InputRam(to_integer(R.readAdr));
    end if;
  end process AccessInputRam;

  ----------------------------------------------------------------------------
  -- Register process
  ----------------------------------------------------------------------------
  reg : process (csi_clk, rsi_reset_n) is
  begin
    if rsi_reset_n = '0' then
      R <= cInitFirParam;
    elsif rising_edge(csi_clk) then
      R <= nxR;
    end if;
  end process reg;

end architecture;
