-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity IR is 
	port(
		clk	: in std_logic;
		Data_in	: in std_logic_vector(15 downto 0);
		Data_out: out std_logic_vector(15 downto 0)
	);
end IR;

-- Behav architecture

architecture Behav of IR is
	signal Data : std_logic_vector(15 downto 0); -- ok
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then
				Data <= Data_in;
		end if;
	end process;
	
	Data_out <= Data;
end Behav;
 
