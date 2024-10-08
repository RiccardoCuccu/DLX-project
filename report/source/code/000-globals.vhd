-------------------------------------------------------------------------------------------------
-- Description:	This package sets up constants and types for universal use across the DLX project.
--		It contains defaults for sizes, ALU operations, instruction types, and so on,
--		functioning as a centralized control point for various parameters to simplify
--		system configuration and maintenance.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/19
-------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

package constants is

	constant SIZE_GLOBAL			: integer := 32;

	-- Control unit input sizes
	constant OPC_SIZE_GLOBAL		: integer := 6;	
	constant FUNC_SIZE_GLOBAL		: integer := 11;
	constant RS_SIZE_GLOBAL			: integer := 5;	

	-- Control unit registers sizes
	constant IR_SIZE_GLOBAL			: integer := SIZE_GLOBAL;
	constant PC_SIZE_GLOBAL			: integer := SIZE_GLOBAL;
	constant MMEM_SIZE_GLOBAL		: integer := 64;
	--constant RMEM_SIZE_GLOBAL		: integer := 64;
	constant CW_SIZE_GLOBAL			: integer := 18;

	-- Instruction memory
	constant IRAM_SIZE_GLOBAL		: integer := 2**8;

	-- Register file
--	constant RF_ADDRESSES_GLOBAL		: integer := 5;	
	constant RF_SIZE_GLOBAL			: integer := IR_SIZE_GLOBAL;

	-- ALU registers sizes
	constant ALU_OP_SIZE_GLOBAL		: integer := SIZE_GLOBAL;
	constant ALU_BLOCK_SIZE_GLOBAL		: integer := 8;	
	constant ALU_BITBLOCK_SIZE_GLOBAL	: integer := ALU_OP_SIZE_GLOBAL/ALU_BLOCK_SIZE_GLOBAL;
	constant ALU_OP_MUX_SIZE_GLOBAL		: integer := ALU_BITBLOCK_SIZE_GLOBAL;
	constant ALU_OP_RCA_SIZE_GLOBAL		: integer := ALU_BITBLOCK_SIZE_GLOBAL;
	constant ALU_EXPP4_GLOBAL		: integer := log2(ALU_OP_SIZE_GLOBAL);
	constant ALU_MUL_RADIX_GLOBAL		: integer := 8;	
	constant ALU_MUL_ENCODER_GLOBAL		: integer := ALU_OP_SIZE_GLOBAL/2;

	-- DRAM
	constant DRAM_SIZE_GLOBAL		: integer := 2**8;
	constant DRAM_WORD_SIZE_GLOBAL		: integer := SIZE_GLOBAL;

	-- ALU Operations
	type aluOp is (		-- FUNC labels
				OP_SLL, OP_SRL, OP_SRA, OP_ADD, OP_ADDU, OP_SUB, OP_SUBU, OP_AND, OP_OR, OP_XOR, OP_SEQ, OP_SNE, OP_SLT, OP_SGT, OP_SLE, OP_SGE, OP_MOVI2S, OP_MOVS2I, OP_MOVF, OP_MOVD, OP_MOVFP2I, OP_MOVI2FP, OP_MOVI2T, OP_MOVT2I, OP_SLTU, OP_SGTU, OP_SLEU, OP_SGEU,
				OP_ADDF, OP_SUBF, OP_MULTF, OP_DIVF, OP_ADDD, OP_SUBD, OP_MULTD, OP_DIVD, OP_CVTF2D, OP_CVTF2I, OP_CVTD2F, OP_CVTD2I, OP_CVTI2F, OP_CVTI2D, OP_MULT, OP_DIV, OP_EQF, OP_NEF, OP_LTF, OP_GTF, OP_LEF, OP_GEF, OP_MULTU, OP_DIVU, OP_EQD, OP_NED, OP_LTD, OP_GTD, OP_LED, OP_GED,

				-- OPCODE labels
				OP_BEQZ, OP_BNEZ, OP_BFPT, OP_BFPF, OP_ADDI, OP_ADDUI, OP_SUBI, OP_SUBUI, OP_ANDI, OP_ORI, OP_XORI, OP_LHI, OP_RFE, OP_TRAP, OP_JR, OP_JALR, OP_SLLI, OP_SRLI, OP_SRAI, OP_SEQI, OP_SNEI, OP_SLTI, OP_SGTI, OP_SLEI, OP_SGEI, OP_LB, OP_LH, OP_LW, OP_LBU, OP_LHU, OP_LF, OP_LD, OP_SB, OP_SH, OP_SW, OP_SF, OP_SD, OP_ITLB, OP_SLTUI, OP_SGTUI, OP_SLEUI, OP_SGEUI,
				OP_J, OP_JAL,
				OP_NOP

			);

	-- FUNC labels
	type ALU_label is (	-- FUNC labels
				L_RTYPE_SLL, L_RTYPE_SRL, L_RTYPE_SRA, L_RTYPE_ADD, L_RTYPE_ADDU, L_RTYPE_SUB, L_RTYPE_SUBU, L_RTYPE_AND, L_RTYPE_OR, L_RTYPE_XOR, L_RTYPE_SEQ, L_RTYPE_SNE, L_RTYPE_SLT, L_RTYPE_SGT, L_RTYPE_SLE, L_RTYPE_SGE, L_RTYPE_MOVI2S, L_RTYPE_MOVS2I, L_RTYPE_MOVF, L_RTYPE_MOVD, L_RTYPE_MOVFP2I, L_RTYPE_MOVI2FP, L_RTYPE_MOVI2T, L_RTYPE_MOVT2I, L_RTYPE_SLTU, L_RTYPE_SGTU, L_RTYPE_SLEU, L_RTYPE_SGEU,
				L_RTYPE_ADDF, L_RTYPE_SUBF, L_RTYPE_MULTF, L_RTYPE_DIVF, L_RTYPE_ADDD, L_RTYPE_SUBD, L_RTYPE_MULTD, L_RTYPE_DIVD, L_RTYPE_CVTF2D, L_RTYPE_CVTF2I, L_RTYPE_CVTD2F, L_RTYPE_CVTD2I, L_RTYPE_CVTI2F, L_RTYPE_CVTI2D, L_RTYPE_MULT, L_RTYPE_DIV, L_RTYPE_EQF, L_RTYPE_NEF, L_RTYPE_LTF, L_RTYPE_GTF, L_RTYPE_LEF, L_RTYPE_GEF, L_RTYPE_MULTU, L_RTYPE_DIVU, L_RTYPE_EQD, L_RTYPE_NED, L_RTYPE_LTD, L_RTYPE_GTD, L_RTYPE_LED, L_RTYPE_GED,
				L_RTYPE_NOP,

				-- OPCODE labels
				L_RTYPE, L_ITYPE, L_JTYPE,
				L_ITYPE_BEQZ, L_ITYPE_BNEZ, L_ITYPE_BFPT, L_ITYPE_BFPF, L_ITYPE_ADDI, L_ITYPE_ADDUI, L_ITYPE_SUBI, L_ITYPE_SUBUI, L_ITYPE_ANDI, L_ITYPE_ORI, L_ITYPE_XORI, L_ITYPE_LHI, L_ITYPE_RFE, L_ITYPE_TRAP, L_ITYPE_JR, L_ITYPE_JALR, L_ITYPE_SLLI, L_ITYPE_NOP, L_ITYPE_SRLI, L_ITYPE_SRAI, L_ITYPE_SEQI, L_ITYPE_SNEI, L_ITYPE_SLTI, L_ITYPE_SGTI, L_ITYPE_SLEI, L_ITYPE_SGEI, L_ITYPE_LB, L_ITYPE_LH, L_ITYPE_LW, L_ITYPE_LBU, L_ITYPE_LHU, L_ITYPE_LF, L_ITYPE_LD, L_ITYPE_SB, L_ITYPE_SH, L_ITYPE_SW, L_ITYPE_SF, L_ITYPE_SD, L_ITYPE_ITLB, L_ITYPE_SLTUI, L_ITYPE_SGTUI, L_ITYPE_SLEUI, L_ITYPE_SGEUI,
				L_JTYPE_J, L_JTYPE_JAL,
				L_NOP

			);


