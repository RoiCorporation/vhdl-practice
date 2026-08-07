library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lock is

    -- Generics.
    generic (
        combination_width : integer := 8;
        retries           : integer := 3;
        cycles_door_open  : integer := 5
    );

    -- Ports.
    port (
        rst                   : in std_logic;
        clk                   : in std_logic;
        edit_lock_combination : in std_logic;
        check_combination     : in std_logic;
        input_combination     : in std_logic_vector(combination_width - 1 downto 0);
        door_open             : out std_logic := '1'
    );
end entity lock;

architecture rtl of lock is
    type lock_state is (
        EDIT_COMBINATION,
        DOOR_LOCKED,
        DOOR_UNLOCKED,
        DOOR_PERMANENTLY_LOCKED
    );
    signal state                     : lock_state;
    signal correct_combination       : std_logic_vector(combination_width - 1 downto 0) := (others => '0');
    signal retries_left              : integer                                          := retries;
    signal cycles_door_unlocked_left : integer                                          := cycles_door_open;

begin

    p_beh : process (clk)
    begin

        if rising_edge(clk) then
            if rst = '1' then
                state                     <= EDIT_COMBINATION;
                door_open                 <= '1';
                retries_left              <= retries;
                cycles_door_unlocked_left <= cycles_door_open;

            elsif rst = '0' then
                case state is
                    when EDIT_COMBINATION =>
                        if edit_lock_combination = '1' then
                            correct_combination <= input_combination;
                        elsif edit_lock_combination = '0' then
                            state     <= DOOR_LOCKED;
                            door_open <= '0';
                        end if;

                    when DOOR_LOCKED =>
                        if retries_left = 0 then
                            state <= DOOR_PERMANENTLY_LOCKED;
                        else
                            if check_combination = '1' then
                                if input_combination = correct_combination then
                                    state        <= DOOR_UNLOCKED;
                                    door_open    <= '1';
                                    retries_left <= retries;
                                else
                                    door_open    <= '0';
                                    retries_left <= retries_left - 1;
                                end if;
                            end if;
                        end if;

                    when DOOR_UNLOCKED =>
                        if edit_lock_combination = '1' then
                            state <= EDIT_COMBINATION;
                        else
                            if cycles_door_unlocked_left = 0 then
                                state                     <= DOOR_LOCKED;
                                cycles_door_unlocked_left <= cycles_door_open;
                                door_open                 <= '0';
                            else
                                cycles_door_unlocked_left <= cycles_door_unlocked_left - 1;
                            end if;
                        end if;

                    when DOOR_PERMANENTLY_LOCKED =>
                end case;
            end if;
        end if;

    end process p_beh;

end architecture rtl;
