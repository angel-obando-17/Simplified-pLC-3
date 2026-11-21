library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
	port(
		clk	   : in  std_logic;
		reset    : in  std_logic;
		opcode	: in  std_logic_vector( 3 downto 0 );
		imme  	: in  std_logic;
		ben		: in  std_logic;
		PCWrite  : out std_logic;
		PCSrc	   : out std_logic;
		IRWrite  : out std_logic;
		MemReg   : out std_logic;
		RegWrite : out std_logic;
		ALUSrcA  : out std_logic;
		ALUSrcB  : out std_logic_vector( 1 downto 0 );
		ALUOp	 	: out std_logic_vector( 1 downto 0 )
	);
end control_unit;

architecture Behavioral of control_unit is
	
	type state_t is ( FETCH, 
						   DECODE, 
							BR, 
							NT,
							ADD_reg,
							AND_reg,
							LD_ADDR,
							LDR_ADDR,
							LD_MEM,
							JMP
						 );
						 
	signal current_state, next_state : state_t;
	
begin
	
	-- State Transition process.
	process( clk, reset )
	begin
		if( reset = '1' ) then
			current_state <= FETCH;
		elsif( rising_edge( clk ) ) then
			current_state <= next_state;
		end if;
	end process;
	
	-- Next State Logic process.
	process( current_state, opcode, imme, ben )	
	begin
		PCWrite 	  <= '0';
		PCSrc 	  <= '0';
		IRWrite 	  <= '0';
		MemReg 	  <= '0';
		RegWrite   <= '0';
		ALUSrcA    <= '0';
		ALUSrcB    <= "00";
		ALUOp      <= "00";
		next_state <= current_state;
		
		case current_state is
			when FETCH =>
				PCSrc   <= '0';
				IRWrite <= '1';
				ALUSrcA <= '0';
				ALUSrcB <= "00";
				ALUOp   <= "00";
				PCWrite <= '1';
				next_state <= DECODE;
				
			when DECODE =>
				case opcode is
					when "0000" =>
						if( ben = '1' ) then
							next_state <= BR;
						else
							next_state <= FETCH;
						end if;
					
					when "0001" =>
							next_state <= ADD_reg;
						
					when "0010" =>
						next_state <= LD_ADDR;
					
					when "0101" =>
							next_state <= AND_reg;

					when "0110" =>
						next_state <= LDR_ADDR;
						
					when "1001" =>
						next_state <= NT;
					
					when "1100" =>
						next_state <= JMP;
					
					when others =>
						next_state <= FETCH;
				end case;
			
			when BR =>
				ALUSrcA    <= '0';
				ALUSrcB    <= "11";
				ALUOp      <= "00";
				PCWrite    <= '1';
				RegWrite   <= '0';
				next_state <= FETCH;
				
			when ADD_reg =>
				if( imme = '1' ) then
					ALUSrcA    <= '1';
					ALUSrcB    <= "10";
					ALUOp      <= "00";
					MemReg     <= '0';
					RegWrite   <= '1';
					next_state <= FETCH;
				else
					ALUSrcA    <= '1';
					ALUSrcB    <= "01";
					ALUOp      <= "00";
					MemReg     <= '0';
					RegWrite   <= '1';
					next_state <= FETCH;
				end if;
				
			when LD_ADDR =>
				ALUSrcA    <= '0';
				ALUSrcB    <= "11";
				ALUOp      <= "00";
				PCWrite    <= '0';
				next_state <= LD_MEM;
	
				
			when AND_reg =>
				if( imme = '1' ) then
					ALUSrcA    <= '1';
					ALUSrcB    <= "10";
					ALUOp      <= "01";
					MemReg     <= '0';
					RegWrite   <= '1';
					next_state <= FETCH;
				else 
					ALUSrcA    <= '1';
					ALUSrcB    <= "01";
					ALUOp      <= "01";
					MemReg     <= '0';
					RegWrite   <= '1';
					next_state <= FETCH;
				end if;
				
			when LDR_ADDR =>
				ALUSrcA    <= '1';
				ALUSrcB    <= "10";
				ALUOp      <= "00";
				PCWrite    <= '0';
				next_state <= LD_MEM;
			
			when NT =>
				ALUSrcA    <= '1';
				ALUOp      <= "10";
				MemReg     <= '0';
				RegWrite   <= '1';
				next_state <= FETCH;
			
			when JMP =>
				ALUSrcA    <= '1';
				ALUSrcB    <= "01";
				ALUOp      <= "00";
				PCWrite    <= '1';
				next_state <= FETCH;
			
			when LD_MEM =>
				PCSrc <= '1';
				MemReg <= '1';
				RegWrite <= '1';
				IRWrite <= '0';
				next_state <= FETCH;
				
		end case;
	end process;
	
end Behavioral;