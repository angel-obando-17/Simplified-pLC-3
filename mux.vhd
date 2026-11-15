library ieee;
use ieee.std_logic_1164.all;

entity mux is
	port(
		sel  	  : in  std_logic_vector( 2 downto 0 );
		in_a 	  : in  std_logic_vector( 7 downto 0 );
		in_b 	  : in  std_logic_vector( 7 downto 0 );
		in_c 	  : in  std_logic_vector( 7 downto 0 );
		in_d 	  : in  std_logic_vector( 7 downto 0 );
		in_e 	  : in  std_logic_vector( 7 downto 0 );
		in_f 	  : in  std_logic_vector( 7 downto 0 );
		in_g 	  : in  std_logic_vector( 7 downto 0 );
		in_h 	  : in  std_logic_vector( 7 downto 0 );
		mux_out : out std_logic_vector( 7 downto 0 )
	);
end mux;

architecture Behavioral of mux is

begin
	
	with sel select
		mux_out <= in_a when "000",
					  in_b when "001",
					  in_c when "010",
					  in_d when "011",
					  in_e when "100",
					  in_f when "101",
					  in_g when "110",
					  in_h when others;

end Behavioral;