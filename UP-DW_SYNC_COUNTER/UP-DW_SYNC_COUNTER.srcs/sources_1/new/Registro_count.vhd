library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;

entity Registro_count is
	Port(
		reset : in std_logic;
		clk : in std_logic;

		data_in : in std_logic_vector;
		data_out : out std_logic_vector
	);
end Registro_count;

architecture Behavioral of Registro_count is

	component ff_d is
		Port (
			reset	: in std_logic;
			clk		: in std_logic;

			d 	:	in std_logic;
			q 	: out std_logic
		);
	end component;

begin

	ff_d_GEN : for I in data_in'HIGH downto 0 generate
		ff_d_inst : ff_d
			Port Map (
				reset => reset,
				clk => clk,
				d => data_in(I),
				q => data_out(I)
			);
	end generate;


end Behavioral;
