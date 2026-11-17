library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(
		in_a 		 : in  std_logic_vector( 7 downto 0 );
		in_b 	 	 : in  std_logic_vector( 7 downto 0 );
		operation : in  std_logic_vector( 1 downto 0 );
		out_alu	 : out std_logic_vector( 7 downto 0 )
	);
end alu;

architecture Behavioral of alu is

begin

	process( in_a, in_b, operation )
	begin
		
		case operation is
		
			when "00" =>
				out_alu <= std_logic_vector( signed( in_a ) + signed( in_b ) );
			
			when "01" =>
				out_alu <= in_a and in_b;
			
			when "10" => 
				out_alu <= not in_a;
			
			when others =>
				out_alu <= ( others => '0' );
		
		end case;
		
	end process;

end Behavioral;