library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DLX_DATAPATH is

	generic (	IR_SIZE			: integer := IR_SIZE_GLOBAL;	-- Instruction Register size		/ 32 bits
			PC_SIZE			: integer := PC_SIZE_GLOBAL);	-- Program Counter size			/ 32 bits

	port (		CLK			: in std_logic;	-- Clock
			RST			: in std_logic;	-- Reset:Active-Low

			IRam_DIn		: in std_logic_vector(IR_SIZE - 1 downto 0);

			-- IF Control Signal
			IR_LATCH_EN		: in std_logic;	-- Instruction Register Latch Enable
			NPC_LATCH_EN		: in std_logic;

			-- ID Control Signals
			RegA_LATCH_EN		: in std_logic;	-- Register A Latch Enable
			RegB_LATCH_EN		: in std_logic;	-- Register B Latch Enable
			RegIMM_LATCH_EN		: in std_logic;	-- Immediate Register Latch Enable

			-- EX Control Signals
			MUXA_SEL		: in std_logic;	-- MUX-A Sel
			MUXB_SEL		: in std_logic;	-- MUX-B Sel
			ALU_OUTREG_EN		: in std_logic;	-- ALU Output Register Enable
			EQ_COND			: in std_logic;	-- Branch if (not) Equal to Zero

			-- ALU Operation Code
			ALU_OPCODE		: in aluOp;	-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
			--ALU_OPCODE		: in std_logic_vector(ALU_OPC_SIZE - 1 downto 0);

			-- MEM Control Signals
			DRAM_WE			: in std_logic;	-- Data RAM Write Enable
			LMD_LATCH_EN		: in std_logic;	-- LMD Register Latch Enable
			JUMP_EN			: in std_logic;	-- JUMP Enable Signal for PC input MUX
			PC_LATCH_EN		: in std_logic;	-- Program Counte Latch Enable

			-- WB Control signals
			WB_MUX_SEL		: in std_logic;	-- Write Back MUX Sel
			RF_WE			: in std_logic;	-- Register File Write Enable

			IR_OUT			: out std_logic_vector(IR_SIZE - 1 downto 0);	-- Instruction Register		/ 32 bits
			PC_OUT			: out std_logic_vector(PC_SIZE - 1 downto 0));	-- Program Counter		/ 32 bits

end DLX_DATAPATH;


architecture DLX_DATAPATH_ARCH of DLX_DATAPATH is

	------------------------------------------------------------------------------------------------------------------------
	-- Components Declaration
	------------------------------------------------------------------------------------------------------------------------

	component REGISTER_FILE is

		generic	(	N		: integer := RF_SIZE_GLOBAL;
				NA		: integer := RF_ADDRESSES_GLOBAL);

		port	(	CLK		: in	std_logic;
				RESET		: in	std_logic;
				ENABLE		: in	std_logic;
				RD1		: in	std_logic;
				RD2		: in	std_logic;
				WR		: in	std_logic;
				ADD_WR		: in	std_logic_vector(NA - 1 downto 0);	-- /  5 bits
				ADD_RD1		: in	std_logic_vector(NA - 1 downto 0);	-- /  5 bits
				ADD_RD2		: in	std_logic_vector(NA - 1 downto 0);	-- /  5 bits
				DATAIN		: in	std_logic_vector(N - 1 downto 0);	-- / 32 bits
				OUT1		: out	std_logic_vector(N - 1 downto 0);	-- / 32 bits
				OUT2		: out	std_logic_vector(N - 1 downto 0));	-- / 32 bits

	end component;

	component MUX41 is

		generic	(	N		: integer := RF_SIZE_GLOBAL);
	
		port	(	A		: in	std_logic_vector(N - 1 downto 0);	-- / 32 bits
				B		: in	std_logic_vector(N - 1 downto 0);	-- / 32 bits
				C		: in	std_logic_vector(N - 1 downto 0);	-- / 32 bits
				D		: in	std_logic_vector(N - 1 downto 0);	-- / 32 bits
				S		: in	std_logic_vector(1 downto 0);		-- /  2 bits
				Y		: out	std_logic_vector(N - 1 downto 0));	-- / 32 bits

	end component;

	component ALU is
		generic (	N		: integer := ALU_OP_SIZE_GLOBAL;
				NB		: integer := ALU_BLOCK_SIZE_GLOBAL);

		port (		OP1		: in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bits
				OP2		: in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bits
				OPC		: in	aluOp;					-- Control Signal
				Y		: out	std_logic_vector(N - 1 downto 0);	-- Result		/ 32 bits
				Z		: out	std_logic);				-- Zero flag	
				--Co		: out	std_logic);
				--Ovf		: out	std_logic);
	end component;


