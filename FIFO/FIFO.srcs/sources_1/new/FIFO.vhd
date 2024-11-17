library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity FIFO is
	Generic(
		FIFO_WIDTH : integer := 8;
		FIFO_DEPTH : integer := 16
	);
	Port(
		reset   : in  std_logic;
		clk     : in  std_logic;
    
		din     : in  std_logic_vector(FIFO_WIDTH-1 DOWNTO 0);
		dout    : out std_logic_vector(FIFO_WIDTH-1 DOWNTO 0);
    
		rd_en   : in  std_logic;
		wr_en   : in  std_logic;
		full    : out std_logic;
		empty   : out std_logic
	);
end FIFO;

architecture Behavioral of FIFO is

	type my_memory is array (0 TO FIFO_DEPTH-1) of std_logic_vector(FIFO_WIDTH-1 DOWNTO 0);
	signal mem : my_memory;
	signal write_pointer, read_pointer : integer range FIFO_DEPTH-1 DOWNTO 0 := 0;
	signal wrd_counter : integer range FIFO_DEPTH DOWNTO 0 := 0;

begin

	process(clk, reset)
    	variable wrd_var : integer := 0;
	begin
		if reset = '1' then
     		wrd_counter <= 0;
     		read_pointer   <= 0;
    		write_pointer  <= 0;
    		mem         <= (Others => (Others => '0'));
		elsif rising_edge(clk) then
			wrd_var := wrd_counter;
-- 1) Controllo sul full e write
    		if wr_en = '1' and wrd_var /= FIFO_DEPTH-1 then --Domanda è se posso leggere full o meno
      			mem(write_pointer) <= din;
        		wrd_var := wrd_var + 1;
        		if write_pointer /= FIFO_DEPTH-1 then
          			write_pointer <= write_pointer + 1;
        		else
          			write_pointer <= 0;
        		end if;
    		end if;
-- 2) Controllo sul empty e read
    		if rd_en = '1' and wrd_var /= 0 then
        		dout <= mem(read_pointer);
        		wrd_var := wrd_var - 1;
        		if read_pointer /= FIFO_DEPTH-1 then
        			read_pointer <= read_pointer + 1;
        		else
        			read_pointer <= 0;
        		end if;
    		end if;
    		wrd_counter <= wrd_var;
-- SURCLASSATO DALL'IDEA DI GARZO
---- 3) Aggiornamento di full e di empty 
--      if wrd_counter = 0 then
--        empty   <= '1';
--        full    <= '0';
--      elsif wrd_counter = FIFO_DEPTH-1 then
--        empty   <= '0';
--        full    <= '1';
--      else
--        empty, full   <= '0'; -- made by jack se non funziona è PIRLA
--      end if;
    	end if;
	end process;

	full  <= '1' when wrd_counter = FIFO_DEPTH-1 else
          	 '0';
	empty <= '1' when wrd_counter = 0 else
          	 '0';

end Behavioral;
