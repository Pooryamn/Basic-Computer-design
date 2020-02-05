-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity Registers is
	port(
		clk	: in std_logic;
		IO	: in std_logic;
		Sel_D	: in std_logic_vector(2 downto 0);
		Data_in	: in std_logic_vector(7 downto 0);
		Sel_A	: in std_logic_vector(2 downto 0);
		Out_A	: out std_logic_vector(7 downto 0);
		Sel_B	: in std_logic_vector(2 downto 0);
		Out_B	: out std_logic_vector(7 downto 0)
	);
end Registers;

-- Behav architecture :

architecture Behav of Registers is
	Type Regs_struct is array(0 to 7) of std_logic_vector(7 downto 0);
	signal Regs : Regs_struct:=(
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000"
	);
begin
	process(clk)
	begin
		if(clk'event and clk='1')then
			if(IO = '0')then
				Regs(conv_integer(Sel_D)) <= Data_in;
			elsif(IO = '1')then
				Out_A <= Regs(conv_integer(Sel_A));
				Out_B <= Regs(conv_integer(Sel_B));
			end if;
		end if;
	end process;
end Behav;