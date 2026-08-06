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
--! @title Integer ALU testbench.
--! @file alu_tb.vhd
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 06-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Testbench for the integer 32-bit ALU implementation.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity alu_tb;

architecture bench of alu_tb is
    -- Constants
    constant data_length   : integer := 32;
    constant opcode_length : integer := 7;

    -- Signals
    signal opcode : std_logic_vector(opcode_length - 1 downto 0) := (others => '0');
    signal a      : std_logic_vector(data_length - 1 downto 0)   := (others => '0');
    signal b      : std_logic_vector(data_length - 1 downto 0)   := (others => '0');
    signal c      : std_logic_vector(data_length - 1 downto 0)   := (others => '0');

begin

    dut : entity work.alu(rtl)
        generic map(
            data_length => data_length
        )
        port map
        (
            opcode => opcode,
            a      => a,
            b      => b,
            c      => c
        );

    -- Stimulus process
    p_stim : process
    begin
        -- Test addition (opcode = 0000000)
        a <= "00000000000000000000000000000110";
        b <= "00000000000000000000000000000001";
        wait for 1 ns;
        assert c = "00000000000000000000000000000111"
        report "a + b should be 00000000000000000000000000000111, got " & to_string(c)
            severity error;

        -- Test substraction (opcode = 0000000)
        a <= "00000000000000000000000000000110";
        b <= "11111111111111111111111111111110";
        wait for 1 ns;
        assert c = "00000000000000000000000000000100"
        report "a - b should be 00000000000000000000000000000100, got " & to_string(c)
            severity error;

        -- Test AND (opcode = 0000001)
        opcode <= "0000001";
        a      <= "00011110000011110000100000000110";
        b      <= "11110011111111111111011111111110";
        wait for 1 ns;
        assert c = "00010010000011110000000000000110"
        report "a AND b should be 00010010000011110000000000000110, got " & to_string(c)
            severity error;

        -- Test OR (opcode = 0000010)
        opcode <= "0000010";
        wait for 1 ns;
        assert c = "11111111111111111111111111111110"
        report "a OR b should be 11111111111111111111111111111110, got " & to_string(c)
            severity error;

        -- Test NAND (opcode = 0000011)
        opcode <= "0000011";
        wait for 1 ns;
        assert c = "11101101111100001111111111111001"
        report "a NAND b should be 11101101111100001111111111111001, got " & to_string(c)
            severity error;

        -- Test NOR (opcode = 0000100)
        opcode <= "0000100";
        wait for 1 ns;
        assert c = "00000000000000000000000000000001"
        report "a NOR b should be 00000000000000000000000000000001, got " & to_string(c)
            severity error;

        -- Test XOR (opcode = 0000101)
        opcode <= "0000101";
        wait for 1 ns;
        assert c = "11101101111100001111111111111000"
        report "a XOR b should be 11101101111100001111111111111000, got " & to_string(c)
            severity error;

        -- Test NOT a (opcode = 0000110)
        opcode <= "0000110";
        wait for 1 ns;
        assert c = "11100001111100001111011111111001"
        report "NOT a should be 11100001111100001111011111111001, got " & to_string(c)
            severity error;

        -- Test NOT b (opcode = 0000111)
        opcode <= "0000111";
        wait for 1 ns;
        assert c = "00001100000000000000100000000001"
        report "NOT b should be 00001100000000000000100000000001, got " & to_string(c)
            severity error;

        wait;
    end process p_stim;

end architecture bench;
