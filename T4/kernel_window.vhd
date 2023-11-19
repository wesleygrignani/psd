library ieee;
use ieee.std_logic_1164.all;
library work;
use work.filter_pkg.all;

entity kernel_window is
  port (
    i_clk    : in std_logic;
    i_ld     : in std_logic;
    i_rst    : in std_logic;
    i_pixel  : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
    o_pixel1 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
    o_pixel2 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
    o_pixel3 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
  );
end entity;

architecture rtl of kernel_window is

  type t_kernel_window is array(0 to KERNEL_SIZE) of std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal r_kernel_window : t_kernel_window;

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
    o_q   => r_kernel_window(0)
  );

  o_pixel1 <= r_kernel_window(0);

  gen_linebuffer : for i in 1 to KERNEL_SIZE - 1 generate
    reg_linebuffer : reg
    generic map(
      p_WIDTH => PIXEL_WIDTH
    )
    port map(
      i_clk => i_clk,
      i_ena => i_ld,
      i_rst => i_rst,
      i_d   => r_kernel_window(i - 1),
      o_q   => r_kernel_window(i)
    );
  end generate;

  o_pixel2 <= r_kernel_window(KERNEL_SIZE - 2);
  o_pixel3 <= r_kernel_window(KERNEL_SIZE - 1);

end architecture;