library ieee;
use ieee.std_logic_1164.all;

entity fsm_sequence_generator_tb is
  -- enmpty
end fsm_sequence_generator_tb;

architecture rtl of fsm_sequence_generator_tb is

  -- fsm component
  component fsm_sequence_generator is
    port (
      i_CLK : in std_logic; -- clock
      i_RST : in std_logic; -- reset/clear
      o_Z   : out std_logic_vector(3 downto 0)); -- data output
  end component;

  -- clock constant
  constant c_CLK_PERIOD : time := 10 ns;
  -- input signals 
  signal w_clk, w_rst : std_logic := '0';
  -- output signals
  signal w_Z : std_logic_vector(3 downto 0) := (others => '0');

begin

  -- clock process 
  p_CLK : process
  begin
    w_clk <= '0';
    wait for c_CLK_PERIOD/2;
    w_clk <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  -- Device under test (FSM generator)
  u_DUV : fsm_sequence_generator
  port map(
    i_CLK => w_clk,
    i_RST => w_rst,
    o_Z   => w_Z
  );

  process
  begin

    -- reset active 
    w_rst <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Z = "0001") report "Fail @ state A" severity error;

    w_rst <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Z = "0011") report "Fail @ state B" severity error;

    wait for c_CLK_PERIOD;
    assert(w_Z = "1100") report "Fail @ state C" severity error;

    wait for c_CLK_PERIOD;
    assert(w_Z = "1000") report "Fail @ state D" severity error;

    wait for c_CLK_PERIOD;
    assert(w_Z = "0001") report "Fail @ state A" severity error;

    wait for c_CLK_PERIOD;
    assert(w_Z = "0011") report "Fail @ state B" severity error;

    wait for c_CLK_PERIOD;
    assert(w_Z = "1100") report "Fail @ state C" severity error;

    wait for c_CLK_PERIOD;
    assert(w_Z = "1000") report "Fail @ state D" severity error;

    assert false report "Test done." severity note;
    wait;

  end process;

end rtl;