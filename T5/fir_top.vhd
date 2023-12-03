entity fir_top is
  port
  (
    i_clk    : in std_logic;
    i_reset  : in std_logic;
    i_START  : in std_logic;
    i_c0     : in std_logic_vector(2 downto 0);
    i_c1     : in std_logic_vector(2 downto 0);
    i_c2     : in std_logic_vector(2 downto 0);
    i_SAMPLE : in std_logic_vector(11 downto 0);
    o_FILTER : out std_logic_vector(11 downto 0)
  );
end entity;

architecture rtl of fir_top is

  component datapath
    port
    (
      i_clk         : in std_logic;
      i_rst         : in std_logic;
      i_en_xt_regs  : in std_logic;
      i_en_c012     : in std_logic;
      i_en_contador : in std_logic;
      i_en_y        : in std_logic;
      i_data        : in std_logic_vector(11 downto 0);
      i_c0          : in std_logic_vector(2 downto 0);
      i_c1          : in std_logic_vector(2 downto 0);
      i_c2          : in std_logic_vector(2 downto 0);
      o_end         : out std_logic;
      o_output      : out std_logic_vector(11 downto 0)
    );
  end component;
  component control
    port
    (
      i_CLK         : in std_logic;
      i_RST         : in std_logic;
      i_START       : in std_logic;
      i_EQ_val      : in std_logic;
      o_reset       : out std_logic;
      o_en_c012     : out std_logic;
      o_en_contador : out std_logic;
      o_en_y        : out std_logic;
      o_en_xt       : out std_logic
    );
  end component;

  signal w_reset       : std_logic;
  signal w_end         : std_logic;
  signal w_en_xt_regs  : std_logic;
  signal w_en_c012     : std_logic;
  signal w_en_contador : std_logic;
  signal w_en_y        : std_logic;
begin

  datapath_inst : datapath
  port map
  (
    i_clk         => i_clk,
    i_rst         => w_reset,
    i_en_xt_regs  => w_en_xt_regs,
    i_en_c012     => w_en_c012,
    i_en_contador => w_en_contador,
    i_en_y        => w_en_y,
    i_data        => i_SAMPLE,
    i_c0          => i_c0,
    i_c1          => i_c1,
    i_c2          => i_c2,
    o_end         => w_end,
    o_output      => o_FILTER
  );

  control_inst : control
  port
  map (
  i_CLK         => i_clk,
  i_RST         => i_reset,
  i_START       => i_START,
  i_EQ_val      => w_end,
  o_reset       => w_reset,
  o_en_c012     => w_en_c012,
  o_en_contador => w_en_contador,
  o_en_y        => w_en_y,
  o_en_xt       => w_en_xt_regs
  );

end architecture;