--	component FORWARDING_UNIT is
--	end component;


	------------------------------------------------------------------------------------------------------------------------
	-- Signals Declaration
	------------------------------------------------------------------------------------------------------------------------
	
	-- Instruction Register (IR) and Program Counter (PC) declaration
	signal IR : std_logic_vector(IR_SIZE - 1 downto 0);							-- Instruction Register signals		/ 32 bits
	signal PC : std_logic_vector(PC_SIZE - 1 downto 0);							-- Program Counter signals		/ 32 bits

	-- Instruction Ram Bus signals
--	signal IRam_DOut : std_logic_vector(SIZE_IR - 1 downto 0);

	-- Datapath Bus signals
	signal PC_BUS : std_logic_vector(PC_SIZE - 1 downto 0);							-- Program Counter Bus			/ 32 bits

	-- FETCH-DECODE (IF_ID) Pipeline signals
	signal IF_ID_PC, IF_ID_PC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);				-- Program Counter signals		/ 32 bits
	signal IF_ID_IR, IF_ID_IR_NEXT : std_logic_vector(IR_SIZE - 1 downto 0);				-- Instruction Register signals		/ 32 bits
	signal IF_ID_ALU_OPCODE, IF_ID_ALU_OPCODE_NEXT : aluOp;							-- ALU Operation Code

	-- DECODE-EXECUTE (DE_EX) Pipeline signals
	signal ID_EX_PC, ID_EX_PC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);				-- Program Counter signals		/ 32 bits
	signal ID_EX_IR, ID_EX_IR_NEXT : std_logic_vector(IR_SIZE - 1 downto 0);				-- Instruction Register signals		/ 32 bits
	signal ID_EX_RF_ADD_WR, ID_EX_RF_ADD_WR_NEXT : std_logic_vector(RF_ADDRESSES_GLOBAL - 1 downto 0);	-- Register File - Write address	/  5 bits
	signal ID_EX_RF_DATAIN, ID_EX_RF_DATAIN_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);		-- Register File - Write data		/ 32 bits
	signal ID_EX_RF_OUT1, ID_EX_RF_OUT1_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);		-- Register File - Read data 1		/ 32 bits
	signal ID_EX_RF_OUT2, ID_EX_RF_OUT2_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);		-- Register File - Read data 2		/ 32 bits
	signal ID_EX_ALU_OPCODE, ID_EX_ALU_OPCODE_NEXT : aluOp;							-- ALU Operation Code

	-- EXECUTE-MEMORY (EX_MEM) Pipeline signals

	-- MEMORY-WRITE BACK (MEM_WB) Pipeline signals

	-- Registe File signals
	signal RF_ENABLE, RF_WR, RF_RD1, RF_RD2 : std_logic;
	signal RF_ADD_WR, RF_ADD_RD1, RF_ADD_RD2 : std_logic_vector(RF_ADDRESSES_GLOBAL - 1 downto 0);		-- /  5 bits
	signal RF_DATAIN, RF_OUT1, RF_OUT2 : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- / 32 bits

	-- ALU signals
	signal ALU_ZERO : std_logic;
	signal ALU_MUX_SEL1, ALU_MUX_SEL2 : std_logic_vector(1 downto 0);					-- /  2 bits
	signal ALU_OP1, ALU_OP2, ALU_OUTPUT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- / 32 bits

	-- Forwarding Unit signals

	begin

		PC_OUT	<= PC;
		IR_OUT	<= IR;

		------------------------------------------------------------------------------------------------------------------------
		-- Processes
		------------------------------------------------------------------------------------------------------------------------

		PIPELINES: process(CLK)
		begin
			if (CLK'event and CLK = '1') then
				if (RST = '0') then
					-- FETCH-DECODE
					IF_ID_PC <= (others => '0');			-- Program Counter signal
					IF_ID_IR <= (others => '0');			-- Instruction Register signal
					IF_ID_ALU_OPCODE <= OP_NOP;			-- ALU Operation Code

					-- DECODE-EXECUTE
					ID_EX_PC <= (others => '0');			-- Program Counter signal
					ID_EX_IR <= (others => '0');			-- Instruction Register signal
					ID_EX_RF_ADD_WR <= (others => '0');		-- Register File - Write address
					ID_EX_RF_DATAIN <= (others => '0');		-- Register File - Write data
					ID_EX_RF_OUT1 <= (others => '0');		-- Register File - Read data 1
					ID_EX_RF_OUT2 <= (others => '0');		-- Register File - Read data 2
					ID_EX_ALU_OPCODE <= OP_NOP;			-- ALU Operation Code

					-- EXECUTE-MEMORY

					-- MEMORY-WRITE BACK
				else
					-- FETCH-DECODE
					IF_ID_PC <= IF_ID_PC_NEXT;			-- Program Counter signal
					IF_ID_IR <= IF_ID_IR_NEXT;			-- Instruction Register signal
					IF_ID_ALU_OPCODE <= IF_ID_ALU_OPCODE_NEXT;	-- ALU Operation Code

					-- DECODE-EXECUTE
					ID_EX_PC <= ID_EX_PC_NEXT;			-- Program Counter signal
					ID_EX_IR <= ID_EX_IR_NEXT;			-- Instruction Register signal
					ID_EX_RF_ADD_WR <= ID_EX_RF_ADD_WR_NEXT;	-- Register File - Write address
					ID_EX_RF_DATAIN <= ID_EX_RF_DATAIN_NEXT;	-- Register File - Write data
					ID_EX_RF_OUT1 <= ID_EX_RF_OUT1_NEXT;		-- Register File - Read data 1
					ID_EX_RF_OUT2 <= ID_EX_RF_OUT2_NEXT;		-- Register File - Read data 2
					ID_EX_ALU_OPCODE <= ID_EX_ALU_OPCODE_NEXT;	-- ALU Operation Code

					-- EXECUTE-MEMORY

					-- MEMORY-WRITE BACK
				end if;
			end if;
		end process PIPELINES;
					

		-- This is the input to program counter: currently zero 
		-- so no update of PC happens
		-- TO BE REMOVED AS SOON AS THE DATAPATH IS INSERTED!!!!!
		-- a proper connection must be made here if more than one
		-- instruction must be executed
		-- PC_BUS <= (others => '0'); 

--		PC_BUS_P: process (CLK, RST)
--		begin
--			if RST = '0' then			-- asynchronous reset (active low)
--				PC_BUS <= (others => '0');
--			elsif CLK'event and CLK = '0' then	-- rising clock edge
--				PC_BUS <= std_logic_vector(unsigned(PC) + 4);
--			end if;
--		end process PC_BUS_P;


		-- Program Counter Process
		--	type   : sequential
		--	inputs : CLK, RST, PC_BUS, PC_LATCH_EN
		--	outputs: PC

		PC_P: process (CLK, RST)
		begin
			if RST = '0' then			-- asynchronous reset (active low)
				PC <= (others => '0');
			elsif CLK'event and CLK = '1' then	-- rising clock edge
				if (PC_LATCH_EN = '1') then
					PC <= PC_BUS;
				end if;
			end if;
		end process PC_P;


		-- Instruction Register Process
		-- 	type   : sequential
		-- 	inputs : CLK, RST, IRam_DIn, IR_LATCH_EN
		-- 	outputs: IR

		IR_P: process (CLK, RST)
		begin
			if RST = '0' then			-- asynchronous reset (active low)
				IR <= (others => '0');
			elsif CLK'event and CLK = '1' then	-- rising clock edge
				if (IR_LATCH_EN = '1') then
					IR <= IRam_DIn;
				end if;
			end if;
		end process IR_P;


		------------------------------------------------------------------------------------------------------------------------
		-- FETCH (IF)
		------------------------------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : PC, JUMP_EN
		--	outputs: PC_BUS

		FETCH_P: process(RST, PC, JUMP_EN)
		begin
-- NOTA: DEFINIRE JUMP_PC NEL DECODE
			if RST = '0' then						-- asynchronous reset (active low)
				PC_BUS <= (others => '0');
			elsif JUMP_EN = '0' then					-- increment PC
				PC_BUS <= std_logic_vector(unsigned(PC) + 4);
--			else								-- jump to JUMP_PC + 4
--				PC_BUS <= std_logic_vector(unsigned(JUMP_PC) + 4);			
			end if;
		end process FETCH_P;

		-- IF-ID PIPELINE
		IF_ID_PC_NEXT <= PC;
		IF_ID_IR_NEXT <= IR;
		IF_ID_ALU_OPCODE_NEXT <= ALU_OPCODE;


		------------------------------------------------------------------------------------------------------------------------
		-- DECODE (DE)
		------------------------------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : RST, IF_ID_PC, IF_ID_IR
		--	outputs: RF_SIGNALS

		DECODE_P: process(RST, IF_ID_PC, IF_ID_IR)
		begin	
			if RST = '0' then						-- asynchronous reset (active low)
				RF_ENABLE	<= '0';
				RF_RD1		<= '0';
				RF_RD2		<= '0';
				RF_WR		<= '0';
				RF_ADD_WR	<= (others => '0');
				RF_ADD_RD1	<= (others => '0');
				RF_ADD_RD2	<= (others => '0');
				RF_DATAIN	<= (others => '0');
			else
				RF_ENABLE	<= '1';
				RF_RD1		<= '1';
				RF_RD2		<= '1';
				RF_WR		<= '1';			-- NOTA: VALORE DA METTERE AD 1 QUANDO C'È DA ASSEGNARE UN VALORE DI RITORNO DAL WRITE BACK
				RF_ADD_WR	<= (others => '0');	-- NOTA: INDIRIZZO DA ASSEGNARE DI RITORNO DAL WRITE BACK
				RF_ADD_RD1	<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL);				-- IF_ID_IR(25 downto 21);
				RF_ADD_RD2	<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL*2);	-- IF_ID_IR(20 downto 16);
				RF_DATAIN	<= (others => '0');	-- NOTA: VALORE DA ASSEGNARE DI RITORNO DAL WRITE BACK
			end if;
		end process DECODE_P;

