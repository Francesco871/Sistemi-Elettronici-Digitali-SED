library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch is
	Port (
		reset	: in std_logic;
		en		: in std_logic;

		d 	:	in std_logic;
		q 	: out std_logic
	);
end latch;

architecture Behavioral of latch is

begin
	process (en, d, reset) --metto anche d perché la copia di d in q deve avvenire sempre quando en è alto (anche quando d varia mentre en rimane alto)
	begin
		if reset = '1' then
			q <= '0';
		elsif en = '1' then
			q <= d;
		end if;
	end process;

end Behavioral;
