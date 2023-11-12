library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abext is
  port (
    i_A   : in std_logic;
    i_B   : in std_logic;
    i_XYZ : in std_logic_vector(2 downto 0);
    o_A   : out std_logic;
    o_B   : out std_logic
  );
end entity;

architecture rtl of abext is

begin

  process (i_XYZ, i_A, i_B)
  begin

    case i_XYZ is
        -- A + B
      when "000" =>
        o_A <= i_A;
        o_B <= i_B;
        -- A - B
      when "001" =>
        o_A <= i_A;
        o_B <= not i_B;
        -- A + 1
      when "010" =>
        o_A <= i_A;
        o_B <= '0';
        -- A
      when "011" =>
        o_A <= i_A;
        o_B <= '0';
        -- A and B
      when "100" =>
        o_A <= i_A and i_B;
        o_B <= '0';
        -- A or B
      when "101" =>
        o_A <= i_A or i_B;
        o_B <= '0';
        -- A xor B
      when "110" =>
        o_A <= i_A xor i_B;
        o_B <= '0';
        -- not A
      when "111" =>
        o_A <= not i_A;
        o_B <= '0';

      when others =>
        o_A <= '0';
        o_B <= '0';
    end case;

  end process;

end architecture;