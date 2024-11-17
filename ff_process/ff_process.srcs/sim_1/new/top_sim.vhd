library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity top_sim is
--  Port ( );
end top_sim;

architecture Behavioral of top_sim is

	constant CLK_PERIOD_HALF : time := 5 ns; --mezzo periodo di clock (==> f=100MHz , T=10ns)
	component ff_1bit is
		Port (
		reset	: in std_logic;
		clk		: in std_logic;

		d 	:	in std_logic;
		q 	: out std_logic
		);
	end component;

	signal clk : std_logic := '0';
	signal reset : std_logic := '0';
	signal d, q : std_logic;

begin

	clk <= not clk after CLK_PERIOD_HALF; --per creare il segnale di clock

	DUT : ff_1bit --DUT = device under test
		Port Map(
			clk => clk,
			reset => reset,

			d => d,
			q => q
		);

	process
	begin

		reset <= '0';

		wait for 7 ns;
		d <= '0';
		reset <= '1';

		wait for 20 ns;
		reset <= '0';

		wait for 20 ns;

		wait until rising_edge(clk); --teoricamente d deve essere sincrono con il clk
		d <= '1';
		wait until rising_edge(clk);
		d <= '0';
		wait until rising_edge(clk);
		d <= '1';
		wait until rising_edge(clk);
		d <= '0';

		wait; --lo metto se no il process ricomincia da capo (loop infinito)

	end process;


end Behavioral;
