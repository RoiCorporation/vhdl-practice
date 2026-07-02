
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop_tb is
end;

architecture bench of d_flip_flop_tb is
  -- Clock period
  constant clk_period : time := 5 fs;
  -- Generics
  -- Ports
  signal d : std_logic := '0';
  signal clk : std_logic := '0';
  signal q : std_logic := '0';
  signal q_neg : std_logic := '0';
begin

  dut : entity work.d_flip_flop
  port map (
    d => d,
    clk => clk,
    q => q,
    q_neg => q_neg
  );

    p_clk : process
    begin
        clk <= not clk;
        wait for clk_period/2;
    end process p_clk;

    p_d : process
    begin
        wait for 3fs;
        d <= '1';
        wait for 4fs;
        d <= '0';
        wait for 5fs;
    end process p_d;


end;