library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;

entity Adder_4bit is
	Port (
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		sum : out std_logic_vector(3 downto 0)
	);
end Adder_4bit;

architecture Behavioral of Adder_4bit is

	component HalfAdder is
		Port (
			a : in std_logic;
			b : in std_logic;
			sum : out std_logic;
			Cout : out std_logic
		);
	end component;

	component FullAdder is
		Port (
			a_f : in std_logic;
			b_f : in std_logic;
			Cin_f : in std_logic;
			Cout_f : out std_logic;
			sum_f : out std_logic
		);
	end component;

	signal n1 : std_logic;
	signal n2 : std_logic;
	signal n3 : std_logic;

begin

	HalfAdder_inst1 : HalfAdder
	Port Map (
		a => a(0),
		b => b(0),
		sum => sum(0),
		Cout => n1
	);

	FullAdder_inst1 : FullAdder
	Port Map (
		a_f => a(1),
		b_f => b(1),
		Cin_f => n1,
		Cout_f => n2,
		sum_f => sum(1)
	);

	FullAdder_inst2 : FullAdder
	Port Map (
		a_f => a(2),
		b_f => b(2),
		Cin_f => n2,
		Cout_f => n3,
		sum_f => sum(2)
	);

	FullAdder_inst3 : FullAdder
	Port Map (
		a_f => a(3),
		b_f => b(3),
		Cin_f => n3,
		Cout_f => open,
		sum_f => sum(3)
	);

end Behavioral;
