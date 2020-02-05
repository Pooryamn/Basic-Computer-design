
-- libraries :

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity ALU is 
	port(
		clk	: in std_logic; -- clock
		In_A	: in std_logic_vector(7 downto 0);
		In_B	: in std_logic_vector(7 downto 0);
		DM_OUT	: in std_logic_vector(7 downto 0);
		Stack_Out: in std_logic_vector(7 downto 0);
		Full_st : in std_logic;
		Empty_st: in std_logic;
		PC_Out	: in std_logic_vector(11 downto 0);
		Instruction: in std_logic_vector(15 downto 0);
		C_Out   : in std_logic;
		V_out	: in std_logic;
		Z_out	: in std_logic;
		S_out	:in std_logic;
		reg_IO	: out std_logic;
		Reg_in	: out std_logic_vector(7 downto 0);
		Sel_D	: out std_logic_vector(2 downto 0);		
		Sel_A	: out std_logic_vector(2 downto 0);
		Sel_B	: out std_logic_vector(2 downto 0);
		DM_RW	: out std_logic;
		DM_Address: out std_logic_vector(7 downto 0);
		DM_Address_LD : out std_logic;
		DM_IN	: out std_logic_vector(7 downto 0);
		PC_LD	: out std_logic;
		PC_Inc	: out std_logic;
		PC_in	: out std_logic_vector(11 downto 0);
		Stack_in: out std_logic_vector(7 downto 0);
		PUSH	: out std_logic;
		POP	: out std_logic;
		Inc_SP 	: out std_logic;
		Dec_SP	: out std_logic;
		SP_Reset: out std_logic;
		V	: out std_logic;
		V_LD	: out std_logic; -- overflow load
		C	: out std_logic;
		C_LD	: out std_logic; -- Carry load
		Z	: out std_logic;
		Z_LD	: out std_logic; -- Zero load
		S	: out std_logic;
		S_LD	: out std_logic  -- Sign load
	);
end ALU;

-- Behav architecture

architecture Behav of ALU is
	-- signals in ALU
	type state_type is(fetch,decode,execute);
	signal state,next_state : state_type:=fetch;
	signal internal_instruct : std_logic_vector(15 downto 0);
	signal ins_type : std_logic_vector(1 downto 0); -- this signal show kind of instruction(bits 15 and 16)
	signal op_code1 : std_logic_vector(4 downto 0); -- this signal show op-code type 1(5 bits)
	signal op_code2 : std_logic_vector(2 downto 0); -- this signal show op-code types 2 and 3(3 bits);
	signal op_code3 : std_logic_vector(1 downto 0); -- this signal show op-code type 4(2 bits);
	signal Rd : std_logic_vector(2 downto 0); -- this signal used in type 1 and 2
	signal Ra : std_logic_vector(2 downto 0); -- this signal used in type 1
	signal Rb : std_logic_vector(2 downto 0); -- this signal used in type 1
	signal address8 : std_logic_vector(7 downto 0); -- this signal used in type 2 and 3
	signal address12 : std_logic_vector(11 downto 0); -- this signal used in type 4 
	signal Current_pc : std_logic_vector(11 downto 0); -- this signal save pc address in alu
	signal CD : std_logic_vector(2 downto 0);

