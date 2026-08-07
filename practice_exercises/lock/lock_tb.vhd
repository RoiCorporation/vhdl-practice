library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lock_tb is
end entity lock_tb;

architecture rtl of lock_tb is

    -- Constants.
    constant clk_period        : time    := 6 fs;
    constant combination_width : integer := 8;

    -- Signals.
    signal rst                   : std_logic                                        := '0';
    signal clk                   : std_logic                                        := '0';
    signal edit_lock_combination : std_logic                                        := '0';
    signal check_combination     : std_logic                                        := '0';
    signal input_combination     : std_logic_vector(combination_width - 1 downto 0) := (others => '0');
    signal door_open             : std_logic;

begin
    dut : entity work.lock(rtl)
        port map
        (
            rst                   => rst,
            clk                   => clk,
            edit_lock_combination => edit_lock_combination,
            check_combination     => check_combination,
            input_combination     => input_combination,
            door_open             => door_open
        );

    -- Clock process.
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
        wait until rising_edge(clk);
        wait for 1 fs;
        rst <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        rst <= '0';
        wait until rising_edge(clk);
        wait for 1 fs;
        edit_lock_combination <= '1';
        input_combination     <= "10101101";
        wait until rising_edge(clk);
        wait for 1 fs;
        wait until rising_edge(clk);
        wait for 1 fs;
        edit_lock_combination <= '0';
        input_combination     <= "01110010";
        for i in 1 to 10 loop
            wait until rising_edge(clk);
            wait for 1 fs;
            check_combination <= '1';
            wait until rising_edge(clk);
            wait for 1 fs;

            assert door_open = '0'
            report "Expected door_open = 0, got " & to_string(door_open)
                severity error;
        end loop;

        wait until rising_edge(clk);
        wait for 1 fs;
        input_combination <= "10101101";
        wait until rising_edge(clk);
        wait for 1 fs;

        assert door_open = '0'
        report "Expected door_open = 0, got " & to_string(door_open)
            severity error;
        check_combination <= '0';

        -- Test 02
        wait until rising_edge(clk);
        wait for 1 fs;
        rst <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        rst                   <= '0';
        edit_lock_combination <= '1';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        input_combination <= "11110000";

        assert door_open = '1'
        report "Expected door_open = 1, got " & to_string(door_open)
            severity error;
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        input_combination <= "00001010";

        assert door_open = '1'
        report "Expected door_open = 1, got " & to_string(door_open)
            severity error;
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait for 1 fs;
        edit_lock_combination <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait for 1 fs;
        input_combination <= (others => '0');
        check_combination <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        assert door_open = '0'
        report "Expected door_open = 0, got " & to_string(door_open)
            severity error;

        input_combination <= "01101001";
        wait until rising_edge(clk);
        wait for 1 fs;
        assert door_open = '0'
        report "Expected door_open = 0, got " & to_string(door_open)
            severity error;

        input_combination <= "00001010";
        wait until rising_edge(clk);
        wait for 1 fs;
        assert door_open = '1'
        report "Expected door_open = 1, got " & to_string(door_open)
            severity error;

        check_combination <= '0';
        for i in 1 to 10 loop
            wait until rising_edge(clk);
        end loop;
        wait for 1 fs;
        assert door_open = '0'
        report "Expected door_open = 0, got " & to_string(door_open)
            severity error;
        check_combination <= '1';

        -- Test 03
        wait until rising_edge(clk);
        wait for 1 fs;
        assert door_open = '1'
        report "Expected door_open = 1, got " & to_string(door_open)
            severity error;

        edit_lock_combination <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;
        input_combination <= "11010010";
        wait until rising_edge(clk);
        wait for 1 fs;
        edit_lock_combination <= '0';
        check_combination     <= '0';
        assert door_open = '1'
        report "Expected door_open = 1, got " & to_string(door_open)
            severity error;
        wait until rising_edge(clk);
        wait for 1 fs;
        assert door_open = '0'
        report "Expected door_open = 0, got " & to_string(door_open)
            severity error;

        for i in 1 to 10 loop
            wait until rising_edge(clk);
        end loop;

        wait for 1 fs;
        input_combination <= "00000000";
        check_combination <= '1';
        wait until rising_edge(clk);
        wait for 1 fs;

        assert door_open = '0'
        report "Expected door_open = 0, got " & to_string(door_open)
            severity error;

        input_combination <= "11010010";
        wait until rising_edge(clk);
        wait for 1 fs;

        assert door_open = '1'
        report "Expected door_open = 1, got " & to_string(door_open)
            severity error;
        check_combination <= '0';

        wait;
    end process p_stim;

end architecture rtl;
