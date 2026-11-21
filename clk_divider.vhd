library ieee;
use ieee.std_logic_1164.all;

entity clk_divider is
	generic(
		IN_FREQ  : integer := 10_000_000;
		OUT_FREQ : integer := 4
	);
	port(
		clk_in  : in  std_logic;
		reset   : in  std_logic;
		clk_out : out std_logic
	);
end clk_divider;

architecture Behavioral of clk_divider is

	constant HALF_PERIOD : integer := IN_FREQ / ( 2 * OUT_FREQ );

	signal s_count : integer range 0 to HALF_PERIOD - 1 := 0;
	signal s_clk   : std_logic := '0';

begin

	process( clk_in, reset )
	begin
		if( reset = '1' ) then
			s_count <= 0;
			s_clk   <= '0';

		elsif( rising_edge( clk_in ) ) then
			if( s_count = HALF_PERIOD - 1 ) then
				s_count <= 0;
				s_clk   <= not s_clk;
			else
				s_count <= s_count + 1;
			end if;
		end if;
	end process;

	clk_out <= s_clk;

end Behavioral;
