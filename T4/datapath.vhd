-- Nome: Wesley Grignani
-- Desc: Caminho de dados do filtro

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
library work;
use work.filter_pkg.all;

entity datapath is
  port (
    i_clk        : in std_logic;
    i_rst        : in std_logic;
    i_en_buffers : in std_logic;
    i_en_filter  : in std_logic;
    i_pixel      : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
    o_filter     : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
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

  signal w_kernel_pixel1 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel2 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel3 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel4 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel5 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel6 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel7 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel8 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel_pixel9 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);

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

end architecture;