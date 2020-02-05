
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity StackPointer_Test is
end StackPointer_Test;

-- Behav :

architecture timing of StackPointer_Test is 
	signal clk	: std_logic:='0';
	signal Reset	: std_logic:='0';
	signal Inc	: std_logic:='1';
	signal Dec	: std_logic:='0';
	signal Address	: std_logic_vector(7 downto 0);
begin
	U0 : entity work.stackpointer(behav) port map(clk,Reset,Inc,Dec,Address);
	clk <= not clk after 50 us when Now <= 2000 us else '0';
	Inc <= not Inc after 1000 us ;
	Dec <= '1' after 1500 us;
	Reset <='1' after 1800 us;
end timing;