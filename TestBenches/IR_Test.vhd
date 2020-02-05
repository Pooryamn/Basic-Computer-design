-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity IR_Test is
end IR_Test;

-- Behav : 

architecture timing of IR_Test is
	signal clk	: std_logic:='0';
	signal Data_in	: std_logic_vector(15 downto 0):="0000000000000000";
	signal Data_out : std_logic_vector(15 downto 0);
begin
	U0 : entity work.ir(behav) port map (clk,Data_in,Data_out);
	clk <= not clk after 50 us when now <= 1000 us else '0';
	Data_in <= Data_in + 100 after 100 us;
end timing;