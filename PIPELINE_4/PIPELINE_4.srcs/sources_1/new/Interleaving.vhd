library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.NUMERIC_STD.ALL;

entity Interleaving is
	Port (
		clk : in std_logic;
		input_a : in unsigned(31 DOWNTO 0);
		input_b : in unsigned(31 DOWNTO 0);
		result : out unsigned(31 DOWNTO 0)
	);
end Interleaving;

architecture Behavioral of Interleaving is

	component multiplier is
		Port (
			input_a			: in unsigned(31 DOWNTO 0);
			input_b			: in unsigned(31 DOWNTO 0);

			result			: out unsigned(31 DOWNTO 0)
		);
	end component;

	signal input_a_0, input_a_1, input_b_0, input_b_1, result_0, result_1 : unsigned(31 DOWNTO 0);
	signal clk2 : std_logic := '0';

begin

	Multi_inst_0: multiplier
	Port Map(
		input_a => input_a_0,
		input_b => input_b_0,
		result => result_0
	);

	Multi_inst_1: multiplier
	Port Map(
		input_a => input_a_1,
		input_b => input_b_1,
		result => result_1
	);

	dimezzatore_clk : process(clk)
	begin
		if rising_edge(clk) then
			clk2 <= not clk2;
		end if;
	end process;

	latching : process(clk2, input_a, input_b)
	begin
		if clk2 = '1' then
			input_a_0 <= input_a;
			input_b_0 <= input_b;
		else
			input_a_1 <= input_a;
			input_b_1 <= input_b;
		end if;
	end process;

	with clk2 select result <= result_1 when '1',
							   result_0 when Others;

end Behavioral;
