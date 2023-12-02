library ieee;
use ieee.std_logic_1164.all;

entity control is
  port (
    i_CLK               : in std_logic; -- clock
    i_RST               : in std_logic; -- reset/clear
    i_START             : in std_logic; -- sinal de start para comecar o calculo
    i_first_full        : in std_logic; -- sinal informando que terminou o first full buffering
    i_end_filter        : in std_logic; -- sinal informando que terminou a filtragem nas 3 primeiras linhas
    i_end               : in std_logic; -- sinal informando que terminou a filtragem toda da imagem
    i_end_rebuffer      : in std_logic; -- sinal informando que o rebuffer terminou
    o_rst_buffers       : out std_logic; -- reset para os buffers e contador da imagem
    o_rst_cont_buffer   : out std_logic; -- reset para o contador filtrar pela imagem
    o_rst_rebuffer      : out std_logic; -- reset para o contador final do 
    o_rst_first_full    : out std_logic; -- reset para o contador first full
    o_en_buffers        : out std_logic; -- enable dos buffers 
    o_en_filter         : out std_logic; -- enable do registrador da filtragem
    o_en_count_buffer   : out std_logic; -- enable do registrador contador filtrar pela imagem
    o_en_first_full     : out std_logic; -- enable do registrador contador first full
    o_en_count_image    : out std_logic; -- enable do registrador contador da imagem
    o_en_count_rebuffer : out std_logic; -- enable do registrador contador do rebuffer
    o_valid : out std_logic -- sinal para informar que a saida é valida
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
  process (r_STATE, i_START, i_first_full, i_end_filter, i_end, i_end_rebuffer)
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

-- Ativacao dos resets 
-- habilita o reset dos buffers somente no estado inicial 
o_rst_buffers <= '1' when (r_STATE = s_init) else
  '0';
-- habilita o reset do contador first full no estado inicial
o_rst_first_full <= '1' when (r_STATE = s_init) else
  '0';
-- habilita o reset do contador da filtragem no estado anterior a ele (s_buffer) e no posterior (s_wait_full) 
o_rst_cont_buffer <= '1' when (r_STATE = s_buffer or r_STATE = s_wait_full) else
  '0';
-- habilita o reset do contador do rebuffer quando esta no estado anterior (s_img_filter)
o_rst_rebuffer <= '1' when (r_STATE = s_img_filter) else
  '0';

-- Ativacao dos enables 
-- enable dos buffers sempre devem estar recebendo valores de entrada menos no estado init
o_en_buffers <= '1' when (r_STATE = s_buffer or r_STATE = s_img_filter or r_STATE = s_wait_full) else
  '0';
-- enable do registrador de filtragem so pode ser ativo no estado de filtragem
o_en_filter <= '1' when (r_STATE = s_img_filter) or i_first_full = '1' or i_end_rebuffer = '1' else
  '0';
-- enable do contador first full so pode ser ativo no estado buffer
o_en_first_full <= '1' when (r_STATE = s_buffer) else
  '0';
-- enable do contador de filtagem pela imagem so pode ser ativo no estado de filtragem
o_en_count_buffer <= '1' when (r_STATE = s_img_filter) else
  '0';
-- enable do contador de rebuffer so pode ser ativo no estado wait full
o_en_count_rebuffer <= '1' when (r_STATE = s_wait_full) else
  '0';
-- enable do contador da imagem deve ser ativo em todos os estados menos init 
o_en_count_image <= '1' when (r_STATE = s_buffer or r_STATE = s_img_filter or r_STATE = s_wait_full) else
  '0';
  
o_valid <= '1' when r_STATE = s_img_filter else '0';

end arch_1;