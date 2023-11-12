library ieee;
use ieee.std_logic_1164.all;

entity cinext is
  port (
    i_XYZ : in std_logic_vector(2 downto 0);
    o_CIN : out std_logic
  );
end entity;

architecture rtl of cinext is

begin

  process (i_XYZ)
  begin
    case i_XYZ is
      when "000" =>
        o_CIN <= '0';
        -- A - B
      when "001" =>
        o_CIN <= '1';
        -- A + 1
      when "010" =>
        o_CIN <= '1';
        -- A
      when "011" =>
        o_CIN <= '0';
        -- A and B
      when "100" =>
        o_CIN <= '0';
        -- A or B
      when "101" =>
        o_CIN <= '0';
        -- A xor B
      when "110" =>
        o_CIN <= '0';
        -- not A
      when "111" =>
        o_CIN <= '0';
      when others =>
        o_CIN <= '0';
    end case;

  end process;

end architecture;