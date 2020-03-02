
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA is
    Port ( 	clk100              : in     STD_LOGIC;
            color               : in     STD_LOGIC_VECTOR(2 downto 0);
			red, green, blue    : out    STD_LOGIC;
			hsync, vsync        : out    STD_LOGIC;
			x, y                : out    STD_LOGIC_VECTOR(9 downto 0)
			);
end VGA;

architecture Behavioral of VGA is
    SIGNAL hcount: STD_LOGIC_VECTOR(9 downto 0);
    SIGNAL vcount: STD_LOGIC_VECTOR(9 downto 0);
    SIGNAL clk25 : STD_LOGIC;
    
    SIGNAL counter : integer range 0 to 3;
begin
    x <= hcount;
    y <= vcount; 

    --Clock Divider from 100MHz to 25MHz
    process (clk100)
    begin
     
        if(rising_edge(clk100)) then
            counter <= counter + 1;
            if(counter >= 1) then
                clk25 <= not clk25;
                counter <= 0;
            end if;
        end if;
    end process;
    
    process (clk25)
    begin
        --Background Color Start
        if rising_edge(clk25) then
            if (hcount >= 144) and (hcount < 784) and (vcount >= 31) and (vcount < 511) then
                red     <= color(0);
                green   <= color(1);
                blue    <= color(2);
            else
                red     <= '0';
                green   <= '0';
                blue    <= '0';
            end if;
        --Background Color End
         
            if hcount < 97 then
                hsync <= '0';
            else
                hsync <= '1';
            end if;
    
            if vcount < 3 then
                vsync <= '0';
            else
                vsync <= '1';
            end if;
         
            hcount <= hcount + 1;
         
            if hcount = 800 then
                vcount <= vcount + 1;
                hcount <= (others => '0');
            end if;
         
            if vcount = 521 then		    
                vcount <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;

