library ieee;
use ieee.std_logic_1164.all;

entity branch_control is
	port(
		nzp_reg_flags   : in  std_logic_vector( 2 downto 0 );
		nzp_instr_flags : in  std_logic_vector( 2 downto 0 );
		BEN				 : out std_logic
	);
end branch_control;

architecture Behavioral of branch_control is

begin

	BEN <= ( nzp_reg_flags( 2 ) and nzp_instr_flags( 2 ) ) or ( nzp_reg_flags( 1 ) and nzp_instr_flags( 1 ) ) or ( nzp_reg_flags( 0 ) and nzp_instr_flags( 0 ) );

end Behavioral;