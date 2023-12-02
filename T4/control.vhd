library ieee;
use ieee.std_logic_1164.all;

entity control is
  port (
    i_CLK               : in std_logic; -- clock
    i_RST               : in std_logic; -- reset/clear
    i_START             : in std_logic;
    o_rst_buffers       : out std_logic; -- reset para os buffers e contador da imagem
    o_rst_cont_buffer   : out std_logic; -- reset para o contador first full e filtrar pela imagem
    o_rst_rebuffer      : out std_logic; -- reset para o contador final do rebuffer
    o_en_buffers        : out std_logic; -- enable dos buffers 
    o_en_filter         : out std_logic; -- enable do registrador da filtragem
    o_en_count_buffer   : out std_logic; -- enable do registrador contador first full e filtrar pela imagem
    o_en_count_image    : out std_logic; -- enable do registrador contador da imagem
    o_en_count_rebuffer : out std_logic -- enable do registrador contador do rebuffer
  );
end control;

architecture arch_1 of control is
  type t_STATE is (s_init, s_buffer, s_img_filter, s_wait_full);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state

begin
  -- State Register
  process (i_RST, i_CLK)
  begin
    if (i_RST = '1') then
      r_STATE <= s_init;
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- Next State Function
  process (r_STATE)
  begin
    case r_STATE is
        -- estado inicial 
      when s_init => if (i_START = '1') then
        w_NEXT <= s_buffer;
      else
        w_NEXT <= s_init;
    end if;

    -- aguarda encher os buffers 
    when s_buffer => if (i_first_full = '1') then
    w_NEXT <= s_img_filter;
  else
    w_NEXT <= s_buffer;
  end if;

  -- filtra pelo tamanho da imagem e tambem verifica se ja acabou de percorrer toda imagem
  when s_img_filter =>
  if (i_end_filter = '1') then
    if (i_end = '1') then
      w_NEXT <= s_init;
    else
      w_NEXT <= s_wait_full;
    end if;
  else
    w_NEXT <= s_img_filter;
  end if;

  -- espera reencher os buffers na ordem correta
  when s_wait_full => if (i_end_rebuffer = '1') then
  w_NEXT <= s_img_filter;
else
  w_NEXT <= s_wait_full;
end if;

when others => w_NEXT <= s_init;
end case;
end process;

-- Output Function

o_rst_buffers <= '1' when (r_STATE = s_init) else
  '0';

o_rst_cont_buffer <= '1' when
end arch_1;