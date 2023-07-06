library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

package constants is

	-- Control unit input sizes
	constant OPC_SIZE_GLOBAL		: integer := 6;						-- OPCODE field size
	constant FUNC_SIZE_GLOBAL		: integer := 11;					-- FUNC field size
	constant REG_SIZE_GLOBAL		: integer := 5;						-- RS field size

	-- Control unit registers sizes
	constant IR_SIZE_GLOBAL			: integer := 32;					-- Instruction Register size
	constant PC_SIZE_GLOBAL			: integer := 32;					-- Program Counter size
	constant MMEM_SIZE_GLOBAL		: integer := 64;					-- Microcode Memory size
	--constant RMEM_SIZE_GLOBAL		: integer := 64;					-- Microcode Relocation
	constant CW_SIZE_GLOBAL			: integer := 16;					-- Control Word size

	-- Instruction memory
	constant RAM_SIZE_GLOBAL		: integer := 2**8;					-- Instruction Memory size

	-- Register file
	constant RF_ADDRESSES_GLOBAL		: integer := 5;						-- Exponent address size
	constant RF_SIZE_GLOBAL			: integer := IR_SIZE_GLOBAL;				-- Register size

	-- Instruction cycles
	--constant IN_EXE_CYCLES_GLOBAL		: integer := 5;						-- Instructions Execution cycles

	-- ALU registers sizes
	constant ALU_OP_SIZE_GLOBAL		: integer := 32;					-- ALU operands size
	constant ALU_BLOCK_SIZE_GLOBAL		: integer := 8;						-- ALU blocks size
	constant ALU_BITBLOCK_SIZE_GLOBAL	: integer := ALU_OP_SIZE_GLOBAL/ALU_BLOCK_SIZE_GLOBAL;	-- ALU bits for each block
	constant ALU_OP_MUX_SIZE_GLOBAL		: integer := ALU_BITBLOCK_SIZE_GLOBAL;			-- ALU MUX operands size
	constant ALU_OP_RCA_SIZE_GLOBAL		: integer := ALU_BITBLOCK_SIZE_GLOBAL;			-- ALU RCA operands size
	constant ALU_EXPP4_GLOBAL		: integer := log2(ALU_OP_SIZE_GLOBAL);			-- ALU exponent size

	-- DRAM
	constant DRAM_SIZE_GLOBAL		: integer := 128;					-- DRAM size
	constant DRAM_WORD_SIZE_GLOBAL		: integer := ALU_OP_SIZE_GLOBAL;			-- DRAM registers size

	-- ALU Operations
	type aluOp is (		--NOP, ADDS, LLS, LRS --- to be completed
				--OP_SRA,
				OP_SLL, OP_SRL, OP_ADD, OP_SUB, OP_AND, OP_OR, OP_XOR, OP_SNE, OP_SLE, OP_SGE,
				OP_BEQZ, OP_BNEZ, OP_ADDI, OP_SUBI, OP_ANDI, OP_ORI, OP_XORI, OP_SLLI, OP_NOP, OP_SRLI, OP_SNEI, OP_SLEI, OP_SGEI, OP_LW, OP_SW,
				OP_J, OP_JAL
			);
	-- FUNC labels
	type funcL is (		
				L_RTYPE_SLL,
				L_RTYPE_SRL,
				L_RTYPE_SRA,
				L_RTYPE_ADD,
				L_RTYPE_ADDU,
				L_RTYPE_SUB,
				L_RTYPE_SUBU,
				L_RTYPE_AND,
				L_RTYPE_OR,
				L_RTYPE_XOR,
				L_RTYPE_SEQ,
				L_RTYPE_SNE,
				L_RTYPE_SLT,
				L_RTYPE_SGT,
				L_RTYPE_SLE,
				L_RTYPE_SGE,
				L_RTYPE_MOVI2S,
				L_RTYPE_MOVS2I,
				L_RTYPE_MOVF,
				L_RTYPE_MOVD,
				L_RTYPE_MOVFP2I,
				L_RTYPE_MOVI2FP,
				L_RTYPE_MOVI2T,
				L_RTYPE_MOVT2I,
				L_RTYPE_SLTU,
				L_RTYPE_SGTU,
				L_RTYPE_SLEU,
				L_RTYPE_SGEU,
				L_RTYPE_ADDF,
				L_RTYPE_SUBF,
				L_RTYPE_MULTF,
				L_RTYPE_DIVF,
				L_RTYPE_ADDD,
				L_RTYPE_SUBD,
				L_RTYPE_MULTD,
				L_RTYPE_DIVD,
				L_RTYPE_CVTF2D,
				L_RTYPE_CVTF2I,
				L_RTYPE_CVTD2F,
				L_RTYPE_CVTD2I,
				L_RTYPE_CVTI2F,
				L_RTYPE_CVTI2D,
				L_RTYPE_MULT,
				L_RTYPE_DIV,
				L_RTYPE_EQF,
				L_RTYPE_NEF,
				L_RTYPE_LTF,
				L_RTYPE_GTF,
				L_RTYPE_LEF,
				L_RTYPE_GEF,
				L_RTYPE_MULTU,
				L_RTYPE_DIVU,
				L_RTYPE_EQD,
				L_RTYPE_NED,
				L_RTYPE_LTD,
				L_RTYPE_GTD,
				L_RTYPE_LED,
				L_RTYPE_GED,
				L_RTYPE_NOP

			);

	-- OPCODE labels
	type opcodeL is (	
				L_RTYPE,
				L_ITYPE_BEQZ,
				L_ITYPE_BNEZ,
				L_ITYPE_BFPT,
				L_ITYPE_BFPF,
				L_ITYPE_ADDI,
				L_ITYPE_ADDUI,
				L_ITYPE_SUBI,
				L_ITYPE_SUBUI,
				L_ITYPE_ANDI,
				L_ITYPE_ORI,
				L_ITYPE_XORI,
				L_ITYPE_LHI,
				L_ITYPE_RFE,
				L_ITYPE_TRAP,
				L_ITYPE_JR,
				L_ITYPE_JALR,
				L_ITYPE_SLLI,
				L_ITYPE_NOP,
				L_ITYPE_SRLI,
				L_ITYPE_SRAI,
				L_ITYPE_SEQI,
				L_ITYPE_SNEI,
				L_ITYPE_SLTI,
				L_ITYPE_SGTI,
				L_ITYPE_SLEI,
				L_ITYPE_SGEI,
				L_ITYPE_LB,
				L_ITYPE_LH,
				L_ITYPE_LW,
				L_ITYPE_LBU,
				L_ITYPE_LHU,
				L_ITYPE_LF,
				L_ITYPE_LD,
				L_ITYPE_SB,
				L_ITYPE_SH,
				L_ITYPE_SW,
				L_ITYPE_SF,
				L_ITYPE_SD,
				L_ITYPE_ITLB,
				L_ITYPE_SLTUI,
				L_ITYPE_SGTUI,
				L_ITYPE_SLEUI,
				L_ITYPE_SGEUI,
				L_JTYPE_J,
				L_JTYPE_JAL

			);


