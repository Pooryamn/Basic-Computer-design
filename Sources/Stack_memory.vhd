
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity Stack_memory is
	port(
		clk	: in std_logic;
		Address	: in std_logic_vector(7 downto 0);
		Data_in	: in std_logic_vector(7 downto 0);
		Push	: in std_logic;
		Pop	: in std_logic;
		Data_out: out std_logic_vector(7 downto 0);
		Full	: out std_logic;
		F_LD	: out std_logic;
		Empty	: out std_logic;
		E_LD	: out std_logic
	);
end Stack_memory;

-- Behav architecture:

architecture Behav of Stack_memory is
	Type Ram_type is array(0 to 255) of std_logic_vector(7 downto 0);
	signal Stack : Ram_type;
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then
			if(Push = '1')then
				if(Address = "11111111")then
					F_LD <= '1';
					Full <= '1';
				else
					Stack(conv_integer(Address)) <= Data_in;
					E_LD <= '1';
					Empty <= '0' ;
				end if;
			elsif(Pop = '1')then
				if(Address = "00000000")then
					E_LD <= '1';
					Empty <= '1';
				else 	
					Data_out <= Stack(conv_integer(Address));
					F_LD <= '1';
					Full <= '0' ;
				end if;
			end if;
		end if;	
	end process;
end Behav;
			
