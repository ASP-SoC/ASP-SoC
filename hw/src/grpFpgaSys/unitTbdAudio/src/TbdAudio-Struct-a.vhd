architecture Struct of TbdAudio is

  component AudioSubSystem is
    port (
      clk_clk       : in std_logic := 'X';  -- clk
      reset_reset_n : in std_logic := 'X'   -- reset_n
      );
  end component AudioSubSystem;

begin  -- architecture Struct

  --AudioSystem : entity work.AudioSubSystem
  --  port map (
  --    clk_clk       => Clock_50,
  --    reset_reset_n => KEY(0)
  --    );

  u0 : component AudioSubSystem
    port map (
      clk_clk       => Clock_50,        --   clk.clk
      reset_reset_n => KEY0             -- reset.reset_n
      );

end architecture Struct;
