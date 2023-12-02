library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
library work;
use work.filter_pkg.all;

entity filter_tb is
end entity;

architecture rtl of filter_tb is

  component filter_top
    port (
      i_clk    : in std_logic;
      i_rst    : in std_logic;
      i_start  : in std_logic;
      i_pixel  : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_filter : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
    );
  end component;

  constant c_CLK_PERIOD : time := 10 ns;

  signal w_clk    : std_logic;
  signal w_rst    : std_logic;
  signal w_start  : std_logic;
  signal w_pixel  : std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  signal w_filter : std_logic_vector(PIXEL_WIDTH - 1 downto 0);

begin

  -- clock process 
  p_CLK : process
  begin
    w_clk <= '0';
    wait for c_CLK_PERIOD/2;
    w_clk <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  filter_top_inst : filter_top
  port map(
    i_clk    => w_clk,
    i_rst    => w_rst,
    i_start  => w_start,
    i_pixel  => w_pixel,
    o_filter => w_filter
  );
  process
  begin
    w_rst   <= '1';
    w_start <= '0';
    w_pixel <= "00000000";
    wait for c_CLK_PERIOD;

    w_rst   <= '0';
    w_start <= '1';
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

    w_pixel <= std_logic_vector(to_unsigned(25, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(26, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(27, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(28, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(29, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(30, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(31, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(32, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(33, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(34, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(35, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

    w_pixel <= std_logic_vector(to_unsigned(36, PIXEL_WIDTH));
    wait for c_CLK_PERIOD;

  end process;
end architecture;