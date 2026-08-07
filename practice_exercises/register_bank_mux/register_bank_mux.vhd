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
--! @title Register bank MUX
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 07-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Register bank multiplexer that outputs the value of the selected register.
--------------------------------------------------------------------------------

library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_types.all;

--! This entity implements a multiplexer that selects one of the register outputs
--! from the register bank based on the selector input.
entity register_bank_mux is

    -- Ports.
    port (
        selector     : in std_logic_vector(register_address_width - 1 downto 0); --! Selector input to choose which register output to forward.
        bank_outputs : in bank_ports_t(register_amount - 1 downto 0)(register_width - 1 downto 0); --! Array of register outputs from the register bank.
        output       : out std_logic_vector(register_width - 1 downto 0) --! Output of the selected register value.
    );
end entity register_bank_mux;

architecture rtl of register_bank_mux is
begin

    --! Output assignment based on the selector value. It selects the corresponding
    --! register output from the bank_outputs array. If the selector is out of range,
    --! it defaults to a zero vector.
    output <= bank_outputs(0) when selector = "00000" else
        bank_outputs(1) when selector = "00001" else
        bank_outputs(2) when selector = "00010" else
        bank_outputs(3) when selector = "00011" else
        bank_outputs(4) when selector = "00100" else
        bank_outputs(5) when selector = "00101" else
        bank_outputs(6) when selector = "00110" else
        bank_outputs(7) when selector = "00111" else
        bank_outputs(8) when selector = "01000" else
        bank_outputs(9) when selector = "01001" else
        bank_outputs(10) when selector = "01010" else
        bank_outputs(11) when selector = "01011" else
        bank_outputs(12) when selector = "01100" else
        bank_outputs(13) when selector = "01101" else
        bank_outputs(14) when selector = "01110" else
        bank_outputs(15) when selector = "01111" else
        bank_outputs(16) when selector = "10000" else
        bank_outputs(17) when selector = "10001" else
        bank_outputs(18) when selector = "10010" else
        bank_outputs(19) when selector = "10011" else
        bank_outputs(20) when selector = "10100" else
        bank_outputs(21) when selector = "10101" else
        bank_outputs(22) when selector = "10110" else
        bank_outputs(23) when selector = "10111" else
        bank_outputs(24) when selector = "11000" else
        bank_outputs(25) when selector = "11001" else
        bank_outputs(26) when selector = "11010" else
        bank_outputs(27) when selector = "11011" else
        bank_outputs(28) when selector = "11100" else
        bank_outputs(29) when selector = "11101" else
        bank_outputs(30) when selector = "11110" else
        bank_outputs(31) when selector = "11111" else
        (others => '0'); -- Default case if selector is out of range.

end architecture rtl;
