library ieee;
use ieee.std_logic_1164.all;
library work;
use work.filter_pkg.all;

entity img_buffer is
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
end entity;

architecture rtl of img_buffer is

  component line_buffer
    port (
      i_clk   : in std_logic;
      i_ld    : in std_logic;
      i_rst   : in std_logic;
      i_pixel : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_pixel : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
    );
  end component;

  component kernel_window
    port (
      i_clk    : in std_logic;
      i_ld     : in std_logic;
      i_rst    : in std_logic;
      i_pixel  : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_pixel1 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_pixel2 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_pixel3 : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
    );
  end component;

  -- sinais para line buffer
  signal w_linebuffer_1 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_linebuffer_2 : std_logic_vector(PIXEL_WIDTH - 1);

  -- sinais para kernel window
  signal w_kernel_pixel1 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel2 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel3 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel4 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel5 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel6 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel7 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel8 : std_logic_vector(PIXEL_WIDTH - 1);
  signal w_kernel_pixel9 : std_logic_vector(PIXEL_WIDTH - 1);
begin

  -- primeiro line buffer e kernel window 
  line_buffer_1 : line_buffer
  port map(
    i_clk   => i_clk,
    i_ld    => i_ld,
    i_rst   => i_rst,
    i_pixel => i_pixel,
    o_pixel => w_linebuffer_1
  );

  kernel_window_1 : kernel_window
  port map(
    i_clk    => i_clk,
    i_ld     => i_ld,
    i_rst    => i_rst,
    i_pixel  => w_linebuffer_1,
    o_pixel1 => w_kernel_pixel1,
    o_pixel2 => w_kernel_pixel2,
    o_pixel3 => w_kernel_pixel3
  );

  -- segundo line buffer e kernel window 
  line_buffer_2 : line_buffer
  port map(
    i_clk   => i_clk,
    i_ld    => i_ld,
    i_rst   => i_rst,
    i_pixel => w_kernel_pixel3,
    o_pixel => w_linebuffer_2
  );

  kernel_window_2 : kernel_window
  port map(
    i_clk    => i_clk,
    i_ld     => i_ld,
    i_rst    => i_rst,
    i_pixel  => w_linebuffer_2,
    o_pixel1 => w_kernel_pixel4,
    o_pixel2 => w_kernel_pixel5,
    o_pixel3 => w_kernel_pixel6
  );
  -- terceiro line buffer e kernel window
  line_buffer_3 : line_buffer
  port map(
    i_clk   => i_clk,
    i_ld    => i_ld,
    i_rst   => i_rst,
    i_pixel => w_kernel_pixel6,
    o_pixel => w_linebuffer_3
  );

  kernel_window_3 : kernel_window
  port map(
    i_clk    => i_clk,
    i_ld     => i_ld,
    i_rst    => i_rst,
    i_pixel  => w_linebuffer_3,
    o_pixel1 => w_kernel_pixel7,
    o_pixel2 => w_kernel_pixel8,
    o_pixel3 => w_kernel_pixel9
  );

  o_kernel_pixel1 <= w_kernel_pixel1;
  o_kernel_pixel2 <= w_kernel_pixel2;
  o_kernel_pixel3 <= w_kernel_pixel3;
  o_kernel_pixel4 <= w_kernel_pixel4;
  o_kernel_pixel5 <= w_kernel_pixel5;
  o_kernel_pixel6 <= w_kernel_pixel6;
  o_kernel_pixel7 <= w_kernel_pixel7;
  o_kernel_pixel8 <= w_kernel_pixel8;
  o_kernel_pixel9 <= w_kernel_pixel9;

end architecture;