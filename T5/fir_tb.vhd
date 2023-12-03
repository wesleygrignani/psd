library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity fir_tb is
end entity;

architecture rtl of fir_tb is

  component fir_top
    port (
      i_clk    : in std_logic;
      i_reset  : in std_logic;
      i_START  : in std_logic;
      i_c0     : in std_logic_vector(2 downto 0);
      i_c1     : in std_logic_vector(2 downto 0);
      i_c2     : in std_logic_vector(2 downto 0);
      i_SAMPLE : in std_logic_vector(11 downto 0);
      o_FILTER : out std_logic_vector(11 downto 0)
    );
  end component;

  constant c_CLK_PERIOD : time := 10 ns;

  signal w_clk    : std_logic;
  signal w_reset  : std_logic;
  signal w_start  : std_logic;
  signal w_c0     : std_logic_vector(2 downto 0);
  signal w_c1     : std_logic_vector(2 downto 0);
  signal w_c2     : std_logic_vector(2 downto 0);
  signal w_sample : std_logic_vector(11 downto 0);
  signal w_filter : std_logic_vector(11 downto 0);

begin

  -- clock process 
  p_CLK : process
  begin
    w_clk <= '0';
    wait for c_CLK_PERIOD/2;
    w_clk <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  fir_top_inst : fir_top
  port map(
    i_clk    => w_clk,
    i_reset  => w_reset,
    i_START  => w_start,
    i_c0     => w_c0,
    i_c1     => w_c1,
    i_c2     => w_c2,
    i_SAMPLE => w_sample,
    o_FILTER => w_filter
  );
  process
  begin

    -- reset inicial do sistema 
    w_reset <= '1';
    w_start <= '0';
    wait for c_CLK_PERIOD;

    w_reset <= '0';
    w_start <= '1';
    -- define os coeficientes
    w_c0 <= "001";
    w_c1 <= "010";
    w_c2 <= "011";
    -- defini o valor de entrada
    w_sample <= std_logic_vector(to_unsigned(1, 12));
    wait for c_CLK_PERIOD;
    w_start <= '0';

    w_sample <= std_logic_vector(to_unsigned(2, 12));
    wait for c_CLK_PERIOD * 2;

    w_sample <= std_logic_vector(to_unsigned(3, 12));
    wait for c_CLK_PERIOD * 2;

    w_sample <= std_logic_vector(to_unsigned(4, 12));
    wait for c_CLK_PERIOD * 2;

    w_sample <= std_logic_vector(to_unsigned(5, 12));
    wait for c_CLK_PERIOD * 2;

    w_sample <= std_logic_vector(to_unsigned(6, 12));
    wait for c_CLK_PERIOD * 2;

    w_sample <= std_logic_vector(to_unsigned(7, 12));
    wait for c_CLK_PERIOD * 2;

    wait;
  end process;

end architecture;