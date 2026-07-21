library ieee;
use ieee.std_logic_1164.all;

entity register_8_bit is
    port (
        input  : in std_logic_vector(7 downto 0);
        clk    : in std_logic;
        rst    : in std_logic;
        output : out std_logic_vector(7 downto 0)
    );
end entity register_8_bit;

architecture behavior of register_8_bit is
begin
    p_reg : process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                output <= (others => '0');
            else
                output <= input;
            end if;
        end if;
    end process p_reg;

end architecture behavior;
