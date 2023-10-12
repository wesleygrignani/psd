library ieee;
use ieee.std_logic_1164.all;

entity comb_logic is
  port (
    i_A : in std_logic;
    i_S : in std_logic_vector(2 downto 0);
    o_R : out std_logic;
    o_N : out std_logic_vector(2 downto 0)
  );
end comb_logic;

architecture rtl of comb_logic is

begin

  o_N(2) <= ((not i_S(2)) and i_S(1) and i_S(0));

  o_N(1) <= ((not i_S(2)) and (not i_S(1)) and i_S(0)) or ((not i_S(2)) and i_S(1) and (not i_S(0)));

  o_N(0) <= ((not i_S(2)) and i_S(1) and (not i_S(0))) or ((not i_S(2)) and (not i_S(0) and i_A));

  o_R <= ((not i_S(2)) and (not i_S(1)) and i_S(0)) or ((not i_S(2)) and i_S(1) and (not i_S(0))) or (i_S(2) and (not i_S(1)) and (not i_S(0)));

end architecture;