begin
	-- main process
	process(clk)
	variable answer : std_logic_vector(8 downto 0);
	variable ov : std_logic; -- to use over flow in sign flag
	begin
		case state is
			when fetch =>

				internal_instruct <= Instruction; -- send instructions to alu and save it to an internal signal
				Current_pc <= PC_Out; -- get pc address 
				next_state <= decode; -- next state is decode

			when decode =>

				-- set internal signals values :

				ins_type <= internal_instruct(15 downto 14);
				op_code1 <= internal_instruct(13 downto 9); -- set op-code type 1
				op_code2 <= internal_instruct(13 downto 11); -- set op-code type 2 and 3
				op_code3 <= internal_instruct(13 downto 12); -- set op-code type 4
				Rd <= internal_instruct(8 downto 6); -- set Rd in type 1
				Ra <= internal_instruct(5 downto 3); -- set Ra in type 1
				Rb <= internal_instruct(2 downto 0); -- set Rb in type 1
				address8 <= internal_instruct(7 downto 0); -- set code address and data address in types 2 and 3
				address12 <= internal_instruct(11 downto 0); -- set code address in type 4
				CD <= internal_instruct(9 downto 7); -- Conditions 
				
				-- get informations from registers :
 
				reg_IO <= '1'; -- to enable read mode in registers
				sel_A <= Ra;
				sel_B <= Rb;

				-- set address for data memory : 
				DM_Address_LD <= '1';
				DM_Address <= address8;

				next_state <= execute;
				

			when execute =>
				next_state <= fetch;
				case ins_type is
					when "00" => -- type 1
						case op_code1 is 
							when "00001" => -- ADD
								-- main function
								answer:= In_A + In_B; 
								
								-- set carry flag :
								C_LD <= '1';
								C <= answer(8);
								
								-- set Zero flag :
								Z_LD <= '1';
								if(answer(7 downto 0) = "00000000")then
									Z <= '1';
								else
									Z <= '0';
								end if;

								-- set overflow flag :
								V_LD <= '1';
								if(answer(7) = '0' and In_A(7) = '1' and In_B(7) = '1')then
									V <= '1';
									ov := '1';
								elsif(answer(7) = '1' and In_A(7) = '0' and In_B(7) = '0')then 
									V <= '1';
									ov := '1';
								else 
									V <= '0';
									ov := '0';
								end if;

								-- set Sign flag : 
								S_LD <= '1';
								if( ov = '1') then
									S <= not answer(7);
								else 
									S <= answer(7);
								end if;
								
								-- send answer to register :
								Reg_IO <= '0';
								Sel_D <= Rd;
								Reg_in <= answer(7 downto 0);

								PC_Inc <= '1'; -- for next step

							when "00010" => -- AND 
								-- main function :
								answer := In_A and In_B;

								-- set carry flag :
								C <= answer(8);
								C_LD <= '1';

								-- set zero flag :
								Z_LD <= '1';
								if(answer(7 downto 0) = "00000000")then
									Z <= '1';
								else
									Z <= '0';
								end if;

								-- set overflow flag :
								V_LD <= '1';
								V <= '0';

								-- set sign flag :
								S_LD <= '1';
								S <= answer(7);

								-- send answer to register :
								Reg_IO <= '0';
								Sel_D <= Rd;
								Reg_in <= answer(7 downto 0);

								PC_Inc <= '1'; -- for next step

							when "00100" =>	-- MOV
								-- main function :
								answer:= In_A;

								-- set Carry flag : 
								C_LD <= '1';
								C <= '0';

								-- set zero flag
								Z_LD <= '1';
								if(answer(7 downto 0) = "00000000")then
									Z <= '1';
								else
									Z <= '0';
								end if;

								-- set overflow flag :
								V_LD <= '1';
								V <= '0';

								-- set sign flag : 
								S_LD <= '1';
								S <= answer(7);

								-- send answer to registers :
								Reg_IO <= '0';
								Sel_D <= Rd;
								Reg_in <= answer(7 downto 0);

								PC_Inc <= '1'; -- for next step

							when "01000" => -- NOT
								-- main function :
								answer := not In_A;

								-- set carry :
								C_LD <= '0';

								-- set zero flag
								Z_LD <= '1';
								if(answer(7 downto 0) = "00000000")then
									Z <= '1';
								else
									Z <= '0';
								end if;

								-- set overflow flag :
								V_LD <= '1';
								V <= '0';

								-- set sign flag : 
								S_LD <= '1';
								S <= answer(7);

								-- send answer to registers :
								Reg_IO <= '0';
								Sel_D <= Rd;
								Reg_in <= answer(7 downto 0);

								PC_Inc <= '1'; -- for next step


							when "10000" =>	-- INC
								-- main function :
								answer := In_A + 1;

								-- set carry flag :
								C_LD <= '1';
								C <= answer(8);

								-- set Zero flag :
								Z_LD <= '1';
								if(answer(7 downto 0) = "00000000")then
									Z <= '1';
								else
									Z <= '0';
								end if;

								-- set overflow flag :
								V_LD <= '1';
								if(answer(7) = '0' and In_A(7) = '1' and In_B(7) = '1')then
									V <= '1';
									ov := '1';
								elsif(answer(7) = '1' and In_A(7) = '0' and In_B(7) = '0')then 
									V <= '1';
									ov := '1';
								else 
									V <= '0';
									ov := '0';
								end if;

								-- set Sign flag : 
								S_LD <= '1';
								if( ov = '1') then
									S <= not answer(7);
								else 
									S <= answer(7);
								end if;

								-- send answer to register :
								Reg_IO <= '0';
								Sel_D <= Rd;
								Reg_in <= answer(7 downto 0);

								PC_Inc <= '1'; -- for next step

							when others =>  -- DO NOTHING
								PC_Inc <= '1'; -- for next step
						end case;
							
					when "01" => -- type 2
						case op_code2 is 
							when "000" => -- LOAD
								DM_RW <= '0';
								answer := DM_OUT; -- get data from data ram
	
								-- send answer to register :
								Reg_IO <= '0';
								Sel_D <= Rd;
								Reg_in <= answer(7 downto 0);
 
								PC_Inc <= '1'; -- for next step

							when "001" => -- STORE
								Reg_Io <= '0';
								answer := In_A;
								DM_Address_LD <= '1';
								DM_IN <= answer(7 downto 0);
								
								PC_Inc <= '1'; -- for next step

							when "010" => -- PUSH
								if(Full_st = '0')then
									answer := DM_OUT;
									push<= '1'; -- to write data on stack
									Stack_in <= answer(7 downto 0); -- data goes to top of the stack
									Inc_SP <= '1'; -- sp++
								else
									SP_Reset <= '1';
								end if;

								PC_Inc <= '1'; -- for next step

							when "011" => -- POP
								if(Empty_st = '0')then
									answer := stack_Out;
									pop <='1';
									Dec_sp<='1';
									

									DM_RW <= '1';
									DM_Address_LD <= '1';
									DM_IN <= answer(7 downto 0);
								else
									SP_Reset <= '1';
								end if;

								PC_Inc <= '1'; -- for next step

							when "100" => -- PUSH
								if(Full_st = '0')then
									answer := In_A;
									push<= '1'; -- to write data on stack
									Stack_in <= answer(7 downto 0); -- data goes to top of the stack
									Inc_SP <= '1'; -- sp++
								else
									SP_Reset <= '1';
								end if;

								PC_Inc <= '1'; -- for next step

							when "101" => -- POP
								if(Empty_st = '0')then
									answer := stack_Out;
									pop <='1';
									Dec_sp<='1';

									-- send answer to registers :
									Reg_IO <= '0';
									Sel_D <= Rd;
									Reg_in <= answer(7 downto 0);
								else
									SP_Reset <= '1';
								end if;

								PC_Inc <= '1'; -- for next step

							when others => -- DO NOTHING
								PC_Inc <= '1'; -- for next step
						end case;
					when "10" => -- type 3
						case op_code2 is 
							when "000" => -- JR
								case CD is
									when "000" => -- Z
										if(Z_out = '1')then
											PC_LD <= '1';
											PC_in <= PC_Out + address12;
										end if; 
									when "001" => -- C
										if(C_Out = '1')then
											PC_LD <= '1';
											PC_in <= PC_Out + address12;
										end if;
									when "010" => -- S
										if(S_out = '1')then
											PC_LD <= '1';
											PC_in <= PC_Out + address12;
										end if;
									when "011" => -- V
										if(V_out = '1')then
											PC_LD <= '1';
											PC_in <= PC_Out + address12;
										end if;
									when "100" => -- F
										if(Full_st = '1')then
											PC_LD <= '1';
											PC_in <= PC_Out + address12;
										end if;
									when "101" => -- E
										if(Empty_st = '1')then
											PC_LD <= '1';
											PC_in <= PC_Out + address12;
										end if;	
									when "110" => -- G
										if(V_out = '0')then
											if(In_A > In_B)then
												PC_LD <= '1';
												PC_in <= PC_Out + address12;
											end if;
										end if;
									when "111" => -- L
										if(V_out = '0')then
											if(In_A < In_B)then
												PC_LD <= '1';
												PC_in <= PC_Out + address12;
											end if;
										end if;
									when others => -- DO NOTHING
										PC_Inc <= '1'; -- for next step
								end case;
							when others => -- DO NOTHING
								PC_Inc <= '1'; -- for next step
						end case;

					when others => -- type 4
						case op_code3 is 
							when "00" => -- CALL
								if(Full_st = '0')then
									-- high 
									answer(7 downto 4) := "0000";
									answer(3 downto 0) := PC_out(11 downto 8); 
									push<= '1'; -- to write data on stack
									Stack_in <= answer(7 downto 0); -- data goes to top of the stack
									Inc_SP <= '1'; -- sp++

									-- Low 
									answer(7 downto 0) := PC_out(7 downto 0);
									push<= '1'; -- to write data on stack
									Stack_in <= answer(7 downto 0); -- data goes to top of the stack
									Inc_SP <= '1'; -- sp++

									PC_LD <= '1';
									PC_in <= address12;
								end if;
							when "01" => -- JMP
								PC_LD <= '1';
								PC_in <= address12;
							when "10" => -- RET
								if(Empty_st = '0')then
									answer(7 downto 0) := stack_Out; -- low
									pop <='1';
									Dec_sp<='1';

									PC_LD <= '1';
									PC_in(7 downto 0) <= answer(7 downto 0);

									answer(7 downto 0) := stack_Out; -- high
									pop <='1';
									Dec_sp<='1';

									PC_in(11 downto 8) <= answer(3 downto 0);
								end if;
							when others => -- DO NOTHING
								PC_Inc <= '1'; -- for next step
						end case;
				end case;
		end case;	
	end process;	

	state <= next_state;

end Behav;