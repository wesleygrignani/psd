library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
  port (
    i_A : in std_logic_vector(15 downto 0);
    i_B : in std_logic_vector(15 downto 0);
    o_D : out std_logic_vector(15 downto 0)
  );
end entity;

architecture rtl of adder is

begin

  o_D <= std_logic_vector(unsigned(i_A) + unsigned(i_B));

end architecture;