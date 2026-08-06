library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light is

    generic (
        time_at_green_light  : integer := 10;
        time_at_yellow_light : integer := 1;
        time_at_red_light    : integer := 3
    );

    port (
        signal clk                 : in std_logic;
        signal rst                 : in std_logic;
        signal traffic_light_color : out std_logic_vector(1 downto 0) -- 00 = green, 01 = yellow, 10 = red
    );
end entity traffic_light;

architecture rtl of traffic_light is
    type traffic_light_state is (TRAFFIC_FLOW, STOP_IF_SAFE, TRAFFIC_STOPPED);
    signal state                      : traffic_light_state;
    signal traffic_light_color_signal : std_logic_vector(1 downto 0) := (others => '0');

begin

    traffic_light_beh : process (clk)
        variable seconds_since_change : integer := 0;

    begin
        if rising_edge(clk) then
            if rst = '1' then
                state                      <= TRAFFIC_FLOW;
                traffic_light_color_signal <= (others => '0');
                seconds_since_change := 0;

            else
                seconds_since_change := seconds_since_change + 1;
                case state is
                    when TRAFFIC_FLOW =>
                        -- If green light time is up, change the FSM's state and the light to
                        -- the yellow light state.
                        if seconds_since_change = time_at_green_light then
                            state                      <= STOP_IF_SAFE;
                            traffic_light_color_signal <= "01";
                            seconds_since_change := 0;
                        end if;

                    when STOP_IF_SAFE =>
                        -- If yellow light time is up, change the FSM's state and the light to
                        -- the red light state.
                        if seconds_since_change = time_at_yellow_light then
                            state                      <= TRAFFIC_STOPPED;
                            traffic_light_color_signal <= "10";
                            seconds_since_change := 0;
                        end if;

                    when TRAFFIC_STOPPED =>
                        -- If red light time is up, change the FSM's state and the light to
                        -- the green light state.
                        if seconds_since_change = time_at_red_light then
                            state                      <= TRAFFIC_FLOW;
                            traffic_light_color_signal <= "00";
                            seconds_since_change := 0;
                        end if;

                end case;

            end if;

        end if;
    end process traffic_light_beh;

    traffic_light_color <= traffic_light_color_signal;

end architecture rtl;
