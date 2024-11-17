library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;

entity HalfAdder is
	Port (
		a : in std_logic;
		b : in std_logic;
		sum : out std_logic;
		Cout : out std_logic
	);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin

	sum <= a xor b;
	Cout <= a and b;


end Behavioral;
