-- Nome: Wesley Grignani
-- Desc: Line buffer para buferizar uma linha da imagem

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.filter_pkg.all;

entity line_buffer is
  port (
    i_clk   : in std_logic;
    i_ld    : in std_logic;
    i_rst   : in std_logic;
    i_pixel : in std_logic_vector(7 downto 0);
    o_pixel : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of line_buffer is

  type t_linebuffer is array(0 to IMG_WIDTH - KERNEL_SIZE) of std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal r_linebuffer : t_linebuffer;

  -- registrador
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

begin

  -- Instanciar o primeiro registrador 
  reg_linebuffer_first : reg
  generic map(
    p_WIDTH => PIXEL_WIDTH
  )
  port map(
    i_clk => i_clk,
    i_ena => i_ld,
    i_rst => i_rst,
    i_d   => i_pixel,
    o_q   => r_linebuffer(0)
  );

  gen_linebuffer : for i in 1 to IMG_WIDTH - KERNEL_SIZE generate
    reg_linebuffer : reg
    generic map(
      p_WIDTH => PIXEL_WIDTH
    )
    port map(
      i_clk => i_clk,
      i_ena => i_ld,
      i_rst => i_rst,
      i_d   => r_linebuffer(i - 1),
      o_q   => r_linebuffer(i)
    );
  end generate;

  o_pixel <= r_linebuffer(IMG_WIDTH - KERNEL_SIZE);

end architecture;