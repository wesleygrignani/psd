library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity datapath is
  port (
    i_clk         : in std_logic;
    i_rst         : in std_logic;
    i_en_xt_regs  : in std_logic;
    i_en_c012     : in std_logic;
    i_en_contador : in std_logic;
    i_en_y        : in std_logic;
    i_data        : in std_logic_vector(11 downto 0);
    i_c0          : in std_logic_vector(2 downto 0);
    i_c1          : in std_logic_vector(2 downto 0);
    i_c2          : in std_logic_vector(2 downto 0);
    o_end         : out std_logic;
    o_output      : out std_logic_vector(11 downto 0)
  );
end entity;
architecture rtl of datapath is

  -- Registrador 
  component reg
    generic (
      p_WIDTH : positive
    );
    port (
      i_clk : in std_logic;
      i_ena : in std_logic;
      i_rst : in std_logic;
      i_d   : in std_logic_vector(p_WIDTH - 1 downto 0);
      o_q   : out std_logic_vector(p_WIDTH - 1 downto 0)
    );
  end component;

  -- registrador contador
  component contador
    generic (
      p_WIDTH : positive
    );
    port (
      i_clk : in std_logic;
      i_ena : in std_logic;
      i_rst : in std_logic;
      o_q   : out std_logic_vector(p_WIDTH - 1 downto 0)
    );
  end component;

  -- Sinais dos resgistradores 
  signal w_xt1 : std_logic_vector(11 downto 0) := (others => '0');
  signal w_xt2 : std_logic_vector(11 downto 0) := (others => '0');
  signal w_xt3 : std_logic_vector(11 downto 0) := (others => '0');

  -- Sinais dos coeficientes 
  signal w_c0 : std_logic_vector(2 downto 0) := (others => '0');
  signal w_c1 : std_logic_vector(2 downto 0) := (others => '0');
  signal w_c2 : std_logic_vector(2 downto 0) := (others => '0');

  signal w_multc0 : integer;
  signal w_multc1 : integer;
  signal w_multc2 : integer;
  signal w_sum1   : integer;
  signal w_sum2   : integer;

  signal w_cont : std_logic_vector(9 downto 0);

  signal w_end : std_logic;

begin
  -- Registradores da entrada
  reg_xt0 : reg
  generic map(
    p_WIDTH => 12
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_xt_regs,
    i_rst => i_rst,
    i_d   => i_data,
    o_q   => w_xt1
  );

  reg_xt1 : reg
  generic map(
    p_WIDTH => 12
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_xt_regs,
    i_rst => i_rst,
    i_d   => w_xt1,
    o_q   => w_xt2
  );

  reg_xt2 : reg
  generic map(
    p_WIDTH => 12
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_xt_regs,
    i_rst => i_rst,
    i_d   => w_xt2,
    o_q   => w_xt3
  );

  -- registradores constantes
  reg_c0 : reg
  generic map(
    p_WIDTH => 3
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_c012,
    i_rst => i_rst,
    i_d   => i_c0,
    o_q   => w_c0
  );

  reg_c1 : reg
  generic map(
    p_WIDTH => 3
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_c012,
    i_rst => i_rst,
    i_d   => i_c1,
    o_q   => w_c1
  );

  reg_c2 : reg
  generic map(
    p_WIDTH => 3
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_c012,
    i_rst => i_rst,
    i_d   => i_c2,
    o_q   => w_c2
  );

  w_multc0 <= to_integer(unsigned(w_xt1)) * to_integer(unsigned(w_c0));
  w_multc1 <= to_integer(unsigned(w_xt2)) * to_integer(unsigned(w_c1));
  w_multc2 <= to_integer(unsigned(w_xt3)) * to_integer(unsigned(w_c2));

  w_sum1 <= w_multc0 + w_multc1;
  w_sum2 <= w_sum1 + w_multc2;

  -- Registrador de saida
  reg_y : reg
  generic map(
    p_WIDTH => 12
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_y,
    i_rst => i_rst,
    i_d   => std_logic_vector(to_unsigned(w_sum2, 12)),
    o_q   => o_output
  );

  contador_inst : contador
  generic map(
    p_WIDTH => 10
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_contador,
    i_rst => i_rst,
    o_q   => w_cont
  );

  -- esperar encher os buffers iniciais
  process (w_cont)
  begin
    if to_integer(unsigned(w_cont)) = 15 then
      w_end <= '1';
    else
      w_end <= '0';
    end if;
  end process;

  o_end <= w_end;

end architecture;