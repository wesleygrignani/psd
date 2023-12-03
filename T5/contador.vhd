library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity contador is
  generic (
    p_WIDTH : positive := 32
  );
  port (
    i_clk : in std_logic;
    i_ena : in std_logic;
    i_rst : in std_logic;
    o_q   : out std_logic_vector(p_WIDTH - 1 downto 0)
  );
end contador;

architecture rtl of contador is

  signal w_cont : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '0');

begin

  process (i_clk, i_rst)
  begin
    if (i_rst = '1') then
      w_cont <= (others => '0');
    elsif (rising_edge(i_clk)) then
      if (i_ena = '1') then
        w_cont <= std_logic_vector(unsigned(w_cont) + 1);
      end if;
    end if;
  end process;

  o_q <= w_cont;

end architecture;