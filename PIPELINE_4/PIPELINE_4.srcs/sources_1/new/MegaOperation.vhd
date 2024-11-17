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

	component Interleaving is
		Port (
			clk : in std_logic;
			input_a : in unsigned(31 DOWNTO 0);
			input_b : in unsigned(31 DOWNTO 0);
			result : out unsigned(31 DOWNTO 0)
		);
	end component;

	signal input_c_1, product_0, product_1, sum_1 : unsigned(31 DOWNTO 0);

begin

	Multi_inst: Interleaving
	Port Map(
		input_a => unsigned(input_a),
		input_b => unsigned(input_b),
		result => product_0,
		clk => clk
	);

	Add_inst: adder
	Port Map(
		input_a => product_1,
		input_b => input_c_1,
		result => sum_1
	);

	process(clk)
	begin
		if rising_edge(clk) then
			input_c_1 <= unsigned(input_c);
			product_1 <= product_0;
			result <= std_logic_vector(sum_1);
		end if;
	end process;

end Behavioral;