-- R-Type register-registe instruction -> FUNC field
	constant RTYPE_SLL	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"04";
	constant RTYPE_SRL	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"06";
--	constant RTYPE_SRA	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"07";
	constant RTYPE_ADD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"20";
--	constant RTYPE_ADDU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"21";
	constant RTYPE_SUB	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"22";
--	constant RTYPE_SUBU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"23";
	constant RTYPE_AND	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"24";
	constant RTYPE_OR	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"25";
	constant RTYPE_XOR	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"26";
--	constant RTYPE_SEQ	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"28";
	constant RTYPE_SNE	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"29";
--	constant RTYPE_SLT	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"2A";
--	constant RTYPE_SGT	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"2B";
	constant RTYPE_SLE	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"2C";
	constant RTYPE_SGE	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"2D";
--	constant RTYPE_MOVI2S	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"30";
--	constant RTYPE_MOVS2I	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"31";
--	constant RTYPE_MOVF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"32";
--	constant RTYPE_MOVD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"33";
--	constant RTYPE_MOVFP2I	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"34";
--	constant RTYPE_MOVI2FP	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"35";
--	constant RTYPE_MOVI2T	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"36";
--	constant RTYPE_MOVT2I	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"37";
--	constant RTYPE_SLTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3A";
--	constant RTYPE_SGTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3B";
--	constant RTYPE_SLEU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3C";
--	constant RTYPE_SGEU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3D";

