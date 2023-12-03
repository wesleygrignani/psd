library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
library work;
use work.filter_pkg.all;

entity filter_top is
  port (
    axi_clk : in std_logic;
    axi_rst : in std_logic;
    -- AXIS slave interface (Input of filter)
    s_axis_valid : in std_logic;
    s_axis_ready : out std_logic;
    s_axis_last  : in std_logic;
    s_axis_data  : in std_logic_vector(31 downto 0);
    -- AXIS master interface (Output from compressor)
    m_axis_valid : out std_logic;
    m_axis_ready : in std_logic;
    m_axis_last  : out std_logic;
    m_axis_data  : out std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of filter_top is

  -- caminho de dados 
  component datapath
    port (
      i_clk              : in std_logic;
      i_rst              : in std_logic;
      i_rst_cont_buffer  : in std_logic;
      i_rst_rebuffer     : in std_logic;
      i_rst_first_full   : in std_logic;
      i_en_buffers       : in std_logic;
      i_en_filter        : in std_logic;
      i_en_cont_img      : in std_logic;
      i_en_cont_buffer   : in std_logic;
      i_en_cont_rebuffer : in std_logic;
      i_en_first_full    : in std_logic;
      i_pixel            : in std_logic_vector(PIXEL_WIDTH - 1 downto 0);
      o_end              : out std_logic;
      o_first_full       : out std_logic;
      o_end_filter       : out std_logic;
      o_end_rebuffer     : out std_logic;
      o_filter           : out std_logic_vector(PIXEL_WIDTH - 1 downto 0)
    );
  end component;

  -- unidade de controle 
  component control
    port (
      i_CLK               : in std_logic;
      i_RST               : in std_logic;
      i_START             : in std_logic;
      i_first_full        : in std_logic;
      i_end_filter        : in std_logic;
      i_end               : in std_logic;
      i_end_rebuffer      : in std_logic;
      o_rst_buffers       : out std_logic;
      o_rst_cont_buffer   : out std_logic;
      o_rst_rebuffer      : out std_logic;
      o_rst_first_full    : out std_logic;
      o_en_buffers        : out std_logic;
      o_en_filter         : out std_logic;
      o_en_count_buffer   : out std_logic;
      o_en_first_full     : out std_logic;
      o_en_count_image    : out std_logic;
      o_en_count_rebuffer : out std_logic;
      o_valid             : out std_logic
    );
  end component;

  signal w_first_full        : std_logic;
  signal w_end_filter        : std_logic;
  signal w_end               : std_logic;
  signal w_end_rebuffer      : std_logic;
  signal w_rst_buffers       : std_logic;
  signal w_rst_cont_buffer   : std_logic;
  signal w_rst_rebuffer      : std_logic;
  signal w_rst_first_full    : std_logic;
  signal w_en_buffers        : std_logic;
  signal w_en_filter         : std_logic;
  signal w_en_count_buffer   : std_logic;
  signal w_en_first_full     : std_logic;
  signal w_en_count_image    : std_logic;
  signal w_en_count_rebuffer : std_logic;

begin

  control_inst : control
  port map(
    i_CLK               => axi_clk,
    i_RST               => axi_rst,
    i_START             => s_axis_valid,
    i_first_full        => w_first_full,
    i_end_filter        => w_end_filter,
    i_end               => w_end,
    i_end_rebuffer      => w_end_rebuffer,
    o_rst_buffers       => w_rst_buffers,
    o_rst_cont_buffer   => w_rst_cont_buffer,
    o_rst_rebuffer      => w_rst_rebuffer,
    o_rst_first_full    => w_rst_first_full,
    o_en_buffers        => w_en_buffers,
    o_en_filter         => w_en_filter,
    o_en_count_buffer   => w_en_count_buffer,
    o_en_first_full     => w_en_first_full,
    o_en_count_image    => w_en_count_image,
    o_en_count_rebuffer => w_en_count_rebuffer,
    o_valid             => m_axis_valid
  );

  datapath_inst : datapath
  port map(
    i_clk              => axi_clk,
    i_rst              => w_rst_buffers,
    i_rst_cont_buffer  => w_rst_cont_buffer,
    i_rst_rebuffer     => w_rst_rebuffer,
    i_rst_first_full   => w_rst_first_full,
    i_en_buffers       => w_en_buffers,
    i_en_filter        => w_en_filter,
    i_en_cont_img      => w_en_count_image,
    i_en_cont_buffer   => w_en_count_buffer,
    i_en_cont_rebuffer => w_en_count_rebuffer,
    i_en_first_full    => w_en_first_full,
    i_pixel            => s_axis_data(7 downto 0),
    o_end              => w_end,
    o_first_full       => w_first_full,
    o_end_filter       => w_end_filter,
    o_end_rebuffer     => w_end_rebuffer,
    o_filter           => m_axis_data(7 downto 0)
  );

  s_axis_ready <= '1';
  m_axis_last  <= s_axis_last;

end architecture;