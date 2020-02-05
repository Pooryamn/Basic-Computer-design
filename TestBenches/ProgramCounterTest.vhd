-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity ProgramCounterTest is
end ProgramCounterTest;

-- Behav :

architecture timing of ProgramCounterTest is
	signal clk	: std_logic:='0';
	signal Data_in	: std_logic_vector(11 downto 0):="000000000000";
	signal LD	: std_logic:='1';
	signal Inc	: std_logic:='0';
	signal Data_out : std_logic_vector(11 downto 0):="000000000000";
begin
	U0 : entity work.programcounter(behav) port map(clk,Data_in,LD,Inc,Data_out);
	clk <= not clk after 50 us when now <= 2000 us else '0';
	Data_in <= Data_in + 10 after 50 us;
	Inc <= '1' after 700 us when now <= 1500 us else '0' ;
	LD <= '0' after 600 us ;
end timing;

	