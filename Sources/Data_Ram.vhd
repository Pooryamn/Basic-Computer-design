-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity Data_Ram is 
	port(	
		clk	: in std_logic;
		address	: in std_logic_vector(7 downto 0);
		Data_in	: in std_logic_vector(7 downto 0);
		R_W	: in std_logic;
		Data_out: out std_logic_vector(7 downto 0)
	);
end Data_Ram;

-- Behav architecture :

architecture Behav of Data_Ram is
	Type Ram_type is array(0 to 255) of std_logic_vector(7 downto 0); -- ok
	signal Ram : Ram_type;
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then
			if(R_W = '0')then
				Data_out <= Ram(conv_integer(address));
			else
				Ram(conv_integer(address)) <= Data_in;
			end if;
		end if;
	end process;
end Behav;
		
