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
--! @title PIPO register
--! @author Roi (r.lopezbarata@gmail.com)
--! @version 1.0
--! @date 07-08-2026
--! @copyright This work is licensed under the MIT License.
--! @brief Implementation of a classic PIPO register.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! This is a classic PIPO register with synchronous reset and load enable.
entity pipo_register is

    -- Generics.
    generic (
        register_width : integer := 8 --! Width of the register in bits.
    );

    -- Ports.
    port (
        rst    : in std_logic; --! Synchronous reset signal.
        clk    : in std_logic; --! Clock signal.
        load   : in std_logic; --! Load enable signal.
        input  : in std_logic_vector(register_width - 1 downto 0); --! Input data to be loaded into the register.
        output : out std_logic_vector(register_width - 1 downto 0) --! Output data from the register.
    );
end entity pipo_register;

architecture rtl of pipo_register is
begin

    --! Process that implements the behavior of the register. It updates the output
    --! on the rising edge of the clock, based on the reset and load signals.
    register_beh : process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                output <= (others => '0');
            elsif load = '1' then
                output <= input;
            end if;
        end if;
    end process register_beh;

end architecture rtl;
