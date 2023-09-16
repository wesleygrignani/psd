library ieee;
use ieee.std_logic_1164.all;

entity encoder_ex is
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
end encoder_ex;

architecture rtl of encoder_ex is

  signal w_GRANT0 : std_logic;
  signal w_GRANT1 : std_logic;
  signal w_GRANT2 : std_logic;
  signal w_GRANT3 : std_logic;

begin

  w_GRANT0 <= '1' when i_REQ0 = '1' else
    '0';

  w_GRANT1 <= '1' when i_REQ0 = '0' and i_REQ1 = '1' else
    '0';

  w_GRANT2 <= '1' when i_REQ0 = '0' and i_REQ1 = '0' and i_REQ2 = '1' else
    '0';

  w_GRANT3 <= '1' when i_REQ0 = '0' and i_REQ1 = '0' and i_REQ2 = '0' and i_REQ3 = '1' else
    '0';

  o_IDEN <= "00" when w_GRANT0 = '1' else
    "01" when w_GRANT1 = '1' else
    "10" when w_GRANT2 = '1' else
    "11" when w_GRANT3 = '1' else
    "UU";

  o_GRANT0 <= w_GRANT0;
  o_GRANT1 <= w_GRANT1;
  o_GRANT2 <= w_GRANT2;
  o_GRANT3 <= w_GRANT3;

end rtl;