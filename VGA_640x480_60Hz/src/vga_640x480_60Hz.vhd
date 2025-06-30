--VGA Signal 640 x 480 @ 60 Hz Industry standard timing
--General timing
--Screen refresh rate	60 Hz
--Vertical refresh	31.46875 kHz
--Pixel freq.	25.175 MHz
--Horizontal timing (line)
--Polarity of horizontal sync pulse is negative.
--Scanline part	Pixels	Time [µs]
--Visible area	640	25.422045680238
--Front porch	16	0.63555114200596
--Sync pulse	96	3.8133068520357
--Back porch	48	1.9066534260179
--Whole line	800	31.777557100298
-- vsync->back porch->rgb data line data)->front porch (repeat)
--Vertical timing (frame)
--Polarity of vertical sync pulse is negative.
--Frame part	Lines	Time [ms]
--Visible area	480	15.253227408143
--Front porch	10	0.31777557100298
--Sync pulse	2	0.063555114200596
--Back porch	33	1.0486593843098
--Whole frame	525	16.683217477656
-- hsync -> back porch - rgb data full frame -> front proch (Repeat)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VGA_DISPLAY is
    port(
        PIXEL_CLK : in  std_logic;
        V_SYNC    : out std_logic;
        H_SYNC    : out std_logic;
        R_OUT     : out std_logic_vector(3 downto 0);
        G_OUT     : out std_logic_vector(3 downto 0);
        B_OUT     : out std_logic_vector(3 downto 0)
    );
end;

architecture RTL of VGA_DISPLAY is

    -- VGA timing constants
    constant H_VISIBLE_AREA  : integer := 640;
    constant H_FRONT_PORCH   : integer := 16;
    constant H_SYNC_PULSE    : integer := 96;
    constant H_BACK_PORCH    : integer := 48;
    constant H_WHOLE_LINE    : integer := 800;

    constant V_VISIBLE_AREA  : integer := 480;
    constant V_FRONT_PORCH   : integer := 10;
    constant V_SYNC_PULSE    : integer := 2;
    constant V_BACK_PORCH    : integer := 33;
    constant V_WHOLE_FRAME   : integer := 525;

    -- Derived active display area
    constant H_ACTIVE_START  : integer := H_SYNC_PULSE + H_BACK_PORCH; --add 16 if off
    constant H_ACTIVE_END    : integer := H_ACTIVE_START + H_VISIBLE_AREA;

    constant V_ACTIVE_START  : integer := V_SYNC_PULSE + V_BACK_PORCH;
    constant V_ACTIVE_END    : integer := V_ACTIVE_START + V_VISIBLE_AREA;

    -- Internal signals
    signal H_POS_COUNTER_INT : integer range 0 to H_WHOLE_LINE := 0;
    signal V_POS_COUNTER_INT : integer range 0 to V_WHOLE_FRAME := 0;
    signal H_SYNC_INT        : std_logic := '1';
    signal V_SYNC_INT        : std_logic := '1';
    signal R_CNT             : integer range 0 to 15 := 0;
    signal G_CNT             : integer range 0 to 15 := 0;
    signal B_CNT             : integer range 0 to 15 := 0;

begin

    -- V_SYNC generation
    v_sync_generator : process(PIXEL_CLK)
    begin
        if rising_edge(PIXEL_CLK) then
            if V_POS_COUNTER_INT < V_SYNC_PULSE then
                V_SYNC_INT <= '0';
            else
                V_SYNC_INT <= '1';
            end if;
        end if;
    end process;

    -- H/V pixel counters
    pixel_pos : process(PIXEL_CLK)
    begin
        if rising_edge(PIXEL_CLK) then
            if H_POS_COUNTER_INT >= H_WHOLE_LINE - 1 then
                H_POS_COUNTER_INT <= 0;
                if V_POS_COUNTER_INT >= V_WHOLE_FRAME - 1 then
                    V_POS_COUNTER_INT <= 0;
                else
                    V_POS_COUNTER_INT <= V_POS_COUNTER_INT + 1;
                end if;
            else
                H_POS_COUNTER_INT <= H_POS_COUNTER_INT + 1;
            end if;
        end if;
    end process;

    -- H_SYNC generation
    h_sync_generator : process(PIXEL_CLK)
    begin
        if rising_edge(PIXEL_CLK) then
            if H_POS_COUNTER_INT < H_SYNC_PULSE then
                H_SYNC_INT <= '0';
            else
                H_SYNC_INT <= '1';
            end if;
        end if;
    end process;

    -- RGB output logic
rgb_data : process(PIXEL_CLK)
    variable x_block, y_block : integer range 0 to 15;
begin
    if rising_edge(PIXEL_CLK) then
        if (H_POS_COUNTER_INT >= H_ACTIVE_START and H_POS_COUNTER_INT < H_ACTIVE_END) and
           (V_POS_COUNTER_INT >= V_ACTIVE_START and V_POS_COUNTER_INT < V_ACTIVE_END) then

            -- Beregn fargeblokkens posisjon
            x_block := (H_POS_COUNTER_INT - H_ACTIVE_START) / 10;
            y_block := (V_POS_COUNTER_INT - V_ACTIVE_START) / 10;

            -- Tilordne RGB basert på blokk-koordinater
            R_OUT <= std_logic_vector(to_unsigned(x_block, 4));
            G_OUT <= std_logic_vector(to_unsigned(y_block, 4));
            B_OUT <= std_logic_vector(to_unsigned((x_block + y_block) mod 16, 4));

        else
            -- Utenfor aktivt bildeområde → svart
            R_OUT <= (others => '0');
            G_OUT <= (others => '0');
            B_OUT <= (others => '0');
        end if;
    end if;
    end process rgb_data;

    -- Final output assignments
    H_SYNC <= H_SYNC_INT;
    V_SYNC <= V_SYNC_INT;

end RTL;
