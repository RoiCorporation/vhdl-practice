library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light_tb is
end entity traffic_light_tb;

architecture rtl of traffic_light_tb is

    -- Constants.
    constant clk_period : time := 6 fs;

    -- Signals.
    signal clk                 : std_logic                    := '0';
    signal rst                 : std_logic                    := '0';
    signal traffic_light_color : std_logic_vector(1 downto 0) := (others => '0');

begin

    dut : entity work.traffic_light(rtl)
        port map
        (
            clk                 => clk,
            rst                 => rst,
            traffic_light_color => traffic_light_color
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
    p_stim : process
    begin
        -- Test 01
        wait for 3 * clk_period + 2 fs;
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        wait until rising_edge(clk);
        wait for 3 * clk_period;
        assert traffic_light_color = "00"
        report "Expected traffic_light_color = 00, got " & to_string(traffic_light_color)
            severity error;

        wait for 3 * clk_period;
        assert traffic_light_color = "00"
        report "Expected traffic_light_color = 00, got " & to_string(traffic_light_color)
            severity error;

        wait for 3 * clk_period;
        assert traffic_light_color = "00"
        report "Expected traffic_light_color = 00, got " & to_string(traffic_light_color)
            severity error;

        wait until rising_edge(clk);
        wait until rising_edge(clk);
        assert traffic_light_color = "01"
        report "Expected traffic_light_color = 01, got " & to_string(traffic_light_color)
            severity error;

        wait until rising_edge(clk);
        assert traffic_light_color = "10"
        report "Expected traffic_light_color = 10, got " & to_string(traffic_light_color)
            severity error;

        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        assert traffic_light_color = "00"
        report "Expected traffic_light_color = 00, got " & to_string(traffic_light_color)
            severity error;

        -- Test 02
        wait on traffic_light_color until traffic_light_color = "01";
        wait for 1 fs;
        rst <= '1';
        wait until rising_edge (clk);
        wait for 1 fs;
        rst <= '0';
        wait until rising_edge (clk);
        wait for 1 fs;
        assert traffic_light_color = "00"
        report "Expected traffic_light_color = 00, got " & to_string(traffic_light_color)
            severity error;

        -- Test 03
        wait on traffic_light_color until traffic_light_color = "10";
        wait for 1 fs;
        rst <= '1';
        wait until rising_edge (clk);
        wait for 1 fs;
        rst <= '0';
        wait until rising_edge (clk);
        wait for 1 fs;
        assert traffic_light_color = "00"
        report "Expected traffic_light_color = 00, got " & to_string(traffic_light_color)
            severity error;

        wait;
    end process p_stim;

end architecture rtl;
