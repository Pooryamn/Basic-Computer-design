-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity Registers_Test is
end Registers_Test;

-- Behav :

architecture timing of Registers_Test is 
	signal clk	: std_logic:='0';
	signal IO	: std_logic:='0';
	signal Sel_D	: std_logic_vector(2 downto 0):="000";
	signal Data_in	: std_logic_vector(7 downto 0):="00000000";
	signal Sel_A	: std_logic_vector(2 downto 0):="111";
	signal Out_A	: std_logic_vector(7 downto 0);
	signal Sel_B	: std_logic_vector(2 downto 0):="000";
	signal Out_B	: std_logic_vector(7 downto 0);
begin
	U0 : entity work.registers(behav) port map(clk,IO,Sel_D,Data_in,Sel_A,Out_A,Sel_B,Out_B);
	clk <= not clk after 50 us when Now <= 2000 us else '0';
	IO <= not IO after 200 us when Now <= 2000 us else '0';
	Data_in <= Data_in + 1 after 100 us;
	Sel_D <= Sel_D + 1 after 250 us;
	Sel_A <= Sel_D;
	Sel_B <= Sel_D + 1 ;
end timing;