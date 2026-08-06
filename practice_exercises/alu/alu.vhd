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
--! @title Integer ALU.
--! @file alu.vhd
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 06-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Integer 32-bit ALU implementation inspired by the RISC-V specification.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is

    -- Generics
    generic (
        data_length   : integer := 32;
        opcode_length : integer := 7
    );

    -- Ports
    port (
        opcode : in std_logic_vector(opcode_length - 1 downto 0);
        a      : in std_logic_vector(data_length - 1 downto 0);
        b      : in std_logic_vector(data_length - 1 downto 0);
        c      : out std_logic_vector(data_length - 1 downto 0)
    );
end entity alu;

architecture rtl of alu is
begin
    c <= std_logic_vector(unsigned(a) + unsigned(b)) when opcode = "0000000" else
        a and b when opcode = "0000001" else
        a or b when opcode = "0000010" else
        a nand b when opcode = "0000011" else
        a nor b when opcode = "0000100" else
        a xor b when opcode = "0000101" else
        not a when opcode = "0000110" else
        not b when opcode = "0000111";
end architecture rtl;
