	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

	entity mem_rom is 
		generic(
			DEPTH 	: integer := 256;
			WIDTH 	: integer := 16;
			ADDR_LEN : integer := 8
		);	
		port(
			addr     : in  std_logic_vector( ADDR_LEN - 1 downto 0 );
			data_out : out std_logic_vector( WIDTH - 1 downto 0 )
		);
	end mem_rom;

	architecture Behavioral of mem_rom is

		type mem_rom_t is array( 0 to DEPTH - 1 ) of std_logic_vector( WIDTH - 1 downto 0 );
		signal rom : mem_rom_t := ( others => ( others => '0' ) );
				
	begin
		
		data_out <= rom( to_integer( unsigned( addr ) ) );

	end Behavioral;