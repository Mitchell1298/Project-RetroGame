library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SoundClk is
    Port (
        clk100MHz : in STD_LOGIC;
        clkROM    : out STD_LOGIC
        );
end SoundClk;

architecture Behavioral of SoundClk is
    SIGNAL counter : integer range 0 to 12499;
    SIGNAL tempClk8 : STD_LOGIC := '0' ;
begin
    process(clk100MHz)
    begin
        if(rising_edge(clk100MHz)) then
            if(counter = 12499) then
                counter <= 0;
                tempClk8 <= '0';
            else
                counter <= counter + 1;
                tempClk8 <= '1';
            end if;
        end if;
    end process;
    clkROM <= tempClk8;
end Behavioral;
