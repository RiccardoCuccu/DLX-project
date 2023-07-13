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
	
	generic (	RAM_DEPTH	: integer := IRAM_SIZE_GLOBAL;
			I_SIZE		: integer := IR_SIZE_GLOBAL);
	
	port (		--CLK		: in  std_logic;
			RST		: in  std_logic;
			ADDR		: in  std_logic_vector(I_SIZE - 1 downto 0);
			DOUT		: out std_logic_vector(I_SIZE - 1 downto 0));

end IRAM;

architecture BEHAVIORAL of IRAM is

	--type RAMtype is array (0 to RAM_DEPTH - 1) of integer;-- std_logic_vector(I_SIZE - 1 downto 0);
	type RAMtype is array (0 to RAM_DEPTH - 1) of std_logic_vector(I_SIZE - 1 downto 0);

	signal IRAM_mem: RAMtype := (others => (others => '0'));

begin

	-- DOUT <= conv_std_logic_vector(IRAM_mem(conv_integer(unsigned(ADDR))),I_SIZE);
	DOUT <= IRAM_mem(conv_integer(unsigned(ADDR(I_SIZE - 1 downto 2))));

	-- purpose: This process is in charge of filling the Instruction RAM with the firmware
	-- type   : combinational
	-- inputs : RST
	-- outputs: IRAM_mem

	FILL_MEM_P: process (RST, ADDR)
	file mem_fp		: text open READ_MODE is "./firmware.asm.mem";
	variable file_line	: line;
	variable index		: integer;
	variable tmp_data	: std_logic_vector(I_SIZE - 1 downto 0);
	begin
		if (RST = '0') then					-- Reset (active low)
			index := 0;
			while not endfile(mem_fp) loop
				readline(mem_fp, file_line);
				hread(file_line, tmp_data);
				IRAM_mem(index) <= tmp_data;
				index := index + 1;
			end loop;
		--elsif (CLK = '0') then
		--	DOUT <= IRAM_mem(conv_integer(unsigned(ADDR(I_SIZE - 1 downto 2))));
		end if;
	end process FILL_MEM_P;

end BEHAVIORAL;
