library ieee;
use ieee.std_logic_1164.all;

entity mux_demux_tb is
  -- empty
end mux_demux_tb;

architecture rtl of mux_demux_tb is
  -- DUV component
  component mux_demux is
    port (
      i_A     : in std_logic; -- data input 
      i_B     : in std_logic; -- data input 
      i_SEL_M : in std_logic; -- mux selector
      i_SEL_D : in std_logic; -- demux selector
      o_S0    : out std_logic; -- data output 
      o_S1    : out std_logic; -- data output
    );
  end component;

  -- Signals to connect DUV component
  signal w_A     : std_logic := '0';
  signal w_B     : std_logic := '0';
  signal w_SEL_M : std_logic := '0';
  signal w_SEL_D : std_logic := '0';
  signal w_S0    : std_logic := '0';
  signal w_S1    : std_logic := '0';

begin

  mux_demux : mux_demux
  port map(
    i_A     => w_A,
    i_B     => w_B,
    i_SEL_M => w_SEL_M,
    i_SEL_D => w_SEL_D,
    o_S0    => w_S0,
    o_S1    => w_S1
  );

  process
  begin

  end process;

end rtl;