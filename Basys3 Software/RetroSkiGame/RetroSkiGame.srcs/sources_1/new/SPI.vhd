library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SPI is
    Port ( 
            SCK :   in  STD_LOGIC;  --SPI Input CLock
            MOSI:   in  STD_LOGIC;  --SPI Slave Input Data line
            CS  :   in  STD_LOGIC;  --Chip Select Input (Active low)
            LED :   out STD_LOGIC_VECTOR(7 downto 0) := x"FF"
    );
end SPI;

architecture Behavioral of SPI is
    SIGNAL  data_reg    : STD_LOGIC_VECTOR(7 downto 0);
begin
    ShiftIn : process(SCK)
    --Shift data in (MSB first) into dataregister when CS is low and on rising edge of SCK
    begin
        if(rising_edge(SCK)) then
            if(CS = '0') then       
                data_reg <= data_reg(6 downto 0) & MOSI;
            end if;
        end if;
    end process ShiftIn;

    UpdateData : process(CS)
    --Update LEDs to data register data on rising_edge CS
    begin
        if(rising_edge(CS)) then
            LED <= not data_reg;
        end if; 
    end process UpdateData;
    
end Behavioral;
