library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
    Port (  clk100              : in  STD_LOGIC;
            sysReset            : in  STD_LOGIC;
            red, green, blue    : out STD_LOGIC;
            hsync, vsync        : out STD_LOGIC;
            SCK                 : in  STD_LOGIC;  --SPI Input CLock
            MOSI                : in  STD_LOGIC;  --SPI Slave Input Data line
            CS                  : in  STD_LOGIC;  --Chip Select Input (Active low)
            LED                 : out STD_LOGIC_VECTOR(7 downto 0);
            PWM                 : out STD_LOGIC
    );
end Top;

architecture Behavioral of Top is
    component VGA is
        Port ( 	clk100              : in    STD_LOGIC;
                color               : in    STD_LOGIC_VECTOR(2 downto 0);
                red, green, blue    : out   STD_LOGIC;
                hsync, vsync        : out   STD_LOGIC;
                x, y                : out   STD_LOGIC_VECTOR(9 downto 0) );
    end component;
    
    component Graphic is
        Port (
                clock               :   in  STD_LOGIC;
                sysReset            :   in  STD_LOGIC;
                x                   :   in  STD_LOGIC_VECTOR(9 downto 0);
                y                   :   in  STD_LOGIC_VECTOR(9 downto 0);
                color               :   out STD_LOGIC_VECTOR(2 downto 0) 
        );
    end component;
    
    component SPI is
        Port ( 
                SCK :   in  STD_LOGIC;  --SPI Input CLock
                MOSI:   in  STD_LOGIC;  --SPI Slave Input Data line
                CS  :   in  STD_LOGIC;  --Chip Select Input (Active low)
                LED :   out STD_LOGIC_VECTOR(7 downto 0) := x"FF"
        );
    end component;
    
    component Sound_Top port(
        clk100MHz : in STD_LOGIC;
        PWM    : out STD_LOGIC
    );
    end component;

    SIGNAL color    : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL x, y     : STD_LOGIC_VECTOR(9 downto 0);
    SIGNAL s_vsync  : STD_LOGIC;

begin
    VGA_Map : VGA port map (    clk100  => clk100,
                                color   => color,
                                red     => red,
                                green   => green,
                                blue    => blue,
                                hsync   => hsync,
                                vsync   => s_vsync,
                                x       => x,
                                y       => y
                                );                             
    vsync <= s_vsync;   
    Graphic_Map : Graphic port map (    clock => s_vsync,
                                        sysReset => sysReset,
                                        x => x,
                                        y => y,
                                        color => color );
                                        
    SPI_Map : SPI port map  (           SCK => SCK,
                                        MOSI => MOSI,
                                        CS => CS,
                                        LED => LED);
                                
    Sound_T_Map : Sound_Top port map (  clk100MHz => clk100,
                                        PWM => PWM);
end Behavioral;
