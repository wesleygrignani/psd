library ieee;
use ieee.std_logic_1164.all;

entity fsm_watch_tb is
  -- empty
end fsm_watch_tb;

architecture rtl of fsm_watch_tb is

  -- fsm watch component
  component fsm_watch
    port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_B   : in std_logic;
      o_S   : out std_logic_vector(1 downto 0)
    );
  end component;

  -- clock constant
  constant c_CLK_PERIOD : time := 10 ns;

  signal w_CLK : std_logic := '0'; -- clock signal
  signal w_RST : std_logic := '0'; -- reset signal 
  signal w_B   : std_logic := '1'; -- button is active in low

  signal w_S : std_logic_vector(1 downto 0) := (others => '0');

begin

  -- clock process 
  p_CLK : process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD/2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  -- Device under test (FSM Watch)
  fsm_watch_inst : fsm_watch
  port map(
    i_CLK => w_CLK,
    i_RST => w_RST,
    i_B   => w_B,
    o_S   => w_S
  );

  process
  begin

    -- reset active 
    w_RST <= '1';
    wait for c_CLK_PERIOD;
    assert(w_S = "00") report "Fail @ state s_TIME" severity error;

    -- reset disabled 
    w_RST <= '0';
    wait for c_CLK_PERIOD;
    assert(w_S = "00") report "Fail @ state s_TIME" severity error;

    -- Test press button for more than 1 clock then release button (Alarm)
    w_B <= '0';
    wait for c_CLK_PERIOD * 2;
    assert(w_S = "01") report "Fail @ state s_ALARM" severity error;

    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_S = "01") report "Fail @ state s_ALARM" severity error;

    -- Test press button for more than 1 clock then release button (Stopwatch)
    w_B <= '0';
    wait for c_CLK_PERIOD * 2;
    assert(w_S = "10") report "Fail @ state s_STOPWATCH" severity error;

    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_S = "10") report "Fail @ state s_STOPWATCH" severity error;

    -- Test press button for more than 1 clock then release button (Date)
    w_B <= '0';
    wait for c_CLK_PERIOD * 2;
    assert(w_S = "11") report "Fail @ state s_DATE" severity error;

    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_S = "11") report "Fail @ state s_DATE" severity error;

    -- Test press button for more than 1 clock then release button (Time)
    w_B <= '0';
    wait for c_CLK_PERIOD * 2;
    assert(w_S = "00") report "Fail @ state s_TIME" severity error;

    w_B <= '1';
    wait for c_CLK_PERIOD;
    assert(w_S = "00") report "Fail @ state s_TIME" severity error;

    assert false report "Test done." severity note;
    wait;
  end process;

end architecture;