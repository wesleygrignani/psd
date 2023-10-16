library ieee;
use ieee.std_logic_1164.all;

entity fsm_moore is
  port (
    i_CLK : in std_logic;
    i_RST : in std_logic;
    i_A   : in std_logic;
    i_B   : in std_logic;
    o_Y   : out std_logic
  );
end fsm_moore;

architecture rtl of fsm_moore is

  type t_STATE is (s_A, s_B, s_C);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state

begin

  -- State Register
  process (i_RST, i_CLK)
  begin
    if (i_RST = '1') then
      r_STATE <= s_A;
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- next State function
  process (r_STATE, i_A, i_B)
  begin
    case r_STATE is

      when s_A =>
        if (i_A = '0' and i_B = '1') then
          w_NEXT <= s_B;
          o_Y    <= '1';
        elsif (i_A = '0' and i_B = '0') then
          w_NEXT <= s_C;
          o_Y    <= '1';
        else
          w_NEXT <= s_A;
          o_Y    <= '0';
        end if;

      when s_B =>
        if (i_A = '1') then
          w_NEXT <= s_C;
          o_Y    <= '1';
        else
          w_NEXT <= s_B;
          o_Y    <= '1';
        end if;

      when s_C =>
        if (i_B = '1') then
          w_NEXT <= s_A;
          o_Y    <= '0';
        else
          w_NEXT <= s_C;
          o_Y    <= '1';
        end if;

      when others => w_NEXT <= s_A;
        o_Y                   <= '0';

    end case;
  end process;

end architecture;