library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    i_R  : in std_logic_vector(7 downto 0);
    i_G  : in std_logic_vector(7 downto 0);
    i_B  : in std_logic_vector(7 downto 0);
    o_C2 : out std_logic_vector(7 downto 0);
    o_M2 : out std_logic_vector(7 downto 0);
    o_Y2 : out std_logic_vector(7 downto 0);
    o_K  : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of top is

  -- rgb to cmy component
  component rgb_cmy
    port (
      i_R : in std_logic_vector(7 downto 0);
      i_G : in std_logic_vector(7 downto 0);
      i_B : in std_logic_vector(7 downto 0);
      o_C : out std_logic_vector(7 downto 0);
      o_M : out std_logic_vector(7 downto 0);
      o_Y : out std_logic_vector(7 downto 0)
    );
  end component;

  -- minimum component
  component min
    port (
      i_A : in std_logic_vector(7 downto 0);
      i_B : in std_logic_vector(7 downto 0);
      o_D : out std_logic_vector(7 downto 0)
    );
  end component;

  -- subtractor component
  component sub
    port (
      i_A : in std_logic_vector(7 downto 0);
      i_B : in std_logic_vector(7 downto 0);
      o_D : out std_logic_vector(7 downto 0)
    );
  end component;

  signal w_C : std_logic_vector(7 downto 0) := (others => '0');
  signal w_M : std_logic_vector(7 downto 0) := (others => '0');
  signal w_Y : std_logic_vector(7 downto 0) := (others => '0');

  -- signal for min between C and M
  signal w_CM : std_logic_vector(7 downto 0) := (others => '0');

  -- K signal
  signal w_K : std_logic_vector(7 downto 0) := (others => '0');

begin

  -- instance of rgb to cmy converter
  rgb_cmy_inst : rgb_cmy
  port map(
    i_R => i_R,
    i_G => i_G,
    i_B => i_B,
    o_C => w_C,
    o_M => w_M,
    o_Y => w_Y
  );

  -- min between C and M
  min_cm_inst : min
  port map(
    i_A => w_C,
    i_B => w_M,
    o_D => w_CM
  );

  -- min between CM result and Y
  min_cmy_inst : min
  port map(
    i_A => w_CM,
    i_B => w_Y,
    o_D => w_K
  );

  -- C sub K
  sub_c_inst : sub
  port map(
    i_A => w_C,
    i_B => w_K,
    o_D => o_C2
  );

  -- M sub K
  sub_m_inst : sub
  port map(
    i_A => w_M,
    i_B => w_K,
    o_D => o_M2
  );

  -- Y sub K
  sub_y_inst : sub
  port map(
    i_A => w_Y,
    i_B => w_K,
    o_D => o_Y2
  );

  o_K <= w_K;
end architecture;