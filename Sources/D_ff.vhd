
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity D_ff is 
	port(	
		clk 	: in std_logic;
		LD	: in std_logic;
		data_in	: in std_logic;
		data_out: out std_logic
	);
end D_ff;

-- behav architecture 

architecture Behav of D_ff is 
	signal data : std_logic;
begin
	process(clk)
	begin
		if(clk'event and clk= '1')then
			if(LD = '1')then
				data <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= data;
end Behav;
		