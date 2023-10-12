library ieee;
use ieee.std_logic_1164.all;

entity fsm is
  port (
    i_CLK : in std_logic;
    i_RST : in std_logic;
    i_A   : in std_logic;
    o_R   : out std_logic
  );
end fsm;

architecture rtl of fsm is

  component comb_logic
    port (
      i_A : in std_logic;
      i_S : in std_logic_vector(2 downto 0);
      o_R : out std_logic;
      o_N : out std_logic_vector(2 downto 0)
    );
  end component;

  component reg
    port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_N   : in std_logic_vector(2 downto 0);
      o_N   : out std_logic_vector(2 downto 0)
    );
  end component;

  signal w_S : std_logic_vector(2 downto 0) := (others => '0');
  signal w_N : std_logic_vector(2 downto 0) := (others => '0');

begin

  comb_logic_inst : comb_logic
  port map(
    i_A => i_A,
    i_S => w_S,
    o_R => o_R,
    o_N => w_N
  );

  reg_inst : reg
  port map(
    i_CLK => i_CLK,
    i_RST => i_RST,
    i_N   => w_N,
    o_N   => w_S
  );

end architecture;