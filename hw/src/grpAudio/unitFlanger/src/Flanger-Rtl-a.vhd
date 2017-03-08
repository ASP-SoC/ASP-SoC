---------------------------------------------------------------------*-vhdl-*--
-- File        : PwmGen-Rtl-a.vhd
-- Description : <short overview about functionality>
--
-------------------------------------------------------------------------------
-- History (yyyy-mm-dd):
-- yyyy-mm-dd last update by firstname lastname
-------------------------------------------------------------------------------

architecture Rtl of Flanger is

  type aDataArray is array ((99) downto 0) of sfixed(-1 downto -24);
  signal internal_register : aDataArray;

  constant cInternal_registerZero : aDataArray := (others => (others => '0'));

begin  -- Rtl
  
Flanger : process( inResetAsync, iClk )

  variable sum : sfixed(0 downto -24);        --sum is 1 bit bigger
begin

  if inResetAsync = not '1' then
    oData <= (others => '0');

    -- reset internal reg
    internal_register <= cInternal_registerZero;
  else
    if rising_edge(iClk) then
      if iStrobe = '1' then
        internal_register(0) <= iData;

        for I in 0 to (97) loop                     -- shift data through the internal registers
          internal_register(I+1) <= internal_register(I);
        end loop;

        
        sum := (internal_register(98) + iData);     -- add the two values and normalize (divide by two)
        oData <= sum(0 downto -23 );
      end if;
    
    end if;
  end if;
  
end process ; -- Flanger
  

end architecture Rtl;
