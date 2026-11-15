library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(
		en  	  : in  std_logic;
		sel 	  : in  std_logic_vector( 2 downto 0 );
		dec_out : out std_logic_vector( 7 downto 0 )
	);
end decoder;

architecture Behavioral of decoder is

begin

	process( en, sel )
	begin
		if( en = '0' ) then
		
			dec_out <= X"00";
			
		else
		
			case sel is
				
				when "000" =>
					dec_out <= "00000001";
				when "001" => 
					dec_out <= "00000010";
				when "010" =>
					dec_out <= "00000100";
				when "011" =>
					dec_out <= "00001000";
				when "100" =>
					dec_out <= "00010000";
				when "101" =>
					dec_out <= "00100000";
				when "110" =>
					dec_out <= "01000000";
				when "111" =>
					dec_out <= "10000000";
				when others =>
					dec_out <= "00000000";
			end case;
			
		end if;
	end process;

end Behavioral;