library ieee;
use ieee.std_logic_1164.all;

entity fsm_car_tb is
  -- enmpty
end fsm_car_tb;

architecture rtl of fsm_car_tb is

  -- fsm car component
  component fsm_car
    port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_A   : in std_logic;
      o_R   : out std_logic
    );
  end component;

  -- clock constant
  constant c_CLK_PERIOD : time := 10 ns;
  -- input and output signals 
  signal w_clk : std_logic := '0';
  signal w_rst : std_logic := '0';
  signal w_A   : std_logic := '0';
  signal w_R   : std_logic := '0';

begin

  -- clock process 
  p_CLK : process
  begin
    w_clk <= '0';
    wait for c_CLK_PERIOD/2;
    w_clk <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  -- Device under test (FSM car)
  u_DUV : fsm_car
  port map(
    i_CLK => w_clk,
    i_RST => w_rst,
    i_A   => w_A,
    o_R   => w_R
  );

  process
  begin

    -- reset active 
    w_rst <= '1';
    wait for c_CLK_PERIOD;
    assert(w_R = '0') report "Fail @ state Wait" severity error;

    w_rst <= '0';
    w_A   <= '0';
    wait for c_CLK_PERIOD;
    assert(w_R = '0') report "Fail @ state Wait" severity error;

    w_A <= '1';
    wait for c_CLK_PERIOD;
    assert(w_R = '1') report "Fail @ state K1" severity error;

    w_A <= '0';
    wait for c_CLK_PERIOD;
    assert(w_R = '0') report "Fail @ state K2" severity error;

    wait for c_CLK_PERIOD;
    assert(w_R = '0') report "Fail @ state K3" severity error;

    wait for c_CLK_PERIOD;
    assert(w_R = '1') report "Fail @ state K4" severity error;

    wait for c_CLK_PERIOD;
    assert(w_R = '0') report "Fail @ state Wait" severity error;
    assert false report "Test done." severity note;
    wait;

  end process;

end rtl;