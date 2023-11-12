library ieee;
use ieee.std_logic_1164.all;

entity calc is
  port (
    i_CLK : in std_logic;
    i_RST : in std_logic;
    i_LD  : in std_logic;
    i_A   : in std_logic_vector(7 downto 0);
    i_B   : in std_logic_vector(7 downto 0);
    i_XYZ : in std_logic_vector(2 downto 0);
    o_S   : out std_logic_vector(7 downto 0)
  );
end entity;
architecture rtl of calc is

  component alu
    port (
      i_A   : in std_logic_vector(7 downto 0);
      i_B   : in std_logic_vector(7 downto 0);
      i_XYZ : in std_logic_vector(2 downto 0);
      o_S   : out std_logic_vector(7 downto 0)
    );
  end component;

  component reg
    port (
      i_CLK : in std_logic;
      i_LD  : in std_logic;
      i_RST : in std_logic;
      i_D   : in std_logic_vector(7 downto 0);
      o_Q   : out std_logic_vector(7 downto 0)
    );
  end component;

  signal w_S : std_logic_vector(7 downto 0);

begin

  alu_inst : alu
  port map(
    i_A   => i_A,
    i_B   => i_B,
    i_XYZ => i_XYZ,
    o_S   => w_S
  );

  reg_inst : reg
  port map(
    i_CLK => i_CLK,
    i_LD  => i_LD,
    i_RST => i_RST,
    i_D   => w_S,
    o_Q   => o_S
  );

end architecture;