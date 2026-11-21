library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
	port(
		ina	 : in  std_logic_vector( 7 downto 0 );  
		inb	 : in  std_logic_vector( 7 downto 0 ); 
		inc	 : in  std_logic_vector( 7 downto 0 ); 
		ind	 : in  std_logic_vector( 7 downto 0 ); 
		sel	 : in  std_logic_vector( 1 downto 0 );
		outmux : out std_logic_vector( 7 downto 0 )
	);
end mux4to1;

architecture Behavioral of mux4to1 is

begin

	with sel select
		outmux <= ina when "00",
					 inb when "01",
					 inc when "10",
					 ind when others;

end Behavioral;