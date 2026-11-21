library ieee;
use ieee.numeric_std.all;

entity sign_extend is
	port(
		data_in  : in  signed( 4 downto 0 );
		data_out : out signed( 7 downto 0 )
	);
end sign_extend;

architecture Behavioral of sign_extend is

begin
	
	data_out <= resize( data_in, data_out'length );
	
end Behavioral;