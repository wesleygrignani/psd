-- Nome: Wesley Grignani
-- Desc: Caminho de dados do filtro

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
library work;
use work.filter_pkg.all;

entity datapath is
  port (
    i_clk              : in std_logic;
    i_rst              : in std_logic;
    i_rst_cont_buffer  : in std_logic; -- reset para o registrador de buferizacao
    i_rst_rebuffer     : in std_logic; -- reset para o registrador de rebuferizacao
    i_rst_first_full   : in std_logic;
    i_en_buffers       : in std_logic;
    i_en_filter        : in std_logic;
    i_en_cont_img      : in std_logic; -- habilita contador da imagem inteira
    i_en_cont_buffer   : in std_logic; -- habilita contador da primeira bufferizacao e para a filtragem
    i_en_cont_rebuffer : in std_logic; -- habilita contador do rebuffer final
    i_en_first_full    : in std_logic;
    i_pixel            : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
    o_end              : out std_logic; -- sinal para informar o bloco de controle que toda imagem foi lida
    o_first_full       : out std_logic; -- sinal para informar que os buffer foram cheios no inicio
    o_end_filter       : out std_logic; -- sinal para informar que a filtragem terminou naquela linha
    o_end_rebuffer     : out std_logic; -- sinal para informar que o rebuffer terminou
    o_filter           : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
  );
end entity;

architecture rtl of datapath is

  -- Componentes do datapath

  component filter_operation
    port (
      i_clk           : in std_logic;
      i_rst           : in std_logic;
      i_ld            : in std_logic;
      i_kernel_pixel1 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel2 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel3 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel4 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel5 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel6 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel7 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel8 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      i_kernel_pixel9 : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_filter        : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
    );
  end component;

  component img_buffer
    port (
      i_clk           : in std_logic;
      i_ld            : in std_logic;
      i_rst           : in std_logic;
      i_pixel         : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel1 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel2 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel3 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel4 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel5 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel6 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel7 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel8 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_kernel_pixel9 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
    );
  end component;

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

  signal w_kernel_pixel1 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel2 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel3 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel4 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel5 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel6 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel7 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel8 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel9 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);

  -- considerando imagem de tamanho maximo de 256
  signal w_img_counter : std_logic_vector(15 downto 0);
  signal w_end         : std_logic;

  signal w_img_buffers    : std_logic_vector(9 downto 0);
  signal w_img_first_full : std_logic_vector(9 downto 0);
  signal w_first_full     : std_logic;
  signal w_end_filter     : std_logic;

  signal w_kernel_rebuffer : std_logic_vector(1 downto 0);
  signal w_end_rebuffer    : std_logic;

begin
  img_buffer_inst : img_buffer
  port map(
    i_clk           => i_clk,
    i_ld            => i_en_buffers,
    i_rst           => i_rst,
    i_pixel         => i_pixel,
    o_kernel_pixel1 => w_kernel_pixel1,
    o_kernel_pixel2 => w_kernel_pixel2,
    o_kernel_pixel3 => w_kernel_pixel3,
    o_kernel_pixel4 => w_kernel_pixel4,
    o_kernel_pixel5 => w_kernel_pixel5,
    o_kernel_pixel6 => w_kernel_pixel6,
    o_kernel_pixel7 => w_kernel_pixel7,
    o_kernel_pixel8 => w_kernel_pixel8,
    o_kernel_pixel9 => w_kernel_pixel9
  );

  filter_operation_inst : filter_operation
  port map(
    i_clk           => i_clk,
    i_rst           => i_rst,
    i_ld            => i_en_filter,
    i_kernel_pixel1 => w_kernel_pixel1,
    i_kernel_pixel2 => w_kernel_pixel2,
    i_kernel_pixel3 => w_kernel_pixel3,
    i_kernel_pixel4 => w_kernel_pixel4,
    i_kernel_pixel5 => w_kernel_pixel5,
    i_kernel_pixel6 => w_kernel_pixel6,
    i_kernel_pixel7 => w_kernel_pixel7,
    i_kernel_pixel8 => w_kernel_pixel8,
    i_kernel_pixel9 => w_kernel_pixel9,
    o_filter        => o_filter
  );

  -- contador da imagem inteira para saber quando acabar a filtragem
  contador_img : contador
  generic map(
    p_WIDTH => 16
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_cont_img,
    i_rst => i_rst,
    o_q   => w_img_counter
  );

  process (w_img_counter)
  begin
    if to_integer(unsigned (w_img_counter)) = IMG_WIDTH * IMG_WIDTH - 1 then
      w_end <= '1';
    else
      w_end <= '0';
    end if;
  end process;

  -- considerando o tamanho maximo da imagem 256 e kernel size 3 (10 bits)
  contador_first_full : contador
  generic map(
    p_WIDTH => 10
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_first_full,
    i_rst => i_rst_first_full,
    o_q   => w_img_first_full
  );

  contador_buffers : contador
  generic map(
    p_WIDTH => 10
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_cont_buffer,
    i_rst => i_rst_cont_buffer,
    o_q   => w_img_buffers
  );

  -- esperar encher os buffers iniciais
  process (w_img_first_full)
  begin
    if to_integer(unsigned (w_img_first_full)) = IMG_WIDTH * KERNEL_SIZE - 1 then
      w_first_full <= '1';
    else
      w_first_full <= '0';
    end if;
  end process;

  -- buffers cheios, esperar filtrar toda as 3 primeiras linhas 
  process (w_img_buffers)
  begin
    if to_integer(unsigned (w_img_buffers)) = IMG_WIDTH - 2 - 1 then
      w_end_filter <= '1';
    else
      w_end_filter <= '0';
    end if;
  end process;

  -- contador para o tamanho do kernel esperar pelo rebuffer quando uma linha termina de processar
  contador_rebuffer : contador
  generic map(
    p_WIDTH => 2
  )
  port map(
    i_clk => i_clk,
    i_ena => i_en_cont_rebuffer,
    i_rst => i_rst_rebuffer,
    o_q   => w_kernel_rebuffer
  );

  process (w_kernel_rebuffer)
  begin
    if to_integer(unsigned (w_kernel_rebuffer)) = KERNEL_SIZE - 1 then
      w_end_rebuffer <= '1';
    else
      w_end_rebuffer <= '0';
    end if;
  end process;

  o_end          <= w_end;
  o_first_full   <= w_first_full;
  o_end_filter   <= w_end_filter;
  o_end_rebuffer <= w_end_rebuffer;

end architecture;