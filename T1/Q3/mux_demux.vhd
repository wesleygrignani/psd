library ieee;
use ieee.std_logic_1164.all;

entity mux_demux is
  port (
    i_A     : in std_logic; -- data input 
    i_B     : in std_logic; -- data input 
    i_SEL_M : in std_logic; -- mux selector
    i_SEL_D : in std_logic; -- demux selector
    o_S0    : out std_logic; -- data output 
    o_S1    : out std_logic); -- data output
end mux_demux;

architecture rtl of mux_demux is

  -- mux component
  component mux2_1bit
    port (
      i_SEL : in std_logic;
      i_A   : in std_logic;
      i_B   : in std_logic;
      o_S   : out std_logic);
  end component;

  -- demux component
  component demux1_2bit
    port (
      i_SEL : in std_logic;
      i_D   : in std_logic;
      o_S0  : out std_logic;
      o_S1  : out std_logic);
  end component;

  signal w_D : std_logic := '0'; -- signal to connect mux output to demux input

begin

  mux : mux2_1bit
  port map(
    i_SEL => i_SEL_M,
    i_A   => i_A,
    i_B   => i_B,
    o_S   => w_D);

  demux : demux1_2bit
  port map(
    i_SEL => i_SEL_D,
    i_D   => w_D,
    o_S0  => o_S0,
    o_S1  => o_S1);

end rtl;