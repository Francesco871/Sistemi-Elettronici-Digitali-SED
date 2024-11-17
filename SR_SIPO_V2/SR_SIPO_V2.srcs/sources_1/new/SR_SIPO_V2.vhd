library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SR_SIPO_V2 is
	Port(
		reset : in std_logic;
		clk : in std_logic;
		data_in : in std_logic;
		--data_out range is (X DOWNTO 0) where X >0
		data_out : out std_logic_vector
	);
end SR_SIPO_V2;

architecture Behavioral of SR_SIPO_V2 is

	signal q_out : std_logic_vector(data_out'RANGE);

begin

	data_out <= q_out;

	process (clk, reset)
	begin
		if reset = '1' then
			q_out <= (Others => '0');	
		elsif rising_edge(clk) then
			q_out <= data_in & q_out(q_out'HIGH DOWNTO q_out'LOW+1);
		end if;
	end process;

-- NB: si può fare anche con il for:
-- 	for I in q_out'HIGH-1 DOWNTO q_out'LOW loop
-- 		q_out(I) <= q_out(I+1);
-- 	end loop;
-- 	q_out(q_out'HIGH) <= data_in;
-- 
-- OPPURE più bello:
-- 	for I in q_out'RANGE loop
-- 		if I = q_out'HIGH then
-- 			q_out(I) <= data_in;
-- 		else
-- 			q_out(I) <= q_out(I+1);
-- 		end if;
-- 	end loop;

end Behavioral;
