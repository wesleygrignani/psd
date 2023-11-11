library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left_param is
  generic (
    n_SHIFT : positive := 32
  );
  port (
    i_A : in std_logic_vector(15 downto 0);
    o_D : out std_logic_vector(15 downto 0)
  );
end entity;

architecture rtl of shift_left_param is

begin

  o_D <= std_logic_vector(shift_left(unsigned(i_A), n_SHIFT));

end architecture;