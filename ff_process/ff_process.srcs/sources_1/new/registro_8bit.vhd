library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro_8bit is
	Port (
		reset	: in std_logic;
		clk		: in std_logic;

		d 	:	in std_logic_vector(7 DOWNTO 0);
		q 	: out std_logic_vector(7 DOWNTO 0)
	);
end registro_8bit;

architecture Behavioral of registro_8bit is

begin
	process (clk, reset)
	begin
		if reset = '1' then
			q <= (Others => '0');
		elsif rising_edge(clk) then
			q <= d;
		end if;
	end process;

end Behavioral;

--è la stessa cosa con i loop ma viene più lungo e brutto:
--	process (clk, reset)
--	begin
--		for I in 7 DOWNTO 0 loop
--			if reset = '1' then
--				q(I) <= '0';
--			elsif rising_edge(clk) then
--				q(I) <= d(I);
--			end if;
--		end loop;
--	end process;