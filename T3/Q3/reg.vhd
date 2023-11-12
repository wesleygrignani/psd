library ieee;
use ieee.std_logic_1164.all;

entity reg is
  port (
    i_CLK : in std_logic;
    i_LD  : in std_logic;
    i_RST : in std_logic;
    i_D   : in std_logic_vector(7 downto 0);
    o_Q   : out std_logic_vector(7 downto 0)
  );
end reg;

architecture rtl of reg is

begin

  process (i_CLK, i_RST)
  begin
    if (i_RST = '1') then
      o_Q <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      if (i_LD = '1') then
        o_Q <= i_D;
      end if;
    end if;
  end process;

end rtl;