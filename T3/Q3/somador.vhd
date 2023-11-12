library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
  port (
    i_A   : in std_logic_vector(7 downto 0);
    i_B   : in std_logic_vector(7 downto 0);
    i_CIN : in std_logic;
    o_S   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of somador is

begin

  o_S <= std_logic_vector(unsigned(i_A) + unsigned(i_B) + ("0000000" & i_CIN));

end architecture;