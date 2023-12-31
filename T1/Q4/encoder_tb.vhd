library ieee;
use ieee.std_logic_1164.all;

entity encoder_tb is
  -- empty
end encoder_tb;

architecture rtl of encoder_tb is

  -- DUV component
  component encoder is
    port (
      i_REQ0   : in std_logic;
      i_REQ1   : in std_logic;
      i_REQ2   : in std_logic;
      i_REQ3   : in std_logic;
      o_GRANT0 : out std_logic;
      o_GRANT1 : out std_logic;
      o_GRANT2 : out std_logic;
      o_GRANT3 : out std_logic);
  end component;

  -- Signals to connect DUV component
  signal w_REQ0   : std_logic := '0';
  signal w_REQ1   : std_logic := '0';
  signal w_REQ2   : std_logic := '0';
  signal w_REQ3   : std_logic := '0';
  signal w_GRANT0 : std_logic := '0';
  signal w_GRANT1 : std_logic := '0';
  signal w_GRANT2 : std_logic := '0';
  signal w_GRANT3 : std_logic := '0';

  type test_vector is record
    i_REQ0, i_REQ1, i_REQ2, i_REQ3         : std_logic;
    o_GRANT0, o_GRANT1, o_GRANT2, o_GRANT3 : std_logic;
  end record;

  type test_vector_array is array (natural range <>) of test_vector;
  constant test_vectors : test_vector_array := (
  -- i_REQ0, i_REQ1, i_REQ2, i_REQ3, i_GRANT0, i_GRANT1, i_GRANT2, i_GRANT3,
  ('0', '0', '0', '0', '0', '0', '0', '0'),
  ('0', '0', '0', '1', '0', '0', '0', '1'),
  ('0', '0', '1', '0', '0', '0', '1', '0'),
  ('0', '0', '1', '1', '0', '0', '1', '0'),
  ('0', '1', '0', '0', '0', '1', '0', '0'),
  ('0', '1', '0', '1', '0', '1', '0', '0'),
  ('0', '1', '1', '0', '0', '1', '0', '0'),
  ('0', '1', '1', '1', '0', '1', '0', '0'),
  ('1', '0', '0', '0', '1', '0', '0', '0'),
  ('1', '0', '0', '1', '1', '0', '0', '0'),
  ('1', '0', '1', '0', '1', '0', '0', '0'),
  ('1', '0', '1', '1', '1', '0', '0', '0'),
  ('1', '1', '0', '0', '1', '0', '0', '0'),
  ('1', '1', '0', '1', '1', '0', '0', '0'),
  ('1', '1', '1', '0', '1', '0', '0', '0'),
  ('1', '1', '1', '1', '1', '0', '0', '0'));

begin

  u_encoder : encoder
  port map(
    i_REQ0   => w_REQ0,
    i_REQ1   => w_REQ1,
    i_REQ2   => w_REQ2,
    i_REQ3   => w_REQ3,
    o_GRANT0 => w_GRANT0,
    o_GRANT1 => w_GRANT1,
    o_GRANT2 => w_GRANT2,
    o_GRANT3 => w_GRANT3);

  process
  begin

    for i in test_vectors'range loop

      w_REQ0 <= test_vectors(i).i_REQ0;
      w_REQ1 <= test_vectors(i).i_REQ1;
      w_REQ2 <= test_vectors(i).i_REQ2;
      w_REQ3 <= test_vectors(i).i_REQ3;

      wait for 1 ns;

      assert (w_GRANT0 = test_vectors(i).o_GRANT0 and w_GRANT1 = test_vectors(i).o_GRANT1 and w_GRANT2 = test_vectors(i).o_GRANT2 and w_GRANT3 = test_vectors(i).o_GRANT3)
      report "test_vector " & integer'image(i) & " failed " &
        " for inputs = " & std_logic'image(w_REQ0) &
        std_logic'image(w_REQ1) & std_logic'image(w_REQ2) &
        std_logic'image(w_REQ3)
        severity error;

    end loop;

    -- Clear inputs 
    w_REQ0 <= '0';
    w_REQ1 <= '0';
    w_REQ2 <= '0';
    w_REQ3 <= '0';

    assert false report "Test done." severity note;
    wait;

  end process;
end architecture;