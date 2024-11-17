library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.ALL;

entity img_matrix is
	Generic (
		IMG_DIM_POW2 : integer := 2
	);
	Port (
		clk : in std_logic;
		reset : in std_logic;
		in_red : in std_logic_vector(7 DOWNTO 0);
		in_green : in std_logic_vector(7 DOWNTO 0);
		in_blue : in std_logic_vector(7 DOWNTO 0);
		in_x_addr : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0);
		in_y_addr : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0);
		out_gray : out std_logic_vector(7 DOWNTO 0);
		out_x_addr : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0);
		out_y_addr : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0)
	);
end img_matrix;

architecture Behavioral of img_matrix is

	component registro_pixel is
		Port (
			reset : in std_logic;
			clk : in std_logic;

			data_in : in std_logic_vector;
			data_out : out std_logic_vector
		);
	end component;

	type custom_array is array (0 to (2**IMG_DIM_POW2)-1 , 0 to (2**IMG_DIM_POW2)-1) of std_logic_vector(7 DOWNTO 0);

	signal media : std_logic_vector(7 DOWNTO 0);
	signal reg_in : custom_array;
	signal reg_out : custom_array;
	signal uscita : std_logic_vector(7 DOWNTO 0);

begin

	media <= std_logic_vector((unsigned(in_red) + unsigned(in_green) + unsigned(in_blue))/3);

	X_GEN : for I in 0 to (2**IMG_DIM_POW2)-1 generate
		Y_GEN : for J in 0 to (2**IMG_DIM_POW2)-1 generate

			reg_inst : registro_pixel
			Port Map (
				reset => reset,
				clk => clk,

				data_in => reg_in(I,J),
				data_out => reg_out(I,J)
			);

			reg_in(I,J) <= media when I = to_integer(unsigned(in_x_addr)) and J = to_integer(unsigned(in_y_addr)) else reg_out(I,J);

		end generate;
	end generate;

	uscita <= reg_out(to_integer(unsigned(out_x_addr)) , to_integer(unsigned(out_y_addr)));

	reg_uscita_inst : registro_pixel
		Port Map (
			reset => reset,
			clk => clk,

			data_in => uscita,
			data_out => out_gray
		);


end Behavioral;
