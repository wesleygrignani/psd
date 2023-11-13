library ieee;
use ieee.std_logic_1164.all;

entity rgb_cmyk_tb is
end entity;

architecture rtl of rgb_cmyk_tb is

  component top
    port (
      i_R  : in std_logic_vector(7 downto 0);
      i_G  : in std_logic_vector(7 downto 0);
      i_B  : in std_logic_vector(7 downto 0);
      o_C2 : out std_logic_vector(7 downto 0);
      o_M2 : out std_logic_vector(7 downto 0);
      o_Y2 : out std_logic_vector(7 downto 0);
      o_K  : out std_logic_vector(7 downto 0)
    );
  end component;

  signal w_R  : std_logic_vector(7 downto 0);
  signal w_G  : std_logic_vector(7 downto 0);
  signal w_B  : std_logic_vector(7 downto 0);
  signal w_C2 : std_logic_vector(7 downto 0);
  signal w_M2 : std_logic_vector(7 downto 0);
  signal w_Y2 : std_logic_vector(7 downto 0);
  signal w_K  : std_logic_vector(7 downto 0);

begin

  -- Connect DUV
  top_inst : top
  port map(
    i_R  => w_R,
    i_G  => w_G,
    i_B  => w_B,
    o_C2 => w_C2,
    o_M2 => w_M2,
    o_Y2 => w_Y2,
    o_K  => w_K
  );

  process
  begin

    w_R <= "01100100";
    w_G <= "01100100";
    w_B <= "01100100";

    wait for 1 ns;
    assert(w_C2 = "00000000") report "Fail @ R100 G100 B100" severity error;
    assert(w_M2 = "00000000") report "Fail @ R100 G100 B100" severity error;
    assert(w_Y2 = "00000000") report "Fail @ R100 G100 B100" severity error;
    assert(w_K = "00111101") report "Fail @ 000" severity error;

    w_R <= "01100100";
    w_G <= "01000000";
    w_B <= "00011000";

    wait for 1 ns;
    assert(w_C2 = "00000000") report "Fail @ R100 G64 B24" severity error;
    assert(w_M2 = "00100100") report "Fail @ R100 G64 B24" severity error;
    assert(w_Y2 = "01001100") report "Fail @ R100 G64 B24" severity error;
    assert(w_K = "10011011") report "Fail @ 000" severity error;

    w_R <= "00000000";
    w_G <= "00000000";
    w_B <= "00000000";
    assert false report "Test done." severity note;
    wait;
  end process;
end architecture;