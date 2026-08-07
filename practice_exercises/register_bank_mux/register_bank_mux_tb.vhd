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
--! @title Testbench for the register bank MUX
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 07-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Testbench with test cases for the register bank multiplexer.
--------------------------------------------------------------------------------

library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_types.all;

--! This entity implements a testbench for the register bank multiplexer. It generates
--! test cases to verify the correct functionality of the multiplexer by applying
--! different selector values and checking the output against expected results.
entity register_bank_mux_tb is
end entity register_bank_mux_tb;

architecture rtl of register_bank_mux_tb is
    signal selector     : std_logic_vector(register_address_width - 1 downto 0)                   := (others => '0'); --! Selector input to choose which register output to forward.
    signal bank_outputs : bank_ports_t(register_amount - 1 downto 0)(register_width - 1 downto 0) := (others => (others => '0')); --! Array of register outputs from the register bank.
    signal output       : std_logic_vector(register_width - 1 downto 0)                           := (others => '0'); --! Output of the selected register value.

begin

    --! Instance of the register bank multiplexer.
    dut : entity work.register_bank_mux
        port map
        (
            selector     => selector,
            bank_outputs => bank_outputs,
            output       => output
        );

    --! Process to generate test cases for the register bank multiplexer. It applies different
    --! selector values and checks the output against expected results, asserting errors if
    --! the output does not match the expected value.
    p_stim : process
    begin
        -- Place random values at some elements of the bank outputs array to
        -- mirror real registers.
        bank_outputs(4)  <= "10111111111010100010101011000010";
        bank_outputs(7)  <= "00010000100101000001010011101111";
        bank_outputs(1)  <= "01010001000111101101101000000100";
        bank_outputs(16) <= "10001001111101101001101111101000";
        bank_outputs(25) <= "00001111010100100001010110000101";
        bank_outputs(8)  <= "10100000010101011111111111111000";
        bank_outputs(30) <= "01110111100111110001110010010101";
        bank_outputs(6)  <= "01011010000001100101010001110110";
        bank_outputs(3)  <= "11001010101011101010000110001111";
        bank_outputs(2)  <= "01000101110110000110110111101100";
        wait for 20 ns;

        -- Test that the selector works as expected.
        -- Test 01
        selector <= "00011";
        wait for 20 ns;
        assert output = "11001010101011101010000110001111"
        report "output should be 11001010101011101010000110001111, got " & to_string(output)
            severity error;

        -- Test 02
        selector <= "01001";
        wait for 20 ns;
        assert output /= "11001010101011101010000110001111"
        report "output shouldn't be 11001010101011101010000110001111"
            severity error;
        assert output = "00000000000000000000000000000000"
        report "output should be 00000000000000000000000000000000, got " & to_string(output)
            severity error;

        -- Test 03
        selector <= "11110";
        wait for 20 ns;
        assert output /= "00000000000000000000000000000000"
        report "output shouldn't be 00000000000000000000000000000000"
            severity error;
        assert output = "01110111100111110001110010010101"
        report "output should be 01110111100111110001110010010101, got " & to_string(output)
            severity error;

        -- Test 04
        selector <= "11001";
        wait for 20 ns;
        assert output /= "01110111100111110001110010010101"
        report "output shouldn't be 01110111100111110001110010010101"
            severity error;
        assert output = "00001111010100100001010110000101"
        report "output should be 00001111010100100001010110000101, got " & to_string(output)
            severity error;

        -- Test 05
        selector <= "00110";
        wait for 20 ns;
        assert output /= "00001111010100100001010110000101"
        report "output shouldn't be 00001111010100100001010110000101"
            severity error;
        assert output = "01011010000001100101010001110110"
        report "output should be 01011010000001100101010001110110, got " & to_string(output)
            severity error;

        -- Test 06
        selector <= "10000";
        wait for 20 ns;
        assert output /= "01011010000001100101010001110110"
        report "output shouldn't be 01011010000001100101010001110110"
            severity error;
        assert output = "10001001111101101001101111101000"
        report "output should be 10001001111101101001101111101000, got " & to_string(output)
            severity error;

        -- Test 07
        selector <= "10100";
        wait for 20 ns;
        assert output /= "10001001111101101001101111101000"
        report "output shouldn't be 10001001111101101001101111101000"
            severity error;
        assert output = "00000000000000000000000000000000"
        report "output should be 00000000000000000000000000000000, got " & to_string(output)
            severity error;

        wait;
    end process p_stim;

end architecture;
