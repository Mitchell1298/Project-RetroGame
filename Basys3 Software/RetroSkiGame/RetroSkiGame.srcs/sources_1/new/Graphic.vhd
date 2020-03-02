library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Graphic is
    Port (
            clock           :   in  STD_LOGIC;
            sysReset        :   in  STD_LOGIC;
            x               :   in  STD_LOGIC_VECTOR(9 downto 0);
            y               :   in  STD_LOGIC_VECTOR(9 downto 0);
            color           :   out STD_LOGIC_VECTOR(2 downto 0)
    );
end Graphic;

architecture Behavioral of Graphic is
    CONSTANT min_x    :   integer := 144;
    CONSTANT max_x    :   integer := 784;
    CONSTANT min_y    :   integer := 31;
    CONSTANT max_y    :   integer := 511;
    
    CONSTANT box_s    :   integer := 10;
    component Sprite is
    Port ( x : in integer;
           y : in integer;
           color : out STD_LOGIC_VECTOR(2 downto 0)
         );
    end component;
SIGNAL box_x, box_y, draw_x, draw_y  :   integer range 0 to 1028;
SIGNAL dir_x, dir_y   :   STD_LOGIC;
SIGNAL sprite_x, sprite_y : integer;
SIGNAL sprite_color : STD_LOGIC_VECTOR(2 downto 0);
begin

spr: Sprite port map(
                        x => sprite_x,
                        y => sprite_y,
                        color => sprite_color);

process(clock, sysReset)
    begin
        --Async reset
        if(sysReset = '1') then
            dir_x <= '0';
            dir_y <= '0';
            box_x <= 200;
            box_y <= 200;
            
        elsif(rising_edge(clock))then
            if(box_x >= max_x - box_s) then 
                dir_x <= '0';
            elsif(box_x <= min_x) then 
                dir_x <= '1';
            end if;
            
            if(dir_x = '1') then
                box_x <= box_x + 1;
            else    
                box_x <= box_x - 1;
            end if;
            
            if(box_y >= max_y - box_s) then 
                dir_y <= '0';
                
            elsif (box_y <= min_y) then
                dir_y <= '1';
            end if;
            
            if(dir_y = '1') then
                box_y <= box_y + 1;
            else    
                box_y <= box_y - 1;
            end if;
        end if;
        draw_x <= to_integer(unsigned(x));
        draw_y <= to_integer(unsigned(y));
        if((x >= box_x) AND (x < box_x + box_s) AND (y >= box_y) AND (y < box_y + box_s) ) then
            sprite_x <= draw_x - box_x; --to get the relative position inside the box sprite
            sprite_y <= draw_y - box_y;
            color <= sprite_color;
        else 
            color <= "110";
        end if;
    end process;    
end Behavioral;
