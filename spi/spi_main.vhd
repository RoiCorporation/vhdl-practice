library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity spi_main is

  generic (
    bits_per_message   : integer := 8;
    sclk_divider_value : integer := 4;
    clk_period         : time    := 6 fs
  );

  port (
    -- Outbound data buffer ports.
    outbound_buffer_input                                         : in std_logic_vector(bits_per_message - 1 downto 0);
    outbound_buffer_output                                        : out std_logic_vector(bits_per_message - 1 downto 0);
    outbound_buffer_load                                          : in std_logic;
    outbound_buffer_input_asdf_outbound_buffer_input_asdf_asdasdf : in std_logic_vector(bits_per_message - 1 downto 0);

    -- Inbound data buffer ports.
    inbound_buffer_input  : in std_logic_vector(bits_per_message - 1 downto 0);
    inbound_buffer_output : out std_logic_vector(bits_per_message - 1 downto 0);
    inbound_buffer_load   : in std_logic;

    -- Rest of the ports.
    start_transmission : in std_logic;
    mosi               : out std_logic := '0';
    miso               : in std_logic;
    cs                 : out std_logic := '1';
    clk                : in std_logic;
    sclk               : out std_logic := '0';
    cpol               : in std_logic;
    cpha               : in std_logic;
    last_shift_bit     : out std_logic := '0';
    rst                : in std_logic
  );

end entity spi_main;
architecture beh of spi_main is
  type state_t is (IDLE, TRANSMIT, FINISH_TRANSMISSION);
  signal state                       : state_t;
  signal outbound_buffer_output_data : std_logic_vector(bits_per_message - 1 downto 0);
begin

  -- Shift registers behavior.
  shift_registers_beh : process (sclk)
  begin
    if rising_edge(sclk) then
      if cpol = '0' and state = TRANSMIT then
        outbound_buffer_output_data <= '0' & outbound_buffer_output_data(bits_per_message - 1 downto 1);
        inbound_buffer_output       <= inbound_buffer_output(bits_per_message - 2 downto 0) & miso;
      end if;

    elsif falling_edge(sclk) then
      if cpol = '1' and state = TRANSMIT then
        outbound_buffer_output_data <= '0' & outbound_buffer_output_data(bits_per_message - 1 downto 1);
        inbound_buffer_output       <= inbound_buffer_output(bits_per_message - 2 downto 0) & miso;
      end if;
    end if;
  end process shift_registers_beh;

  -- Behavior process.
  spi_main_beh : process (sclk)
    variable current_bits_processed : integer := 0;
  begin
    if rising_edge(sclk) and cpol = '0' then

      if state = IDLE then
        current_bits_processed := 0;

        -- CS pin is active low. Therefore, if the CS line has been pulled down, an
        -- SPI transmission is ongoing.
      elsif state = TRANSMIT then

        -- If all the available bits per transmission have been sent or received,
        -- raise the last bit flag.
        if current_bits_processed = bits_per_message then
          last_shift_bit <= '1';

          -- If there are still bits remaining, update the count of processed bits and
          -- feed the MOSI line with the outbound buffer's LSB.
        else
          current_bits_processed := current_bits_processed + 1;
          mosi <= outbound_buffer_output_data(0);
        end if;
      end if;

    elsif falling_edge(sclk) and cpol = '1' then

      if state = IDLE then
        current_bits_processed := 0;

        -- CS pin is active low. Therefore, if the CS line has been pulled down, an
        -- SPI transmission is ongoing.
      elsif state = TRANSMIT then

        -- If all the available bits per transmission have been sent or received,
        -- raise the last bit flag.
        if current_bits_processed = bits_per_message then
          last_shift_bit <= '1';

          -- If there are still bits remaining, update the count of processed bits and
          -- feed the MOSI line with the outbound buffer's LSB.
        else
          current_bits_processed := current_bits_processed + 1;
          mosi <= outbound_buffer_output_data(0);
        end if;
      end if;
    end if;
  end process spi_main_beh;

  fsm_proc : process (clk)
    variable divider : integer := 0;
  begin
    if rising_edge(clk) then
      if rst = '1' then
        inbound_buffer_output       <= (others => '0');
        outbound_buffer_output_data <= (others => '0');
        state                       <= IDLE;

      else
        case state is
          when IDLE =>
            cs   <= '1';
            sclk <= cpol;

            -- Allow loading values into the inbound and outbound registers while in the
            -- Idle state.
            -- if inbound_buffer_load = '1' then
            --     inbound_buffer_output <= inbound_buffer_input;
            -- end if;
            -- if outbound_buffer_load = '1' then
            --     outbound_buffer_output <= outbound_buffer_input;
            -- end if;

            if start_transmission = '1' then
              state <= TRANSMIT;
            end if;

          when TRANSMIT =>
            cs <= '0';

            -- Generate SCLK pulses.
            if divider = sclk_divider_value then
              divider := 0;
              sclk <= not sclk;
            else
              divider := divider + 1;
            end if;

            -- Move to the finish transmission state when the last bit is sent/received.
            if last_shift_bit = '1' then
              state <= FINISH_TRANSMISSION;
            end if;

          when FINISH_TRANSMISSION =>
            cs             <= '1';
            last_shift_bit <= '0';
            sclk           <= cpol;
            state          <= IDLE;
        end case;
      end if;
    end if;
  end process fsm_proc;

  outbound_buffer_output <= outbound_buffer_output_data;

end architecture beh;
