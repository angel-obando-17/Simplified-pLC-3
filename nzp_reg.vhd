library ieee;
use ieee.std_logic_1164.all;

entity nzp_reg is
	port(
		clk 	 : in  std_logic;
		reset  : in  std_logic;
		enable : in  std_logic;
		D_in   : in  std_logic_vector( 2 downto 0 );
		Q_out  : out std_logic_vector( 2 downto 0 )
	);
end nzp_reg;

architecture Behavioral of nzp_reg is

begin

	process( clk, reset )
	begin
		if( reset = '1' ) then
			Q_out <= "010";
			
		elsif( rising_edge( clk ) ) then
			if( enable = '1' ) then
				Q_out <= D_in;
			end if;
		end if;
	end process;

end Behavioral;