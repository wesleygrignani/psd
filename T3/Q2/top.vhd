library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    i_C : in std_logic_vector(15 downto 0);
    o_F : out std_logic_vector(15 downto 0)
  );
end entity;

architecture rtl of top is

  component shift_left_param
    generic (
      n_SHIFT : positive
    );
    port (
      i_A : in std_logic_vector(15 downto 0);
      o_D : out std_logic_vector(15 downto 0)
    );
  end component;

  component shift_right_param
    generic (
      n_SHIFT : positive
    );
    port (
      i_A : in std_logic_vector(15 downto 0);
      o_D : out std_logic_vector(15 downto 0)
    );
  end component;

  component adder
    port (
      i_A : in std_logic_vector(15 downto 0);
      i_B : in std_logic_vector(15 downto 0);
      o_D : out std_logic_vector(15 downto 0)
    );
  end component;

  signal w_SL1 : std_logic_vector(15 downto 0);
  signal w_SL2 : std_logic_vector(15 downto 0);
  signal w_SL5 : std_logic_vector(15 downto 0);
  signal w_SL6 : std_logic_vector(15 downto 0);

  signal w_ADD1_2   : std_logic_vector(15 downto 0);
  signal w_ADD5_6   : std_logic_vector(15 downto 0);
  signal w_ADD_1256 : std_logic_vector(15 downto 0);

  signal w_SR7  : std_logic_vector(15 downto 0);
  signal w_CSR7 : std_logic_vector(15 downto 0);

begin

  shift_left_1 : shift_left_param
  generic map(
    n_SHIFT => 1
  )
  port map(
    i_A => i_C,
    o_D => w_SL1
  );

  shift_left_2 : shift_left_param
  generic map(
    n_SHIFT => 2
  )
  port map(
    i_A => i_C,
    o_D => w_SL2
  );

  shift_left_5 : shift_left_param
  generic map(
    n_SHIFT => 5
  )
  port map(
    i_A => i_C,
    o_D => w_SL5
  );

  shift_left_6 : shift_left_param
  generic map(
    n_SHIFT => 6
  )
  port map(
    i_A => i_C,
    o_D => w_SL6
  );

  adder_1_2 : adder
  port map(
    i_A => w_SL1,
    i_B => w_SL2,
    o_D => w_ADD1_2
  );

  adder_5_6 : adder
  port map(
    i_A => w_SL5,
    i_B => w_SL6,
    o_D => w_ADD5_6
  );

  adder_1256 : adder
  port map(
    i_A => w_ADD1_2,
    i_B => w_ADD5_6,
    o_D => w_ADD_1256
  );

  shift_right_7 : shift_right_param
  generic map(
    n_SHIFT => 7
  )
  port map(
    i_A => w_ADD_1256,
    o_D => w_SR7
  );

  adder_C_SR7 : adder
  port map(
    i_A => i_C,
    i_B => w_SR7,
    o_D => w_CSR7
  );

  adder_CSR7 : adder
  port map(
    i_A => w_CSR7,
    i_B => std_logic_vector(to_unsigned(32, 16)),
    o_D => o_F
  );

end architecture;