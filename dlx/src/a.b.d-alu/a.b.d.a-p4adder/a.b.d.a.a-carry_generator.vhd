library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;
use work.constants.all;

entity CARRY_GENERATOR is

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL;			-- / 32 bits
			NB:	integer := ALU_BLOCK_SIZE_GLOBAL);		-- /  8 bits

	port 	(	A:	in	std_logic_vector(N-1 downto 0);		-- Operand 1		/ 32 bit
			B:	in	std_logic_vector(N-1 downto 0);		-- Operand 2		/ 32 bit
			Ci:	in	std_logic;				-- Carry in
			Co:	out	std_logic_vector(NB-1 downto 0));	-- Carry out		/  8 bit

end CARRY_GENERATOR;


architecture STRUCTURAL of CARRY_GENERATOR is

	constant NROW: integer := log2(N) + 1;					-- log2(32) + 1 = 6

	type SignalVector is array (NROW-1 downto 0) of std_logic_vector(N-1 downto 0);
	signal P, G: SignalVector := (others => (others => '0'));


	component PG_ROW
		generic (N: integer := ALU_OP_SIZE_GLOBAL);
		port (	A:	in	std_logic_vector(N-1 downto 0);
			B:	in	std_logic_vector(N-1 downto 0);
			Ci:	in	std_logic;
			P:	out	std_logic_vector(N-1 downto 0);		-- p_i = a_i ⊕ b_i
			G:	out	std_logic_vector(N-1 downto 0));	-- g_i = a_i * b_i
	end component;

	component GENERATE_BLOCK is
		port (	Gik:	in	std_logic;				-- G_{i:k}
			Gkj:	in	std_logic;				-- G_{k-1:j}
			Pik:	in	std_logic;				-- P_{i:k}
			Gij:	out	std_logic);				-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
	end component;

	component PG_BLOCK
		port (	Gik:	in	std_logic;				-- G_{i:k}
			Gkj:	in	std_logic;				-- G_{k-1:j}
			Pik:	in	std_logic;				-- P_{i:k}
			Pkj:	in	std_logic;				-- P_{k-1:j}
			Gij:	out	std_logic;				-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
			Pij:	out	std_logic);				-- P_{i:j} = P_{i:k} * P_{k-1:j}
	end component;


	begin

		-- first row
		PG_ROW_INSTANCE: PG_ROW
		generic map (ALU_OP_SIZE_GLOBAL)
		port map (
				A => A,
				B => B,
				Ci => Ci,
				G => G(0),
				P => P(0));

		-- rest of the tree
		PG_BLOCK_INSTANCE_ROW: for i in 1 to NROW-1 generate						-- rows (first excluded)
			PG_BLOCK_INSTANCE_COLUMN: for j in 0 to ALU_OP_SIZE_GLOBAL-1 generate			-- columns
				
				-- if we are in the first part of the tree we have a regular structure
				REG_NETWORK: if (i <= log2(ALU_BITBLOCK_SIZE_GLOBAL)) generate
					
					-- if we are in row "i" we need half the blocks of row "i-1"
					IF_REG_NEED: if ((j+1)mod(2**i) = 0) generate

						-- only the block of column "j" with the lowest value satisfies the following condition
						IF_REG_G: if (j < 2**i) generate
							G_BLOCK_INSTANCE: GENERATE_BLOCK
							port map (
									Gik => G(i-1)(j),			-- G_{i:k}
									Gkj => G(i-1)(j-2**(i-1)),		-- G_{k-1:j}
									Pik => P(i-1)(j),			-- P_{i:k}
									Gij => G(i)(j));			-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
						end generate;

						-- all other blocks satisfy the following condition
						IF_REG_PG: if (j >= 2**i) generate
							PG_BLOCK_REG_INSTANCE: PG_BLOCK
							port map (
									Gik => G(i-1)(j),			-- G_{i:k}
									Gkj => G(i-1)(j-(2**(i-1))),		-- G_{k-1:j}
									Pik => P(i-1)(j),			-- P_{i:k}
									Pkj => P(i-1)(j-(2**(i-1))),		-- P_{k-1:j}
									Gij => G(i)(j),				-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
									Pij => P(i)(j));			-- P_{i:j} = P_{i:k} * P_{k-1:j}
						end generate;

					end generate;

--					IF_REG_NOT_NEED: if ((j+1)mod(2**i) /= 0) generate
--						P(i)(j) <= '0';
--						G(i)(j) <= '0';
--					end generate;

				end generate;

				-- if we are in the second part of the tree we have an irregular structure
				UREG_NETWORK: if (i > log2(ALU_BITBLOCK_SIZE_GLOBAL)) generate
					
					-- if we are in row "i" we need the same number of blocks as in row "i-1"
					IF_UREG_NEED: if ((j mod (2**i)) >= 2**(i-1) and (j mod(2**i)) < 2**i) and (((j+1) mod ALU_BITBLOCK_SIZE_GLOBAL) = 0) generate

						-- "2**(i-ALU_BITBLOCK_SIZE_GLOBAL)" blocks in columns "j" with the lowest value meet the following condition
						IF_UREG_G: if (j < 2**i) generate
							G_BLOCK_INSTANCE: GENERATE_BLOCK
							port map (
									Gik => G(i-1)(j),			-- G_{i:k}
									Gkj => G(i-1)((j/2**(i-1))*2**(i-1)-1),	-- G_{k-1:j}
									Pik => P(i-1)(j),			-- P_{i:k}
									Gij => G(i)(j));			-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
						end generate;

						-- all other blocks satisfy the following condition
						IF_UREG_PG: if (j >= (2**(i-ALU_BITBLOCK_SIZE_GLOBAL+1))) generate
							PG_BLOCK_REG_INSTANCE: PG_BLOCK
							port map (
									Gik => G(i-1)(j),			-- G_{i:k}
									Gkj => G(i-1)((j/2**(i-1))*2**(i-1)-1),	-- G_{k-1:j}
									Pik => P(i-1)(j),			-- P_{i:k}
									Pkj => P(i-1)((j/2**(i-1))*2**(i-1)-1),	-- P_{k-1:j}
									Gij => G(i)(j),				-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
									Pij => P(i)(j));			-- P_{i:j} = P_{i:k} * P_{k-1:j}
						end generate;

					end generate;

					-- if the signal must be passed to the next row, it is connected with the previous row
					PASS_SIGNAL: if((j mod (2**i)) < 2**(i-1) and (j mod (2**i)) >= 0) and (((j+1) mod ALU_BITBLOCK_SIZE_GLOBAL) = 0) generate
						P(i)(j) <= P(i-1)(j);
						G(i)(j) <= G(i-1)(j);
					end generate;

--					IF_UREG_NOT_NEED: if ((((j mod(2**i)) < 2**i) or (j mod (2**i)) >= 0)) and (((j+1) mod ALU_BITBLOCK_SIZE_GLOBAL) /= 0) generate
--						P(i)(j) <= '0';
--						G(i)(j) <= '0';
--					end generate;

				end generate;
				
				-- if it is the last row, it carries the G signal to the cout
				LAST_ROW: if (i = NROW-1) generate
					
					COUT_SELECT: if ((j+1) mod ALU_BITBLOCK_SIZE_GLOBAL) = 0 generate
						Co(j/ALU_BITBLOCK_SIZE_GLOBAL) <= G(i)(j);
					end generate;

				end generate;
			end generate;
		end generate;

end STRUCTURAL;


configuration CFG_CARRY_GENERATOR of CARRY_GENERATOR is
	for STRUCTURAL
	end for;
end configuration;
