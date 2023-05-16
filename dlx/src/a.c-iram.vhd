library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.constants.all;

-- Instruction IRAM_mem for DLX
-- Memory filled by a process which reads from a file
-- file name is "test.asm.mem"

entity IRAM is
	
	generic (	RAM_DEPTH	: integer := RAM_SIZE_GLOBAL;
			I_SIZE		: integer := IR_SIZE_GLOBAL);
	
	port (		Rst		: in  std_logic;
			Clk		: in  std_logic;
			Addr		: in  std_logic_vector(I_SIZE - 1 downto 0);
			Dout		: out std_logic_vector(I_SIZE - 1 downto 0));

end IRAM;

architecture BEHAVIORAL of IRAM is

	--type RAMtype is array (0 to RAM_DEPTH - 1) of integer;-- std_logic_vector(I_SIZE - 1 downto 0);
	type RAMtype is array (0 to RAM_DEPTH - 1) of std_logic_vector(I_SIZE - 1 downto 0);

	signal IRAM_mem: RAMtype := (others => (others => '0'));

begin

	-- Dout <= conv_std_logic_vector(IRAM_mem(conv_integer(unsigned(Addr))),I_SIZE);
	Dout <= IRAM_mem(conv_integer(unsigned(Addr(I_SIZE - 1 downto 2))));

	-- purpose: This process is in charge of filling the Instruction RAM with the firmware
	-- type   : combinational
	-- inputs : Rst
	-- outputs: IRAM_mem

	FILL_MEM_P: process (Rst, Clk, Addr)
	file mem_fp		: text open READ_MODE is "./test.asm.mem";
	variable file_line	: line;
	variable index		: integer;
	variable tmp_data	: std_logic_vector(I_SIZE - 1 downto 0);
	begin
		if (Rst = '0') then					-- reset active low
			index := 0;
			while not endfile(mem_fp) loop
				readline(mem_fp, file_line);
				hread(file_line, tmp_data);
				IRAM_mem(index) <= tmp_data;
				index := index + 1;
			end loop;
		--elsif (CLK = '0') then
		--	Dout <= IRAM_mem(conv_integer(unsigned(Addr(I_SIZE - 1 downto 2))));
		end if;
	end process FILL_MEM_P;

end BEHAVIORAL;
