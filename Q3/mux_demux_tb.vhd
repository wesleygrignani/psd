library ieee;
use ieee.std_logic_1164.all;

entity mux_demux_tb is
  -- empty
end mux_demux_tb;

architecture rtl of mux_demux_tb is
  -- DUV component
  component mux_demux is
    port (
      i_A     : in std_logic; -- data input 
      i_B     : in std_logic; -- data input 
      i_SEL_M : in std_logic; -- mux selector
      i_SEL_D : in std_logic; -- demux selector
      o_S0    : out std_logic; -- data output 
      o_S1    : out std_logic; -- data output
    );
  end component;

  -- Signals to connect DUV component
  signal w_A     : std_logic := '0';
  signal w_B     : std_logic := '0';
  signal w_SEL_M : std_logic := '0';
  signal w_SEL_D : std_logic := '0';
  signal w_S0    : std_logic := '0';
  signal w_S1    : std_logic := '0';

begin

  mux_demux : mux_demux
  port map(
    i_A     => w_A,
    i_B     => w_B,
    i_SEL_M => w_SEL_M,
    i_SEL_D => w_SEL_D,
    o_S0    => w_S0,
    o_S1    => w_S1
  );

  process
  begin

    -- Data inputs  
    w_A <= '0';
    w_B <= '0';
    -- Selector is set to multiplex i_A
    w_SEL_M <= '0';
    -- Selector is set to trigger demux input to o_S0 output
    w_SEL_D <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0000" severity error;
    assert(w_S1 = '0') report "Fail @ 0000" severity error;

    -- input change 
    w_A <= '1';
    w_B <= '0';
    wait for 1 ns;
    assert(w_S0 = '1') report "Fail @ 1000" severity error;
    assert(w_S1 = '0') report "Fail @ 1000" severity error;

    -- input change
    w_A <= '0';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0100" severity error;
    assert(w_S1 = '0') report "Fail @ 0100" severity error;

    -- input change 
    w_A <= '1';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '1') report "Fail @ 1100" severity error;
    assert(w_S1 = '0') report "Fail @ 1100" severity error;

    -- now selector is set to trigger demux input to o_S1 output
    w_A     <= '0';
    w_B     <= '0';
    w_SEL_D <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0000" severity error;
    assert(w_S1 = '0') report "Fail @ 0000" severity error;

    -- input change 
    w_A <= '1';
    w_B <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 1000" severity error;
    assert(w_S1 = '0') report "Fail @ 1000" severity error;

    -- input change
    w_A <= '0';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0100" severity error;
    assert(w_S1 = '1') report "Fail @ 0100" severity error;

    -- input change 
    w_A <= '1';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 1100" severity error;
    assert(w_S1 = '1') report "Fail @ 1100" severity error;

    -- Changing multiplexer to select input i_B
    -- Demux Selector is set to trigger input to o_S0 output again
    -- Data inputs reset  
    w_A     <= '0';
    w_B     <= '0';
    w_SEL_M <= '1';
    w_SEL_D <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0010" severity error;
    assert(w_S1 = '0') report "Fail @ 0010" severity error;

    -- input change
    w_A <= '1';
    w_B <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 1010" severity error;
    assert(w_S1 = '0') report "Fail @ 1010" severity error;

    -- input change
    w_A <= '0';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '1') report "Fail @ 0110" severity error;
    assert(w_S1 = '0') report "Fail @ 0110" severity error;

    -- input change
    w_A <= '1';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '1') report "Fail @ 1110" severity error;
    assert(w_S1 = '0') report "Fail @ 1110" severity error;

    -- Demux Selector is set to trigger input to o_S1 output
    -- Data inputs reset
    w_A     <= '0';
    w_B     <= '0';
    w_SEL_D <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0011" severity error;
    assert(w_S1 = '0') report "Fail @ 0011" severity error;

    -- input change
    w_A <= '1';
    w_B <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 1011" severity error;
    assert(w_S1 = '0') report "Fail @ 1011" severity error;

    -- input change
    w_A <= '0';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 0111" severity error;
    assert(w_S1 = '1') report "Fail @ 0111" severity error;

    -- input change
    w_A <= '1';
    w_B <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 1111" severity error;
    assert(w_S1 = '1') report "Fail @ 1111" severity error;

    -- clear inputs  
    w_A     <= '0';
    w_B     <= '0';
    w_SEL_M <= '0';
    w_SEL_D <= '0';
    assert false report "Test done." severity note;
    wait;

  end process;

end rtl;