library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sim_MegaOp3 is
--  Port ( );
end sim_MegaOp3;

architecture Behavioral of sim_MegaOp3 is

	component MegaOperation is
		Port (
		clk : in std_logic;
		input_a : in std_logic_vector(31 DOWNTO 0);
		input_b : in std_logic_vector(31 DOWNTO 0);
		input_c : in std_logic_vector(31 DOWNTO 0);
		result : out std_logic_vector(31 DOWNTO 0)
		);
	end component;
    
    signal clk  : std_logic := '0' ;
	signal input_a, input_b, input_c, result : std_logic_vector(31 DOWNTO 0) := (Others => '0');

begin
--NB: dut = device under test
	clk <= not clk after 10 ns;
	dut: MegaOperation
		Port map(
			clk => clk,
			input_a => input_a,
			input_b => input_b,
			input_c => input_c,
			result => result
		);

	process
	begin
		input_a <= std_logic_vector(to_unsigned(3, input_a'LENGTH));
		input_b <= std_logic_vector(to_unsigned(3, input_b'LENGTH));
		input_c <= std_logic_vector(to_unsigned(1, input_c'LENGTH));
		wait for 35 ns;
		input_a <= std_logic_vector(to_unsigned(8, input_a'LENGTH));
		input_b <= std_logic_vector(to_unsigned(3, input_b'LENGTH));
		input_c <= std_logic_vector(to_unsigned(6, input_c'LENGTH));
		wait;
	end process;

end Behavioral;
