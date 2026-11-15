library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port(
		clk	  : in  std_logic;
		reset   : in  std_logic;
		
		-- Escritura.
		wr      : in  std_logic;
		DR  	  : in  std_logic_vector( 2 downto 0 );
		data    : in  std_logic_vector( 7 downto 0 );
		
		-- Lectura.
		SR1 	  : in  std_logic_vector( 2 downto 0 );
		SR2 	  : in  std_logic_vector( 2 downto 0 ); 
		SR1_out : out std_logic_vector( 7 downto 0 );
		SR2_out : out std_logic_vector( 7 downto 0 )
	);
end register_file;

architecture struct of register_file is
	
	signal enable_regs : std_logic_vector( 7 downto 0 ) := X"00";
	signal reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : std_logic_vector( 7 downto 0 );
	
begin
	
	inst_deco : entity work.decoder
		port map(
			en	     => wr,
			sel	  => DR,
			dec_out => enable_regs
		);
	
	inst_reg0 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 0 ),
			D_in  => data,
			Q_out => reg0
		);
	
	inst_reg1 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 1 ),
			D_in  => data,
			Q_out => reg1
		);
	
	inst_reg2 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 2 ),
			D_in  => data,
			Q_out => reg2
		);
	
	inst_reg3 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 3 ),
			D_in  => data,
			Q_out => reg3
		);
	
	inst_reg4 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 4 ),
			D_in  => data,
			Q_out => reg4
		);
	
	inst_reg5 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 5 ),
			D_in  => data,
			Q_out => reg5
		);
	
	inst_reg6 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 6 ),
			D_in  => data,
			Q_out => reg6
		);
	
	inst_reg7 : entity work.reg
		port map(
			clk   => clk,
			reset => reset,
			en    => enable_regs( 7 ),
			D_in  => data,
			Q_out => reg7
		);
	
	inst_muxSR1 : entity work.mux
		port map(
			sel	  => SR1,
			in_a	  => reg0,
			in_b	  => reg1,
			in_c	  => reg2,
			in_d	  => reg3,
			in_e	  => reg4,
			in_f	  => reg5,
			in_g	  => reg6,
			in_h	  => reg7,
			mux_out => SR1_out
		);
	
	inst_muxSR2 : entity work.mux
		port map(
			sel	  => SR2,
			in_a	  => reg0,
			in_b	  => reg1,
			in_c	  => reg2,
			in_d	  => reg3,
			in_e	  => reg4,
			in_f	  => reg5,
			in_g	  => reg6,
			in_h	  => reg7,
			mux_out => SR2_out
		);

	
end struct;