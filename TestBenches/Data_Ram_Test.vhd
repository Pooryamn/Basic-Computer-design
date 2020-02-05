-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity Data_Ram_test is
end Data_Ram_test;

-- Behav : 

architecture timing of Data_Ram_test is
	signal clk	: std_logic:='0';
	signal address	: std_logic_vector(7 downto 0):="00000000";
	signal Data_in	: std_logic_vector(7 downto 0):="00000000";
	signal R_W	: std_logic:='1';
	signal Data_out : std_logic_vector(7 downto 0);
begin
	U0 : entity work.data_ram(behav) port map(clk,address,Data_in,R_W,Data_out);
	clk <= not clk after 50 us when now <= 1000 us else '0';
	address <= address + 1 after 100 us when now <= 300 us else "00000010";
	R_W <= '0' after 400 us;
	Data_in <= Data_in + 10 after 50 us;
end timing;

