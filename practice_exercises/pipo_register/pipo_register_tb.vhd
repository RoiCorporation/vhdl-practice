--------------------------------------------------------------------------------
-- MIT License

-- Copyright (c) 2026 Roi Lopez Barata

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------------------------------
--! @title Testbench for the PIPO register
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 07-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Testbench for the PIPO register implementation.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! This entity implements a testbench for the register entity. It generates a
--! clock signal, applies reset and input stimuli, and observes the output of
--! the register. Furthermore, it contains test cases to verify the correct
--! behavior of the register under different conditions.
entity pipo_register_tb is
end entity pipo_register_tb;

architecture beh of pipo_register_tb is

    -- Constants.
    constant clk_period     : time    := 10 ns; --! Clock period for the testbench clock signal.
    constant register_width : integer := 8; --! Width of the register in bits.

    -- Signals.
    signal rst    : std_logic                                     := '0'; --! Synchronous reset signal.
    signal clk    : std_logic                                     := '0'; --! Clock signal.
    signal load   : std_logic                                     := '0'; --! Load enable signal.
    signal input  : std_logic_vector(register_width - 1 downto 0) := (others => '0'); --! Input data to be loaded into the register.
    signal output : std_logic_vector(register_width - 1 downto 0) := (others => '0'); --! Output data from the register.

begin

    --! Instance of the PIPO register.
    dut : entity work.pipo_register(rtl)
        port map
        (
            rst    => rst,
            clk    => clk,
            load   => load,
            input  => input,
            output => output
        );

    --! Process to generate the clock signal. It toggles the clock every half period.
    p_clk : process
    begin
        for i in 1 to 3000 loop
            wait for clk_period / 2;
            clk <= not clk;
        end loop;
        wait;
    end process p_clk;

    --! Process to test the register behavior. It applies reset, load, and input
    --! stimuli to the register and observes the output. It contains test cases
    --! to verify the correct operation of the register under different conditions.
    p_stim : process
    begin

        -- Test 01
        rst <= '1';
        wait until rising_edge(clk);
        wait for 3 ns;
        assert output = "00000000"
        report "output should be 00000000, got " & to_string(output)
            severity error;
        rst <= '0';

        -- Test 02
        wait until rising_edge(clk);
        wait for 3 ns;
        input <= "10101010";
        load  <= '1';
        wait until rising_edge(clk);
        wait for 3 ns;
        assert output = "10101010"
        report "output should be 10101010, got " & to_string(output)
            severity error;

        -- Test 03
        input <= "00001111";
        wait until rising_edge(clk);
        wait for 3 ns;
        assert output = "00001111"
        report "output should be 00001111, got " & to_string(output)
            severity error;
        load <= '0';

        -- Test 04
        wait until rising_edge(clk);
        wait for 3 ns;
        assert output = "00001111"
        report "output should be 00001111, got " & to_string(output)
            severity error;

        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        wait for 3 ns;
        assert output = "00001111"
        report "output should be 00001111, got " & to_string(output)
            severity error;

        -- Test 05
        wait until rising_edge(clk);
        wait for 3 ns;
        input <= "00000000";
        load  <= '1';
        wait until rising_edge(clk);
        wait for 3 ns;
        assert output = "00000000"
        report "output should be 00000000, got " & to_string(output)
            severity error;
        load <= '0';

        wait;
    end process p_stim;

end architecture beh;
