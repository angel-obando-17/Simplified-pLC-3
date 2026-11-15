library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_file is
end tb_register_file;

architecture test of tb_register_file is
	signal s_clk 		   : std_logic := '0';
	signal s_reset			: std_logic;

	-- Escritura.
	signal s_wr          : std_logic := '0';
	signal s_DR          : std_logic_vector( 2 downto 0 ) := "000";
	signal s_data        : std_logic_vector( 7 downto 0 ) := X"00";

	-- Lectura.
	signal s_SR1         : std_logic_vector( 2 downto 0 ) := "000";
	signal s_SR2 		   : std_logic_vector( 2 downto 0 ) := "000";
	signal s_SR1_out     : std_logic_vector( 7 downto 0 );
	signal s_SR2_out     : std_logic_vector( 7 downto 0 );

	signal sim_done 		: boolean := false;

	constant CLK_PERIOD  : time := 20 ns;
	
begin
	
	dut: entity work.register_file
		port map(
			clk 	  => s_clk,
			reset   => s_reset,
			
			-- Escritura.
			wr 	  => s_wr,
			DR		  => s_DR,
			data	  => s_data,
			
			-- Lectura.
			SR1	  => s_SR1,
			SR2	  => s_SR2,
			SR1_out => s_SR1_out,
			SR2_out => s_SR2_out
		);
	
	clk_proc: process
	begin
	
		while not sim_done loop
			s_clk <= '0';
			wait for CLK_PERIOD / 2;
			s_clk <= '1';
			wait for CLK_PERIOD / 2;
		end loop;
		
		wait;
	end process;

	stim_proc : process
	begin
		s_reset <= '1';
		wait for 20 ns;
		s_reset <= '0';
		
		report "Starting Simulation...";
		report "First Case: Write in the Reg2.";
		wait until falling_edge( s_clk );
		s_data <= X"FF";
		s_wr   <= '1';
		s_DR   <= "010";
		s_SR1  <= "000";
		s_SR2  <= "000";
		
		
		report "Second Case: Write in the Reg3.";
		wait until falling_edge( s_clk );
		s_data <= X"AA";
		s_wr   <= '1';
		s_DR   <= "011";
		s_SR1  <= "000";
		s_SR2  <= "000";
		
		report "Third Case: Read Reg2 and Reg3.";
		wait until falling_edge( s_clk );
		s_data <= X"00";
		s_wr   <= '0';
		s_DR   <= "000";
		s_SR1  <= "010";
		s_SR2  <= "011";
		
		report "End Simulation.";
		wait until rising_edge( s_clk );
		
		sim_done <= true;
		
		wait;
	end process;
	
end test;