library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity min is
  port (
    i_A : in std_logic_vector(7 downto 0);
    i_B : in std_logic_vector(7 downto 0);
    o_D : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of min is

  signal w_D : std_logic_vector(7 downto 0);

begin

  process (i_A, i_B)
  begin
    if (unsigned(i_A) < unsigned(i_B)) then
      w_D <= i_A;
    else
      w_D <= i_B;
    end if;
  end process;

  o_D <= w_D;

end architecture;