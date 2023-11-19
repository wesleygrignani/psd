-- Nome: Wesley Grignani
-- Desc: Bloco dedicado para as operacoes do filtro 3x3

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.filter_pkg.all;

entity filter_operation is
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
    o_filter        : out std_logic_vector(PIXEL_WIDTH - 1 downto 0));
end entity;

architecture rtl of filter_operation is

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

  -- sinais kernel 3x3
  signal w_kernel_1   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_2   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_3   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_4   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_5   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_6   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_7   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_8   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_9   : integer range 0 to (2 ** PIXEL_WIDTH) - 1;
  signal w_kernel_out : integer;

begin

  w_kernel_1 <= to_integer(unsigned(i_kernel_pixel1));
  w_kernel_2 <= to_integer(unsigned(i_kernel_pixel2));
  w_kernel_3 <= to_integer(unsigned(i_kernel_pixel3));
  w_kernel_4 <= to_integer(unsigned(i_kernel_pixel4));
  w_kernel_5 <= to_integer(unsigned(i_kernel_pixel5));
  w_kernel_6 <= to_integer(unsigned(i_kernel_pixel6));
  w_kernel_7 <= to_integer(unsigned(i_kernel_pixel7));
  w_kernel_8 <= to_integer(unsigned(i_kernel_pixel8));
  w_kernel_9 <= to_integer(unsigned(i_kernel_pixel9));

  -- filtragem desejada 
  w_kernel_out <= (w_kernel_1 + w_kernel_2 + w_kernel_3 + w_kernel_4 + w_kernel_5 + w_kernel_6 + w_kernel_7 + w_kernel_8 + w_kernel_9)/9;

  -- O sinal de load deve ser diferente do sinal de load dos registradores de line buffer e kernel window
  -- O sinal de load só será ativo pelo bloco de controle quando os kernels window estiverem cheios
  reg_inst : reg
  generic map(
    p_WIDTH => PIXEL_WIDTH
  )
  port map(
    i_clk => i_clk,
    i_ena => i_ld,
    i_rst => i_rst,
    i_d   => std_logic_vector(to_unsigned(w_kernel_out, PIXEL_WIDTH)),
    o_q   => o_filter
  );
end architecture;