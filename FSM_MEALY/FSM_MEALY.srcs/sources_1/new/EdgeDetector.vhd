library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EdgeDetector is
	Port (
		clk : in std_logic;
		reset : in std_logic;
		signal_in : in std_logic;
		upEdge : out std_logic;
		downEdge : out std_logic
	);
end EdgeDetector;

architecture Behavioral of EdgeDetector is

	type stato is (START, WAIT_UP, WAIT_DOWN);
	
	signal state : stato;
	signal next_state : stato;

begin

	transition_logic : process(signal_in, state)
	begin
		case state is
			when START =>
				if signal_in = '1' then next_state <= WAIT_DOWN;
				else next_state <= WAIT_UP;
				end if;

			when WAIT_UP =>
				if signal_in = '1' then next_state <= WAIT_DOWN;
				else next_state <= WAIT_UP;
				end if;

			when WAIT_DOWN =>
				if signal_in = '1' then next_state <= WAIT_DOWN;
				else next_state <= WAIT_UP;
				end if;
		end case;
	end process;

	sync_logic : process(reset, clk)
	begin
		if reset = '1' then
			state <= START;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process;

	output_logic : process(signal_in, state)
	begin
		case state is
			when START =>
				upEdge <= '0';
				downEdge <= '0';

			when WAIT_UP =>
				if signal_in = '1' then upEdge <= '1'; downEdge <= '0';
				else upEdge <= '0'; downEdge <= '0';
				end if;
			when WAIT_DOWN =>
				if signal_in = '1' then upEdge <= '0'; downEdge <= '0';
				else upEdge <= '0'; downEdge <= '1';
				end if;
		end case;
	end process;


end Behavioral;
