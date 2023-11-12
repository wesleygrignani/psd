library ieee;
use ieee.std_logic_1164.all;

entity al_extender is
  port (
    i_A   : in std_logic_vector(7 downto 0);
    i_B   : in std_logic_vector(7 downto 0);
    i_XYZ : in std_logic_vector(2 downto 0);
    o_IA  : out std_logic_vector(7 downto 0);
    o_IB  : out std_logic_vector(7 downto 0);
    o_CIN : out std_logic
  );
end entity;

architecture rtl of al_extender is

  component abext
    port (
      i_A   : in std_logic;
      i_B   : in std_logic;
      i_XYZ : in std_logic_vector(2 downto 0);
      o_A   : out std_logic;
      o_B   : out std_logic
    );
  end component;

  component cinext
    port (
      i_XYZ : in std_logic_vector(2 downto 0);
      o_CIN : out std_logic
    );
  end component;

begin

  -- Generate 8 instances of alu extender 
  alu_extender :
  for i in 7 downto 0 generate
    abext_inst : abext
    port map(
      i_A   => i_A(i),
      i_B   => i_B(i),
      i_XYZ => i_XYZ,
      o_A   => o_IA(i),
      o_B   => o_IB(i)
    );
  end generate;

  -- CIN logic 
  cinext_inst : cinext
  port map(
    i_XYZ => i_XYZ,
    o_CIN => o_CIN
  );

end architecture;