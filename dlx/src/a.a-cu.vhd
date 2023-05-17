library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.constants.all;
--use ieee.numeric_std.all;
--use work.all;

entity DLX_CU is

	generic (	MICROCODE_MEM_SIZE	: integer := MMEM_SIZE_GLOBAL;		-- Microcode Memory Size
			FUNC_SIZE		: integer := FUNC_SIZE_GLOBAL;		-- Func Field Size for R-Type Ops
			OP_CODE_SIZE		: integer := OPC_SIZE_GLOBAL;		-- Op Code Size
--			ALU_OPC_SIZE		: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Size
			IR_SIZE			: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
			CW_SIZE			: integer := CW_SIZE_GLOBAL);		-- Control Word Size

	port (		Clk			: in  std_logic;	-- Clock
			Rst			: in  std_logic;	-- Reset:Active-Low

			-- Instruction Register
			IR_IN			: in  std_logic_vector(IR_SIZE - 1 downto 0);

			-- IF Control Signal
			IR_LATCH_EN		: out std_logic;	-- Instruction Register Latch Enable
			NPC_LATCH_EN		: out std_logic;	-- NextProgramCounter Register Latch Enable

			-- ID Control Signals
			RegA_LATCH_EN		: out std_logic;	-- Register A Latch Enable
			RegB_LATCH_EN		: out std_logic;	-- Register B Latch Enable
			RegIMM_LATCH_EN		: out std_logic;	-- Immediate Register Latch Enable

			-- EX Control Signals
			MUXA_SEL		: out std_logic;	-- MUX-A Sel
			MUXB_SEL		: out std_logic;	-- MUX-B Sel
			ALU_OUTREG_EN		: out std_logic;	-- ALU Output Register Enable
			EQ_COND			: out std_logic;	-- Branch if (not) Equal to Zero

			-- ALU Operation Code
			ALU_OPCODE		: out aluOp;		-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
			--ALU_OPCODE		: out std_logic_vector(ALU_OPC_SIZE - 1 downto 0);

			-- MEM Control Signals
			DRAM_WE			: out std_logic;	-- Data RAM Write Enable
			LMD_LATCH_EN		: out std_logic;	-- LMD Register Latch Enable
			JUMP_EN			: out std_logic;	-- JUMP Enable Signal for PC input MUX
			PC_LATCH_EN		: out std_logic;	-- Program Counter Latch Enable

			-- WB Control signals
			WB_MUX_SEL		: out std_logic;	-- Write Back MUX Sel
			RF_WE			: out std_logic);	-- Register File Write Enable

end DLX_CU;


