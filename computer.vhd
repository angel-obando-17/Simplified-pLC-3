library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity computer is
	port(
		clk    : in  std_logic;
		reset  : in  std_logic;
		HEX5   : out std_logic_vector( 7 downto 0 ); 
		HEX4   : out std_logic_vector( 7 downto 0 );  
		HEX3   : out std_logic_vector( 7 downto 0 );  
		HEX2   : out std_logic_vector( 7 downto 0 );  
		HEX1   : out std_logic_vector( 7 downto 0 );  
		HEX0   : out std_logic_vector( 7 downto 0 )   
	);
end computer;

architecture struct of computer is

	signal s_memdata : std_logic_vector( 15 downto 0 );
	signal s_addrmem : std_logic_vector( 7 downto 0 );

	signal s_SrcA, s_SrcB, s_ALUOut : std_logic_vector( 7 downto 0 );
	signal s_SrcAOut, s_SrcBOut, s_RegALUOut : std_logic_vector( 7 downto 0 );

	signal s_clk_slow : std_logic;
	
	signal s_RegWrite : std_logic;
	signal s_DR : std_logic_vector( 2 downto 0 );
	signal display_en : std_logic;

begin
	
	display_en <= '1' when s_RegWrite = '1' and ( s_DR = "100" ) else
					  '0';
	
	inst_clk_divider : entity work.clk_divider
		generic map(
			IN_FREQ  => 10_000_000,
			OUT_FREQ => 32
		)
		port map(
			clk_in  => clk,
			reset   => reset,
			clk_out => s_clk_slow
		);

	inst_processor : entity work.processor
		port map(
			clk			=> s_clk_slow,
			reset			=> reset,
			mem_data 	=> s_memdata,
			addr_mem 	=> s_addrmem,
			SrcA	   	=> s_SrcA,
			SrcB	   	=> s_SrcB,
			ALUOut   	=> s_ALUOut,
			outRegWrite => s_RegWrite,
			DR				=> s_DR
		);

	inst_memrom : entity work.mem_rom
		port map(
			addr     => s_addrmem,
			data_out => s_memdata
		);
	
	inst_regSR1 : entity work.reg
		port map(
			clk 	=> s_clk_slow,
			reset => reset,
			en		=> display_en,
			D_in  => s_SrcA,
			Q_out	=> s_SrcAOut
		);
	
	inst_regSR2 : entity work.reg
		port map(
			clk 	=> s_clk_slow,
			reset => reset,
			en		=> display_en,
			D_in  => s_SrcB,
			Q_out	=> s_SrcBOut
		);
	
	inst_regALUOut : entity work.reg
		port map(
			clk 	=> s_clk_slow,
			reset => reset,
			en		=> display_en,
			D_in  => s_ALUOut,
			Q_out	=> s_RegALUOut
		);
	
	
	inst_disp_SrcA : entity work.dec_display
		port map(
			value     => s_SrcAOut,
			hex_tens  => HEX5,
			hex_units => HEX4
		);

	inst_disp_SrcB : entity work.dec_display
		port map(
			value     => s_SrcBOut,
			hex_tens  => HEX3,
			hex_units => HEX2
		);

	inst_disp_ALUOut : entity work.dec_display
		port map(
			value     => s_RegALUOut,
			hex_tens  => HEX1,
			hex_units => HEX0
		);

end struct;
