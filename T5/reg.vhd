library ieee;
use ieee.std_logic_1164.all;

entity reg is
  generic (
    p_WIDTH : positive := 32
  );
  port (
    i_clk : in std_logic;
    i_ena : in std_logic;
    i_rst : in std_logic;
    i_d   : in std_logic_vector(p_WIDTH - 1 downto 0);
    o_q   : out std_logic_vector(p_WIDTH - 1 downto 0)
  );
end reg;

architecture rtl of reg is

begin

  process (i_clk, i_rst)
  begin
    if (i_rst = '1') then
      o_q <= (others => '0');
    elsif (rising_edge(i_clk)) then
      if (i_ena = '1') then
        o_q <= i_d;
      end if;
    end if;
  end process;

end rtl;