library ieee;
use ieee.std_logic_1164.all;

entity calc_tb is
end entity;

architecture rtl of calc_tb is

  component calc
    port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_LD  : in std_logic;
      i_A   : in std_logic_vector(7 downto 0);
      i_B   : in std_logic_vector(7 downto 0);
      i_XYZ : in std_logic_vector(2 downto 0);
      o_S   : out std_logic_vector(7 downto 0)
    );
  end component;

  -- clock constant
  constant c_CLK_PERIOD : time := 10 ns;

  signal w_CLK : std_logic := '0'; -- clock signal
  signal w_RST : std_logic := '0'; -- reset signal 
  signal w_LD  : std_logic := '0'; -- load signal 

  signal w_A   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_B   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_XYZ : std_logic_vector(2 downto 0) := (others => '0');
  signal w_S   : std_logic_vector(7 downto 0) := (others => '0');

begin

  -- clock process 
  p_CLK : process
  begin
    w_CLK <= '0';
    wait for c_CLK_PERIOD/2;
    w_CLK <= '1';
    wait for c_CLK_PERIOD/2;
  end process;

  calc_inst : calc
  port map(
    i_CLK => w_CLK,
    i_RST => w_RST,
    i_LD  => w_LD,
    i_A   => w_A,
    i_B   => w_B,
    i_XYZ => w_XYZ,
    o_S   => w_S
  );

  process
  begin
    w_A   <= "00001111"; -- value 15
    w_B   <= "00000101"; -- value 5
    w_XYZ <= "000"; -- selector a+b
    -- reset active 
    w_RST <= '1';
    w_LD  <= '0';
    wait for c_CLK_PERIOD;
    assert(w_S = "00000000") report "Fail @ reset" severity error;

    w_RST <= '0';
    w_LD  <= '1';
    wait for c_CLK_PERIOD;
    assert(w_S = "00010100") report "Fail @ A+B" severity error;

    w_XYZ <= "001"; -- selector a - b
    wait for c_CLK_PERIOD;
    assert(w_S = "00001010") report "Fail @ A-B" severity error;

    w_XYZ <= "010"; -- selector a + 1
    wait for c_CLK_PERIOD;
    assert(w_S = "00010000") report "Fail @ A + 1" severity error;
    w_XYZ <= "011"; -- selector a 
    wait for c_CLK_PERIOD;
    assert(w_S = "00001111") report "Fail @ A" severity error;
    w_XYZ <= "100"; -- selector A and B
    wait for c_CLK_PERIOD;
    assert(w_S = "00000101") report "Fail @ A and B" severity error;

    w_XYZ <= "101"; -- selector A or B
    wait for c_CLK_PERIOD;
    assert(w_S = "00001111") report "Fail @ A or B" severity error;

    w_XYZ <= "110"; -- selector A xor B
    wait for c_CLK_PERIOD;
    assert(w_S = "00001010") report "Fail @ A xor B" severity error;
    w_XYZ <= "111"; -- selector not A
    wait for c_CLK_PERIOD;
    assert(w_S = "11110000") report "Fail @ not A" severity error;

    -- clear inputs 
    w_A   <= "00000000";
    w_B   <= "00000000";
    w_XYZ <= "000";
    w_LD  <= '0';

    assert false report "Test done." severity note;
    wait;
  end process;
end architecture;