--		JUMP_ADDRESS_P: process(Branch_r, IF_ID_PC, ID_EX_OFFSET_NEXT, RF_OUT1)
--		begin
--			if (Branch_r = '0') then			-- NOTA: Branch_r è un segnale per indicare il jump relativo (definirlo come input del datapath)
--				JUMP_PC <= IF_ID_PC + ID_EX_OFFSET_NEXT;		-- relative jump
--			else
--				JUMP_PC <= RF_OUT1;					-- absolute jump
--			end if;
--		end process;

		REGF: REGISTER_FILE

		generic map (	N	=> RF_SIZE_GLOBAL,
				NA	=> RF_ADDRESSES_GLOBAL)

		port map (	CLK	=> CLK,
				RESET	=> RST,
				ENABLE	=> RF_ENABLE,
				RD1	=> RF_RD1,
				RD2	=> RF_RD2,
				WR	=> RF_WR,
				ADD_WR	=> RF_ADD_WR,
				ADD_RD1	=> RF_ADD_RD1,
				ADD_RD2	=> RF_ADD_RD2,
				DATAIN	=> RF_DATAIN,
				OUT1	=> RF_OUT1,
				OUT2	=> RF_OUT2);

-- NOTE: da definire
--		IMMGR: IMMEDIATE_GENERATOR
--
--		generic map (	N_tot  	=> M)
--		
--		port map (	INSTRUCTION => IF_ID_INSTRUCTION,
--				IMMEDIATE   => ID_EX_OFFSET_NEXT);

