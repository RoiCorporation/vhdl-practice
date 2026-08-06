library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop_tb is
end entity d_flip_flop_tb;

architecture bench of d_flip_flop_tb is

    -- Constants
    constant clk_period : time := 6 fs;

    -- Ports
    signal d     : std_logic := '0';
    signal clk   : std_logic := '0';
    signal q     : std_logic := '0';
    signal q_neg : std_logic := '0';

begin

    dut : entity work.d_flip_flop(rtl)
        port map
        (
            d     => d,
            clk   => clk,
            q     => q,
            q_neg => q_neg
        );

    p_clk : process
    begin
        for i in 1 to 3000 loop
            wait for clk_period / 2;
            clk <= not clk;
        end loop;
        wait;
    end process p_clk;

    -- Stimulus process
    p_stim : process
    begin
        -- Test 01
        d <= '0';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert q = '0'
        report "Expected q = 0, got " & std_logic'image(q)
            severity error;
        assert q_neg = '1'
        report "Expected q_neg = 1, got " & std_logic'image(q_neg)
            severity error;

        -- Test 02
        d <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert q = '1'
        report "Expected q = 1, got " & std_logic'image(q)
            severity error;
        assert q_neg = '0'
        report "Expected q_neg = 0, got " & std_logic'image(q_neg)
            severity error;

        -- Test 03
        wait until rising_edge(clk);
        wait for 1 fs;
        d <= '0';
        wait for 1 fs;
        assert q = '1'
        report "Expected q = 1, got " & std_logic'image(q)
            severity error;
        assert q_neg = '0'
        report "Expected q_neg = 0, got " & std_logic'image(q_neg)
            severity error;

        -- Test 04
        wait until falling_edge(clk);
        wait for 1 fs;
        assert q = '1'
        report "Expected q = 1, got " & std_logic'image(q)
            severity error;
        assert q_neg = '0'
        report "Expected q_neg = 0, got " & std_logic'image(q_neg)
            severity error;

        -- Test 04
        wait until rising_edge(clk);
        wait for 1 fs;
        assert q = '0'
        report "Expected q = 0, got " & std_logic'image(q)
            severity error;
        assert q_neg = '1'
        report "Expected q_neg = 1, got " & std_logic'image(q_neg)
            severity error;

        -- Test 05
        wait until falling_edge(clk);
        wait for 1 fs;
        d <= '1';
        wait for 1 fs;
        assert q = '0'
        report "Expected q = 0, got " & std_logic'image(q)
            severity error;
        assert q_neg = '1'
        report "Expected q_neg = 1, got " & std_logic'image(q_neg)
            severity error;

        -- Test 05
        wait until rising_edge(clk);
        wait for 1 fs;
        assert q = '1'
        report "Expected q = 1, got " & std_logic'image(q)
            severity error;
        assert q_neg = '0'
        report "Expected q_neg = 0, got " & std_logic'image(q_neg)
            severity error;

        wait;
    end process p_stim;

end architecture bench;
