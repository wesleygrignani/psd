library ieee;
use ieee.std_logic_1164.all;

entity demux1_2bit is
  port (
    i_SEL : in std_logic; -- selector
    i_D   : in std_logic; -- data input
    o_S0  : out std_logic; -- data output
    o_S1  : out std_logic); -- data output
end demux1_2bit;

architecture rtl of demux1_2bit is

begin

end architecture;