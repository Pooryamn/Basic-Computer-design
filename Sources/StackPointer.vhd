
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity StackPointer is
	port(
		clk	: in std_logic;
		Reset	: in std_logic;
		Inc	: in std_logic;
		Dec	: in std_logic;
		Address	: out std_logic_vector(7 downto 0)
	);
end StackPointer;

-- Behav architecture :

architecture Behav of StackPointer is
	signal data : std_logic_vector(7 downto 0):="00000000";
begin
	process(clk,Reset)
	begin
		if(Reset = '1')then
			data <= "00000000";
		
		elsif(clk'event and clk = '1')then
			if(Inc = '1')then 
				data <= data + 1;
			
			elsif(Dec = '1')then
				data <= data - 1;
			end if;
		end if;
	end  process;
	
	Address <= data;

end Behav;
		