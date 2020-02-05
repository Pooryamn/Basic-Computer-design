-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity Stack_memory_Test is
end Stack_memory_Test;

-- Behav :

architecture timing of Stack_memory_Test is 
	signal clk	: std_logic:='0';
	signal Address	: std_logic_vector(7 downto 0):="00000000";
	signal Data_in	: std_logic_vector(7 downto 0):="10101010";
	signal Push	: std_logic:='1';
	signal Pop	: std_logic:='0';
	signal Data_out: std_logic_vector(7 downto 0):="00000000";
	signal Full	: std_logic;
	signal Empty	: std_logic;
begin
	U0 : entity work.stack_memory(behav) port map(clk,Address,Data_in,Push,Pop,Data_out,Full,Empty);
	clk <= not clk after 50 us when Now <= 2000 us else '0';
	Data_in <= Data_in + 1 after 25 us;
	Push <= '0' after 900 us;
	Pop <= '1' after 900 us;
	Address <= Address + 1 after 50 us when Now <= 700 us else Address - 1;
	
end timing;
