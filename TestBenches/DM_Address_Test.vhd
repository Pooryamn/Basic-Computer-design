-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity DM_Address_Test is
end DM_Address_Test;

-- Behav : 

architecture timing of DM_Address_Test is
	signal clk	: std_logic:='0';
	signal LD	: std_logic:='0';
	signal Data_in	: std_logic_vector(7 downto 0):="00000000";
	signal Data_out : std_logic_vector(7 downto 0);
begin
	U0 : entity work.dm_address(behav) port map (clk,LD,Data_in,Data_out);
	clk <= not clk after 50 us when now <= 1000 us else '0';
	LD <= not LD after 300 us ;
	Data_in <= Data_in + 100 after 100 us;
end timing;
