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
      o_S1    : out std_logic); -- data output
  end component;

  -- Signals to connect DUV component
  signal w_A     : std_logic := '0';
  signal w_B     : std_logic := '0';
  signal w_SEL_M : std_logic := '0';
  signal w_SEL_D : std_logic := '0';
  signal w_S0    : std_logic := '0';
  signal w_S1    : std_logic := '0';

  type test_vector is record
    i_A, i_B, i_SEL_M, i_SEL_D : std_logic;
    o_S0, o_S1                 : std_logic;
  end record;

  type test_vector_array is array (natural range <>) of test_vector;
  constant test_vectors : test_vector_array := (
  -- i_A, i_B, i_SEL_M, i_SEL_D, o_S0, o_S1
  -- Changing A and B with mux select in 0 and demux select in 0
  ('0', '0', '0', '0', '0', '0'),
  ('1', '0', '0', '0', '1', '0'),
  ('0', '1', '0', '0', '0', '0'),
  ('1', '1', '0', '0', '1', '0'),
  -- Changing A and B with mux select in 0 and demux select in 1
  ('0', '0', '0', '1', '0', '0'),
  ('1', '0', '0', '1', '0', '1'),
  ('0', '1', '0', '1', '0', '0'),
  ('1', '1', '0', '1', '0', '1'),
  -- Changing A and B with mux select in 1 and demux select in 0
  ('0', '0', '1', '0', '0', '0'),
  ('1', '0', '1', '0', '0', '0'),
  ('0', '1', '1', '0', '1', '0'),
  ('1', '1', '1', '0', '1', '0'),
  -- Changing A and B with mux select in 1 and demux select in 1
  ('0', '0', '1', '1', '0', '0'),
  ('1', '0', '1', '1', '0', '0'),
  ('0', '1', '1', '1', '0', '1'),
  ('1', '1', '1', '1', '0', '1'));

begin

  u_mux_demux : mux_demux
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

    for i in test_vectors'range loop

      w_A     <= test_vectors(i).i_A;
      w_B     <= test_vectors(i).i_B;
      w_SEL_D <= test_vectors(i).i_SEL_D;
      w_SEL_M <= test_vectors(i).i_SEL_M;

      wait for 1 ns;

      assert (w_S0 = test_vectors(i).o_S0 and w_S1 = test_vectors(i).o_S1)
      report "test_vector " & integer'image(i) & " failed " &
        " for inputs = " & std_logic'image(w_A) &
        std_logic'image(w_B) & std_logic'image(w_SEL_M) &
        std_logic'image(w_SEL_D)
        severity error;

    end loop;

    -- Clear inputs 
    w_A     <= '0';
    w_B     <= '0';
    w_SEL_M <= '0';
    w_SEL_D <= '0';
    assert false report "Test done." severity note;
    wait;

  end process;

end rtl;