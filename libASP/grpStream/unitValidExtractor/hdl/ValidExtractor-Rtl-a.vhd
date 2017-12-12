-------------------------------------------------------------------------------
-- Title       : Avalon Valid Extractor
-- Author      : David Haberleitner
-------------------------------------------------------------------------------
-- Description : Provide valid signal as avalon and also as conduit
-------------------------------------------------------------------------------

architecture Rtl of ValidExtractor is
  
  
begin

  aso_valid <= asi_valid;
  val_strobe <= asi_valid;

end architecture Rtl;
