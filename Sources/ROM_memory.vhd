library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity Rom_memory is 
	generic(	bits : integer :=16;
			words : integer :=4096
	);	
	port(	
		clk	: in std_logic;
		address	: in std_logic_vector(11 downto 0);
		Data_out: out std_logic_vector(bits-1 downto 0)
	);
end Rom_memory;

-- Behav architecture :

architecture Behav of Rom_memory is
	Type memory_type is array(0 to words-1) of std_logic_vector(bits-1 downto 0); 
	CONSTANT Rom : memory_type :=(
		"1101000000000011", -- CALL "3"
		"1101000000011010", -- CALL "26"
		"1101000000000010", -- JMP "2"(STAY HERE)
		"0010000000000000", -- INC R0
		"0010000001001001", -- INC R1
		"0100100000000000", -- STORE "0",R0
		"0100100100000001", -- STORE "1",R1
		"0000001010001000", -- ADD R2,R1,R0
		"0100101000000010", -- STORE "2",R2
		"0000100000001000", -- MOV R0,R1
		"0000100001010000", -- MOV R1,R2
		"0000001010001000", -- ADD R2,R1,R0
		"0100101000000011", -- STORE "3",R2
		"0000100000001000", -- MOV R0,R1
		"0000100001010000", -- MOV R1,R2
		"0000001010001000", -- ADD R2,R1,R0
		"0100101000000101", -- STORE "5",R2
		"0000100000001000", -- MOV R0,R1
		"0000100001010000", -- MOV R1,R2
		"0000001010001000", -- ADD R2,R1,R0
		"0100101000001000", -- STORE "8",R2
		"0000100000001000", -- MOV R0,R1
		"0000100001010000", -- MOV R1,R2
		"0000001010001000", -- ADD R2,R1,R0
		"0100101000001101", -- STORE "13",R2
		"1101000000000001", -- RET
		"0100000000000000", -- LOAD R0,"0"
		"0000011000000000", -- NOP
		"0100000000000001", -- LOAD R0,"1"
		"0000011000000000", -- NOP
		"0100000000000010", -- LOAD R0,"2"
		"0000011000000000", -- NOP
		"0100000000000011", -- LOAD R0,"3"
		"0000011000000000", -- NOP
		"0100000000000101", -- LOAD R0,"5"
		"0000011000000000", -- NOP
		"0100000000001000", -- LOAD R0,"8"
		"0000011000000000", -- NOP
		"0100000000001101", -- LOAD R0,"13"
		"1101000000000010"  -- RET
	);
begin
	process(clk)
	begin
		if(clk'event and clk = '1')then
			Data_out <= Rom(conv_integer(address));
		end if;
	end process;
end Behav;
