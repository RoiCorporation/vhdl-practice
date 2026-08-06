library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_ram is

    generic (
        data_width : integer := 8;
        addr_width : integer := 8;
        ram_size   : integer := 127
    );

    port (
        data_in  : in std_logic_vector(data_width - 1 downto 0);
        addr     : in std_logic_vector(addr_width - 1 downto 0);
        wr       : in std_logic;
        clk      : in std_logic;
        data_out : out std_logic_vector(data_width - 1 downto 0)
    );

end entity single_port_ram;

architecture rtl of single_port_ram is
    type RAM_ARRAY is array (0 to ram_size) of std_logic_vector (data_width - 1 downto 0);

    signal d_out      : std_logic_vector(data_width - 1 downto 0) := (others => '0');
    signal ram_memory : RAM_ARRAY                                 := (
    x"00", x"00", x"00", x"80", -- 0x00:
    x"99", x"00", x"00", x"11", -- 0x04:
    x"00", x"00", x"00", x"00", -- 0x08:
    x"00", x"00", x"00", x"00", -- 0x0C:
    x"00", x"00", x"00", x"00", -- 0x10:
    x"00", x"00", x"00", x"00", -- 0x14:
    x"00", x"00", x"00", x"00", -- 0x18:
    x"00", x"00", x"00", x"00", -- 0x1C:
    x"00", x"00", x"00", x"00", -- 0x20:
    x"00", x"00", x"00", x"00", -- 0x24:
    x"00", x"00", x"00", x"00", -- 0x28:
    x"00", x"00", x"00", x"00", -- 0x2C:
    x"00", x"00", x"00", x"00", -- 0x30:
    x"00", x"00", x"00", x"00", -- 0x34:
    x"00", x"00", x"00", x"00", -- 0x38:
    x"00", x"00", x"00", x"00", -- 0x3C:
    x"00", x"00", x"00", x"00", -- 0x40:
    x"00", x"00", x"00", x"00", -- 0x44:
    x"00", x"00", x"00", x"00", -- 0x48:
    x"00", x"00", x"00", x"00", -- 0x4C:
    x"00", x"00", x"00", x"00", -- 0x50:
    x"00", x"00", x"00", x"00", -- 0x54:
    x"00", x"00", x"00", x"00", -- 0x58:
    x"00", x"00", x"00", x"00", -- 0x5C:
    x"00", x"00", x"00", x"00", -- 0x60:
    x"00", x"00", x"00", x"00", -- 0x64:
    x"00", x"00", x"00", x"00", -- 0x68:
    x"00", x"00", x"00", x"00", -- 0x6C:
    x"00", x"00", x"00", x"00", -- 0x70:
    x"00", x"00", x"00", x"00", -- 0x74:
    x"00", x"00", x"00", x"00", -- 0x78:
    x"00", x"00", x"00", x"00" -- 0x7C:
    );

begin

    single_port_ram_beh : process (clk)
    begin
        if rising_edge(clk) then
            d_out <= ram_memory(to_integer(unsigned(addr)));
            if wr = '1' then
                ram_memory(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;

    end process single_port_ram_beh;

    data_out <= d_out;

end architecture rtl;
