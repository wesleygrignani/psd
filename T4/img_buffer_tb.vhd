library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
library work;
use work.filter_pkg.all;

entity img_buffer_tb is
end entity;

architecture rtl of img_buffer_tb is

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

  constant c_CLK_PERIOD : time := 10 ns;

  signal w_clk   : std_logic;
  signal w_ld    : std_logic;
  signal w_rst   : std_logic;
  signal w_pixel : std_logic_vector(PIXEL_WIDTH - 1 downto 0);

  -- output signals from kernel
  signal w_kernel1 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel2 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel3 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel4 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel5 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel6 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel7 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel8 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_kernel9 : std_logic_vector(PIXEL_WIDTH - 1 downto 0);

begin

  -- clock process 
  p_CLK : process
  begin
    w_clk <= '0';
    wait for c_CLK_PERIOD/2;
    w_clk <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  img_buffer_inst : img_buffer
  port map(
    i_clk           => w_clk,
    i_ld            => w_ld,
    i_rst           => w_rst,
    i_pixel         => w_pixel,
    o_kernel_pixel1 => w_kernel1,
    o_kernel_pixel2 => w_kernel2,
    o_kernel_pixel3 => w_kernel3,
    o_kernel_pixel4 => w_kernel4,
    o_kernel_pixel5 => w_kernel5,
    o_kernel_pixel6 => w_kernel6,
    o_kernel_pixel7 => w_kernel7,
    o_kernel_pixel8 => w_kernel8,
    o_kernel_pixel9 => w_kernel9
  );
  process
  begin
    w_rst   <= '1';
    w_ld    <= '0';
    w_pixel <= "00000000";
    wait for c_CLK_PERIOD;

    w_rst   <= '0';
    w_ld    <= '1';
    w_pixel <= std_logic_vector(to_unsigned(1, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(2, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(3, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(4, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(5, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(6, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(7, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(8, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(9, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(10, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(11, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(12, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(13, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(14, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(15, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(16, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(17, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(18, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(19, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(20, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(21, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(22, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(23, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(24, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;
  end process;
end architecture;