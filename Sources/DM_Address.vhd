-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity DM_Address is
	port(
		clk	: in std_logic;
		LD	: in std_logic;
		Data_in	: in std_logic_vector(7 downto 0);
		Data_out: out std_logic_vector(7 downto 0)
	);
end DM_Address;

-- Behav architecture

architecture Behav of DM_Address is
	signal Data : std_logic_vector(7 downto 0); -- ok
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then 
			if(LD = '1')then
				Data <= Data_in;
			end if;
		end if;
	end process;
	
	Data_out <= Data;
end Behav;
