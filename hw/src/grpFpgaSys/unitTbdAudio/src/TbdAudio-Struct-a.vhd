architecture Struct of TbdAudio is

begin  -- architecture Struct

  TbdAudio_1 : entity work.TbdAudio
    port map (
      clk_clk       => CLOCK_50,
      reset_reset_n => KEY0
      );

end architecture Struct;