architecture DLX_CU_HW of DLX_CU is
	
	type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
	
	-- look-up table
	signal cw_mem : mem_array := (	

					"111100010000111",	-- x"00" RTYPE	*
					"000000000000000",	-- x"01"
					"111011111001100",	-- x"02" J	*
					"000000000000000",	-- x"03" JAL
					"111010101001000",	-- x"04" BEQZ	*
					"000000000000000",	-- x"05" BNEZ
					"000000000000000",	-- x"06" BFPT
					"000000000000000",	-- x"07" BFPF
					"111010110000111",	-- x"08" ADDI	*
					"000000000000000",	-- x"09" ADDUI
					"000000000000000",	-- x"0A" SUBI
					"000000000000000",	-- x"0B" SUBUI
					"000000000000000",	-- x"0C" ANDI
					"000000000000000",	-- x"0D" ORI
					"000000000000000",	-- x"0E" XORI
					"000000000000000",	-- x"0F" LHI
					
					"000000000000000",	-- x"10" RFE
					"000000000000000",	-- x"11" TRAP
					"000000000000000",	-- x"12" JR
					"000000000000000",	-- x"13" JALR
					"000000000000000",	-- x"14" SLLI
					"000000000000000",	-- x"15" NOP
					"000000000000000",	-- x"16" SRLI
					"000000000000000",	-- x"17" SRAI
					"000000000000000",	-- x"18" SEQI
					"000000000000000",	-- x"19" SNEI
					"000000000000000",	-- x"1A" SLTI
					"000000000000000",	-- x"1B" SGTI
					"000000000000000",	-- x"1C" SLEI
					"000000000000000",	-- x"1D" SGEI
					"000000000000000",	-- x"1E"
					"000000000000000",	-- x"1F"

					"000000000000000",	-- x"20" LB
					"000000000000000",	-- x"21" LH
					"000000000000000",	-- x"22"
					"000000000000000",	-- x"23" LW
					"000000000000000",	-- x"24" LBU
					"000000000000000",	-- x"25" LHU
					"000000000000000",	-- x"26" LF
					"000000000000000",	-- x"27" LD
					"000000000000000",	-- x"28" SB
					"000000000000000",	-- x"29" SH
					"000000000000000",	-- x"2A"
					"000000000000000",	-- x"2B" SW
					"000000000000000",	-- x"2C"
					"000000000000000",	-- x"2D"
					"000000000000000",	-- x"2E" SF
					"000000000000000",	-- x"2F" SD

					"000000000000000",	-- x"30"
					"000000000000000",	-- x"31"
					"000000000000000",	-- x"32"
					"000000000000000",	-- x"33"
					"000000000000000",	-- x"34"
					"000000000000000",	-- x"35"
					"000000000000000",	-- x"36"
					"000000000000000",	-- x"37"
					"000000000000000",	-- x"38" ITLB
					"000000000000000",	-- x"39"
					"000000000000000",	-- x"3A" SLTUI
					"000000000000000",	-- x"3B" SGTUI
					"000000000000000",	-- x"3C" SLEUI
					"000000000000000",	-- x"3D" SGEUI
					"000000000000000",	-- x"3E"
					"000000000000000");	-- x"3F"

	--signal IR_opcode : std_logic_vector(OP_CODE_SIZE - 1 downto 0);		-- OpCode part of IR
	--signal IR_func   : std_logic_vector(FUNC_SIZE - 1 downto 0);		-- Func part of IR when Rtype

	signal IR_opcode : std_logic_vector(5 downto 0);			-- OpCode part of IR
	signal IR_func   : std_logic_vector(10 downto 0);			-- Func part of IR when Rtype
	--signal cw        : std_logic_vector(CW_SIZE - 1 downto 0);		-- full control word read from cw_mem

	-- control words
	signal cw1 : std_logic_vector(CW_SIZE - 1 downto 0);		-- first stage
	signal cw2 : std_logic_vector(CW_SIZE - 1 - 2 downto 0);	-- second stage
	signal cw3 : std_logic_vector(CW_SIZE - 1 - 5 downto 0);	-- third stage
	signal cw4 : std_logic_vector(CW_SIZE - 1 - 9 downto 0);	-- fourth stage
	signal cw5 : std_logic_vector(CW_SIZE - 1 - 13 downto 0);	-- fifth stage

	signal aluOpcode_i : aluOp := OP_NOP;	-- ALUOP defined in package
	signal aluOpcode1  : aluOp := OP_NOP;
	signal aluOpcode2  : aluOp := OP_NOP;
	signal aluOpcode3  : aluOp := OP_NOP;

--	signal aluOpcode_i : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode1  : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode2  : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode3  : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;

begin

	IR_opcode	<= IR_IN(IR_SIZE - 1 downto IR_SIZE - OP_CODE_SIZE);
	IR_func		<= IR_IN(FUNC_SIZE - 1 downto 0);
	--cw		<= cw_mem(conv_integer(IR_opcode));

	-- stage one control signals
	IR_LATCH_EN	<= cw1(CW_SIZE - 1);
	NPC_LATCH_EN	<= cw1(CW_SIZE - 2);

	-- stage two control signals
	RegA_LATCH_EN	<= cw2(CW_SIZE - 3);
	RegB_LATCH_EN	<= cw2(CW_SIZE - 4);
	RegIMM_LATCH_EN	<= cw2(CW_SIZE - 5);

	-- stage three control signals
	MUXA_SEL	<= cw3(CW_SIZE - 6);
	MUXB_SEL	<= cw3(CW_SIZE - 7);
	ALU_OUTREG_EN	<= cw3(CW_SIZE - 8);
	EQ_COND		<= cw3(CW_SIZE - 9);

	-- stage four control signals
	DRAM_WE		<= cw4(CW_SIZE - 10);
	LMD_LATCH_EN	<= cw4(CW_SIZE - 11);
	JUMP_EN		<= cw4(CW_SIZE - 12);
	PC_LATCH_EN	<= cw4(CW_SIZE - 13);

	-- stage five control signals
	WB_MUX_SEL	<= cw5(CW_SIZE - 14);
	RF_WE		<= cw5(CW_SIZE - 15);


	ALU_OP_CODE_P: process (IR_opcode, IR_func)
	begin
		case IR_opcode is

			-- R-Type instructions
			when RTYPE =>
				case IR_func is
					when RTYPE_SLL		=> aluOpcode_i <= OP_SLL;
					when RTYPE_SRL		=> aluOpcode_i <= OP_SRL;
--					when RTYPE_SRA		=> aluOpcode_i <= OP_SRA;
					when RTYPE_ADD		=> aluOpcode_i <= OP_ADD;
--					when RTYPE_ADDU		=> aluOpcode_i <= OP_ADDU;
					when RTYPE_SUB		=> aluOpcode_i <= OP_SUB;
--					when RTYPE_SUBU		=> aluOpcode_i <= OP_SUBU;
					when RTYPE_AND		=> aluOpcode_i <= OP_AND;
					when RTYPE_OR		=> aluOpcode_i <= OP_OR;
					when RTYPE_XOR		=> aluOpcode_i <= OP_XOR;
