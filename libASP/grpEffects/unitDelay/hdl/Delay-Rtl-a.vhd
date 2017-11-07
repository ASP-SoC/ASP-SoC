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

  subtype aRamAddress is integer range 0 to gDelay;
  signal readAddress, writeAddress : aRamAddress;

  
begin

  ---------------------------------------------------------------------------
  -- Outputs
  ---------------------------------------------------------------------------
  
  ---------------------------------------------------------------------------
  -- Signal assignments
  ---------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- Logic
  ---------------------------------------------------------------------------
  

  ------------------------------------------------------------------------------
  -- Read and write RAM
  ------------------------------------------------------------------------------
  ram_rw : process (iClk) is
  begin  -- process ram_rw
    if rising_edge(iClk) then
      if asi_valid = '1' then
        ramBlock(writeAddress) <= iDdry;
      end if;
      oDwet <= ramBlock(readAddress);
    end if;
  end process ram_rw;

  
  ------------------------------------------------------------------------------
  -- Address pointer logic
  ------------------------------------------------------------------------------
  address_p : process (iClk, inResetAsync) is
  begin  -- process address_p
    if inResetAsync = not('1') then     -- asynchronous reset (active low)
      readAddress  <= 1;
      writeAddress <= 0;
    elsif rising_edge(iClk) then        -- rising clock edge
      -- wait until data is valid
      if asi_valid = '1' then

        -- increase read address
        if readAddress = gDelay then
          readAddress <= 0;
        else
          readAddress <= readAddress + 1;
        end if;

        -- increase write address
        if writeAddress = gDelay then
          writeAddress <= 0;
        else
          writeAddress <= writeAddress + 1;
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
        readAddress <= 0;
        writeAddress <= to_integer(unsigned(avs_s0_writedata(LogDualis(dMaxDelay)-1 downto 0)));
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------
  -- Instantiations
  ---------------------------------------------------------------------------


end architecture Rtl;