--		-- used for branch prediction
--		COMP_REG: process(ALUSrc_PC, ALU_result, EX_MEM_ALU_result, Branch_j, Branch, EX_MEM_RD, ID_EX_RD, MEM_WB_RD, writa_data_f, read_addr_f1, read_data_f1)
--		begin
--			{...}
--		end process;

--		-- How stall the pipeline, this is the mux for control signals
--		STALL_CONTROL_SIGNAL: process(stall, EXECUTE_CONTROL_SIGNALS, MemWrite, MemRead, Branch, RegWrite, MemToReg, ALUSrc, ALUSrc_PC)
--		begin
--			{..}
--		end process;

--		-- choose if use integer or floating register according OPCODE
--		CHOOSE_I_F_REG: process(IF_ID_INSTRUCTION(31 DOWNTO 26))
--		begin
--			{..}
--		end process;

--		CHOOSE_RD: process(IF_ID_INSTRUCTION, ALUSrc, Branch_j, Float_operation_RD)
--		begin
--			{..}
--		end process;

		-- ID-EX PIPELINE
		ID_EX_PC_NEXT <= IF_ID_PC;
		ID_EX_IR_NEXT <= IF_ID_IR;
--		ID_EX_OFFSET_NEXT <= ID_EX_OFFSET;

		ID_EX_RF_ADD_WR_NEXT <= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL*2 - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL*3);			-- IF_ID_IR(15 downto 11);
		ID_EX_RF_DATAIN_NEXT <= RF_DATAIN;
		ID_EX_RF_OUT1_NEXT <= RF_OUT1;
		ID_EX_RF_OUT2_NEXT <= RF_OUT2;

		ID_EX_ALU_OPCODE_NEXT <= IF_ID_ALU_OPCODE;

		------------------------------------------------------------------------------------------------------------------------
		-- EXECUTE (EX)
		------------------------------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : 
		--	outputs: 

		ALUMUX1: MUX41

		generic map (	N	=> RF_SIZE_GLOBAL)

		port map (	A	=> ID_EX_RF_OUT1,
				B	=> ID_EX_RF_DATAIN,
				C	=> (others => '0'),	-- NOTA: EX_MEM_ALU_result     (forwarding)
				D	=> ID_EX_PC,
				S	=> ALU_MUX_SEL1,
				Y	=> ALU_OP1);
	
		ALUMUX2: MUX41

		generic map (	N	=> RF_SIZE_GLOBAL)

		port map (	A	=> ID_EX_RF_OUT2,
				B	=> ID_EX_RF_DATAIN,
				C	=> (others => '0'),	-- NOTA: EX_MEM_ALU_result     (forwarding)
				D	=> (others => '0'),
				S	=> ALU_MUX_SEL2,
				Y	=> ALU_OP2);

