library ieee;
use ieee.std_logic_1164.all;

entity and_gate_tb is
end entity and_gate_tb;

architecture tb of and_gate_tb is

  -- Component under test (CUT)
  signal a : std_logic := '0';
  signal b : std_logic := '0';
  signal y : std_logic;

begin

  -- Instantiate the design
  uut : entity work.and_gate
    port map
    (
      a => a,
      b => b,
      y => y
    );

  -- Stimulus process
  stim_proc : process
  begin
    -- Test 00
    a <= '0';
    b <= '0';
    wait for 10 ns;
    assert y = '0'
    report "0 AND 0 should be 0, got " & std_logic'image(y)
      severity error;

    -- Test 01
    a <= '0';
    b <= '1';
    wait for 10 ns;
    assert y = '0'
    report "0 AND 1 should be 0, got " & std_logic'image(y)
      severity error;

    -- Test 10
    a <= '1';
    b <= '0';
    wait for 10 ns;
    assert y = '0'
    report "1 AND 0 should be 0, got " & std_logic'image(y)
      severity error;

    -- Test 11
    a <= '1';
    b <= '1';
    wait for 10 ns;
    assert y = '1'
    report "1 AND 1 should be 1, got " & std_logic'image(y)
      severity error;

    -- End simulation
    wait;
  end process;

end architecture tb;
