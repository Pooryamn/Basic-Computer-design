
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity ProgramCounter is 
	port(
		clk	: in std_logic;
		Data_in	: in std_logic_vector(11 downto 0);
		LD	: in std_logic;
		Inc	: in std_logic;
		Data_out: out std_logic_vector(11 downto 0)
	);
end ProgramCounter;

-- Behav architecture :

architecture Behav of ProgramCounter is
	signal Data : std_logic_vector(11 downto 0):="000000000000"; -- ok
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then
			if(Inc = '1')then
				Data <= Data + 1;
			
			elsif(LD = '1')then 
				Data <= Data_in;
			end if;
		end if;
	end process;
	
	Data_out <= Data;
end Behav;
