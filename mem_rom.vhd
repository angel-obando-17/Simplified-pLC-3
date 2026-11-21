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
		signal rom : mem_rom_t := ( x"2210", x"2410", x"5020", x"1C25", x"162A", x"0809", x"1881",
											 x"1A02", x"1404", x"1205", x"1E21", x"9FFF", x"1FE1", x"16C7",
											 x"C180", x"1E20", x"C1C0", x"0000", x"0001", others => x"0000" );
				
	begin
		
		data_out <= rom( to_integer( unsigned( addr ) ) );

	end Behavioral;