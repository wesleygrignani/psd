library ieee;
use ieee.std_logic_1164.all;

entity fsm_car is
  port (
    i_CLK : in std_logic; -- clock
    i_RST : in std_logic; -- reset/clear
    i_A   : in std_logic; -- key car
    o_R   : out std_logic); -- data output
end fsm_car;

architecture arch_1 of fsm_car is
  type t_STATE is (s_K1, s_K2, s_K3, s_K4, s_WAIT);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state

begin
  -- State Register
  process (i_RST, i_CLK)
  begin
    if (i_RST = '1') then
      r_STATE <= s_WAIT;
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- Next State Function
  process (r_STATE)
  begin
    case r_STATE is
      when s_WAIT => if (i_A = '1') then
        w_NEXT <= s_K1;
      else
        w_NEXT <= s_WAIT;
    end if;

    when s_K1 => w_NEXT <= s_K2;

    when s_K2 => w_NEXT <= s_K3;

    when s_K3 => w_NEXT <= s_K4;

    when s_K4 => w_NEXT <= s_WAIT;

    when others => w_NEXT <= s_WAIT;
  end case;
end process;

-- Output Function
o_R <= '1' when (r_STATE = s_K1 and r_STATE = s_K2 and r_STATE = s_K4) else
  '0';

end arch_1;