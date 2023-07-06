library ieee; 
use ieee.std_logic_1164.all; 
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
use work.constants.all;

entity ALU is

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL;
			NB:	integer := ALU_BLOCK_SIZE_GLOBAL);

	port (		OP1:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1
			OP2:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2
			OPC:	in	aluOp;					-- Control Signal
			Y:	out	std_logic_vector(N - 1 downto 0);	-- Result
			Z:	out	std_logic);				-- Zero flag		
			--Co:	out	std_logic);
			--Ovf:	out	std_logic);
end ALU;


architecture BEHAVIORAL of ALU is

	component P4_ADDER is

		generic (	N:	integer := ALU_OP_SIZE_GLOBAL;
				NB:	integer := ALU_BLOCK_SIZE_GLOBAL);

		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2
				Ci:	in	std_logic;				-- Carry in
				S:	out	std_logic_vector(N - 1 downto 0);	-- Result
				Co:	out	std_logic);				-- Carry out
				--Ovf:	out	std_logic);
	end component;

--	component COMPARATOR is
--
--		generic (	N: integer := ALU_OP_SIZE_GLOBAL);
--	
--		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1
--				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2
--				S:	out	std_logic);				-- Result
--
--	end component;

	component LOGIC is

		generic (	N:	integer := ALU_OP_SIZE_GLOBAL);
	
		port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2
				OP:	in	std_logic_vector(1 downto 0);		-- Operation
				S:	out	std_logic_vector(N - 1 downto 0));	-- Result

	end component;

--	component BOOTHMUL is
--		generic (
--			NBIT :		integer := 32);
--		port (
--			A :		in	std_logic_vector(NBIT/2 -1 downto 0);
--			B :		in	std_logic_vector(NBIT/2 -1 downto 0);
--			C :	    out	std_logic_vector(NBIT-1 downto 0));
--	end component;

	--component SHIFTER is
		--generic (
			--I_SIZE : integer := 32);
		--port (
			--Control: in std_logic_vector(1 downto 0);
			--Operand_1 : in  std_logic_vector(I_SIZE - 1 downto 0);
			--Operand_2 : in  std_logic_vector(I_SIZE - 1 downto 0);
			--Dout : out std_logic_vector(I_SIZE - 1 downto 0)
			--);		
	--end component;

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

	signal Y_TMP, OP_A, OP_B, OP_S : std_logic_vector(N - 1 downto 0);
--	signal OP_LOGIC : std_logic_vector(1 downto 0);
	signal OP_Ci : std_logic;
--	signal OP_CMP : std_logic;

	begin

		------------------------------------------------------------------------------------------------------------------------
		-- Processes
		------------------------------------------------------------------------------------------------------------------------

		COMPUTATION: process(OP1, OP2, OPC)
		begin
			case(OPC) is

				-- Shift

--				when OP_SLL =>	-- unsigned, R[regc] <-- R[rega] << R[regb]_27..31
--				when OP_SLLI =>	-- unsigned, R[regb] <-- R[rega] << uimm16_27..31
				when OP_SLL | OP_SLLI =>
					Y_TMP <= std_logic_vector(shift_left(unsigned(OP1),to_integer(unsigned(OP2))));

--				when OP_SRL =>	-- unsigned, R[regc] <-- R[rega] >> R[regb]_27..31
--				when OP_SRLI =>	-- unsigned, R[regb] <-- R[rega] >> uimm16_27..31
				when OP_SRL | OP_SRLI =>
					Y_TMP <= std_logic_vector(shift_right(unsigned(OP1),to_integer(unsigned(OP2))));

-- PRO --
----				when OP_SRA =>	-- signed, R[regc] <-- (R[rega]_0)^R[regb] ## (R[rega] >> R[regb])_R[regb]..31
----				when OP_SRAI =>	-- signed, R[regb] <-- (R[rega]_31)^uimm16 ## (R[rega] >> uimm16)_uimm16..31
--				when OP_SRA | OP_SRAI =>
--					Y_TMP <= std_logic_vector(shift_right(signed(OP1),to_integer(unsigned(OP2))));

				-- Arithmetic Operations

--				when OP_ADD =>	-- signed, R[regc] <-- R[rega] + R[regb]
--				when OP_ADDI =>	-- signed, R[regb] <-- R[rega] + imm16
				when OP_ADD | OP_ADDI =>
					OP_A <= OP1;
					OP_B <= OP2;
					OP_Ci <= '0';
					Y_TMP <= OP_S;

