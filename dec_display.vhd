library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dec_display is
	port(
		value     : in  std_logic_vector( 7 downto 0 );
		hex_tens  : out std_logic_vector( 7 downto 0 );
		hex_units : out std_logic_vector( 7 downto 0 )
	);
end dec_display;

architecture struct of dec_display is

	signal s_value : integer range 0 to 255;
	signal s_tens, s_units : std_logic_vector( 3 downto 0 );

begin

	s_value <= to_integer( unsigned( value ) );

	s_tens  <= std_logic_vector( to_unsigned( ( s_value / 10 ) mod 10, 4 ) );
	s_units <= std_logic_vector( to_unsigned( s_value mod 10, 4 ) );

	inst_seg_tens : entity work.seg7_decoder
		port map(
			digit    => s_tens,
			segments => hex_tens( 6 downto 0 )
		);

	inst_seg_units : entity work.seg7_decoder
		port map(
			digit    => s_units,
			segments => hex_units( 6 downto 0 )
		);

	hex_tens( 7 )  <= '0' when ( s_value >= 100 ) else '1';
	hex_units( 7 ) <= '1';

end struct;
