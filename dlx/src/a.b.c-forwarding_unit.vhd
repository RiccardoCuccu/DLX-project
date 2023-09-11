----------------------------------------------------------------------------------------------------
-- Description:	This module serves as a Forwarding Unit in the pipeline, aiming to detect and 
--		resolve data hazards. It achieves this by forwarding relevant data back to earlier 
--		stages of the pipeline. Specifically, if a register being updated in the MEM or WB 
--		stage is simultaneously being read in the EX stage, the unit triggers data 
--		forwarding to ensure the correct data is utilized.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/11
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity FU is

	generic (	N:		integer := RS_SIZE_GLOBAL);

-- mi serve in input: EX_MEM_ALU_OUT e WB_MUX_OUT

	port (		RS1:		in	std_logic_vector(N - 1 downto 0);	-- Source register 1
			RS2:		in	std_logic_vector(N - 1 downto 0);	-- Source register 2
			RD_MEM:		in	std_logic_vector(N - 1 downto 0);	-- Destination Registers at MEM stage
			RD_WB:		in	std_logic_vector(N - 1 downto 0);	-- Destination Registers at WB stage
			RF_WE_MEM:	in	std_logic;				-- Register File Write Enable at MEM stage
			RF_WE_WB:	in	std_logic;				-- Register File Write Enable at WB stage
			FORWARD_A:	out	std_logic_vector(1 downto 0);		-- Forward Selector A
			FORWARD_B:	out	std_logic_vector(1 downto 0));		-- Forward Selector B

end FU;


architecture BEHAVIORAL of FU is
	begin

		MUXA_PRE_SELECTOR: process(RS1, RD_MEM, RD_WB, RF_WE_WB, RF_WE_MEM)
		begin
			-- if the destination register in MEM stage matches RS1 and write enable is '1' then forward from EX_MEM_ALU_OUT
			if (RD_MEM = RS1 and RF_WE_MEM = '1') then
				FORWARD_A <= "01";
			-- if the destination register in WB stage matches RS1 and write enable is '1' then forward from WB_MUX_OUT
			elsif (RD_WB = RS1 and RF_WE_WB = '1') then
				FORWARD_A <= "10";
			-- otherwise no forwarding needed and ALU input will be from RF_OUT1
			else
				FORWARD_A <= "00";
			end if;
		end process;

		MUXB_PRE_SELECTOR: process(RS2, RD_MEM, RD_WB, RF_WE_WB, RF_WE_MEM)
		begin
			-- if the destination register in MEM stage matches RS2 and write enable is '1' then forward from EX_MEM_ALU_OUT
			if (RD_MEM = RS2 and RF_WE_MEM = '1') then
				FORWARD_B <= "01";
			-- if the destination register in WB stage matches RS2 and write enable is '1' then forward from WB_MUX_OUT
			elsif (RD_WB = RS2 and RF_WE_WB = '1') then
				FORWARD_B <= "10";
			-- otherwise no forwarding needed and ALU input will be from RF_OUT2
			else
				FORWARD_B <= "00";
			end if;	
		end process;

end BEHAVIORAL;
