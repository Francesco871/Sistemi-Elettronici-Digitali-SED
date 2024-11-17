library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.NUMERIC_STD.ALL;

entity MegaOperation is
	Port (
		clk : in std_logic;
		input_a : in std_logic_vector(31 DOWNTO 0);
		input_b : in std_logic_vector(31 DOWNTO 0);
		input_c : in std_logic_vector(31 DOWNTO 0);
		result : out std_logic_vector(31 DOWNTO 0)
	);
end MegaOperation;

architecture Behavioral of MegaOperation is

	component adder is
		Port (
			input_a			: in unsigned(31 DOWNTO 0);
			input_b			: in unsigned(31 DOWNTO 0);

			result			: out unsigned(31 DOWNTO 0)
		);
	end component;

	component multiplier is
		Port (
			input_a			: in unsigned(31 DOWNTO 0);
			input_b			: in unsigned(31 DOWNTO 0);

			result			: out unsigned(31 DOWNTO 0)
		);
	end component;

	signal product, sum : unsigned(31 DOWNTO 0);

begin

	Multi_inst: multiplier
	Port Map(
		input_a => unsigned(input_a),
		input_b => unsigned(input_b),
		result => product
	);

	Add_inst: adder
	Port Map(
		input_a => product,
		input_b => unsigned(input_c),
		result => sum
	);

	process(clk)
	begin
		if rising_edge(clk) then
			result <= std_logic_vector(sum);
		end if;
	end process;

end Behavioral;
