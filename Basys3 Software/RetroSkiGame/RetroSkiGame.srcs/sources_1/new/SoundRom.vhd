library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SoundRom is
    Port ( 
            clk100  : in STD_LOGIC;
            clk8    : in STD_LOGIC;
            data    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end SoundRom;

architecture Behavioral of SoundRom is
    component Ernie port(
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    end component;
    
    SIGNAL tempaddr : STD_LOGIC_VECTOR(12 downto 0);
begin
    
    rom : Ernie port map(
        clka => clk100,
        addra => tempaddr,
        douta => data
    );
        
    process(clk8)
    begin
        if(rising_edge(clk8)) then
            if(tempaddr = 6709) then
                tempaddr <= "0000000000000";
            else
                tempaddr <= tempaddr + 1;
            end if;
        end if;
    end process;
end Behavioral;
