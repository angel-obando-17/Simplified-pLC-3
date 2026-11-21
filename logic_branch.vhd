library ieee;
use ieee.std_logic_1164.all;

entity logic_branch is
	port(
		data_in  : in  std_logic_vector( 7 downto 0 );
		data_out : out std_logic_vector( 2 downto 0 )
	);
end logic_branch;

architecture Behavioral of logic_branch is

	constant ALL_ZEROS : std_logic_vector( 7 downto 0 ) := ( others => '0' );
	
begin

	data_out( 2 ) <= data_in( 7 );
	data_out( 1 ) <= '1' when ( data_in = ALL_ZEROS ) else '0';
	data_out( 0 ) <= data_out( 2 ) nor data_out( 1 );
	
end Behavioral;