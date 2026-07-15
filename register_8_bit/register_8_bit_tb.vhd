library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_8_bit_tb is
end register_8_bit_tb;

architecture beh of register_8_bit_tb is

    signal input, output : std_logic_vector(7 downto 0) := (others => '0');
    signal clk, rst : std_logic := '0';

begin
    dut : entity work.register_8_bit 
    port map (
        input => input,
        clk => clk,
        rst => rst,
        output => output
    );

    p_input : process
    begin
        input <= (7 downto 1 => '1', others => '0');
        wait for 18 fs;
        input <= (7 downto 2 => '1', others => '0');
        wait for 18 fs;
        input <= (7 downto 3 => '1', others => '0');
        wait for 18 fs;
        input <= (7 downto 4 => '1', others => '0');
        wait for 18 fs;
        input <= (7 downto 5 => '1', others => '0');
        wait for 18 fs;
        input <= (7 downto 6 => '1', others => '0');
        wait for 18 fs;
    end process p_input;

    p_rst : process
    begin
        wait for 3 fs;
        rst <= '1';
        wait for 40 fs;
        rst <= '0';
        wait for 15 fs;
    end process p_rst;

    p_clk : process
        constant clk_period : time := 20 fs;
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process p_clk;

end architecture beh;
