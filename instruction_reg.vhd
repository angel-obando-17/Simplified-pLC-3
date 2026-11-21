library ieee;
use ieee.std_logic_1164.all;

entity instruction_reg is
	port(
		clk    	 : in  std_logic;
		reset  	 : in  std_logic;
		enable 	 : in  std_logic;
		data	 	 : in  std_logic_vector( 15 downto 0 );
		opcode    : out std_logic_vector( 3 downto 0 );
		immediate : out std_logic;
		data8_6   : out std_logic_vector( 2 downto 0 );
		data2_0   : out std_logic_vector( 2 downto 0 );
		data11_9  : out std_logic_vector( 2 downto 0 );
		data4_0   : out std_logic_vector( 4 downto 0 );
		data7_0   : out std_logic_vector( 7 downto 0 )
	);
end instruction_reg;


architecture Behavioral of instruction_reg is

	signal IR : std_logic_vector( 15 downto 0 ) := X"0000";

begin

	process( clk, reset )
	begin
		if( reset = '1' ) then
			IR <= ( others => '0' );
			
		elsif( rising_edge( clk ) ) then
			if( enable = '1' ) then
				IR <= data;
			end if;
		end if;
	end process;
	
	opcode 	 <= IR( 15 downto 12 );
	immediate <= IR( 5 );
	data8_6   <= IR( 8 downto 6 );
	data2_0   <= IR( 2 downto 0 );
	data11_9  <= IR( 11 downto 9 );
	data4_0   <= IR( 4 downto 0 );
	data7_0   <= IR( 7 downto 0 );

end Behavioral;
