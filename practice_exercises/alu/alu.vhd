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
--! @title Integer ALU
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 07-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Integer 32-bit ALU implementation inspired by the RISC-V specification.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! This is an implementation of a simple ALU (Arithmetic Logic Unit) that
--! performs basic arithmetic and logic operations on two 32-bit inputs. The
--! operation to be performed is determined by a 7-bit opcode input, and the
--! result of the operation is output as a 32-bit value.
entity alu is

    -- Generics.
    generic (
        data_length   : integer := 32; --! Length of the input and output data vectors.
        opcode_length : integer := 7 --! Length of the opcode vector.
    );

    -- Ports.
    port (
        opcode : in std_logic_vector(opcode_length - 1 downto 0); --! 7-bit opcode input that determines the operation to be performed.
        a      : in std_logic_vector(data_length - 1 downto 0); --! First 32-bit input operand.
        b      : in std_logic_vector(data_length - 1 downto 0); --! Second 32-bit input operand.
        c      : out std_logic_vector(data_length - 1 downto 0) --! 32-bit output result.
    );
end entity alu;

architecture rtl of alu is
begin

    --! The output 'c' is assigned based on the value of the 'opcode' input. Each
    --! opcode corresponds to a specific operation, such as addition, bitwise AND,
    --! bitwise OR, etc. If the opcode does not match any of the defined operations,
    --! the output is set to zero.
    c <= std_logic_vector(unsigned(a) + unsigned(b)) when opcode = "0000000" else --! addition/substraction
        a and b when opcode = "0000001" else --! bitwise AND
        a or b when opcode = "0000010" else --! bitwise OR
        a nand b when opcode = "0000011" else --! bitwise NAND
        a nor b when opcode = "0000100" else --! bitwise NOR
        a xor b when opcode = "0000101" else --! bitwise XOR
        not a when opcode = "0000110" else --! bitwise NOT with respect to input a
        not b when opcode = "0000111" else --! bitwise NOT with respect to input b
        (others => '0'); --! default case, output is zero

end architecture rtl;
