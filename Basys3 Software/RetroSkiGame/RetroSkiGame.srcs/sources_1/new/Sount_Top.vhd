library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sound_Top is
    Port (  clk100MHz : in STD_LOGIC;       --W5
            PWM : out STD_LOGIC             --A14
    );
end Sound_Top;

architecture Behavioral of Sound_Top is
    component SoundClk port(
        clk100MHz   :   in STD_LOGIC;
        clkROM      :   out STD_LOGIC
        );
    end component;
        
    component SoundRom port(
        clk100  : in STD_LOGIC;
        clk8 : in STD_LOGIC;
        data : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component Sound port(
        clk100MHz : in STD_LOGIC;
        data   : in STD_LOGIC_VECTOR(7 downto 0);
        PWM    : out STD_LOGIC
    );
    end component;
    
    SIGNAL tempData : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL tempClk8  : STD_LOGIC;
begin

clk1 : SoundClk port map(
    clk100MHz  => clk100MHz,
    clkROM  => tempClk8); 
       
rom1 : SoundRom port map(
    clk100  => clk100MHz,
    clk8    => tempClk8,
    data    => tempData);
    
sound1 : Sound port map(
    clk100MHz  => clk100MHz,
    data    => tempData,
    PWM     => PWM);
    
end Behavioral;
