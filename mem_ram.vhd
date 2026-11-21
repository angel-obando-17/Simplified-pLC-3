library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_ram is 
	generic(
		DEPTH 	: integer := 256;
		WIDTH 	: integer := 16;
		ADDR_LEN : integer := 8
	);	
	port(
		clk		: in  std_logic;
		we			: in  std_logic;
		addr     : in  std_logic_vector( ADDR_LEN - 1 downto 0 );
		data_in  : in  std_logic_vector( WIDTH - 1 downto 0 );
		data_out : out std_logic_vector( WIDTH - 1 downto 0 )
	);
end mem_ram;

architecture Behavioral of mem_ram is

	type mem_ram_t is array( 0 to DEPTH - 1 ) of std_logic_vector( WIDTH - 1 downto 0 );
	signal ram : mem_ram_t := ( others => ( others => '0' ) );
			
begin
	
	process( clk )
	begin
		if( rising_edge( clk ) ) then
			if( we = '1' ) then
				ram( to_integer( unsigned( addr ) ) ) <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= ram( to_integer( unsigned( addr ) ) );

end Behavioral;