--					when RTYPE_SEQ		=> aluOpcode_i <= OP_SEQ;
					when RTYPE_SNE		=> aluOpcode_i <= OP_SNE;
--					when RTYPE_SLT		=> aluOpcode_i <= OP_SLT;
--					when RTYPE_SGT		=> aluOpcode_i <= OP_SGT;
					when RTYPE_SLE		=> aluOpcode_i <= OP_SLE;
					when RTYPE_SGE		=> aluOpcode_i <= OP_SGE;
--					when RTYPE_MOVI2S	=> aluOpcode_i <= OP_MOVI2S;
--					when RTYPE_MOVS2I	=> aluOpcode_i <= OP_MOVS2I;
--					when RTYPE_MOVF	 	=> aluOpcode_i <= OP_MOVF;
--					when RTYPE_MOVD	 	=> aluOpcode_i <= OP_MOVD;
--					when RTYPE_MOVFP2I	=> aluOpcode_i <= OP_MOVFP2I;
--					when RTYPE_MOVI2FP	=> aluOpcode_i <= OP_MOVI2FP;
--					when RTYPE_MOVI2T	=> aluOpcode_i <= OP_MOVI2T;
--					when RTYPE_MOVT2I	=> aluOpcode_i <= OP_MOVT2I;
--					when RTYPE_SLTU		=> aluOpcode_i <= OP_SLTU;
--					when RTYPE_SGTU		=> aluOpcode_i <= OP_SGTU;
--					when RTYPE_SLEU		=> aluOpcode_i <= OP_SLEU;
--					when RTYPE_SGEU		=> aluOpcode_i <= OP_SGEU;
--					when RTYPE_ADDF		=> aluOpcode_i <= OP_ADDF;
--					when RTYPE_SUBF		=> aluOpcode_i <= OP_SUBF;
--					when RTYPE_MULTF	=> aluOpcode_i <= OP_MULTF;
--					when RTYPE_DIVF		=> aluOpcode_i <= OP_DIVF;
--					when RTYPE_ADDD		=> aluOpcode_i <= OP_ADDD;
--					when RTYPE_SUBD		=> aluOpcode_i <= OP_SUBD;
--					when RTYPE_MULTD	=> aluOpcode_i <= OP_MULTD;
--					when RTYPE_DIVD		=> aluOpcode_i <= OP_DIVD;
--					when RTYPE_CVTF2D	=> aluOpcode_i <= OP_CVTF2D;
--					when RTYPE_CVTF2I	=> aluOpcode_i <= OP_CVTF2I;
--					when RTYPE_CVTD2F	=> aluOpcode_i <= OP_CVTD2F;
--					when RTYPE_CVTD2I	=> aluOpcode_i <= OP_CVTD2I;
--					when RTYPE_CVTI2F	=> aluOpcode_i <= OP_CVTI2F;
--					when RTYPE_CVTI2D	=> aluOpcode_i <= OP_CVTI2D;
--					when RTYPE_MULT		=> aluOpcode_i <= OP_MULT;
--					when RTYPE_DIV		=> aluOpcode_i <= OP_DIV;
--					when RTYPE_EQF		=> aluOpcode_i <= OP_EQF;
--					when RTYPE_NEF		=> aluOpcode_i <= OP_NEF;
--					when RTYPE_LTF		=> aluOpcode_i <= OP_LTF;
--					when RTYPE_GTF		=> aluOpcode_i <= OP_GTF;
--					when RTYPE_LEF		=> aluOpcode_i <= OP_LEF;
--					when RTYPE_GEF		=> aluOpcode_i <= OP_GEF;
--					when RTYPE_MULTU	=> aluOpcode_i <= OP_MULTU;
--					when RTYPE_DIVU		=> aluOpcode_i <= OP_DIVU;
--					when RTYPE_EQD		=> aluOpcode_i <= OP_EQD;
--					when RTYPE_NED		=> aluOpcode_i <= OP_NED;
--					when RTYPE_LTD		=> aluOpcode_i <= OP_LTD;
--					when RTYPE_GTD		=> aluOpcode_i <= OP_GTD;
--					when RTYPE_LED		=> aluOpcode_i <= OP_LED;
--					when RTYPE_GED		=> aluOpcode_i <= OP_GED;
					when others		=> aluOpcode_i <= OP_NOP;
				end case;

			-- I-Type instructions
			when ITYPE_BEQZ		=> aluOpcode_i <= OP_BEQZ;
			when ITYPE_BNEZ		=> aluOpcode_i <= OP_BNEZ;
--			when ITYPE_BFPT		=> aluOpcode_i <= OP_BFPT;
--			when ITYPE_BFPF		=> aluOpcode_i <= OP_BFPF;
			when ITYPE_ADDI		=> aluOpcode_i <= OP_ADDI;
