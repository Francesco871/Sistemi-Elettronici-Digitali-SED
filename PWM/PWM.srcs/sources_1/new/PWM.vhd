library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM is
	Port (
		reset : in std_logic;
		clk : in std_logic;
		t_on : in std_logic_vector(8-1 DOWNTO 0); -- UNSIGNED
		t_total : in std_logic_vector(8-1 DOWNTO 0); -- UNSIGNED
		pwm_out : out std_logic
	);
end PWM;

architecture Behavioral of PWM is

	signal count_ck : integer := 0;

begin  -- SBAGLIATO: se ad esempio t_on cambia prima che abbia raggiunto t_total mi risale l'uscita che magari era già salita prima con il vecchio t_on ==> sbagliato

	process (clk, reset)
	begin
		if reset = '1' then
			pwm_out <= '0';
			count_ck <= 0;

		elsif rising_edge(clk) then
			count_ck <= count_ck + 1;
			if count_ck >= to_integer(unsigned(t_total)) then
				count_ck <= 0;
			end if;

			if count_ck <= to_integer(unsigned(t_on)) then
				pwm_out <= '1';
			else
				pwm_out <= '0';
			end if;
			
		end if;

	end process;


end Behavioral;

-- SOLUZIONE GARZETTI:
--	signal count : unsigned(t_total'RANGE) := to_unsigned(0, t_total'LENGHT); --> inizializza a zero
--	signal t_on_reg : std_logic_vector(8-1 DOWNTO 0) := to_unsigned(0, t_total'LENGHT);
--	signal t_total_reg : std_logic_vector(8-1 DOWNTO 0) := to_unsigned(0, t_total'LENGHT);
--
--begin
--	process(clk, reset, t_on, t_total)
--	begin
--		if reset = '1' then
--			pwm_out <= '0';
--			count <= to_unsigned(0, t_total'LENGHT);
--
--			t_on_reg <= t_on;
--			t_total_reg <= to_unsigned(0, t_total'LENGHT);
--		elsif rising_edge(clk) then
--
--			count <= count + 1; N.B: c'è differenza tra aumentare il count a questa riga e farlo in fondo dopo l'if
--
--			--controllare se count = t_total => count = 0, pwm_out = 1
--			-- controllare se count = t_on => pwm_out = 0
--
--			if count = t_total_reg then
--				count <= to_unsigned(0, t_total'LENGHT);
--				pwm_out <= '1';
--
--				--Registro t_on e t_total
--				t_on_reg <= unsigned(t_on);
--				t_total_reg <= unsigned(t_total);
--
--			elsif count = t_on_reg then
--				pwm_out <= '0';
--			end if;
--
--		end if;
--
--	end process;