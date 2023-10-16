library ieee;
use ieee.std_logic_1164.all;

entity fsm_mealy_tb is
  -- empty
end fsm_mealy_tb;

architecture rtl of fsm_mealy_tb is

  -- fsm mealy component
  component fsm_mealy
    port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_A   : in std_logic;
      i_B   : in std_logic;
      o_Y   : out std_logic
    );
  end component;

  -- clock constant
  constant c_CLK_PERIOD : time := 10 ns;

  signal w_CLK : std_logic := '0'; -- clock signal
  signal w_RST : std_logic := '0'; -- reset signal 
  signal w_A   : std_logic := '0'; -- data input
  signal w_B   : std_logic := '0'; -- data input
  signal w_Y   : std_logic := '0'; -- output

begin

  -- clock process 
  p_CLK : process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD/2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  -- Device under test (FSM Mealy)
  fsm_mealy_inst : fsm_mealy
  port map(
    i_CLK => w_CLK,
    i_RST => w_RST,
    i_A   => w_A,
    i_B   => w_B,
    o_Y   => w_Y
  );

  process
  begin

    -- reset active 
    w_RST <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Y = '0') report "Fail @ state s_A" severity error;

    -- reset disabled and only input A in 1
    w_RST <= '0';
    w_A   <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Y = '0') report "Fail @ state s_A" severity error;

    -- go to B state
    w_A <= '0';
    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Y = '1') report "Fail @ state s_B" severity error;

    -- stay in B state
    w_A <= '0';
    w_B <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Y = '1') report "Fail @ state s_B" severity error;

    -- go to C state
    w_A <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Y = '1') report "Fail @ state s_C" severity error;

    -- stay in C state
    w_B <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Y = '1') report "Fail @ state s_C" severity error;

    -- return to A state
    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Y = '0') report "Fail @ state s_A" severity error;

    -- now test A state going directly to C state
    w_A <= '0';
    w_B <= '0';
    wait for c_CLK_PERIOD;
    assert(w_Y = '1') report "Fail @ state s_C" severity error;

    -- go to A state
    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_Y = '0') report "Fail @ state s_A" severity error;

    assert false report "Test done." severity note;
    wait;

  end process;

end architecture;