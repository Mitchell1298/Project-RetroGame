library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sprite is
    Port ( x : in integer;
           y : in integer;
           color : out STD_LOGIC_VECTOR(2 downto 0)
         );
end Sprite;

architecture Behavioral of Sprite is
    Type RomType is array(9 downto 0) 
    of std_logic_vector(9 downto 0);

Constant Rom: RomType := (
                            "0000110000",
                            "0011111100",
                            "0111111110",
                            "0111111110",
                            "1111111111",
                            "1111111111",
                            "0111111110",
                            "0111111110",
                            "0011111100",
                            "0000110000");

begin
    process(x,y)
    begin
        if (Rom(y)(x) = '1') then--if (y = 1 or y = 2 or y = 5 or y =9) then   --
            color <= "001";
        else
            color <= "110";
        end if;
    end process;
end Behavioral;
