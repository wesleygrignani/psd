library ieee;
use ieee.std_logic_1164.all;

package filter_pkg is

  constant KERNEL_SIZE : integer := 3;
  constant IMG_WIDTH   : integer := 10;
  constant PIXEL_WIDTH : integer := 8;

end package filter_pkg;