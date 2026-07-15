library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sipo_shift_register is

    generic(
        register_width : integer := 8
    );

    port (
        data_in : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        parallel_out : out std_logic_vector(register_width - 1 downto 0)
    );

end entity sipo_shift_register;


architecture rtl of sipo_shift_register is
    signal shift_reg : std_logic_vector(register_width - 1 downto 0) := (others => '0');
begin

    parallel_out <= shift_reg;

    sipo_shift_register_beh : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                shift_reg <= (others => '0');
            else
                shift_reg <= data_in & shift_reg(register_width - 1 downto 1);
            end if;
        end if;
    end process sipo_shift_register_beh;

end architecture rtl;
