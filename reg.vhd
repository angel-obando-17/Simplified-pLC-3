library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port(
		clk 	: in std_logic;
		reset : in std_logic;
		en		: in std_logic;
		D_in  : in std_logic_vector( 7 downto 0 );
		Q_out	: out std_logic_vector( 7 downto 0 )
	);
end reg;

architecture Behavioral of reg is

begin

	process( clk, reset )
	begin
		if( reset = '1' ) then
		
			Q_out <= "00000000";
			
		elsif( rising_edge( clk ) ) then
		
			if( en = '1' ) then
				Q_out <= D_in;
			end if;
		
		end if;
	end process;

end Behavioral;