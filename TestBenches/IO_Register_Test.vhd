-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity IO_Register_Test is
end IO_Register_Test;

-- Behav :

architecture timing of IO_Register_Test is 
	signal clk	: std_logic:='0';
	signal IO	: std_logic:='0';  -- if '0' is input , if '1' is output
	signal Data_in	: std_logic_vector(7 downto 0):="10101010";
	signal Data_out	: std_logic_vector(7 downto 0);
begin
	U0 : entity work.io_register(behav) port map(clk,IO,Data_in,Data_out);
	clk <= not clk after 50 us when Now <= 1000 us else '0';
	IO <= '1' after 200 us;
	Data_in <= Data_in + 1 after 50 us when Now <= 195 us; 
end timing;