library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterSIPO is
	Generic (
		SR_WIDTH : integer:=4
	);
	Port(
		reset : in std_logic;
		clk : in std_logic;

		data_in : in std_logic;

		data_out : out std_logic_vector(SR_WIDTH-1 downto 0)
	);
end ShiftRegisterSIPO;

architecture Behavioral of ShiftRegisterSIPO is

	component ff_d is
		Port (
			reset	: in std_logic;
			clk		: in std_logic;

			d 	:	in std_logic;
			q 	: out std_logic
		);
	end component;

	signal n : std_logic_vector(SR_WIDTH-1 downto 0); --altro modo per scrivere il range: (data_out'RANGE); = stesso range di data_out
begin

	ff_d_GEN : for I in SR_WIDTH-1 downto 0 generate

		ff_inizio : if I = SR_WIDTH-1 generate
			ff_d_inizio_inst : ff_d
			Port Map (
				reset => reset,
				clk => clk,
				d => data_in,
				q => n(I)
			);
		end generate;

		ff_interno : if I < SR_WIDTH-1 generate -- oppure if I /= SR_WIDTH-1 = diverso da
			ff_d_interno_inst : ff_d
			Port Map (
				reset => reset,
				clk => clk,
				d => n(I+1),
				q => n(I)
			);
		end generate;

	end generate;

	data_out <= n; -- oppure all'inizio del for metto data_out(I) <= n(I)


end Behavioral;
