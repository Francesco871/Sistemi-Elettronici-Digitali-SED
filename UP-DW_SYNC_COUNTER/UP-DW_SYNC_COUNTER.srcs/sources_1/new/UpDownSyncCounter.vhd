library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.ALL;

entity UpDownSyncCounter is
	Generic (
		COUNT_WIDTH : integer := 4
	);
	Port(
		reset : in std_logic;
		clk : in std_logic;

		inc_count : in std_logic;
		dec_count : in std_logic;

		count : out std_logic_vector(COUNT_WIDTH-1 downto 0) -- Signed
	);
end UpDownSyncCounter;

architecture Behavioral of UpDownSyncCounter is

	component Registro_count is
		Port (
			reset : in std_logic;
			clk : in std_logic;

			data_in : in std_logic_vector;
			data_out : out std_logic_vector
		);
	end component;

	signal count_internal : std_logic_vector(count'RANGE);
	signal count_reg : std_logic_vector(count'RANGE);
	signal sel : std_logic_vector(1 downto 0);

begin

	Registro_inst1 : Registro_count
	Port Map (
		reset => reset,
		clk => clk,

		data_in => count_internal,
		data_out => count_reg
	);

	sel <= (1 => inc_count , 0 => dec_count); -- == sel(0) <= dec sel(1) <= inc
	with sel select  count_internal <= std_logic_vector(signed(count_reg)-1) when "01",
									   std_logic_vector(signed(count_reg)+1) when "10",
									   count_reg when others;


	count <= count_reg;

end Behavioral;
