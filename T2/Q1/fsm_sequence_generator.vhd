library ieee;
use ieee.std_logic_1164.all;

entity fsm_sequence_generator is
  port (
    i_CLK : in std_logic; -- clock
    i_RST : in std_logic; -- reset/clear
    o_Z   : out std_logic_vector(3 downto 0)); -- data output
end fsm_sequence_generator;

architecture arch_1 of fsm_sequence_generator is
  type t_STATE is (s_A, s_B, s_C, s_D);
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

  -- Next State Function
  process (r_STATE)
  begin
    case r_STATE is
      when s_A    => w_NEXT    <= s_B;
      when s_B    => w_NEXT    <= s_C;
      when s_C    => w_NEXT    <= s_D;
      when s_D    => w_NEXT    <= s_A;
      when others => w_NEXT <= s_A;
    end case;
  end process;

  -- Output Function
  o_Z <= "0001" when (r_STATE = s_A) else
    "0011" when (r_STATE = s_B) else
    "1100" when (r_STATE = s_C) else
    "1000";

end arch_1;