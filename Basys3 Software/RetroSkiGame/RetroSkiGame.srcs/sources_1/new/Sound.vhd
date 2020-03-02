library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sound is
    Port (  
        clk100MHz     : in STD_LOGIC;
        data    : in STD_LOGIC_VECTOR(7 downto 0); --8 bits of data from ROM
        PWM     : out STD_LOGIC               
    );
end Sound;

architecture Behavioral of Sound is
    SIGNAL counter : integer range 0 to 255;
begin
    --Pulse Width Modulation
    process(clk100MHz)
    begin
        if(rising_edge(clk100MHz)) then
            if(counter < 255) then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;
            
            if(counter < data) then
                PWM <= '1';
            else
                PWM <= '0';
            end if;
        end if;
    end process;
end Behavioral;