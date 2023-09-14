----------------------------------------------------------------------------------------------------
-- Description:	This ALU (Arithmetic Logic Unit) module is designed to execute various arithmetic, 
--		logical and shifting operations. This ALU makes use of a P4 Adder for addition
--		and subtraction operations.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/14
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity ALU is

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL;				-- / 32 bits
			NB:	integer := ALU_BLOCK_SIZE_GLOBAL);			-- /  8 bits

	port (		OP1:	in	std_logic_vector(N - 1 downto 0);		-- Operand 1		/ 32 bits
			OP2:	in	std_logic_vector(N - 1 downto 0);		-- Operand 2		/ 32 bits
			OPC:	in	aluOp;						-- Control Signal
			Y:	out	std_logic_vector(N - 1 downto 0);		-- Result		/ 32 bits
			Z:	out	std_logic);					-- Zero flag
			--Co:	out	std_logic);
			--Ovf:	out	std_logic);
end ALU;


architecture BEHAVIORAL of ALU is

	component P4_ADDER is

		generic (	N:	integer := ALU_OP_SIZE_GLOBAL;			-- / 32 bits
				NB:	integer := ALU_BLOCK_SIZE_GLOBAL);		-- /  8 bits

		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bits
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bits
				Ci:	in	std_logic;				-- Carry in
				S:	out	std_logic_vector(N - 1 downto 0);	-- Result		/ 32 bits
				Co:	out	std_logic);				-- Carry out
				--Ovf:	out	std_logic);
	end component;

	component COMPARATOR is

		generic (	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bits
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bits
				S:	in	std_logic_vector(3 downto 0);		-- Selector		/  4 bits
				Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bits

	end component;

	component LOGIC is

		generic (	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bits
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bits
				S:	in	std_logic_vector(1 downto 0);		-- Selector		/  2 bits
				Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bits

	end component;

	component BARREL_SHIFTER_LEFT is

		generic (	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand		/ 32 bits
				B:	in	std_logic_vector(N - 1 downto 0);	-- Number of Shifts	/ 32 bits
				Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bits

	end component;

	component BARREL_SHIFTER_RIGHT is

		generic (	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand		/ 32 bits
				B:	in	std_logic_vector(N - 1 downto 0);	-- Number of Shifts	/ 32 bits
				S:	in	std_logic;				-- Shif Type		/  2 bits
				Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bits

	end component;

	component ZERO_DETECTOR is

		generic	(	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

		port	(	A:	in	std_logic_vector(N - 1 downto 0);	-- Operand		/ 32 bits
				Y:	out	std_logic);				-- Result

	end component;

	component BOOTH_MULTIPLIER is
	
		generic (	N:	integer := ALU_OP_SIZE_GLOBAL);			-- / 32 bits
	
		port	(	A:	in	std_logic_vector(N/2 - 1 downto 0);
				B:	in	std_logic_vector(N/2 - 1 downto 0);
				P:	out	std_logic_vector(N - 1 downto 0));
	
	end component;

--	component fpAdderTOP is
--		Port
--		(
--			A	:   in  std_logic_vector(31 downto 0);
--			B	:   in  std_logic_vector(31 downto 0);
--			AddSub	:   in  std_logic;                      --0 add, 1 sub
--			Y	:   out std_logic_vector(31 downto 0)
--		);
--	end component;

--	component fpMultiplier is
--		Port
--		(
--			A : in  std_logic_vector(31 downto 0);	-- 2nd operand
--			B : in  std_logic_vector(31 downto 0);	-- 1st operand
--			Y : out std_logic_vector(31 downto 0)	-- result
--		);
--	end component;

	signal OP_A, OP_B : std_logic_vector(N - 1 downto 0);
	signal Y_TMP : std_logic_vector(N - 1 downto 0);
	signal Z_TMP : std_logic;

	signal Y_SUM, Y_MUL, Y_LOGIC, Y_SHIFTR, Y_SHIFTL, Y_COMPARE : std_logic_vector(N - 1 downto 0);
	signal Z_DET : std_logic;

	signal OP_COMPARE : std_logic_vector(3 downto 0);
	signal OP_LOGIC : std_logic_vector(1 downto 0);
	signal OP_SHIFT : std_logic;
	signal OP_Ci : std_logic;

	begin

		----------------------------------------------------------------------------------------------------
		-- Processes
		----------------------------------------------------------------------------------------------------

		Y_COMPUTATION: process(OP1, OP2, OPC, Y_SUM, Y_MUL, Y_LOGIC, Y_SHIFTR, Y_SHIFTL, Y_COMPARE)
		begin
			case OPC is

				-- Shifts

--				when OP_SLL =>		-- unsigned, R[regc] <-- R[rega] << R[regb]_27..31
--				when OP_SLLI =>		-- unsigned, R[regb] <-- R[rega] << uimm16_27..31
				when OP_SLL | OP_SLLI =>
--					Y_TMP <= std_logic_vector(shift_left(unsigned(OP1),to_integer(unsigned(OP2))));
					OP_A <= OP1;
					OP_B <= OP2;
					Y_TMP <= Y_SHIFTL;

--				when OP_SRL =>		-- unsigned, R[regc] <-- R[rega] >> R[regb]_27..31
--				when OP_SRLI =>		-- unsigned, R[regb] <-- R[rega] >> uimm16_27..31
				when OP_SRL | OP_SRLI =>
--					Y_TMP <= std_logic_vector(shift_right(unsigned(OP1),to_integer(unsigned(OP2))));
					OP_A <= OP1;
					OP_B <= OP2;
					OP_SHIFT <= '0';
					Y_TMP <= Y_SHIFTR;

--				when OP_SRA =>		-- signed, R[regc] <-- (R[rega]_0)^R[regb] ## (R[rega] >> R[regb])_R[regb]..31
--				when OP_SRAI =>		-- signed, R[regb] <-- (R[rega]_31)^uimm16 ## (R[rega] >> uimm16)_uimm16..31
				when OP_SRA | OP_SRAI =>
--					Y_TMP <= std_logic_vector(shift_right(signed(OP1),to_integer(unsigned(OP2))));
					OP_A <= OP1;
					OP_B <= OP2;
					OP_SHIFT <= '1';
					Y_TMP <= Y_SHIFTR;

				-- Arithmetic Operations

--				when OP_ADD =>		-- signed, R[regc] <-- R[rega] + R[regb]
--				when OP_ADDI =>		-- signed, R[regb] <-- R[rega] + imm16
				when OP_ADD | OP_ADDI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_Ci <= '0';
					Y_TMP <= Y_SUM;

--				when OP_ADDU =>		-- unsigned, R[regc] <-- R[rega] + R[regb]
--				when OP_ADDUI =>	-- unsigned, R[regb] <-- R[rega] + uimm16
				when OP_ADDU | OP_ADDUI =>
--					Y_TMP <= std_logic_vector(unsigned(OP1) + unsigned(OP2));
					OP_A <= OP1;
					OP_B <= OP2;
					OP_Ci <= '0';
					Y_TMP <= Y_SUM;

--				when OP_SUB =>	-- signed, R[regc] <-- R[rega] - R[regb]
--				when OP_SUBI =>	-- signed, R[regb] <-- R[rega] - imm16
				when OP_SUB | OP_SUBI =>
					OP_A <= OP1;
					OP_B <= NOT OP2;
					OP_Ci <= '1';
					Y_TMP <= Y_SUM;

--				when OP_SUBU =>		-- unsigned, R[regc] <-- R[rega] - R[regb]
--				when OP_SUBUI =>	-- unsigned, R[regb] <-- R[rega] - uimm16
				when OP_SUBU | OP_SUBUI =>
--					Y_TMP <= std_logic_vector(unsigned(OP1) - unsigned(OP2));
					OP_A <= OP1;
					OP_B <= NOT OP2;
					OP_Ci <= '1';
					Y_TMP <= Y_SUM;					

--				when OP_MULT =>		-- signed, R[regc] <-- R[rega] * R[regb]
--				when OP_MULTU =>	-- unsigned, R[regc] <-- R[rega] * R[regb]
				when OP_MULT | OP_MULTU =>
					OP_A <= OP1;
					OP_B <= OP2;
					Y_TMP <= Y_MUL;

				-- Logic Operations

--				when OP_AND =>		-- unsigned bitwise basis, R[regc] <-- R[rega] & R[regb]
--				when OP_ANDI =>		-- unsigned bitwise basis, R[regb] <-- R[rega] & uimm16
				when OP_AND | OP_ANDI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_LOGIC <= "00";
					Y_TMP <= Y_LOGIC;

--				when OP_OR =>		-- unsigned bitwise basis, R[regc] <-- R[rega] | R[regb]
--				when OP_ORI =>		-- unsigned bitwise basis, R[regb] <-- R[rega] | uimm16
				when OP_OR | OP_ORI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_LOGIC <= "01";
					Y_TMP <= Y_LOGIC;

--				when OP_XOR =>		-- unsigned bitwise basis, R[regc] <-- R[rega] XOR R[regb]
--				when OP_XORI =>		-- unsigned bitwise basis, R[regb] <-- R[rega] XOR uimm16
				when OP_XOR | OP_XORI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_LOGIC <= "10";
					Y_TMP <= Y_LOGIC;

				-- Comparison Operations

--				when OP_SEQ =>		-- signed, if (R[rega] == R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SEQI =>		-- signed, if (R[rega] == imm16 ) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SEQ | OP_SEQI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0000";
					Y_TMP <= Y_COMPARE;

--				when OP_SNE =>		-- signed, if (R[rega] != R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SNEI =>		-- signed, if (R[rega] != imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SNE | OP_SNEI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0001";
					Y_TMP <= Y_COMPARE;

--				when OP_SLT =>		-- signed, if (R[rega] < R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SLTI =>		-- signed, if (R[rega] < imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SLT | OP_SLTI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0010";
					Y_TMP <= Y_COMPARE;

--				when OP_SLTU =>		-- unsigned, if (R[rega] < R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SLTUI =>	-- unsigned, if (R[rega] < uimm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SLTU | OP_SLTUI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0011";
					Y_TMP <= Y_COMPARE;

--				when OP_SGT =>		-- signed, if (R[rega] > R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SGTI =>		-- signed, if (R[rega] > imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SGT | OP_SGTI =>	
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0100";
					Y_TMP <= Y_COMPARE;

--				when OP_SGTU =>		-- unsigned, if (R[rega] > R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SGTUI =>	-- unsigned, if (R[rega] > uimm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SGTU | OP_SGTUI =>	
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0101";
					Y_TMP <= Y_COMPARE;

--				when OP_SLE =>		-- signed, if (R[rega] <= R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SLEI =>		-- signed, if (R[rega] <= imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SLE | OP_SLEI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0110";
					Y_TMP <= Y_COMPARE;

--				when OP_SLEU =>		-- unsigned, if (R[rega] <= R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SLEUI =>	-- unsigned, if (R[rega] <= uimm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SLEU | OP_SLEUI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "0111";
					Y_TMP <= Y_COMPARE;

--				when OP_SGE =>		-- signed, if (R[rega] >= R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SGEI =>		-- signed, if (R[rega] >= imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SGE | OP_SGEI =>	
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "1000";
					Y_TMP <= Y_COMPARE;

--				when OP_SGEU =>		-- unsigned, if (R[rega] >= R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SGEUI =>	-- unsigned, if (R[rega] >= uimm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SGEU | OP_SGEUI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_COMPARE <= "1001";
					Y_TMP <= Y_COMPARE;

				-- Loads

--				when OP_LW =>		-- R[regb] <-- M[imm16 + R[rega]]
--				when OP_SW =>		-- M[imm16 + R[rega]] <-- R[regb]
				when OP_LW | OP_SW =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_Ci <= '0';
					Y_TMP <= Y_SUM;

--				when OP_LHI =>		-- R[regb] <-- imm16 ## 0^16
				when OP_LHI =>
					Y_TMP <= OP2;

				-- Jumps

--				when OP_J =>		-- PC <-- PC + imm26
--				when OP_JAL =>		-- R31 <-- PC + 4; PC <-- PC + imm26
				when OP_J | OP_JAL =>
					--Y_TMP <= std_logic_vector(to_unsigned(4, Y_TMP'length));
					OP_A <= OP1;
					OP_B <= OP2;
					OP_Ci <= '0';
					Y_TMP <= Y_SUM;

--				when OP_JR =>		-- PC <-- R[rega]
--				when OP_JALR =>		-- R31 <-- PC + 4; PC <-- R[rega]
				when OP_JR | OP_JALR =>
					Y_TMP <= OP1;

				-- Branches

--				when OP_BEQZ =>		-- if (R[rega] == 0) PC <-- PC + imm16
--				when OP_BNEZ =>		-- if (R[rega] != 0) PC <-- PC + imm16
				when OP_BEQZ | OP_BNEZ =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_Ci <= '0';
					Y_TMP <= Y_SUM;

				-- No Operations

--				when OP_NOP =>		-- idles one cycle
				when OP_NOP =>
					Y_TMP <= std_logic_vector(to_unsigned(0, Y_TMP'length));

				when others =>
					Y_TMP <= std_logic_vector(to_unsigned(0, Y_TMP'length));

			end case;
		end process;

		Z_COMPUTATION: process(Z_DET)
		begin

			Z_TMP <= Z_DET;

		end process;


--		BRANCHES: process (OPC, Y_TMP)
--		begin
--			if (Y_TMP = std_logic_vector(to_unsigned(0, Y_TMP'length)) and OPC = OP_BEQZ) then
--				Z <= '1';
--			elsif (Y_TMP /= std_logic_vector(to_unsigned(0, Y_TMP'length)) and OPC = OP_BNEZ) then
--				Z <= '1';
--			else
--				Z <= '0';
--			end if;
--		end process;

		Y <= Y_TMP;
		Z <= Z_TMP;

		----------------------------------------------------------------------------------------------------
		-- Components Mapping
		----------------------------------------------------------------------------------------------------

		SUM: P4_ADDER
		generic map (N, NB)
		port map (OP_A, OP_B, OP_Ci, Y_SUM, open);

		MUL: BOOTH_MULTIPLIER
		generic map (N)
		port map (OP_A(N/2 - 1 downto 0), OP_B(N/2 - 1 downto 0), Y_MUL);

		BSL: BARREL_SHIFTER_LEFT
		generic map (N)
		port map (OP_A, OP_B, Y_SHIFTL);

		BSR: BARREL_SHIFTER_RIGHT
		generic map (N)
		port map (OP_A, OP_B, OP_SHIFT, Y_SHIFTR);

		LOG: LOGIC
		generic map (N)
		port map (OP_A, OP_B, OP_LOGIC, Y_LOGIC);

		CMP: COMPARATOR
		generic map (N)
		port map (OP_A, OP_B, OP_COMPARE, Y_COMPARE);

		ZDET: ZERO_DETECTOR
		generic map (N)
		port map (Y_TMP, Z_DET);

end BEHAVIORAL;

configuration CFG_ALU_ARCHITECTURE of ALU is
	for BEHAVIORAL
	end for;
end CFG_ALU_ARCHITECTURE;