--		RS2_OR_IMM: process(ID_EX_ALUSrc, ID_EX_immediate, EX_MEM_FowardB_Next_app)
--		begin
--			-- for immediate operation
--			if (ID_EX_ALUSrc = '1') then
--				ALU_operand2 <= ID_EX_immediate;
--			-- for other operation
--			else
--				ALU_operand2 <= EX_MEM_FowardB_Next_app;
--			end if;
--		end process;

--		SW_OR_SB: process(EX_MEM_FowardB_Next_app, ID_EX_Take_MSB)
--		begin
--			-- for store a byte
--			if (ID_EX_Take_MSB = '1') then
--				EX_MEM_FowardB_Next(31 downto 8) <= (Others => '0');
--				EX_MEM_FowardB_Next(7 downto 0) <= EX_MEM_FowardB_Next_app(31 downto 24);
--			-- for other store
--			else
--				EX_MEM_FowardB_Next <= EX_MEM_FowardB_Next_app;
--			end if;
--		end process;

		ARITHMETIC_LOGIC_UNIT: ALU
			
			generic map (	N	=> ALU_OP_SIZE_GLOBAL,
					NB	=> ALU_BLOCK_SIZE_GLOBAL)
			
			port map (	OP1	=> ALU_OP1,
					OP2	=> ALU_OP2,
					OPC	=> ID_EX_ALU_OPCODE,
					Y	=> ALU_OUTPUT,
					Z	=> ALU_ZERO);

		------------------------------------------------------------------------------------------------------------------------
		-- MEMORY (MEM)
		------------------------------------------------------------------------------------------------------------------------

		------------------------------------------------------------------------------------------------------------------------
		-- WRITE BACK (WB)
		------------------------------------------------------------------------------------------------------------------------


		------------------------------------------------------------------------------------------------------------------------
		-- Components Mapping
		------------------------------------------------------------------------------------------------------------------------






end DLX_DATAPATH_ARCH;
