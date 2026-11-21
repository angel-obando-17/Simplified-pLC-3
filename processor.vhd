library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
	port( 
		clk			: in  std_logic;
		reset			: in  std_logic;
		mem_data 	: in  std_logic_vector( 15 downto 0 );
		addr_mem 	: out std_logic_vector( 7 downto 0 );
		SrcA	   	: out std_logic_vector( 7 downto 0 );  
		SrcB	   	: out std_logic_vector( 7 downto 0 );
		ALUOut   	: out std_logic_vector( 7 downto 0 );
		outRegWrite : out std_logic;
		DR				: out std_logic_vector( 2 downto 0 )
	);
end processor;

architecture struct of processor is
	
	signal ONE : std_logic_vector( 7 downto 0 ) := x"01";
	
	signal s_opcode : std_logic_vector( 3 downto 0 );
	signal s_imme, s_ben	: std_logic;
	
	signal s_PCWrite, s_PCSrc, s_IRWrite, s_MemReg, s_RegWrite, s_ALUSrcA : std_logic;
	signal s_ALUSrcB, s_ALUOp : std_logic_vector( 1 downto 0 );
	
	signal s_data8_6, s_data2_0, s_data11_9 : std_logic_vector( 2 downto 0 ); 
	signal s_data7_0 : std_logic_vector( 7 downto 0 ); 
	signal s_data4_0 : std_logic_vector( 4 downto 0 );
	
	signal s_dataMem : std_logic_vector( 7 downto 0 );
	
	signal s_regAout, s_regBout : std_logic_vector( 7 downto 0 );
	
	signal s_muxAout, s_muxBout : std_logic_vector( 7 downto 0 );
	signal s_aluOut, s_aluOutReg : std_logic_vector( 7 downto 0 );
	
	signal s_PCOut : std_logic_vector( 7 downto 0 );
	
	signal s_signExt : signed( 7 downto 0 );
	
	signal s_NZPRegIn, s_NZPRegOut : std_logic_vector( 2 downto 0 );
	
begin
	
	inst_control_unit : entity work.control_unit
		port map(
			clk	   => clk,
			reset    => reset,
			opcode	=> s_opcode,
			imme  	=> s_imme,
			ben		=> s_ben,
			PCWrite  => s_PCWrite,
			PCSrc	   => s_PCSrc,
			IRWrite  => s_IRWrite, 
			MemReg   => s_MemReg,
			RegWrite => s_RegWrite,
			ALUSrcA  => s_ALUSrcA,
			ALUSrcB  => s_ALUSrcB,
			ALUOp	 	=> s_ALUOp
		);
	
	inst_IR : entity work.instruction_reg
		port map(
			clk    	 => clk,
			reset  	 => reset,
			enable 	 => s_IRWrite,
			data	 	 => mem_data,
			opcode    => s_opcode,
			immediate => s_imme,
			data8_6   => s_data8_6,
			data2_0   => s_data2_0,
			data11_9  => s_data11_9,
			data4_0   => s_data4_0,
			data7_0   => s_data7_0
		);
		
	inst_registerFile : entity work.register_file
		port map(
			clk	  => clk,
			reset   => reset, 
			wr      => s_RegWrite,
			DR  	  => s_data11_9,
			data    => s_dataMem,
			SR1 	  => s_data8_6,
			SR2 	  => s_data2_0,
			SR1_out => s_regAout,
			SR2_out => s_regBout
		);
	
	inst_alu : entity work.alu
		port map(
			in_a 		 => s_muxAout,
			in_b 	 	 => s_muxBout,
			operation => s_ALUOp,
			out_alu	 => s_aluOut
		);
	
	inst_aluOutReg : entity work.reg
		port map(
			clk 	=> clk,
			reset => reset,
			en		=> '1',
			D_in  => s_aluOut,
			Q_out	=> s_aluOutReg
		);
		
	inst_PC : entity work.reg
		port map(
			clk 	=> clk,
			reset => reset,
			en		=> s_PCWrite,
			D_in  => s_aluOut,
			Q_out	=> s_PCOut
		);
		
	inst_signExt : entity work.sign_extend
		port map(
			data_in  => signed( s_data4_0 ),
			data_out => s_signExt
		);
	
	inst_mux4to1 : entity work.mux4to1
		port map(
			ina	 => ONE,
			inb	 => s_regBout,
			inc	 => std_logic_vector( s_signExt ),
			ind	 => s_data7_0,
			sel	 => s_ALUSrcB,
			outmux => s_muxBout
		);
	
	
	with s_ALUSrcA select
		s_muxAout <= s_PCOut when '0',
						 s_regAout when '1';
						 
	with s_PCSrc select
		addr_mem <= s_PCOut when '0',
						s_aluOutReg when '1';
						
	with s_MemReg select
		s_dataMem <= s_aluOut when '0',
						 mem_data( 7 downto 0 ) when '1';
	
	inst_logic_branch : entity work.logic_branch
		port map(
			data_in  => s_dataMem,
			data_out => s_NZPRegIn
		);
		
	inst_nzp_reg : entity work.nzp_reg
		port map(
			clk 	 => clk,
			reset  => reset,
			enable => s_RegWrite,
			D_in   => s_NZPRegIn,
			Q_out  => s_NZPRegOut
		);
	
	inst_branch_control : entity work.branch_control
		port map(
			nzp_reg_flags   => s_NZPRegOut,
			nzp_instr_flags => s_data11_9,
			BEN				 => s_ben
		);
	
	SrcA	 		<= s_muxAout;
	SrcB	 		<= s_muxBout;
	ALUOut 		<= s_aluOut;
	outRegWrite <= s_RegWrite;
	DR 			<= s_data11_9; 
	
end struct;