-- R-Type register-registe instruction -> FUNC field
	constant RTYPE_SLL	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"04";
	constant RTYPE_SRL	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"06";
	constant RTYPE_SRA	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"07";
	constant RTYPE_ADD	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"20";
	constant RTYPE_ADDU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"21";
	constant RTYPE_SUB	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"22";
	constant RTYPE_SUBU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"23";
	constant RTYPE_AND	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"24";
	constant RTYPE_OR	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"25";
	constant RTYPE_XOR	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"26";
	constant RTYPE_SEQ	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"28";
	constant RTYPE_SNE	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"29";
	constant RTYPE_SLT	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"2A";
	constant RTYPE_SGT	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"2B";
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
	constant RTYPE_SLTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3A";
	constant RTYPE_SGTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3B";
	constant RTYPE_SLEU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3C";
	constant RTYPE_SGEU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"3D";

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
	constant RTYPE_MULT	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"1E";
--	constant RTYPE_DIV	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"0F";
--	constant RTYPE_EQF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"10";
--	constant RTYPE_NEF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"11";
--	constant RTYPE_LTF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"12";
--	constant RTYPE_GTF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"13";
--	constant RTYPE_LEF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"14";
--	constant RTYPE_GEF	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"15";
--	constant RTYPE_MULTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"16";
	constant RTYPE_MULTU	: std_logic_vector(FUNC_SIZE_GLOBAL - 1 downto 0) := "000" & x"1F";
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
	constant ITYPE_ADDUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"9";
	constant ITYPE_SUBI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"A";
	constant ITYPE_SUBUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"B";
	constant ITYPE_ANDI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"C";
	constant ITYPE_ORI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"D";
	constant ITYPE_XORI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"E";
	constant ITYPE_LHI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"F";
--	constant ITYPE_RFE	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"0";
--	constant ITYPE_TRAP	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"1";
	constant ITYPE_JR	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"2";
	constant ITYPE_JALR	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"3";
	constant ITYPE_SLLI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"4";
	constant ITYPE_NOP	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"5";
	constant ITYPE_SRLI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"6";
	constant ITYPE_SRAI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"7";
	constant ITYPE_SEQI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"8";
	constant ITYPE_SNEI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"9";
	constant ITYPE_SLTI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"A";
	constant ITYPE_SGTI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "01" & x"B";
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
	constant ITYPE_SLTUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"A";
	constant ITYPE_SGTUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"B";
	constant ITYPE_SLEUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"C";
	constant ITYPE_SGEUI	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "11" & x"D";

-- J-Type instruction -> OPCODE field
	constant JTYPE_J	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"2";
	constant JTYPE_JAL	: std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0) := "00" & x"3";

end constants;
