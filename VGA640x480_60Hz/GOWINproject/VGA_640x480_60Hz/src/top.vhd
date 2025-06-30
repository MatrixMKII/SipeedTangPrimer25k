library IEEE;
use IEEE.std_logic_1164.all;

entity top is
    port (
        clk_in  : in std_logic;
        H_SYNC  : out std_logic;
        V_SYNC  : out std_logic;
        R_OUT   : out std_logic_vector(3 downto 0);
        G_OUT   : out std_logic_vector(3 downto 0);
        B_OUT   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture RTL of top is

    signal pixel_clk_out    : std_logic;

 --   component GOWIN_OSC
--        port (
--            clkout0 : out std_logic;
--            clkin  : in std_logic-
--        );
--    end component;

    component Gowin_PLL
        port (
            clkout0 : out std_logic;
            clkin   : in  std_logic
        );
    end component;


    component VGA_DISPLAY
        port (
            PIXEL_CLK : in  std_logic;
            V_SYNC    : out std_logic;
            H_SYNC    : out std_logic;
            R_OUT     : out std_logic_vector(3 downto 0);
            G_OUT     : out std_logic_vector(3 downto 0);
            B_OUT     : out std_logic_vector(3 downto 0)
        );
    end component;

begin

    -- Intern oscillator (50 MHz)
 --   u_osc : GOWIN_OSC
--        port map (
--            clkin => clk_in,
 --           clkout0  => pixel_clk   -- Aktiver oscillator
--);

    -- PLL som genererer 25.175 MHz
    u_pll : gowin_pll
        port map (
            clkin   => clk_in,
            clkout0 => pixel_clk_out
        );

    -- VGA-modul
    u_vga : VGA_DISPLAY
        port map (
            PIXEL_CLK => pixel_clk_out,
            V_SYNC    => V_SYNC,
            H_SYNC    => H_SYNC,
            R_OUT     => R_OUT,
            G_OUT     => G_OUT,
            B_OUT     => B_OUT
        );

end RTL;
