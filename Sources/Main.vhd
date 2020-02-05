library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity main is
	port(
		clk : in std_logic;
		Output : out std_logic_vector(7 downto 0)
	);
end main;

-- Behav architecture :

architecture Behav of main is
	signal reg_IO : std_logic; -- (ALU -> registers)
	signal Sel_D : std_logic_vector(2 downto 0); -- (ALU -> registers)
	signal Reg_in : std_logic_vector(7 downto 0); -- (ALU -> registers)
	signal Sel_A : std_logic_vector(2 downto 0); -- (ALU -> registers)
	signal A : std_logic_vector(7 downto 0); -- (Registers -> ALU)
	signal Sel_B : std_logic_vector(2 downto 0); -- (ALU -> registers)
	signal B : std_logic_vector(7 downto 0); -- (Registers -> ALU)
	signal PC_out : std_logic_vector(11 downto 0); -- (PC -> ROM,ALU)
	signal PC_in : std_logic_vector(11 downto 0); -- (ALU -> PC)
	signal PC_LD : std_logic; -- (ALU -> PC)
	signal PC_INC: std_logic; -- (ALU -> PC)
	signal instruct_Out : std_logic_vector(15 downto 0); -- (IR -> ALU)
	signal instruct_In : std_logic_vector(15 downto 0); -- (ROM -> IR)
	signal DM_Address : std_logic_vector(7 downto 0); -- (ALU -> DM_Address)
	signal DM_Address_LD : std_logic; -- (ALU -> RAM)
	signal DM_Address2 : std_logic_vector(7 downto 0); -- (DM_ADDRESS -> RAM)
	signal DM_In : std_logic_vector(7 downto 0); -- ( ALU -> RAM)
	signal DM_Out : std_logic_vector(7 downto 0); -- (RAM -> ALU);
	signal DM_RW : std_logic; -- (ALU -> RAM)
	signal SP_Reset : std_logic; -- (ALU -> RAM)
	signal Inc_SP : std_logic; -- (ALU -> RAM)
	signal Dec_SP : std_logic; -- (ALU -> RAM)
	signal Stack_Address : std_logic_vector(7 downto 0); -- (SP -> Stack)
	signal Stack_In : std_logic_vector(7 downto 0); -- (ALU -> Stack)
	signal Stack_Out : std_logic_vector(7 downto 0); -- (Stack -> ALU)
	signal Push : std_logic; -- (ALU -> Stack)
	signal Pop : std_logic; -- (ALU -> Stack)
	signal ST_Full :std_logic; -- (Stack -> ST_Full_Flag)
	signal ST_Empty:std_logic; -- (Stack -> ST_Empty_Flag)
	signal C_LD : std_logic; --(ALU -> Carry_flag)
	signal C : std_logic; -- (ALU -> Carry_flag)
	signal C_Out : std_logic; -- (Carry_flag -> ALU)
	signal V_LD : std_logic; --(ALU -> Overflow_flag)
	signal V : std_logic; -- (ALU -> Overflow_flag)
	signal V_Out : std_logic; -- (Overflow_flag -> ALU)
	signal Z_LD : std_logic; --(ALU -> Zero_flag)
	signal Z : std_logic; -- (ALU -> Zero_flag)
	signal Z_Out : std_logic; -- (Zero_flag -> ALU)
	signal S_LD : std_logic; --(ALU -> Sign_flag)
	signal S : std_logic; -- (ALU -> Sign_flag)
	signal S_Out : std_logic; -- (Sign_flag -> ALU)
	signal F_LD : std_logic; -- (Stack -> Full_ST_flag)
	signal E_LD : std_logic; -- (Stack -> Empty_ST_flag)
	signal F_Out : std_logic; -- (Full_ST_flag -> ALU)
	signal E_Out : std_logic; -- (Empty_ST_flag -> ALU)
	
	
begin
	U0 : entity work.registers(behav) port map(clk,reg_IO,Sel_D,Reg_in,Sel_A,A,Sel_B,B); -- registers unit 
	U1 : entity work.programcounter(behav) port map(clk,PC_in,PC_LD,PC_INC,PC_out); -- PC
	U2 : entity work.ir(behav) port map(clk,instruct_In,instruct_Out); -- IR
	U3 : entity work.rom_memory(behav)generic map(16 , 4096) port map(clk,PC_out,instruct_In); -- ROM MEMORY
	U4 : entity work.dm_address(behav) port map(clk,DM_Address_LD,DM_Address,DM_Address2); -- RAM ADDRESS
	U5 : entity work.data_ram(behav) port map(clk,DM_Address2,DM_In,DM_RW,DM_Out); -- RAM
	U6 : entity work.stackpointer(behav) port map(clk,SP_Reset,Inc_SP,Dec_SP,Stack_Address); -- SP
	U7 : entity work.stack_memory(behav) port map(clk,Stack_Address,Stack_In,Push,Pop,Stack_Out,ST_Full,F_LD,ST_Empty,E_LD); -- Stack
     Carry : entity work.d_ff(behav) port map(clk,C_LD,C,C_Out); -- Carry Flag
  Overflow : entity work.d_ff(behav) port map(clk,V_LD,V,V_Out); -- Overflow Flag
      Zero : entity work.d_ff(behav) port map(clk,Z_LD,Z,Z_Out); -- Zero flag
      Sign : entity work.d_ff(behav) port map(clk,S_LD,S,S_Out); -- Sign flag
   Full_St : entity work.d_ff(behav) port map(clk,F_LD,ST_Full,F_Out); -- Full Stack flag
  Empty_St : entity work.d_ff(behav) port map(clk,E_LD,ST_Empty,E_Out); -- Empty Stack flag
  ALU_Unit : entity work.alu(behav)  port map(clk,
						A,
						B,
						DM_Out,
						Stack_Out,
						F_Out,
						E_Out,
						PC_out,
						instruct_Out,
						C_Out,
						V_Out,
						Z_Out,
						S_Out,
						reg_IO,
						Reg_in,
						Sel_D,
						Sel_A,
						Sel_B,
						DM_RW,
						DM_Address,
						DM_Address_LD,
						DM_In,
						PC_LD,
						PC_INC,
						PC_in,
						Stack_In,
						Push,
						Pop,
						Inc_SP,
						Dec_SP,
						SP_Reset,
						V,V_LD,
						C,C_LD,
						Z,Z_LD,
						S,S_LD);

	Output <= A;
end Behav;