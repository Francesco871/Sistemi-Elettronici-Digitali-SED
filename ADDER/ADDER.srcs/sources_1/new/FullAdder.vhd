library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
	Port (
		a_f : in std_logic;
		b_f : in std_logic;
		Cin_f : in std_logic;
		Cout_f : out std_logic;
		sum_f : out std_logic
	);
end FullAdder;

architecture Behavioral of FullAdder is

	component HalfAdder is
		Port (
			a : in std_logic;
			b : in std_logic;
			sum : out std_logic;
			Cout : out std_logic
		);
	end component;

	signal n1 : std_logic;
	signal n2 : std_logic;
	signal n3 : std_logic;
	--oppure al posto di n2 e n3 uso: signal c : std_logic_vector(0 to 1);

begin
	
	HalfAdder_inst1 : HalfAdder
	Port Map (
		a => a_f,
		b => b_f,
		sum => n1,
		Cout => n2
	);

	HalfAdder_inst2 : HalfAdder
	Port Map (
		a => n1,
		b => Cin_f,
		sum => sum_f,
		Cout => n3
	);

	Cout_f <= n2 or n3;

end Behavioral;
