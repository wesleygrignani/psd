library ieee;
use ieee.std_logic_1164.all;

entity temp_tb is
end entity;

architecture rtl of temp_tb is

  component top
    port (
      i_C : in std_logic_vector(15 downto 0);
      o_F : out std_logic_vector(15 downto 0)
    );
  end component;

  signal w_C : std_logic_vector(15 downto 0) := (others => '0');
  signal w_F : std_logic_vector(15 downto 0) := (others => '0');

begin

  top_inst : top
  port map(
    i_C => w_C,
    o_F => w_F
  );

  process
  begin

    -- set celsius temperature
    w_C <= "0000000001000000";
    wait for 1 ns;
    assert(w_F = "0000000010010011") report "Fail @ 0000000001000000" severity error;

    -- clear input 
    w_C <= "0000000000000000";
    assert false report "Test done." severity note;
    wait;

  end process;
end architecture;