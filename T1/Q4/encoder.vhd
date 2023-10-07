library ieee;
use ieee.std_logic_1164.all;

entity encoder is
  port (
    i_REQ0   : in std_logic;
    i_REQ1   : in std_logic;
    i_REQ2   : in std_logic;
    i_REQ3   : in std_logic;
    o_GRANT0 : out std_logic;
    o_GRANT1 : out std_logic;
    o_GRANT2 : out std_logic;
    o_GRANT3 : out std_logic);
end encoder;

architecture rtl of encoder is

begin

  o_GRANT0 <= '1' when i_REQ0 = '1' else
    '0';
  o_GRANT1 <= '1' when i_REQ0 = '0' and i_REQ1 = '1' else
    '0';
  o_GRANT2 <= '1' when i_REQ0 = '0' and i_REQ1 = '0' and i_REQ2 = '1' else
    '0';
  o_GRANT3 <= '1' when i_REQ0 = '0' and i_REQ1 = '0' and i_REQ2 = '0' and i_REQ3 = '1' else
    '0';

end rtl;