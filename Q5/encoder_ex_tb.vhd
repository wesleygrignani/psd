library ieee;
use ieee.std_logic_1164.all;

entity encoder_ex_tb is
  -- empty
end encoder_ex_tb;

architecture rtl of encoder_ex_tb is

  -- DUV component
  component encoder_ex is
    port (
      i_REQ0   : in std_logic;
      i_REQ1   : in std_logic;
      i_REQ2   : in std_logic;
      i_REQ3   : in std_logic;
      o_GRANT0 : out std_logic;
      o_GRANT1 : out std_logic;
      o_GRANT2 : out std_logic;
      o_GRANT3 : out std_logic;
      o_IDEN   : out std_logic_vector(1 downto 0));
  end component;

  -- Signals to connect DUV component
  signal w_REQ0   : std_logic                    := '0';
  signal w_REQ1   : std_logic                    := '0';
  signal w_REQ2   : std_logic                    := '0';
  signal w_REQ3   : std_logic                    := '0';
  signal w_GRANT0 : std_logic                    := '0';
  signal w_GRANT1 : std_logic                    := '0';
  signal w_GRANT2 : std_logic                    := '0';
  signal w_GRANT3 : std_logic                    := '0';
  signal w_IDEN   : std_logic_vector(1 downto 0) := (others => '0');

  type test_vector is record
    i_REQ0, i_REQ1, i_REQ2, i_REQ3         : std_logic;
    o_GRANT0, o_GRANT1, o_GRANT2, o_GRANT3 : std_logic;
    o_IDEN                                 : std_logic_vector(1 downto 0);
  end record;

  type test_vector_array is array (natural range <>) of test_vector;
  constant test_vectors : test_vector_array := (
  -- i_REQ0, i_REQ1, i_REQ2, i_REQ3, o_GRANT0, o_GRANT1, o_GRANT2, o_GRANT3, o_IDEN
  ('0', '0', '0', '0', '0', '0', '0', '0', "00"),
  ('0', '0', '0', '1', '0', '0', '0', '1', "11"),
  ('0', '0', '1', '0', '0', '0', '1', '0', "10"),
  ('0', '0', '1', '1', '0', '0', '1', '0', "10"),
  ('0', '1', '0', '0', '0', '1', '0', '0', "01"),
  ('0', '1', '0', '1', '0', '1', '0', '0', "01"),
  ('0', '1', '1', '0', '0', '1', '0', '0', "01"),
  ('0', '1', '1', '1', '0', '1', '0', '0', "01"),
  ('1', '0', '0', '0', '1', '0', '0', '0', "00"),
  ('1', '0', '0', '1', '1', '0', '0', '0', "00"),
  ('1', '0', '1', '0', '1', '0', '0', '0', "00"),
  ('1', '0', '1', '1', '1', '0', '0', '0', "00"),
  ('1', '1', '0', '0', '1', '0', '0', '0', "00"),
  ('1', '1', '0', '1', '1', '0', '0', '0', "00"),
  ('1', '1', '1', '0', '1', '0', '0', '0', "00"),
  ('1', '1', '1', '1', '1', '0', '0', '0', "00"));

begin

  u_encoder : encoder_ex
  port map(
    i_REQ0   => w_REQ0,
    i_REQ1   => w_REQ1,
    i_REQ2   => w_REQ2,
    i_REQ3   => w_REQ3,
    o_GRANT0 => w_GRANT0,
    o_GRANT1 => w_GRANT1,
    o_GRANT2 => w_GRANT2,
    o_GRANT3 => w_GRANT3,
    o_IDEN   => w_IDEN);

  process
  begin

    for i in test_vectors'range loop

      w_REQ0 <= test_vectors(i).i_REQ0;
      w_REQ1 <= test_vectors(i).i_REQ1;
      w_REQ2 <= test_vectors(i).i_REQ2;
      w_REQ3 <= test_vectors(i).i_REQ3;

      wait for 1 ns;

      assert (w_GRANT0 = test_vectors(i).o_GRANT0 and w_GRANT1 = test_vectors(i).o_GRANT1 and
      w_GRANT2 = test_vectors(i).o_GRANT2 and w_GRANT3 = test_vectors(i).o_GRANT3 and w_IDEN = test_vectors(i).o_IDEN)

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