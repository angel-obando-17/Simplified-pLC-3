library ieee;
use ieee.std_logic_1164.all;

entity tb_alu is
end tb_alu;

architecture test of tb_alu is
	
	signal s_in_a 		 : std_logic_vector( 7 downto 0 );
	signal s_in_b 		 : std_logic_vector( 7 downto 0 );
	signal s_operation : std_logic_vector( 1 downto 0 );
	signal s_out_alu   : std_logic_vector( 7 downto 0 );
	

begin

	dut: entity work.alu
		port map(
			in_a		 => s_in_a,
			in_b		 => s_in_b,
			operation => s_operation,
			out_alu	 => s_out_alu
		);
	
	stim_proc: process
	begin
			s_in_a <= X"08";
			s_in_b <= X"04";
			s_operation <= "00";
			wait for 10 ns;
			
			s_operation <= "01";
			wait for 10 ns;
			
			s_in_a <= X"FF";
			s_in_b <= X"01";
			s_operation <= "00";
			wait for 10 ns;
			
			s_operation <= "01";
			wait for 10 ns;
			
			s_in_a <= X"04";
			s_in_b <= X"0A";
			wait for 10 ns;
			
			s_in_a <= X"FF";
			s_in_b <= X"FF";
			s_operation <= "10";
			wait for 10 ns;
			
			s_in_a <= X"AA";
			s_in_b <= X"55";
			s_operation <= "10";
			wait for 10 ns;
			
			s_in_a <= X"FF";
			s_operation <= "11";
			wait for 10 ns;
			
			s_in_a <= X"00";
			s_operation <= "11";
			wait;
			
	end process;
	
end test;