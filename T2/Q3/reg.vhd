library ieee;
use ieee.std_logic_1164.all;

entity reg is
  port (
    i_CLK : in std_logic;
    i_RST : in std_logic;
    i_N   : in std_logic_vector(2 downto 0);
    o_N   : out std_logic_vector(2 downto 0)
  );
end reg;

architecture rtl of reg is

begin

  process (i_CLK, i_RST)
  begin
    if (i_RST = '1') then
      o_N <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      o_N <= i_N;
    end if;
  end process;

end architecture;