-------------------------------------------------------------------------------
-- Title       : Signal Delay Left and Right
-- Author      : Michael Wurm <michael.wurm@students.fh-hagenberg.at>
-------------------------------------------------------------------------------
-- Description : Unit delays left and right channel independent. Each channel's
--               delay can be configured separately.
-------------------------------------------------------------------------------



architecture Rtl of Delay is

  ---------------------------------------------------------------------------
  -- Wires
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Registers
  ---------------------------------------------------------------------------
  signal DelayValReg : unsigned(LogDualis(gMaxDelay)-1 downto 0);

  type aMemory is array (0 to gMaxDelay) of std_ulogic_vector(asi_data'range);
  signal ramBlock : aMemory := (others => (others => '0'));

  subtype aRamAddress is integer range 0 to gMaxDelay;
  signal Address : aRamAddress;
  signal Offset  : aRamAddress;


begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  aso_valid <= asi_valid;

  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Logic
  ---------------------------------------------------------------------------


  ------------------------------------------------------------------------------
  -- Read and write RAM
  ------------------------------------------------------------------------------
  ram_rw : process (csi_clk) is
    variable readAddress  : aRamAddress;
    variable writeAddress : aRamAddress;
  begin  -- process ram_rw
    if rising_edge(csi_clk) then
      if Offset = 0 then  -- RAM reads old value when reading and writing at the
        -- same address
        aso_data <= asi_data;
      else
        readAddress  := Address;
        writeAddress := (Address + Offset) mod gMaxDelay;

        if asi_valid = '1' then
          ramBlock(writeAddress) <= asi_data;
        end if;
        aso_data <= ramBlock(readAddress);      --TODO: write back silence
      end if;

    end if;
  end process ram_rw;


  ------------------------------------------------------------------------------
  -- Address pointer logic
  ------------------------------------------------------------------------------
  address_p : process (csi_clk, rsi_reset_n) is

  begin  -- process address_p
    if rsi_reset_n = not('1') then      -- asynchronous reset (active low)
      Address <= 0;
    elsif rising_edge(csi_clk) then     -- rising clock edge
      -- wait until data is valid
      if asi_valid = '1' then

        -- increase address
        if Address = gMaxDelay-1 then
          Address <= 0;
        else
          Address <= Address + 1;
        end if;


      end if;
    end if;
  end process address_p;



  -- MM INTERFACE for configuration
  SetConfigReg : process (csi_clk) is
  begin
    if rising_edge(csi_clk) then
      if avs_s0_write = '1' then  -- bad implementation (jumps in output signal
        -- and reapeating parts when changing delay)
        --readAddress  <= 0;
        Offset <= to_integer(unsigned(avs_s0_writedata(LogDualis(gMaxDelay)-1 downto 0)));
        --TODO: scale output to 0
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------
  -- Instantiations
  ---------------------------------------------------------------------------


end architecture Rtl;