-- R-Type floating-point instruction -> FUNC field
--	constant RTYPE_ADDF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"00";
--	constant RTYPE_SUBF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"01";
--	constant RTYPE_MULTF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"02";
--	constant RTYPE_DIVF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"03";
--	constant RTYPE_ADDD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"04";
--	constant RTYPE_SUBD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"05";
--	constant RTYPE_MULTD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"06";
--	constant RTYPE_DIVD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"07";
--	constant RTYPE_CVTF2D	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"08";
--	constant RTYPE_CVTF2I	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"09";
--	constant RTYPE_CVTD2F	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0A";
--	constant RTYPE_CVTD2I	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0B";
--	constant RTYPE_CVTI2F	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0C";
--	constant RTYPE_CVTI2D	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0D";
--	constant RTYPE_MULT	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0E";
--	constant RTYPE_DIV	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0F";
--	constant RTYPE_EQF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"10";
--	constant RTYPE_NEF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"11";
--	constant RTYPE_LTF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"12";
--	constant RTYPE_GTF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"13";
--	constant RTYPE_LEF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"14";
--	constant RTYPE_GEF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"15";
--	constant RTYPE_MULTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"16";
--	constant RTYPE_DIVU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"17";
--	constant RTYPE_EQD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"18";
--	constant RTYPE_NED	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"19";
--	constant RTYPE_LTD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"1A";
--	constant RTYPE_GTD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"1B";
--	constant RTYPE_LED	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"1C";
--	constant RTYPE_GED	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"1D";

-- R-Type instruction -> OPCODE field
	constant RTYPE		: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"0";

-- I-Type instruction -> OPCODE field
	constant ITYPE_BEQZ	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"4";
	constant ITYPE_BNEZ	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"5";
--	constant ITYPE_BFPT	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"6";
--	constant ITYPE_BFPF	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"7";
	constant ITYPE_ADDI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"8";
--	constant ITYPE_ADDUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"9";
	constant ITYPE_SUBI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"A";
--	constant ITYPE_SUBUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"B";
	constant ITYPE_ANDI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"C";
	constant ITYPE_ORI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"D";
	constant ITYPE_XORI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"E";
--	constant ITYPE_LHI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"F";
--	constant ITYPE_RFE	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"0";
--	constant ITYPE_TRAP	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"1";
--	constant ITYPE_JR	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"2";
--	constant ITYPE_JALR	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"3";
	constant ITYPE_SLLI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"4";
	constant ITYPE_NOP	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"5";
	constant ITYPE_SRLI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"6";
--	constant ITYPE_SRAI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"7";
--	constant ITYPE_SEQI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"8";
	constant ITYPE_SNEI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"9";
--	constant ITYPE_SLTI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"A";
--	constant ITYPE_SGTI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"B";
	constant ITYPE_SLEI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"C";
	constant ITYPE_SGEI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"D";
--	constant ITYPE_LB	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"0";
--	constant ITYPE_LH	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"1";
	constant ITYPE_LW	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"3";
--	constant ITYPE_LBU	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"4";
--	constant ITYPE_LHU	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"5";
--	constant ITYPE_LF	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"6";
--	constant ITYPE_LD	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"7";
--	constant ITYPE_SB	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"8";
--	constant ITYPE_SH	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"9";
	constant ITYPE_SW	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"B";
--	constant ITYPE_SF	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"E";
--	constant ITYPE_SD	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "10" & x"F";
--	constant ITYPE_ITLB	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"8";
--	constant ITYPE_SLTUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"A";
--	constant ITYPE_SGTUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"B";
--	constant ITYPE_SLEUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"C";
--	constant ITYPE_SGEUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"D";

-- J-Type instruction -> OPCODE field
	constant JTYPE_J	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"2";
	constant JTYPE_JAL	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"3";

end constants;
