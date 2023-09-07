----------------------------------------------------------------------------------------------------
-- Description:	This module serves as the Instruction RAM (IRAM) and it is responsible for storing
--		all the instructions to be executed. The IRAM is filled during the initial setup from
--		a firmware file, "firmware.asm.mem", which contains the precompiled assembly instructions.		
--		Upon a reset signal, a process reads from this file and fills up the instruction memory. 
--		The memory is then accessed via an input address to fetch instructions for execution.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/03
----------------------------------------------------------------------------------------------------

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

	--type RAMtype is array (0 to RAM_DEPTH - 1) of integer; -- std_logic_vector(I_SIZE - 1 downto 0);
	type RAMtype is array (0 to RAM_DEPTH - 1) of std_logic_vector(I_SIZE - 1 downto 0);

	signal IRAM_mem: RAMtype := (others => (others => '0'));

begin

	-- DOUT <= conv_std_logic_vector(IRAM_mem(conv_integer(unsigned(ADDR))),I_SIZE);
	DOUT <= IRAM_mem(conv_integer(unsigned(ADDR(I_SIZE - 1 downto 2))));

	-- purpose: This process is in charge of filling the Instruction RAM with the firmware
	FILL_MEM_P: process (RST, ADDR)
	file mem_fp : text open READ_MODE is "./firmware.asm.mem";
	variable file_line : line;
	variable index : integer;
	variable tmp_data : std_logic_vector(I_SIZE - 1 downto 0);
	begin
		if (RST = '0') then					-- Reset (active low)
			index := 0;
			while not endfile(mem_fp) loop
				readline(mem_fp, file_line);		-- Read one line from the file
				hread(file_line, tmp_data);		-- Convert the line to std_logic_vector
				IRAM_mem(index) <= tmp_data;		-- Store the instruction into internal memory
				index := index + 1;			-- Increment index
			end loop;
		--elsif (CLK = '0') then
		--	DOUT <= IRAM_mem(conv_integer(unsigned(ADDR(I_SIZE - 1 downto 2))));
		end if;
	end process FILL_MEM_P;

end BEHAVIORAL;
