library ieee;
use ieee.std_logic_1164.all;


entity sipo_shift_register_tb is
end entity sipo_shift_register_tb;


architecture bench of sipo_shift_register_tb is

    -- Constants
    constant register_width : integer := 8;
    constant clk_period : time := 6 fs;

    -- Ports
    signal data_in : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal parallel_out : std_logic_vector(register_width - 1 downto 0) := (others => '0');

begin

    dut : entity work.sipo_shift_register
    port map (
        data_in => data_in,
        clk => clk,
        rst => rst,
        parallel_out => parallel_out
    );

    -- Clock process
    p_clk : process
    begin
        for i in 1 to 3000 loop
            wait for clk_period / 2;
            clk <= not clk;
        end loop;
        wait;
    end process p_clk;

    -- Stimulus process
    stim_proc : process
    begin
        -- Test 01
        data_in <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "10000000"
            report "Expected parallel_out = 10000000, got " & to_string(parallel_out)
            severity error;
        
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11000000"
            report "Expected parallel_out = 11000000, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11100000"
            report "Expected parallel_out = 11100000, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11110000"
            report "Expected parallel_out = 11110000, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11111000"
            report "Expected parallel_out = 11111000, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11111100"
            report "Expected parallel_out = 11111100, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11111110"
            report "Expected parallel_out = 11111110, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11111111"
            report "Expected parallel_out = 11111111, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "11111111"
            report "Expected parallel_out = 11111111, got " & to_string(parallel_out)
            severity error;

        -- Test 02
        data_in <= '0';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "01111111"
            report "Expected parallel_out = 01111111, got " & to_string(parallel_out)
            severity error;
        
        data_in <= '1';
        wait until falling_edge(clk);
        wait for 1 fs;
        assert parallel_out = "01111111"
            report "Expected parallel_out = 01111111, got " & to_string(parallel_out)
            severity error;
        
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "10111111"
            report "Expected parallel_out = 10111111, got " & to_string(parallel_out)
            severity error;

        data_in <= '0';
        wait until rising_edge(clk);
        data_in <= '0';
        wait until falling_edge(clk);
        wait for 1 fs;
        assert parallel_out = "01011111"
            report "Expected parallel_out = 01011111, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "00101111"
            report "Expected parallel_out = 00101111, got " & to_string(parallel_out)
            severity error;

        data_in <= '0';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "00010111"
            report "Expected parallel_out = 00010111, got " & to_string(parallel_out)
            severity error;

        -- Test 03
        rst <= '1';
        wait for 1 fs;
        assert parallel_out = "00010111"
            report "Expected parallel_out = 00010111, got " & to_string(parallel_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "00000000"
            report "Expected parallel_out = 00000000, got " & to_string(parallel_out)
            severity error;
        
        data_in <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "00000000"
            report "Expected parallel_out = 00000000, got " & to_string(parallel_out)
            severity error;
        
        wait until rising_edge(clk);
        wait for 1 fs;
        assert parallel_out = "00000000"
            report "Expected parallel_out = 00000000, got " & to_string(parallel_out)
            severity error;

        wait;
    end process stim_proc;

end architecture bench;
