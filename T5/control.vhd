library ieee;
use ieee.std_logic_1164.all;

entity control is
  port
  (
    i_CLK         : in std_logic; -- clock
    i_RST         : in std_logic; -- reset/clear
    i_START       : in std_logic;
    i_EQ_val      : in std_logic;
    o_reset       : out std_logic;
    o_en_c012     : out std_logic;
    o_en_contador : out std_logic;
    o_en_y        : out std_logic;
    o_en_xt       : out std_logic

  ); -- data output
end control;

architecture arch_1 of control is
  type t_STATE is (s_INIT, s_COEF, s_IF, s_CALC);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state

begin
  -- State Register
  process (i_RST, i_CLK)
  begin
    if (i_RST = '1') then
      r_STATE <= s_INIT;
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- Next State Function
  process (r_STATE, i_START, i_EQ_val)
  begin
    case r_STATE is
      when s_INIT => if (i_START = '1') then
        w_NEXT <= s_COEF;
      else
        w_NEXT <= s_INIT;
    end if;

    when s_COEF => w_NEXT <= s_IF;

    when s_IF => if (i_EQ_val = '0') then
    w_NEXT <= s_CALC;
  else
    w_NEXT <= s_INIT;
  end if;

  when s_CALC => w_NEXT <= s_IF;

  when others => w_NEXT <= s_INIT;
end case;
end process;

-- Output Function
o_reset <= '1' when(r_STATE = s_INIT) else
  '0';

o_en_c012 <= '1' when(r_STATE = s_COEF) else
  '0';

o_en_contador <= '1' when(r_STATE = s_CALC) else
  '0';

o_en_y <= '1' when(r_STATE = s_CALC) else
  '0';

o_en_xt <= '1' when(r_STATE = s_IF) else
  '0';

end arch_1;