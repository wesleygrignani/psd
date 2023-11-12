library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port (
    i_A   : in std_logic_vector(7 downto 0);
    i_B   : in std_logic_vector(7 downto 0);
    i_XYZ : in std_logic_vector(2 downto 0);
    o_S   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of alu is

  component al_extender
    port (
      i_A   : in std_logic_vector(7 downto 0);
      i_B   : in std_logic_vector(7 downto 0);
      i_XYZ : in std_logic_vector(2 downto 0);
      o_IA  : out std_logic_vector(7 downto 0);
      o_IB  : out std_logic_vector(7 downto 0);
      o_CIN : out std_logic
    );
  end component;

  component somador
    port (
      i_A   : in std_logic_vector(7 downto 0);
      i_B   : in std_logic_vector(7 downto 0);
      i_CIN : in std_logic;
      o_S   : out std_logic_vector(7 downto 0)
    );
  end component;

  signal w_IA  : std_logic_vector(7 downto 0) := (others => '0');
  signal w_IB  : std_logic_vector(7 downto 0) := (others => '0');
  signal w_CIN : std_logic                    := '0';

begin

  al_extender_inst : al_extender
  port map(
    i_A   => i_A,
    i_B   => i_B,
    i_XYZ => i_XYZ,
    o_IA  => w_IA,
    o_IB  => w_IB,
    o_CIN => w_CIN
  );

  somador_inst : somador
  port map(
    i_A   => w_IA,
    i_B   => w_IB,
    i_CIN => w_CIN,
    o_S   => o_S
  );

end architecture;