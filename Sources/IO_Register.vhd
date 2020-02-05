-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity : 

entity IO_Register is
	port(	
		clk	: in std_logic;
		IO	: in std_logic;  -- if '0' is input , if '1' is output
		Data_in	: in std_logic_vector(7 downto 0);
		Data_out: out std_logic_vector(7 downto 0)
	);
end IO_Register;

-- Behav :

architecture Behav of IO_Register is 
	signal reg : std_logic_vector(7 downto 0);
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then
			if(IO = '0')then -- is input
				reg <= Data_in;
			elsif(IO = '1')then -- is output
				Data_out <= reg;
			end if;
		end if;
	end process;
end Behav;
