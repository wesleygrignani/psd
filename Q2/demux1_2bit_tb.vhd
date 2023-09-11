library ieee;
use ieee.std_logic_1164.all;

entity demux1_2bit_tb is
  -- empty
end demux1_2bit_tb;

architecture rtl of demux1_2bit_tb is

  -- DUV component
  component demux1_2bit
    port (
      i_SEL : in std_logic;
      i_D   : in std_logic;
      o_S0  : out std_logic;
      o_S1  : out std_logic);
  end component;

  signal w_SEL : std_logic := '0';
  signal w_D   : std_logic := '0';
  signal w_S0  : std_logic := '0';
  signal w_S1  : std_logic := '0';

begin

  -- Connect DUV
  u_DUT : demux1_2bit
  port map(
    i_SEL => w_SEL,
    i_D   => w_D,
    o_S0  => w_S0,
    o_S1  => w_S1);

  process
  begin

    -- Routing i_D input to o_S0 output 
    w_SEL <= '0';
    w_D   <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 00" severity error;
    assert(w_S1 = '0') report "Fail @ 00" severity error;

    w_SEL <= '0';
    w_D   <= '1';
    wait for 1 ns;
    assert(w_S0 = '1') report "Fail @ 01" severity error;
    assert(w_S1 = '0') report "Fail @ 01" severity error;

    -- Routing i_D input to o_S1 output
    w_SEL <= '1';
    w_D   <= '0';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 10" severity error;
    assert(w_S1 = '0') report "Fail @ 10" severity error;

    w_SEL <= '1';
    w_D   <= '1';
    wait for 1 ns;
    assert(w_S0 = '0') report "Fail @ 11" severity error;
    assert(w_S1 = '1') report "Fail @ 11" severity error;

    -- Clear inputs
    w_SEL <= '0';
    w_D   <= '0';
    assert false report "Test done." severity note;
    wait;

  end process;
end rtl;