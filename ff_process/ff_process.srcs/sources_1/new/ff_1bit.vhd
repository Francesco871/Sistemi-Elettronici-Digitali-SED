library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_1bit is
	Port (
		reset	: in std_logic;
		clk		: in std_logic;

		d 	:	in std_logic;
		q 	: out std_logic
	);
end ff_1bit;

architecture Behavioral of ff_1bit is

begin

	process (clk, reset)
	begin
		if reset = '1' then
			q <= '0';
		elsif rising_edge(clk) then
			q <= d;
		end if; --NB: vivado capisce che è un flip-flop ma in strutture diverse devo mettere tutte le condizioni: else q <= q
	end process;


end Behavioral;
