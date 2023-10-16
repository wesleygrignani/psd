library ieee;
use ieee.std_logic_1164.all;

entity fsm_watch is
  port (
    i_CLK : in std_logic;
    i_RST : in std_logic;
    i_B   : in std_logic;
    o_S   : out std_logic_vector(1 downto 0)
  );
end fsm_watch;

architecture rtl of fsm_watch is
  type t_STATE is (s_TIME, s_TIME_AUX, s_ALARM, s_ALARM_AUX, s_STOPWATCH, s_STOPWATCH_AUX, s_DATE, s_DATE_AUX);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state
  signal w_B     : std_logic := '0';

begin

  w_B <= i_B;

  -- State Register
  process (i_RST, i_CLK)
  begin
    if (i_RST = '1') then
      r_STATE <= s_TIME;
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- Next State Function
  process (r_STATE, w_B)
  begin
    case r_STATE is

      when s_TIME =>
        if (falling_edge(w_B)) then
          w_NEXT <= s_ALARM;
        else
          w_NEXT <= s_TIME;
        end if;

      when s_ALARM =>
        if (falling_edge(w_B)) then
          w_NEXT <= s_STOPWATCH;
        else
          w_NEXT <= s_ALARM;
        end if;

      when s_STOPWATCH =>
        if (falling_edge(w_B)) then
          w_NEXT <= s_DATE;
        else
          w_NEXT <= s_STOPWATCH;
        end if;

      when s_DATE =>
        if (falling_edge(w_B)) then
          w_NEXT <= s_TIME;
        else
          w_NEXT <= s_DATE;
        end if;

        -- when s_TIME =>
        --   if (i_B = '1') then
        --     w_NEXT <= s_TIME_AUX;
        --   else
        --     w_NEXT <= s_TIME;
        --   end if;

        -- when s_TIME_AUX =>
        --   if (i_B = '0') then
        --     w_NEXT <= s_ALARM;
        --   else
        --     w_NEXT <= s_TIME_AUX;
        --   end if;

        -- when s_ALARM =>
        --   if (i_B = '1') then
        --     w_NEXT <= s_ALARM_AUX;
        --   else
        --     w_NEXT <= s_ALARM;
        --   end if;

        -- when s_ALARM_AUX =>
        --   if (i_B = '0') then
        --     w_NEXT <= s_STOPWATCH;
        --   else
        --     w_NEXT <= s_ALARM_AUX;
        --   end if;

        -- when s_STOPWATCH =>
        --   if (i_B = '1') then
        --     w_NEXT <= s_STOPWATCH_AUX;
        --   else
        --     w_NEXT <= s_STOPWATCH;
        --   end if;

        -- when s_STOPWATCH_AUX =>
        --   if (i_B = '0') then
        --     w_NEXT <= s_DATE;
        --   else
        --     w_NEXT <= s_STOPWATCH_AUX;
        --   end if;

        -- when s_DATE =>
        --   if (i_B = '1') then
        --     w_NEXT <= s_DATE_AUX;
        --   else
        --     w_NEXT <= s_DATE;
        --   end if;

        -- when s_DATE_AUX =>
        --   if (i_B = '0') then
        --     w_NEXT <= s_TIME;
        --   else
        --     w_NEXT <= s_DATE_AUX;
        --   end if;

      when others => w_NEXT <= s_TIME;
    end case;
  end process;

  -- Output function
  -- o_S <= "00" when (r_STATE = s_TIME or r_STATE = s_TIME_AUX) else
  --   "01" when (r_STATE = s_ALARM or r_STATE = s_ALARM_AUX) else
  --   "10" when (r_STATE = s_STOPWATCH or r_STATE = s_STOPWATCH_AUX) else
  --   "11" when (r_STATE = s_DATE or r_STATE = s_DATE_AUX) else
  --   "00";

  o_S <= "00" when (r_STATE = s_TIME) else
    "01" when (r_STATE = s_ALARM) else
    "10" when (r_STATE = s_STOPWATCH) else
    "11" when (r_STATE = s_DATE) else
    "00";

end architecture;