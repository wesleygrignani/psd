library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
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

  -- Buffer for input data file 
  file input_buff : text;

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
    variable read_col_from_input_buff : line;
    variable val_col0                 : integer;
    variable v_space                  : character;
  begin

    file_open(input_buff, "tb_data.txt", READ_MODE);

    w_rst   <= '1';
    w_start <= '0';
    w_pixel <= "00000000";
    wait for c_CLK_PERIOD;

    w_rst   <= '0';
    w_start <= '1';
    wait for c_CLK_PERIOD;

    -- joga valores para o acelerador
    while not endfile(input_buff) loop
      readline(input_buff, read_col_from_input_buff);

      read(read_col_from_input_buff, val_col0); -- amostra da imagem

      -- passa o valor lido do txt para o sinal 
      w_pixel <= std_logic_vector(to_unsigned (val_col0, PIXEL_WIDTH));

      wait for c_CLK_PERIOD;
    end loop;
    file_close(input_buff);
    wait;
  end process;
end architecture;