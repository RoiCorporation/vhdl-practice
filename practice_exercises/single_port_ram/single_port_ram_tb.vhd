library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_ram_tb is
end entity single_port_ram_tb;

architecture rtl of single_port_ram_tb is

    -- Constants
    constant data_width : integer := 8;
    constant addr_width : integer := 8;
    constant clk_period : time    := 8 fs;

    -- Ports
    signal data_in  : std_logic_vector(data_width - 1 downto 0) := (others => '0');
    signal addr     : std_logic_vector(addr_width - 1 downto 0) := (others => '0');
    signal wr       : std_logic                                 := '0';
    signal clk      : std_logic                                 := '0';
    signal data_out : std_logic_vector(data_width - 1 downto 0) := (others => '0');

begin

    dut : entity work.single_port_ram(rtl)
        port map
        (
            data_in  => data_in,
            addr     => addr,
            wr       => wr,
            clk      => clk,
            data_out => data_out
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
        wait until falling_edge(clk);
        wait for 1 fs;
        data_in <= "11111111";
        addr    <= "00000011";
        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "10000000"
        report "Expected data_out = 10000000, got " & to_string(data_out)
            severity error;

        -- Test 02
        wait until rising_edge(clk);
        wait for 1 fs;
        wr <= '1';
        wait for 1 fs;
        assert data_out = "10000000"
        report "Expected data_out = 10000000, got " & to_string(data_out)
            severity error;
        wait until rising_edge(clk);
        assert data_out = "10000000"
        report "Expected data_out = 10000000, got " & to_string(data_out)
            severity error;
        wait until falling_edge(clk);
        wr <= '0';

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "11111111"
        report "Expected data_out = 11111111, got " & to_string(data_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "11111111"
        report "Expected data_out = 11111111, got " & to_string(data_out)
            severity error;

        -- Test 03
        wait until falling_edge(clk);
        wait for 1 fs;
        addr    <= "00101010";
        data_in <= "11000001";
        assert data_out = "11111111"
        report "Expected data_out = 11111111, got " & to_string(data_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "00000000"
        report "Expected data_out = 00000000, got " & to_string(data_out)
            severity error;

        addr <= "00101010";
        assert data_out = "00000000"
        report "Expected data_out = 00000000, got " & to_string(data_out)
            severity error;

        wait until falling_edge(clk);
        wait for 1 fs;
        wr <= '1';

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "00000000"
        report "Expected data_out = 00000000, got " & to_string(data_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        wr <= '0';
        assert data_out = "11000001"
        report "Expected data_out = 11000001, got " & to_string(data_out)
            severity error;

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "11000001"
        report "Expected data_out = 11000001, got " & to_string(data_out)
            severity error;

        -- Test 04
        wait until falling_edge(clk);
        wait for 1 fs;
        addr <= "00000011";

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "11111111"
        report "Expected data_out = 11111111, got " & to_string(data_out)
            severity error;

        wait until falling_edge(clk);
        wait for 1 fs;
        addr <= "00101010";

        wait until rising_edge(clk);
        wait for 1 fs;
        assert data_out = "11000001"
        report "Expected data_out = 11000001, got " & to_string(data_out)
            severity error;

        wait;
    end process p_stim;

end architecture rtl;
