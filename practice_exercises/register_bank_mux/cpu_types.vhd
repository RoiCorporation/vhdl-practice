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
--! @title CPU types
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 07-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Custom types and declarations used in different files of this CPU project.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! This package contains custom types and constants used in the CPU project,
--! including register specifications and array types for register bank ports.
package cpu_types is
    constant register_amount        : natural := 32; --! Amount of general purpose registers available in the CPU.
    constant register_width         : natural := 32; --! Width of the general purpose registers in bits.
    constant register_address_width : natural := 5; --! Bits needed to address every general purpose register.
    type bank_ports_t is array (natural range <>) of std_logic_vector; --! Array type for the port entries of the register bank.
end package cpu_types;
