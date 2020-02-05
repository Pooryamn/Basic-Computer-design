
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity full_flag_test is 
end full_flag_test;

-- timing

architecture timing of full_flag_test is
	signal clk 	: std_logic;
	signal LD	: std_logic;
	signal data_in	: std_logic;
	signal data_out : std_logic;
begin 
	U0 : entity work.d_ff(behav) port map(clk,LD,data_in,data_out);
	clk <= not clk after 50 us when now <= 1000 us else '0';
	LD <= not LD after 200 us when now <= 1000 us else '0';
	data_in <= not data_in after 150 us when now <= 1000 us else '0';
end timing;