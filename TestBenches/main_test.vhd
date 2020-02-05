library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity :

entity main_test is
end main_test;

-- timing :
architecture timing of main_test is
	
		signal clk : std_logic:='0';
		signal Output : std_logic_vector(7 downto 0);
begin
	U0 : entity work.main(behav) port map(clk,Output);
	clk <= not clk after 50 us when now <= 3000 us else '0';
end timing;