--			when ITYPE_ADDUI	=> aluOpcode_i <= OP_ADDUI;
			when ITYPE_SUBI		=> aluOpcode_i <= OP_SUBI;
--			when ITYPE_SUBUI	=> aluOpcode_i <= OP_SUBUI;
			when ITYPE_ANDI		=> aluOpcode_i <= OP_ANDI;
			when ITYPE_ORI		=> aluOpcode_i <= OP_ORI;
			when ITYPE_XORI		=> aluOpcode_i <= OP_XORI;
--			when ITYPE_LHI		=> aluOpcode_i <= OP_LHI;
--			when ITYPE_RFE		=> aluOpcode_i <= OP_RFE;
--			when ITYPE_TRAP		=> aluOpcode_i <= OP_TRAP;
--			when ITYPE_JR		=> aluOpcode_i <= OP_JR;
--			when ITYPE_JALR		=> aluOpcode_i <= OP_JALR;
			when ITYPE_SLLI		=> aluOpcode_i <= OP_SLLI;
			when ITYPE_NOP		=> aluOpcode_i <= OP_NOP;
			when ITYPE_SRLI		=> aluOpcode_i <= OP_SRLI;
--			when ITYPE_SRAI		=> aluOpcode_i <= OP_SRAI;
--			when ITYPE_SEQI		=> aluOpcode_i <= OP_SEQI;
			when ITYPE_SNEI		=> aluOpcode_i <= OP_SNEI;
--			when ITYPE_SLTI		=> aluOpcode_i <= OP_SLTI;
--			when ITYPE_SGTI		=> aluOpcode_i <= OP_SGTI;
			when ITYPE_SLEI		=> aluOpcode_i <= OP_SLEI;
			when ITYPE_SGEI		=> aluOpcode_i <= OP_SGEI;
--			when ITYPE_LB		=> aluOpcode_i <= OP_LB;
--			when ITYPE_LH		=> aluOpcode_i <= OP_LH;
			when ITYPE_LW		=> aluOpcode_i <= OP_LW;
--			when ITYPE_LBU		=> aluOpcode_i <= OP_LBU;
--			when ITYPE_LHU		=> aluOpcode_i <= OP_LHU;
--			when ITYPE_LF		=> aluOpcode_i <= OP_LF;
--			when ITYPE_LD		=> aluOpcode_i <= OP_LD;
--			when ITYPE_SB		=> aluOpcode_i <= OP_SB;
--			when ITYPE_SH		=> aluOpcode_i <= OP_SH;
			when ITYPE_SW		=> aluOpcode_i <= OP_SW;
--			when ITYPE_SF		=> aluOpcode_i <= OP_SF;
--			when ITYPE_SD		=> aluOpcode_i <= OP_SD;
--			when ITYPE_ITLB		=> aluOpcode_i <= OP_ITLB;
--			when ITYPE_SLTUI	=> aluOpcode_i <= OP_SLTUI;
--			when ITYPE_SGTUI	=> aluOpcode_i <= OP_SGTUI;
--			when ITYPE_SLEUI	=> aluOpcode_i <= OP_SLEUI;
--			when ITYPE_SGEUI	=> aluOpcode_i <= OP_SGEUI;

			-- J-Type instructions
			when JTYPE_J		=> aluOpcode_i <= OP_J;
			when JTYPE_JAL		=> aluOpcode_i <= OP_JAL;

			when others		=> aluOpcode_i <= OP_NOP;

		end case;
	end process ALU_OP_CODE_P;

	-- process to pipeline control words
	CW_PIPE: process (Clk, Rst)
	begin
		if Rst = '0' then			-- asynchronous reset (active low)

			cw1 <= (others => '0');
			cw2 <= (others => '0');
			cw3 <= (others => '0');
			cw4 <= (others => '0');
			cw5 <= (others => '0');
			
			aluOpcode1 <= OP_NOP;
			aluOpcode2 <= OP_NOP;
			aluOpcode3 <= OP_NOP;

		elsif Clk'event and Clk = '1' then	-- rising clock edge

			cw1 <= cw_mem(conv_integer(IR_opcode));
			cw2 <= cw1(CW_SIZE - 1 - 2 downto 0);
			cw3 <= cw2(CW_SIZE - 1 - 5 downto 0);
			cw4 <= cw3(CW_SIZE - 1 - 9 downto 0);
			cw5 <= cw4(CW_SIZE - 1 - 13 downto 0);

			aluOpcode1 <= aluOpcode_i;
			aluOpcode2 <= aluOpcode1;
			aluOpcode3 <= aluOpcode2;

		end if;
	end process CW_PIPE;

	ALU_OPCODE <= aluOpcode3;

end DLX_CU_HW;