--				when OP_SUB =>	-- signed, R[regc] <-- R[rega] - R[regb]
--				when OP_SUBI =>	-- signed, R[regb] <-- R[rega] - imm16
				when OP_SUB | OP_SUBI =>
					OP_A <= OP1;
					OP_B <= NOT OP2;
					OP_Ci <= '1';
					Y_TMP <= OP_S;

				-- Logic Operations

--				when OP_AND =>	-- unsigned bitwise basis, R[regc] <-- R[rega] & R[regb]
--				when OP_ANDI =>	-- unsigned bitwise basis, R[regb] <-- R[rega] & uimm16
				when OP_AND | OP_ANDI =>
					Y_TMP <= OP1 and OP2;

--				when OP_OR =>	-- unsigned bitwise basis, R[regc] <-- R[rega] | R[regb]
--				when OP_ORI =>	-- unsigned bitwise basis, R[regb] <-- R[rega] | uimm16
				when OP_OR | OP_ORI =>
					Y_TMP <= OP1 or OP2;

--				when OP_XOR =>	-- unsigned bitwise basis, R[regc] <-- R[rega] XOR R[regb]
--				when OP_XORI =>	-- unsigned bitwise basis, R[regb] <-- R[rega] XOR uimm16
				when OP_XOR | OP_XORI =>
					Y_TMP <= OP1 xor OP2;

				-- Comparison Operations

--				when OP_SNE =>	-- signed, if (R[rega] != R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SNEI =>	-- signed, if (R[rega] != imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SNE | OP_SNEI =>
					if (OP1 /= OP2) then
						Y_TMP <= std_logic_vector(to_unsigned(1, Y_TMP'length));
					else
						Y_TMP <= std_logic_vector(to_unsigned(0, Y_TMP'length));
					end if;

--				when OP_SLE =>	-- signed, if (R[rega] <= R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SLEI =>	-- signed, if (R[rega] <= imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SLE | OP_SLEI =>
					if (signed(OP1) <= signed(OP2)) then
						Y_TMP <= std_logic_vector(to_unsigned(1, Y_TMP'length));
					else
						Y_TMP <= std_logic_vector(to_unsigned(0, Y_TMP'length));
					end if;

--				when OP_SGE =>	-- signed, if (R[rega] >= R[regb]) R[regc] <-- 1 else R[regc] <-- 0
--				when OP_SGEI =>	-- signed, if (R[rega] >= imm16) R[regb] <-- 1 else R[regb] <-- 0
				when OP_SGE | OP_SGEI =>	
					if (signed(OP1) >= signed(OP2)) then
						Y_TMP <= std_logic_vector(to_unsigned(1, Y_TMP'length));
					else
						Y_TMP <= std_logic_vector(to_unsigned(0, Y_TMP'length));
					end if;

--				when OP_BEQZ =>	-- if (R[rega] == 0) PC <-- PC + imm16
--				when OP_BNEZ =>	-- if (R[rega] != 0) PC <-- PC + imm16
				when OP_BEQZ | OP_BNEZ =>
					Y_TMP <= OP1;

--				when OP_LW =>	-- R[regb] <-- M[imm16 + R[rega]]
--				when OP_SW =>	-- M[imm16 + R[rega]] <-- R[regb]
--				when OP_J =>	-- PC <-- PC + imm26
--				when OP_JAL =>	-- R31 <-- PC + 4; PC <-- PC + imm26
--				when OP_NOP =>	-- idles one cycle	
				when others => Y_TMP <= std_logic_vector(to_unsigned(0, Y_TMP'length));
			end case;
		end process;

		BRANCHES: process (Y_TMP, OPC)
		begin
			if (Y_TMP = std_logic_vector(to_unsigned(0, Y_TMP'length)) and OPC = OP_BEQZ) then
				Z <= '1';
			elsif (Y_TMP /= std_logic_vector(to_unsigned(0, Y_TMP'length)) and OPC = OP_BNEZ) then
				Z <= '1';
			else
				Z <= '0';
			end if;
		end process;

		Y <= Y_TMP;

		------------------------------------------------------------------------------------------------------------------------
		-- Components Mapping
		------------------------------------------------------------------------------------------------------------------------

		SUM: P4_ADDER
		generic map (N, NB)
		port map (OP_A, OP_B, OP_Ci, OP_S, open);

--		LGC: LOGIC
--		generic map (N)
--		port map (OP_A, OP_B, OP_LOGIC, OP_S);

--		CMP: COMPARATOR
--		generic map (N)
--		port map (OP_A, OP_B, OP_CMP);

end BEHAVIORAL;