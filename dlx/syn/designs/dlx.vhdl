
library IEEE;

use IEEE.std_logic_1164.all;

package CONV_PACK_DLX is

-- define attributes
attribute ENUM_ENCODING : STRING;

-- define any necessary types
type aluOp is (OP_SLL, OP_SRL, OP_SRA, OP_ADD, OP_ADDU, OP_SUB, OP_SUBU, 
   OP_AND, OP_OR, OP_XOR, OP_SEQ, OP_SNE, OP_SLT, OP_SGT, OP_SLE, OP_SGE, 
   OP_MOVI2S, OP_MOVS2I, OP_MOVF, OP_MOVD, OP_MOVFP2I, OP_MOVI2FP, OP_MOVI2T, 
   OP_MOVT2I, OP_SLTU, OP_SGTU, OP_SLEU, OP_SGEU, OP_ADDF, OP_SUBF, OP_MULTF, 
   OP_DIVF, OP_ADDD, OP_SUBD, OP_MULTD, OP_DIVD, OP_CVTF2D, OP_CVTF2I, 
   OP_CVTD2F, OP_CVTD2I, OP_CVTI2F, OP_CVTI2D, OP_MULT, OP_DIV, OP_EQF, OP_NEF,
   OP_LTF, OP_GTF, OP_LEF, OP_GEF, OP_MULTU, OP_DIVU, OP_EQD, OP_NED, OP_LTD, 
   OP_GTD, OP_LED, OP_GED, OP_BEQZ, OP_BNEZ, OP_BFPT, OP_BFPF, OP_ADDI, 
   OP_ADDUI, OP_SUBI, OP_SUBUI, OP_ANDI, OP_ORI, OP_XORI, OP_LHI, OP_RFE, 
   OP_TRAP, OP_JR, OP_JALR, OP_SLLI, OP_SRLI, OP_SRAI, OP_SEQI, OP_SNEI, 
   OP_SLTI, OP_SGTI, OP_SLEI, OP_SGEI, OP_LB, OP_LH, OP_LW, OP_LBU, OP_LHU, 
   OP_LF, OP_LD, OP_SB, OP_SH, OP_SW, OP_SF, OP_SD, OP_ITLB, OP_SLTUI, 
   OP_SGTUI, OP_SLEUI, OP_SGEUI, OP_J, OP_JAL, OP_NOP);
attribute ENUM_ENCODING of aluOp : type is 
   "0000000 0000001 0000010 0000011 0000100 0000101 0000110 0000111 0001000 0001001 0001010 0001011 0001100 0001101 0001110 0001111 0010000 0010001 0010010 0010011 0010100 0010101 0010110 0010111 0011000 0011001 0011010 0011011 0011100 0011101 0011110 0011111 0100000 0100001 0100010 0100011 0100100 0100101 0100110 0100111 0101000 0101001 0101010 0101011 0101100 0101101 0101110 0101111 0110000 0110001 0110010 0110011 0110100 0110101 0110110 0110111 0111000 0111001 0111010 0111011 0111100 0111101 0111110 0111111 1000000 1000001 1000010 1000011 1000100 1000101 1000110 1000111 1001000 1001001 1001010 1001011 1001100 1001101 1001110 1001111 1010000 1010001 1010010 1010011 1010100 1010101 1010110 1010111 1011000 1011001 1011010 1011011 1011100 1011101 1011110 1011111 1100000 1100001 1100010 1100011 1100100 1100101 1100110";

end CONV_PACK_DLX;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity DLX_IRAM_RAM_DEPTH256_I_SIZE32 is

   port( RST : in std_logic;  ADDR : in std_logic_vector (31 downto 0);  DOUT :
         out std_logic_vector (31 downto 0));

end DLX_IRAM_RAM_DEPTH256_I_SIZE32;

architecture SYN_BEHAVIORAL of DLX_IRAM_RAM_DEPTH256_I_SIZE32 is

begin

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity DLX_DRAM_N256_NW32 is

   port( CLK, RST, RE, WE : in std_logic;  ADDR, DIN : in std_logic_vector (31 
         downto 0);  DOUT : out std_logic_vector (31 downto 0));

end DLX_DRAM_N256_NW32;

architecture SYN_BEHAVIORAL of DLX_DRAM_N256_NW32 is

begin

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity PG_ROW_N32 is

   port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic;  P, G : 
         out std_logic_vector (31 downto 0));

end PG_ROW_N32;

architecture SYN_BEHAVIORAL of PG_ROW_N32 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component XNOR2_X1
      port( A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   signal n10, n11, n12 : std_logic;

begin
   
   U1 : XOR2_X1 port map( A => B(9), B => A(9), Z => P(9));
   U2 : XOR2_X1 port map( A => B(8), B => A(8), Z => P(8));
   U3 : XOR2_X1 port map( A => B(7), B => A(7), Z => P(7));
   U4 : XOR2_X1 port map( A => B(6), B => A(6), Z => P(6));
   U5 : XOR2_X1 port map( A => B(5), B => A(5), Z => P(5));
   U6 : XOR2_X1 port map( A => B(4), B => A(4), Z => P(4));
   U7 : XOR2_X1 port map( A => B(3), B => A(3), Z => P(3));
   U8 : XOR2_X1 port map( A => B(31), B => A(31), Z => P(31));
   U9 : XOR2_X1 port map( A => B(30), B => A(30), Z => P(30));
   U10 : XOR2_X1 port map( A => B(2), B => A(2), Z => P(2));
   U11 : XOR2_X1 port map( A => B(29), B => A(29), Z => P(29));
   U12 : XOR2_X1 port map( A => B(28), B => A(28), Z => P(28));
   U13 : XOR2_X1 port map( A => B(27), B => A(27), Z => P(27));
   U14 : XOR2_X1 port map( A => B(26), B => A(26), Z => P(26));
   U15 : XOR2_X1 port map( A => B(25), B => A(25), Z => P(25));
   U16 : XOR2_X1 port map( A => B(24), B => A(24), Z => P(24));
   U17 : XOR2_X1 port map( A => B(23), B => A(23), Z => P(23));
   U18 : XOR2_X1 port map( A => B(22), B => A(22), Z => P(22));
   U19 : XOR2_X1 port map( A => B(21), B => A(21), Z => P(21));
   U20 : XOR2_X1 port map( A => B(20), B => A(20), Z => P(20));
   U21 : XOR2_X1 port map( A => B(1), B => A(1), Z => P(1));
   U22 : XOR2_X1 port map( A => B(19), B => A(19), Z => P(19));
   U23 : XOR2_X1 port map( A => B(18), B => A(18), Z => P(18));
   U24 : XOR2_X1 port map( A => B(17), B => A(17), Z => P(17));
   U25 : XOR2_X1 port map( A => B(16), B => A(16), Z => P(16));
   U26 : XOR2_X1 port map( A => B(15), B => A(15), Z => P(15));
   U27 : XOR2_X1 port map( A => B(14), B => A(14), Z => P(14));
   U28 : XOR2_X1 port map( A => B(13), B => A(13), Z => P(13));
   U29 : XOR2_X1 port map( A => B(12), B => A(12), Z => P(12));
   U30 : XOR2_X1 port map( A => B(11), B => A(11), Z => P(11));
   U31 : XOR2_X1 port map( A => B(10), B => A(10), Z => P(10));
   U32 : XNOR2_X1 port map( A => n10, B => A(0), ZN => P(0));
   U33 : AND2_X1 port map( A1 => B(9), A2 => A(9), ZN => G(9));
   U34 : AND2_X1 port map( A1 => B(8), A2 => A(8), ZN => G(8));
   U35 : AND2_X1 port map( A1 => B(7), A2 => A(7), ZN => G(7));
   U36 : AND2_X1 port map( A1 => B(6), A2 => A(6), ZN => G(6));
   U37 : AND2_X1 port map( A1 => B(5), A2 => A(5), ZN => G(5));
   U38 : AND2_X1 port map( A1 => B(4), A2 => A(4), ZN => G(4));
   U39 : AND2_X1 port map( A1 => B(3), A2 => A(3), ZN => G(3));
   U40 : AND2_X1 port map( A1 => B(31), A2 => A(31), ZN => G(31));
   U41 : AND2_X1 port map( A1 => B(30), A2 => A(30), ZN => G(30));
   U42 : AND2_X1 port map( A1 => B(2), A2 => A(2), ZN => G(2));
   U43 : AND2_X1 port map( A1 => B(29), A2 => A(29), ZN => G(29));
   U44 : AND2_X1 port map( A1 => B(28), A2 => A(28), ZN => G(28));
   U45 : AND2_X1 port map( A1 => B(27), A2 => A(27), ZN => G(27));
   U46 : AND2_X1 port map( A1 => B(26), A2 => A(26), ZN => G(26));
   U47 : AND2_X1 port map( A1 => B(25), A2 => A(25), ZN => G(25));
   U48 : AND2_X1 port map( A1 => B(24), A2 => A(24), ZN => G(24));
   U49 : AND2_X1 port map( A1 => B(23), A2 => A(23), ZN => G(23));
   U50 : AND2_X1 port map( A1 => B(22), A2 => A(22), ZN => G(22));
   U51 : AND2_X1 port map( A1 => B(21), A2 => A(21), ZN => G(21));
   U52 : AND2_X1 port map( A1 => B(20), A2 => A(20), ZN => G(20));
   U53 : AND2_X1 port map( A1 => B(1), A2 => A(1), ZN => G(1));
   U54 : AND2_X1 port map( A1 => B(19), A2 => A(19), ZN => G(19));
   U55 : AND2_X1 port map( A1 => B(18), A2 => A(18), ZN => G(18));
   U56 : AND2_X1 port map( A1 => B(17), A2 => A(17), ZN => G(17));
   U57 : AND2_X1 port map( A1 => B(16), A2 => A(16), ZN => G(16));
   U58 : AND2_X1 port map( A1 => B(15), A2 => A(15), ZN => G(15));
   U59 : AND2_X1 port map( A1 => B(14), A2 => A(14), ZN => G(14));
   U60 : AND2_X1 port map( A1 => B(13), A2 => A(13), ZN => G(13));
   U61 : AND2_X1 port map( A1 => B(12), A2 => A(12), ZN => G(12));
   U62 : AND2_X1 port map( A1 => B(11), A2 => A(11), ZN => G(11));
   U63 : AND2_X1 port map( A1 => B(10), A2 => A(10), ZN => G(10));
   U64 : OAI21_X1 port map( B1 => n10, B2 => n11, A => n12, ZN => G(0));
   U65 : OAI21_X1 port map( B1 => A(0), B2 => B(0), A => Ci, ZN => n12);
   U66 : INV_X1 port map( A => A(0), ZN => n11);
   U67 : INV_X1 port map( A => B(0), ZN => n10);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity COMPARATOR_N32_DW01_cmp6_1_DW01_cmp6_5 is

   port( A, B : in std_logic_vector (31 downto 0);  TC : in std_logic;  LT, GT,
         EQ, LE, GE, NE : out std_logic);

end COMPARATOR_N32_DW01_cmp6_1_DW01_cmp6_5;

architecture SYN_rpl of COMPARATOR_N32_DW01_cmp6_1_DW01_cmp6_5 is

   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   signal GT_port, n203, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
      n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91
      , n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, 
      n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, 
      n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, 
      n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, 
      n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, 
      n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, 
      n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, 
      n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, 
      n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, 
      n201, n202, n332, n334, n335, n336, n337, n338, n339, n340, n341, n342, 
      n343, n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, 
      n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, 
      n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, 
      n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, 
      n391, n392, n393, n394, n395 : std_logic;

begin
   GT <= GT_port;
   
   U102 : XOR2_X1 port map( A => A(30), B => n394, Z => n70);
   U171 : NAND3_X1 port map( A1 => n197, A2 => n150, A3 => n147, ZN => n196);
   U175 : NAND3_X1 port map( A1 => n387, A2 => n199, A3 => n200, ZN => n197);
   U1 : INV_X1 port map( A => n142, ZN => n381);
   U2 : INV_X1 port map( A => n130, ZN => n373);
   U3 : INV_X1 port map( A => n118, ZN => n365);
   U4 : INV_X1 port map( A => n106, ZN => n357);
   U5 : INV_X1 port map( A => n94, ZN => n349);
   U6 : INV_X1 port map( A => n82, ZN => n341);
   U7 : NOR2_X1 port map( A1 => n193, A2 => n136, ZN => n135);
   U8 : NOR2_X1 port map( A1 => n187, A2 => n124, ZN => n123);
   U9 : NOR2_X1 port map( A1 => n181, A2 => n112, ZN => n111);
   U10 : NOR2_X1 port map( A1 => n175, A2 => n100, ZN => n99);
   U11 : NOR2_X1 port map( A1 => n169, A2 => n88, ZN => n87);
   U12 : NOR2_X1 port map( A1 => n163, A2 => n76, ZN => n75);
   U13 : NOR2_X1 port map( A1 => n198, A2 => n148, ZN => n147);
   U14 : OAI211_X1 port map( C1 => n161, C2 => n162, A => n78, B => n75, ZN => 
                           n160);
   U15 : NAND2_X1 port map( A1 => n339, A2 => n164, ZN => n162);
   U16 : AOI211_X1 port map( C1 => n165, C2 => n166, A => n82, B => n344, ZN =>
                           n161);
   U17 : INV_X1 port map( A => n79, ZN => n339);
   U18 : OAI211_X1 port map( C1 => n191, C2 => n192, A => n138, B => n135, ZN 
                           => n190);
   U19 : NAND2_X1 port map( A1 => n379, A2 => n194, ZN => n192);
   U20 : AOI211_X1 port map( C1 => n195, C2 => n196, A => n142, B => n384, ZN 
                           => n191);
   U21 : INV_X1 port map( A => n139, ZN => n379);
   U22 : OAI211_X1 port map( C1 => n185, C2 => n186, A => n126, B => n123, ZN 
                           => n184);
   U23 : NAND2_X1 port map( A1 => n371, A2 => n188, ZN => n186);
   U24 : AOI211_X1 port map( C1 => n189, C2 => n190, A => n130, B => n376, ZN 
                           => n185);
   U25 : INV_X1 port map( A => n127, ZN => n371);
   U26 : OAI211_X1 port map( C1 => n179, C2 => n180, A => n114, B => n111, ZN 
                           => n178);
   U27 : NAND2_X1 port map( A1 => n363, A2 => n182, ZN => n180);
   U28 : AOI211_X1 port map( C1 => n183, C2 => n184, A => n118, B => n368, ZN 
                           => n179);
   U29 : INV_X1 port map( A => n115, ZN => n363);
   U30 : OAI211_X1 port map( C1 => n173, C2 => n174, A => n102, B => n99, ZN =>
                           n172);
   U31 : NAND2_X1 port map( A1 => n355, A2 => n176, ZN => n174);
   U32 : AOI211_X1 port map( C1 => n177, C2 => n178, A => n106, B => n360, ZN 
                           => n173);
   U33 : INV_X1 port map( A => n103, ZN => n355);
   U34 : OAI211_X1 port map( C1 => n167, C2 => n168, A => n90, B => n87, ZN => 
                           n166);
   U35 : NAND2_X1 port map( A1 => n347, A2 => n170, ZN => n168);
   U36 : AOI211_X1 port map( C1 => n171, C2 => n172, A => n94, B => n352, ZN =>
                           n167);
   U37 : INV_X1 port map( A => n91, ZN => n347);
   U38 : AOI21_X1 port map( B1 => n143, B2 => n144, A => n145, ZN => n140);
   U39 : AOI21_X1 port map( B1 => n146, B2 => n147, A => n148, ZN => n143);
   U40 : AOI21_X1 port map( B1 => n149, B2 => n150, A => n151, ZN => n146);
   U41 : AOI21_X1 port map( B1 => n152, B2 => n153, A => n389, ZN => n149);
   U42 : AOI21_X1 port map( B1 => n131, B2 => n132, A => n133, ZN => n128);
   U43 : AOI21_X1 port map( B1 => n134, B2 => n135, A => n136, ZN => n131);
   U44 : AOI21_X1 port map( B1 => n137, B2 => n138, A => n139, ZN => n134);
   U45 : AOI21_X1 port map( B1 => n140, B2 => n381, A => n382, ZN => n137);
   U46 : AOI21_X1 port map( B1 => n119, B2 => n120, A => n121, ZN => n116);
   U47 : AOI21_X1 port map( B1 => n122, B2 => n123, A => n124, ZN => n119);
   U48 : AOI21_X1 port map( B1 => n125, B2 => n126, A => n127, ZN => n122);
   U49 : AOI21_X1 port map( B1 => n128, B2 => n373, A => n374, ZN => n125);
   U50 : AOI21_X1 port map( B1 => n107, B2 => n108, A => n109, ZN => n104);
   U51 : AOI21_X1 port map( B1 => n110, B2 => n111, A => n112, ZN => n107);
   U52 : AOI21_X1 port map( B1 => n113, B2 => n114, A => n115, ZN => n110);
   U53 : AOI21_X1 port map( B1 => n116, B2 => n365, A => n366, ZN => n113);
   U54 : AOI21_X1 port map( B1 => n95, B2 => n96, A => n97, ZN => n92);
   U55 : AOI21_X1 port map( B1 => n98, B2 => n99, A => n100, ZN => n95);
   U56 : AOI21_X1 port map( B1 => n101, B2 => n102, A => n103, ZN => n98);
   U57 : AOI21_X1 port map( B1 => n104, B2 => n357, A => n358, ZN => n101);
   U58 : AOI21_X1 port map( B1 => n83, B2 => n84, A => n85, ZN => n80);
   U59 : AOI21_X1 port map( B1 => n86, B2 => n87, A => n88, ZN => n83);
   U60 : AOI21_X1 port map( B1 => n89, B2 => n90, A => n91, ZN => n86);
   U61 : AOI21_X1 port map( B1 => n92, B2 => n349, A => n350, ZN => n89);
   U62 : AOI21_X1 port map( B1 => n71, B2 => n72, A => n73, ZN => n69);
   U63 : AOI21_X1 port map( B1 => n74, B2 => n75, A => n76, ZN => n71);
   U64 : AOI21_X1 port map( B1 => n77, B2 => n78, A => n79, ZN => n74);
   U65 : AOI21_X1 port map( B1 => n80, B2 => n341, A => n342, ZN => n77);
   U66 : NOR2_X1 port map( A1 => n198, A2 => n145, ZN => n195);
   U67 : NOR2_X1 port map( A1 => n193, A2 => n133, ZN => n189);
   U68 : NOR2_X1 port map( A1 => n187, A2 => n121, ZN => n183);
   U69 : NOR2_X1 port map( A1 => n181, A2 => n109, ZN => n177);
   U70 : NOR2_X1 port map( A1 => n175, A2 => n97, ZN => n171);
   U71 : NOR2_X1 port map( A1 => n169, A2 => n85, ZN => n165);
   U72 : NOR2_X1 port map( A1 => n163, A2 => n73, ZN => n159);
   U73 : NAND2_X1 port map( A1 => n194, A2 => n141, ZN => n142);
   U74 : NAND2_X1 port map( A1 => n188, A2 => n129, ZN => n130);
   U75 : NAND2_X1 port map( A1 => n182, A2 => n117, ZN => n118);
   U76 : NAND2_X1 port map( A1 => n176, A2 => n105, ZN => n106);
   U77 : NAND2_X1 port map( A1 => n170, A2 => n93, ZN => n94);
   U78 : NAND2_X1 port map( A1 => n164, A2 => n81, ZN => n82);
   U79 : AND2_X1 port map( A1 => n199, A2 => n154, ZN => n153);
   U80 : INV_X1 port map( A => n154, ZN => n389);
   U81 : INV_X1 port map( A => n144, ZN => n384);
   U82 : INV_X1 port map( A => n132, ZN => n376);
   U83 : INV_X1 port map( A => n120, ZN => n368);
   U84 : INV_X1 port map( A => n108, ZN => n360);
   U85 : INV_X1 port map( A => n96, ZN => n352);
   U86 : INV_X1 port map( A => n84, ZN => n344);
   U87 : INV_X1 port map( A => n141, ZN => n382);
   U88 : INV_X1 port map( A => n129, ZN => n374);
   U89 : INV_X1 port map( A => n117, ZN => n366);
   U90 : INV_X1 port map( A => n105, ZN => n358);
   U91 : INV_X1 port map( A => n93, ZN => n350);
   U92 : INV_X1 port map( A => n81, ZN => n342);
   U93 : NAND2_X1 port map( A1 => B(3), A2 => n388, ZN => n150);
   U94 : NAND2_X1 port map( A1 => B(2), A2 => n390, ZN => n154);
   U95 : NOR2_X1 port map( A1 => n392, A2 => B(0), ZN => n201);
   U96 : NOR2_X1 port map( A1 => n388, A2 => B(3), ZN => n151);
   U97 : NOR2_X1 port map( A1 => n386, A2 => B(4), ZN => n198);
   U98 : INV_X1 port map( A => B(1), ZN => n395);
   U99 : AOI21_X1 port map( B1 => n66, B2 => n334, A => n67, ZN => n203);
   U100 : INV_X1 port map( A => n68, ZN => n334);
   U101 : AOI22_X1 port map( A1 => B(30), A2 => n335, B1 => n69, B2 => n70, ZN 
                           => n68);
   U103 : INV_X1 port map( A => A(30), ZN => n335);
   U104 : AOI22_X1 port map( A1 => n155, A2 => n395, B1 => A(1), B2 => n156, ZN
                           => n152);
   U105 : OR2_X1 port map( A1 => n156, A2 => A(1), ZN => n155);
   U106 : NAND2_X1 port map( A1 => B(0), A2 => n392, ZN => n156);
   U107 : NOR2_X1 port map( A1 => n378, A2 => B(8), ZN => n193);
   U108 : NOR2_X1 port map( A1 => n370, A2 => B(12), ZN => n187);
   U109 : NOR2_X1 port map( A1 => n362, A2 => B(16), ZN => n181);
   U110 : NOR2_X1 port map( A1 => n354, A2 => B(20), ZN => n175);
   U111 : NOR2_X1 port map( A1 => n346, A2 => B(24), ZN => n169);
   U112 : NOR2_X1 port map( A1 => n338, A2 => B(28), ZN => n163);
   U113 : NOR2_X1 port map( A1 => n385, A2 => B(5), ZN => n145);
   U114 : NOR2_X1 port map( A1 => n377, A2 => B(9), ZN => n133);
   U115 : NOR2_X1 port map( A1 => n369, A2 => B(13), ZN => n121);
   U116 : NOR2_X1 port map( A1 => n361, A2 => B(17), ZN => n109);
   U117 : NOR2_X1 port map( A1 => n353, A2 => B(21), ZN => n97);
   U118 : NOR2_X1 port map( A1 => n345, A2 => B(25), ZN => n85);
   U119 : NOR2_X1 port map( A1 => n337, A2 => B(29), ZN => n73);
   U120 : NOR2_X1 port map( A1 => n380, A2 => B(7), ZN => n139);
   U121 : NOR2_X1 port map( A1 => n372, A2 => B(11), ZN => n127);
   U122 : NOR2_X1 port map( A1 => n364, A2 => B(15), ZN => n115);
   U123 : NOR2_X1 port map( A1 => n356, A2 => B(19), ZN => n103);
   U124 : NOR2_X1 port map( A1 => n348, A2 => B(23), ZN => n91);
   U125 : NOR2_X1 port map( A1 => n340, A2 => B(27), ZN => n79);
   U126 : NOR2_X1 port map( A1 => n393, A2 => A(31), ZN => n67);
   U127 : OAI21_X1 port map( B1 => n67, B2 => n157, A => n66, ZN => GT_port);
   U128 : AOI22_X1 port map( A1 => A(30), A2 => n394, B1 => n158, B2 => n70, ZN
                           => n157);
   U129 : AOI21_X1 port map( B1 => n159, B2 => n160, A => n336, ZN => n158);
   U130 : INV_X1 port map( A => n72, ZN => n336);
   U131 : INV_X1 port map( A => n151, ZN => n387);
   U132 : OAI211_X1 port map( C1 => A(1), C2 => n201, A => n391, B => n153, ZN 
                           => n200);
   U133 : AND2_X1 port map( A1 => n332, A2 => n203, ZN => EQ);
   U134 : INV_X1 port map( A => GT_port, ZN => n332);
   U135 : NAND2_X1 port map( A1 => A(31), A2 => n393, ZN => n66);
   U136 : NAND2_X1 port map( A1 => B(7), A2 => n380, ZN => n138);
   U137 : NAND2_X1 port map( A1 => B(11), A2 => n372, ZN => n126);
   U138 : NAND2_X1 port map( A1 => B(15), A2 => n364, ZN => n114);
   U139 : NAND2_X1 port map( A1 => B(19), A2 => n356, ZN => n102);
   U140 : NAND2_X1 port map( A1 => B(23), A2 => n348, ZN => n90);
   U141 : NAND2_X1 port map( A1 => B(27), A2 => n340, ZN => n78);
   U142 : NAND2_X1 port map( A1 => B(5), A2 => n385, ZN => n144);
   U143 : NAND2_X1 port map( A1 => B(9), A2 => n377, ZN => n132);
   U144 : NAND2_X1 port map( A1 => B(13), A2 => n369, ZN => n120);
   U145 : NAND2_X1 port map( A1 => B(17), A2 => n361, ZN => n108);
   U146 : NAND2_X1 port map( A1 => B(21), A2 => n353, ZN => n96);
   U147 : NAND2_X1 port map( A1 => B(25), A2 => n345, ZN => n84);
   U148 : NAND2_X1 port map( A1 => B(29), A2 => n337, ZN => n72);
   U149 : AND2_X1 port map( A1 => B(4), A2 => n386, ZN => n148);
   U150 : NAND2_X1 port map( A1 => B(6), A2 => n383, ZN => n141);
   U151 : NAND2_X1 port map( A1 => B(10), A2 => n375, ZN => n129);
   U152 : NAND2_X1 port map( A1 => B(14), A2 => n367, ZN => n117);
   U153 : NAND2_X1 port map( A1 => B(18), A2 => n359, ZN => n105);
   U154 : NAND2_X1 port map( A1 => B(22), A2 => n351, ZN => n93);
   U155 : NAND2_X1 port map( A1 => B(26), A2 => n343, ZN => n81);
   U156 : INV_X1 port map( A => B(30), ZN => n394);
   U157 : INV_X1 port map( A => A(0), ZN => n392);
   U158 : INV_X1 port map( A => A(5), ZN => n385);
   U159 : INV_X1 port map( A => A(9), ZN => n377);
   U160 : INV_X1 port map( A => A(13), ZN => n369);
   U161 : INV_X1 port map( A => A(17), ZN => n361);
   U162 : INV_X1 port map( A => A(21), ZN => n353);
   U163 : INV_X1 port map( A => A(25), ZN => n345);
   U164 : INV_X1 port map( A => A(29), ZN => n337);
   U165 : INV_X1 port map( A => A(3), ZN => n388);
   U166 : INV_X1 port map( A => A(7), ZN => n380);
   U167 : INV_X1 port map( A => A(11), ZN => n372);
   U168 : INV_X1 port map( A => A(15), ZN => n364);
   U169 : INV_X1 port map( A => A(19), ZN => n356);
   U170 : INV_X1 port map( A => A(23), ZN => n348);
   U172 : INV_X1 port map( A => A(27), ZN => n340);
   U173 : INV_X1 port map( A => B(31), ZN => n393);
   U174 : INV_X1 port map( A => A(2), ZN => n390);
   U176 : INV_X1 port map( A => A(6), ZN => n383);
   U177 : INV_X1 port map( A => A(10), ZN => n375);
   U178 : INV_X1 port map( A => A(14), ZN => n367);
   U179 : INV_X1 port map( A => A(18), ZN => n359);
   U180 : INV_X1 port map( A => A(22), ZN => n351);
   U181 : INV_X1 port map( A => A(26), ZN => n343);
   U182 : AND2_X1 port map( A1 => B(8), A2 => n378, ZN => n136);
   U183 : AND2_X1 port map( A1 => B(12), A2 => n370, ZN => n124);
   U184 : AND2_X1 port map( A1 => B(16), A2 => n362, ZN => n112);
   U185 : AND2_X1 port map( A1 => B(20), A2 => n354, ZN => n100);
   U186 : AND2_X1 port map( A1 => B(24), A2 => n346, ZN => n88);
   U187 : AND2_X1 port map( A1 => B(28), A2 => n338, ZN => n76);
   U188 : OR2_X1 port map( A1 => n390, A2 => B(2), ZN => n199);
   U189 : INV_X1 port map( A => A(4), ZN => n386);
   U190 : INV_X1 port map( A => A(8), ZN => n378);
   U191 : INV_X1 port map( A => A(12), ZN => n370);
   U192 : INV_X1 port map( A => A(16), ZN => n362);
   U193 : INV_X1 port map( A => A(20), ZN => n354);
   U194 : INV_X1 port map( A => A(24), ZN => n346);
   U195 : INV_X1 port map( A => A(28), ZN => n338);
   U196 : INV_X1 port map( A => n203, ZN => LT);
   U197 : OR2_X1 port map( A1 => n383, A2 => B(6), ZN => n194);
   U198 : OR2_X1 port map( A1 => n375, A2 => B(10), ZN => n188);
   U199 : OR2_X1 port map( A1 => n367, A2 => B(14), ZN => n182);
   U200 : OR2_X1 port map( A1 => n359, A2 => B(18), ZN => n176);
   U201 : OR2_X1 port map( A1 => n351, A2 => B(22), ZN => n170);
   U202 : OR2_X1 port map( A1 => n343, A2 => B(26), ZN => n164);
   U203 : INV_X1 port map( A => n202, ZN => n391);
   U204 : AOI21_X1 port map( B1 => A(1), B2 => n201, A => n395, ZN => n202);

end SYN_rpl;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity COMPARATOR_N32_DW01_cmp6_0_DW01_cmp6_4 is

   port( A, B : in std_logic_vector (31 downto 0);  TC : in std_logic;  LT, GT,
         EQ, LE, GE, NE : out std_logic);

end COMPARATOR_N32_DW01_cmp6_0_DW01_cmp6_4;

architecture SYN_rpl of COMPARATOR_N32_DW01_cmp6_0_DW01_cmp6_4 is

   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   signal n202, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77
      , n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, 
      n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, 
      n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, 
      n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, 
      n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, 
      n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, 
      n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, 
      n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, 
      n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, 
      n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, 
      n201, n332, n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, 
      n343, n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, 
      n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, 
      n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, 
      n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, 
      n391, n392, n393, n394 : std_logic;

begin
   
   U86 : NAND3_X1 port map( A1 => n133, A2 => n134, A3 => n135, ZN => n130);
   U87 : NAND3_X1 port map( A1 => n136, A2 => n137, A3 => n138, ZN => n133);
   U101 : XOR2_X1 port map( A => n333, B => B(30), Z => n69);
   U1 : INV_X1 port map( A => n131, ZN => n356);
   U2 : INV_X1 port map( A => n111, ZN => n348);
   U3 : INV_X1 port map( A => n91, ZN => n340);
   U4 : NOR2_X1 port map( A1 => n190, A2 => n144, ZN => n126);
   U5 : NOR2_X1 port map( A1 => n198, A2 => n360, ZN => n140);
   U6 : INV_X1 port map( A => n137, ZN => n360);
   U7 : NOR2_X1 port map( A1 => n184, A2 => n146, ZN => n116);
   U8 : NOR2_X1 port map( A1 => n178, A2 => n148, ZN => n106);
   U9 : NOR2_X1 port map( A1 => n172, A2 => n150, ZN => n96);
   U10 : NOR2_X1 port map( A1 => n166, A2 => n152, ZN => n86);
   U11 : NOR2_X1 port map( A1 => n160, A2 => n154, ZN => n76);
   U12 : OAI211_X1 port map( C1 => n73, C2 => n74, A => n75, B => n76, ZN => 
                           n71);
   U13 : NAND2_X1 port map( A1 => n77, A2 => n78, ZN => n74);
   U14 : AOI211_X1 port map( C1 => n79, C2 => n80, A => n81, B => n82, ZN => 
                           n73);
   U15 : NOR2_X1 port map( A1 => n152, A2 => n153, ZN => n79);
   U16 : OAI211_X1 port map( C1 => n123, C2 => n124, A => n125, B => n126, ZN 
                           => n120);
   U17 : NAND2_X1 port map( A1 => n127, A2 => n128, ZN => n124);
   U18 : AOI211_X1 port map( C1 => n129, C2 => n130, A => n131, B => n132, ZN 
                           => n123);
   U19 : NOR2_X1 port map( A1 => n142, A2 => n143, ZN => n129);
   U20 : OAI211_X1 port map( C1 => n113, C2 => n114, A => n115, B => n116, ZN 
                           => n110);
   U21 : NAND2_X1 port map( A1 => n117, A2 => n118, ZN => n114);
   U22 : AOI211_X1 port map( C1 => n119, C2 => n120, A => n121, B => n122, ZN 
                           => n113);
   U23 : NOR2_X1 port map( A1 => n144, A2 => n145, ZN => n119);
   U24 : OAI211_X1 port map( C1 => n103, C2 => n104, A => n105, B => n106, ZN 
                           => n100);
   U25 : NAND2_X1 port map( A1 => n107, A2 => n108, ZN => n104);
   U26 : AOI211_X1 port map( C1 => n109, C2 => n110, A => n111, B => n112, ZN 
                           => n103);
   U27 : NOR2_X1 port map( A1 => n146, A2 => n147, ZN => n109);
   U28 : OAI211_X1 port map( C1 => n93, C2 => n94, A => n95, B => n96, ZN => 
                           n90);
   U29 : NAND2_X1 port map( A1 => n97, A2 => n98, ZN => n94);
   U30 : AOI211_X1 port map( C1 => n99, C2 => n100, A => n101, B => n102, ZN =>
                           n93);
   U31 : NOR2_X1 port map( A1 => n148, A2 => n149, ZN => n99);
   U32 : OAI211_X1 port map( C1 => n83, C2 => n84, A => n85, B => n86, ZN => 
                           n80);
   U33 : NAND2_X1 port map( A1 => n87, A2 => n88, ZN => n84);
   U34 : AOI211_X1 port map( C1 => n89, C2 => n90, A => n91, B => n92, ZN => 
                           n83);
   U35 : NOR2_X1 port map( A1 => n150, A2 => n151, ZN => n89);
   U36 : AOI21_X1 port map( B1 => n194, B2 => n358, A => n143, ZN => n192);
   U37 : INV_X1 port map( A => n132, ZN => n358);
   U38 : AOI21_X1 port map( B1 => n195, B2 => n135, A => n196, ZN => n194);
   U39 : AOI21_X1 port map( B1 => n197, B2 => n134, A => n359, ZN => n195);
   U40 : AOI21_X1 port map( B1 => n189, B2 => n126, A => n190, ZN => n188);
   U41 : AOI21_X1 port map( B1 => n191, B2 => n125, A => n355, ZN => n189);
   U42 : INV_X1 port map( A => n127, ZN => n355);
   U43 : AOI21_X1 port map( B1 => n192, B2 => n356, A => n193, ZN => n191);
   U44 : AOI21_X1 port map( B1 => n186, B2 => n352, A => n187, ZN => n185);
   U45 : INV_X1 port map( A => n121, ZN => n352);
   U46 : AOI21_X1 port map( B1 => n188, B2 => n354, A => n145, ZN => n186);
   U47 : INV_X1 port map( A => n122, ZN => n354);
   U48 : AOI21_X1 port map( B1 => n182, B2 => n350, A => n147, ZN => n180);
   U49 : INV_X1 port map( A => n112, ZN => n350);
   U50 : AOI21_X1 port map( B1 => n183, B2 => n116, A => n184, ZN => n182);
   U51 : AOI21_X1 port map( B1 => n185, B2 => n115, A => n351, ZN => n183);
   U52 : AOI21_X1 port map( B1 => n177, B2 => n106, A => n178, ZN => n176);
   U53 : AOI21_X1 port map( B1 => n179, B2 => n105, A => n347, ZN => n177);
   U54 : INV_X1 port map( A => n107, ZN => n347);
   U55 : AOI21_X1 port map( B1 => n180, B2 => n348, A => n181, ZN => n179);
   U56 : AOI21_X1 port map( B1 => n174, B2 => n344, A => n175, ZN => n173);
   U57 : INV_X1 port map( A => n101, ZN => n344);
   U58 : AOI21_X1 port map( B1 => n176, B2 => n346, A => n149, ZN => n174);
   U59 : INV_X1 port map( A => n102, ZN => n346);
   U60 : AOI21_X1 port map( B1 => n170, B2 => n342, A => n151, ZN => n168);
   U61 : INV_X1 port map( A => n92, ZN => n342);
   U62 : AOI21_X1 port map( B1 => n171, B2 => n96, A => n172, ZN => n170);
   U63 : AOI21_X1 port map( B1 => n173, B2 => n95, A => n343, ZN => n171);
   U64 : AOI21_X1 port map( B1 => n165, B2 => n86, A => n166, ZN => n164);
   U65 : AOI21_X1 port map( B1 => n167, B2 => n85, A => n339, ZN => n165);
   U66 : INV_X1 port map( A => n87, ZN => n339);
   U67 : AOI21_X1 port map( B1 => n168, B2 => n340, A => n169, ZN => n167);
   U68 : AOI21_X1 port map( B1 => n162, B2 => n336, A => n163, ZN => n161);
   U69 : INV_X1 port map( A => n81, ZN => n336);
   U70 : AOI21_X1 port map( B1 => n164, B2 => n338, A => n153, ZN => n162);
   U71 : INV_X1 port map( A => n82, ZN => n338);
   U72 : AOI21_X1 port map( B1 => n158, B2 => n334, A => n155, ZN => n157);
   U73 : INV_X1 port map( A => n72, ZN => n334);
   U74 : AOI21_X1 port map( B1 => n159, B2 => n76, A => n160, ZN => n158);
   U75 : AOI21_X1 port map( B1 => n161, B2 => n75, A => n335, ZN => n159);
   U76 : NOR2_X1 port map( A1 => n196, A2 => n142, ZN => n135);
   U77 : NOR2_X1 port map( A1 => n154, A2 => n155, ZN => n70);
   U78 : NAND2_X1 port map( A1 => n357, A2 => n128, ZN => n131);
   U79 : INV_X1 port map( A => n193, ZN => n357);
   U80 : NAND2_X1 port map( A1 => n353, A2 => n118, ZN => n121);
   U81 : INV_X1 port map( A => n187, ZN => n353);
   U82 : NAND2_X1 port map( A1 => n349, A2 => n108, ZN => n111);
   U83 : INV_X1 port map( A => n181, ZN => n349);
   U84 : NAND2_X1 port map( A1 => n345, A2 => n98, ZN => n101);
   U85 : INV_X1 port map( A => n175, ZN => n345);
   U88 : NAND2_X1 port map( A1 => n341, A2 => n88, ZN => n91);
   U89 : INV_X1 port map( A => n169, ZN => n341);
   U90 : NAND2_X1 port map( A1 => n337, A2 => n78, ZN => n81);
   U91 : INV_X1 port map( A => n163, ZN => n337);
   U92 : INV_X1 port map( A => n117, ZN => n351);
   U93 : INV_X1 port map( A => n97, ZN => n343);
   U94 : INV_X1 port map( A => n77, ZN => n335);
   U95 : INV_X1 port map( A => n136, ZN => n359);
   U96 : INV_X1 port map( A => B(0), ZN => n394);
   U97 : INV_X1 port map( A => B(2), ZN => n393);
   U98 : INV_X1 port map( A => B(3), ZN => n392);
   U99 : INV_X1 port map( A => B(4), ZN => n391);
   U100 : OAI21_X1 port map( B1 => n362, B2 => n141, A => B(1), ZN => n139);
   U102 : NOR2_X1 port map( A1 => n393, A2 => A(2), ZN => n198);
   U103 : NOR2_X1 port map( A1 => n391, A2 => A(4), ZN => n196);
   U104 : NOR2_X1 port map( A1 => n390, A2 => A(5), ZN => n132);
   U105 : NOR2_X1 port map( A1 => n386, A2 => A(9), ZN => n122);
   U106 : NOR2_X1 port map( A1 => n382, A2 => A(13), ZN => n112);
   U107 : NOR2_X1 port map( A1 => n378, A2 => A(17), ZN => n102);
   U108 : NOR2_X1 port map( A1 => n374, A2 => A(21), ZN => n92);
   U109 : NOR2_X1 port map( A1 => n370, A2 => A(25), ZN => n82);
   U110 : NOR2_X1 port map( A1 => n387, A2 => A(8), ZN => n190);
   U111 : NOR2_X1 port map( A1 => n383, A2 => A(12), ZN => n184);
   U112 : NOR2_X1 port map( A1 => n379, A2 => A(16), ZN => n178);
   U113 : NOR2_X1 port map( A1 => n375, A2 => A(20), ZN => n172);
   U114 : NOR2_X1 port map( A1 => n371, A2 => A(24), ZN => n166);
   U115 : NOR2_X1 port map( A1 => n367, A2 => A(28), ZN => n160);
   U116 : NOR2_X1 port map( A1 => n389, A2 => A(6), ZN => n193);
   U117 : NOR2_X1 port map( A1 => n385, A2 => A(10), ZN => n187);
   U118 : NOR2_X1 port map( A1 => n381, A2 => A(14), ZN => n181);
   U119 : NOR2_X1 port map( A1 => n377, A2 => A(18), ZN => n175);
   U120 : NOR2_X1 port map( A1 => n373, A2 => A(22), ZN => n169);
   U121 : NOR2_X1 port map( A1 => n369, A2 => A(26), ZN => n163);
   U122 : NOR2_X1 port map( A1 => n366, A2 => A(29), ZN => n72);
   U123 : NOR2_X1 port map( A1 => n364, A2 => A(31), ZN => n66);
   U124 : NOR2_X1 port map( A1 => n394, A2 => A(0), ZN => n201);
   U125 : AOI21_X1 port map( B1 => n361, B2 => n140, A => n198, ZN => n197);
   U126 : INV_X1 port map( A => n199, ZN => n361);
   U127 : OAI22_X1 port map( A1 => n200, A2 => B(1), B1 => n362, B2 => n201, ZN
                           => n199);
   U128 : AND2_X1 port map( A1 => n201, A2 => n362, ZN => n200);
   U129 : INV_X1 port map( A => n202, ZN => GT);
   U130 : AOI21_X1 port map( B1 => n65, B2 => n332, A => n66, ZN => n202);
   U131 : NAND2_X1 port map( A1 => A(0), A2 => n394, ZN => n141);
   U132 : NAND2_X1 port map( A1 => A(31), A2 => n364, ZN => n65);
   U133 : INV_X1 port map( A => A(1), ZN => n362);
   U134 : NAND2_X1 port map( A1 => A(6), A2 => n389, ZN => n128);
   U135 : NAND2_X1 port map( A1 => A(10), A2 => n385, ZN => n118);
   U136 : NAND2_X1 port map( A1 => A(14), A2 => n381, ZN => n108);
   U137 : NAND2_X1 port map( A1 => A(18), A2 => n377, ZN => n98);
   U138 : NAND2_X1 port map( A1 => A(22), A2 => n373, ZN => n88);
   U139 : NAND2_X1 port map( A1 => A(26), A2 => n369, ZN => n78);
   U140 : NAND2_X1 port map( A1 => A(7), A2 => n388, ZN => n127);
   U141 : NAND2_X1 port map( A1 => A(11), A2 => n384, ZN => n117);
   U142 : NAND2_X1 port map( A1 => A(15), A2 => n380, ZN => n107);
   U143 : NAND2_X1 port map( A1 => A(19), A2 => n376, ZN => n97);
   U144 : NAND2_X1 port map( A1 => A(23), A2 => n372, ZN => n87);
   U145 : NAND2_X1 port map( A1 => A(27), A2 => n368, ZN => n77);
   U146 : OAI211_X1 port map( C1 => A(1), C2 => n363, A => n139, B => n140, ZN 
                           => n138);
   U147 : INV_X1 port map( A => n141, ZN => n363);
   U148 : NAND2_X1 port map( A1 => A(2), A2 => n393, ZN => n137);
   U149 : NAND2_X1 port map( A1 => A(3), A2 => n392, ZN => n136);
   U150 : INV_X1 port map( A => A(30), ZN => n333);
   U151 : INV_X1 port map( A => B(6), ZN => n389);
   U152 : INV_X1 port map( A => B(10), ZN => n385);
   U153 : INV_X1 port map( A => B(14), ZN => n381);
   U154 : INV_X1 port map( A => B(18), ZN => n377);
   U155 : INV_X1 port map( A => B(22), ZN => n373);
   U156 : INV_X1 port map( A => B(26), ZN => n369);
   U157 : INV_X1 port map( A => B(31), ZN => n364);
   U158 : INV_X1 port map( A => B(7), ZN => n388);
   U159 : INV_X1 port map( A => B(11), ZN => n384);
   U160 : INV_X1 port map( A => B(15), ZN => n380);
   U161 : INV_X1 port map( A => B(19), ZN => n376);
   U162 : INV_X1 port map( A => B(23), ZN => n372);
   U163 : INV_X1 port map( A => B(27), ZN => n368);
   U164 : AND2_X1 port map( A1 => A(4), A2 => n391, ZN => n142);
   U165 : AND2_X1 port map( A1 => A(8), A2 => n387, ZN => n144);
   U166 : AND2_X1 port map( A1 => A(12), A2 => n383, ZN => n146);
   U167 : AND2_X1 port map( A1 => A(16), A2 => n379, ZN => n148);
   U168 : AND2_X1 port map( A1 => A(20), A2 => n375, ZN => n150);
   U169 : AND2_X1 port map( A1 => A(24), A2 => n371, ZN => n152);
   U170 : AND2_X1 port map( A1 => A(28), A2 => n367, ZN => n154);
   U171 : INV_X1 port map( A => B(5), ZN => n390);
   U172 : INV_X1 port map( A => B(9), ZN => n386);
   U173 : INV_X1 port map( A => B(13), ZN => n382);
   U174 : INV_X1 port map( A => B(17), ZN => n378);
   U175 : INV_X1 port map( A => B(21), ZN => n374);
   U176 : INV_X1 port map( A => B(25), ZN => n370);
   U177 : INV_X1 port map( A => B(29), ZN => n366);
   U178 : AND2_X1 port map( A1 => A(5), A2 => n390, ZN => n143);
   U179 : AND2_X1 port map( A1 => A(9), A2 => n386, ZN => n145);
   U180 : AND2_X1 port map( A1 => A(13), A2 => n382, ZN => n147);
   U181 : AND2_X1 port map( A1 => A(17), A2 => n378, ZN => n149);
   U182 : AND2_X1 port map( A1 => A(21), A2 => n374, ZN => n151);
   U183 : AND2_X1 port map( A1 => A(25), A2 => n370, ZN => n153);
   U184 : AND2_X1 port map( A1 => A(29), A2 => n366, ZN => n155);
   U185 : INV_X1 port map( A => B(8), ZN => n387);
   U186 : INV_X1 port map( A => B(12), ZN => n383);
   U187 : INV_X1 port map( A => B(16), ZN => n379);
   U188 : INV_X1 port map( A => B(20), ZN => n375);
   U189 : INV_X1 port map( A => B(24), ZN => n371);
   U190 : INV_X1 port map( A => B(28), ZN => n367);
   U191 : OAI21_X1 port map( B1 => n66, B2 => n156, A => n65, ZN => LT);
   U192 : AOI22_X1 port map( A1 => B(30), A2 => n333, B1 => n157, B2 => n69, ZN
                           => n156);
   U193 : OR2_X1 port map( A1 => n388, A2 => A(7), ZN => n125);
   U194 : OR2_X1 port map( A1 => n384, A2 => A(11), ZN => n115);
   U195 : OR2_X1 port map( A1 => n380, A2 => A(15), ZN => n105);
   U196 : OR2_X1 port map( A1 => n376, A2 => A(19), ZN => n95);
   U197 : OR2_X1 port map( A1 => n372, A2 => A(23), ZN => n85);
   U198 : OR2_X1 port map( A1 => n368, A2 => A(27), ZN => n75);
   U199 : OR2_X1 port map( A1 => n392, A2 => A(3), ZN => n134);
   U200 : INV_X1 port map( A => n67, ZN => n332);
   U201 : AOI22_X1 port map( A1 => A(30), A2 => n365, B1 => n68, B2 => n69, ZN 
                           => n67);
   U202 : INV_X1 port map( A => B(30), ZN => n365);
   U203 : AOI21_X1 port map( B1 => n70, B2 => n71, A => n72, ZN => n68);

end SYN_rpl;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity SUM_GENERATOR_N32_NB8 is

   port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic_vector (7
         downto 0);  S : out std_logic_vector (31 downto 0));

end SUM_GENERATOR_N32_NB8;

architecture SYN_STRUCTURAL of SUM_GENERATOR_N32_NB8 is

   component CSB_N4_1
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_2
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_3
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_4
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_5
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_6
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_7
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;
   
   component CSB_N4_0
      port( A, B : in std_logic_vector (3 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (3 downto 0));
   end component;

begin
   
   CSBI_1 : CSB_N4_0 port map( A(3) => A(3), A(2) => A(2), A(1) => A(1), A(0) 
                           => A(0), B(3) => B(3), B(2) => B(2), B(1) => B(1), 
                           B(0) => B(0), Ci => Ci(0), S(3) => S(3), S(2) => 
                           S(2), S(1) => S(1), S(0) => S(0));
   CSBI_2 : CSB_N4_7 port map( A(3) => A(7), A(2) => A(6), A(1) => A(5), A(0) 
                           => A(4), B(3) => B(7), B(2) => B(6), B(1) => B(5), 
                           B(0) => B(4), Ci => Ci(1), S(3) => S(7), S(2) => 
                           S(6), S(1) => S(5), S(0) => S(4));
   CSBI_3 : CSB_N4_6 port map( A(3) => A(11), A(2) => A(10), A(1) => A(9), A(0)
                           => A(8), B(3) => B(11), B(2) => B(10), B(1) => B(9),
                           B(0) => B(8), Ci => Ci(2), S(3) => S(11), S(2) => 
                           S(10), S(1) => S(9), S(0) => S(8));
   CSBI_4 : CSB_N4_5 port map( A(3) => A(15), A(2) => A(14), A(1) => A(13), 
                           A(0) => A(12), B(3) => B(15), B(2) => B(14), B(1) =>
                           B(13), B(0) => B(12), Ci => Ci(3), S(3) => S(15), 
                           S(2) => S(14), S(1) => S(13), S(0) => S(12));
   CSBI_5 : CSB_N4_4 port map( A(3) => A(19), A(2) => A(18), A(1) => A(17), 
                           A(0) => A(16), B(3) => B(19), B(2) => B(18), B(1) =>
                           B(17), B(0) => B(16), Ci => Ci(4), S(3) => S(19), 
                           S(2) => S(18), S(1) => S(17), S(0) => S(16));
   CSBI_6 : CSB_N4_3 port map( A(3) => A(23), A(2) => A(22), A(1) => A(21), 
                           A(0) => A(20), B(3) => B(23), B(2) => B(22), B(1) =>
                           B(21), B(0) => B(20), Ci => Ci(5), S(3) => S(23), 
                           S(2) => S(22), S(1) => S(21), S(0) => S(20));
   CSBI_7 : CSB_N4_2 port map( A(3) => A(27), A(2) => A(26), A(1) => A(25), 
                           A(0) => A(24), B(3) => B(27), B(2) => B(26), B(1) =>
                           B(25), B(0) => B(24), Ci => Ci(6), S(3) => S(27), 
                           S(2) => S(26), S(1) => S(25), S(0) => S(24));
   CSBI_8 : CSB_N4_1 port map( A(3) => A(31), A(2) => A(30), A(1) => A(29), 
                           A(0) => A(28), B(3) => B(31), B(2) => B(30), B(1) =>
                           B(29), B(0) => B(28), Ci => Ci(7), S(3) => S(31), 
                           S(2) => S(30), S(1) => S(29), S(0) => S(28));

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity CARRY_GENERATOR_N32_NB8 is

   port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic;  Co : 
         out std_logic_vector (7 downto 0));

end CARRY_GENERATOR_N32_NB8;

architecture SYN_STRUCTURAL of CARRY_GENERATOR_N32_NB8 is

   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component PG_BLOCK_1
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_1
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_2
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_2
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_3
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_3
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_4
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_4
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_5
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_6
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_7
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_5
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_8
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_6
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_9
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_10
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_11
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_12
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_7
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_13
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_14
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_15
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_16
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_17
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_18
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_19
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_8
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_BLOCK_20
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_21
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_22
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_23
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_24
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_25
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_26
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_27
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_28
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_29
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_30
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_31
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_32
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_33
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component PG_BLOCK_0
      port( Gik, Gkj, Pik, Pkj : in std_logic;  Gij, Pij : out std_logic);
   end component;
   
   component GENERATE_BLOCK_0
      port( Gik, Gkj, Pik : in std_logic;  Gij : out std_logic);
   end component;
   
   component PG_ROW_N32
      port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic;  P, G
            : out std_logic_vector (31 downto 0));
   end component;
   
   signal Co_7_port, Co_6_port, Co_5_port, Co_4_port, Co_3_port, Co_2_port, 
      Co_1_port, Co_0_port, G_0_31_port, G_0_30_port, G_0_29_port, G_0_28_port,
      G_0_27_port, G_0_26_port, G_0_25_port, G_0_24_port, G_0_23_port, 
      G_0_22_port, G_0_21_port, G_0_20_port, G_0_19_port, G_0_18_port, 
      G_0_17_port, G_0_16_port, G_0_15_port, G_0_14_port, G_0_13_port, 
      G_0_12_port, G_0_11_port, G_0_10_port, G_0_9_port, G_0_8_port, G_0_7_port
      , G_0_6_port, G_0_5_port, G_0_4_port, G_0_3_port, G_0_2_port, G_0_1_port,
      G_0_0_port, P_0_31_port, P_0_30_port, P_0_29_port, P_0_28_port, 
      P_0_27_port, P_0_26_port, P_0_25_port, P_0_24_port, P_0_23_port, 
      P_0_22_port, P_0_21_port, P_0_20_port, P_0_19_port, P_0_18_port, 
      P_0_17_port, P_0_16_port, P_0_15_port, P_0_14_port, P_0_13_port, 
      P_0_12_port, P_0_11_port, P_0_10_port, P_0_9_port, P_0_8_port, P_0_7_port
      , P_0_6_port, P_0_5_port, P_0_4_port, P_0_3_port, P_0_2_port, P_0_1_port,
      n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, P_5_15_port,
      P_4_7_port, P_4_31_port, P_4_27_port, P_4_23_port, P_3_31_port, 
      P_3_27_port, P_3_19_port, P_3_15_port, P_3_11_port, P_2_7_port, 
      P_2_31_port, P_2_23_port, P_2_15_port, P_1_9_port, P_1_7_port, P_1_5_port
      , P_1_3_port, P_1_31_port, P_1_29_port, P_1_27_port, P_1_25_port, 
      P_1_23_port, P_1_21_port, P_1_19_port, P_1_17_port, P_1_15_port, 
      P_1_13_port, P_1_11_port, G_4_31_port, G_4_27_port, G_4_23_port, 
      G_3_31_port, G_3_27_port, G_3_19_port, G_3_15_port, G_3_11_port, 
      G_2_7_port, G_2_31_port, G_2_23_port, G_2_15_port, G_1_9_port, G_1_7_port
      , G_1_5_port, G_1_3_port, G_1_31_port, G_1_29_port, G_1_27_port, 
      G_1_25_port, G_1_23_port, G_1_21_port, G_1_1_port, G_1_19_port, 
      G_1_17_port, G_1_15_port, G_1_13_port, G_1_11_port, n15, n_1174, n_1175, 
      n_1176, n_1177, n_1178, n_1179 : std_logic;

begin
   Co <= ( Co_7_port, Co_6_port, Co_5_port, Co_4_port, Co_3_port, Co_2_port, 
      Co_1_port, Co_0_port );
   
   PG_ROW_INSTANCE : PG_ROW_N32 port map( A(31) => A(31), A(30) => A(30), A(29)
                           => A(29), A(28) => A(28), A(27) => A(27), A(26) => 
                           A(26), A(25) => A(25), A(24) => A(24), A(23) => 
                           A(23), A(22) => A(22), A(21) => A(21), A(20) => 
                           A(20), A(19) => A(19), A(18) => A(18), A(17) => 
                           A(17), A(16) => A(16), A(15) => A(15), A(14) => 
                           A(14), A(13) => A(13), A(12) => A(12), A(11) => 
                           A(11), A(10) => A(10), A(9) => A(9), A(8) => A(8), 
                           A(7) => A(7), A(6) => A(6), A(5) => A(5), A(4) => 
                           A(4), A(3) => A(3), A(2) => A(2), A(1) => A(1), A(0)
                           => A(0), B(31) => B(31), B(30) => B(30), B(29) => 
                           B(29), B(28) => B(28), B(27) => B(27), B(26) => 
                           B(26), B(25) => B(25), B(24) => B(24), B(23) => 
                           B(23), B(22) => B(22), B(21) => B(21), B(20) => 
                           B(20), B(19) => B(19), B(18) => B(18), B(17) => 
                           B(17), B(16) => B(16), B(15) => B(15), B(14) => 
                           B(14), B(13) => B(13), B(12) => B(12), B(11) => 
                           B(11), B(10) => B(10), B(9) => B(9), B(8) => B(8), 
                           B(7) => B(7), B(6) => B(6), B(5) => B(5), B(4) => 
                           B(4), B(3) => B(3), B(2) => B(2), B(1) => B(1), B(0)
                           => B(0), Ci => Ci, P(31) => P_0_31_port, P(30) => 
                           P_0_30_port, P(29) => P_0_29_port, P(28) => 
                           P_0_28_port, P(27) => P_0_27_port, P(26) => 
                           P_0_26_port, P(25) => P_0_25_port, P(24) => 
                           P_0_24_port, P(23) => P_0_23_port, P(22) => 
                           P_0_22_port, P(21) => P_0_21_port, P(20) => 
                           P_0_20_port, P(19) => P_0_19_port, P(18) => 
                           P_0_18_port, P(17) => P_0_17_port, P(16) => 
                           P_0_16_port, P(15) => P_0_15_port, P(14) => 
                           P_0_14_port, P(13) => P_0_13_port, P(12) => 
                           P_0_12_port, P(11) => P_0_11_port, P(10) => 
                           P_0_10_port, P(9) => P_0_9_port, P(8) => P_0_8_port,
                           P(7) => P_0_7_port, P(6) => P_0_6_port, P(5) => 
                           P_0_5_port, P(4) => P_0_4_port, P(3) => P_0_3_port, 
                           P(2) => P_0_2_port, P(1) => P_0_1_port, P(0) => 
                           n_1174, G(31) => G_0_31_port, G(30) => G_0_30_port, 
                           G(29) => G_0_29_port, G(28) => G_0_28_port, G(27) =>
                           G_0_27_port, G(26) => G_0_26_port, G(25) => 
                           G_0_25_port, G(24) => G_0_24_port, G(23) => 
                           G_0_23_port, G(22) => G_0_22_port, G(21) => 
                           G_0_21_port, G(20) => G_0_20_port, G(19) => 
                           G_0_19_port, G(18) => G_0_18_port, G(17) => 
                           G_0_17_port, G(16) => G_0_16_port, G(15) => 
                           G_0_15_port, G(14) => G_0_14_port, G(13) => 
                           G_0_13_port, G(12) => G_0_12_port, G(11) => 
                           G_0_11_port, G(10) => G_0_10_port, G(9) => 
                           G_0_9_port, G(8) => G_0_8_port, G(7) => G_0_7_port, 
                           G(6) => G_0_6_port, G(5) => G_0_5_port, G(4) => 
                           G_0_4_port, G(3) => G_0_3_port, G(2) => G_0_2_port, 
                           G(1) => G_0_1_port, G(0) => G_0_0_port);
   G_BLOCK_INSTANCE_1_1 : GENERATE_BLOCK_0 port map( Gik => G_0_1_port, Gkj => 
                           G_0_0_port, Pik => P_0_1_port, Gij => G_1_1_port);
   PG_BLOCK_REG_INSTANCE_1_3 : PG_BLOCK_0 port map( Gik => G_0_3_port, Gkj => 
                           G_0_2_port, Pik => P_0_3_port, Pkj => P_0_2_port, 
                           Gij => G_1_3_port, Pij => P_1_3_port);
   PG_BLOCK_REG_INSTANCE_1_5 : PG_BLOCK_33 port map( Gik => G_0_5_port, Gkj => 
                           G_0_4_port, Pik => P_0_5_port, Pkj => P_0_4_port, 
                           Gij => G_1_5_port, Pij => P_1_5_port);
   PG_BLOCK_REG_INSTANCE_1_7 : PG_BLOCK_32 port map( Gik => G_0_7_port, Gkj => 
                           G_0_6_port, Pik => P_0_7_port, Pkj => P_0_6_port, 
                           Gij => G_1_7_port, Pij => P_1_7_port);
   PG_BLOCK_REG_INSTANCE_1_9 : PG_BLOCK_31 port map( Gik => G_0_9_port, Gkj => 
                           G_0_8_port, Pik => P_0_9_port, Pkj => P_0_8_port, 
                           Gij => G_1_9_port, Pij => P_1_9_port);
   PG_BLOCK_REG_INSTANCE_1_11 : PG_BLOCK_30 port map( Gik => G_0_11_port, Gkj 
                           => G_0_10_port, Pik => P_0_11_port, Pkj => 
                           P_0_10_port, Gij => G_1_11_port, Pij => P_1_11_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_13 : PG_BLOCK_29 port map( Gik => G_0_13_port, Gkj 
                           => G_0_12_port, Pik => P_0_13_port, Pkj => 
                           P_0_12_port, Gij => G_1_13_port, Pij => P_1_13_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_15 : PG_BLOCK_28 port map( Gik => G_0_15_port, Gkj 
                           => G_0_14_port, Pik => P_0_15_port, Pkj => 
                           P_0_14_port, Gij => G_1_15_port, Pij => P_1_15_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_17 : PG_BLOCK_27 port map( Gik => G_0_17_port, Gkj 
                           => G_0_16_port, Pik => P_0_17_port, Pkj => 
                           P_0_16_port, Gij => G_1_17_port, Pij => P_1_17_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_19 : PG_BLOCK_26 port map( Gik => G_0_19_port, Gkj 
                           => G_0_18_port, Pik => P_0_19_port, Pkj => 
                           P_0_18_port, Gij => G_1_19_port, Pij => P_1_19_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_21 : PG_BLOCK_25 port map( Gik => G_0_21_port, Gkj 
                           => G_0_20_port, Pik => P_0_21_port, Pkj => 
                           P_0_20_port, Gij => G_1_21_port, Pij => P_1_21_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_23 : PG_BLOCK_24 port map( Gik => G_0_23_port, Gkj 
                           => G_0_22_port, Pik => P_0_23_port, Pkj => 
                           P_0_22_port, Gij => G_1_23_port, Pij => P_1_23_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_25 : PG_BLOCK_23 port map( Gik => G_0_25_port, Gkj 
                           => G_0_24_port, Pik => P_0_25_port, Pkj => 
                           P_0_24_port, Gij => G_1_25_port, Pij => P_1_25_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_27 : PG_BLOCK_22 port map( Gik => G_0_27_port, Gkj 
                           => G_0_26_port, Pik => P_0_27_port, Pkj => 
                           P_0_26_port, Gij => G_1_27_port, Pij => P_1_27_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_29 : PG_BLOCK_21 port map( Gik => G_0_29_port, Gkj 
                           => G_0_28_port, Pik => P_0_29_port, Pkj => 
                           P_0_28_port, Gij => G_1_29_port, Pij => P_1_29_port)
                           ;
   PG_BLOCK_REG_INSTANCE_1_31 : PG_BLOCK_20 port map( Gik => G_0_31_port, Gkj 
                           => G_0_30_port, Pik => P_0_31_port, Pkj => 
                           P_0_30_port, Gij => G_1_31_port, Pij => P_1_31_port)
                           ;
   G_BLOCK_INSTANCE_2_3 : GENERATE_BLOCK_8 port map( Gik => G_1_3_port, Gkj => 
                           G_1_1_port, Pik => P_1_3_port, Gij => Co_0_port);
   PG_BLOCK_REG_INSTANCE_2_7 : PG_BLOCK_19 port map( Gik => G_1_7_port, Gkj => 
                           G_1_5_port, Pik => P_1_7_port, Pkj => P_1_5_port, 
                           Gij => G_2_7_port, Pij => P_2_7_port);
   PG_BLOCK_REG_INSTANCE_2_11 : PG_BLOCK_18 port map( Gik => G_1_11_port, Gkj 
                           => G_1_9_port, Pik => P_1_11_port, Pkj => P_1_9_port
                           , Gij => G_3_11_port, Pij => P_3_11_port);
   PG_BLOCK_REG_INSTANCE_2_15 : PG_BLOCK_17 port map( Gik => G_1_15_port, Gkj 
                           => G_1_13_port, Pik => P_1_15_port, Pkj => 
                           P_1_13_port, Gij => G_2_15_port, Pij => P_2_15_port)
                           ;
   PG_BLOCK_REG_INSTANCE_2_19 : PG_BLOCK_16 port map( Gik => G_1_19_port, Gkj 
                           => G_1_17_port, Pik => P_1_19_port, Pkj => 
                           P_1_17_port, Gij => G_3_19_port, Pij => P_3_19_port)
                           ;
   PG_BLOCK_REG_INSTANCE_2_23 : PG_BLOCK_15 port map( Gik => G_1_23_port, Gkj 
                           => G_1_21_port, Pik => P_1_23_port, Pkj => 
                           P_1_21_port, Gij => G_2_23_port, Pij => P_2_23_port)
                           ;
   PG_BLOCK_REG_INSTANCE_2_27 : PG_BLOCK_14 port map( Gik => G_1_27_port, Gkj 
                           => G_1_25_port, Pik => P_1_27_port, Pkj => 
                           P_1_25_port, Gij => G_3_27_port, Pij => P_3_27_port)
                           ;
   PG_BLOCK_REG_INSTANCE_2_31 : PG_BLOCK_13 port map( Gik => G_1_31_port, Gkj 
                           => G_1_29_port, Pik => P_1_31_port, Pkj => 
                           P_1_29_port, Gij => G_2_31_port, Pij => P_2_31_port)
                           ;
   G_BLOCK_INSTANCE_3_7 : GENERATE_BLOCK_7 port map( Gik => G_2_7_port, Gkj => 
                           Co_0_port, Pik => P_2_7_port, Gij => n1);
   PG_BLOCK_REG_INSTANCE_3_7 : PG_BLOCK_12 port map( Gik => G_2_7_port, Gkj => 
                           Co_0_port, Pik => P_2_7_port, Pkj => n15, Gij => n2,
                           Pij => P_4_7_port);
   PG_BLOCK_REG_INSTANCE_3_15 : PG_BLOCK_11 port map( Gik => G_2_15_port, Gkj 
                           => G_3_11_port, Pik => P_2_15_port, Pkj => 
                           P_3_11_port, Gij => G_3_15_port, Pij => P_3_15_port)
                           ;
   PG_BLOCK_REG_INSTANCE_3_23 : PG_BLOCK_10 port map( Gik => G_2_23_port, Gkj 
                           => G_3_19_port, Pik => P_2_23_port, Pkj => 
                           P_3_19_port, Gij => G_4_23_port, Pij => P_4_23_port)
                           ;
   PG_BLOCK_REG_INSTANCE_3_31 : PG_BLOCK_9 port map( Gik => G_2_31_port, Gkj =>
                           G_3_27_port, Pik => P_2_31_port, Pkj => P_3_27_port,
                           Gij => G_3_31_port, Pij => P_3_31_port);
   G_BLOCK_INSTANCE_4_11 : GENERATE_BLOCK_6 port map( Gik => G_3_11_port, Gkj 
                           => Co_1_port, Pik => P_3_11_port, Gij => n3);
   PG_BLOCK_REG_INSTANCE_4_11 : PG_BLOCK_8 port map( Gik => G_3_11_port, Gkj =>
                           Co_1_port, Pik => P_3_11_port, Pkj => P_4_7_port, 
                           Gij => n4, Pij => n_1175);
   G_BLOCK_INSTANCE_4_15 : GENERATE_BLOCK_5 port map( Gik => G_3_15_port, Gkj 
                           => Co_1_port, Pik => P_3_15_port, Gij => n5);
   PG_BLOCK_REG_INSTANCE_4_15 : PG_BLOCK_7 port map( Gik => G_3_15_port, Gkj =>
                           Co_1_port, Pik => P_3_15_port, Pkj => P_4_7_port, 
                           Gij => n6, Pij => P_5_15_port);
   PG_BLOCK_REG_INSTANCE_4_27 : PG_BLOCK_6 port map( Gik => G_3_27_port, Gkj =>
                           G_4_23_port, Pik => P_3_27_port, Pkj => P_4_23_port,
                           Gij => G_4_27_port, Pij => P_4_27_port);
   PG_BLOCK_REG_INSTANCE_4_31 : PG_BLOCK_5 port map( Gik => G_3_31_port, Gkj =>
                           G_4_23_port, Pik => P_3_31_port, Pkj => P_4_23_port,
                           Gij => G_4_31_port, Pij => P_4_31_port);
   G_BLOCK_INSTANCE_5_19 : GENERATE_BLOCK_4 port map( Gik => G_3_19_port, Gkj 
                           => Co_3_port, Pik => P_3_19_port, Gij => n7);
   PG_BLOCK_REG_INSTANCE_5_19 : PG_BLOCK_4 port map( Gik => G_3_19_port, Gkj =>
                           Co_3_port, Pik => P_3_19_port, Pkj => P_5_15_port, 
                           Gij => n8, Pij => n_1176);
   G_BLOCK_INSTANCE_5_23 : GENERATE_BLOCK_3 port map( Gik => G_4_23_port, Gkj 
                           => Co_3_port, Pik => P_4_23_port, Gij => n9);
   PG_BLOCK_REG_INSTANCE_5_23 : PG_BLOCK_3 port map( Gik => G_4_23_port, Gkj =>
                           Co_3_port, Pik => P_4_23_port, Pkj => P_5_15_port, 
                           Gij => n10, Pij => n_1177);
   G_BLOCK_INSTANCE_5_27 : GENERATE_BLOCK_2 port map( Gik => G_4_27_port, Gkj 
                           => Co_3_port, Pik => P_4_27_port, Gij => n11);
   PG_BLOCK_REG_INSTANCE_5_27 : PG_BLOCK_2 port map( Gik => G_4_27_port, Gkj =>
                           Co_3_port, Pik => P_4_27_port, Pkj => P_5_15_port, 
                           Gij => n12, Pij => n_1178);
   G_BLOCK_INSTANCE_5_31 : GENERATE_BLOCK_1 port map( Gik => G_4_31_port, Gkj 
                           => Co_3_port, Pik => P_4_31_port, Gij => n13);
   PG_BLOCK_REG_INSTANCE_5_31 : PG_BLOCK_1 port map( Gik => G_4_31_port, Gkj =>
                           Co_3_port, Pik => P_4_31_port, Pkj => P_5_15_port, 
                           Gij => n14, Pij => n_1179);
   U2 : AND2_X1 port map( A1 => n14, A2 => n13, ZN => Co_7_port);
   U3 : AND2_X1 port map( A1 => n12, A2 => n11, ZN => Co_6_port);
   U4 : AND2_X1 port map( A1 => n9, A2 => n10, ZN => Co_5_port);
   U5 : AND2_X1 port map( A1 => n8, A2 => n7, ZN => Co_4_port);
   U6 : AND2_X1 port map( A1 => n6, A2 => n5, ZN => Co_3_port);
   U7 : AND2_X1 port map( A1 => n4, A2 => n3, ZN => Co_2_port);
   U8 : AND2_X1 port map( A1 => n2, A2 => n1, ZN => Co_1_port);
   n15 <= '0';

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity ALU_N32_NB8_DW01_addsub_0 is

   port( A, B : in std_logic_vector (31 downto 0);  CI, ADD_SUB : in std_logic;
         SUM : out std_logic_vector (31 downto 0);  CO : out std_logic);

end ALU_N32_NB8_DW01_addsub_0;

architecture SYN_rpl of ALU_N32_NB8_DW01_addsub_0 is

   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component FA_X1
      port( A, B, CI : in std_logic;  CO, S : out std_logic);
   end component;
   
   signal carry_31_port, carry_30_port, carry_29_port, carry_28_port, 
      carry_27_port, carry_26_port, carry_25_port, carry_24_port, carry_23_port
      , carry_22_port, carry_21_port, carry_20_port, carry_19_port, 
      carry_18_port, carry_17_port, carry_16_port, carry_15_port, carry_14_port
      , carry_13_port, carry_12_port, carry_11_port, carry_10_port, 
      carry_9_port, carry_8_port, carry_7_port, carry_6_port, carry_5_port, 
      carry_4_port, carry_3_port, carry_2_port, carry_1_port, B_AS_31_port, 
      B_AS_30_port, B_AS_29_port, B_AS_28_port, B_AS_27_port, B_AS_26_port, 
      B_AS_25_port, B_AS_24_port, B_AS_23_port, B_AS_22_port, B_AS_21_port, 
      B_AS_20_port, B_AS_19_port, B_AS_18_port, B_AS_17_port, B_AS_16_port, 
      B_AS_15_port, B_AS_14_port, B_AS_13_port, B_AS_12_port, B_AS_11_port, 
      B_AS_10_port, B_AS_9_port, B_AS_8_port, B_AS_7_port, B_AS_6_port, 
      B_AS_5_port, B_AS_4_port, B_AS_3_port, B_AS_2_port, B_AS_1_port, 
      B_AS_0_port, n_1182 : std_logic;

begin
   
   U1_31 : FA_X1 port map( A => A(31), B => B_AS_31_port, CI => carry_31_port, 
                           CO => n_1182, S => SUM(31));
   U1_30 : FA_X1 port map( A => A(30), B => B_AS_30_port, CI => carry_30_port, 
                           CO => carry_31_port, S => SUM(30));
   U1_29 : FA_X1 port map( A => A(29), B => B_AS_29_port, CI => carry_29_port, 
                           CO => carry_30_port, S => SUM(29));
   U1_28 : FA_X1 port map( A => A(28), B => B_AS_28_port, CI => carry_28_port, 
                           CO => carry_29_port, S => SUM(28));
   U1_27 : FA_X1 port map( A => A(27), B => B_AS_27_port, CI => carry_27_port, 
                           CO => carry_28_port, S => SUM(27));
   U1_26 : FA_X1 port map( A => A(26), B => B_AS_26_port, CI => carry_26_port, 
                           CO => carry_27_port, S => SUM(26));
   U1_25 : FA_X1 port map( A => A(25), B => B_AS_25_port, CI => carry_25_port, 
                           CO => carry_26_port, S => SUM(25));
   U1_24 : FA_X1 port map( A => A(24), B => B_AS_24_port, CI => carry_24_port, 
                           CO => carry_25_port, S => SUM(24));
   U1_23 : FA_X1 port map( A => A(23), B => B_AS_23_port, CI => carry_23_port, 
                           CO => carry_24_port, S => SUM(23));
   U1_22 : FA_X1 port map( A => A(22), B => B_AS_22_port, CI => carry_22_port, 
                           CO => carry_23_port, S => SUM(22));
   U1_21 : FA_X1 port map( A => A(21), B => B_AS_21_port, CI => carry_21_port, 
                           CO => carry_22_port, S => SUM(21));
   U1_20 : FA_X1 port map( A => A(20), B => B_AS_20_port, CI => carry_20_port, 
                           CO => carry_21_port, S => SUM(20));
   U1_19 : FA_X1 port map( A => A(19), B => B_AS_19_port, CI => carry_19_port, 
                           CO => carry_20_port, S => SUM(19));
   U1_18 : FA_X1 port map( A => A(18), B => B_AS_18_port, CI => carry_18_port, 
                           CO => carry_19_port, S => SUM(18));
   U1_17 : FA_X1 port map( A => A(17), B => B_AS_17_port, CI => carry_17_port, 
                           CO => carry_18_port, S => SUM(17));
   U1_16 : FA_X1 port map( A => A(16), B => B_AS_16_port, CI => carry_16_port, 
                           CO => carry_17_port, S => SUM(16));
   U1_15 : FA_X1 port map( A => A(15), B => B_AS_15_port, CI => carry_15_port, 
                           CO => carry_16_port, S => SUM(15));
   U1_14 : FA_X1 port map( A => A(14), B => B_AS_14_port, CI => carry_14_port, 
                           CO => carry_15_port, S => SUM(14));
   U1_13 : FA_X1 port map( A => A(13), B => B_AS_13_port, CI => carry_13_port, 
                           CO => carry_14_port, S => SUM(13));
   U1_12 : FA_X1 port map( A => A(12), B => B_AS_12_port, CI => carry_12_port, 
                           CO => carry_13_port, S => SUM(12));
   U1_11 : FA_X1 port map( A => A(11), B => B_AS_11_port, CI => carry_11_port, 
                           CO => carry_12_port, S => SUM(11));
   U1_10 : FA_X1 port map( A => A(10), B => B_AS_10_port, CI => carry_10_port, 
                           CO => carry_11_port, S => SUM(10));
   U1_9 : FA_X1 port map( A => A(9), B => B_AS_9_port, CI => carry_9_port, CO 
                           => carry_10_port, S => SUM(9));
   U1_8 : FA_X1 port map( A => A(8), B => B_AS_8_port, CI => carry_8_port, CO 
                           => carry_9_port, S => SUM(8));
   U1_7 : FA_X1 port map( A => A(7), B => B_AS_7_port, CI => carry_7_port, CO 
                           => carry_8_port, S => SUM(7));
   U1_6 : FA_X1 port map( A => A(6), B => B_AS_6_port, CI => carry_6_port, CO 
                           => carry_7_port, S => SUM(6));
   U1_5 : FA_X1 port map( A => A(5), B => B_AS_5_port, CI => carry_5_port, CO 
                           => carry_6_port, S => SUM(5));
   U1_4 : FA_X1 port map( A => A(4), B => B_AS_4_port, CI => carry_4_port, CO 
                           => carry_5_port, S => SUM(4));
   U1_3 : FA_X1 port map( A => A(3), B => B_AS_3_port, CI => carry_3_port, CO 
                           => carry_4_port, S => SUM(3));
   U1_2 : FA_X1 port map( A => A(2), B => B_AS_2_port, CI => carry_2_port, CO 
                           => carry_3_port, S => SUM(2));
   U1_1 : FA_X1 port map( A => A(1), B => B_AS_1_port, CI => carry_1_port, CO 
                           => carry_2_port, S => SUM(1));
   U1_0 : FA_X1 port map( A => A(0), B => B_AS_0_port, CI => ADD_SUB, CO => 
                           carry_1_port, S => SUM(0));
   U1 : XOR2_X1 port map( A => B(9), B => ADD_SUB, Z => B_AS_9_port);
   U2 : XOR2_X1 port map( A => B(8), B => ADD_SUB, Z => B_AS_8_port);
   U3 : XOR2_X1 port map( A => B(7), B => ADD_SUB, Z => B_AS_7_port);
   U4 : XOR2_X1 port map( A => B(6), B => ADD_SUB, Z => B_AS_6_port);
   U5 : XOR2_X1 port map( A => B(5), B => ADD_SUB, Z => B_AS_5_port);
   U6 : XOR2_X1 port map( A => B(4), B => ADD_SUB, Z => B_AS_4_port);
   U7 : XOR2_X1 port map( A => B(3), B => ADD_SUB, Z => B_AS_3_port);
   U8 : XOR2_X1 port map( A => B(31), B => ADD_SUB, Z => B_AS_31_port);
   U9 : XOR2_X1 port map( A => B(30), B => ADD_SUB, Z => B_AS_30_port);
   U10 : XOR2_X1 port map( A => B(2), B => ADD_SUB, Z => B_AS_2_port);
   U11 : XOR2_X1 port map( A => B(29), B => ADD_SUB, Z => B_AS_29_port);
   U12 : XOR2_X1 port map( A => B(28), B => ADD_SUB, Z => B_AS_28_port);
   U13 : XOR2_X1 port map( A => B(27), B => ADD_SUB, Z => B_AS_27_port);
   U14 : XOR2_X1 port map( A => B(26), B => ADD_SUB, Z => B_AS_26_port);
   U15 : XOR2_X1 port map( A => B(25), B => ADD_SUB, Z => B_AS_25_port);
   U16 : XOR2_X1 port map( A => B(24), B => ADD_SUB, Z => B_AS_24_port);
   U17 : XOR2_X1 port map( A => B(23), B => ADD_SUB, Z => B_AS_23_port);
   U18 : XOR2_X1 port map( A => B(22), B => ADD_SUB, Z => B_AS_22_port);
   U19 : XOR2_X1 port map( A => B(21), B => ADD_SUB, Z => B_AS_21_port);
   U20 : XOR2_X1 port map( A => B(20), B => ADD_SUB, Z => B_AS_20_port);
   U21 : XOR2_X1 port map( A => B(1), B => ADD_SUB, Z => B_AS_1_port);
   U22 : XOR2_X1 port map( A => B(19), B => ADD_SUB, Z => B_AS_19_port);
   U23 : XOR2_X1 port map( A => B(18), B => ADD_SUB, Z => B_AS_18_port);
   U24 : XOR2_X1 port map( A => B(17), B => ADD_SUB, Z => B_AS_17_port);
   U25 : XOR2_X1 port map( A => B(16), B => ADD_SUB, Z => B_AS_16_port);
   U26 : XOR2_X1 port map( A => B(15), B => ADD_SUB, Z => B_AS_15_port);
   U27 : XOR2_X1 port map( A => B(14), B => ADD_SUB, Z => B_AS_14_port);
   U28 : XOR2_X1 port map( A => B(13), B => ADD_SUB, Z => B_AS_13_port);
   U29 : XOR2_X1 port map( A => B(12), B => ADD_SUB, Z => B_AS_12_port);
   U30 : XOR2_X1 port map( A => B(11), B => ADD_SUB, Z => B_AS_11_port);
   U31 : XOR2_X1 port map( A => B(10), B => ADD_SUB, Z => B_AS_10_port);
   U32 : XOR2_X1 port map( A => B(0), B => ADD_SUB, Z => B_AS_0_port);

end SYN_rpl;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity COMPARATOR_N32 is

   port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic_vector (3 
         downto 0);  Y : out std_logic_vector (31 downto 0));

end COMPARATOR_N32;

architecture SYN_BEHAVIORAL of COMPARATOR_N32 is

   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component MUX2_X1
      port( A, B, S : in std_logic;  Z : out std_logic);
   end component;
   
   component NOR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component COMPARATOR_N32_DW01_cmp6_1_DW01_cmp6_5
      port( A, B : in std_logic_vector (31 downto 0);  TC : in std_logic;  LT, 
            GT, EQ, LE, GE, NE : out std_logic);
   end component;
   
   component COMPARATOR_N32_DW01_cmp6_0_DW01_cmp6_4
      port( A, B : in std_logic_vector (31 downto 0);  TC : in std_logic;  LT, 
            GT, EQ, LE, GE, NE : out std_logic);
   end component;
   
   signal X_Logic0_port, Y_0_port, N46, N48, N49, N50, N51, n1, n2, n30, n31, 
      n32, n33, n34, n35, n36, n_1183, n_1184, n_1185, n_1186, n_1187, n_1188, 
      n_1189 : std_logic;

begin
   Y <= ( X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, 
      X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port
      , X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, 
      X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port
      , X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, 
      X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port
      , X_Logic0_port, X_Logic0_port, X_Logic0_port, X_Logic0_port, Y_0_port );
   
   X_Logic0_port <= '0';
   n1 <= '1';
   n2 <= '0';
   r91 : COMPARATOR_N32_DW01_cmp6_0_DW01_cmp6_4 port map( A(31) => A(31), A(30)
                           => A(30), A(29) => A(29), A(28) => A(28), A(27) => 
                           A(27), A(26) => A(26), A(25) => A(25), A(24) => 
                           A(24), A(23) => A(23), A(22) => A(22), A(21) => 
                           A(21), A(20) => A(20), A(19) => A(19), A(18) => 
                           A(18), A(17) => A(17), A(16) => A(16), A(15) => 
                           A(15), A(14) => A(14), A(13) => A(13), A(12) => 
                           A(12), A(11) => A(11), A(10) => A(10), A(9) => A(9),
                           A(8) => A(8), A(7) => A(7), A(6) => A(6), A(5) => 
                           A(5), A(4) => A(4), A(3) => A(3), A(2) => A(2), A(1)
                           => A(1), A(0) => A(0), B(31) => B(31), B(30) => 
                           B(30), B(29) => B(29), B(28) => B(28), B(27) => 
                           B(27), B(26) => B(26), B(25) => B(25), B(24) => 
                           B(24), B(23) => B(23), B(22) => B(22), B(21) => 
                           B(21), B(20) => B(20), B(19) => B(19), B(18) => 
                           B(18), B(17) => B(17), B(16) => B(16), B(15) => 
                           B(15), B(14) => B(14), B(13) => B(13), B(12) => 
                           B(12), B(11) => B(11), B(10) => B(10), B(9) => B(9),
                           B(8) => B(8), B(7) => B(7), B(6) => B(6), B(5) => 
                           B(5), B(4) => B(4), B(3) => B(3), B(2) => B(2), B(1)
                           => B(1), B(0) => B(0), TC => n1, LT => N48, GT => 
                           N50, EQ => n_1183, LE => n_1184, GE => n_1185, NE =>
                           n_1186);
   r90 : COMPARATOR_N32_DW01_cmp6_1_DW01_cmp6_5 port map( A(31) => A(31), A(30)
                           => A(30), A(29) => A(29), A(28) => A(28), A(27) => 
                           A(27), A(26) => A(26), A(25) => A(25), A(24) => 
                           A(24), A(23) => A(23), A(22) => A(22), A(21) => 
                           A(21), A(20) => A(20), A(19) => A(19), A(18) => 
                           A(18), A(17) => A(17), A(16) => A(16), A(15) => 
                           A(15), A(14) => A(14), A(13) => A(13), A(12) => 
                           A(12), A(11) => A(11), A(10) => A(10), A(9) => A(9),
                           A(8) => A(8), A(7) => A(7), A(6) => A(6), A(5) => 
                           A(5), A(4) => A(4), A(3) => A(3), A(2) => A(2), A(1)
                           => A(1), A(0) => A(0), B(31) => B(31), B(30) => 
                           B(30), B(29) => B(29), B(28) => B(28), B(27) => 
                           B(27), B(26) => B(26), B(25) => B(25), B(24) => 
                           B(24), B(23) => B(23), B(22) => B(22), B(21) => 
                           B(21), B(20) => B(20), B(19) => B(19), B(18) => 
                           B(18), B(17) => B(17), B(16) => B(16), B(15) => 
                           B(15), B(14) => B(14), B(13) => B(13), B(12) => 
                           B(12), B(11) => B(11), B(10) => B(10), B(9) => B(9),
                           B(8) => B(8), B(7) => B(7), B(6) => B(6), B(5) => 
                           B(5), B(4) => B(4), B(3) => B(3), B(2) => B(2), B(1)
                           => B(1), B(0) => B(0), TC => n2, LT => N49, GT => 
                           N51, EQ => N46, LE => n_1187, GE => n_1188, NE => 
                           n_1189);
   U2 : MUX2_X1 port map( A => n30, B => n31, S => S(3), Z => Y_0_port);
   U3 : NOR3_X1 port map( A1 => n32, A2 => S(2), A3 => S(1), ZN => n31);
   U6 : MUX2_X1 port map( A => n33, B => n34, S => S(2), Z => n30);
   U7 : XOR2_X1 port map( A => S(1), B => n35, Z => n34);
   U8 : MUX2_X1 port map( A => N50, B => N51, S => S(0), Z => n35);
   U9 : MUX2_X1 port map( A => n36, B => n32, S => S(1), Z => n33);
   U10 : MUX2_X1 port map( A => N48, B => N49, S => S(0), Z => n32);
   U11 : XOR2_X1 port map( A => S(0), B => N46, Z => n36);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity LOGIC_N32 is

   port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic_vector (1 
         downto 0);  Y : out std_logic_vector (31 downto 0));

end LOGIC_N32;

architecture SYN_BEHAVIORAL of LOGIC_N32 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component MUX2_X1
      port( A, B, S : in std_logic;  Z : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X4
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   signal n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, 
      n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358, 
      n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, 
      n371, n372, n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, 
      n383, n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394, 
      n395, n396, n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, 
      n407, n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418, 
      n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, 
      n431, n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442, 
      n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453, n454, 
      n455, n456, n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, 
      n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, 
      n479, n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, 
      n491, n492, n493, n494, n495, n496, n497, n498, n499, n500 : std_logic;

begin
   
   U2 : NAND2_X1 port map( A1 => S(0), A2 => n344, ZN => n336);
   U3 : OR2_X1 port map( A1 => n344, A2 => S(0), ZN => n337);
   U4 : INV_X4 port map( A => n337, ZN => n338);
   U5 : INV_X4 port map( A => n336, ZN => n339);
   U6 : OAI21_X1 port map( B1 => n340, B2 => n341, A => n342, ZN => Y(9));
   U7 : OAI21_X1 port map( B1 => n339, B2 => n343, A => B(9), ZN => n342);
   U8 : MUX2_X1 port map( A => n344, B => n338, S => n341, Z => n343);
   U9 : INV_X1 port map( A => A(9), ZN => n341);
   U10 : AOI21_X1 port map( B1 => n338, B2 => n345, A => n339, ZN => n340);
   U11 : INV_X1 port map( A => B(9), ZN => n345);
   U12 : OAI21_X1 port map( B1 => n346, B2 => n347, A => n348, ZN => Y(8));
   U13 : OAI21_X1 port map( B1 => n339, B2 => n349, A => B(8), ZN => n348);
   U14 : MUX2_X1 port map( A => n344, B => n338, S => n347, Z => n349);
   U15 : INV_X1 port map( A => A(8), ZN => n347);
   U16 : AOI21_X1 port map( B1 => n338, B2 => n350, A => n339, ZN => n346);
   U17 : INV_X1 port map( A => B(8), ZN => n350);
   U18 : OAI21_X1 port map( B1 => n351, B2 => n352, A => n353, ZN => Y(7));
   U19 : OAI21_X1 port map( B1 => n339, B2 => n354, A => B(7), ZN => n353);
   U20 : MUX2_X1 port map( A => n344, B => n338, S => n352, Z => n354);
   U21 : INV_X1 port map( A => A(7), ZN => n352);
   U22 : AOI21_X1 port map( B1 => n338, B2 => n355, A => n339, ZN => n351);
   U23 : INV_X1 port map( A => B(7), ZN => n355);
   U24 : OAI21_X1 port map( B1 => n356, B2 => n357, A => n358, ZN => Y(6));
   U25 : OAI21_X1 port map( B1 => n339, B2 => n359, A => B(6), ZN => n358);
   U26 : MUX2_X1 port map( A => n344, B => n338, S => n357, Z => n359);
   U27 : INV_X1 port map( A => A(6), ZN => n357);
   U28 : AOI21_X1 port map( B1 => n338, B2 => n360, A => n339, ZN => n356);
   U29 : INV_X1 port map( A => B(6), ZN => n360);
   U30 : OAI21_X1 port map( B1 => n361, B2 => n362, A => n363, ZN => Y(5));
   U31 : OAI21_X1 port map( B1 => n339, B2 => n364, A => B(5), ZN => n363);
   U32 : MUX2_X1 port map( A => n344, B => n338, S => n362, Z => n364);
   U33 : INV_X1 port map( A => A(5), ZN => n362);
   U34 : AOI21_X1 port map( B1 => n338, B2 => n365, A => n339, ZN => n361);
   U35 : INV_X1 port map( A => B(5), ZN => n365);
   U36 : OAI21_X1 port map( B1 => n366, B2 => n367, A => n368, ZN => Y(4));
   U37 : OAI21_X1 port map( B1 => n339, B2 => n369, A => B(4), ZN => n368);
   U38 : MUX2_X1 port map( A => n344, B => n338, S => n367, Z => n369);
   U39 : INV_X1 port map( A => A(4), ZN => n367);
   U40 : AOI21_X1 port map( B1 => n338, B2 => n370, A => n339, ZN => n366);
   U41 : INV_X1 port map( A => B(4), ZN => n370);
   U42 : OAI21_X1 port map( B1 => n371, B2 => n372, A => n373, ZN => Y(3));
   U43 : OAI21_X1 port map( B1 => n339, B2 => n374, A => B(3), ZN => n373);
   U44 : MUX2_X1 port map( A => n344, B => n338, S => n372, Z => n374);
   U45 : INV_X1 port map( A => A(3), ZN => n372);
   U46 : AOI21_X1 port map( B1 => n338, B2 => n375, A => n339, ZN => n371);
   U47 : INV_X1 port map( A => B(3), ZN => n375);
   U48 : OAI21_X1 port map( B1 => n376, B2 => n377, A => n378, ZN => Y(31));
   U49 : OAI21_X1 port map( B1 => n339, B2 => n379, A => B(31), ZN => n378);
   U50 : MUX2_X1 port map( A => n344, B => n338, S => n377, Z => n379);
   U51 : INV_X1 port map( A => A(31), ZN => n377);
   U52 : AOI21_X1 port map( B1 => n338, B2 => n380, A => n339, ZN => n376);
   U53 : INV_X1 port map( A => B(31), ZN => n380);
   U54 : OAI21_X1 port map( B1 => n381, B2 => n382, A => n383, ZN => Y(30));
   U55 : OAI21_X1 port map( B1 => n339, B2 => n384, A => B(30), ZN => n383);
   U56 : MUX2_X1 port map( A => n344, B => n338, S => n382, Z => n384);
   U57 : INV_X1 port map( A => A(30), ZN => n382);
   U58 : AOI21_X1 port map( B1 => n338, B2 => n385, A => n339, ZN => n381);
   U59 : INV_X1 port map( A => B(30), ZN => n385);
   U60 : OAI21_X1 port map( B1 => n386, B2 => n387, A => n388, ZN => Y(2));
   U61 : OAI21_X1 port map( B1 => n339, B2 => n389, A => B(2), ZN => n388);
   U62 : MUX2_X1 port map( A => n344, B => n338, S => n387, Z => n389);
   U63 : INV_X1 port map( A => A(2), ZN => n387);
   U64 : AOI21_X1 port map( B1 => n338, B2 => n390, A => n339, ZN => n386);
   U65 : INV_X1 port map( A => B(2), ZN => n390);
   U66 : OAI21_X1 port map( B1 => n391, B2 => n392, A => n393, ZN => Y(29));
   U67 : OAI21_X1 port map( B1 => n339, B2 => n394, A => B(29), ZN => n393);
   U68 : MUX2_X1 port map( A => n344, B => n338, S => n392, Z => n394);
   U69 : INV_X1 port map( A => A(29), ZN => n392);
   U70 : AOI21_X1 port map( B1 => n338, B2 => n395, A => n339, ZN => n391);
   U71 : INV_X1 port map( A => B(29), ZN => n395);
   U72 : OAI21_X1 port map( B1 => n396, B2 => n397, A => n398, ZN => Y(28));
   U73 : OAI21_X1 port map( B1 => n339, B2 => n399, A => B(28), ZN => n398);
   U74 : MUX2_X1 port map( A => n344, B => n338, S => n397, Z => n399);
   U75 : INV_X1 port map( A => A(28), ZN => n397);
   U76 : AOI21_X1 port map( B1 => n338, B2 => n400, A => n339, ZN => n396);
   U77 : INV_X1 port map( A => B(28), ZN => n400);
   U78 : OAI21_X1 port map( B1 => n401, B2 => n402, A => n403, ZN => Y(27));
   U79 : OAI21_X1 port map( B1 => n339, B2 => n404, A => B(27), ZN => n403);
   U80 : MUX2_X1 port map( A => n344, B => n338, S => n402, Z => n404);
   U81 : INV_X1 port map( A => A(27), ZN => n402);
   U82 : AOI21_X1 port map( B1 => n338, B2 => n405, A => n339, ZN => n401);
   U83 : INV_X1 port map( A => B(27), ZN => n405);
   U84 : OAI21_X1 port map( B1 => n406, B2 => n407, A => n408, ZN => Y(26));
   U85 : OAI21_X1 port map( B1 => n339, B2 => n409, A => B(26), ZN => n408);
   U86 : MUX2_X1 port map( A => n344, B => n338, S => n407, Z => n409);
   U87 : INV_X1 port map( A => A(26), ZN => n407);
   U88 : AOI21_X1 port map( B1 => n338, B2 => n410, A => n339, ZN => n406);
   U89 : INV_X1 port map( A => B(26), ZN => n410);
   U90 : OAI21_X1 port map( B1 => n411, B2 => n412, A => n413, ZN => Y(25));
   U91 : OAI21_X1 port map( B1 => n339, B2 => n414, A => B(25), ZN => n413);
   U92 : MUX2_X1 port map( A => n344, B => n338, S => n412, Z => n414);
   U93 : INV_X1 port map( A => A(25), ZN => n412);
   U94 : AOI21_X1 port map( B1 => n338, B2 => n415, A => n339, ZN => n411);
   U95 : INV_X1 port map( A => B(25), ZN => n415);
   U96 : OAI21_X1 port map( B1 => n416, B2 => n417, A => n418, ZN => Y(24));
   U97 : OAI21_X1 port map( B1 => n339, B2 => n419, A => B(24), ZN => n418);
   U98 : MUX2_X1 port map( A => n344, B => n338, S => n417, Z => n419);
   U99 : INV_X1 port map( A => A(24), ZN => n417);
   U100 : AOI21_X1 port map( B1 => n338, B2 => n420, A => n339, ZN => n416);
   U101 : INV_X1 port map( A => B(24), ZN => n420);
   U102 : OAI21_X1 port map( B1 => n421, B2 => n422, A => n423, ZN => Y(23));
   U103 : OAI21_X1 port map( B1 => n339, B2 => n424, A => B(23), ZN => n423);
   U104 : MUX2_X1 port map( A => n344, B => n338, S => n422, Z => n424);
   U105 : INV_X1 port map( A => A(23), ZN => n422);
   U106 : AOI21_X1 port map( B1 => n338, B2 => n425, A => n339, ZN => n421);
   U107 : INV_X1 port map( A => B(23), ZN => n425);
   U108 : OAI21_X1 port map( B1 => n426, B2 => n427, A => n428, ZN => Y(22));
   U109 : OAI21_X1 port map( B1 => n339, B2 => n429, A => B(22), ZN => n428);
   U110 : MUX2_X1 port map( A => n344, B => n338, S => n427, Z => n429);
   U111 : INV_X1 port map( A => A(22), ZN => n427);
   U112 : AOI21_X1 port map( B1 => n338, B2 => n430, A => n339, ZN => n426);
   U113 : INV_X1 port map( A => B(22), ZN => n430);
   U114 : OAI21_X1 port map( B1 => n431, B2 => n432, A => n433, ZN => Y(21));
   U115 : OAI21_X1 port map( B1 => n339, B2 => n434, A => B(21), ZN => n433);
   U116 : MUX2_X1 port map( A => n344, B => n338, S => n432, Z => n434);
   U117 : INV_X1 port map( A => A(21), ZN => n432);
   U118 : AOI21_X1 port map( B1 => n338, B2 => n435, A => n339, ZN => n431);
   U119 : INV_X1 port map( A => B(21), ZN => n435);
   U120 : OAI21_X1 port map( B1 => n436, B2 => n437, A => n438, ZN => Y(20));
   U121 : OAI21_X1 port map( B1 => n339, B2 => n439, A => B(20), ZN => n438);
   U122 : MUX2_X1 port map( A => n344, B => n338, S => n437, Z => n439);
   U123 : INV_X1 port map( A => A(20), ZN => n437);
   U124 : AOI21_X1 port map( B1 => n338, B2 => n440, A => n339, ZN => n436);
   U125 : INV_X1 port map( A => B(20), ZN => n440);
   U126 : OAI21_X1 port map( B1 => n441, B2 => n442, A => n443, ZN => Y(1));
   U127 : OAI21_X1 port map( B1 => n339, B2 => n444, A => B(1), ZN => n443);
   U128 : MUX2_X1 port map( A => n344, B => n338, S => n442, Z => n444);
   U129 : INV_X1 port map( A => A(1), ZN => n442);
   U130 : AOI21_X1 port map( B1 => n338, B2 => n445, A => n339, ZN => n441);
   U131 : INV_X1 port map( A => B(1), ZN => n445);
   U132 : OAI21_X1 port map( B1 => n446, B2 => n447, A => n448, ZN => Y(19));
   U133 : OAI21_X1 port map( B1 => n339, B2 => n449, A => B(19), ZN => n448);
   U134 : MUX2_X1 port map( A => n344, B => n338, S => n447, Z => n449);
   U135 : INV_X1 port map( A => A(19), ZN => n447);
   U136 : AOI21_X1 port map( B1 => n338, B2 => n450, A => n339, ZN => n446);
   U137 : INV_X1 port map( A => B(19), ZN => n450);
   U138 : OAI21_X1 port map( B1 => n451, B2 => n452, A => n453, ZN => Y(18));
   U139 : OAI21_X1 port map( B1 => n339, B2 => n454, A => B(18), ZN => n453);
   U140 : MUX2_X1 port map( A => n344, B => n338, S => n452, Z => n454);
   U141 : INV_X1 port map( A => A(18), ZN => n452);
   U142 : AOI21_X1 port map( B1 => n338, B2 => n455, A => n339, ZN => n451);
   U143 : INV_X1 port map( A => B(18), ZN => n455);
   U144 : OAI21_X1 port map( B1 => n456, B2 => n457, A => n458, ZN => Y(17));
   U145 : OAI21_X1 port map( B1 => n339, B2 => n459, A => B(17), ZN => n458);
   U146 : MUX2_X1 port map( A => n344, B => n338, S => n457, Z => n459);
   U147 : INV_X1 port map( A => A(17), ZN => n457);
   U148 : AOI21_X1 port map( B1 => n338, B2 => n460, A => n339, ZN => n456);
   U149 : INV_X1 port map( A => B(17), ZN => n460);
   U150 : OAI21_X1 port map( B1 => n461, B2 => n462, A => n463, ZN => Y(16));
   U151 : OAI21_X1 port map( B1 => n339, B2 => n464, A => B(16), ZN => n463);
   U152 : MUX2_X1 port map( A => n344, B => n338, S => n462, Z => n464);
   U153 : INV_X1 port map( A => A(16), ZN => n462);
   U154 : AOI21_X1 port map( B1 => n338, B2 => n465, A => n339, ZN => n461);
   U155 : INV_X1 port map( A => B(16), ZN => n465);
   U156 : OAI21_X1 port map( B1 => n466, B2 => n467, A => n468, ZN => Y(15));
   U157 : OAI21_X1 port map( B1 => n339, B2 => n469, A => B(15), ZN => n468);
   U158 : MUX2_X1 port map( A => n344, B => n338, S => n467, Z => n469);
   U159 : INV_X1 port map( A => A(15), ZN => n467);
   U160 : AOI21_X1 port map( B1 => n338, B2 => n470, A => n339, ZN => n466);
   U161 : INV_X1 port map( A => B(15), ZN => n470);
   U162 : OAI21_X1 port map( B1 => n471, B2 => n472, A => n473, ZN => Y(14));
   U163 : OAI21_X1 port map( B1 => n339, B2 => n474, A => B(14), ZN => n473);
   U164 : MUX2_X1 port map( A => n344, B => n338, S => n472, Z => n474);
   U165 : INV_X1 port map( A => A(14), ZN => n472);
   U166 : AOI21_X1 port map( B1 => n338, B2 => n475, A => n339, ZN => n471);
   U167 : INV_X1 port map( A => B(14), ZN => n475);
   U168 : OAI21_X1 port map( B1 => n476, B2 => n477, A => n478, ZN => Y(13));
   U169 : OAI21_X1 port map( B1 => n339, B2 => n479, A => B(13), ZN => n478);
   U170 : MUX2_X1 port map( A => n344, B => n338, S => n477, Z => n479);
   U171 : INV_X1 port map( A => A(13), ZN => n477);
   U172 : AOI21_X1 port map( B1 => n338, B2 => n480, A => n339, ZN => n476);
   U173 : INV_X1 port map( A => B(13), ZN => n480);
   U174 : OAI21_X1 port map( B1 => n481, B2 => n482, A => n483, ZN => Y(12));
   U175 : OAI21_X1 port map( B1 => n339, B2 => n484, A => B(12), ZN => n483);
   U176 : MUX2_X1 port map( A => n344, B => n338, S => n482, Z => n484);
   U177 : INV_X1 port map( A => A(12), ZN => n482);
   U178 : AOI21_X1 port map( B1 => n338, B2 => n485, A => n339, ZN => n481);
   U179 : INV_X1 port map( A => B(12), ZN => n485);
   U180 : OAI21_X1 port map( B1 => n486, B2 => n487, A => n488, ZN => Y(11));
   U181 : OAI21_X1 port map( B1 => n339, B2 => n489, A => B(11), ZN => n488);
   U182 : MUX2_X1 port map( A => n344, B => n338, S => n487, Z => n489);
   U183 : INV_X1 port map( A => A(11), ZN => n487);
   U184 : AOI21_X1 port map( B1 => n338, B2 => n490, A => n339, ZN => n486);
   U185 : INV_X1 port map( A => B(11), ZN => n490);
   U186 : OAI21_X1 port map( B1 => n491, B2 => n492, A => n493, ZN => Y(10));
   U187 : OAI21_X1 port map( B1 => n339, B2 => n494, A => B(10), ZN => n493);
   U188 : MUX2_X1 port map( A => n344, B => n338, S => n492, Z => n494);
   U189 : INV_X1 port map( A => A(10), ZN => n492);
   U190 : AOI21_X1 port map( B1 => n338, B2 => n495, A => n339, ZN => n491);
   U191 : INV_X1 port map( A => B(10), ZN => n495);
   U192 : OAI21_X1 port map( B1 => n496, B2 => n497, A => n498, ZN => Y(0));
   U193 : OAI21_X1 port map( B1 => n339, B2 => n499, A => B(0), ZN => n498);
   U194 : MUX2_X1 port map( A => n344, B => n338, S => n497, Z => n499);
   U195 : INV_X1 port map( A => A(0), ZN => n497);
   U196 : AOI21_X1 port map( B1 => n338, B2 => n500, A => n339, ZN => n496);
   U197 : INV_X1 port map( A => B(0), ZN => n500);
   U198 : INV_X1 port map( A => S(1), ZN => n344);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity BARREL_SHIFTER_RIGHT_N32 is

   port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic;  Y : out 
         std_logic_vector (31 downto 0));

end BARREL_SHIFTER_RIGHT_N32;

architecture SYN_STRUCTURAL of BARREL_SHIFTER_RIGHT_N32 is

   component MUX21_L_1
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_2
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_3
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_4
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_5
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_6
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_7
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_8
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_9
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_10
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_11
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_12
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_13
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_14
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_15
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_16
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_17
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_18
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_19
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_20
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_21
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_22
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_23
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_24
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_25
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_26
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_27
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_28
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_29
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_30
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_31
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_32
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_33
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_34
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_35
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_36
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_37
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_38
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_39
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_40
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_41
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_42
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_43
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_44
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_45
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_46
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_47
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_48
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_49
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_50
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_51
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_52
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_53
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_54
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_55
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_56
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_57
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_58
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_59
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_60
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_61
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_62
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_63
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_64
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_65
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_66
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_67
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_68
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_69
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_70
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_71
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_72
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_73
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_74
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_75
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_76
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_77
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_78
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_79
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_80
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_81
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_82
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_83
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_84
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_85
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_86
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_87
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_88
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_89
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_90
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_91
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_92
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_93
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_94
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_95
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_96
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_97
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_98
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_99
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_100
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_101
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_102
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_103
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_104
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_105
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_106
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_107
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_108
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_109
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_110
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_111
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_112
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_113
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_114
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_115
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_116
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_117
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_118
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_119
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_120
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_121
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_122
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_123
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_124
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_125
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_126
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_127
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_128
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_129
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_130
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_131
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_132
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_133
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_134
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_135
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_136
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_137
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_138
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_139
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_140
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_141
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_142
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_143
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_144
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_145
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_146
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_147
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_148
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_149
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_150
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_151
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_152
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_153
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_154
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_155
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_156
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_157
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_158
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_159
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_160
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   signal TMP_4_9_port, TMP_4_8_port, TMP_4_7_port, TMP_4_6_port, TMP_4_5_port,
      TMP_4_4_port, TMP_4_3_port, TMP_4_31_port, TMP_4_30_port, TMP_4_2_port, 
      TMP_4_29_port, TMP_4_28_port, TMP_4_27_port, TMP_4_26_port, TMP_4_25_port
      , TMP_4_24_port, TMP_4_23_port, TMP_4_22_port, TMP_4_21_port, 
      TMP_4_20_port, TMP_4_1_port, TMP_4_19_port, TMP_4_18_port, TMP_4_17_port,
      TMP_4_16_port, TMP_4_15_port, TMP_4_14_port, TMP_4_13_port, TMP_4_12_port
      , TMP_4_11_port, TMP_4_10_port, TMP_4_0_port, TMP_3_9_port, TMP_3_8_port,
      TMP_3_7_port, TMP_3_6_port, TMP_3_5_port, TMP_3_4_port, TMP_3_3_port, 
      TMP_3_31_port, TMP_3_30_port, TMP_3_2_port, TMP_3_29_port, TMP_3_28_port,
      TMP_3_27_port, TMP_3_26_port, TMP_3_25_port, TMP_3_24_port, TMP_3_23_port
      , TMP_3_22_port, TMP_3_21_port, TMP_3_20_port, TMP_3_1_port, 
      TMP_3_19_port, TMP_3_18_port, TMP_3_17_port, TMP_3_16_port, TMP_3_15_port
      , TMP_3_14_port, TMP_3_13_port, TMP_3_12_port, TMP_3_11_port, 
      TMP_3_10_port, TMP_3_0_port, TMP_2_9_port, TMP_2_8_port, TMP_2_7_port, 
      TMP_2_6_port, TMP_2_5_port, TMP_2_4_port, TMP_2_3_port, TMP_2_31_port, 
      TMP_2_30_port, TMP_2_2_port, TMP_2_29_port, TMP_2_28_port, TMP_2_27_port,
      TMP_2_26_port, TMP_2_25_port, TMP_2_24_port, TMP_2_23_port, TMP_2_22_port
      , TMP_2_21_port, TMP_2_20_port, TMP_2_1_port, TMP_2_19_port, 
      TMP_2_18_port, TMP_2_17_port, TMP_2_16_port, TMP_2_15_port, TMP_2_14_port
      , TMP_2_13_port, TMP_2_12_port, TMP_2_11_port, TMP_2_10_port, 
      TMP_2_0_port, TMP_1_9_port, TMP_1_8_port, TMP_1_7_port, TMP_1_6_port, 
      TMP_1_5_port, TMP_1_4_port, TMP_1_3_port, TMP_1_31_port, TMP_1_30_port, 
      TMP_1_2_port, TMP_1_29_port, TMP_1_28_port, TMP_1_27_port, TMP_1_26_port,
      TMP_1_25_port, TMP_1_24_port, TMP_1_23_port, TMP_1_22_port, TMP_1_21_port
      , TMP_1_20_port, TMP_1_1_port, TMP_1_19_port, TMP_1_18_port, 
      TMP_1_17_port, TMP_1_16_port, TMP_1_15_port, TMP_1_14_port, TMP_1_13_port
      , TMP_1_12_port, TMP_1_11_port, TMP_1_10_port, TMP_1_0_port : std_logic;

begin
   
   MUX21_K_0_0 : MUX21_L_160 port map( A => A(0), B => A(1), S => B(0), Y => 
                           TMP_1_0_port);
   MUX21_K_0_1 : MUX21_L_159 port map( A => A(1), B => A(2), S => B(0), Y => 
                           TMP_1_1_port);
   MUX21_K_0_2 : MUX21_L_158 port map( A => A(2), B => A(3), S => B(0), Y => 
                           TMP_1_2_port);
   MUX21_K_0_3 : MUX21_L_157 port map( A => A(3), B => A(4), S => B(0), Y => 
                           TMP_1_3_port);
   MUX21_K_0_4 : MUX21_L_156 port map( A => A(4), B => A(5), S => B(0), Y => 
                           TMP_1_4_port);
   MUX21_K_0_5 : MUX21_L_155 port map( A => A(5), B => A(6), S => B(0), Y => 
                           TMP_1_5_port);
   MUX21_K_0_6 : MUX21_L_154 port map( A => A(6), B => A(7), S => B(0), Y => 
                           TMP_1_6_port);
   MUX21_K_0_7 : MUX21_L_153 port map( A => A(7), B => A(8), S => B(0), Y => 
                           TMP_1_7_port);
   MUX21_K_0_8 : MUX21_L_152 port map( A => A(8), B => A(9), S => B(0), Y => 
                           TMP_1_8_port);
   MUX21_K_0_9 : MUX21_L_151 port map( A => A(9), B => A(10), S => B(0), Y => 
                           TMP_1_9_port);
   MUX21_K_0_10 : MUX21_L_150 port map( A => A(10), B => A(11), S => B(0), Y =>
                           TMP_1_10_port);
   MUX21_K_0_11 : MUX21_L_149 port map( A => A(11), B => A(12), S => B(0), Y =>
                           TMP_1_11_port);
   MUX21_K_0_12 : MUX21_L_148 port map( A => A(12), B => A(13), S => B(0), Y =>
                           TMP_1_12_port);
   MUX21_K_0_13 : MUX21_L_147 port map( A => A(13), B => A(14), S => B(0), Y =>
                           TMP_1_13_port);
   MUX21_K_0_14 : MUX21_L_146 port map( A => A(14), B => A(15), S => B(0), Y =>
                           TMP_1_14_port);
   MUX21_K_0_15 : MUX21_L_145 port map( A => A(15), B => A(16), S => B(0), Y =>
                           TMP_1_15_port);
   MUX21_K_0_16 : MUX21_L_144 port map( A => A(16), B => A(17), S => B(0), Y =>
                           TMP_1_16_port);
   MUX21_K_0_17 : MUX21_L_143 port map( A => A(17), B => A(18), S => B(0), Y =>
                           TMP_1_17_port);
   MUX21_K_0_18 : MUX21_L_142 port map( A => A(18), B => A(19), S => B(0), Y =>
                           TMP_1_18_port);
   MUX21_K_0_19 : MUX21_L_141 port map( A => A(19), B => A(20), S => B(0), Y =>
                           TMP_1_19_port);
   MUX21_K_0_20 : MUX21_L_140 port map( A => A(20), B => A(21), S => B(0), Y =>
                           TMP_1_20_port);
   MUX21_K_0_21 : MUX21_L_139 port map( A => A(21), B => A(22), S => B(0), Y =>
                           TMP_1_21_port);
   MUX21_K_0_22 : MUX21_L_138 port map( A => A(22), B => A(23), S => B(0), Y =>
                           TMP_1_22_port);
   MUX21_K_0_23 : MUX21_L_137 port map( A => A(23), B => A(24), S => B(0), Y =>
                           TMP_1_23_port);
   MUX21_K_0_24 : MUX21_L_136 port map( A => A(24), B => A(25), S => B(0), Y =>
                           TMP_1_24_port);
   MUX21_K_0_25 : MUX21_L_135 port map( A => A(25), B => A(26), S => B(0), Y =>
                           TMP_1_25_port);
   MUX21_K_0_26 : MUX21_L_134 port map( A => A(26), B => A(27), S => B(0), Y =>
                           TMP_1_26_port);
   MUX21_K_0_27 : MUX21_L_133 port map( A => A(27), B => A(28), S => B(0), Y =>
                           TMP_1_27_port);
   MUX21_K_0_28 : MUX21_L_132 port map( A => A(28), B => A(29), S => B(0), Y =>
                           TMP_1_28_port);
   MUX21_K_0_29 : MUX21_L_131 port map( A => A(29), B => A(30), S => B(0), Y =>
                           TMP_1_29_port);
   MUX21_K_0_30 : MUX21_L_130 port map( A => A(30), B => A(31), S => B(0), Y =>
                           TMP_1_30_port);
   MUX21_J_0_0 : MUX21_L_129 port map( A => A(31), B => S, S => B(0), Y => 
                           TMP_1_31_port);
   MUX21_K_1_0 : MUX21_L_128 port map( A => TMP_1_0_port, B => TMP_1_2_port, S 
                           => B(1), Y => TMP_2_0_port);
   MUX21_K_1_1 : MUX21_L_127 port map( A => TMP_1_1_port, B => TMP_1_3_port, S 
                           => B(1), Y => TMP_2_1_port);
   MUX21_K_1_2 : MUX21_L_126 port map( A => TMP_1_2_port, B => TMP_1_4_port, S 
                           => B(1), Y => TMP_2_2_port);
   MUX21_K_1_3 : MUX21_L_125 port map( A => TMP_1_3_port, B => TMP_1_5_port, S 
                           => B(1), Y => TMP_2_3_port);
   MUX21_K_1_4 : MUX21_L_124 port map( A => TMP_1_4_port, B => TMP_1_6_port, S 
                           => B(1), Y => TMP_2_4_port);
   MUX21_K_1_5 : MUX21_L_123 port map( A => TMP_1_5_port, B => TMP_1_7_port, S 
                           => B(1), Y => TMP_2_5_port);
   MUX21_K_1_6 : MUX21_L_122 port map( A => TMP_1_6_port, B => TMP_1_8_port, S 
                           => B(1), Y => TMP_2_6_port);
   MUX21_K_1_7 : MUX21_L_121 port map( A => TMP_1_7_port, B => TMP_1_9_port, S 
                           => B(1), Y => TMP_2_7_port);
   MUX21_K_1_8 : MUX21_L_120 port map( A => TMP_1_8_port, B => TMP_1_10_port, S
                           => B(1), Y => TMP_2_8_port);
   MUX21_K_1_9 : MUX21_L_119 port map( A => TMP_1_9_port, B => TMP_1_11_port, S
                           => B(1), Y => TMP_2_9_port);
   MUX21_K_1_10 : MUX21_L_118 port map( A => TMP_1_10_port, B => TMP_1_12_port,
                           S => B(1), Y => TMP_2_10_port);
   MUX21_K_1_11 : MUX21_L_117 port map( A => TMP_1_11_port, B => TMP_1_13_port,
                           S => B(1), Y => TMP_2_11_port);
   MUX21_K_1_12 : MUX21_L_116 port map( A => TMP_1_12_port, B => TMP_1_14_port,
                           S => B(1), Y => TMP_2_12_port);
   MUX21_K_1_13 : MUX21_L_115 port map( A => TMP_1_13_port, B => TMP_1_15_port,
                           S => B(1), Y => TMP_2_13_port);
   MUX21_K_1_14 : MUX21_L_114 port map( A => TMP_1_14_port, B => TMP_1_16_port,
                           S => B(1), Y => TMP_2_14_port);
   MUX21_K_1_15 : MUX21_L_113 port map( A => TMP_1_15_port, B => TMP_1_17_port,
                           S => B(1), Y => TMP_2_15_port);
   MUX21_K_1_16 : MUX21_L_112 port map( A => TMP_1_16_port, B => TMP_1_18_port,
                           S => B(1), Y => TMP_2_16_port);
   MUX21_K_1_17 : MUX21_L_111 port map( A => TMP_1_17_port, B => TMP_1_19_port,
                           S => B(1), Y => TMP_2_17_port);
   MUX21_K_1_18 : MUX21_L_110 port map( A => TMP_1_18_port, B => TMP_1_20_port,
                           S => B(1), Y => TMP_2_18_port);
   MUX21_K_1_19 : MUX21_L_109 port map( A => TMP_1_19_port, B => TMP_1_21_port,
                           S => B(1), Y => TMP_2_19_port);
   MUX21_K_1_20 : MUX21_L_108 port map( A => TMP_1_20_port, B => TMP_1_22_port,
                           S => B(1), Y => TMP_2_20_port);
   MUX21_K_1_21 : MUX21_L_107 port map( A => TMP_1_21_port, B => TMP_1_23_port,
                           S => B(1), Y => TMP_2_21_port);
   MUX21_K_1_22 : MUX21_L_106 port map( A => TMP_1_22_port, B => TMP_1_24_port,
                           S => B(1), Y => TMP_2_22_port);
   MUX21_K_1_23 : MUX21_L_105 port map( A => TMP_1_23_port, B => TMP_1_25_port,
                           S => B(1), Y => TMP_2_23_port);
   MUX21_K_1_24 : MUX21_L_104 port map( A => TMP_1_24_port, B => TMP_1_26_port,
                           S => B(1), Y => TMP_2_24_port);
   MUX21_K_1_25 : MUX21_L_103 port map( A => TMP_1_25_port, B => TMP_1_27_port,
                           S => B(1), Y => TMP_2_25_port);
   MUX21_K_1_26 : MUX21_L_102 port map( A => TMP_1_26_port, B => TMP_1_28_port,
                           S => B(1), Y => TMP_2_26_port);
   MUX21_K_1_27 : MUX21_L_101 port map( A => TMP_1_27_port, B => TMP_1_29_port,
                           S => B(1), Y => TMP_2_27_port);
   MUX21_K_1_28 : MUX21_L_100 port map( A => TMP_1_28_port, B => TMP_1_30_port,
                           S => B(1), Y => TMP_2_28_port);
   MUX21_K_1_29 : MUX21_L_99 port map( A => TMP_1_29_port, B => TMP_1_31_port, 
                           S => B(1), Y => TMP_2_29_port);
   MUX21_J_1_0 : MUX21_L_98 port map( A => TMP_1_30_port, B => S, S => B(1), Y 
                           => TMP_2_30_port);
   MUX21_J_1_1 : MUX21_L_97 port map( A => TMP_1_31_port, B => S, S => B(1), Y 
                           => TMP_2_31_port);
   MUX21_K_2_0 : MUX21_L_96 port map( A => TMP_2_0_port, B => TMP_2_4_port, S 
                           => B(2), Y => TMP_3_0_port);
   MUX21_K_2_1 : MUX21_L_95 port map( A => TMP_2_1_port, B => TMP_2_5_port, S 
                           => B(2), Y => TMP_3_1_port);
   MUX21_K_2_2 : MUX21_L_94 port map( A => TMP_2_2_port, B => TMP_2_6_port, S 
                           => B(2), Y => TMP_3_2_port);
   MUX21_K_2_3 : MUX21_L_93 port map( A => TMP_2_3_port, B => TMP_2_7_port, S 
                           => B(2), Y => TMP_3_3_port);
   MUX21_K_2_4 : MUX21_L_92 port map( A => TMP_2_4_port, B => TMP_2_8_port, S 
                           => B(2), Y => TMP_3_4_port);
   MUX21_K_2_5 : MUX21_L_91 port map( A => TMP_2_5_port, B => TMP_2_9_port, S 
                           => B(2), Y => TMP_3_5_port);
   MUX21_K_2_6 : MUX21_L_90 port map( A => TMP_2_6_port, B => TMP_2_10_port, S 
                           => B(2), Y => TMP_3_6_port);
   MUX21_K_2_7 : MUX21_L_89 port map( A => TMP_2_7_port, B => TMP_2_11_port, S 
                           => B(2), Y => TMP_3_7_port);
   MUX21_K_2_8 : MUX21_L_88 port map( A => TMP_2_8_port, B => TMP_2_12_port, S 
                           => B(2), Y => TMP_3_8_port);
   MUX21_K_2_9 : MUX21_L_87 port map( A => TMP_2_9_port, B => TMP_2_13_port, S 
                           => B(2), Y => TMP_3_9_port);
   MUX21_K_2_10 : MUX21_L_86 port map( A => TMP_2_10_port, B => TMP_2_14_port, 
                           S => B(2), Y => TMP_3_10_port);
   MUX21_K_2_11 : MUX21_L_85 port map( A => TMP_2_11_port, B => TMP_2_15_port, 
                           S => B(2), Y => TMP_3_11_port);
   MUX21_K_2_12 : MUX21_L_84 port map( A => TMP_2_12_port, B => TMP_2_16_port, 
                           S => B(2), Y => TMP_3_12_port);
   MUX21_K_2_13 : MUX21_L_83 port map( A => TMP_2_13_port, B => TMP_2_17_port, 
                           S => B(2), Y => TMP_3_13_port);
   MUX21_K_2_14 : MUX21_L_82 port map( A => TMP_2_14_port, B => TMP_2_18_port, 
                           S => B(2), Y => TMP_3_14_port);
   MUX21_K_2_15 : MUX21_L_81 port map( A => TMP_2_15_port, B => TMP_2_19_port, 
                           S => B(2), Y => TMP_3_15_port);
   MUX21_K_2_16 : MUX21_L_80 port map( A => TMP_2_16_port, B => TMP_2_20_port, 
                           S => B(2), Y => TMP_3_16_port);
   MUX21_K_2_17 : MUX21_L_79 port map( A => TMP_2_17_port, B => TMP_2_21_port, 
                           S => B(2), Y => TMP_3_17_port);
   MUX21_K_2_18 : MUX21_L_78 port map( A => TMP_2_18_port, B => TMP_2_22_port, 
                           S => B(2), Y => TMP_3_18_port);
   MUX21_K_2_19 : MUX21_L_77 port map( A => TMP_2_19_port, B => TMP_2_23_port, 
                           S => B(2), Y => TMP_3_19_port);
   MUX21_K_2_20 : MUX21_L_76 port map( A => TMP_2_20_port, B => TMP_2_24_port, 
                           S => B(2), Y => TMP_3_20_port);
   MUX21_K_2_21 : MUX21_L_75 port map( A => TMP_2_21_port, B => TMP_2_25_port, 
                           S => B(2), Y => TMP_3_21_port);
   MUX21_K_2_22 : MUX21_L_74 port map( A => TMP_2_22_port, B => TMP_2_26_port, 
                           S => B(2), Y => TMP_3_22_port);
   MUX21_K_2_23 : MUX21_L_73 port map( A => TMP_2_23_port, B => TMP_2_27_port, 
                           S => B(2), Y => TMP_3_23_port);
   MUX21_K_2_24 : MUX21_L_72 port map( A => TMP_2_24_port, B => TMP_2_28_port, 
                           S => B(2), Y => TMP_3_24_port);
   MUX21_K_2_25 : MUX21_L_71 port map( A => TMP_2_25_port, B => TMP_2_29_port, 
                           S => B(2), Y => TMP_3_25_port);
   MUX21_K_2_26 : MUX21_L_70 port map( A => TMP_2_26_port, B => TMP_2_30_port, 
                           S => B(2), Y => TMP_3_26_port);
   MUX21_K_2_27 : MUX21_L_69 port map( A => TMP_2_27_port, B => TMP_2_31_port, 
                           S => B(2), Y => TMP_3_27_port);
   MUX21_J_2_0 : MUX21_L_68 port map( A => TMP_2_28_port, B => S, S => B(2), Y 
                           => TMP_3_28_port);
   MUX21_J_2_1 : MUX21_L_67 port map( A => TMP_2_29_port, B => S, S => B(2), Y 
                           => TMP_3_29_port);
   MUX21_J_2_2 : MUX21_L_66 port map( A => TMP_2_30_port, B => S, S => B(2), Y 
                           => TMP_3_30_port);
   MUX21_J_2_3 : MUX21_L_65 port map( A => TMP_2_31_port, B => S, S => B(2), Y 
                           => TMP_3_31_port);
   MUX21_K_3_0 : MUX21_L_64 port map( A => TMP_3_0_port, B => TMP_3_8_port, S 
                           => B(3), Y => TMP_4_0_port);
   MUX21_K_3_1 : MUX21_L_63 port map( A => TMP_3_1_port, B => TMP_3_9_port, S 
                           => B(3), Y => TMP_4_1_port);
   MUX21_K_3_2 : MUX21_L_62 port map( A => TMP_3_2_port, B => TMP_3_10_port, S 
                           => B(3), Y => TMP_4_2_port);
   MUX21_K_3_3 : MUX21_L_61 port map( A => TMP_3_3_port, B => TMP_3_11_port, S 
                           => B(3), Y => TMP_4_3_port);
   MUX21_K_3_4 : MUX21_L_60 port map( A => TMP_3_4_port, B => TMP_3_12_port, S 
                           => B(3), Y => TMP_4_4_port);
   MUX21_K_3_5 : MUX21_L_59 port map( A => TMP_3_5_port, B => TMP_3_13_port, S 
                           => B(3), Y => TMP_4_5_port);
   MUX21_K_3_6 : MUX21_L_58 port map( A => TMP_3_6_port, B => TMP_3_14_port, S 
                           => B(3), Y => TMP_4_6_port);
   MUX21_K_3_7 : MUX21_L_57 port map( A => TMP_3_7_port, B => TMP_3_15_port, S 
                           => B(3), Y => TMP_4_7_port);
   MUX21_K_3_8 : MUX21_L_56 port map( A => TMP_3_8_port, B => TMP_3_16_port, S 
                           => B(3), Y => TMP_4_8_port);
   MUX21_K_3_9 : MUX21_L_55 port map( A => TMP_3_9_port, B => TMP_3_17_port, S 
                           => B(3), Y => TMP_4_9_port);
   MUX21_K_3_10 : MUX21_L_54 port map( A => TMP_3_10_port, B => TMP_3_18_port, 
                           S => B(3), Y => TMP_4_10_port);
   MUX21_K_3_11 : MUX21_L_53 port map( A => TMP_3_11_port, B => TMP_3_19_port, 
                           S => B(3), Y => TMP_4_11_port);
   MUX21_K_3_12 : MUX21_L_52 port map( A => TMP_3_12_port, B => TMP_3_20_port, 
                           S => B(3), Y => TMP_4_12_port);
   MUX21_K_3_13 : MUX21_L_51 port map( A => TMP_3_13_port, B => TMP_3_21_port, 
                           S => B(3), Y => TMP_4_13_port);
   MUX21_K_3_14 : MUX21_L_50 port map( A => TMP_3_14_port, B => TMP_3_22_port, 
                           S => B(3), Y => TMP_4_14_port);
   MUX21_K_3_15 : MUX21_L_49 port map( A => TMP_3_15_port, B => TMP_3_23_port, 
                           S => B(3), Y => TMP_4_15_port);
   MUX21_K_3_16 : MUX21_L_48 port map( A => TMP_3_16_port, B => TMP_3_24_port, 
                           S => B(3), Y => TMP_4_16_port);
   MUX21_K_3_17 : MUX21_L_47 port map( A => TMP_3_17_port, B => TMP_3_25_port, 
                           S => B(3), Y => TMP_4_17_port);
   MUX21_K_3_18 : MUX21_L_46 port map( A => TMP_3_18_port, B => TMP_3_26_port, 
                           S => B(3), Y => TMP_4_18_port);
   MUX21_K_3_19 : MUX21_L_45 port map( A => TMP_3_19_port, B => TMP_3_27_port, 
                           S => B(3), Y => TMP_4_19_port);
   MUX21_K_3_20 : MUX21_L_44 port map( A => TMP_3_20_port, B => TMP_3_28_port, 
                           S => B(3), Y => TMP_4_20_port);
   MUX21_K_3_21 : MUX21_L_43 port map( A => TMP_3_21_port, B => TMP_3_29_port, 
                           S => B(3), Y => TMP_4_21_port);
   MUX21_K_3_22 : MUX21_L_42 port map( A => TMP_3_22_port, B => TMP_3_30_port, 
                           S => B(3), Y => TMP_4_22_port);
   MUX21_K_3_23 : MUX21_L_41 port map( A => TMP_3_23_port, B => TMP_3_31_port, 
                           S => B(3), Y => TMP_4_23_port);
   MUX21_J_3_0 : MUX21_L_40 port map( A => TMP_3_24_port, B => S, S => B(3), Y 
                           => TMP_4_24_port);
   MUX21_J_3_1 : MUX21_L_39 port map( A => TMP_3_25_port, B => S, S => B(3), Y 
                           => TMP_4_25_port);
   MUX21_J_3_2 : MUX21_L_38 port map( A => TMP_3_26_port, B => S, S => B(3), Y 
                           => TMP_4_26_port);
   MUX21_J_3_3 : MUX21_L_37 port map( A => TMP_3_27_port, B => S, S => B(3), Y 
                           => TMP_4_27_port);
   MUX21_J_3_4 : MUX21_L_36 port map( A => TMP_3_28_port, B => S, S => B(3), Y 
                           => TMP_4_28_port);
   MUX21_J_3_5 : MUX21_L_35 port map( A => TMP_3_29_port, B => S, S => B(3), Y 
                           => TMP_4_29_port);
   MUX21_J_3_6 : MUX21_L_34 port map( A => TMP_3_30_port, B => S, S => B(3), Y 
                           => TMP_4_30_port);
   MUX21_J_3_7 : MUX21_L_33 port map( A => TMP_3_31_port, B => S, S => B(3), Y 
                           => TMP_4_31_port);
   MUX21_K_4_0 : MUX21_L_32 port map( A => TMP_4_0_port, B => TMP_4_16_port, S 
                           => B(4), Y => Y(0));
   MUX21_K_4_1 : MUX21_L_31 port map( A => TMP_4_1_port, B => TMP_4_17_port, S 
                           => B(4), Y => Y(1));
   MUX21_K_4_2 : MUX21_L_30 port map( A => TMP_4_2_port, B => TMP_4_18_port, S 
                           => B(4), Y => Y(2));
   MUX21_K_4_3 : MUX21_L_29 port map( A => TMP_4_3_port, B => TMP_4_19_port, S 
                           => B(4), Y => Y(3));
   MUX21_K_4_4 : MUX21_L_28 port map( A => TMP_4_4_port, B => TMP_4_20_port, S 
                           => B(4), Y => Y(4));
   MUX21_K_4_5 : MUX21_L_27 port map( A => TMP_4_5_port, B => TMP_4_21_port, S 
                           => B(4), Y => Y(5));
   MUX21_K_4_6 : MUX21_L_26 port map( A => TMP_4_6_port, B => TMP_4_22_port, S 
                           => B(4), Y => Y(6));
   MUX21_K_4_7 : MUX21_L_25 port map( A => TMP_4_7_port, B => TMP_4_23_port, S 
                           => B(4), Y => Y(7));
   MUX21_K_4_8 : MUX21_L_24 port map( A => TMP_4_8_port, B => TMP_4_24_port, S 
                           => B(4), Y => Y(8));
   MUX21_K_4_9 : MUX21_L_23 port map( A => TMP_4_9_port, B => TMP_4_25_port, S 
                           => B(4), Y => Y(9));
   MUX21_K_4_10 : MUX21_L_22 port map( A => TMP_4_10_port, B => TMP_4_26_port, 
                           S => B(4), Y => Y(10));
   MUX21_K_4_11 : MUX21_L_21 port map( A => TMP_4_11_port, B => TMP_4_27_port, 
                           S => B(4), Y => Y(11));
   MUX21_K_4_12 : MUX21_L_20 port map( A => TMP_4_12_port, B => TMP_4_28_port, 
                           S => B(4), Y => Y(12));
   MUX21_K_4_13 : MUX21_L_19 port map( A => TMP_4_13_port, B => TMP_4_29_port, 
                           S => B(4), Y => Y(13));
   MUX21_K_4_14 : MUX21_L_18 port map( A => TMP_4_14_port, B => TMP_4_30_port, 
                           S => B(4), Y => Y(14));
   MUX21_K_4_15 : MUX21_L_17 port map( A => TMP_4_15_port, B => TMP_4_31_port, 
                           S => B(4), Y => Y(15));
   MUX21_J_4_0 : MUX21_L_16 port map( A => TMP_4_16_port, B => S, S => B(4), Y 
                           => Y(16));
   MUX21_J_4_1 : MUX21_L_15 port map( A => TMP_4_17_port, B => S, S => B(4), Y 
                           => Y(17));
   MUX21_J_4_2 : MUX21_L_14 port map( A => TMP_4_18_port, B => S, S => B(4), Y 
                           => Y(18));
   MUX21_J_4_3 : MUX21_L_13 port map( A => TMP_4_19_port, B => S, S => B(4), Y 
                           => Y(19));
   MUX21_J_4_4 : MUX21_L_12 port map( A => TMP_4_20_port, B => S, S => B(4), Y 
                           => Y(20));
   MUX21_J_4_5 : MUX21_L_11 port map( A => TMP_4_21_port, B => S, S => B(4), Y 
                           => Y(21));
   MUX21_J_4_6 : MUX21_L_10 port map( A => TMP_4_22_port, B => S, S => B(4), Y 
                           => Y(22));
   MUX21_J_4_7 : MUX21_L_9 port map( A => TMP_4_23_port, B => S, S => B(4), Y 
                           => Y(23));
   MUX21_J_4_8 : MUX21_L_8 port map( A => TMP_4_24_port, B => S, S => B(4), Y 
                           => Y(24));
   MUX21_J_4_9 : MUX21_L_7 port map( A => TMP_4_25_port, B => S, S => B(4), Y 
                           => Y(25));
   MUX21_J_4_10 : MUX21_L_6 port map( A => TMP_4_26_port, B => S, S => B(4), Y 
                           => Y(26));
   MUX21_J_4_11 : MUX21_L_5 port map( A => TMP_4_27_port, B => S, S => B(4), Y 
                           => Y(27));
   MUX21_J_4_12 : MUX21_L_4 port map( A => TMP_4_28_port, B => S, S => B(4), Y 
                           => Y(28));
   MUX21_J_4_13 : MUX21_L_3 port map( A => TMP_4_29_port, B => S, S => B(4), Y 
                           => Y(29));
   MUX21_J_4_14 : MUX21_L_2 port map( A => TMP_4_30_port, B => S, S => B(4), Y 
                           => Y(30));
   MUX21_J_4_15 : MUX21_L_1 port map( A => TMP_4_31_port, B => S, S => B(4), Y 
                           => Y(31));

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity BARREL_SHIFTER_LEFT_N32 is

   port( A, B : in std_logic_vector (31 downto 0);  Y : out std_logic_vector 
         (31 downto 0));

end BARREL_SHIFTER_LEFT_N32;

architecture SYN_STRUCTURAL of BARREL_SHIFTER_LEFT_N32 is

   component MUX21_L_161
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_162
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_163
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_164
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_165
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_166
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_167
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_168
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_169
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_170
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_171
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_172
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_173
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_174
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_175
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_176
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_177
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_178
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_179
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_180
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_181
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_182
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_183
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_184
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_185
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_186
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_187
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_188
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_189
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_190
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_191
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_192
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_193
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_194
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_195
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_196
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_197
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_198
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_199
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_200
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_201
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_202
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_203
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_204
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_205
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_206
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_207
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_208
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_209
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_210
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_211
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_212
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_213
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_214
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_215
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_216
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_217
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_218
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_219
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_220
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_221
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_222
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_223
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_224
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_225
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_226
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_227
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_228
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_229
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_230
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_231
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_232
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_233
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_234
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_235
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_236
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_237
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_238
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_239
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_240
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_241
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_242
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_243
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_244
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_245
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_246
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_247
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_248
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_249
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_250
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_251
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_252
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_253
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_254
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_255
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_256
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_257
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_258
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_259
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_260
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_261
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_262
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_263
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_264
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_265
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_266
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_267
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_268
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_269
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_270
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_271
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_272
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_273
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_274
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_275
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_276
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_277
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_278
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_279
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_280
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_281
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_282
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_283
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_284
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_285
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_286
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_287
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_288
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_289
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_290
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_291
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_292
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_293
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_294
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_295
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_296
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_297
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_298
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_299
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_300
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_301
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_302
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_303
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_304
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_305
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_306
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_307
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_308
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_309
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_310
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_311
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_312
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_313
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_314
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_315
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_316
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_317
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_318
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_319
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   component MUX21_L_0
      port( A, B, S : in std_logic;  Y : out std_logic);
   end component;
   
   signal TMP_4_9_port, TMP_4_8_port, TMP_4_7_port, TMP_4_6_port, TMP_4_5_port,
      TMP_4_4_port, TMP_4_3_port, TMP_4_31_port, TMP_4_30_port, TMP_4_2_port, 
      TMP_4_29_port, TMP_4_28_port, TMP_4_27_port, TMP_4_26_port, TMP_4_25_port
      , TMP_4_24_port, TMP_4_23_port, TMP_4_22_port, TMP_4_21_port, 
      TMP_4_20_port, TMP_4_1_port, TMP_4_19_port, TMP_4_18_port, TMP_4_17_port,
      TMP_4_16_port, TMP_4_15_port, TMP_4_14_port, TMP_4_13_port, TMP_4_12_port
      , TMP_4_11_port, TMP_4_10_port, TMP_4_0_port, TMP_3_9_port, TMP_3_8_port,
      TMP_3_7_port, TMP_3_6_port, TMP_3_5_port, TMP_3_4_port, TMP_3_3_port, 
      TMP_3_31_port, TMP_3_30_port, TMP_3_2_port, TMP_3_29_port, TMP_3_28_port,
      TMP_3_27_port, TMP_3_26_port, TMP_3_25_port, TMP_3_24_port, TMP_3_23_port
      , TMP_3_22_port, TMP_3_21_port, TMP_3_20_port, TMP_3_1_port, 
      TMP_3_19_port, TMP_3_18_port, TMP_3_17_port, TMP_3_16_port, TMP_3_15_port
      , TMP_3_14_port, TMP_3_13_port, TMP_3_12_port, TMP_3_11_port, 
      TMP_3_10_port, TMP_3_0_port, TMP_2_9_port, TMP_2_8_port, TMP_2_7_port, 
      TMP_2_6_port, TMP_2_5_port, TMP_2_4_port, TMP_2_3_port, TMP_2_31_port, 
      TMP_2_30_port, TMP_2_2_port, TMP_2_29_port, TMP_2_28_port, TMP_2_27_port,
      TMP_2_26_port, TMP_2_25_port, TMP_2_24_port, TMP_2_23_port, TMP_2_22_port
      , TMP_2_21_port, TMP_2_20_port, TMP_2_1_port, TMP_2_19_port, 
      TMP_2_18_port, TMP_2_17_port, TMP_2_16_port, TMP_2_15_port, TMP_2_14_port
      , TMP_2_13_port, TMP_2_12_port, TMP_2_11_port, TMP_2_10_port, 
      TMP_2_0_port, TMP_1_9_port, TMP_1_8_port, TMP_1_7_port, TMP_1_6_port, 
      TMP_1_5_port, TMP_1_4_port, TMP_1_3_port, TMP_1_31_port, TMP_1_30_port, 
      TMP_1_2_port, TMP_1_29_port, TMP_1_28_port, TMP_1_27_port, TMP_1_26_port,
      TMP_1_25_port, TMP_1_24_port, TMP_1_23_port, TMP_1_22_port, TMP_1_21_port
      , TMP_1_20_port, TMP_1_1_port, TMP_1_19_port, TMP_1_18_port, 
      TMP_1_17_port, TMP_1_16_port, TMP_1_15_port, TMP_1_14_port, TMP_1_13_port
      , TMP_1_12_port, TMP_1_11_port, TMP_1_10_port, TMP_1_0_port, n41 : 
      std_logic;

begin
   
   MUX21_J_0_0 : MUX21_L_0 port map( A => A(0), B => n41, S => B(0), Y => 
                           TMP_1_0_port);
   MUX21_K_0_0 : MUX21_L_319 port map( A => A(1), B => A(0), S => B(0), Y => 
                           TMP_1_1_port);
   MUX21_K_0_1 : MUX21_L_318 port map( A => A(2), B => A(1), S => B(0), Y => 
                           TMP_1_2_port);
   MUX21_K_0_2 : MUX21_L_317 port map( A => A(3), B => A(2), S => B(0), Y => 
                           TMP_1_3_port);
   MUX21_K_0_3 : MUX21_L_316 port map( A => A(4), B => A(3), S => B(0), Y => 
                           TMP_1_4_port);
   MUX21_K_0_4 : MUX21_L_315 port map( A => A(5), B => A(4), S => B(0), Y => 
                           TMP_1_5_port);
   MUX21_K_0_5 : MUX21_L_314 port map( A => A(6), B => A(5), S => B(0), Y => 
                           TMP_1_6_port);
   MUX21_K_0_6 : MUX21_L_313 port map( A => A(7), B => A(6), S => B(0), Y => 
                           TMP_1_7_port);
   MUX21_K_0_7 : MUX21_L_312 port map( A => A(8), B => A(7), S => B(0), Y => 
                           TMP_1_8_port);
   MUX21_K_0_8 : MUX21_L_311 port map( A => A(9), B => A(8), S => B(0), Y => 
                           TMP_1_9_port);
   MUX21_K_0_9 : MUX21_L_310 port map( A => A(10), B => A(9), S => B(0), Y => 
                           TMP_1_10_port);
   MUX21_K_0_10 : MUX21_L_309 port map( A => A(11), B => A(10), S => B(0), Y =>
                           TMP_1_11_port);
   MUX21_K_0_11 : MUX21_L_308 port map( A => A(12), B => A(11), S => B(0), Y =>
                           TMP_1_12_port);
   MUX21_K_0_12 : MUX21_L_307 port map( A => A(13), B => A(12), S => B(0), Y =>
                           TMP_1_13_port);
   MUX21_K_0_13 : MUX21_L_306 port map( A => A(14), B => A(13), S => B(0), Y =>
                           TMP_1_14_port);
   MUX21_K_0_14 : MUX21_L_305 port map( A => A(15), B => A(14), S => B(0), Y =>
                           TMP_1_15_port);
   MUX21_K_0_15 : MUX21_L_304 port map( A => A(16), B => A(15), S => B(0), Y =>
                           TMP_1_16_port);
   MUX21_K_0_16 : MUX21_L_303 port map( A => A(17), B => A(16), S => B(0), Y =>
                           TMP_1_17_port);
   MUX21_K_0_17 : MUX21_L_302 port map( A => A(18), B => A(17), S => B(0), Y =>
                           TMP_1_18_port);
   MUX21_K_0_18 : MUX21_L_301 port map( A => A(19), B => A(18), S => B(0), Y =>
                           TMP_1_19_port);
   MUX21_K_0_19 : MUX21_L_300 port map( A => A(20), B => A(19), S => B(0), Y =>
                           TMP_1_20_port);
   MUX21_K_0_20 : MUX21_L_299 port map( A => A(21), B => A(20), S => B(0), Y =>
                           TMP_1_21_port);
   MUX21_K_0_21 : MUX21_L_298 port map( A => A(22), B => A(21), S => B(0), Y =>
                           TMP_1_22_port);
   MUX21_K_0_22 : MUX21_L_297 port map( A => A(23), B => A(22), S => B(0), Y =>
                           TMP_1_23_port);
   MUX21_K_0_23 : MUX21_L_296 port map( A => A(24), B => A(23), S => B(0), Y =>
                           TMP_1_24_port);
   MUX21_K_0_24 : MUX21_L_295 port map( A => A(25), B => A(24), S => B(0), Y =>
                           TMP_1_25_port);
   MUX21_K_0_25 : MUX21_L_294 port map( A => A(26), B => A(25), S => B(0), Y =>
                           TMP_1_26_port);
   MUX21_K_0_26 : MUX21_L_293 port map( A => A(27), B => A(26), S => B(0), Y =>
                           TMP_1_27_port);
   MUX21_K_0_27 : MUX21_L_292 port map( A => A(28), B => A(27), S => B(0), Y =>
                           TMP_1_28_port);
   MUX21_K_0_28 : MUX21_L_291 port map( A => A(29), B => A(28), S => B(0), Y =>
                           TMP_1_29_port);
   MUX21_K_0_29 : MUX21_L_290 port map( A => A(30), B => A(29), S => B(0), Y =>
                           TMP_1_30_port);
   MUX21_K_0_30 : MUX21_L_289 port map( A => A(31), B => A(30), S => B(0), Y =>
                           TMP_1_31_port);
   MUX21_J_1_0 : MUX21_L_288 port map( A => TMP_1_0_port, B => n41, S => B(1), 
                           Y => TMP_2_0_port);
   MUX21_J_1_1 : MUX21_L_287 port map( A => TMP_1_1_port, B => n41, S => B(1), 
                           Y => TMP_2_1_port);
   MUX21_K_1_0 : MUX21_L_286 port map( A => TMP_1_2_port, B => TMP_1_0_port, S 
                           => B(1), Y => TMP_2_2_port);
   MUX21_K_1_1 : MUX21_L_285 port map( A => TMP_1_3_port, B => TMP_1_1_port, S 
                           => B(1), Y => TMP_2_3_port);
   MUX21_K_1_2 : MUX21_L_284 port map( A => TMP_1_4_port, B => TMP_1_2_port, S 
                           => B(1), Y => TMP_2_4_port);
   MUX21_K_1_3 : MUX21_L_283 port map( A => TMP_1_5_port, B => TMP_1_3_port, S 
                           => B(1), Y => TMP_2_5_port);
   MUX21_K_1_4 : MUX21_L_282 port map( A => TMP_1_6_port, B => TMP_1_4_port, S 
                           => B(1), Y => TMP_2_6_port);
   MUX21_K_1_5 : MUX21_L_281 port map( A => TMP_1_7_port, B => TMP_1_5_port, S 
                           => B(1), Y => TMP_2_7_port);
   MUX21_K_1_6 : MUX21_L_280 port map( A => TMP_1_8_port, B => TMP_1_6_port, S 
                           => B(1), Y => TMP_2_8_port);
   MUX21_K_1_7 : MUX21_L_279 port map( A => TMP_1_9_port, B => TMP_1_7_port, S 
                           => B(1), Y => TMP_2_9_port);
   MUX21_K_1_8 : MUX21_L_278 port map( A => TMP_1_10_port, B => TMP_1_8_port, S
                           => B(1), Y => TMP_2_10_port);
   MUX21_K_1_9 : MUX21_L_277 port map( A => TMP_1_11_port, B => TMP_1_9_port, S
                           => B(1), Y => TMP_2_11_port);
   MUX21_K_1_10 : MUX21_L_276 port map( A => TMP_1_12_port, B => TMP_1_10_port,
                           S => B(1), Y => TMP_2_12_port);
   MUX21_K_1_11 : MUX21_L_275 port map( A => TMP_1_13_port, B => TMP_1_11_port,
                           S => B(1), Y => TMP_2_13_port);
   MUX21_K_1_12 : MUX21_L_274 port map( A => TMP_1_14_port, B => TMP_1_12_port,
                           S => B(1), Y => TMP_2_14_port);
   MUX21_K_1_13 : MUX21_L_273 port map( A => TMP_1_15_port, B => TMP_1_13_port,
                           S => B(1), Y => TMP_2_15_port);
   MUX21_K_1_14 : MUX21_L_272 port map( A => TMP_1_16_port, B => TMP_1_14_port,
                           S => B(1), Y => TMP_2_16_port);
   MUX21_K_1_15 : MUX21_L_271 port map( A => TMP_1_17_port, B => TMP_1_15_port,
                           S => B(1), Y => TMP_2_17_port);
   MUX21_K_1_16 : MUX21_L_270 port map( A => TMP_1_18_port, B => TMP_1_16_port,
                           S => B(1), Y => TMP_2_18_port);
   MUX21_K_1_17 : MUX21_L_269 port map( A => TMP_1_19_port, B => TMP_1_17_port,
                           S => B(1), Y => TMP_2_19_port);
   MUX21_K_1_18 : MUX21_L_268 port map( A => TMP_1_20_port, B => TMP_1_18_port,
                           S => B(1), Y => TMP_2_20_port);
   MUX21_K_1_19 : MUX21_L_267 port map( A => TMP_1_21_port, B => TMP_1_19_port,
                           S => B(1), Y => TMP_2_21_port);
   MUX21_K_1_20 : MUX21_L_266 port map( A => TMP_1_22_port, B => TMP_1_20_port,
                           S => B(1), Y => TMP_2_22_port);
   MUX21_K_1_21 : MUX21_L_265 port map( A => TMP_1_23_port, B => TMP_1_21_port,
                           S => B(1), Y => TMP_2_23_port);
   MUX21_K_1_22 : MUX21_L_264 port map( A => TMP_1_24_port, B => TMP_1_22_port,
                           S => B(1), Y => TMP_2_24_port);
   MUX21_K_1_23 : MUX21_L_263 port map( A => TMP_1_25_port, B => TMP_1_23_port,
                           S => B(1), Y => TMP_2_25_port);
   MUX21_K_1_24 : MUX21_L_262 port map( A => TMP_1_26_port, B => TMP_1_24_port,
                           S => B(1), Y => TMP_2_26_port);
   MUX21_K_1_25 : MUX21_L_261 port map( A => TMP_1_27_port, B => TMP_1_25_port,
                           S => B(1), Y => TMP_2_27_port);
   MUX21_K_1_26 : MUX21_L_260 port map( A => TMP_1_28_port, B => TMP_1_26_port,
                           S => B(1), Y => TMP_2_28_port);
   MUX21_K_1_27 : MUX21_L_259 port map( A => TMP_1_29_port, B => TMP_1_27_port,
                           S => B(1), Y => TMP_2_29_port);
   MUX21_K_1_28 : MUX21_L_258 port map( A => TMP_1_30_port, B => TMP_1_28_port,
                           S => B(1), Y => TMP_2_30_port);
   MUX21_K_1_29 : MUX21_L_257 port map( A => TMP_1_31_port, B => TMP_1_29_port,
                           S => B(1), Y => TMP_2_31_port);
   MUX21_J_2_0 : MUX21_L_256 port map( A => TMP_2_0_port, B => n41, S => B(2), 
                           Y => TMP_3_0_port);
   MUX21_J_2_1 : MUX21_L_255 port map( A => TMP_2_1_port, B => n41, S => B(2), 
                           Y => TMP_3_1_port);
   MUX21_J_2_2 : MUX21_L_254 port map( A => TMP_2_2_port, B => n41, S => B(2), 
                           Y => TMP_3_2_port);
   MUX21_J_2_3 : MUX21_L_253 port map( A => TMP_2_3_port, B => n41, S => B(2), 
                           Y => TMP_3_3_port);
   MUX21_K_2_0 : MUX21_L_252 port map( A => TMP_2_4_port, B => TMP_2_0_port, S 
                           => B(2), Y => TMP_3_4_port);
   MUX21_K_2_1 : MUX21_L_251 port map( A => TMP_2_5_port, B => TMP_2_1_port, S 
                           => B(2), Y => TMP_3_5_port);
   MUX21_K_2_2 : MUX21_L_250 port map( A => TMP_2_6_port, B => TMP_2_2_port, S 
                           => B(2), Y => TMP_3_6_port);
   MUX21_K_2_3 : MUX21_L_249 port map( A => TMP_2_7_port, B => TMP_2_3_port, S 
                           => B(2), Y => TMP_3_7_port);
   MUX21_K_2_4 : MUX21_L_248 port map( A => TMP_2_8_port, B => TMP_2_4_port, S 
                           => B(2), Y => TMP_3_8_port);
   MUX21_K_2_5 : MUX21_L_247 port map( A => TMP_2_9_port, B => TMP_2_5_port, S 
                           => B(2), Y => TMP_3_9_port);
   MUX21_K_2_6 : MUX21_L_246 port map( A => TMP_2_10_port, B => TMP_2_6_port, S
                           => B(2), Y => TMP_3_10_port);
   MUX21_K_2_7 : MUX21_L_245 port map( A => TMP_2_11_port, B => TMP_2_7_port, S
                           => B(2), Y => TMP_3_11_port);
   MUX21_K_2_8 : MUX21_L_244 port map( A => TMP_2_12_port, B => TMP_2_8_port, S
                           => B(2), Y => TMP_3_12_port);
   MUX21_K_2_9 : MUX21_L_243 port map( A => TMP_2_13_port, B => TMP_2_9_port, S
                           => B(2), Y => TMP_3_13_port);
   MUX21_K_2_10 : MUX21_L_242 port map( A => TMP_2_14_port, B => TMP_2_10_port,
                           S => B(2), Y => TMP_3_14_port);
   MUX21_K_2_11 : MUX21_L_241 port map( A => TMP_2_15_port, B => TMP_2_11_port,
                           S => B(2), Y => TMP_3_15_port);
   MUX21_K_2_12 : MUX21_L_240 port map( A => TMP_2_16_port, B => TMP_2_12_port,
                           S => B(2), Y => TMP_3_16_port);
   MUX21_K_2_13 : MUX21_L_239 port map( A => TMP_2_17_port, B => TMP_2_13_port,
                           S => B(2), Y => TMP_3_17_port);
   MUX21_K_2_14 : MUX21_L_238 port map( A => TMP_2_18_port, B => TMP_2_14_port,
                           S => B(2), Y => TMP_3_18_port);
   MUX21_K_2_15 : MUX21_L_237 port map( A => TMP_2_19_port, B => TMP_2_15_port,
                           S => B(2), Y => TMP_3_19_port);
   MUX21_K_2_16 : MUX21_L_236 port map( A => TMP_2_20_port, B => TMP_2_16_port,
                           S => B(2), Y => TMP_3_20_port);
   MUX21_K_2_17 : MUX21_L_235 port map( A => TMP_2_21_port, B => TMP_2_17_port,
                           S => B(2), Y => TMP_3_21_port);
   MUX21_K_2_18 : MUX21_L_234 port map( A => TMP_2_22_port, B => TMP_2_18_port,
                           S => B(2), Y => TMP_3_22_port);
   MUX21_K_2_19 : MUX21_L_233 port map( A => TMP_2_23_port, B => TMP_2_19_port,
                           S => B(2), Y => TMP_3_23_port);
   MUX21_K_2_20 : MUX21_L_232 port map( A => TMP_2_24_port, B => TMP_2_20_port,
                           S => B(2), Y => TMP_3_24_port);
   MUX21_K_2_21 : MUX21_L_231 port map( A => TMP_2_25_port, B => TMP_2_21_port,
                           S => B(2), Y => TMP_3_25_port);
   MUX21_K_2_22 : MUX21_L_230 port map( A => TMP_2_26_port, B => TMP_2_22_port,
                           S => B(2), Y => TMP_3_26_port);
   MUX21_K_2_23 : MUX21_L_229 port map( A => TMP_2_27_port, B => TMP_2_23_port,
                           S => B(2), Y => TMP_3_27_port);
   MUX21_K_2_24 : MUX21_L_228 port map( A => TMP_2_28_port, B => TMP_2_24_port,
                           S => B(2), Y => TMP_3_28_port);
   MUX21_K_2_25 : MUX21_L_227 port map( A => TMP_2_29_port, B => TMP_2_25_port,
                           S => B(2), Y => TMP_3_29_port);
   MUX21_K_2_26 : MUX21_L_226 port map( A => TMP_2_30_port, B => TMP_2_26_port,
                           S => B(2), Y => TMP_3_30_port);
   MUX21_K_2_27 : MUX21_L_225 port map( A => TMP_2_31_port, B => TMP_2_27_port,
                           S => B(2), Y => TMP_3_31_port);
   MUX21_J_3_0 : MUX21_L_224 port map( A => TMP_3_0_port, B => n41, S => B(3), 
                           Y => TMP_4_0_port);
   MUX21_J_3_1 : MUX21_L_223 port map( A => TMP_3_1_port, B => n41, S => B(3), 
                           Y => TMP_4_1_port);
   MUX21_J_3_2 : MUX21_L_222 port map( A => TMP_3_2_port, B => n41, S => B(3), 
                           Y => TMP_4_2_port);
   MUX21_J_3_3 : MUX21_L_221 port map( A => TMP_3_3_port, B => n41, S => B(3), 
                           Y => TMP_4_3_port);
   MUX21_J_3_4 : MUX21_L_220 port map( A => TMP_3_4_port, B => n41, S => B(3), 
                           Y => TMP_4_4_port);
   MUX21_J_3_5 : MUX21_L_219 port map( A => TMP_3_5_port, B => n41, S => B(3), 
                           Y => TMP_4_5_port);
   MUX21_J_3_6 : MUX21_L_218 port map( A => TMP_3_6_port, B => n41, S => B(3), 
                           Y => TMP_4_6_port);
   MUX21_J_3_7 : MUX21_L_217 port map( A => TMP_3_7_port, B => n41, S => B(3), 
                           Y => TMP_4_7_port);
   MUX21_K_3_0 : MUX21_L_216 port map( A => TMP_3_8_port, B => TMP_3_0_port, S 
                           => B(3), Y => TMP_4_8_port);
   MUX21_K_3_1 : MUX21_L_215 port map( A => TMP_3_9_port, B => TMP_3_1_port, S 
                           => B(3), Y => TMP_4_9_port);
   MUX21_K_3_2 : MUX21_L_214 port map( A => TMP_3_10_port, B => TMP_3_2_port, S
                           => B(3), Y => TMP_4_10_port);
   MUX21_K_3_3 : MUX21_L_213 port map( A => TMP_3_11_port, B => TMP_3_3_port, S
                           => B(3), Y => TMP_4_11_port);
   MUX21_K_3_4 : MUX21_L_212 port map( A => TMP_3_12_port, B => TMP_3_4_port, S
                           => B(3), Y => TMP_4_12_port);
   MUX21_K_3_5 : MUX21_L_211 port map( A => TMP_3_13_port, B => TMP_3_5_port, S
                           => B(3), Y => TMP_4_13_port);
   MUX21_K_3_6 : MUX21_L_210 port map( A => TMP_3_14_port, B => TMP_3_6_port, S
                           => B(3), Y => TMP_4_14_port);
   MUX21_K_3_7 : MUX21_L_209 port map( A => TMP_3_15_port, B => TMP_3_7_port, S
                           => B(3), Y => TMP_4_15_port);
   MUX21_K_3_8 : MUX21_L_208 port map( A => TMP_3_16_port, B => TMP_3_8_port, S
                           => B(3), Y => TMP_4_16_port);
   MUX21_K_3_9 : MUX21_L_207 port map( A => TMP_3_17_port, B => TMP_3_9_port, S
                           => B(3), Y => TMP_4_17_port);
   MUX21_K_3_10 : MUX21_L_206 port map( A => TMP_3_18_port, B => TMP_3_10_port,
                           S => B(3), Y => TMP_4_18_port);
   MUX21_K_3_11 : MUX21_L_205 port map( A => TMP_3_19_port, B => TMP_3_11_port,
                           S => B(3), Y => TMP_4_19_port);
   MUX21_K_3_12 : MUX21_L_204 port map( A => TMP_3_20_port, B => TMP_3_12_port,
                           S => B(3), Y => TMP_4_20_port);
   MUX21_K_3_13 : MUX21_L_203 port map( A => TMP_3_21_port, B => TMP_3_13_port,
                           S => B(3), Y => TMP_4_21_port);
   MUX21_K_3_14 : MUX21_L_202 port map( A => TMP_3_22_port, B => TMP_3_14_port,
                           S => B(3), Y => TMP_4_22_port);
   MUX21_K_3_15 : MUX21_L_201 port map( A => TMP_3_23_port, B => TMP_3_15_port,
                           S => B(3), Y => TMP_4_23_port);
   MUX21_K_3_16 : MUX21_L_200 port map( A => TMP_3_24_port, B => TMP_3_16_port,
                           S => B(3), Y => TMP_4_24_port);
   MUX21_K_3_17 : MUX21_L_199 port map( A => TMP_3_25_port, B => TMP_3_17_port,
                           S => B(3), Y => TMP_4_25_port);
   MUX21_K_3_18 : MUX21_L_198 port map( A => TMP_3_26_port, B => TMP_3_18_port,
                           S => B(3), Y => TMP_4_26_port);
   MUX21_K_3_19 : MUX21_L_197 port map( A => TMP_3_27_port, B => TMP_3_19_port,
                           S => B(3), Y => TMP_4_27_port);
   MUX21_K_3_20 : MUX21_L_196 port map( A => TMP_3_28_port, B => TMP_3_20_port,
                           S => B(3), Y => TMP_4_28_port);
   MUX21_K_3_21 : MUX21_L_195 port map( A => TMP_3_29_port, B => TMP_3_21_port,
                           S => B(3), Y => TMP_4_29_port);
   MUX21_K_3_22 : MUX21_L_194 port map( A => TMP_3_30_port, B => TMP_3_22_port,
                           S => B(3), Y => TMP_4_30_port);
   MUX21_K_3_23 : MUX21_L_193 port map( A => TMP_3_31_port, B => TMP_3_23_port,
                           S => B(3), Y => TMP_4_31_port);
   MUX21_J_4_0 : MUX21_L_192 port map( A => TMP_4_0_port, B => n41, S => B(4), 
                           Y => Y(0));
   MUX21_J_4_1 : MUX21_L_191 port map( A => TMP_4_1_port, B => n41, S => B(4), 
                           Y => Y(1));
   MUX21_J_4_2 : MUX21_L_190 port map( A => TMP_4_2_port, B => n41, S => B(4), 
                           Y => Y(2));
   MUX21_J_4_3 : MUX21_L_189 port map( A => TMP_4_3_port, B => n41, S => B(4), 
                           Y => Y(3));
   MUX21_J_4_4 : MUX21_L_188 port map( A => TMP_4_4_port, B => n41, S => B(4), 
                           Y => Y(4));
   MUX21_J_4_5 : MUX21_L_187 port map( A => TMP_4_5_port, B => n41, S => B(4), 
                           Y => Y(5));
   MUX21_J_4_6 : MUX21_L_186 port map( A => TMP_4_6_port, B => n41, S => B(4), 
                           Y => Y(6));
   MUX21_J_4_7 : MUX21_L_185 port map( A => TMP_4_7_port, B => n41, S => B(4), 
                           Y => Y(7));
   MUX21_J_4_8 : MUX21_L_184 port map( A => TMP_4_8_port, B => n41, S => B(4), 
                           Y => Y(8));
   MUX21_J_4_9 : MUX21_L_183 port map( A => TMP_4_9_port, B => n41, S => B(4), 
                           Y => Y(9));
   MUX21_J_4_10 : MUX21_L_182 port map( A => TMP_4_10_port, B => n41, S => B(4)
                           , Y => Y(10));
   MUX21_J_4_11 : MUX21_L_181 port map( A => TMP_4_11_port, B => n41, S => B(4)
                           , Y => Y(11));
   MUX21_J_4_12 : MUX21_L_180 port map( A => TMP_4_12_port, B => n41, S => B(4)
                           , Y => Y(12));
   MUX21_J_4_13 : MUX21_L_179 port map( A => TMP_4_13_port, B => n41, S => B(4)
                           , Y => Y(13));
   MUX21_J_4_14 : MUX21_L_178 port map( A => TMP_4_14_port, B => n41, S => B(4)
                           , Y => Y(14));
   MUX21_J_4_15 : MUX21_L_177 port map( A => TMP_4_15_port, B => n41, S => B(4)
                           , Y => Y(15));
   MUX21_K_4_0 : MUX21_L_176 port map( A => TMP_4_16_port, B => TMP_4_0_port, S
                           => B(4), Y => Y(16));
   MUX21_K_4_1 : MUX21_L_175 port map( A => TMP_4_17_port, B => TMP_4_1_port, S
                           => B(4), Y => Y(17));
   MUX21_K_4_2 : MUX21_L_174 port map( A => TMP_4_18_port, B => TMP_4_2_port, S
                           => B(4), Y => Y(18));
   MUX21_K_4_3 : MUX21_L_173 port map( A => TMP_4_19_port, B => TMP_4_3_port, S
                           => B(4), Y => Y(19));
   MUX21_K_4_4 : MUX21_L_172 port map( A => TMP_4_20_port, B => TMP_4_4_port, S
                           => B(4), Y => Y(20));
   MUX21_K_4_5 : MUX21_L_171 port map( A => TMP_4_21_port, B => TMP_4_5_port, S
                           => B(4), Y => Y(21));
   MUX21_K_4_6 : MUX21_L_170 port map( A => TMP_4_22_port, B => TMP_4_6_port, S
                           => B(4), Y => Y(22));
   MUX21_K_4_7 : MUX21_L_169 port map( A => TMP_4_23_port, B => TMP_4_7_port, S
                           => B(4), Y => Y(23));
   MUX21_K_4_8 : MUX21_L_168 port map( A => TMP_4_24_port, B => TMP_4_8_port, S
                           => B(4), Y => Y(24));
   MUX21_K_4_9 : MUX21_L_167 port map( A => TMP_4_25_port, B => TMP_4_9_port, S
                           => B(4), Y => Y(25));
   MUX21_K_4_10 : MUX21_L_166 port map( A => TMP_4_26_port, B => TMP_4_10_port,
                           S => B(4), Y => Y(26));
   MUX21_K_4_11 : MUX21_L_165 port map( A => TMP_4_27_port, B => TMP_4_11_port,
                           S => B(4), Y => Y(27));
   MUX21_K_4_12 : MUX21_L_164 port map( A => TMP_4_28_port, B => TMP_4_12_port,
                           S => B(4), Y => Y(28));
   MUX21_K_4_13 : MUX21_L_163 port map( A => TMP_4_29_port, B => TMP_4_13_port,
                           S => B(4), Y => Y(29));
   MUX21_K_4_14 : MUX21_L_162 port map( A => TMP_4_30_port, B => TMP_4_14_port,
                           S => B(4), Y => Y(30));
   MUX21_K_4_15 : MUX21_L_161 port map( A => TMP_4_31_port, B => TMP_4_15_port,
                           S => B(4), Y => Y(31));
   n41 <= '0';

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity P4_ADDER_N32_NB8 is

   port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic;  S : out
         std_logic_vector (31 downto 0);  Co : out std_logic);

end P4_ADDER_N32_NB8;

architecture SYN_STRUCTURAL of P4_ADDER_N32_NB8 is

   component SUM_GENERATOR_N32_NB8
      port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic_vector
            (7 downto 0);  S : out std_logic_vector (31 downto 0));
   end component;
   
   component CARRY_GENERATOR_N32_NB8
      port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic;  Co :
            out std_logic_vector (7 downto 0));
   end component;
   
   signal CarriesOut_6_port, CarriesOut_5_port, CarriesOut_4_port, 
      CarriesOut_3_port, CarriesOut_2_port, CarriesOut_1_port, 
      CarriesOut_0_port : std_logic;

begin
   
   CARRY_GENERATOR_INSTANCE : CARRY_GENERATOR_N32_NB8 port map( A(31) => A(31),
                           A(30) => A(30), A(29) => A(29), A(28) => A(28), 
                           A(27) => A(27), A(26) => A(26), A(25) => A(25), 
                           A(24) => A(24), A(23) => A(23), A(22) => A(22), 
                           A(21) => A(21), A(20) => A(20), A(19) => A(19), 
                           A(18) => A(18), A(17) => A(17), A(16) => A(16), 
                           A(15) => A(15), A(14) => A(14), A(13) => A(13), 
                           A(12) => A(12), A(11) => A(11), A(10) => A(10), A(9)
                           => A(9), A(8) => A(8), A(7) => A(7), A(6) => A(6), 
                           A(5) => A(5), A(4) => A(4), A(3) => A(3), A(2) => 
                           A(2), A(1) => A(1), A(0) => A(0), B(31) => B(31), 
                           B(30) => B(30), B(29) => B(29), B(28) => B(28), 
                           B(27) => B(27), B(26) => B(26), B(25) => B(25), 
                           B(24) => B(24), B(23) => B(23), B(22) => B(22), 
                           B(21) => B(21), B(20) => B(20), B(19) => B(19), 
                           B(18) => B(18), B(17) => B(17), B(16) => B(16), 
                           B(15) => B(15), B(14) => B(14), B(13) => B(13), 
                           B(12) => B(12), B(11) => B(11), B(10) => B(10), B(9)
                           => B(9), B(8) => B(8), B(7) => B(7), B(6) => B(6), 
                           B(5) => B(5), B(4) => B(4), B(3) => B(3), B(2) => 
                           B(2), B(1) => B(1), B(0) => B(0), Ci => Ci, Co(7) =>
                           Co, Co(6) => CarriesOut_6_port, Co(5) => 
                           CarriesOut_5_port, Co(4) => CarriesOut_4_port, Co(3)
                           => CarriesOut_3_port, Co(2) => CarriesOut_2_port, 
                           Co(1) => CarriesOut_1_port, Co(0) => 
                           CarriesOut_0_port);
   SUM_GENERATOR_INSTANCE : SUM_GENERATOR_N32_NB8 port map( A(31) => A(31), 
                           A(30) => A(30), A(29) => A(29), A(28) => A(28), 
                           A(27) => A(27), A(26) => A(26), A(25) => A(25), 
                           A(24) => A(24), A(23) => A(23), A(22) => A(22), 
                           A(21) => A(21), A(20) => A(20), A(19) => A(19), 
                           A(18) => A(18), A(17) => A(17), A(16) => A(16), 
                           A(15) => A(15), A(14) => A(14), A(13) => A(13), 
                           A(12) => A(12), A(11) => A(11), A(10) => A(10), A(9)
                           => A(9), A(8) => A(8), A(7) => A(7), A(6) => A(6), 
                           A(5) => A(5), A(4) => A(4), A(3) => A(3), A(2) => 
                           A(2), A(1) => A(1), A(0) => A(0), B(31) => B(31), 
                           B(30) => B(30), B(29) => B(29), B(28) => B(28), 
                           B(27) => B(27), B(26) => B(26), B(25) => B(25), 
                           B(24) => B(24), B(23) => B(23), B(22) => B(22), 
                           B(21) => B(21), B(20) => B(20), B(19) => B(19), 
                           B(18) => B(18), B(17) => B(17), B(16) => B(16), 
                           B(15) => B(15), B(14) => B(14), B(13) => B(13), 
                           B(12) => B(12), B(11) => B(11), B(10) => B(10), B(9)
                           => B(9), B(8) => B(8), B(7) => B(7), B(6) => B(6), 
                           B(5) => B(5), B(4) => B(4), B(3) => B(3), B(2) => 
                           B(2), B(1) => B(1), B(0) => B(0), Ci(7) => 
                           CarriesOut_6_port, Ci(6) => CarriesOut_5_port, Ci(5)
                           => CarriesOut_4_port, Ci(4) => CarriesOut_3_port, 
                           Ci(3) => CarriesOut_2_port, Ci(2) => 
                           CarriesOut_1_port, Ci(1) => CarriesOut_0_port, Ci(0)
                           => Ci, S(31) => S(31), S(30) => S(30), S(29) => 
                           S(29), S(28) => S(28), S(27) => S(27), S(26) => 
                           S(26), S(25) => S(25), S(24) => S(24), S(23) => 
                           S(23), S(22) => S(22), S(21) => S(21), S(20) => 
                           S(20), S(19) => S(19), S(18) => S(18), S(17) => 
                           S(17), S(16) => S(16), S(15) => S(15), S(14) => 
                           S(14), S(13) => S(13), S(12) => S(12), S(11) => 
                           S(11), S(10) => S(10), S(9) => S(9), S(8) => S(8), 
                           S(7) => S(7), S(6) => S(6), S(5) => S(5), S(4) => 
                           S(4), S(3) => S(3), S(2) => S(2), S(1) => S(1), S(0)
                           => S(0));

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity 
   DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32_DW01_add_0 
   is

   port( A, B : in std_logic_vector (31 downto 0);  CI : in std_logic;  SUM : 
         out std_logic_vector (31 downto 0);  CO : out std_logic);

end DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32_DW01_add_0
   ;

architecture SYN_rpl of 
   DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32_DW01_add_0 
   is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component XNOR2_X1
      port( A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   signal n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
      , n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, SUM_30_port, 
      SUM_29_port, SUM_28_port, SUM_27_port, SUM_26_port, SUM_25_port, 
      SUM_24_port, SUM_23_port, SUM_22_port, SUM_21_port, SUM_20_port, 
      SUM_19_port, SUM_18_port, SUM_17_port, SUM_16_port, SUM_15_port, 
      SUM_14_port, SUM_13_port, SUM_12_port, SUM_11_port, SUM_10_port, 
      SUM_9_port, SUM_8_port, SUM_7_port, SUM_6_port, SUM_5_port, SUM_4_port, 
      SUM_3_port, SUM_31_port, n57, SUM_2_port : std_logic;

begin
   SUM <= ( SUM_31_port, SUM_30_port, SUM_29_port, SUM_28_port, SUM_27_port, 
      SUM_26_port, SUM_25_port, SUM_24_port, SUM_23_port, SUM_22_port, 
      SUM_21_port, SUM_20_port, SUM_19_port, SUM_18_port, SUM_17_port, 
      SUM_16_port, SUM_15_port, SUM_14_port, SUM_13_port, SUM_12_port, 
      SUM_11_port, SUM_10_port, SUM_9_port, SUM_8_port, SUM_7_port, SUM_6_port,
      SUM_5_port, SUM_4_port, SUM_3_port, SUM_2_port, A(1), A(0) );
   
   U28 : XOR2_X1 port map( A => A(30), B => n27, Z => SUM_30_port);
   U29 : XOR2_X1 port map( A => A(29), B => n26, Z => SUM_29_port);
   U30 : XOR2_X1 port map( A => A(28), B => n25, Z => SUM_28_port);
   U31 : XOR2_X1 port map( A => A(27), B => n24, Z => SUM_27_port);
   U32 : XOR2_X1 port map( A => A(26), B => n23, Z => SUM_26_port);
   U33 : XOR2_X1 port map( A => A(25), B => n22, Z => SUM_25_port);
   U34 : XOR2_X1 port map( A => A(24), B => n21, Z => SUM_24_port);
   U35 : XOR2_X1 port map( A => A(23), B => n20, Z => SUM_23_port);
   U36 : XOR2_X1 port map( A => A(22), B => n19, Z => SUM_22_port);
   U37 : XOR2_X1 port map( A => A(21), B => n18, Z => SUM_21_port);
   U38 : XOR2_X1 port map( A => A(20), B => n17, Z => SUM_20_port);
   U39 : XOR2_X1 port map( A => A(19), B => n16, Z => SUM_19_port);
   U40 : XOR2_X1 port map( A => A(18), B => n15, Z => SUM_18_port);
   U41 : XOR2_X1 port map( A => A(17), B => n14, Z => SUM_17_port);
   U42 : XOR2_X1 port map( A => A(16), B => n13, Z => SUM_16_port);
   U43 : XOR2_X1 port map( A => A(15), B => n12, Z => SUM_15_port);
   U44 : XOR2_X1 port map( A => A(14), B => n11, Z => SUM_14_port);
   U45 : XOR2_X1 port map( A => A(13), B => n10, Z => SUM_13_port);
   U46 : XOR2_X1 port map( A => A(12), B => n9, Z => SUM_12_port);
   U47 : XOR2_X1 port map( A => A(11), B => n8, Z => SUM_11_port);
   U48 : XOR2_X1 port map( A => A(10), B => n7, Z => SUM_10_port);
   U49 : XOR2_X1 port map( A => A(9), B => n6, Z => SUM_9_port);
   U50 : XOR2_X1 port map( A => A(8), B => n5, Z => SUM_8_port);
   U51 : XOR2_X1 port map( A => A(7), B => n4, Z => SUM_7_port);
   U52 : XOR2_X1 port map( A => A(6), B => n3, Z => SUM_6_port);
   U53 : XOR2_X1 port map( A => A(5), B => n2, Z => SUM_5_port);
   U54 : XOR2_X1 port map( A => A(4), B => n1, Z => SUM_4_port);
   U55 : XOR2_X1 port map( A => A(3), B => A(2), Z => SUM_3_port);
   U1 : AND2_X1 port map( A1 => A(29), A2 => n26, ZN => n27);
   U2 : XNOR2_X1 port map( A => A(31), B => n57, ZN => SUM_31_port);
   U3 : NAND2_X1 port map( A1 => A(30), A2 => n27, ZN => n57);
   U4 : AND2_X1 port map( A1 => A(4), A2 => n1, ZN => n2);
   U5 : AND2_X1 port map( A1 => A(5), A2 => n2, ZN => n3);
   U6 : AND2_X1 port map( A1 => A(6), A2 => n3, ZN => n4);
   U7 : AND2_X1 port map( A1 => A(7), A2 => n4, ZN => n5);
   U8 : AND2_X1 port map( A1 => A(8), A2 => n5, ZN => n6);
   U9 : AND2_X1 port map( A1 => A(9), A2 => n6, ZN => n7);
   U10 : AND2_X1 port map( A1 => A(10), A2 => n7, ZN => n8);
   U11 : AND2_X1 port map( A1 => A(11), A2 => n8, ZN => n9);
   U12 : AND2_X1 port map( A1 => A(12), A2 => n9, ZN => n10);
   U13 : AND2_X1 port map( A1 => A(13), A2 => n10, ZN => n11);
   U14 : AND2_X1 port map( A1 => A(14), A2 => n11, ZN => n12);
   U15 : AND2_X1 port map( A1 => A(15), A2 => n12, ZN => n13);
   U16 : AND2_X1 port map( A1 => A(16), A2 => n13, ZN => n14);
   U17 : AND2_X1 port map( A1 => A(17), A2 => n14, ZN => n15);
   U18 : AND2_X1 port map( A1 => A(18), A2 => n15, ZN => n16);
   U19 : AND2_X1 port map( A1 => A(19), A2 => n16, ZN => n17);
   U20 : AND2_X1 port map( A1 => A(20), A2 => n17, ZN => n18);
   U21 : AND2_X1 port map( A1 => A(21), A2 => n18, ZN => n19);
   U22 : AND2_X1 port map( A1 => A(22), A2 => n19, ZN => n20);
   U23 : AND2_X1 port map( A1 => A(23), A2 => n20, ZN => n21);
   U24 : AND2_X1 port map( A1 => A(24), A2 => n21, ZN => n22);
   U25 : AND2_X1 port map( A1 => A(25), A2 => n22, ZN => n23);
   U26 : AND2_X1 port map( A1 => A(26), A2 => n23, ZN => n24);
   U27 : AND2_X1 port map( A1 => A(27), A2 => n24, ZN => n25);
   U56 : AND2_X1 port map( A1 => A(28), A2 => n25, ZN => n26);
   U57 : AND2_X1 port map( A1 => A(3), A2 => A(2), ZN => n1);
   U58 : INV_X1 port map( A => A(2), ZN => SUM_2_port);

end SYN_rpl;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity FU_N5 is

   port( RS1, RS2, RD_MEM, RD_WB : in std_logic_vector (4 downto 0);  RF_WE_MEM
         , RF_WE_WB : in std_logic;  FORWARD_A, FORWARD_B : out 
         std_logic_vector (1 downto 0));

end FU_N5;

architecture SYN_BEHAVIORAL of FU_N5 is

   component XNOR2_X1
      port( A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   signal n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
      n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62 : 
      std_logic;

begin
   
   U2 : INV_X1 port map( A => n36, ZN => FORWARD_A(0));
   U3 : INV_X1 port map( A => n37, ZN => FORWARD_B(0));
   U4 : NOR4_X1 port map( A1 => n38, A2 => n39, A3 => n40, A4 => n41, ZN => 
                           FORWARD_B(1));
   U5 : XOR2_X1 port map( A => RS2(2), B => RD_WB(2), Z => n41);
   U6 : XOR2_X1 port map( A => RS2(3), B => RD_WB(3), Z => n40);
   U7 : XOR2_X1 port map( A => RS2(1), B => RD_WB(1), Z => n39);
   U8 : NAND4_X1 port map( A1 => n42, A2 => n43, A3 => RF_WE_WB, A4 => n37, ZN 
                           => n38);
   U9 : NAND4_X1 port map( A1 => n44, A2 => n45, A3 => n46, A4 => n47, ZN => 
                           n37);
   U10 : NOR3_X1 port map( A1 => n48, A2 => n49, A3 => n50, ZN => n47);
   U11 : XOR2_X1 port map( A => RS2(1), B => RD_MEM(1), Z => n50);
   U12 : XOR2_X1 port map( A => RS2(0), B => RD_MEM(0), Z => n48);
   U13 : XNOR2_X1 port map( A => RD_MEM(3), B => RS2(3), ZN => n46);
   U14 : XNOR2_X1 port map( A => RD_MEM(4), B => RS2(4), ZN => n45);
   U15 : XNOR2_X1 port map( A => RD_MEM(2), B => RS2(2), ZN => n44);
   U16 : XNOR2_X1 port map( A => RD_WB(4), B => RS2(4), ZN => n43);
   U17 : XNOR2_X1 port map( A => RD_WB(0), B => RS2(0), ZN => n42);
   U18 : NOR4_X1 port map( A1 => n51, A2 => n52, A3 => n53, A4 => n54, ZN => 
                           FORWARD_A(1));
   U19 : XOR2_X1 port map( A => RS1(2), B => RD_WB(2), Z => n54);
   U20 : XOR2_X1 port map( A => RS1(3), B => RD_WB(3), Z => n53);
   U21 : XOR2_X1 port map( A => RS1(1), B => RD_WB(1), Z => n52);
   U22 : NAND4_X1 port map( A1 => n55, A2 => n56, A3 => RF_WE_WB, A4 => n36, ZN
                           => n51);
   U23 : NAND4_X1 port map( A1 => n57, A2 => n58, A3 => n59, A4 => n60, ZN => 
                           n36);
   U24 : NOR3_X1 port map( A1 => n61, A2 => n49, A3 => n62, ZN => n60);
   U25 : XOR2_X1 port map( A => RS1(1), B => RD_MEM(1), Z => n62);
   U26 : INV_X1 port map( A => RF_WE_MEM, ZN => n49);
   U27 : XOR2_X1 port map( A => RS1(0), B => RD_MEM(0), Z => n61);
   U28 : XNOR2_X1 port map( A => RD_MEM(3), B => RS1(3), ZN => n59);
   U29 : XNOR2_X1 port map( A => RD_MEM(4), B => RS1(4), ZN => n58);
   U30 : XNOR2_X1 port map( A => RD_MEM(2), B => RS1(2), ZN => n57);
   U31 : XNOR2_X1 port map( A => RD_WB(4), B => RS1(4), ZN => n56);
   U32 : XNOR2_X1 port map( A => RD_WB(0), B => RS1(0), ZN => n55);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity ZERODET_N32 is

   port( A : in std_logic_vector (31 downto 0);  Y : out std_logic);

end ZERODET_N32;

architecture SYN_STRUCTURAL of ZERODET_N32 is

   component AND2_1
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_2
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_3
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_4
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_5
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_6
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_7
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_8
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_9
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_10
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_11
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_12
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_13
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_14
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_15
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_16
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_17
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_18
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_19
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_20
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_21
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_22
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_23
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_24
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_25
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_26
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_27
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_28
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_29
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_30
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component AND2_0
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_1
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_2
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_3
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_4
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_5
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_6
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_7
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_8
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_9
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_10
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_11
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_12
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_13
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_14
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_15
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_16
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_17
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_18
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_19
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_20
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_21
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_22
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_23
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_24
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_25
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_26
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_27
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_28
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_29
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_30
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_31
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   component XNOR2_0
      port( A, B : in std_logic;  Y : out std_logic);
   end component;
   
   signal M_4_1_port, M_4_0_port, M_3_3_port, M_3_2_port, M_3_1_port, 
      M_3_0_port, M_2_7_port, M_2_6_port, M_2_5_port, M_2_4_port, M_2_3_port, 
      M_2_2_port, M_2_1_port, M_2_0_port, M_1_9_port, M_1_8_port, M_1_7_port, 
      M_1_6_port, M_1_5_port, M_1_4_port, M_1_3_port, M_1_2_port, M_1_1_port, 
      M_1_15_port, M_1_14_port, M_1_13_port, M_1_12_port, M_1_11_port, 
      M_1_10_port, M_1_0_port, M_0_9_port, M_0_8_port, M_0_7_port, M_0_6_port, 
      M_0_5_port, M_0_4_port, M_0_3_port, M_0_31_port, M_0_30_port, M_0_2_port,
      M_0_29_port, M_0_28_port, M_0_27_port, M_0_26_port, M_0_25_port, 
      M_0_24_port, M_0_23_port, M_0_22_port, M_0_21_port, M_0_20_port, 
      M_0_1_port, M_0_19_port, M_0_18_port, M_0_17_port, M_0_16_port, 
      M_0_15_port, M_0_14_port, M_0_13_port, M_0_12_port, M_0_11_port, 
      M_0_10_port, M_0_0_port, n1 : std_logic;

begin
   
   XOR0_i_0_0 : XNOR2_0 port map( A => A(0), B => n1, Y => M_0_0_port);
   XOR0_i_0_1 : XNOR2_31 port map( A => A(1), B => n1, Y => M_0_1_port);
   XOR0_i_0_2 : XNOR2_30 port map( A => A(2), B => n1, Y => M_0_2_port);
   XOR0_i_0_3 : XNOR2_29 port map( A => A(3), B => n1, Y => M_0_3_port);
   XOR0_i_0_4 : XNOR2_28 port map( A => A(4), B => n1, Y => M_0_4_port);
   XOR0_i_0_5 : XNOR2_27 port map( A => A(5), B => n1, Y => M_0_5_port);
   XOR0_i_0_6 : XNOR2_26 port map( A => A(6), B => n1, Y => M_0_6_port);
   XOR0_i_0_7 : XNOR2_25 port map( A => A(7), B => n1, Y => M_0_7_port);
   XOR0_i_0_8 : XNOR2_24 port map( A => A(8), B => n1, Y => M_0_8_port);
   XOR0_i_0_9 : XNOR2_23 port map( A => A(9), B => n1, Y => M_0_9_port);
   XOR0_i_0_10 : XNOR2_22 port map( A => A(10), B => n1, Y => M_0_10_port);
   XOR0_i_0_11 : XNOR2_21 port map( A => A(11), B => n1, Y => M_0_11_port);
   XOR0_i_0_12 : XNOR2_20 port map( A => A(12), B => n1, Y => M_0_12_port);
   XOR0_i_0_13 : XNOR2_19 port map( A => A(13), B => n1, Y => M_0_13_port);
   XOR0_i_0_14 : XNOR2_18 port map( A => A(14), B => n1, Y => M_0_14_port);
   XOR0_i_0_15 : XNOR2_17 port map( A => A(15), B => n1, Y => M_0_15_port);
   XOR0_i_0_16 : XNOR2_16 port map( A => A(16), B => n1, Y => M_0_16_port);
   XOR0_i_0_17 : XNOR2_15 port map( A => A(17), B => n1, Y => M_0_17_port);
   XOR0_i_0_18 : XNOR2_14 port map( A => A(18), B => n1, Y => M_0_18_port);
   XOR0_i_0_19 : XNOR2_13 port map( A => A(19), B => n1, Y => M_0_19_port);
   XOR0_i_0_20 : XNOR2_12 port map( A => A(20), B => n1, Y => M_0_20_port);
   XOR0_i_0_21 : XNOR2_11 port map( A => A(21), B => n1, Y => M_0_21_port);
   XOR0_i_0_22 : XNOR2_10 port map( A => A(22), B => n1, Y => M_0_22_port);
   XOR0_i_0_23 : XNOR2_9 port map( A => A(23), B => n1, Y => M_0_23_port);
   XOR0_i_0_24 : XNOR2_8 port map( A => A(24), B => n1, Y => M_0_24_port);
   XOR0_i_0_25 : XNOR2_7 port map( A => A(25), B => n1, Y => M_0_25_port);
   XOR0_i_0_26 : XNOR2_6 port map( A => A(26), B => n1, Y => M_0_26_port);
   XOR0_i_0_27 : XNOR2_5 port map( A => A(27), B => n1, Y => M_0_27_port);
   XOR0_i_0_28 : XNOR2_4 port map( A => A(28), B => n1, Y => M_0_28_port);
   XOR0_i_0_29 : XNOR2_3 port map( A => A(29), B => n1, Y => M_0_29_port);
   XOR0_i_0_30 : XNOR2_2 port map( A => A(30), B => n1, Y => M_0_30_port);
   XOR0_i_0_31 : XNOR2_1 port map( A => A(31), B => n1, Y => M_0_31_port);
   AND_i_1_0 : AND2_0 port map( A => M_0_0_port, B => M_0_1_port, Y => 
                           M_1_0_port);
   AND_i_1_1 : AND2_30 port map( A => M_0_2_port, B => M_0_3_port, Y => 
                           M_1_1_port);
   AND_i_1_2 : AND2_29 port map( A => M_0_4_port, B => M_0_5_port, Y => 
                           M_1_2_port);
   AND_i_1_3 : AND2_28 port map( A => M_0_6_port, B => M_0_7_port, Y => 
                           M_1_3_port);
   AND_i_1_4 : AND2_27 port map( A => M_0_8_port, B => M_0_9_port, Y => 
                           M_1_4_port);
   AND_i_1_5 : AND2_26 port map( A => M_0_10_port, B => M_0_11_port, Y => 
                           M_1_5_port);
   AND_i_1_6 : AND2_25 port map( A => M_0_12_port, B => M_0_13_port, Y => 
                           M_1_6_port);
   AND_i_1_7 : AND2_24 port map( A => M_0_14_port, B => M_0_15_port, Y => 
                           M_1_7_port);
   AND_i_1_8 : AND2_23 port map( A => M_0_16_port, B => M_0_17_port, Y => 
                           M_1_8_port);
   AND_i_1_9 : AND2_22 port map( A => M_0_18_port, B => M_0_19_port, Y => 
                           M_1_9_port);
   AND_i_1_10 : AND2_21 port map( A => M_0_20_port, B => M_0_21_port, Y => 
                           M_1_10_port);
   AND_i_1_11 : AND2_20 port map( A => M_0_22_port, B => M_0_23_port, Y => 
                           M_1_11_port);
   AND_i_1_12 : AND2_19 port map( A => M_0_24_port, B => M_0_25_port, Y => 
                           M_1_12_port);
   AND_i_1_13 : AND2_18 port map( A => M_0_26_port, B => M_0_27_port, Y => 
                           M_1_13_port);
   AND_i_1_14 : AND2_17 port map( A => M_0_28_port, B => M_0_29_port, Y => 
                           M_1_14_port);
   AND_i_1_15 : AND2_16 port map( A => M_0_30_port, B => M_0_31_port, Y => 
                           M_1_15_port);
   AND_i_2_0 : AND2_15 port map( A => M_1_0_port, B => M_1_1_port, Y => 
                           M_2_0_port);
   AND_i_2_1 : AND2_14 port map( A => M_1_2_port, B => M_1_3_port, Y => 
                           M_2_1_port);
   AND_i_2_2 : AND2_13 port map( A => M_1_4_port, B => M_1_5_port, Y => 
                           M_2_2_port);
   AND_i_2_3 : AND2_12 port map( A => M_1_6_port, B => M_1_7_port, Y => 
                           M_2_3_port);
   AND_i_2_4 : AND2_11 port map( A => M_1_8_port, B => M_1_9_port, Y => 
                           M_2_4_port);
   AND_i_2_5 : AND2_10 port map( A => M_1_10_port, B => M_1_11_port, Y => 
                           M_2_5_port);
   AND_i_2_6 : AND2_9 port map( A => M_1_12_port, B => M_1_13_port, Y => 
                           M_2_6_port);
   AND_i_2_7 : AND2_8 port map( A => M_1_14_port, B => M_1_15_port, Y => 
                           M_2_7_port);
   AND_i_3_0 : AND2_7 port map( A => M_2_0_port, B => M_2_1_port, Y => 
                           M_3_0_port);
   AND_i_3_1 : AND2_6 port map( A => M_2_2_port, B => M_2_3_port, Y => 
                           M_3_1_port);
   AND_i_3_2 : AND2_5 port map( A => M_2_4_port, B => M_2_5_port, Y => 
                           M_3_2_port);
   AND_i_3_3 : AND2_4 port map( A => M_2_6_port, B => M_2_7_port, Y => 
                           M_3_3_port);
   AND_i_4_0 : AND2_3 port map( A => M_3_0_port, B => M_3_1_port, Y => 
                           M_4_0_port);
   AND_i_4_1 : AND2_2 port map( A => M_3_2_port, B => M_3_3_port, Y => 
                           M_4_1_port);
   AND_i_5_0 : AND2_1 port map( A => M_4_0_port, B => M_4_1_port, Y => Y);
   n1 <= '0';

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity ALU_N32_NB8 is

   port( OP1, OP2 : in std_logic_vector (31 downto 0);  OPC : in 
         std_logic_vector (0 to 6);  Y : out std_logic_vector (31 downto 0);  Z
         : out std_logic);

end ALU_N32_NB8;

architecture SYN_BEHAVIORAL of ALU_N32_NB8 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI222_X1
      port( A1, A2, B1, B2, C1, C2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component MUX2_X1
      port( A, B, S : in std_logic;  Z : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI222_X1
      port( A1, A2, B1, B2, C1, C2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X2
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI221_X4
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR3_X2
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X2
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR2_X2
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component DLH_X2
      port( G, D : in std_logic;  Q : out std_logic);
   end component;
   
   component ALU_N32_NB8_DW01_addsub_0
      port( A, B : in std_logic_vector (31 downto 0);  CI, ADD_SUB : in 
            std_logic;  SUM : out std_logic_vector (31 downto 0);  CO : out 
            std_logic);
   end component;
   
   component COMPARATOR_N32
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic_vector 
            (3 downto 0);  Y : out std_logic_vector (31 downto 0));
   end component;
   
   component LOGIC_N32
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic_vector 
            (1 downto 0);  Y : out std_logic_vector (31 downto 0));
   end component;
   
   component BARREL_SHIFTER_RIGHT_N32
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic;  Y : 
            out std_logic_vector (31 downto 0));
   end component;
   
   component BARREL_SHIFTER_LEFT_N32
      port( A, B : in std_logic_vector (31 downto 0);  Y : out std_logic_vector
            (31 downto 0));
   end component;
   
   component P4_ADDER_N32_NB8
      port( A, B : in std_logic_vector (31 downto 0);  Ci : in std_logic;  S : 
            out std_logic_vector (31 downto 0);  Co : out std_logic);
   end component;
   
   component DLH_X1
      port( G, D : in std_logic;  Q : out std_logic);
   end component;
   
   component DLL_X1
      port( D, GN : in std_logic;  Q : out std_logic);
   end component;
   
   signal Y_31_port, Y_30_port, Y_29_port, Y_28_port, Y_27_port, Y_26_port, 
      Y_25_port, Y_24_port, Y_23_port, Y_22_port, Y_21_port, Y_20_port, 
      Y_19_port, Y_18_port, Y_17_port, Y_16_port, Y_15_port, Y_14_port, 
      Y_13_port, Y_12_port, Y_11_port, Y_10_port, Y_9_port, Y_8_port, Y_7_port,
      Y_6_port, Y_5_port, Y_4_port, Y_3_port, Y_2_port, Y_1_port, Y_0_port, 
      OP_A_31_port, OP_A_30_port, OP_A_29_port, OP_A_28_port, OP_A_27_port, 
      OP_A_26_port, OP_A_25_port, OP_A_24_port, OP_A_23_port, OP_A_22_port, 
      OP_A_21_port, OP_A_20_port, OP_A_19_port, OP_A_18_port, OP_A_17_port, 
      OP_A_16_port, OP_A_15_port, OP_A_14_port, OP_A_13_port, OP_A_12_port, 
      OP_A_11_port, OP_A_10_port, OP_A_9_port, OP_A_8_port, OP_A_7_port, 
      OP_A_6_port, OP_A_5_port, OP_A_4_port, OP_A_3_port, OP_A_2_port, 
      OP_A_1_port, OP_A_0_port, OP_B_31_port, OP_B_30_port, OP_B_29_port, 
      OP_B_28_port, OP_B_27_port, OP_B_26_port, OP_B_25_port, OP_B_24_port, 
      OP_B_23_port, OP_B_22_port, OP_B_21_port, OP_B_20_port, OP_B_19_port, 
      OP_B_18_port, OP_B_17_port, OP_B_16_port, OP_B_15_port, OP_B_14_port, 
      OP_B_13_port, OP_B_12_port, OP_B_11_port, OP_B_10_port, OP_B_9_port, 
      OP_B_8_port, OP_B_7_port, OP_B_6_port, OP_B_5_port, OP_B_4_port, 
      OP_B_3_port, OP_B_2_port, OP_B_1_port, OP_B_0_port, Y_SHIFTL_31_port, 
      Y_SHIFTL_30_port, Y_SHIFTL_29_port, Y_SHIFTL_28_port, Y_SHIFTL_27_port, 
      Y_SHIFTL_26_port, Y_SHIFTL_25_port, Y_SHIFTL_24_port, Y_SHIFTL_23_port, 
      Y_SHIFTL_22_port, Y_SHIFTL_21_port, Y_SHIFTL_20_port, Y_SHIFTL_19_port, 
      Y_SHIFTL_18_port, Y_SHIFTL_17_port, Y_SHIFTL_16_port, Y_SHIFTL_15_port, 
      Y_SHIFTL_14_port, Y_SHIFTL_13_port, Y_SHIFTL_12_port, Y_SHIFTL_11_port, 
      Y_SHIFTL_10_port, Y_SHIFTL_9_port, Y_SHIFTL_8_port, Y_SHIFTL_7_port, 
      Y_SHIFTL_6_port, Y_SHIFTL_5_port, Y_SHIFTL_4_port, Y_SHIFTL_3_port, 
      Y_SHIFTL_2_port, Y_SHIFTL_1_port, Y_SHIFTL_0_port, OP_Ci, Y_SUM_31_port, 
      Y_SUM_30_port, Y_SUM_29_port, Y_SUM_28_port, Y_SUM_27_port, Y_SUM_26_port
      , Y_SUM_25_port, Y_SUM_24_port, Y_SUM_23_port, Y_SUM_22_port, 
      Y_SUM_21_port, Y_SUM_20_port, Y_SUM_19_port, Y_SUM_18_port, Y_SUM_17_port
      , Y_SUM_16_port, Y_SUM_15_port, Y_SUM_14_port, Y_SUM_13_port, 
      Y_SUM_12_port, Y_SUM_11_port, Y_SUM_10_port, Y_SUM_9_port, Y_SUM_8_port, 
      Y_SUM_7_port, Y_SUM_6_port, Y_SUM_5_port, Y_SUM_4_port, Y_SUM_3_port, 
      Y_SUM_2_port, Y_SUM_1_port, Y_SUM_0_port, N249, N250, N251, N252, N253, 
      N254, N255, N256, N257, N258, N259, N260, N261, N262, N263, N264, N265, 
      N266, N267, N268, N269, N270, N271, N272, N273, N274, N275, N276, N277, 
      N278, N279, N280, OP_LOGIC_1_port, OP_LOGIC_0_port, Y_LOGIC_31_port, 
      Y_LOGIC_30_port, Y_LOGIC_29_port, Y_LOGIC_28_port, Y_LOGIC_27_port, 
      Y_LOGIC_26_port, Y_LOGIC_25_port, Y_LOGIC_24_port, Y_LOGIC_23_port, 
      Y_LOGIC_22_port, Y_LOGIC_21_port, Y_LOGIC_20_port, Y_LOGIC_19_port, 
      Y_LOGIC_18_port, Y_LOGIC_17_port, Y_LOGIC_16_port, Y_LOGIC_15_port, 
      Y_LOGIC_14_port, Y_LOGIC_13_port, Y_LOGIC_12_port, Y_LOGIC_11_port, 
      Y_LOGIC_10_port, Y_LOGIC_9_port, Y_LOGIC_8_port, Y_LOGIC_7_port, 
      Y_LOGIC_6_port, Y_LOGIC_5_port, Y_LOGIC_4_port, Y_LOGIC_3_port, 
      Y_LOGIC_2_port, Y_LOGIC_1_port, Y_LOGIC_0_port, OP_SHIFT, 
      Y_SHIFTR_31_port, Y_SHIFTR_30_port, Y_SHIFTR_29_port, Y_SHIFTR_28_port, 
      Y_SHIFTR_27_port, Y_SHIFTR_26_port, Y_SHIFTR_25_port, Y_SHIFTR_24_port, 
      Y_SHIFTR_23_port, Y_SHIFTR_22_port, Y_SHIFTR_21_port, Y_SHIFTR_20_port, 
      Y_SHIFTR_19_port, Y_SHIFTR_18_port, Y_SHIFTR_17_port, Y_SHIFTR_16_port, 
      Y_SHIFTR_15_port, Y_SHIFTR_14_port, Y_SHIFTR_13_port, Y_SHIFTR_12_port, 
      Y_SHIFTR_11_port, Y_SHIFTR_10_port, Y_SHIFTR_9_port, Y_SHIFTR_8_port, 
      Y_SHIFTR_7_port, Y_SHIFTR_6_port, Y_SHIFTR_5_port, Y_SHIFTR_4_port, 
      Y_SHIFTR_3_port, Y_SHIFTR_2_port, Y_SHIFTR_1_port, Y_SHIFTR_0_port, 
      OP_COMPARE_3_port, OP_COMPARE_2_port, OP_COMPARE_1_port, 
      OP_COMPARE_0_port, Y_COMPARE_0_port, N281, N282, N283, N284, N285, N286, 
      N287, N288, N289, N290, N291, N292, N293, N294, N295, N296, N297, N298, 
      N299, N300, N301, N302, N303, N304, N305, N306, N307, N308, N309, N310, 
      N311, N312, N313, N315, N316, N317, N318, N319, N320, N321, N323, N324, 
      U3_U1_Z_0, n187, n176, n2, n375, n376, n377, n378, n379, n380, n381, n382
      , n383, n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394,
      n395, n396, n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, 
      n407, n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418, 
      n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, 
      n431, n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442, 
      n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453, n454, 
      n455, n456, n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, 
      n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, 
      n479, n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, 
      n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501, n502, 
      n503, n504, n505, n506, n507, n508, n509, n510, n511, n512, n513, n514, 
      n515, n_1224, n_1225, n_1226, n_1227, n_1228, n_1229, n_1230, n_1231, 
      n_1232, n_1233, n_1234, n_1235, n_1236, n_1237, n_1238, n_1239, n_1240, 
      n_1241, n_1242, n_1243, n_1244, n_1245, n_1246, n_1247, n_1248, n_1249, 
      n_1250, n_1251, n_1252, n_1253, n_1254, n_1255, n_1256 : std_logic;

begin
   Y <= ( Y_31_port, Y_30_port, Y_29_port, Y_28_port, Y_27_port, Y_26_port, 
      Y_25_port, Y_24_port, Y_23_port, Y_22_port, Y_21_port, Y_20_port, 
      Y_19_port, Y_18_port, Y_17_port, Y_16_port, Y_15_port, Y_14_port, 
      Y_13_port, Y_12_port, Y_11_port, Y_10_port, Y_9_port, Y_8_port, Y_7_port,
      Y_6_port, Y_5_port, Y_4_port, Y_3_port, Y_2_port, Y_1_port, Y_0_port );
   
   OP_COMPARE_reg_3_inst : DLH_X1 port map( G => N320, D => N324, Q => 
                           OP_COMPARE_3_port);
   OP_COMPARE_reg_2_inst : DLH_X1 port map( G => N320, D => N323, Q => 
                           OP_COMPARE_2_port);
   OP_COMPARE_reg_1_inst : DLH_X1 port map( G => N320, D => n176, Q => 
                           OP_COMPARE_1_port);
   OP_COMPARE_reg_0_inst : DLH_X1 port map( G => N320, D => N321, Q => 
                           OP_COMPARE_0_port);
   OP_A_reg_31_inst : DLH_X1 port map( G => N281, D => OP1(31), Q => 
                           OP_A_31_port);
   OP_A_reg_30_inst : DLH_X1 port map( G => N281, D => OP1(30), Q => 
                           OP_A_30_port);
   OP_A_reg_29_inst : DLH_X1 port map( G => N281, D => OP1(29), Q => 
                           OP_A_29_port);
   OP_A_reg_28_inst : DLH_X1 port map( G => N281, D => OP1(28), Q => 
                           OP_A_28_port);
   OP_A_reg_27_inst : DLH_X1 port map( G => N281, D => OP1(27), Q => 
                           OP_A_27_port);
   OP_A_reg_26_inst : DLH_X1 port map( G => N281, D => OP1(26), Q => 
                           OP_A_26_port);
   OP_A_reg_25_inst : DLH_X1 port map( G => N281, D => OP1(25), Q => 
                           OP_A_25_port);
   OP_A_reg_24_inst : DLH_X1 port map( G => N281, D => OP1(24), Q => 
                           OP_A_24_port);
   OP_A_reg_23_inst : DLH_X1 port map( G => N281, D => OP1(23), Q => 
                           OP_A_23_port);
   OP_A_reg_22_inst : DLH_X1 port map( G => N281, D => OP1(22), Q => 
                           OP_A_22_port);
   OP_A_reg_21_inst : DLH_X1 port map( G => N281, D => OP1(21), Q => 
                           OP_A_21_port);
   OP_A_reg_20_inst : DLH_X1 port map( G => N281, D => OP1(20), Q => 
                           OP_A_20_port);
   OP_A_reg_19_inst : DLH_X1 port map( G => N281, D => OP1(19), Q => 
                           OP_A_19_port);
   OP_A_reg_18_inst : DLH_X1 port map( G => N281, D => OP1(18), Q => 
                           OP_A_18_port);
   OP_A_reg_17_inst : DLH_X1 port map( G => N281, D => OP1(17), Q => 
                           OP_A_17_port);
   OP_A_reg_16_inst : DLH_X1 port map( G => N281, D => OP1(16), Q => 
                           OP_A_16_port);
   OP_A_reg_15_inst : DLH_X1 port map( G => N281, D => OP1(15), Q => 
                           OP_A_15_port);
   OP_A_reg_14_inst : DLH_X1 port map( G => N281, D => OP1(14), Q => 
                           OP_A_14_port);
   OP_A_reg_13_inst : DLH_X1 port map( G => N281, D => OP1(13), Q => 
                           OP_A_13_port);
   OP_A_reg_12_inst : DLH_X1 port map( G => N281, D => OP1(12), Q => 
                           OP_A_12_port);
   OP_A_reg_11_inst : DLH_X1 port map( G => N281, D => OP1(11), Q => 
                           OP_A_11_port);
   OP_A_reg_10_inst : DLH_X1 port map( G => N281, D => OP1(10), Q => 
                           OP_A_10_port);
   OP_A_reg_9_inst : DLH_X1 port map( G => N281, D => OP1(9), Q => OP_A_9_port)
                           ;
   OP_A_reg_8_inst : DLH_X1 port map( G => N281, D => OP1(8), Q => OP_A_8_port)
                           ;
   OP_A_reg_7_inst : DLH_X1 port map( G => N281, D => OP1(7), Q => OP_A_7_port)
                           ;
   OP_A_reg_6_inst : DLH_X1 port map( G => N281, D => OP1(6), Q => OP_A_6_port)
                           ;
   OP_A_reg_5_inst : DLH_X1 port map( G => N281, D => OP1(5), Q => OP_A_5_port)
                           ;
   OP_A_reg_4_inst : DLH_X1 port map( G => N281, D => OP1(4), Q => OP_A_4_port)
                           ;
   OP_A_reg_3_inst : DLH_X1 port map( G => N281, D => OP1(3), Q => OP_A_3_port)
                           ;
   OP_A_reg_2_inst : DLH_X1 port map( G => N281, D => OP1(2), Q => OP_A_2_port)
                           ;
   OP_A_reg_1_inst : DLH_X1 port map( G => N281, D => OP1(1), Q => OP_A_1_port)
                           ;
   OP_A_reg_0_inst : DLH_X1 port map( G => N281, D => OP1(0), Q => OP_A_0_port)
                           ;
   OP_B_reg_31_inst : DLH_X1 port map( G => N281, D => N313, Q => OP_B_31_port)
                           ;
   OP_B_reg_30_inst : DLH_X1 port map( G => N281, D => N312, Q => OP_B_30_port)
                           ;
   OP_B_reg_29_inst : DLH_X1 port map( G => N281, D => N311, Q => OP_B_29_port)
                           ;
   OP_B_reg_28_inst : DLH_X1 port map( G => N281, D => N310, Q => OP_B_28_port)
                           ;
   OP_B_reg_27_inst : DLH_X1 port map( G => N281, D => N309, Q => OP_B_27_port)
                           ;
   OP_B_reg_26_inst : DLH_X1 port map( G => N281, D => N308, Q => OP_B_26_port)
                           ;
   OP_B_reg_25_inst : DLH_X1 port map( G => N281, D => N307, Q => OP_B_25_port)
                           ;
   OP_B_reg_24_inst : DLH_X1 port map( G => N281, D => N306, Q => OP_B_24_port)
                           ;
   OP_B_reg_23_inst : DLH_X1 port map( G => N281, D => N305, Q => OP_B_23_port)
                           ;
   OP_B_reg_22_inst : DLH_X1 port map( G => N281, D => N304, Q => OP_B_22_port)
                           ;
   OP_B_reg_21_inst : DLH_X1 port map( G => N281, D => N303, Q => OP_B_21_port)
                           ;
   OP_B_reg_20_inst : DLH_X1 port map( G => N281, D => N302, Q => OP_B_20_port)
                           ;
   OP_B_reg_19_inst : DLH_X1 port map( G => N281, D => N301, Q => OP_B_19_port)
                           ;
   OP_B_reg_18_inst : DLH_X1 port map( G => N281, D => N300, Q => OP_B_18_port)
                           ;
   OP_B_reg_17_inst : DLH_X1 port map( G => N281, D => N299, Q => OP_B_17_port)
                           ;
   OP_B_reg_16_inst : DLH_X1 port map( G => N281, D => N298, Q => OP_B_16_port)
                           ;
   OP_B_reg_15_inst : DLH_X1 port map( G => N281, D => N297, Q => OP_B_15_port)
                           ;
   OP_B_reg_14_inst : DLH_X1 port map( G => N281, D => N296, Q => OP_B_14_port)
                           ;
   OP_B_reg_13_inst : DLH_X1 port map( G => N281, D => N295, Q => OP_B_13_port)
                           ;
   OP_B_reg_12_inst : DLH_X1 port map( G => N281, D => N294, Q => OP_B_12_port)
                           ;
   OP_B_reg_11_inst : DLH_X1 port map( G => N281, D => N293, Q => OP_B_11_port)
                           ;
   OP_B_reg_10_inst : DLH_X1 port map( G => N281, D => N292, Q => OP_B_10_port)
                           ;
   OP_B_reg_9_inst : DLH_X1 port map( G => N281, D => N291, Q => OP_B_9_port);
   OP_B_reg_8_inst : DLH_X1 port map( G => N281, D => N290, Q => OP_B_8_port);
   OP_B_reg_7_inst : DLH_X1 port map( G => N281, D => N289, Q => OP_B_7_port);
   OP_B_reg_6_inst : DLH_X1 port map( G => N281, D => N288, Q => OP_B_6_port);
   OP_B_reg_5_inst : DLH_X1 port map( G => N281, D => N287, Q => OP_B_5_port);
   OP_Ci_reg : DLL_X1 port map( D => n378, GN => n187, Q => OP_Ci);
   OP_LOGIC_reg_1_inst : DLH_X1 port map( G => N316, D => N318, Q => 
                           OP_LOGIC_1_port);
   OP_LOGIC_reg_0_inst : DLH_X1 port map( G => N316, D => N317, Q => 
                           OP_LOGIC_0_port);
   OP_SHIFT_reg : DLH_X1 port map( G => N319, D => n515, Q => OP_SHIFT);
   n2 <= '0';
   SUM : P4_ADDER_N32_NB8 port map( A(31) => OP_A_31_port, A(30) => 
                           OP_A_30_port, A(29) => OP_A_29_port, A(28) => 
                           OP_A_28_port, A(27) => OP_A_27_port, A(26) => 
                           OP_A_26_port, A(25) => OP_A_25_port, A(24) => 
                           OP_A_24_port, A(23) => OP_A_23_port, A(22) => 
                           OP_A_22_port, A(21) => OP_A_21_port, A(20) => 
                           OP_A_20_port, A(19) => OP_A_19_port, A(18) => 
                           OP_A_18_port, A(17) => OP_A_17_port, A(16) => 
                           OP_A_16_port, A(15) => OP_A_15_port, A(14) => 
                           OP_A_14_port, A(13) => OP_A_13_port, A(12) => 
                           OP_A_12_port, A(11) => OP_A_11_port, A(10) => 
                           OP_A_10_port, A(9) => OP_A_9_port, A(8) => 
                           OP_A_8_port, A(7) => OP_A_7_port, A(6) => 
                           OP_A_6_port, A(5) => OP_A_5_port, A(4) => 
                           OP_A_4_port, A(3) => OP_A_3_port, A(2) => 
                           OP_A_2_port, A(1) => OP_A_1_port, A(0) => 
                           OP_A_0_port, B(31) => OP_B_31_port, B(30) => 
                           OP_B_30_port, B(29) => OP_B_29_port, B(28) => 
                           OP_B_28_port, B(27) => OP_B_27_port, B(26) => 
                           OP_B_26_port, B(25) => OP_B_25_port, B(24) => 
                           OP_B_24_port, B(23) => OP_B_23_port, B(22) => 
                           OP_B_22_port, B(21) => OP_B_21_port, B(20) => 
                           OP_B_20_port, B(19) => OP_B_19_port, B(18) => 
                           OP_B_18_port, B(17) => OP_B_17_port, B(16) => 
                           OP_B_16_port, B(15) => OP_B_15_port, B(14) => 
                           OP_B_14_port, B(13) => OP_B_13_port, B(12) => 
                           OP_B_12_port, B(11) => OP_B_11_port, B(10) => 
                           OP_B_10_port, B(9) => OP_B_9_port, B(8) => 
                           OP_B_8_port, B(7) => OP_B_7_port, B(6) => 
                           OP_B_6_port, B(5) => OP_B_5_port, B(4) => 
                           OP_B_4_port, B(3) => OP_B_3_port, B(2) => 
                           OP_B_2_port, B(1) => OP_B_1_port, B(0) => 
                           OP_B_0_port, Ci => OP_Ci, S(31) => Y_SUM_31_port, 
                           S(30) => Y_SUM_30_port, S(29) => Y_SUM_29_port, 
                           S(28) => Y_SUM_28_port, S(27) => Y_SUM_27_port, 
                           S(26) => Y_SUM_26_port, S(25) => Y_SUM_25_port, 
                           S(24) => Y_SUM_24_port, S(23) => Y_SUM_23_port, 
                           S(22) => Y_SUM_22_port, S(21) => Y_SUM_21_port, 
                           S(20) => Y_SUM_20_port, S(19) => Y_SUM_19_port, 
                           S(18) => Y_SUM_18_port, S(17) => Y_SUM_17_port, 
                           S(16) => Y_SUM_16_port, S(15) => Y_SUM_15_port, 
                           S(14) => Y_SUM_14_port, S(13) => Y_SUM_13_port, 
                           S(12) => Y_SUM_12_port, S(11) => Y_SUM_11_port, 
                           S(10) => Y_SUM_10_port, S(9) => Y_SUM_9_port, S(8) 
                           => Y_SUM_8_port, S(7) => Y_SUM_7_port, S(6) => 
                           Y_SUM_6_port, S(5) => Y_SUM_5_port, S(4) => 
                           Y_SUM_4_port, S(3) => Y_SUM_3_port, S(2) => 
                           Y_SUM_2_port, S(1) => Y_SUM_1_port, S(0) => 
                           Y_SUM_0_port, Co => n_1224);
   BSL : BARREL_SHIFTER_LEFT_N32 port map( A(31) => OP_A_31_port, A(30) => 
                           OP_A_30_port, A(29) => OP_A_29_port, A(28) => 
                           OP_A_28_port, A(27) => OP_A_27_port, A(26) => 
                           OP_A_26_port, A(25) => OP_A_25_port, A(24) => 
                           OP_A_24_port, A(23) => OP_A_23_port, A(22) => 
                           OP_A_22_port, A(21) => OP_A_21_port, A(20) => 
                           OP_A_20_port, A(19) => OP_A_19_port, A(18) => 
                           OP_A_18_port, A(17) => OP_A_17_port, A(16) => 
                           OP_A_16_port, A(15) => OP_A_15_port, A(14) => 
                           OP_A_14_port, A(13) => OP_A_13_port, A(12) => 
                           OP_A_12_port, A(11) => OP_A_11_port, A(10) => 
                           OP_A_10_port, A(9) => OP_A_9_port, A(8) => 
                           OP_A_8_port, A(7) => OP_A_7_port, A(6) => 
                           OP_A_6_port, A(5) => OP_A_5_port, A(4) => 
                           OP_A_4_port, A(3) => OP_A_3_port, A(2) => 
                           OP_A_2_port, A(1) => OP_A_1_port, A(0) => 
                           OP_A_0_port, B(31) => OP_B_31_port, B(30) => 
                           OP_B_30_port, B(29) => OP_B_29_port, B(28) => 
                           OP_B_28_port, B(27) => OP_B_27_port, B(26) => 
                           OP_B_26_port, B(25) => OP_B_25_port, B(24) => 
                           OP_B_24_port, B(23) => OP_B_23_port, B(22) => 
                           OP_B_22_port, B(21) => OP_B_21_port, B(20) => 
                           OP_B_20_port, B(19) => OP_B_19_port, B(18) => 
                           OP_B_18_port, B(17) => OP_B_17_port, B(16) => 
                           OP_B_16_port, B(15) => OP_B_15_port, B(14) => 
                           OP_B_14_port, B(13) => OP_B_13_port, B(12) => 
                           OP_B_12_port, B(11) => OP_B_11_port, B(10) => 
                           OP_B_10_port, B(9) => OP_B_9_port, B(8) => 
                           OP_B_8_port, B(7) => OP_B_7_port, B(6) => 
                           OP_B_6_port, B(5) => OP_B_5_port, B(4) => 
                           OP_B_4_port, B(3) => OP_B_3_port, B(2) => 
                           OP_B_2_port, B(1) => OP_B_1_port, B(0) => 
                           OP_B_0_port, Y(31) => Y_SHIFTL_31_port, Y(30) => 
                           Y_SHIFTL_30_port, Y(29) => Y_SHIFTL_29_port, Y(28) 
                           => Y_SHIFTL_28_port, Y(27) => Y_SHIFTL_27_port, 
                           Y(26) => Y_SHIFTL_26_port, Y(25) => Y_SHIFTL_25_port
                           , Y(24) => Y_SHIFTL_24_port, Y(23) => 
                           Y_SHIFTL_23_port, Y(22) => Y_SHIFTL_22_port, Y(21) 
                           => Y_SHIFTL_21_port, Y(20) => Y_SHIFTL_20_port, 
                           Y(19) => Y_SHIFTL_19_port, Y(18) => Y_SHIFTL_18_port
                           , Y(17) => Y_SHIFTL_17_port, Y(16) => 
                           Y_SHIFTL_16_port, Y(15) => Y_SHIFTL_15_port, Y(14) 
                           => Y_SHIFTL_14_port, Y(13) => Y_SHIFTL_13_port, 
                           Y(12) => Y_SHIFTL_12_port, Y(11) => Y_SHIFTL_11_port
                           , Y(10) => Y_SHIFTL_10_port, Y(9) => Y_SHIFTL_9_port
                           , Y(8) => Y_SHIFTL_8_port, Y(7) => Y_SHIFTL_7_port, 
                           Y(6) => Y_SHIFTL_6_port, Y(5) => Y_SHIFTL_5_port, 
                           Y(4) => Y_SHIFTL_4_port, Y(3) => Y_SHIFTL_3_port, 
                           Y(2) => Y_SHIFTL_2_port, Y(1) => Y_SHIFTL_1_port, 
                           Y(0) => Y_SHIFTL_0_port);
   BSR : BARREL_SHIFTER_RIGHT_N32 port map( A(31) => OP_A_31_port, A(30) => 
                           OP_A_30_port, A(29) => OP_A_29_port, A(28) => 
                           OP_A_28_port, A(27) => OP_A_27_port, A(26) => 
                           OP_A_26_port, A(25) => OP_A_25_port, A(24) => 
                           OP_A_24_port, A(23) => OP_A_23_port, A(22) => 
                           OP_A_22_port, A(21) => OP_A_21_port, A(20) => 
                           OP_A_20_port, A(19) => OP_A_19_port, A(18) => 
                           OP_A_18_port, A(17) => OP_A_17_port, A(16) => 
                           OP_A_16_port, A(15) => OP_A_15_port, A(14) => 
                           OP_A_14_port, A(13) => OP_A_13_port, A(12) => 
                           OP_A_12_port, A(11) => OP_A_11_port, A(10) => 
                           OP_A_10_port, A(9) => OP_A_9_port, A(8) => 
                           OP_A_8_port, A(7) => OP_A_7_port, A(6) => 
                           OP_A_6_port, A(5) => OP_A_5_port, A(4) => 
                           OP_A_4_port, A(3) => OP_A_3_port, A(2) => 
                           OP_A_2_port, A(1) => OP_A_1_port, A(0) => 
                           OP_A_0_port, B(31) => OP_B_31_port, B(30) => 
                           OP_B_30_port, B(29) => OP_B_29_port, B(28) => 
                           OP_B_28_port, B(27) => OP_B_27_port, B(26) => 
                           OP_B_26_port, B(25) => OP_B_25_port, B(24) => 
                           OP_B_24_port, B(23) => OP_B_23_port, B(22) => 
                           OP_B_22_port, B(21) => OP_B_21_port, B(20) => 
                           OP_B_20_port, B(19) => OP_B_19_port, B(18) => 
                           OP_B_18_port, B(17) => OP_B_17_port, B(16) => 
                           OP_B_16_port, B(15) => OP_B_15_port, B(14) => 
                           OP_B_14_port, B(13) => OP_B_13_port, B(12) => 
                           OP_B_12_port, B(11) => OP_B_11_port, B(10) => 
                           OP_B_10_port, B(9) => OP_B_9_port, B(8) => 
                           OP_B_8_port, B(7) => OP_B_7_port, B(6) => 
                           OP_B_6_port, B(5) => OP_B_5_port, B(4) => 
                           OP_B_4_port, B(3) => OP_B_3_port, B(2) => 
                           OP_B_2_port, B(1) => OP_B_1_port, B(0) => 
                           OP_B_0_port, S => OP_SHIFT, Y(31) => 
                           Y_SHIFTR_31_port, Y(30) => Y_SHIFTR_30_port, Y(29) 
                           => Y_SHIFTR_29_port, Y(28) => Y_SHIFTR_28_port, 
                           Y(27) => Y_SHIFTR_27_port, Y(26) => Y_SHIFTR_26_port
                           , Y(25) => Y_SHIFTR_25_port, Y(24) => 
                           Y_SHIFTR_24_port, Y(23) => Y_SHIFTR_23_port, Y(22) 
                           => Y_SHIFTR_22_port, Y(21) => Y_SHIFTR_21_port, 
                           Y(20) => Y_SHIFTR_20_port, Y(19) => Y_SHIFTR_19_port
                           , Y(18) => Y_SHIFTR_18_port, Y(17) => 
                           Y_SHIFTR_17_port, Y(16) => Y_SHIFTR_16_port, Y(15) 
                           => Y_SHIFTR_15_port, Y(14) => Y_SHIFTR_14_port, 
                           Y(13) => Y_SHIFTR_13_port, Y(12) => Y_SHIFTR_12_port
                           , Y(11) => Y_SHIFTR_11_port, Y(10) => 
                           Y_SHIFTR_10_port, Y(9) => Y_SHIFTR_9_port, Y(8) => 
                           Y_SHIFTR_8_port, Y(7) => Y_SHIFTR_7_port, Y(6) => 
                           Y_SHIFTR_6_port, Y(5) => Y_SHIFTR_5_port, Y(4) => 
                           Y_SHIFTR_4_port, Y(3) => Y_SHIFTR_3_port, Y(2) => 
                           Y_SHIFTR_2_port, Y(1) => Y_SHIFTR_1_port, Y(0) => 
                           Y_SHIFTR_0_port);
   LOG : LOGIC_N32 port map( A(31) => OP_A_31_port, A(30) => OP_A_30_port, 
                           A(29) => OP_A_29_port, A(28) => OP_A_28_port, A(27) 
                           => OP_A_27_port, A(26) => OP_A_26_port, A(25) => 
                           OP_A_25_port, A(24) => OP_A_24_port, A(23) => 
                           OP_A_23_port, A(22) => OP_A_22_port, A(21) => 
                           OP_A_21_port, A(20) => OP_A_20_port, A(19) => 
                           OP_A_19_port, A(18) => OP_A_18_port, A(17) => 
                           OP_A_17_port, A(16) => OP_A_16_port, A(15) => 
                           OP_A_15_port, A(14) => OP_A_14_port, A(13) => 
                           OP_A_13_port, A(12) => OP_A_12_port, A(11) => 
                           OP_A_11_port, A(10) => OP_A_10_port, A(9) => 
                           OP_A_9_port, A(8) => OP_A_8_port, A(7) => 
                           OP_A_7_port, A(6) => OP_A_6_port, A(5) => 
                           OP_A_5_port, A(4) => OP_A_4_port, A(3) => 
                           OP_A_3_port, A(2) => OP_A_2_port, A(1) => 
                           OP_A_1_port, A(0) => OP_A_0_port, B(31) => 
                           OP_B_31_port, B(30) => OP_B_30_port, B(29) => 
                           OP_B_29_port, B(28) => OP_B_28_port, B(27) => 
                           OP_B_27_port, B(26) => OP_B_26_port, B(25) => 
                           OP_B_25_port, B(24) => OP_B_24_port, B(23) => 
                           OP_B_23_port, B(22) => OP_B_22_port, B(21) => 
                           OP_B_21_port, B(20) => OP_B_20_port, B(19) => 
                           OP_B_19_port, B(18) => OP_B_18_port, B(17) => 
                           OP_B_17_port, B(16) => OP_B_16_port, B(15) => 
                           OP_B_15_port, B(14) => OP_B_14_port, B(13) => 
                           OP_B_13_port, B(12) => OP_B_12_port, B(11) => 
                           OP_B_11_port, B(10) => OP_B_10_port, B(9) => 
                           OP_B_9_port, B(8) => OP_B_8_port, B(7) => 
                           OP_B_7_port, B(6) => OP_B_6_port, B(5) => 
                           OP_B_5_port, B(4) => OP_B_4_port, B(3) => 
                           OP_B_3_port, B(2) => OP_B_2_port, B(1) => 
                           OP_B_1_port, B(0) => OP_B_0_port, S(1) => 
                           OP_LOGIC_1_port, S(0) => OP_LOGIC_0_port, Y(31) => 
                           Y_LOGIC_31_port, Y(30) => Y_LOGIC_30_port, Y(29) => 
                           Y_LOGIC_29_port, Y(28) => Y_LOGIC_28_port, Y(27) => 
                           Y_LOGIC_27_port, Y(26) => Y_LOGIC_26_port, Y(25) => 
                           Y_LOGIC_25_port, Y(24) => Y_LOGIC_24_port, Y(23) => 
                           Y_LOGIC_23_port, Y(22) => Y_LOGIC_22_port, Y(21) => 
                           Y_LOGIC_21_port, Y(20) => Y_LOGIC_20_port, Y(19) => 
                           Y_LOGIC_19_port, Y(18) => Y_LOGIC_18_port, Y(17) => 
                           Y_LOGIC_17_port, Y(16) => Y_LOGIC_16_port, Y(15) => 
                           Y_LOGIC_15_port, Y(14) => Y_LOGIC_14_port, Y(13) => 
                           Y_LOGIC_13_port, Y(12) => Y_LOGIC_12_port, Y(11) => 
                           Y_LOGIC_11_port, Y(10) => Y_LOGIC_10_port, Y(9) => 
                           Y_LOGIC_9_port, Y(8) => Y_LOGIC_8_port, Y(7) => 
                           Y_LOGIC_7_port, Y(6) => Y_LOGIC_6_port, Y(5) => 
                           Y_LOGIC_5_port, Y(4) => Y_LOGIC_4_port, Y(3) => 
                           Y_LOGIC_3_port, Y(2) => Y_LOGIC_2_port, Y(1) => 
                           Y_LOGIC_1_port, Y(0) => Y_LOGIC_0_port);
   CMP : COMPARATOR_N32 port map( A(31) => OP_A_31_port, A(30) => OP_A_30_port,
                           A(29) => OP_A_29_port, A(28) => OP_A_28_port, A(27) 
                           => OP_A_27_port, A(26) => OP_A_26_port, A(25) => 
                           OP_A_25_port, A(24) => OP_A_24_port, A(23) => 
                           OP_A_23_port, A(22) => OP_A_22_port, A(21) => 
                           OP_A_21_port, A(20) => OP_A_20_port, A(19) => 
                           OP_A_19_port, A(18) => OP_A_18_port, A(17) => 
                           OP_A_17_port, A(16) => OP_A_16_port, A(15) => 
                           OP_A_15_port, A(14) => OP_A_14_port, A(13) => 
                           OP_A_13_port, A(12) => OP_A_12_port, A(11) => 
                           OP_A_11_port, A(10) => OP_A_10_port, A(9) => 
                           OP_A_9_port, A(8) => OP_A_8_port, A(7) => 
                           OP_A_7_port, A(6) => OP_A_6_port, A(5) => 
                           OP_A_5_port, A(4) => OP_A_4_port, A(3) => 
                           OP_A_3_port, A(2) => OP_A_2_port, A(1) => 
                           OP_A_1_port, A(0) => OP_A_0_port, B(31) => 
                           OP_B_31_port, B(30) => OP_B_30_port, B(29) => 
                           OP_B_29_port, B(28) => OP_B_28_port, B(27) => 
                           OP_B_27_port, B(26) => OP_B_26_port, B(25) => 
                           OP_B_25_port, B(24) => OP_B_24_port, B(23) => 
                           OP_B_23_port, B(22) => OP_B_22_port, B(21) => 
                           OP_B_21_port, B(20) => OP_B_20_port, B(19) => 
                           OP_B_19_port, B(18) => OP_B_18_port, B(17) => 
                           OP_B_17_port, B(16) => OP_B_16_port, B(15) => 
                           OP_B_15_port, B(14) => OP_B_14_port, B(13) => 
                           OP_B_13_port, B(12) => OP_B_12_port, B(11) => 
                           OP_B_11_port, B(10) => OP_B_10_port, B(9) => 
                           OP_B_9_port, B(8) => OP_B_8_port, B(7) => 
                           OP_B_7_port, B(6) => OP_B_6_port, B(5) => 
                           OP_B_5_port, B(4) => OP_B_4_port, B(3) => 
                           OP_B_3_port, B(2) => OP_B_2_port, B(1) => 
                           OP_B_1_port, B(0) => OP_B_0_port, S(3) => 
                           OP_COMPARE_3_port, S(2) => OP_COMPARE_2_port, S(1) 
                           => OP_COMPARE_1_port, S(0) => OP_COMPARE_0_port, 
                           Y(31) => n_1225, Y(30) => n_1226, Y(29) => n_1227, 
                           Y(28) => n_1228, Y(27) => n_1229, Y(26) => n_1230, 
                           Y(25) => n_1231, Y(24) => n_1232, Y(23) => n_1233, 
                           Y(22) => n_1234, Y(21) => n_1235, Y(20) => n_1236, 
                           Y(19) => n_1237, Y(18) => n_1238, Y(17) => n_1239, 
                           Y(16) => n_1240, Y(15) => n_1241, Y(14) => n_1242, 
                           Y(13) => n_1243, Y(12) => n_1244, Y(11) => n_1245, 
                           Y(10) => n_1246, Y(9) => n_1247, Y(8) => n_1248, 
                           Y(7) => n_1249, Y(6) => n_1250, Y(5) => n_1251, Y(4)
                           => n_1252, Y(3) => n_1253, Y(2) => n_1254, Y(1) => 
                           n_1255, Y(0) => Y_COMPARE_0_port);
   r71 : ALU_N32_NB8_DW01_addsub_0 port map( A(31) => OP1(31), A(30) => OP1(30)
                           , A(29) => OP1(29), A(28) => OP1(28), A(27) => 
                           OP1(27), A(26) => OP1(26), A(25) => OP1(25), A(24) 
                           => OP1(24), A(23) => OP1(23), A(22) => OP1(22), 
                           A(21) => OP1(21), A(20) => OP1(20), A(19) => OP1(19)
                           , A(18) => OP1(18), A(17) => OP1(17), A(16) => 
                           OP1(16), A(15) => OP1(15), A(14) => OP1(14), A(13) 
                           => OP1(13), A(12) => OP1(12), A(11) => OP1(11), 
                           A(10) => OP1(10), A(9) => OP1(9), A(8) => OP1(8), 
                           A(7) => OP1(7), A(6) => OP1(6), A(5) => OP1(5), A(4)
                           => OP1(4), A(3) => OP1(3), A(2) => OP1(2), A(1) => 
                           OP1(1), A(0) => OP1(0), B(31) => OP2(31), B(30) => 
                           OP2(30), B(29) => OP2(29), B(28) => OP2(28), B(27) 
                           => OP2(27), B(26) => OP2(26), B(25) => OP2(25), 
                           B(24) => OP2(24), B(23) => OP2(23), B(22) => OP2(22)
                           , B(21) => OP2(21), B(20) => OP2(20), B(19) => 
                           OP2(19), B(18) => OP2(18), B(17) => OP2(17), B(16) 
                           => OP2(16), B(15) => OP2(15), B(14) => OP2(14), 
                           B(13) => OP2(13), B(12) => OP2(12), B(11) => OP2(11)
                           , B(10) => OP2(10), B(9) => OP2(9), B(8) => OP2(8), 
                           B(7) => OP2(7), B(6) => OP2(6), B(5) => OP2(5), B(4)
                           => OP2(4), B(3) => OP2(3), B(2) => OP2(2), B(1) => 
                           OP2(1), B(0) => OP2(0), CI => n2, ADD_SUB => n381, 
                           SUM(31) => N280, SUM(30) => N279, SUM(29) => N278, 
                           SUM(28) => N277, SUM(27) => N276, SUM(26) => N275, 
                           SUM(25) => N274, SUM(24) => N273, SUM(23) => N272, 
                           SUM(22) => N271, SUM(21) => N270, SUM(20) => N269, 
                           SUM(19) => N268, SUM(18) => N267, SUM(17) => N266, 
                           SUM(16) => N265, SUM(15) => N264, SUM(14) => N263, 
                           SUM(13) => N262, SUM(12) => N261, SUM(11) => N260, 
                           SUM(10) => N259, SUM(9) => N258, SUM(8) => N257, 
                           SUM(7) => N256, SUM(6) => N255, SUM(5) => N254, 
                           SUM(4) => N253, SUM(3) => N252, SUM(2) => N251, 
                           SUM(1) => N250, SUM(0) => N249, CO => n_1256);
   OP_B_reg_0_inst : DLH_X2 port map( G => N281, D => N282, Q => OP_B_0_port);
   OP_B_reg_1_inst : DLH_X2 port map( G => N281, D => N283, Q => OP_B_1_port);
   OP_B_reg_3_inst : DLH_X2 port map( G => N281, D => N285, Q => OP_B_3_port);
   OP_B_reg_4_inst : DLH_X2 port map( G => N281, D => N286, Q => OP_B_4_port);
   OP_B_reg_2_inst : DLH_X2 port map( G => N281, D => N284, Q => OP_B_2_port);
   U4 : OR2_X1 port map( A1 => n470, A2 => n471, ZN => n375);
   U5 : OR2_X2 port map( A1 => n486, A2 => n378, ZN => n404);
   U6 : INV_X2 port map( A => n375, ZN => n376);
   U7 : INV_X1 port map( A => N315, ZN => n377);
   U8 : INV_X1 port map( A => n377, ZN => n378);
   U9 : INV_X1 port map( A => n402, ZN => n379);
   U10 : INV_X2 port map( A => n379, ZN => n380);
   U11 : NAND2_X2 port map( A1 => n187, A2 => n488, ZN => N281);
   U12 : OR3_X2 port map( A1 => N317, A2 => N318, A3 => n502, ZN => N316);
   U13 : OAI221_X4 port map( B1 => n385, B2 => n472, C1 => n473, C2 => n474, A 
                           => n475, ZN => n403);
   U14 : OAI221_X4 port map( B1 => n474, B2 => n477, C1 => n489, C2 => n387, A 
                           => n501, ZN => N319);
   U15 : INV_X2 port map( A => n475, ZN => n381);
   U16 : OAI21_X1 port map( B1 => n382, B2 => n383, A => n384, ZN => n176);
   U17 : NOR2_X1 port map( A1 => n385, A2 => n386, ZN => Z);
   U18 : MUX2_X1 port map( A => n387, B => n388, S => n389, Z => n386);
   U19 : NOR2_X1 port map( A1 => n390, A2 => n391, ZN => n389);
   U20 : NAND4_X1 port map( A1 => n392, A2 => n393, A3 => n394, A4 => n395, ZN 
                           => n391);
   U21 : NOR4_X1 port map( A1 => Y_23_port, A2 => Y_22_port, A3 => Y_21_port, 
                           A4 => Y_20_port, ZN => n395);
   U22 : NOR4_X1 port map( A1 => Y_1_port, A2 => Y_19_port, A3 => Y_18_port, A4
                           => Y_17_port, ZN => n394);
   U23 : NOR4_X1 port map( A1 => Y_16_port, A2 => Y_15_port, A3 => Y_14_port, 
                           A4 => Y_13_port, ZN => n393);
   U24 : NOR4_X1 port map( A1 => Y_12_port, A2 => Y_11_port, A3 => Y_10_port, 
                           A4 => Y_0_port, ZN => n392);
   U25 : NAND4_X1 port map( A1 => n396, A2 => n397, A3 => n398, A4 => n399, ZN 
                           => n390);
   U26 : NOR4_X1 port map( A1 => Y_9_port, A2 => Y_8_port, A3 => Y_7_port, A4 
                           => Y_6_port, ZN => n399);
   U27 : NOR4_X1 port map( A1 => Y_5_port, A2 => Y_4_port, A3 => Y_3_port, A4 
                           => Y_31_port, ZN => n398);
   U28 : NOR4_X1 port map( A1 => Y_30_port, A2 => Y_2_port, A3 => Y_29_port, A4
                           => Y_28_port, ZN => n397);
   U29 : NOR4_X1 port map( A1 => Y_27_port, A2 => Y_26_port, A3 => Y_25_port, 
                           A4 => Y_24_port, ZN => n396);
   U30 : NAND2_X1 port map( A1 => n400, A2 => n401, ZN => Y_9_port);
   U31 : AOI222_X1 port map( A1 => Y_SHIFTL_9_port, A2 => n380, B1 => N258, B2 
                           => n403, C1 => OP2(9), C2 => n376, ZN => n401);
   U32 : AOI222_X1 port map( A1 => Y_SHIFTR_9_port, A2 => N319, B1 => 
                           Y_SUM_9_port, B2 => n404, C1 => Y_LOGIC_9_port, C2 
                           => N316, ZN => n400);
   U33 : NAND2_X1 port map( A1 => n405, A2 => n406, ZN => Y_8_port);
   U34 : AOI222_X1 port map( A1 => Y_SHIFTL_8_port, A2 => n380, B1 => N257, B2 
                           => n403, C1 => OP2(8), C2 => n376, ZN => n406);
   U35 : AOI222_X1 port map( A1 => Y_SHIFTR_8_port, A2 => N319, B1 => 
                           Y_SUM_8_port, B2 => n404, C1 => Y_LOGIC_8_port, C2 
                           => N316, ZN => n405);
   U36 : NAND2_X1 port map( A1 => n407, A2 => n408, ZN => Y_7_port);
   U37 : AOI222_X1 port map( A1 => Y_SHIFTL_7_port, A2 => n380, B1 => N256, B2 
                           => n403, C1 => OP2(7), C2 => n376, ZN => n408);
   U38 : AOI222_X1 port map( A1 => Y_SHIFTR_7_port, A2 => N319, B1 => 
                           Y_SUM_7_port, B2 => n404, C1 => Y_LOGIC_7_port, C2 
                           => N316, ZN => n407);
   U39 : NAND2_X1 port map( A1 => n409, A2 => n410, ZN => Y_6_port);
   U40 : AOI222_X1 port map( A1 => Y_SHIFTL_6_port, A2 => n380, B1 => N255, B2 
                           => n403, C1 => OP2(6), C2 => n376, ZN => n410);
   U41 : AOI222_X1 port map( A1 => Y_SHIFTR_6_port, A2 => N319, B1 => 
                           Y_SUM_6_port, B2 => n404, C1 => Y_LOGIC_6_port, C2 
                           => N316, ZN => n409);
   U42 : NAND2_X1 port map( A1 => n411, A2 => n412, ZN => Y_5_port);
   U43 : AOI222_X1 port map( A1 => Y_SHIFTL_5_port, A2 => n380, B1 => N254, B2 
                           => n403, C1 => OP2(5), C2 => n376, ZN => n412);
   U44 : AOI222_X1 port map( A1 => Y_SHIFTR_5_port, A2 => N319, B1 => 
                           Y_SUM_5_port, B2 => n404, C1 => Y_LOGIC_5_port, C2 
                           => N316, ZN => n411);
   U45 : NAND2_X1 port map( A1 => n413, A2 => n414, ZN => Y_4_port);
   U46 : AOI222_X1 port map( A1 => Y_SHIFTL_4_port, A2 => n380, B1 => N253, B2 
                           => n403, C1 => OP2(4), C2 => n376, ZN => n414);
   U47 : AOI222_X1 port map( A1 => Y_SHIFTR_4_port, A2 => N319, B1 => 
                           Y_SUM_4_port, B2 => n404, C1 => Y_LOGIC_4_port, C2 
                           => N316, ZN => n413);
   U48 : NAND2_X1 port map( A1 => n415, A2 => n416, ZN => Y_3_port);
   U49 : AOI222_X1 port map( A1 => Y_SHIFTL_3_port, A2 => n380, B1 => N252, B2 
                           => n403, C1 => OP2(3), C2 => n376, ZN => n416);
   U50 : AOI222_X1 port map( A1 => Y_SHIFTR_3_port, A2 => N319, B1 => 
                           Y_SUM_3_port, B2 => n404, C1 => Y_LOGIC_3_port, C2 
                           => N316, ZN => n415);
   U51 : NAND2_X1 port map( A1 => n417, A2 => n418, ZN => Y_31_port);
   U52 : AOI222_X1 port map( A1 => Y_SHIFTL_31_port, A2 => n380, B1 => N280, B2
                           => n403, C1 => OP2(31), C2 => n376, ZN => n418);
   U53 : AOI222_X1 port map( A1 => Y_SHIFTR_31_port, A2 => N319, B1 => 
                           Y_SUM_31_port, B2 => n404, C1 => Y_LOGIC_31_port, C2
                           => N316, ZN => n417);
   U54 : NAND2_X1 port map( A1 => n419, A2 => n420, ZN => Y_30_port);
   U55 : AOI222_X1 port map( A1 => Y_SHIFTL_30_port, A2 => n380, B1 => N279, B2
                           => n403, C1 => OP2(30), C2 => n376, ZN => n420);
   U56 : AOI222_X1 port map( A1 => Y_SHIFTR_30_port, A2 => N319, B1 => 
                           Y_SUM_30_port, B2 => n404, C1 => Y_LOGIC_30_port, C2
                           => N316, ZN => n419);
   U57 : NAND3_X1 port map( A1 => n421, A2 => n422, A3 => n423, ZN => Y_2_port)
                           ;
   U58 : AOI222_X1 port map( A1 => Y_SHIFTR_2_port, A2 => N319, B1 => 
                           Y_SUM_2_port, B2 => n404, C1 => Y_LOGIC_2_port, C2 
                           => N316, ZN => n423);
   U59 : AOI21_X1 port map( B1 => N251, B2 => n403, A => n424, ZN => n422);
   U60 : AOI22_X1 port map( A1 => OP2(2), A2 => n376, B1 => Y_SHIFTL_2_port, B2
                           => n380, ZN => n421);
   U61 : NAND2_X1 port map( A1 => n425, A2 => n426, ZN => Y_29_port);
   U62 : AOI222_X1 port map( A1 => Y_SHIFTL_29_port, A2 => n380, B1 => N278, B2
                           => n403, C1 => OP2(29), C2 => n376, ZN => n426);
   U63 : AOI222_X1 port map( A1 => Y_SHIFTR_29_port, A2 => N319, B1 => 
                           Y_SUM_29_port, B2 => n404, C1 => Y_LOGIC_29_port, C2
                           => N316, ZN => n425);
   U64 : NAND2_X1 port map( A1 => n427, A2 => n428, ZN => Y_28_port);
   U65 : AOI222_X1 port map( A1 => Y_SHIFTL_28_port, A2 => n380, B1 => N277, B2
                           => n403, C1 => OP2(28), C2 => n376, ZN => n428);
   U66 : AOI222_X1 port map( A1 => Y_SHIFTR_28_port, A2 => N319, B1 => 
                           Y_SUM_28_port, B2 => n404, C1 => Y_LOGIC_28_port, C2
                           => N316, ZN => n427);
   U67 : NAND2_X1 port map( A1 => n429, A2 => n430, ZN => Y_27_port);
   U68 : AOI222_X1 port map( A1 => Y_SHIFTL_27_port, A2 => n380, B1 => N276, B2
                           => n403, C1 => OP2(27), C2 => n376, ZN => n430);
   U69 : AOI222_X1 port map( A1 => Y_SHIFTR_27_port, A2 => N319, B1 => 
                           Y_SUM_27_port, B2 => n404, C1 => Y_LOGIC_27_port, C2
                           => N316, ZN => n429);
   U70 : NAND2_X1 port map( A1 => n431, A2 => n432, ZN => Y_26_port);
   U71 : AOI222_X1 port map( A1 => Y_SHIFTL_26_port, A2 => n380, B1 => N275, B2
                           => n403, C1 => OP2(26), C2 => n376, ZN => n432);
   U72 : AOI222_X1 port map( A1 => Y_SHIFTR_26_port, A2 => N319, B1 => 
                           Y_SUM_26_port, B2 => n404, C1 => Y_LOGIC_26_port, C2
                           => N316, ZN => n431);
   U73 : NAND2_X1 port map( A1 => n433, A2 => n434, ZN => Y_25_port);
   U74 : AOI222_X1 port map( A1 => Y_SHIFTL_25_port, A2 => n380, B1 => N274, B2
                           => n403, C1 => OP2(25), C2 => n376, ZN => n434);
   U75 : AOI222_X1 port map( A1 => Y_SHIFTR_25_port, A2 => N319, B1 => 
                           Y_SUM_25_port, B2 => n404, C1 => Y_LOGIC_25_port, C2
                           => N316, ZN => n433);
   U76 : NAND2_X1 port map( A1 => n435, A2 => n436, ZN => Y_24_port);
   U77 : AOI222_X1 port map( A1 => Y_SHIFTL_24_port, A2 => n380, B1 => N273, B2
                           => n403, C1 => OP2(24), C2 => n376, ZN => n436);
   U78 : AOI222_X1 port map( A1 => Y_SHIFTR_24_port, A2 => N319, B1 => 
                           Y_SUM_24_port, B2 => n404, C1 => Y_LOGIC_24_port, C2
                           => N316, ZN => n435);
   U79 : NAND2_X1 port map( A1 => n437, A2 => n438, ZN => Y_23_port);
   U80 : AOI222_X1 port map( A1 => Y_SHIFTL_23_port, A2 => n380, B1 => N272, B2
                           => n403, C1 => OP2(23), C2 => n376, ZN => n438);
   U81 : AOI222_X1 port map( A1 => Y_SHIFTR_23_port, A2 => N319, B1 => 
                           Y_SUM_23_port, B2 => n404, C1 => Y_LOGIC_23_port, C2
                           => N316, ZN => n437);
   U82 : NAND2_X1 port map( A1 => n439, A2 => n440, ZN => Y_22_port);
   U83 : AOI222_X1 port map( A1 => Y_SHIFTL_22_port, A2 => n380, B1 => N271, B2
                           => n403, C1 => OP2(22), C2 => n376, ZN => n440);
   U84 : AOI222_X1 port map( A1 => Y_SHIFTR_22_port, A2 => N319, B1 => 
                           Y_SUM_22_port, B2 => n404, C1 => Y_LOGIC_22_port, C2
                           => N316, ZN => n439);
   U85 : NAND2_X1 port map( A1 => n441, A2 => n442, ZN => Y_21_port);
   U86 : AOI222_X1 port map( A1 => Y_SHIFTL_21_port, A2 => n380, B1 => N270, B2
                           => n403, C1 => OP2(21), C2 => n376, ZN => n442);
   U87 : AOI222_X1 port map( A1 => Y_SHIFTR_21_port, A2 => N319, B1 => 
                           Y_SUM_21_port, B2 => n404, C1 => Y_LOGIC_21_port, C2
                           => N316, ZN => n441);
   U88 : NAND2_X1 port map( A1 => n443, A2 => n444, ZN => Y_20_port);
   U89 : AOI222_X1 port map( A1 => Y_SHIFTL_20_port, A2 => n380, B1 => N269, B2
                           => n403, C1 => OP2(20), C2 => n376, ZN => n444);
   U90 : AOI222_X1 port map( A1 => Y_SHIFTR_20_port, A2 => N319, B1 => 
                           Y_SUM_20_port, B2 => n404, C1 => Y_LOGIC_20_port, C2
                           => N316, ZN => n443);
   U91 : NAND2_X1 port map( A1 => n445, A2 => n446, ZN => Y_1_port);
   U92 : AOI222_X1 port map( A1 => Y_SHIFTL_1_port, A2 => n380, B1 => N250, B2 
                           => n403, C1 => OP2(1), C2 => n376, ZN => n446);
   U93 : AOI222_X1 port map( A1 => Y_SHIFTR_1_port, A2 => N319, B1 => 
                           Y_SUM_1_port, B2 => n404, C1 => Y_LOGIC_1_port, C2 
                           => N316, ZN => n445);
   U94 : NAND2_X1 port map( A1 => n447, A2 => n448, ZN => Y_19_port);
   U95 : AOI222_X1 port map( A1 => Y_SHIFTL_19_port, A2 => n380, B1 => N268, B2
                           => n403, C1 => OP2(19), C2 => n376, ZN => n448);
   U96 : AOI222_X1 port map( A1 => Y_SHIFTR_19_port, A2 => N319, B1 => 
                           Y_SUM_19_port, B2 => n404, C1 => Y_LOGIC_19_port, C2
                           => N316, ZN => n447);
   U97 : NAND2_X1 port map( A1 => n449, A2 => n450, ZN => Y_18_port);
   U98 : AOI222_X1 port map( A1 => Y_SHIFTL_18_port, A2 => n380, B1 => N267, B2
                           => n403, C1 => OP2(18), C2 => n376, ZN => n450);
   U99 : AOI222_X1 port map( A1 => Y_SHIFTR_18_port, A2 => N319, B1 => 
                           Y_SUM_18_port, B2 => n404, C1 => Y_LOGIC_18_port, C2
                           => N316, ZN => n449);
   U100 : NAND2_X1 port map( A1 => n451, A2 => n452, ZN => Y_17_port);
   U101 : AOI222_X1 port map( A1 => Y_SHIFTL_17_port, A2 => n380, B1 => N266, 
                           B2 => n403, C1 => OP2(17), C2 => n376, ZN => n452);
   U102 : AOI222_X1 port map( A1 => Y_SHIFTR_17_port, A2 => N319, B1 => 
                           Y_SUM_17_port, B2 => n404, C1 => Y_LOGIC_17_port, C2
                           => N316, ZN => n451);
   U103 : NAND2_X1 port map( A1 => n453, A2 => n454, ZN => Y_16_port);
   U104 : AOI222_X1 port map( A1 => Y_SHIFTL_16_port, A2 => n380, B1 => N265, 
                           B2 => n403, C1 => OP2(16), C2 => n376, ZN => n454);
   U105 : AOI222_X1 port map( A1 => Y_SHIFTR_16_port, A2 => N319, B1 => 
                           Y_SUM_16_port, B2 => n404, C1 => Y_LOGIC_16_port, C2
                           => N316, ZN => n453);
   U106 : NAND2_X1 port map( A1 => n455, A2 => n456, ZN => Y_15_port);
   U107 : AOI222_X1 port map( A1 => Y_SHIFTL_15_port, A2 => n380, B1 => N264, 
                           B2 => n403, C1 => OP2(15), C2 => n376, ZN => n456);
   U108 : AOI222_X1 port map( A1 => Y_SHIFTR_15_port, A2 => N319, B1 => 
                           Y_SUM_15_port, B2 => n404, C1 => Y_LOGIC_15_port, C2
                           => N316, ZN => n455);
   U109 : NAND2_X1 port map( A1 => n457, A2 => n458, ZN => Y_14_port);
   U110 : AOI222_X1 port map( A1 => Y_SHIFTL_14_port, A2 => n380, B1 => N263, 
                           B2 => n403, C1 => OP2(14), C2 => n376, ZN => n458);
   U111 : AOI222_X1 port map( A1 => Y_SHIFTR_14_port, A2 => N319, B1 => 
                           Y_SUM_14_port, B2 => n404, C1 => Y_LOGIC_14_port, C2
                           => N316, ZN => n457);
   U112 : NAND2_X1 port map( A1 => n459, A2 => n460, ZN => Y_13_port);
   U113 : AOI222_X1 port map( A1 => Y_SHIFTL_13_port, A2 => n380, B1 => N262, 
                           B2 => n403, C1 => OP2(13), C2 => n376, ZN => n460);
   U114 : AOI222_X1 port map( A1 => Y_SHIFTR_13_port, A2 => N319, B1 => 
                           Y_SUM_13_port, B2 => n404, C1 => Y_LOGIC_13_port, C2
                           => N316, ZN => n459);
   U115 : NAND2_X1 port map( A1 => n461, A2 => n462, ZN => Y_12_port);
   U116 : AOI222_X1 port map( A1 => Y_SHIFTL_12_port, A2 => n380, B1 => N261, 
                           B2 => n403, C1 => OP2(12), C2 => n376, ZN => n462);
   U117 : AOI222_X1 port map( A1 => Y_SHIFTR_12_port, A2 => N319, B1 => 
                           Y_SUM_12_port, B2 => n404, C1 => Y_LOGIC_12_port, C2
                           => N316, ZN => n461);
   U118 : NAND2_X1 port map( A1 => n463, A2 => n464, ZN => Y_11_port);
   U119 : AOI222_X1 port map( A1 => Y_SHIFTL_11_port, A2 => n380, B1 => N260, 
                           B2 => n403, C1 => OP2(11), C2 => n376, ZN => n464);
   U120 : AOI222_X1 port map( A1 => Y_SHIFTR_11_port, A2 => N319, B1 => 
                           Y_SUM_11_port, B2 => n404, C1 => Y_LOGIC_11_port, C2
                           => N316, ZN => n463);
   U121 : NAND2_X1 port map( A1 => n465, A2 => n466, ZN => Y_10_port);
   U122 : AOI222_X1 port map( A1 => Y_SHIFTL_10_port, A2 => n380, B1 => N259, 
                           B2 => n403, C1 => OP2(10), C2 => n376, ZN => n466);
   U123 : AOI222_X1 port map( A1 => Y_SHIFTR_10_port, A2 => N319, B1 => 
                           Y_SUM_10_port, B2 => n404, C1 => Y_LOGIC_10_port, C2
                           => N316, ZN => n465);
   U124 : NAND3_X1 port map( A1 => n467, A2 => n468, A3 => n469, ZN => Y_0_port
                           );
   U125 : AOI222_X1 port map( A1 => Y_COMPARE_0_port, A2 => N320, B1 => 
                           Y_LOGIC_0_port, B2 => N316, C1 => Y_SHIFTR_0_port, 
                           C2 => N319, ZN => n469);
   U126 : AOI22_X1 port map( A1 => N249, A2 => n403, B1 => OP2(0), B2 => n376, 
                           ZN => n468);
   U127 : INV_X1 port map( A => U3_U1_Z_0, ZN => n475);
   U128 : AOI22_X1 port map( A1 => Y_SHIFTL_0_port, A2 => n380, B1 => 
                           Y_SUM_0_port, B2 => n404, ZN => n467);
   U129 : OAI22_X1 port map( A1 => n474, A2 => n476, B1 => n471, B2 => n477, ZN
                           => U3_U1_Z_0);
   U130 : OAI222_X1 port map( A1 => n478, A2 => n472, B1 => n382, B2 => n387, 
                           C1 => n388, C2 => n479, ZN => N324);
   U131 : OAI211_X1 port map( C1 => n480, C2 => n479, A => n481, B => n482, ZN 
                           => N323);
   U132 : INV_X1 port map( A => n483, ZN => n482);
   U133 : OAI22_X1 port map( A1 => n484, A2 => n382, B1 => n478, B2 => n470, ZN
                           => n483);
   U134 : AND2_X1 port map( A1 => n388, A2 => n477, ZN => n484);
   U135 : MUX2_X1 port map( A => n378, B => n485, S => OP2(31), Z => N313);
   U136 : MUX2_X1 port map( A => n378, B => n485, S => OP2(30), Z => N312);
   U137 : MUX2_X1 port map( A => n378, B => n485, S => OP2(29), Z => N311);
   U138 : MUX2_X1 port map( A => n378, B => n485, S => OP2(28), Z => N310);
   U139 : MUX2_X1 port map( A => n378, B => n485, S => OP2(27), Z => N309);
   U140 : MUX2_X1 port map( A => n378, B => n485, S => OP2(26), Z => N308);
   U141 : MUX2_X1 port map( A => n378, B => n485, S => OP2(25), Z => N307);
   U142 : MUX2_X1 port map( A => n378, B => n485, S => OP2(24), Z => N306);
   U143 : MUX2_X1 port map( A => n378, B => n485, S => OP2(23), Z => N305);
   U144 : MUX2_X1 port map( A => n378, B => n485, S => OP2(22), Z => N304);
   U145 : MUX2_X1 port map( A => n378, B => n485, S => OP2(21), Z => N303);
   U146 : MUX2_X1 port map( A => n378, B => n485, S => OP2(20), Z => N302);
   U147 : MUX2_X1 port map( A => n378, B => n485, S => OP2(19), Z => N301);
   U148 : MUX2_X1 port map( A => n378, B => n485, S => OP2(18), Z => N300);
   U149 : MUX2_X1 port map( A => n378, B => n485, S => OP2(17), Z => N299);
   U150 : MUX2_X1 port map( A => n378, B => n485, S => OP2(16), Z => N298);
   U151 : MUX2_X1 port map( A => n378, B => n485, S => OP2(15), Z => N297);
   U152 : MUX2_X1 port map( A => n378, B => n485, S => OP2(14), Z => N296);
   U153 : MUX2_X1 port map( A => n378, B => n485, S => OP2(13), Z => N295);
   U154 : MUX2_X1 port map( A => n378, B => n485, S => OP2(12), Z => N294);
   U155 : MUX2_X1 port map( A => n378, B => n485, S => OP2(11), Z => N293);
   U156 : MUX2_X1 port map( A => n378, B => n485, S => OP2(10), Z => N292);
   U157 : MUX2_X1 port map( A => n378, B => n485, S => OP2(9), Z => N291);
   U158 : MUX2_X1 port map( A => n378, B => n485, S => OP2(8), Z => N290);
   U159 : MUX2_X1 port map( A => n378, B => n485, S => OP2(7), Z => N289);
   U160 : MUX2_X1 port map( A => n378, B => n485, S => OP2(6), Z => N288);
   U161 : MUX2_X1 port map( A => n378, B => n485, S => OP2(5), Z => N287);
   U162 : MUX2_X1 port map( A => n378, B => n485, S => OP2(4), Z => N286);
   U163 : MUX2_X1 port map( A => n378, B => n485, S => OP2(3), Z => N285);
   U164 : MUX2_X1 port map( A => n378, B => n485, S => OP2(2), Z => N284);
   U165 : MUX2_X1 port map( A => n378, B => n485, S => OP2(1), Z => N283);
   U166 : MUX2_X1 port map( A => n378, B => n485, S => OP2(0), Z => N282);
   U167 : OR3_X1 port map( A1 => n486, A2 => n424, A3 => n487, ZN => n485);
   U168 : INV_X1 port map( A => n488, ZN => n487);
   U169 : NOR4_X1 port map( A1 => n380, A2 => N316, A3 => N319, A4 => N320, ZN 
                           => n488);
   U170 : OAI211_X1 port map( C1 => n489, C2 => n470, A => n384, B => n490, ZN 
                           => N320);
   U171 : AOI221_X1 port map( B1 => n491, B2 => n492, C1 => n493, C2 => n494, A
                           => N321, ZN => n490);
   U172 : OAI222_X1 port map( A1 => n387, A2 => n478, B1 => n382, B2 => n495, 
                           C1 => n489, C2 => n476, ZN => N321);
   U173 : AND3_X1 port map( A1 => n383, A2 => n387, A3 => n477, ZN => n495);
   U174 : INV_X1 port map( A => n492, ZN => n383);
   U175 : AOI21_X1 port map( B1 => OPC(2), B2 => n496, A => n497, ZN => n382);
   U176 : INV_X1 port map( A => n498, ZN => n497);
   U177 : NAND3_X1 port map( A1 => n470, A2 => n388, A3 => n472, ZN => n494);
   U178 : INV_X1 port map( A => n478, ZN => n493);
   U179 : NAND2_X1 port map( A1 => n388, A2 => n480, ZN => n492);
   U180 : INV_X1 port map( A => n499, ZN => n384);
   U181 : OAI221_X1 port map( B1 => n489, B2 => n472, C1 => n473, C2 => n478, A
                           => n481, ZN => n499);
   U182 : INV_X1 port map( A => n500, ZN => n481);
   U183 : OAI22_X1 port map( A1 => n478, A2 => n476, B1 => n479, B2 => n477, ZN
                           => n500);
   U184 : INV_X1 port map( A => n515, ZN => n501);
   U185 : OAI22_X1 port map( A1 => n388, A2 => n474, B1 => n489, B2 => n473, ZN
                           => n515);
   U186 : OAI22_X1 port map( A1 => n472, A2 => n474, B1 => n471, B2 => n388, ZN
                           => n502);
   U187 : NAND3_X1 port map( A1 => OPC(5), A2 => OPC(4), A3 => OPC(6), ZN => 
                           n472);
   U188 : OAI22_X1 port map( A1 => n473, A2 => n471, B1 => n477, B2 => n478, ZN
                           => N318);
   U189 : NAND3_X1 port map( A1 => n503, A2 => n504, A3 => OPC(6), ZN => n477);
   U190 : OAI22_X1 port map( A1 => n471, A2 => n387, B1 => n480, B2 => n478, ZN
                           => N317);
   U191 : NAND2_X1 port map( A1 => n496, A2 => n505, ZN => n478);
   U192 : NOR3_X1 port map( A1 => OPC(1), A2 => OPC(0), A3 => n506, ZN => n496)
                           ;
   U193 : OAI22_X1 port map( A1 => n474, A2 => n480, B1 => n489, B2 => n388, ZN
                           => n402);
   U194 : NAND3_X1 port map( A1 => OPC(3), A2 => n507, A3 => OPC(0), ZN => n489
                           );
   U195 : NOR2_X1 port map( A1 => n404, A2 => n424, ZN => n187);
   U196 : AOI21_X1 port map( B1 => n473, B2 => n470, A => n498, ZN => n424);
   U197 : NAND4_X1 port map( A1 => OPC(1), A2 => OPC(0), A3 => n506, A4 => n505
                           , ZN => n498);
   U198 : OAI22_X1 port map( A1 => n474, A2 => n470, B1 => n471, B2 => n480, ZN
                           => N315);
   U199 : NAND3_X1 port map( A1 => n503, A2 => n504, A3 => n508, ZN => n480);
   U200 : NAND3_X1 port map( A1 => n507, A2 => n506, A3 => OPC(0), ZN => n471);
   U201 : OAI221_X1 port map( B1 => n470, B2 => n479, C1 => n474, C2 => n387, A
                           => n509, ZN => n486);
   U202 : INV_X1 port map( A => n510, ZN => n509);
   U203 : OAI21_X1 port map( B1 => n385, B2 => n511, A => n512, ZN => n510);
   U204 : OR3_X1 port map( A1 => n513, A2 => n473, A3 => n505, ZN => n512);
   U205 : NAND3_X1 port map( A1 => n508, A2 => n503, A3 => OPC(4), ZN => n473);
   U206 : OR3_X1 port map( A1 => n506, A2 => OPC(1), A3 => n514, ZN => n513);
   U207 : AND3_X1 port map( A1 => n387, A2 => n388, A3 => n476, ZN => n511);
   U208 : NAND3_X1 port map( A1 => OPC(4), A2 => n508, A3 => OPC(5), ZN => n476
                           );
   U209 : NAND3_X1 port map( A1 => n508, A2 => n504, A3 => OPC(5), ZN => n388);
   U210 : INV_X1 port map( A => OPC(6), ZN => n508);
   U211 : NAND4_X1 port map( A1 => OPC(2), A2 => OPC(1), A3 => OPC(3), A4 => 
                           n514, ZN => n385);
   U212 : NAND3_X1 port map( A1 => OPC(5), A2 => n504, A3 => OPC(6), ZN => n387
                           );
   U213 : INV_X1 port map( A => OPC(4), ZN => n504);
   U214 : NAND3_X1 port map( A1 => n506, A2 => n514, A3 => n507, ZN => n474);
   U215 : NOR2_X1 port map( A1 => OPC(1), A2 => OPC(2), ZN => n507);
   U216 : INV_X1 port map( A => OPC(3), ZN => n506);
   U217 : INV_X1 port map( A => n491, ZN => n479);
   U218 : NOR4_X1 port map( A1 => n505, A2 => n514, A3 => OPC(3), A4 => OPC(1),
                           ZN => n491);
   U219 : INV_X1 port map( A => OPC(0), ZN => n514);
   U220 : INV_X1 port map( A => OPC(2), ZN => n505);
   U221 : NAND3_X1 port map( A1 => OPC(4), A2 => n503, A3 => OPC(6), ZN => n470
                           );
   U222 : INV_X1 port map( A => OPC(5), ZN => n503);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity REGADDR_N32_OPC6_REG5 is

   port( INSTR : in std_logic_vector (31 downto 0);  RS1, RS2, RD : out 
         std_logic_vector (4 downto 0));

end REGADDR_N32_OPC6_REG5;

architecture SYN_BEHAVIORAL of REGADDR_N32_OPC6_REG5 is

   component NOR4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   signal n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
      n72 : std_logic;

begin
   
   U2 : NOR2_X1 port map( A1 => n58, A2 => n59, ZN => RS2(4));
   U3 : NOR2_X1 port map( A1 => n58, A2 => n60, ZN => RS2(3));
   U4 : NOR2_X1 port map( A1 => n58, A2 => n61, ZN => RS2(2));
   U5 : NOR2_X1 port map( A1 => n58, A2 => n62, ZN => RS2(1));
   U6 : NOR2_X1 port map( A1 => n58, A2 => n63, ZN => RS2(0));
   U7 : AND2_X1 port map( A1 => INSTR(25), A2 => n64, ZN => RS1(4));
   U8 : AND2_X1 port map( A1 => INSTR(24), A2 => n64, ZN => RS1(3));
   U9 : AND2_X1 port map( A1 => INSTR(23), A2 => n64, ZN => RS1(2));
   U10 : AND2_X1 port map( A1 => INSTR(22), A2 => n64, ZN => RS1(1));
   U11 : AND2_X1 port map( A1 => INSTR(21), A2 => n64, ZN => RS1(0));
   U12 : OAI22_X1 port map( A1 => n58, A2 => n65, B1 => n59, B2 => n66, ZN => 
                           RD(4));
   U13 : INV_X1 port map( A => INSTR(20), ZN => n59);
   U14 : INV_X1 port map( A => INSTR(15), ZN => n65);
   U15 : OAI22_X1 port map( A1 => n58, A2 => n67, B1 => n60, B2 => n66, ZN => 
                           RD(3));
   U16 : INV_X1 port map( A => INSTR(19), ZN => n60);
   U17 : INV_X1 port map( A => INSTR(14), ZN => n67);
   U18 : OAI22_X1 port map( A1 => n58, A2 => n68, B1 => n61, B2 => n66, ZN => 
                           RD(2));
   U19 : INV_X1 port map( A => INSTR(18), ZN => n61);
   U20 : INV_X1 port map( A => INSTR(13), ZN => n68);
   U21 : OAI22_X1 port map( A1 => n58, A2 => n69, B1 => n62, B2 => n66, ZN => 
                           RD(1));
   U22 : INV_X1 port map( A => INSTR(17), ZN => n62);
   U23 : INV_X1 port map( A => INSTR(12), ZN => n69);
   U24 : OAI22_X1 port map( A1 => n58, A2 => n70, B1 => n63, B2 => n66, ZN => 
                           RD(0));
   U25 : NAND2_X1 port map( A1 => n58, A2 => n64, ZN => n66);
   U26 : NAND2_X1 port map( A1 => INSTR(27), A2 => n71, ZN => n64);
   U27 : INV_X1 port map( A => INSTR(16), ZN => n63);
   U28 : INV_X1 port map( A => INSTR(11), ZN => n70);
   U29 : OR3_X1 port map( A1 => INSTR(27), A2 => INSTR(26), A3 => n72, ZN => 
                           n58);
   U30 : INV_X1 port map( A => n71, ZN => n72);
   U31 : NOR4_X1 port map( A1 => INSTR(29), A2 => INSTR(28), A3 => INSTR(31), 
                           A4 => INSTR(30), ZN => n71);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity SIGNEX_N32_OPC6_REG5 is

   port( INSTR : in std_logic_vector (31 downto 0);  IMM : out std_logic_vector
         (31 downto 0));

end SIGNEX_N32_OPC6_REG5;

architecture SYN_BEHAVIORAL of SIGNEX_N32_OPC6_REG5 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component MUX2_X1
      port( A, B, S : in std_logic;  Z : out std_logic);
   end component;
   
   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   signal n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, 
      n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, 
      n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, 
      n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, 
      n147, n148 : std_logic;

begin
   
   U2 : NOR2_X1 port map( A1 => n100, A2 => n101, ZN => IMM(9));
   U3 : NOR2_X1 port map( A1 => n100, A2 => n102, ZN => IMM(8));
   U4 : NOR2_X1 port map( A1 => n100, A2 => n103, ZN => IMM(7));
   U5 : NOR2_X1 port map( A1 => n100, A2 => n104, ZN => IMM(6));
   U6 : NOR2_X1 port map( A1 => n100, A2 => n105, ZN => IMM(5));
   U7 : NOR2_X1 port map( A1 => n100, A2 => n106, ZN => IMM(4));
   U8 : NOR2_X1 port map( A1 => n100, A2 => n107, ZN => IMM(3));
   U9 : OAI22_X1 port map( A1 => n108, A2 => n109, B1 => n110, B2 => n111, ZN 
                           => IMM(31));
   U10 : INV_X1 port map( A => n112, ZN => n110);
   U11 : OAI21_X1 port map( B1 => n113, B2 => n114, A => n115, ZN => IMM(30));
   U12 : NOR2_X1 port map( A1 => n100, A2 => n116, ZN => IMM(2));
   U13 : OAI21_X1 port map( B1 => n113, B2 => n117, A => n115, ZN => IMM(29));
   U14 : OAI21_X1 port map( B1 => n113, B2 => n118, A => n115, ZN => IMM(28));
   U15 : OAI21_X1 port map( B1 => n113, B2 => n119, A => n115, ZN => IMM(27));
   U16 : OAI21_X1 port map( B1 => n113, B2 => n120, A => n115, ZN => IMM(26));
   U17 : OAI21_X1 port map( B1 => n101, B2 => n113, A => n115, ZN => IMM(25));
   U18 : NAND2_X1 port map( A1 => n112, A2 => n121, ZN => n115);
   U19 : OAI22_X1 port map( A1 => n108, A2 => n109, B1 => n122, B2 => n111, ZN 
                           => n121);
   U20 : INV_X1 port map( A => n113, ZN => n122);
   U21 : INV_X1 port map( A => INSTR(25), ZN => n109);
   U22 : INV_X1 port map( A => INSTR(9), ZN => n101);
   U23 : OAI21_X1 port map( B1 => n102, B2 => n113, A => n123, ZN => IMM(24));
   U24 : AOI21_X1 port map( B1 => INSTR(24), B2 => n124, A => n125, ZN => n123)
                           ;
   U25 : INV_X1 port map( A => INSTR(8), ZN => n102);
   U26 : OAI21_X1 port map( B1 => n103, B2 => n113, A => n126, ZN => IMM(23));
   U27 : AOI21_X1 port map( B1 => INSTR(23), B2 => n124, A => n125, ZN => n126)
                           ;
   U28 : INV_X1 port map( A => INSTR(7), ZN => n103);
   U29 : OAI21_X1 port map( B1 => n104, B2 => n113, A => n127, ZN => IMM(22));
   U30 : AOI21_X1 port map( B1 => INSTR(22), B2 => n124, A => n125, ZN => n127)
                           ;
   U31 : INV_X1 port map( A => INSTR(6), ZN => n104);
   U32 : OAI21_X1 port map( B1 => n105, B2 => n113, A => n128, ZN => IMM(21));
   U33 : AOI21_X1 port map( B1 => INSTR(21), B2 => n124, A => n125, ZN => n128)
                           ;
   U34 : INV_X1 port map( A => INSTR(5), ZN => n105);
   U35 : OAI21_X1 port map( B1 => n106, B2 => n113, A => n129, ZN => IMM(20));
   U36 : AOI21_X1 port map( B1 => INSTR(20), B2 => n124, A => n125, ZN => n129)
                           ;
   U37 : INV_X1 port map( A => INSTR(4), ZN => n106);
   U38 : NOR2_X1 port map( A1 => n100, A2 => n130, ZN => IMM(1));
   U39 : OAI21_X1 port map( B1 => n107, B2 => n113, A => n131, ZN => IMM(19));
   U40 : AOI21_X1 port map( B1 => INSTR(19), B2 => n124, A => n125, ZN => n131)
                           ;
   U41 : INV_X1 port map( A => INSTR(3), ZN => n107);
   U42 : OAI21_X1 port map( B1 => n113, B2 => n116, A => n132, ZN => IMM(18));
   U43 : AOI21_X1 port map( B1 => INSTR(18), B2 => n124, A => n125, ZN => n132)
                           ;
   U44 : INV_X1 port map( A => INSTR(2), ZN => n116);
   U45 : OAI21_X1 port map( B1 => n113, B2 => n130, A => n133, ZN => IMM(17));
   U46 : AOI21_X1 port map( B1 => INSTR(17), B2 => n124, A => n125, ZN => n133)
                           ;
   U47 : INV_X1 port map( A => INSTR(1), ZN => n130);
   U48 : OAI21_X1 port map( B1 => n113, B2 => n134, A => n135, ZN => IMM(16));
   U49 : AOI21_X1 port map( B1 => INSTR(16), B2 => n124, A => n125, ZN => n135)
                           ;
   U50 : NOR2_X1 port map( A1 => n111, A2 => n100, ZN => n125);
   U51 : NAND3_X1 port map( A1 => INSTR(15), A2 => n108, A3 => n136, ZN => n111
                           );
   U52 : MUX2_X1 port map( A => n137, B => n138, S => INSTR(31), Z => n136);
   U53 : NAND3_X1 port map( A1 => INSTR(29), A2 => n139, A3 => INSTR(30), ZN =>
                           n138);
   U54 : XOR2_X1 port map( A => INSTR(28), B => INSTR(27), Z => n139);
   U55 : NAND2_X1 port map( A1 => INSTR(26), A2 => n140, ZN => n137);
   U56 : MUX2_X1 port map( A => n141, B => n142, S => INSTR(30), Z => n140);
   U57 : NOR3_X1 port map( A1 => n143, A2 => INSTR(29), A3 => n144, ZN => n142)
                           ;
   U58 : AND2_X1 port map( A1 => n143, A2 => INSTR(29), ZN => n141);
   U59 : INV_X1 port map( A => INSTR(28), ZN => n143);
   U60 : INV_X1 port map( A => n108, ZN => n124);
   U61 : NAND2_X1 port map( A1 => INSTR(27), A2 => n145, ZN => n108);
   U62 : NOR2_X1 port map( A1 => n100, A2 => n146, ZN => IMM(15));
   U63 : INV_X1 port map( A => INSTR(15), ZN => n146);
   U64 : NOR2_X1 port map( A1 => n100, A2 => n114, ZN => IMM(14));
   U65 : INV_X1 port map( A => INSTR(14), ZN => n114);
   U66 : NOR2_X1 port map( A1 => n100, A2 => n117, ZN => IMM(13));
   U67 : INV_X1 port map( A => INSTR(13), ZN => n117);
   U68 : NOR2_X1 port map( A1 => n100, A2 => n118, ZN => IMM(12));
   U69 : INV_X1 port map( A => INSTR(12), ZN => n118);
   U70 : NOR2_X1 port map( A1 => n100, A2 => n119, ZN => IMM(11));
   U71 : INV_X1 port map( A => INSTR(11), ZN => n119);
   U72 : NOR2_X1 port map( A1 => n100, A2 => n120, ZN => IMM(10));
   U73 : INV_X1 port map( A => INSTR(10), ZN => n120);
   U74 : NOR2_X1 port map( A1 => n100, A2 => n134, ZN => IMM(0));
   U75 : INV_X1 port map( A => INSTR(0), ZN => n134);
   U76 : NAND2_X1 port map( A1 => n113, A2 => n112, ZN => n100);
   U77 : NAND3_X1 port map( A1 => n147, A2 => n144, A3 => n145, ZN => n112);
   U78 : NOR4_X1 port map( A1 => INSTR(28), A2 => INSTR(29), A3 => INSTR(30), 
                           A4 => INSTR(31), ZN => n145);
   U79 : INV_X1 port map( A => INSTR(27), ZN => n144);
   U80 : NAND4_X1 port map( A1 => INSTR(28), A2 => INSTR(27), A3 => INSTR(29), 
                           A4 => n148, ZN => n113);
   U81 : NOR3_X1 port map( A1 => n147, A2 => INSTR(31), A3 => INSTR(30), ZN => 
                           n148);
   U82 : INV_X1 port map( A => INSTR(26), ZN => n147);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity RF_N32_NA5 is

   port( RST, EN, EN_RD1, EN_RD2, EN_WR : in std_logic;  ADD_RD1, ADD_RD2, 
         ADD_WR : in std_logic_vector (4 downto 0);  DATAIN : in 
         std_logic_vector (31 downto 0);  OUT1, OUT2 : out std_logic_vector (31
         downto 0));

end RF_N32_NA5;

architecture SYN_BEHAVIORAL of RF_N32_NA5 is

   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI22_X1
      port( A1, A2, B1, B2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component BUF_X1
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component INV_X2
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X2
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND2_X2
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component DLH_X1
      port( G, D : in std_logic;  Q : out std_logic);
   end component;
   
   signal REG_0_31_port, REG_0_30_port, REG_0_29_port, REG_0_28_port, 
      REG_0_27_port, REG_0_26_port, REG_0_25_port, REG_0_24_port, REG_0_23_port
      , REG_0_22_port, REG_0_21_port, REG_0_20_port, REG_0_19_port, 
      REG_0_18_port, REG_0_17_port, REG_0_16_port, REG_0_15_port, REG_0_14_port
      , REG_0_13_port, REG_0_12_port, REG_0_11_port, REG_0_10_port, 
      REG_0_9_port, REG_0_8_port, REG_0_7_port, REG_0_6_port, REG_0_5_port, 
      REG_0_4_port, REG_0_3_port, REG_0_2_port, REG_0_1_port, REG_0_0_port, 
      REG_1_31_port, REG_1_30_port, REG_1_29_port, REG_1_28_port, REG_1_27_port
      , REG_1_26_port, REG_1_25_port, REG_1_24_port, REG_1_23_port, 
      REG_1_22_port, REG_1_21_port, REG_1_20_port, REG_1_19_port, REG_1_18_port
      , REG_1_17_port, REG_1_16_port, REG_1_15_port, REG_1_14_port, 
      REG_1_13_port, REG_1_12_port, REG_1_11_port, REG_1_10_port, REG_1_9_port,
      REG_1_8_port, REG_1_7_port, REG_1_6_port, REG_1_5_port, REG_1_4_port, 
      REG_1_3_port, REG_1_2_port, REG_1_1_port, REG_1_0_port, REG_2_31_port, 
      REG_2_30_port, REG_2_29_port, REG_2_28_port, REG_2_27_port, REG_2_26_port
      , REG_2_25_port, REG_2_24_port, REG_2_23_port, REG_2_22_port, 
      REG_2_21_port, REG_2_20_port, REG_2_19_port, REG_2_18_port, REG_2_17_port
      , REG_2_16_port, REG_2_15_port, REG_2_14_port, REG_2_13_port, 
      REG_2_12_port, REG_2_11_port, REG_2_10_port, REG_2_9_port, REG_2_8_port, 
      REG_2_7_port, REG_2_6_port, REG_2_5_port, REG_2_4_port, REG_2_3_port, 
      REG_2_2_port, REG_2_1_port, REG_2_0_port, REG_3_31_port, REG_3_30_port, 
      REG_3_29_port, REG_3_28_port, REG_3_27_port, REG_3_26_port, REG_3_25_port
      , REG_3_24_port, REG_3_23_port, REG_3_22_port, REG_3_21_port, 
      REG_3_20_port, REG_3_19_port, REG_3_18_port, REG_3_17_port, REG_3_16_port
      , REG_3_15_port, REG_3_14_port, REG_3_13_port, REG_3_12_port, 
      REG_3_11_port, REG_3_10_port, REG_3_9_port, REG_3_8_port, REG_3_7_port, 
      REG_3_6_port, REG_3_5_port, REG_3_4_port, REG_3_3_port, REG_3_2_port, 
      REG_3_1_port, REG_3_0_port, REG_4_31_port, REG_4_30_port, REG_4_29_port, 
      REG_4_28_port, REG_4_27_port, REG_4_26_port, REG_4_25_port, REG_4_24_port
      , REG_4_23_port, REG_4_22_port, REG_4_21_port, REG_4_20_port, 
      REG_4_19_port, REG_4_18_port, REG_4_17_port, REG_4_16_port, REG_4_15_port
      , REG_4_14_port, REG_4_13_port, REG_4_12_port, REG_4_11_port, 
      REG_4_10_port, REG_4_9_port, REG_4_8_port, REG_4_7_port, REG_4_6_port, 
      REG_4_5_port, REG_4_4_port, REG_4_3_port, REG_4_2_port, REG_4_1_port, 
      REG_4_0_port, REG_5_31_port, REG_5_30_port, REG_5_29_port, REG_5_28_port,
      REG_5_27_port, REG_5_26_port, REG_5_25_port, REG_5_24_port, REG_5_23_port
      , REG_5_22_port, REG_5_21_port, REG_5_20_port, REG_5_19_port, 
      REG_5_18_port, REG_5_17_port, REG_5_16_port, REG_5_15_port, REG_5_14_port
      , REG_5_13_port, REG_5_12_port, REG_5_11_port, REG_5_10_port, 
      REG_5_9_port, REG_5_8_port, REG_5_7_port, REG_5_6_port, REG_5_5_port, 
      REG_5_4_port, REG_5_3_port, REG_5_2_port, REG_5_1_port, REG_5_0_port, 
      REG_6_31_port, REG_6_30_port, REG_6_29_port, REG_6_28_port, REG_6_27_port
      , REG_6_26_port, REG_6_25_port, REG_6_24_port, REG_6_23_port, 
      REG_6_22_port, REG_6_21_port, REG_6_20_port, REG_6_19_port, REG_6_18_port
      , REG_6_17_port, REG_6_16_port, REG_6_15_port, REG_6_14_port, 
      REG_6_13_port, REG_6_12_port, REG_6_11_port, REG_6_10_port, REG_6_9_port,
      REG_6_8_port, REG_6_7_port, REG_6_6_port, REG_6_5_port, REG_6_4_port, 
      REG_6_3_port, REG_6_2_port, REG_6_1_port, REG_6_0_port, REG_7_31_port, 
      REG_7_30_port, REG_7_29_port, REG_7_28_port, REG_7_27_port, REG_7_26_port
      , REG_7_25_port, REG_7_24_port, REG_7_23_port, REG_7_22_port, 
      REG_7_21_port, REG_7_20_port, REG_7_19_port, REG_7_18_port, REG_7_17_port
      , REG_7_16_port, REG_7_15_port, REG_7_14_port, REG_7_13_port, 
      REG_7_12_port, REG_7_11_port, REG_7_10_port, REG_7_9_port, REG_7_8_port, 
      REG_7_7_port, REG_7_6_port, REG_7_5_port, REG_7_4_port, REG_7_3_port, 
      REG_7_2_port, REG_7_1_port, REG_7_0_port, REG_8_31_port, REG_8_30_port, 
      REG_8_29_port, REG_8_28_port, REG_8_27_port, REG_8_26_port, REG_8_25_port
      , REG_8_24_port, REG_8_23_port, REG_8_22_port, REG_8_21_port, 
      REG_8_20_port, REG_8_19_port, REG_8_18_port, REG_8_17_port, REG_8_16_port
      , REG_8_15_port, REG_8_14_port, REG_8_13_port, REG_8_12_port, 
      REG_8_11_port, REG_8_10_port, REG_8_9_port, REG_8_8_port, REG_8_7_port, 
      REG_8_6_port, REG_8_5_port, REG_8_4_port, REG_8_3_port, REG_8_2_port, 
      REG_8_1_port, REG_8_0_port, REG_9_31_port, REG_9_30_port, REG_9_29_port, 
      REG_9_28_port, REG_9_27_port, REG_9_26_port, REG_9_25_port, REG_9_24_port
      , REG_9_23_port, REG_9_22_port, REG_9_21_port, REG_9_20_port, 
      REG_9_19_port, REG_9_18_port, REG_9_17_port, REG_9_16_port, REG_9_15_port
      , REG_9_14_port, REG_9_13_port, REG_9_12_port, REG_9_11_port, 
      REG_9_10_port, REG_9_9_port, REG_9_8_port, REG_9_7_port, REG_9_6_port, 
      REG_9_5_port, REG_9_4_port, REG_9_3_port, REG_9_2_port, REG_9_1_port, 
      REG_9_0_port, REG_10_31_port, REG_10_30_port, REG_10_29_port, 
      REG_10_28_port, REG_10_27_port, REG_10_26_port, REG_10_25_port, 
      REG_10_24_port, REG_10_23_port, REG_10_22_port, REG_10_21_port, 
      REG_10_20_port, REG_10_19_port, REG_10_18_port, REG_10_17_port, 
      REG_10_16_port, REG_10_15_port, REG_10_14_port, REG_10_13_port, 
      REG_10_12_port, REG_10_11_port, REG_10_10_port, REG_10_9_port, 
      REG_10_8_port, REG_10_7_port, REG_10_6_port, REG_10_5_port, REG_10_4_port
      , REG_10_3_port, REG_10_2_port, REG_10_1_port, REG_10_0_port, 
      REG_11_31_port, REG_11_30_port, REG_11_29_port, REG_11_28_port, 
      REG_11_27_port, REG_11_26_port, REG_11_25_port, REG_11_24_port, 
      REG_11_23_port, REG_11_22_port, REG_11_21_port, REG_11_20_port, 
      REG_11_19_port, REG_11_18_port, REG_11_17_port, REG_11_16_port, 
      REG_11_15_port, REG_11_14_port, REG_11_13_port, REG_11_12_port, 
      REG_11_11_port, REG_11_10_port, REG_11_9_port, REG_11_8_port, 
      REG_11_7_port, REG_11_6_port, REG_11_5_port, REG_11_4_port, REG_11_3_port
      , REG_11_2_port, REG_11_1_port, REG_11_0_port, REG_12_31_port, 
      REG_12_30_port, REG_12_29_port, REG_12_28_port, REG_12_27_port, 
      REG_12_26_port, REG_12_25_port, REG_12_24_port, REG_12_23_port, 
      REG_12_22_port, REG_12_21_port, REG_12_20_port, REG_12_19_port, 
      REG_12_18_port, REG_12_17_port, REG_12_16_port, REG_12_15_port, 
      REG_12_14_port, REG_12_13_port, REG_12_12_port, REG_12_11_port, 
      REG_12_10_port, REG_12_9_port, REG_12_8_port, REG_12_7_port, 
      REG_12_6_port, REG_12_5_port, REG_12_4_port, REG_12_3_port, REG_12_2_port
      , REG_12_1_port, REG_12_0_port, REG_13_31_port, REG_13_30_port, 
      REG_13_29_port, REG_13_28_port, REG_13_27_port, REG_13_26_port, 
      REG_13_25_port, REG_13_24_port, REG_13_23_port, REG_13_22_port, 
      REG_13_21_port, REG_13_20_port, REG_13_19_port, REG_13_18_port, 
      REG_13_17_port, REG_13_16_port, REG_13_15_port, REG_13_14_port, 
      REG_13_13_port, REG_13_12_port, REG_13_11_port, REG_13_10_port, 
      REG_13_9_port, REG_13_8_port, REG_13_7_port, REG_13_6_port, REG_13_5_port
      , REG_13_4_port, REG_13_3_port, REG_13_2_port, REG_13_1_port, 
      REG_13_0_port, REG_14_31_port, REG_14_30_port, REG_14_29_port, 
      REG_14_28_port, REG_14_27_port, REG_14_26_port, REG_14_25_port, 
      REG_14_24_port, REG_14_23_port, REG_14_22_port, REG_14_21_port, 
      REG_14_20_port, REG_14_19_port, REG_14_18_port, REG_14_17_port, 
      REG_14_16_port, REG_14_15_port, REG_14_14_port, REG_14_13_port, 
      REG_14_12_port, REG_14_11_port, REG_14_10_port, REG_14_9_port, 
      REG_14_8_port, REG_14_7_port, REG_14_6_port, REG_14_5_port, REG_14_4_port
      , REG_14_3_port, REG_14_2_port, REG_14_1_port, REG_14_0_port, 
      REG_15_31_port, REG_15_30_port, REG_15_29_port, REG_15_28_port, 
      REG_15_27_port, REG_15_26_port, REG_15_25_port, REG_15_24_port, 
      REG_15_23_port, REG_15_22_port, REG_15_21_port, REG_15_20_port, 
      REG_15_19_port, REG_15_18_port, REG_15_17_port, REG_15_16_port, 
      REG_15_15_port, REG_15_14_port, REG_15_13_port, REG_15_12_port, 
      REG_15_11_port, REG_15_10_port, REG_15_9_port, REG_15_8_port, 
      REG_15_7_port, REG_15_6_port, REG_15_5_port, REG_15_4_port, REG_15_3_port
      , REG_15_2_port, REG_15_1_port, REG_15_0_port, REG_16_31_port, 
      REG_16_30_port, REG_16_29_port, REG_16_28_port, REG_16_27_port, 
      REG_16_26_port, REG_16_25_port, REG_16_24_port, REG_16_23_port, 
      REG_16_22_port, REG_16_21_port, REG_16_20_port, REG_16_19_port, 
      REG_16_18_port, REG_16_17_port, REG_16_16_port, REG_16_15_port, 
      REG_16_14_port, REG_16_13_port, REG_16_12_port, REG_16_11_port, 
      REG_16_10_port, REG_16_9_port, REG_16_8_port, REG_16_7_port, 
      REG_16_6_port, REG_16_5_port, REG_16_4_port, REG_16_3_port, REG_16_2_port
      , REG_16_1_port, REG_16_0_port, REG_17_31_port, REG_17_30_port, 
      REG_17_29_port, REG_17_28_port, REG_17_27_port, REG_17_26_port, 
      REG_17_25_port, REG_17_24_port, REG_17_23_port, REG_17_22_port, 
      REG_17_21_port, REG_17_20_port, REG_17_19_port, REG_17_18_port, 
      REG_17_17_port, REG_17_16_port, REG_17_15_port, REG_17_14_port, 
      REG_17_13_port, REG_17_12_port, REG_17_11_port, REG_17_10_port, 
      REG_17_9_port, REG_17_8_port, REG_17_7_port, REG_17_6_port, REG_17_5_port
      , REG_17_4_port, REG_17_3_port, REG_17_2_port, REG_17_1_port, 
      REG_17_0_port, REG_18_31_port, REG_18_30_port, REG_18_29_port, 
      REG_18_28_port, REG_18_27_port, REG_18_26_port, REG_18_25_port, 
      REG_18_24_port, REG_18_23_port, REG_18_22_port, REG_18_21_port, 
      REG_18_20_port, REG_18_19_port, REG_18_18_port, REG_18_17_port, 
      REG_18_16_port, REG_18_15_port, REG_18_14_port, REG_18_13_port, 
      REG_18_12_port, REG_18_11_port, REG_18_10_port, REG_18_9_port, 
      REG_18_8_port, REG_18_7_port, REG_18_6_port, REG_18_5_port, REG_18_4_port
      , REG_18_3_port, REG_18_2_port, REG_18_1_port, REG_18_0_port, 
      REG_19_31_port, REG_19_30_port, REG_19_29_port, REG_19_28_port, 
      REG_19_27_port, REG_19_26_port, REG_19_25_port, REG_19_24_port, 
      REG_19_23_port, REG_19_22_port, REG_19_21_port, REG_19_20_port, 
      REG_19_19_port, REG_19_18_port, REG_19_17_port, REG_19_16_port, 
      REG_19_15_port, REG_19_14_port, REG_19_13_port, REG_19_12_port, 
      REG_19_11_port, REG_19_10_port, REG_19_9_port, REG_19_8_port, 
      REG_19_7_port, REG_19_6_port, REG_19_5_port, REG_19_4_port, REG_19_3_port
      , REG_19_2_port, REG_19_1_port, REG_19_0_port, REG_20_31_port, 
      REG_20_30_port, REG_20_29_port, REG_20_28_port, REG_20_27_port, 
      REG_20_26_port, REG_20_25_port, REG_20_24_port, REG_20_23_port, 
      REG_20_22_port, REG_20_21_port, REG_20_20_port, REG_20_19_port, 
      REG_20_18_port, REG_20_17_port, REG_20_16_port, REG_20_15_port, 
      REG_20_14_port, REG_20_13_port, REG_20_12_port, REG_20_11_port, 
      REG_20_10_port, REG_20_9_port, REG_20_8_port, REG_20_7_port, 
      REG_20_6_port, REG_20_5_port, REG_20_4_port, REG_20_3_port, REG_20_2_port
      , REG_20_1_port, REG_20_0_port, REG_21_31_port, REG_21_30_port, 
      REG_21_29_port, REG_21_28_port, REG_21_27_port, REG_21_26_port, 
      REG_21_25_port, REG_21_24_port, REG_21_23_port, REG_21_22_port, 
      REG_21_21_port, REG_21_20_port, REG_21_19_port, REG_21_18_port, 
      REG_21_17_port, REG_21_16_port, REG_21_15_port, REG_21_14_port, 
      REG_21_13_port, REG_21_12_port, REG_21_11_port, REG_21_10_port, 
      REG_21_9_port, REG_21_8_port, REG_21_7_port, REG_21_6_port, REG_21_5_port
      , REG_21_4_port, REG_21_3_port, REG_21_2_port, REG_21_1_port, 
      REG_21_0_port, REG_22_31_port, REG_22_30_port, REG_22_29_port, 
      REG_22_28_port, REG_22_27_port, REG_22_26_port, REG_22_25_port, 
      REG_22_24_port, REG_22_23_port, REG_22_22_port, REG_22_21_port, 
      REG_22_20_port, REG_22_19_port, REG_22_18_port, REG_22_17_port, 
      REG_22_16_port, REG_22_15_port, REG_22_14_port, REG_22_13_port, 
      REG_22_12_port, REG_22_11_port, REG_22_10_port, REG_22_9_port, 
      REG_22_8_port, REG_22_7_port, REG_22_6_port, REG_22_5_port, REG_22_4_port
      , REG_22_3_port, REG_22_2_port, REG_22_1_port, REG_22_0_port, 
      REG_23_31_port, REG_23_30_port, REG_23_29_port, REG_23_28_port, 
      REG_23_27_port, REG_23_26_port, REG_23_25_port, REG_23_24_port, 
      REG_23_23_port, REG_23_22_port, REG_23_21_port, REG_23_20_port, 
      REG_23_19_port, REG_23_18_port, REG_23_17_port, REG_23_16_port, 
      REG_23_15_port, REG_23_14_port, REG_23_13_port, REG_23_12_port, 
      REG_23_11_port, REG_23_10_port, REG_23_9_port, REG_23_8_port, 
      REG_23_7_port, REG_23_6_port, REG_23_5_port, REG_23_4_port, REG_23_3_port
      , REG_23_2_port, REG_23_1_port, REG_23_0_port, REG_24_31_port, 
      REG_24_30_port, REG_24_29_port, REG_24_28_port, REG_24_27_port, 
      REG_24_26_port, REG_24_25_port, REG_24_24_port, REG_24_23_port, 
      REG_24_22_port, REG_24_21_port, REG_24_20_port, REG_24_19_port, 
      REG_24_18_port, REG_24_17_port, REG_24_16_port, REG_24_15_port, 
      REG_24_14_port, REG_24_13_port, REG_24_12_port, REG_24_11_port, 
      REG_24_10_port, REG_24_9_port, REG_24_8_port, REG_24_7_port, 
      REG_24_6_port, REG_24_5_port, REG_24_4_port, REG_24_3_port, REG_24_2_port
      , REG_24_1_port, REG_24_0_port, REG_25_31_port, REG_25_30_port, 
      REG_25_29_port, REG_25_28_port, REG_25_27_port, REG_25_26_port, 
      REG_25_25_port, REG_25_24_port, REG_25_23_port, REG_25_22_port, 
      REG_25_21_port, REG_25_20_port, REG_25_19_port, REG_25_18_port, 
      REG_25_17_port, REG_25_16_port, REG_25_15_port, REG_25_14_port, 
      REG_25_13_port, REG_25_12_port, REG_25_11_port, REG_25_10_port, 
      REG_25_9_port, REG_25_8_port, REG_25_7_port, REG_25_6_port, REG_25_5_port
      , REG_25_4_port, REG_25_3_port, REG_25_2_port, REG_25_1_port, 
      REG_25_0_port, REG_26_31_port, REG_26_30_port, REG_26_29_port, 
      REG_26_28_port, REG_26_27_port, REG_26_26_port, REG_26_25_port, 
      REG_26_24_port, REG_26_23_port, REG_26_22_port, REG_26_21_port, 
      REG_26_20_port, REG_26_19_port, REG_26_18_port, REG_26_17_port, 
      REG_26_16_port, REG_26_15_port, REG_26_14_port, REG_26_13_port, 
      REG_26_12_port, REG_26_11_port, REG_26_10_port, REG_26_9_port, 
      REG_26_8_port, REG_26_7_port, REG_26_6_port, REG_26_5_port, REG_26_4_port
      , REG_26_3_port, REG_26_2_port, REG_26_1_port, REG_26_0_port, 
      REG_27_31_port, REG_27_30_port, REG_27_29_port, REG_27_28_port, 
      REG_27_27_port, REG_27_26_port, REG_27_25_port, REG_27_24_port, 
      REG_27_23_port, REG_27_22_port, REG_27_21_port, REG_27_20_port, 
      REG_27_19_port, REG_27_18_port, REG_27_17_port, REG_27_16_port, 
      REG_27_15_port, REG_27_14_port, REG_27_13_port, REG_27_12_port, 
      REG_27_11_port, REG_27_10_port, REG_27_9_port, REG_27_8_port, 
      REG_27_7_port, REG_27_6_port, REG_27_5_port, REG_27_4_port, REG_27_3_port
      , REG_27_2_port, REG_27_1_port, REG_27_0_port, REG_28_31_port, 
      REG_28_30_port, REG_28_29_port, REG_28_28_port, REG_28_27_port, 
      REG_28_26_port, REG_28_25_port, REG_28_24_port, REG_28_23_port, 
      REG_28_22_port, REG_28_21_port, REG_28_20_port, REG_28_19_port, 
      REG_28_18_port, REG_28_17_port, REG_28_16_port, REG_28_15_port, 
      REG_28_14_port, REG_28_13_port, REG_28_12_port, REG_28_11_port, 
      REG_28_10_port, REG_28_9_port, REG_28_8_port, REG_28_7_port, 
      REG_28_6_port, REG_28_5_port, REG_28_4_port, REG_28_3_port, REG_28_2_port
      , REG_28_1_port, REG_28_0_port, REG_29_31_port, REG_29_30_port, 
      REG_29_29_port, REG_29_28_port, REG_29_27_port, REG_29_26_port, 
      REG_29_25_port, REG_29_24_port, REG_29_23_port, REG_29_22_port, 
      REG_29_21_port, REG_29_20_port, REG_29_19_port, REG_29_18_port, 
      REG_29_17_port, REG_29_16_port, REG_29_15_port, REG_29_14_port, 
      REG_29_13_port, REG_29_12_port, REG_29_11_port, REG_29_10_port, 
      REG_29_9_port, REG_29_8_port, REG_29_7_port, REG_29_6_port, REG_29_5_port
      , REG_29_4_port, REG_29_3_port, REG_29_2_port, REG_29_1_port, 
      REG_29_0_port, REG_30_31_port, REG_30_30_port, REG_30_29_port, 
      REG_30_28_port, REG_30_27_port, REG_30_26_port, REG_30_25_port, 
      REG_30_24_port, REG_30_23_port, REG_30_22_port, REG_30_21_port, 
      REG_30_20_port, REG_30_19_port, REG_30_18_port, REG_30_17_port, 
      REG_30_16_port, REG_30_15_port, REG_30_14_port, REG_30_13_port, 
      REG_30_12_port, REG_30_11_port, REG_30_10_port, REG_30_9_port, 
      REG_30_8_port, REG_30_7_port, REG_30_6_port, REG_30_5_port, REG_30_4_port
      , REG_30_3_port, REG_30_2_port, REG_30_1_port, REG_30_0_port, 
      REG_31_31_port, REG_31_30_port, REG_31_29_port, REG_31_28_port, 
      REG_31_27_port, REG_31_26_port, REG_31_25_port, REG_31_24_port, 
      REG_31_23_port, REG_31_22_port, REG_31_21_port, REG_31_20_port, 
      REG_31_19_port, REG_31_18_port, REG_31_17_port, REG_31_16_port, 
      REG_31_15_port, REG_31_14_port, REG_31_13_port, REG_31_12_port, 
      REG_31_11_port, REG_31_10_port, REG_31_9_port, REG_31_8_port, 
      REG_31_7_port, REG_31_6_port, REG_31_5_port, REG_31_4_port, REG_31_3_port
      , REG_31_2_port, REG_31_1_port, REG_31_0_port, N221, N222, N223, N224, 
      N225, N226, N227, N228, N229, N230, N231, N232, N233, N234, N235, N236, 
      N237, N238, N239, N240, N241, N242, N243, N244, N245, N246, N247, N248, 
      N249, N250, N251, N252, N253, N254, N287, N288, N289, N290, N291, N292, 
      N293, N294, N295, N296, N297, N298, N299, N300, N301, N302, N303, N304, 
      N305, N306, N307, N308, N309, N310, N311, N312, N313, N314, N315, N316, 
      N317, N318, N319, N320, N321, N322, N323, N324, N325, N326, N327, N328, 
      N329, N330, N331, N332, N333, N334, N335, N336, N337, N338, N339, N340, 
      N341, N342, N343, N344, N345, N346, N347, N348, N350, N351, N352, N353, 
      N354, N355, N356, N357, N358, N359, N360, N361, N362, N363, N364, N365, 
      N366, N367, N368, N369, N370, N371, N372, N373, N374, N375, N376, N377, 
      N378, N379, N380, N381, N382, N383, N384, N385, N386, N387, N388, N389, 
      N390, N391, N392, N393, N394, N395, N396, N397, N398, N399, N400, N401, 
      N402, N403, N404, N405, N406, N407, N408, N409, N410, N411, N412, N413, 
      N414, N415, n3923, n3924, n3925, n3926, n3927, n3928, n3929, n3930, n3931
      , n3932, n3933, n3934, n3935, n3936, n3937, n3938, n3939, n3940, n3941, 
      n3942, n3943, n3944, n3945, n3946, n3947, n3948, n3949, n3950, n3951, 
      n3952, n3953, n3954, n3955, n3956, n3957, n3958, n3959, n3960, n3961, 
      n3962, n3963, n3964, n3965, n3966, n3967, n3968, n3969, n3970, n3971, 
      n3972, n3973, n3974, n3975, n3976, n3977, n3978, n3979, n3980, n3981, 
      n3982, n3983, n3984, n3985, n3986, n3987, n3988, n3989, n3990, n3991, 
      n3992, n3993, n3994, n3995, n3996, n3997, n3998, n3999, n4000, n4001, 
      n4002, n4003, n4004, n4005, n4006, n4007, n4008, n4009, n4010, n4011, 
      n4012, n4013, n4014, n4015, n4016, n4017, n4018, n4019, n4020, n4021, 
      n4022, n4023, n4024, n4025, n4026, n4027, n4028, n4029, n4030, n4031, 
      n4032, n4033, n4034, n4035, n4036, n4037, n4038, n4039, n4040, n4041, 
      n4042, n4043, n4044, n4045, n4046, n4047, n4048, n4049, n4050, n4051, 
      n4052, n4053, n4054, n4055, n4056, n4057, n4058, n4059, n4060, n4061, 
      n4062, n4063, n4064, n4065, n4066, n4067, n4068, n4069, n4070, n4071, 
      n4072, n4073, n4074, n4075, n4076, n4077, n4078, n4079, n4080, n4081, 
      n4082, n4083, n4084, n4085, n4086, n4087, n4088, n4089, n4090, n4091, 
      n4092, n4093, n4094, n4095, n4096, n4097, n4098, n4099, n4100, n4101, 
      n4102, n4103, n4104, n4105, n4106, n4107, n4108, n4109, n4110, n4111, 
      n4112, n4113, n4114, n4115, n4116, n4117, n4118, n4119, n4120, n4121, 
      n4122, n4123, n4124, n4125, n4126, n4127, n4128, n4129, n4130, n4131, 
      n4132, n4133, n4134, n4135, n4136, n4137, n4138, n4139, n4140, n4141, 
      n4142, n4143, n4144, n4145, n4146, n4147, n4148, n4149, n4150, n4151, 
      n4152, n4153, n4154, n4155, n4156, n4157, n4158, n4159, n4160, n4161, 
      n4162, n4163, n4164, n4165, n4166, n4167, n4168, n4169, n4170, n4171, 
      n4172, n4173, n4174, n4175, n4176, n4177, n4178, n4179, n4180, n4181, 
      n4182, n4183, n4184, n4185, n4186, n4187, n4188, n4189, n4190, n4191, 
      n4192, n4193, n4194, n4195, n4196, n4197, n4198, n4199, n4200, n4201, 
      n4202, n4203, n4204, n4205, n4206, n4207, n4208, n4209, n4210, n4211, 
      n4212, n4213, n4214, n4215, n4216, n4217, n4218, n4219, n4220, n4221, 
      n4222, n4223, n4224, n4225, n4226, n4227, n4228, n4229, n4230, n4231, 
      n4232, n4233, n4234, n4235, n4236, n4237, n4238, n4239, n4240, n4241, 
      n4242, n4243, n4244, n4245, n4246, n4247, n4248, n4249, n4250, n4251, 
      n4252, n4253, n4254, n4255, n4256, n4257, n4258, n4259, n4260, n4261, 
      n4262, n4263, n4264, n4265, n4266, n4267, n4268, n4269, n4270, n4271, 
      n4272, n4273, n4274, n4275, n4276, n4277, n4278, n4279, n4280, n4281, 
      n4282, n4283, n4284, n4285, n4286, n4287, n4288, n4289, n4290, n4291, 
      n4292, n4293, n4294, n4295, n4296, n4297, n4298, n4299, n4300, n4301, 
      n4302, n4303, n4304, n4305, n4306, n4307, n4308, n4309, n4310, n4311, 
      n4312, n4313, n4314, n4315, n4316, n4317, n4318, n4319, n4320, n4321, 
      n4322, n4323, n4324, n4325, n4326, n4327, n4328, n4329, n4330, n4331, 
      n4332, n4333, n4334, n4335, n4336, n4337, n4338, n4339, n4340, n4341, 
      n4342, n4343, n4344, n4345, n4346, n4347, n4348, n4349, n4350, n4351, 
      n4352, n4353, n4354, n4355, n4356, n4357, n4358, n4359, n4360, n4361, 
      n4362, n4363, n4364, n4365, n4366, n4367, n4368, n4369, n4370, n4371, 
      n4372, n4373, n4374, n4375, n4376, n4377, n4378, n4379, n4380, n4381, 
      n4382, n4383, n4384, n4385, n4386, n4387, n4388, n4389, n4390, n4391, 
      n4392, n4393, n4394, n4395, n4396, n4397, n4398, n4399, n4400, n4401, 
      n4402, n4403, n4404, n4405, n4406, n4407, n4408, n4409, n4410, n4411, 
      n4412, n4413, n4414, n4415, n4416, n4417, n4418, n4419, n4420, n4421, 
      n4422, n4423, n4424, n4425, n4426, n4427, n4428, n4429, n4430, n4431, 
      n4432, n4433, n4434, n4435, n4436, n4437, n4438, n4439, n4440, n4441, 
      n4442, n4443, n4444, n4445, n4446, n4447, n4448, n4449, n4450, n4451, 
      n4452, n4453, n4454, n4455, n4456, n4457, n4458, n4459, n4460, n4461, 
      n4462, n4463, n4464, n4465, n4466, n4467, n4468, n4469, n4470, n4471, 
      n4472, n4473, n4474, n4475, n4476, n4477, n4478, n4479, n4480, n4481, 
      n4482, n4483, n4484, n4485, n4486, n4487, n4488, n4489, n4490, n4491, 
      n4492, n4493, n4494, n4495, n4496, n4497, n4498, n4499, n4500, n4501, 
      n4502, n4503, n4504, n4505, n4506, n4507, n4508, n4509, n4510, n4511, 
      n4512, n4513, n4514, n4515, n4516, n4517, n4518, n4519, n4520, n4521, 
      n4522, n4523, n4524, n4525, n4526, n4527, n4528, n4529, n4530, n4531, 
      n4532, n4533, n4534, n4535, n4536, n4537, n4538, n4539, n4540, n4541, 
      n4542, n4543, n4544, n4545, n4546, n4547, n4548, n4549, n4550, n4551, 
      n4552, n4553, n4554, n4555, n4556, n4557, n4558, n4559, n4560, n4561, 
      n4562, n4563, n4564, n4565, n4566, n4567, n4568, n4569, n4570, n4571, 
      n4572, n4573, n4574, n4575, n4576, n4577, n4578, n4579, n4580, n4581, 
      n4582, n4583, n4584, n4585, n4586, n4587, n4588, n4589, n4590, n4591, 
      n4592, n4593, n4594, n4595, n4596, n4597, n4598, n4599, n4600, n4601, 
      n4602, n4603, n4604, n4605, n4606, n4607, n4608, n4609, n4610, n4611, 
      n4612, n4613, n4614, n4615, n4616, n4617, n4618, n4619, n4620, n4621, 
      n4622, n4623, n4624, n4625, n4626, n4627, n4628, n4629, n4630, n4631, 
      n4632, n4633, n4634, n4635, n4636, n4637, n4638, n4639, n4640, n4641, 
      n4642, n4643, n4644, n4645, n4646, n4647, n4648, n4649, n4650, n4651, 
      n4652, n4653, n4654, n4655, n4656, n4657, n4658, n4659, n4660, n4661, 
      n4662, n4663, n4664, n4665, n4666, n4667, n4668, n4669, n4670, n4671, 
      n4672, n4673, n4674, n4675, n4676, n4677, n4678, n4679, n4680, n4681, 
      n4682, n4683, n4684, n4685, n4686, n4687, n4688, n4689, n4690, n4691, 
      n4692, n4693, n4694, n4695, n4696, n4697, n4698, n4699, n4700, n4701, 
      n4702, n4703, n4704, n4705, n4706, n4707, n4708, n4709, n4710, n4711, 
      n4712, n4713, n4714, n4715, n4716, n4717, n4718, n4719, n4720, n4721, 
      n4722, n4723, n4724, n4725, n4726, n4727, n4728, n4729, n4730, n4731, 
      n4732, n4733, n4734, n4735, n4736, n4737, n4738, n4739, n4740, n4741, 
      n4742, n4743, n4744, n4745, n4746, n4747, n4748, n4749, n4750, n4751, 
      n4752, n4753, n4754, n4755, n4756, n4757, n4758, n4759, n4760, n4761, 
      n4762, n4763, n4764, n4765, n4766, n4767, n4768, n4769, n4770, n4771, 
      n4772, n4773, n4774, n4775, n4776, n4777, n4778, n4779, n4780, n4781, 
      n4782, n4783, n4784, n4785, n4786, n4787, n4788, n4789, n4790, n4791, 
      n4792, n4793, n4794, n4795, n4796, n4797, n4798, n4799, n4800, n4801, 
      n4802, n4803, n4804, n4805, n4806, n4807, n4808, n4809, n4810, n4811, 
      n4812, n4813, n4814, n4815, n4816, n4817, n4818, n4819, n4820, n4821, 
      n4822, n4823, n4824, n4825, n4826, n4827, n4828, n4829, n4830, n4831, 
      n4832, n4833, n4834, n4835, n4836, n4837, n4838, n4839, n4840, n4841, 
      n4842, n4843, n4844, n4845, n4846, n4847, n4848, n4849, n4850, n4851, 
      n4852, n4853, n4854, n4855, n4856, n4857, n4858, n4859, n4860, n4861, 
      n4862, n4863, n4864, n4865, n4866, n4867, n4868, n4869, n4870, n4871, 
      n4872, n4873, n4874, n4875, n4876, n4877, n4878, n4879, n4880, n4881, 
      n4882, n4883, n4884, n4885, n4886, n4887, n4888, n4889, n4890, n4891, 
      n4892, n4893, n4894, n4895, n4896, n4897, n4898, n4899, n4900, n4901, 
      n4902, n4903, n4904, n4905, n4906, n4907, n4908, n4909, n4910, n4911, 
      n4912, n4913, n4914, n4915, n4916, n4917, n4918, n4919, n4920, n4921, 
      n4922, n4923, n4924, n4925, n4926, n4927, n4928, n4929, n4930, n4931, 
      n4932, n4933, n4934, n4935, n4936, n4937, n4938, n4939, n4940, n4941, 
      n4942, n4943, n4944, n4945, n4946, n4947, n4948, n4949, n4950, n4951, 
      n4952, n4953, n4954, n4955, n4956, n4957, n4958, n4959, n4960, n4961, 
      n4962, n4963, n4964, n4965, n4966, n4967, n4968, n4969, n4970, n4971, 
      n4972, n4973, n4974, n4975, n4976, n4977, n4978, n4979, n4980, n4981, 
      n4982, n4983, n4984, n4985, n4986, n4987, n4988, n4989, n4990, n4991, 
      n4992, n4993, n4994, n4995, n4996, n4997, n4998, n4999, n5000, n5001, 
      n5002, n5003, n5004, n5005, n5006, n5007, n5008, n5009, n5010, n5011, 
      n5012, n5013, n5014, n5015, n5016, n5017, n5018, n5019, n5020, n5021, 
      n5022, n5023, n5024, n5025, n5026, n5027, n5028, n5029, n5030, n5031, 
      n5032, n5033, n5034, n5035, n5036, n5037, n5038, n5039, n5040, n5041, 
      n5042, n5043, n5044, n5045, n5046, n5047, n5048, n5049, n5050, n5051, 
      n5052, n5053, n5054, n5055, n5056, n5057, n5058, n5059, n5060, n5061, 
      n5062, n5063, n5064, n5065, n5066, n5067, n5068, n5069, n5070, n5071, 
      n5072, n5073, n5074, n5075, n5076, n5077, n5078, n5079, n5080, n5081, 
      n5082, n5083, n5084, n5085, n5086, n5087, n5088, n5089, n5090, n5091, 
      n5092, n5093, n5094, n5095, n5096, n5097, n5098, n5099, n5100, n5101, 
      n5102, n5103, n5104, n5105, n5106, n5107, n5108, n5109, n5110, n5111, 
      n5112, n5113, n5114, n5115, n5116, n5117, n5118, n5119, n5120, n5121, 
      n5122, n5123, n5124, n5125, n5126, n5127, n5128, n5129, n5130, n5131, 
      n5132, n5133, n5134, n5135, n5136, n5137, n5138, n5139, n5140, n5141, 
      n5142, n5143, n5144, n5145, n5146, n5147, n5148, n5149, n5150, n5151, 
      n5152, n5153, n5154, n5155, n5156, n5157, n5158, n5159, n5160, n5161, 
      n5162, n5163, n5164, n5165, n5166, n5167, n5168, n5169, n5170, n5171, 
      n5172, n5173, n5174, n5175, n5176, n5177, n5178, n5179, n5180, n5181, 
      n5182, n5183, n5184, n5185, n5186, n5187, n5188, n5189, n5190, n5191, 
      n5192, n5193, n5194, n5195, n5196, n5197, n5198, n5199, n5200, n5201, 
      n5202, n5203, n5204, n5205, n5206, n5207, n5208, n5209, n5210, n5211, 
      n5212, n5213, n5214, n5215, n5216, n5217, n5218, n5219, n5220, n5221, 
      n5222, n5223, n5224, n5225, n5226, n5227, n5228, n5229, n5230, n5231, 
      n5232, n5233, n5234, n5235, n5236, n5237, n5238, n5239, n5240, n5241, 
      n5242, n5243, n5244, n5245, n5246, n5247, n5248, n5249, n5250, n5251, 
      n5252, n5253, n5254, n5255, n5256, n5257, n5258, n5259, n5260, n5261, 
      n5262, n5263, n5264, n5265, n5266, n5267, n5268, n5269, n5270, n5271, 
      n5272, n5273, n5274, n5275, n5276, n5277, n5278, n5279, n5280, n5281, 
      n5282, n5283, n5284, n5285, n5286, n5287, n5288, n5289, n5290, n5291, 
      n5292, n5293, n5294, n5295, n5296, n5297, n5298, n5299, n5300, n5301, 
      n5302, n5303, n5304, n5305, n5306, n5307, n5308, n5309, n5310, n5311, 
      n5312, n5313, n5314, n5315, n5316, n5317, n5318, n5319, n5320, n5321, 
      n5322, n5323, n5324, n5325, n5326, n5327, n5328, n5329, n5330, n5331, 
      n5332, n5333, n5334, n5335, n5336, n5337, n5338, n5339, n5340, n5341, 
      n5342, n5343, n5344, n5345, n5346, n5347, n5348, n5349, n5350, n5351, 
      n5352, n5353, n5354, n5355, n5356, n5357, n5358, n5359, n5360, n5361, 
      n5362, n5363, n5364, n5365, n5366, n5367, n5368, n5369, n5370, n5371, 
      n5372, n5373, n5374, n5375, n5376, n5377, n5378, n5379, n5380, n5381, 
      n5382, n5383, n5384, n5385, n5386, n5387, n5388, n5389, n5390, n5391, 
      n5392, n5393, n5394, n5395, n5396, n5397, n5398, n5399, n5400, n5401, 
      n5402, n5403, n5404, n5405, n5406, n5407, n5408, n5409, n5410, n5411, 
      n5412, n5413, n5414, n5415, n5416, n5417, n5418, n5419, n5420, n5421, 
      n5422, n5423, n5424, n5425, n5426, n5427, n5428, n5429, n5430, n5431, 
      n5432, n5433, n5434, n5435, n5436, n5437, n5438, n5439, n5440, n5441, 
      n5442, n5443, n5444, n5445, n5446, n5447, n5448, n5449, n5450, n5451, 
      n5452, n5453, n5454, n5455, n5456, n5457, n5458, n5459, n5460, n5461, 
      n5462, n5463, n5464, n5465, n5466, n5467, n5468, n5469, n5470, n5471, 
      n5472, n5473, n5474, n5475, n5476, n5477, n5478, n5479, n5480, n5481, 
      n5482, n5483, n5484, n5485, n5486, n5487, n5488, n5489, n5490, n5491, 
      n5492, n5493, n5494, n5495, n5496, n5497, n5498, n5499, n5500, n5501, 
      n5502, n5503, n5504, n5505, n5506, n5507, n5508, n5509, n5510, n5511, 
      n5512, n5513, n5514, n5515, n5516, n5517, n5518, n5519, n5520, n5521, 
      n5522, n5523, n5524, n5525, n5526, n5527, n5528, n5529, n5530, n5531, 
      n5532, n5533, n5534, n5535, n5536, n5537, n5538, n5539, n5540, n5541, 
      n5542, n5543, n5544, n5545, n5546, n5547, n5548, n5549, n5550, n5551, 
      n5552, n5553, n5554, n5555, n5556, n5557, n5558, n5559, n5560, n5561, 
      n5562, n5563, n5564, n5565, n5566, n5567, n5568, n5569, n5570, n5571, 
      n5572, n5573, n5574, n5575, n5576, n5577, n5578, n5579, n5580, n5581, 
      n5582, n5583, n5584, n5585, n5586, n5587, n5588, n5589, n5590, n5591, 
      n5592, n5593, n5594, n5595, n5596, n5597, n5598, n5599, n5600, n5601, 
      n5602, n5603, n5604, n5605, n5606, n5607, n5608, n5609, n5610, n5611, 
      n5612, n5613, n5614, n5615, n5616, n5617, n5618, n5619, n5620, n5621, 
      n5622, n5623, n5624, n5625, n5626, n5627, n5628, n5629, n5630, n5631, 
      n5632, n5633, n5634, n5635, n5636, n5637, n5638, n5639, n5640, n5641, 
      n5642, n5643, n5644, n5645, n5646, n5647, n5648, n5649, n5650, n5651, 
      n5652, n5653, n5654, n5655, n5656, n5657, n5658, n5659, n5660, n5661, 
      n5662, n5663, n5664, n5665, n5666, n5667, n5668, n5669, n5670, n5671, 
      n5672, n5673, n5674, n5675, n5676, n5677, n5678, n5679, n5680, n5681, 
      n5682, n5683, n5684, n5685, n5686, n5687, n5688, n5689, n5690, n5691, 
      n5692, n5693, n5694, n5695, n5696, n5697, n5698, n5699, n5700, n5701, 
      n5702, n5703, n5704, n5705, n5706, n5707, n5708, n5709, n5710, n5711, 
      n5712, n5713, n5714, n5715, n5716, n5717, n5718, n5719, n5720, n5721, 
      n5722, n5723, n5724, n5725, n5726, n5727, n5728, n5729, n5730, n5731, 
      n5732, n5733, n5734, n5735, n5736, n5737, n5738, n5739, n5740, n5741, 
      n5742, n5743, n5744, n5745, n5746, n5747, n5748, n5749, n5750, n5751, 
      n5752, n5753, n5754, n5755, n5756, n5757, n5758, n5759, n5760, n5761, 
      n5762, n5763, n5764, n5765, n5766, n5767, n5768, n5769, n5770, n5771, 
      n5772, n5773, n5774, n5775, n5776, n5777, n5778, n5779, n5780, n5781, 
      n5782, n5783, n5784, n5785, n5786, n5787, n5788, n5789, n5790, n5791, 
      n5792, n5793, n5794, n5795, n5796, n5797, n5798, n5799, n5800, n5801, 
      n5802, n5803, n5804, n5805, n5806, n5807, n5808, n5809, n5810, n5811, 
      n5812, n5813, n5814, n5815, n5816, n5817, n5818, n5819, n5820, n5821, 
      n5822, n5823, n5824, n5825, n5826, n5827, n5828, n5829, n5830, n5831, 
      n5832, n5833, n5834, n5835, n5836, n5837, n5838, n5839, n5840, n5841, 
      n5842, n5843, n5844, n5845, n5846, n5847, n5848, n5849, n5850, n5851, 
      n5852, n5853, n5854, n5855, n5856, n5857, n5858, n5859, n5860, n5861, 
      n5862, n5863, n5864, n5865, n5866, n5867, n5868, n5869, n5870, n5871, 
      n5872, n5873, n5874, n5875, n5876, n5877, n5878, n5879, n5880, n5881, 
      n5882, n5883, n5884, n5885, n5886, n5887, n5888, n5889, n5890, n5891, 
      n5892, n5893, n5894, n5895, n5896, n5897, n5898, n5899, n5900, n5901, 
      n5902, n5903, n5904, n5905, n5906, n5907, n5908, n5909, n5910, n5911, 
      n5912, n5913, n5914, n5915, n5916, n5917, n5918, n5919, n5920, n5921, 
      n5922, n5923, n5924, n5925, n5926, n5927, n5928, n5929, n5930, n5931, 
      n5932, n5933, n5934, n5935, n5936, n5937, n5938, n5939, n5940, n5941, 
      n5942 : std_logic;

begin
   
   REG_reg_0_31_inst : DLH_X1 port map( G => n3950, D => N348, Q => 
                           REG_0_31_port);
   REG_reg_0_30_inst : DLH_X1 port map( G => n3950, D => N347, Q => 
                           REG_0_30_port);
   REG_reg_0_29_inst : DLH_X1 port map( G => n3950, D => N346, Q => 
                           REG_0_29_port);
   REG_reg_0_28_inst : DLH_X1 port map( G => n3950, D => N345, Q => 
                           REG_0_28_port);
   REG_reg_0_27_inst : DLH_X1 port map( G => n3950, D => N344, Q => 
                           REG_0_27_port);
   REG_reg_0_26_inst : DLH_X1 port map( G => n3950, D => N343, Q => 
                           REG_0_26_port);
   REG_reg_0_25_inst : DLH_X1 port map( G => n3950, D => N342, Q => 
                           REG_0_25_port);
   REG_reg_0_24_inst : DLH_X1 port map( G => n3950, D => N341, Q => 
                           REG_0_24_port);
   REG_reg_0_23_inst : DLH_X1 port map( G => n3950, D => N340, Q => 
                           REG_0_23_port);
   REG_reg_0_22_inst : DLH_X1 port map( G => n3950, D => N339, Q => 
                           REG_0_22_port);
   REG_reg_0_21_inst : DLH_X1 port map( G => n3950, D => N338, Q => 
                           REG_0_21_port);
   REG_reg_0_20_inst : DLH_X1 port map( G => n3950, D => N337, Q => 
                           REG_0_20_port);
   REG_reg_0_19_inst : DLH_X1 port map( G => n3950, D => N336, Q => 
                           REG_0_19_port);
   REG_reg_0_18_inst : DLH_X1 port map( G => n3950, D => N335, Q => 
                           REG_0_18_port);
   REG_reg_0_17_inst : DLH_X1 port map( G => n3950, D => N334, Q => 
                           REG_0_17_port);
   REG_reg_0_16_inst : DLH_X1 port map( G => n3950, D => N333, Q => 
                           REG_0_16_port);
   REG_reg_0_15_inst : DLH_X1 port map( G => n3950, D => N332, Q => 
                           REG_0_15_port);
   REG_reg_0_14_inst : DLH_X1 port map( G => n3950, D => N331, Q => 
                           REG_0_14_port);
   REG_reg_0_13_inst : DLH_X1 port map( G => n3950, D => N330, Q => 
                           REG_0_13_port);
   REG_reg_0_12_inst : DLH_X1 port map( G => n3950, D => N329, Q => 
                           REG_0_12_port);
   REG_reg_0_11_inst : DLH_X1 port map( G => n3950, D => N328, Q => 
                           REG_0_11_port);
   REG_reg_0_10_inst : DLH_X1 port map( G => n3950, D => N327, Q => 
                           REG_0_10_port);
   REG_reg_0_9_inst : DLH_X1 port map( G => n3950, D => N326, Q => REG_0_9_port
                           );
   REG_reg_0_8_inst : DLH_X1 port map( G => n3950, D => N325, Q => REG_0_8_port
                           );
   REG_reg_0_7_inst : DLH_X1 port map( G => n3950, D => N324, Q => REG_0_7_port
                           );
   REG_reg_0_6_inst : DLH_X1 port map( G => n3950, D => N323, Q => REG_0_6_port
                           );
   REG_reg_0_5_inst : DLH_X1 port map( G => n3950, D => N322, Q => REG_0_5_port
                           );
   REG_reg_0_4_inst : DLH_X1 port map( G => n3950, D => N321, Q => REG_0_4_port
                           );
   REG_reg_0_3_inst : DLH_X1 port map( G => n3950, D => N320, Q => REG_0_3_port
                           );
   REG_reg_0_2_inst : DLH_X1 port map( G => n3950, D => N319, Q => REG_0_2_port
                           );
   REG_reg_0_1_inst : DLH_X1 port map( G => n3950, D => N318, Q => REG_0_1_port
                           );
   REG_reg_0_0_inst : DLH_X1 port map( G => n3950, D => N317, Q => REG_0_0_port
                           );
   REG_reg_1_31_inst : DLH_X1 port map( G => n3952, D => n5942, Q => 
                           REG_1_31_port);
   REG_reg_1_30_inst : DLH_X1 port map( G => n3952, D => n5941, Q => 
                           REG_1_30_port);
   REG_reg_1_29_inst : DLH_X1 port map( G => n3952, D => n5940, Q => 
                           REG_1_29_port);
   REG_reg_1_28_inst : DLH_X1 port map( G => n3952, D => n5939, Q => 
                           REG_1_28_port);
   REG_reg_1_27_inst : DLH_X1 port map( G => n3952, D => n5938, Q => 
                           REG_1_27_port);
   REG_reg_1_26_inst : DLH_X1 port map( G => n3952, D => n5937, Q => 
                           REG_1_26_port);
   REG_reg_1_25_inst : DLH_X1 port map( G => n3952, D => n5936, Q => 
                           REG_1_25_port);
   REG_reg_1_24_inst : DLH_X1 port map( G => n3952, D => n5935, Q => 
                           REG_1_24_port);
   REG_reg_1_23_inst : DLH_X1 port map( G => n3952, D => n5934, Q => 
                           REG_1_23_port);
   REG_reg_1_22_inst : DLH_X1 port map( G => n3952, D => n5933, Q => 
                           REG_1_22_port);
   REG_reg_1_21_inst : DLH_X1 port map( G => n3952, D => n5932, Q => 
                           REG_1_21_port);
   REG_reg_1_20_inst : DLH_X1 port map( G => n3952, D => n5931, Q => 
                           REG_1_20_port);
   REG_reg_1_19_inst : DLH_X1 port map( G => n3952, D => n5930, Q => 
                           REG_1_19_port);
   REG_reg_1_18_inst : DLH_X1 port map( G => n3952, D => n5929, Q => 
                           REG_1_18_port);
   REG_reg_1_17_inst : DLH_X1 port map( G => n3952, D => n5928, Q => 
                           REG_1_17_port);
   REG_reg_1_16_inst : DLH_X1 port map( G => n3952, D => n5927, Q => 
                           REG_1_16_port);
   REG_reg_1_15_inst : DLH_X1 port map( G => n3952, D => n5926, Q => 
                           REG_1_15_port);
   REG_reg_1_14_inst : DLH_X1 port map( G => n3952, D => n5925, Q => 
                           REG_1_14_port);
   REG_reg_1_13_inst : DLH_X1 port map( G => n3952, D => n5924, Q => 
                           REG_1_13_port);
   REG_reg_1_12_inst : DLH_X1 port map( G => n3952, D => n5923, Q => 
                           REG_1_12_port);
   REG_reg_1_11_inst : DLH_X1 port map( G => n3952, D => n5922, Q => 
                           REG_1_11_port);
   REG_reg_1_10_inst : DLH_X1 port map( G => n3952, D => n5921, Q => 
                           REG_1_10_port);
   REG_reg_1_9_inst : DLH_X1 port map( G => n3952, D => n5920, Q => 
                           REG_1_9_port);
   REG_reg_1_8_inst : DLH_X1 port map( G => n3952, D => n5919, Q => 
                           REG_1_8_port);
   REG_reg_1_7_inst : DLH_X1 port map( G => n3952, D => n5918, Q => 
                           REG_1_7_port);
   REG_reg_1_6_inst : DLH_X1 port map( G => n3952, D => n5917, Q => 
                           REG_1_6_port);
   REG_reg_1_5_inst : DLH_X1 port map( G => n3952, D => n5916, Q => 
                           REG_1_5_port);
   REG_reg_1_4_inst : DLH_X1 port map( G => n3952, D => n5915, Q => 
                           REG_1_4_port);
   REG_reg_1_3_inst : DLH_X1 port map( G => n3952, D => n5914, Q => 
                           REG_1_3_port);
   REG_reg_1_2_inst : DLH_X1 port map( G => n3952, D => n5913, Q => 
                           REG_1_2_port);
   REG_reg_1_1_inst : DLH_X1 port map( G => n3952, D => n5912, Q => 
                           REG_1_1_port);
   REG_reg_1_0_inst : DLH_X1 port map( G => n3952, D => n5911, Q => 
                           REG_1_0_port);
   REG_reg_2_31_inst : DLH_X1 port map( G => n3924, D => n5942, Q => 
                           REG_2_31_port);
   REG_reg_2_30_inst : DLH_X1 port map( G => n3924, D => n5941, Q => 
                           REG_2_30_port);
   REG_reg_2_29_inst : DLH_X1 port map( G => n3924, D => n5940, Q => 
                           REG_2_29_port);
   REG_reg_2_28_inst : DLH_X1 port map( G => n3924, D => n5939, Q => 
                           REG_2_28_port);
   REG_reg_2_27_inst : DLH_X1 port map( G => n3924, D => n5938, Q => 
                           REG_2_27_port);
   REG_reg_2_26_inst : DLH_X1 port map( G => n3924, D => n5937, Q => 
                           REG_2_26_port);
   REG_reg_2_25_inst : DLH_X1 port map( G => n3924, D => n5936, Q => 
                           REG_2_25_port);
   REG_reg_2_24_inst : DLH_X1 port map( G => n3924, D => n5935, Q => 
                           REG_2_24_port);
   REG_reg_2_23_inst : DLH_X1 port map( G => n3924, D => n5934, Q => 
                           REG_2_23_port);
   REG_reg_2_22_inst : DLH_X1 port map( G => n3924, D => n5933, Q => 
                           REG_2_22_port);
   REG_reg_2_21_inst : DLH_X1 port map( G => n3924, D => n5932, Q => 
                           REG_2_21_port);
   REG_reg_2_20_inst : DLH_X1 port map( G => n3924, D => n5931, Q => 
                           REG_2_20_port);
   REG_reg_2_19_inst : DLH_X1 port map( G => n3924, D => n5930, Q => 
                           REG_2_19_port);
   REG_reg_2_18_inst : DLH_X1 port map( G => n3924, D => n5929, Q => 
                           REG_2_18_port);
   REG_reg_2_17_inst : DLH_X1 port map( G => n3924, D => n5928, Q => 
                           REG_2_17_port);
   REG_reg_2_16_inst : DLH_X1 port map( G => n3924, D => n5927, Q => 
                           REG_2_16_port);
   REG_reg_2_15_inst : DLH_X1 port map( G => n3924, D => n5926, Q => 
                           REG_2_15_port);
   REG_reg_2_14_inst : DLH_X1 port map( G => n3924, D => n5925, Q => 
                           REG_2_14_port);
   REG_reg_2_13_inst : DLH_X1 port map( G => n3924, D => n5924, Q => 
                           REG_2_13_port);
   REG_reg_2_12_inst : DLH_X1 port map( G => n3924, D => n5923, Q => 
                           REG_2_12_port);
   REG_reg_2_11_inst : DLH_X1 port map( G => n3924, D => n5922, Q => 
                           REG_2_11_port);
   REG_reg_2_10_inst : DLH_X1 port map( G => n3924, D => n5921, Q => 
                           REG_2_10_port);
   REG_reg_2_9_inst : DLH_X1 port map( G => n3924, D => n5920, Q => 
                           REG_2_9_port);
   REG_reg_2_8_inst : DLH_X1 port map( G => n3924, D => n5919, Q => 
                           REG_2_8_port);
   REG_reg_2_7_inst : DLH_X1 port map( G => n3924, D => n5918, Q => 
                           REG_2_7_port);
   REG_reg_2_6_inst : DLH_X1 port map( G => n3924, D => n5917, Q => 
                           REG_2_6_port);
   REG_reg_2_5_inst : DLH_X1 port map( G => n3924, D => n5916, Q => 
                           REG_2_5_port);
   REG_reg_2_4_inst : DLH_X1 port map( G => n3924, D => n5915, Q => 
                           REG_2_4_port);
   REG_reg_2_3_inst : DLH_X1 port map( G => n3924, D => n5914, Q => 
                           REG_2_3_port);
   REG_reg_2_2_inst : DLH_X1 port map( G => n3924, D => n5913, Q => 
                           REG_2_2_port);
   REG_reg_2_1_inst : DLH_X1 port map( G => n3924, D => n5912, Q => 
                           REG_2_1_port);
   REG_reg_2_0_inst : DLH_X1 port map( G => n3924, D => n5911, Q => 
                           REG_2_0_port);
   REG_reg_3_31_inst : DLH_X1 port map( G => n3926, D => n5942, Q => 
                           REG_3_31_port);
   REG_reg_3_30_inst : DLH_X1 port map( G => n3926, D => n5941, Q => 
                           REG_3_30_port);
   REG_reg_3_29_inst : DLH_X1 port map( G => n3926, D => n5940, Q => 
                           REG_3_29_port);
   REG_reg_3_28_inst : DLH_X1 port map( G => n3926, D => n5939, Q => 
                           REG_3_28_port);
   REG_reg_3_27_inst : DLH_X1 port map( G => n3926, D => n5938, Q => 
                           REG_3_27_port);
   REG_reg_3_26_inst : DLH_X1 port map( G => n3926, D => n5937, Q => 
                           REG_3_26_port);
   REG_reg_3_25_inst : DLH_X1 port map( G => n3926, D => n5936, Q => 
                           REG_3_25_port);
   REG_reg_3_24_inst : DLH_X1 port map( G => n3926, D => n5935, Q => 
                           REG_3_24_port);
   REG_reg_3_23_inst : DLH_X1 port map( G => n3926, D => n5934, Q => 
                           REG_3_23_port);
   REG_reg_3_22_inst : DLH_X1 port map( G => n3926, D => n5933, Q => 
                           REG_3_22_port);
   REG_reg_3_21_inst : DLH_X1 port map( G => n3926, D => n5932, Q => 
                           REG_3_21_port);
   REG_reg_3_20_inst : DLH_X1 port map( G => n3926, D => n5931, Q => 
                           REG_3_20_port);
   REG_reg_3_19_inst : DLH_X1 port map( G => n3926, D => n5930, Q => 
                           REG_3_19_port);
   REG_reg_3_18_inst : DLH_X1 port map( G => n3926, D => n5929, Q => 
                           REG_3_18_port);
   REG_reg_3_17_inst : DLH_X1 port map( G => n3926, D => n5928, Q => 
                           REG_3_17_port);
   REG_reg_3_16_inst : DLH_X1 port map( G => n3926, D => n5927, Q => 
                           REG_3_16_port);
   REG_reg_3_15_inst : DLH_X1 port map( G => n3926, D => n5926, Q => 
                           REG_3_15_port);
   REG_reg_3_14_inst : DLH_X1 port map( G => n3926, D => n5925, Q => 
                           REG_3_14_port);
   REG_reg_3_13_inst : DLH_X1 port map( G => n3926, D => n5924, Q => 
                           REG_3_13_port);
   REG_reg_3_12_inst : DLH_X1 port map( G => n3926, D => n5923, Q => 
                           REG_3_12_port);
   REG_reg_3_11_inst : DLH_X1 port map( G => n3926, D => n5922, Q => 
                           REG_3_11_port);
   REG_reg_3_10_inst : DLH_X1 port map( G => n3926, D => n5921, Q => 
                           REG_3_10_port);
   REG_reg_3_9_inst : DLH_X1 port map( G => n3926, D => n5920, Q => 
                           REG_3_9_port);
   REG_reg_3_8_inst : DLH_X1 port map( G => n3926, D => n5919, Q => 
                           REG_3_8_port);
   REG_reg_3_7_inst : DLH_X1 port map( G => n3926, D => n5918, Q => 
                           REG_3_7_port);
   REG_reg_3_6_inst : DLH_X1 port map( G => n3926, D => n5917, Q => 
                           REG_3_6_port);
   REG_reg_3_5_inst : DLH_X1 port map( G => n3926, D => n5916, Q => 
                           REG_3_5_port);
   REG_reg_3_4_inst : DLH_X1 port map( G => n3926, D => n5915, Q => 
                           REG_3_4_port);
   REG_reg_3_3_inst : DLH_X1 port map( G => n3926, D => n5914, Q => 
                           REG_3_3_port);
   REG_reg_3_2_inst : DLH_X1 port map( G => n3926, D => n5913, Q => 
                           REG_3_2_port);
   REG_reg_3_1_inst : DLH_X1 port map( G => n3926, D => n5912, Q => 
                           REG_3_1_port);
   REG_reg_3_0_inst : DLH_X1 port map( G => n3926, D => n5911, Q => 
                           REG_3_0_port);
   REG_reg_4_31_inst : DLH_X1 port map( G => n3928, D => n5942, Q => 
                           REG_4_31_port);
   REG_reg_4_30_inst : DLH_X1 port map( G => n3928, D => n5941, Q => 
                           REG_4_30_port);
   REG_reg_4_29_inst : DLH_X1 port map( G => n3928, D => n5940, Q => 
                           REG_4_29_port);
   REG_reg_4_28_inst : DLH_X1 port map( G => n3928, D => n5939, Q => 
                           REG_4_28_port);
   REG_reg_4_27_inst : DLH_X1 port map( G => n3928, D => n5938, Q => 
                           REG_4_27_port);
   REG_reg_4_26_inst : DLH_X1 port map( G => n3928, D => n5937, Q => 
                           REG_4_26_port);
   REG_reg_4_25_inst : DLH_X1 port map( G => n3928, D => n5936, Q => 
                           REG_4_25_port);
   REG_reg_4_24_inst : DLH_X1 port map( G => n3928, D => n5935, Q => 
                           REG_4_24_port);
   REG_reg_4_23_inst : DLH_X1 port map( G => n3928, D => n5934, Q => 
                           REG_4_23_port);
   REG_reg_4_22_inst : DLH_X1 port map( G => n3928, D => n5933, Q => 
                           REG_4_22_port);
   REG_reg_4_21_inst : DLH_X1 port map( G => n3928, D => n5932, Q => 
                           REG_4_21_port);
   REG_reg_4_20_inst : DLH_X1 port map( G => n3928, D => n5931, Q => 
                           REG_4_20_port);
   REG_reg_4_19_inst : DLH_X1 port map( G => n3928, D => n5930, Q => 
                           REG_4_19_port);
   REG_reg_4_18_inst : DLH_X1 port map( G => n3928, D => n5929, Q => 
                           REG_4_18_port);
   REG_reg_4_17_inst : DLH_X1 port map( G => n3928, D => n5928, Q => 
                           REG_4_17_port);
   REG_reg_4_16_inst : DLH_X1 port map( G => n3928, D => n5927, Q => 
                           REG_4_16_port);
   REG_reg_4_15_inst : DLH_X1 port map( G => n3928, D => n5926, Q => 
                           REG_4_15_port);
   REG_reg_4_14_inst : DLH_X1 port map( G => n3928, D => n5925, Q => 
                           REG_4_14_port);
   REG_reg_4_13_inst : DLH_X1 port map( G => n3928, D => n5924, Q => 
                           REG_4_13_port);
   REG_reg_4_12_inst : DLH_X1 port map( G => n3928, D => n5923, Q => 
                           REG_4_12_port);
   REG_reg_4_11_inst : DLH_X1 port map( G => n3928, D => n5922, Q => 
                           REG_4_11_port);
   REG_reg_4_10_inst : DLH_X1 port map( G => n3928, D => n5921, Q => 
                           REG_4_10_port);
   REG_reg_4_9_inst : DLH_X1 port map( G => n3928, D => n5920, Q => 
                           REG_4_9_port);
   REG_reg_4_8_inst : DLH_X1 port map( G => n3928, D => n5919, Q => 
                           REG_4_8_port);
   REG_reg_4_7_inst : DLH_X1 port map( G => n3928, D => n5918, Q => 
                           REG_4_7_port);
   REG_reg_4_6_inst : DLH_X1 port map( G => n3928, D => n5917, Q => 
                           REG_4_6_port);
   REG_reg_4_5_inst : DLH_X1 port map( G => n3928, D => n5916, Q => 
                           REG_4_5_port);
   REG_reg_4_4_inst : DLH_X1 port map( G => n3928, D => n5915, Q => 
                           REG_4_4_port);
   REG_reg_4_3_inst : DLH_X1 port map( G => n3928, D => n5914, Q => 
                           REG_4_3_port);
   REG_reg_4_2_inst : DLH_X1 port map( G => n3928, D => n5913, Q => 
                           REG_4_2_port);
   REG_reg_4_1_inst : DLH_X1 port map( G => n3928, D => n5912, Q => 
                           REG_4_1_port);
   REG_reg_4_0_inst : DLH_X1 port map( G => n3928, D => n5911, Q => 
                           REG_4_0_port);
   REG_reg_5_31_inst : DLH_X1 port map( G => n3930, D => n5942, Q => 
                           REG_5_31_port);
   REG_reg_5_30_inst : DLH_X1 port map( G => n3930, D => n5941, Q => 
                           REG_5_30_port);
   REG_reg_5_29_inst : DLH_X1 port map( G => n3930, D => n5940, Q => 
                           REG_5_29_port);
   REG_reg_5_28_inst : DLH_X1 port map( G => n3930, D => n5939, Q => 
                           REG_5_28_port);
   REG_reg_5_27_inst : DLH_X1 port map( G => n3930, D => n5938, Q => 
                           REG_5_27_port);
   REG_reg_5_26_inst : DLH_X1 port map( G => n3930, D => n5937, Q => 
                           REG_5_26_port);
   REG_reg_5_25_inst : DLH_X1 port map( G => n3930, D => n5936, Q => 
                           REG_5_25_port);
   REG_reg_5_24_inst : DLH_X1 port map( G => n3930, D => n5935, Q => 
                           REG_5_24_port);
   REG_reg_5_23_inst : DLH_X1 port map( G => n3930, D => n5934, Q => 
                           REG_5_23_port);
   REG_reg_5_22_inst : DLH_X1 port map( G => n3930, D => n5933, Q => 
                           REG_5_22_port);
   REG_reg_5_21_inst : DLH_X1 port map( G => n3930, D => n5932, Q => 
                           REG_5_21_port);
   REG_reg_5_20_inst : DLH_X1 port map( G => n3930, D => n5931, Q => 
                           REG_5_20_port);
   REG_reg_5_19_inst : DLH_X1 port map( G => n3930, D => n5930, Q => 
                           REG_5_19_port);
   REG_reg_5_18_inst : DLH_X1 port map( G => n3930, D => n5929, Q => 
                           REG_5_18_port);
   REG_reg_5_17_inst : DLH_X1 port map( G => n3930, D => n5928, Q => 
                           REG_5_17_port);
   REG_reg_5_16_inst : DLH_X1 port map( G => n3930, D => n5927, Q => 
                           REG_5_16_port);
   REG_reg_5_15_inst : DLH_X1 port map( G => n3930, D => n5926, Q => 
                           REG_5_15_port);
   REG_reg_5_14_inst : DLH_X1 port map( G => n3930, D => n5925, Q => 
                           REG_5_14_port);
   REG_reg_5_13_inst : DLH_X1 port map( G => n3930, D => n5924, Q => 
                           REG_5_13_port);
   REG_reg_5_12_inst : DLH_X1 port map( G => n3930, D => n5923, Q => 
                           REG_5_12_port);
   REG_reg_5_11_inst : DLH_X1 port map( G => n3930, D => n5922, Q => 
                           REG_5_11_port);
   REG_reg_5_10_inst : DLH_X1 port map( G => n3930, D => n5921, Q => 
                           REG_5_10_port);
   REG_reg_5_9_inst : DLH_X1 port map( G => n3930, D => n5920, Q => 
                           REG_5_9_port);
   REG_reg_5_8_inst : DLH_X1 port map( G => n3930, D => n5919, Q => 
                           REG_5_8_port);
   REG_reg_5_7_inst : DLH_X1 port map( G => n3930, D => n5918, Q => 
                           REG_5_7_port);
   REG_reg_5_6_inst : DLH_X1 port map( G => n3930, D => n5917, Q => 
                           REG_5_6_port);
   REG_reg_5_5_inst : DLH_X1 port map( G => n3930, D => n5916, Q => 
                           REG_5_5_port);
   REG_reg_5_4_inst : DLH_X1 port map( G => n3930, D => n5915, Q => 
                           REG_5_4_port);
   REG_reg_5_3_inst : DLH_X1 port map( G => n3930, D => n5914, Q => 
                           REG_5_3_port);
   REG_reg_5_2_inst : DLH_X1 port map( G => n3930, D => n5913, Q => 
                           REG_5_2_port);
   REG_reg_5_1_inst : DLH_X1 port map( G => n3930, D => n5912, Q => 
                           REG_5_1_port);
   REG_reg_5_0_inst : DLH_X1 port map( G => n3930, D => n5911, Q => 
                           REG_5_0_port);
   REG_reg_6_31_inst : DLH_X1 port map( G => n3932, D => n5942, Q => 
                           REG_6_31_port);
   REG_reg_6_30_inst : DLH_X1 port map( G => n3932, D => n5941, Q => 
                           REG_6_30_port);
   REG_reg_6_29_inst : DLH_X1 port map( G => n3932, D => n5940, Q => 
                           REG_6_29_port);
   REG_reg_6_28_inst : DLH_X1 port map( G => n3932, D => n5939, Q => 
                           REG_6_28_port);
   REG_reg_6_27_inst : DLH_X1 port map( G => n3932, D => n5938, Q => 
                           REG_6_27_port);
   REG_reg_6_26_inst : DLH_X1 port map( G => n3932, D => n5937, Q => 
                           REG_6_26_port);
   REG_reg_6_25_inst : DLH_X1 port map( G => n3932, D => n5936, Q => 
                           REG_6_25_port);
   REG_reg_6_24_inst : DLH_X1 port map( G => n3932, D => n5935, Q => 
                           REG_6_24_port);
   REG_reg_6_23_inst : DLH_X1 port map( G => n3932, D => n5934, Q => 
                           REG_6_23_port);
   REG_reg_6_22_inst : DLH_X1 port map( G => n3932, D => n5933, Q => 
                           REG_6_22_port);
   REG_reg_6_21_inst : DLH_X1 port map( G => n3932, D => n5932, Q => 
                           REG_6_21_port);
   REG_reg_6_20_inst : DLH_X1 port map( G => n3932, D => n5931, Q => 
                           REG_6_20_port);
   REG_reg_6_19_inst : DLH_X1 port map( G => n3932, D => n5930, Q => 
                           REG_6_19_port);
   REG_reg_6_18_inst : DLH_X1 port map( G => n3932, D => n5929, Q => 
                           REG_6_18_port);
   REG_reg_6_17_inst : DLH_X1 port map( G => n3932, D => n5928, Q => 
                           REG_6_17_port);
   REG_reg_6_16_inst : DLH_X1 port map( G => n3932, D => n5927, Q => 
                           REG_6_16_port);
   REG_reg_6_15_inst : DLH_X1 port map( G => n3932, D => n5926, Q => 
                           REG_6_15_port);
   REG_reg_6_14_inst : DLH_X1 port map( G => n3932, D => n5925, Q => 
                           REG_6_14_port);
   REG_reg_6_13_inst : DLH_X1 port map( G => n3932, D => n5924, Q => 
                           REG_6_13_port);
   REG_reg_6_12_inst : DLH_X1 port map( G => n3932, D => n5923, Q => 
                           REG_6_12_port);
   REG_reg_6_11_inst : DLH_X1 port map( G => n3932, D => n5922, Q => 
                           REG_6_11_port);
   REG_reg_6_10_inst : DLH_X1 port map( G => n3932, D => n5921, Q => 
                           REG_6_10_port);
   REG_reg_6_9_inst : DLH_X1 port map( G => n3932, D => n5920, Q => 
                           REG_6_9_port);
   REG_reg_6_8_inst : DLH_X1 port map( G => n3932, D => n5919, Q => 
                           REG_6_8_port);
   REG_reg_6_7_inst : DLH_X1 port map( G => n3932, D => n5918, Q => 
                           REG_6_7_port);
   REG_reg_6_6_inst : DLH_X1 port map( G => n3932, D => n5917, Q => 
                           REG_6_6_port);
   REG_reg_6_5_inst : DLH_X1 port map( G => n3932, D => n5916, Q => 
                           REG_6_5_port);
   REG_reg_6_4_inst : DLH_X1 port map( G => n3932, D => n5915, Q => 
                           REG_6_4_port);
   REG_reg_6_3_inst : DLH_X1 port map( G => n3932, D => n5914, Q => 
                           REG_6_3_port);
   REG_reg_6_2_inst : DLH_X1 port map( G => n3932, D => n5913, Q => 
                           REG_6_2_port);
   REG_reg_6_1_inst : DLH_X1 port map( G => n3932, D => n5912, Q => 
                           REG_6_1_port);
   REG_reg_6_0_inst : DLH_X1 port map( G => n3932, D => n5911, Q => 
                           REG_6_0_port);
   REG_reg_7_31_inst : DLH_X1 port map( G => n3934, D => n5942, Q => 
                           REG_7_31_port);
   REG_reg_7_30_inst : DLH_X1 port map( G => n3934, D => n5941, Q => 
                           REG_7_30_port);
   REG_reg_7_29_inst : DLH_X1 port map( G => n3934, D => n5940, Q => 
                           REG_7_29_port);
   REG_reg_7_28_inst : DLH_X1 port map( G => n3934, D => n5939, Q => 
                           REG_7_28_port);
   REG_reg_7_27_inst : DLH_X1 port map( G => n3934, D => n5938, Q => 
                           REG_7_27_port);
   REG_reg_7_26_inst : DLH_X1 port map( G => n3934, D => n5937, Q => 
                           REG_7_26_port);
   REG_reg_7_25_inst : DLH_X1 port map( G => n3934, D => n5936, Q => 
                           REG_7_25_port);
   REG_reg_7_24_inst : DLH_X1 port map( G => n3934, D => n5935, Q => 
                           REG_7_24_port);
   REG_reg_7_23_inst : DLH_X1 port map( G => n3934, D => n5934, Q => 
                           REG_7_23_port);
   REG_reg_7_22_inst : DLH_X1 port map( G => n3934, D => n5933, Q => 
                           REG_7_22_port);
   REG_reg_7_21_inst : DLH_X1 port map( G => n3934, D => n5932, Q => 
                           REG_7_21_port);
   REG_reg_7_20_inst : DLH_X1 port map( G => n3934, D => n5931, Q => 
                           REG_7_20_port);
   REG_reg_7_19_inst : DLH_X1 port map( G => n3934, D => n5930, Q => 
                           REG_7_19_port);
   REG_reg_7_18_inst : DLH_X1 port map( G => n3934, D => n5929, Q => 
                           REG_7_18_port);
   REG_reg_7_17_inst : DLH_X1 port map( G => n3934, D => n5928, Q => 
                           REG_7_17_port);
   REG_reg_7_16_inst : DLH_X1 port map( G => n3934, D => n5927, Q => 
                           REG_7_16_port);
   REG_reg_7_15_inst : DLH_X1 port map( G => n3934, D => n5926, Q => 
                           REG_7_15_port);
   REG_reg_7_14_inst : DLH_X1 port map( G => n3934, D => n5925, Q => 
                           REG_7_14_port);
   REG_reg_7_13_inst : DLH_X1 port map( G => n3934, D => n5924, Q => 
                           REG_7_13_port);
   REG_reg_7_12_inst : DLH_X1 port map( G => n3934, D => n5923, Q => 
                           REG_7_12_port);
   REG_reg_7_11_inst : DLH_X1 port map( G => n3934, D => n5922, Q => 
                           REG_7_11_port);
   REG_reg_7_10_inst : DLH_X1 port map( G => n3934, D => n5921, Q => 
                           REG_7_10_port);
   REG_reg_7_9_inst : DLH_X1 port map( G => n3934, D => n5920, Q => 
                           REG_7_9_port);
   REG_reg_7_8_inst : DLH_X1 port map( G => n3934, D => n5919, Q => 
                           REG_7_8_port);
   REG_reg_7_7_inst : DLH_X1 port map( G => n3934, D => n5918, Q => 
                           REG_7_7_port);
   REG_reg_7_6_inst : DLH_X1 port map( G => n3934, D => n5917, Q => 
                           REG_7_6_port);
   REG_reg_7_5_inst : DLH_X1 port map( G => n3934, D => n5916, Q => 
                           REG_7_5_port);
   REG_reg_7_4_inst : DLH_X1 port map( G => n3934, D => n5915, Q => 
                           REG_7_4_port);
   REG_reg_7_3_inst : DLH_X1 port map( G => n3934, D => n5914, Q => 
                           REG_7_3_port);
   REG_reg_7_2_inst : DLH_X1 port map( G => n3934, D => n5913, Q => 
                           REG_7_2_port);
   REG_reg_7_1_inst : DLH_X1 port map( G => n3934, D => n5912, Q => 
                           REG_7_1_port);
   REG_reg_7_0_inst : DLH_X1 port map( G => n3934, D => n5911, Q => 
                           REG_7_0_port);
   REG_reg_8_31_inst : DLH_X1 port map( G => n3936, D => n5942, Q => 
                           REG_8_31_port);
   REG_reg_8_30_inst : DLH_X1 port map( G => n3936, D => n5941, Q => 
                           REG_8_30_port);
   REG_reg_8_29_inst : DLH_X1 port map( G => n3936, D => n5940, Q => 
                           REG_8_29_port);
   REG_reg_8_28_inst : DLH_X1 port map( G => n3936, D => n5939, Q => 
                           REG_8_28_port);
   REG_reg_8_27_inst : DLH_X1 port map( G => n3936, D => n5938, Q => 
                           REG_8_27_port);
   REG_reg_8_26_inst : DLH_X1 port map( G => n3936, D => n5937, Q => 
                           REG_8_26_port);
   REG_reg_8_25_inst : DLH_X1 port map( G => n3936, D => n5936, Q => 
                           REG_8_25_port);
   REG_reg_8_24_inst : DLH_X1 port map( G => n3936, D => n5935, Q => 
                           REG_8_24_port);
   REG_reg_8_23_inst : DLH_X1 port map( G => n3936, D => n5934, Q => 
                           REG_8_23_port);
   REG_reg_8_22_inst : DLH_X1 port map( G => n3936, D => n5933, Q => 
                           REG_8_22_port);
   REG_reg_8_21_inst : DLH_X1 port map( G => n3936, D => n5932, Q => 
                           REG_8_21_port);
   REG_reg_8_20_inst : DLH_X1 port map( G => n3936, D => n5931, Q => 
                           REG_8_20_port);
   REG_reg_8_19_inst : DLH_X1 port map( G => n3936, D => n5930, Q => 
                           REG_8_19_port);
   REG_reg_8_18_inst : DLH_X1 port map( G => n3936, D => n5929, Q => 
                           REG_8_18_port);
   REG_reg_8_17_inst : DLH_X1 port map( G => n3936, D => n5928, Q => 
                           REG_8_17_port);
   REG_reg_8_16_inst : DLH_X1 port map( G => n3936, D => n5927, Q => 
                           REG_8_16_port);
   REG_reg_8_15_inst : DLH_X1 port map( G => n3936, D => n5926, Q => 
                           REG_8_15_port);
   REG_reg_8_14_inst : DLH_X1 port map( G => n3936, D => n5925, Q => 
                           REG_8_14_port);
   REG_reg_8_13_inst : DLH_X1 port map( G => n3936, D => n5924, Q => 
                           REG_8_13_port);
   REG_reg_8_12_inst : DLH_X1 port map( G => n3936, D => n5923, Q => 
                           REG_8_12_port);
   REG_reg_8_11_inst : DLH_X1 port map( G => n3936, D => n5922, Q => 
                           REG_8_11_port);
   REG_reg_8_10_inst : DLH_X1 port map( G => n3936, D => n5921, Q => 
                           REG_8_10_port);
   REG_reg_8_9_inst : DLH_X1 port map( G => n3936, D => n5920, Q => 
                           REG_8_9_port);
   REG_reg_8_8_inst : DLH_X1 port map( G => n3936, D => n5919, Q => 
                           REG_8_8_port);
   REG_reg_8_7_inst : DLH_X1 port map( G => n3936, D => n5918, Q => 
                           REG_8_7_port);
   REG_reg_8_6_inst : DLH_X1 port map( G => n3936, D => n5917, Q => 
                           REG_8_6_port);
   REG_reg_8_5_inst : DLH_X1 port map( G => n3936, D => n5916, Q => 
                           REG_8_5_port);
   REG_reg_8_4_inst : DLH_X1 port map( G => n3936, D => n5915, Q => 
                           REG_8_4_port);
   REG_reg_8_3_inst : DLH_X1 port map( G => n3936, D => n5914, Q => 
                           REG_8_3_port);
   REG_reg_8_2_inst : DLH_X1 port map( G => n3936, D => n5913, Q => 
                           REG_8_2_port);
   REG_reg_8_1_inst : DLH_X1 port map( G => n3936, D => n5912, Q => 
                           REG_8_1_port);
   REG_reg_8_0_inst : DLH_X1 port map( G => n3936, D => n5911, Q => 
                           REG_8_0_port);
   REG_reg_9_31_inst : DLH_X1 port map( G => n3938, D => n5942, Q => 
                           REG_9_31_port);
   REG_reg_9_30_inst : DLH_X1 port map( G => n3938, D => n5941, Q => 
                           REG_9_30_port);
   REG_reg_9_29_inst : DLH_X1 port map( G => n3938, D => n5940, Q => 
                           REG_9_29_port);
   REG_reg_9_28_inst : DLH_X1 port map( G => n3938, D => n5939, Q => 
                           REG_9_28_port);
   REG_reg_9_27_inst : DLH_X1 port map( G => n3938, D => n5938, Q => 
                           REG_9_27_port);
   REG_reg_9_26_inst : DLH_X1 port map( G => n3938, D => n5937, Q => 
                           REG_9_26_port);
   REG_reg_9_25_inst : DLH_X1 port map( G => n3938, D => n5936, Q => 
                           REG_9_25_port);
   REG_reg_9_24_inst : DLH_X1 port map( G => n3938, D => n5935, Q => 
                           REG_9_24_port);
   REG_reg_9_23_inst : DLH_X1 port map( G => n3938, D => n5934, Q => 
                           REG_9_23_port);
   REG_reg_9_22_inst : DLH_X1 port map( G => n3938, D => n5933, Q => 
                           REG_9_22_port);
   REG_reg_9_21_inst : DLH_X1 port map( G => n3938, D => n5932, Q => 
                           REG_9_21_port);
   REG_reg_9_20_inst : DLH_X1 port map( G => n3938, D => n5931, Q => 
                           REG_9_20_port);
   REG_reg_9_19_inst : DLH_X1 port map( G => n3938, D => n5930, Q => 
                           REG_9_19_port);
   REG_reg_9_18_inst : DLH_X1 port map( G => n3938, D => n5929, Q => 
                           REG_9_18_port);
   REG_reg_9_17_inst : DLH_X1 port map( G => n3938, D => n5928, Q => 
                           REG_9_17_port);
   REG_reg_9_16_inst : DLH_X1 port map( G => n3938, D => n5927, Q => 
                           REG_9_16_port);
   REG_reg_9_15_inst : DLH_X1 port map( G => n3938, D => n5926, Q => 
                           REG_9_15_port);
   REG_reg_9_14_inst : DLH_X1 port map( G => n3938, D => n5925, Q => 
                           REG_9_14_port);
   REG_reg_9_13_inst : DLH_X1 port map( G => n3938, D => n5924, Q => 
                           REG_9_13_port);
   REG_reg_9_12_inst : DLH_X1 port map( G => n3938, D => n5923, Q => 
                           REG_9_12_port);
   REG_reg_9_11_inst : DLH_X1 port map( G => n3938, D => n5922, Q => 
                           REG_9_11_port);
   REG_reg_9_10_inst : DLH_X1 port map( G => n3938, D => n5921, Q => 
                           REG_9_10_port);
   REG_reg_9_9_inst : DLH_X1 port map( G => n3938, D => n5920, Q => 
                           REG_9_9_port);
   REG_reg_9_8_inst : DLH_X1 port map( G => n3938, D => n5919, Q => 
                           REG_9_8_port);
   REG_reg_9_7_inst : DLH_X1 port map( G => n3938, D => n5918, Q => 
                           REG_9_7_port);
   REG_reg_9_6_inst : DLH_X1 port map( G => n3938, D => n5917, Q => 
                           REG_9_6_port);
   REG_reg_9_5_inst : DLH_X1 port map( G => n3938, D => n5916, Q => 
                           REG_9_5_port);
   REG_reg_9_4_inst : DLH_X1 port map( G => n3938, D => n5915, Q => 
                           REG_9_4_port);
   REG_reg_9_3_inst : DLH_X1 port map( G => n3938, D => n5914, Q => 
                           REG_9_3_port);
   REG_reg_9_2_inst : DLH_X1 port map( G => n3938, D => n5913, Q => 
                           REG_9_2_port);
   REG_reg_9_1_inst : DLH_X1 port map( G => n3938, D => n5912, Q => 
                           REG_9_1_port);
   REG_reg_9_0_inst : DLH_X1 port map( G => n3938, D => n5911, Q => 
                           REG_9_0_port);
   REG_reg_10_31_inst : DLH_X1 port map( G => n3940, D => n5942, Q => 
                           REG_10_31_port);
   REG_reg_10_30_inst : DLH_X1 port map( G => n3940, D => n5941, Q => 
                           REG_10_30_port);
   REG_reg_10_29_inst : DLH_X1 port map( G => n3940, D => n5940, Q => 
                           REG_10_29_port);
   REG_reg_10_28_inst : DLH_X1 port map( G => n3940, D => n5939, Q => 
                           REG_10_28_port);
   REG_reg_10_27_inst : DLH_X1 port map( G => n3940, D => n5938, Q => 
                           REG_10_27_port);
   REG_reg_10_26_inst : DLH_X1 port map( G => n3940, D => n5937, Q => 
                           REG_10_26_port);
   REG_reg_10_25_inst : DLH_X1 port map( G => n3940, D => n5936, Q => 
                           REG_10_25_port);
   REG_reg_10_24_inst : DLH_X1 port map( G => n3940, D => n5935, Q => 
                           REG_10_24_port);
   REG_reg_10_23_inst : DLH_X1 port map( G => n3940, D => n5934, Q => 
                           REG_10_23_port);
   REG_reg_10_22_inst : DLH_X1 port map( G => n3940, D => n5933, Q => 
                           REG_10_22_port);
   REG_reg_10_21_inst : DLH_X1 port map( G => n3940, D => n5932, Q => 
                           REG_10_21_port);
   REG_reg_10_20_inst : DLH_X1 port map( G => n3940, D => n5931, Q => 
                           REG_10_20_port);
   REG_reg_10_19_inst : DLH_X1 port map( G => n3940, D => n5930, Q => 
                           REG_10_19_port);
   REG_reg_10_18_inst : DLH_X1 port map( G => n3940, D => n5929, Q => 
                           REG_10_18_port);
   REG_reg_10_17_inst : DLH_X1 port map( G => n3940, D => n5928, Q => 
                           REG_10_17_port);
   REG_reg_10_16_inst : DLH_X1 port map( G => n3940, D => n5927, Q => 
                           REG_10_16_port);
   REG_reg_10_15_inst : DLH_X1 port map( G => n3940, D => n5926, Q => 
                           REG_10_15_port);
   REG_reg_10_14_inst : DLH_X1 port map( G => n3940, D => n5925, Q => 
                           REG_10_14_port);
   REG_reg_10_13_inst : DLH_X1 port map( G => n3940, D => n5924, Q => 
                           REG_10_13_port);
   REG_reg_10_12_inst : DLH_X1 port map( G => n3940, D => n5923, Q => 
                           REG_10_12_port);
   REG_reg_10_11_inst : DLH_X1 port map( G => n3940, D => n5922, Q => 
                           REG_10_11_port);
   REG_reg_10_10_inst : DLH_X1 port map( G => n3940, D => n5921, Q => 
                           REG_10_10_port);
   REG_reg_10_9_inst : DLH_X1 port map( G => n3940, D => n5920, Q => 
                           REG_10_9_port);
   REG_reg_10_8_inst : DLH_X1 port map( G => n3940, D => n5919, Q => 
                           REG_10_8_port);
   REG_reg_10_7_inst : DLH_X1 port map( G => n3940, D => n5918, Q => 
                           REG_10_7_port);
   REG_reg_10_6_inst : DLH_X1 port map( G => n3940, D => n5917, Q => 
                           REG_10_6_port);
   REG_reg_10_5_inst : DLH_X1 port map( G => n3940, D => n5916, Q => 
                           REG_10_5_port);
   REG_reg_10_4_inst : DLH_X1 port map( G => n3940, D => n5915, Q => 
                           REG_10_4_port);
   REG_reg_10_3_inst : DLH_X1 port map( G => n3940, D => n5914, Q => 
                           REG_10_3_port);
   REG_reg_10_2_inst : DLH_X1 port map( G => n3940, D => n5913, Q => 
                           REG_10_2_port);
   REG_reg_10_1_inst : DLH_X1 port map( G => n3940, D => n5912, Q => 
                           REG_10_1_port);
   REG_reg_10_0_inst : DLH_X1 port map( G => n3940, D => n5911, Q => 
                           REG_10_0_port);
   REG_reg_11_31_inst : DLH_X1 port map( G => n3942, D => n5942, Q => 
                           REG_11_31_port);
   REG_reg_11_30_inst : DLH_X1 port map( G => n3942, D => n5941, Q => 
                           REG_11_30_port);
   REG_reg_11_29_inst : DLH_X1 port map( G => n3942, D => n5940, Q => 
                           REG_11_29_port);
   REG_reg_11_28_inst : DLH_X1 port map( G => n3942, D => n5939, Q => 
                           REG_11_28_port);
   REG_reg_11_27_inst : DLH_X1 port map( G => n3942, D => n5938, Q => 
                           REG_11_27_port);
   REG_reg_11_26_inst : DLH_X1 port map( G => n3942, D => n5937, Q => 
                           REG_11_26_port);
   REG_reg_11_25_inst : DLH_X1 port map( G => n3942, D => n5936, Q => 
                           REG_11_25_port);
   REG_reg_11_24_inst : DLH_X1 port map( G => n3942, D => n5935, Q => 
                           REG_11_24_port);
   REG_reg_11_23_inst : DLH_X1 port map( G => n3942, D => n5934, Q => 
                           REG_11_23_port);
   REG_reg_11_22_inst : DLH_X1 port map( G => n3942, D => n5933, Q => 
                           REG_11_22_port);
   REG_reg_11_21_inst : DLH_X1 port map( G => n3942, D => n5932, Q => 
                           REG_11_21_port);
   REG_reg_11_20_inst : DLH_X1 port map( G => n3942, D => n5931, Q => 
                           REG_11_20_port);
   REG_reg_11_19_inst : DLH_X1 port map( G => n3942, D => n5930, Q => 
                           REG_11_19_port);
   REG_reg_11_18_inst : DLH_X1 port map( G => n3942, D => n5929, Q => 
                           REG_11_18_port);
   REG_reg_11_17_inst : DLH_X1 port map( G => n3942, D => n5928, Q => 
                           REG_11_17_port);
   REG_reg_11_16_inst : DLH_X1 port map( G => n3942, D => n5927, Q => 
                           REG_11_16_port);
   REG_reg_11_15_inst : DLH_X1 port map( G => n3942, D => n5926, Q => 
                           REG_11_15_port);
   REG_reg_11_14_inst : DLH_X1 port map( G => n3942, D => n5925, Q => 
                           REG_11_14_port);
   REG_reg_11_13_inst : DLH_X1 port map( G => n3942, D => n5924, Q => 
                           REG_11_13_port);
   REG_reg_11_12_inst : DLH_X1 port map( G => n3942, D => n5923, Q => 
                           REG_11_12_port);
   REG_reg_11_11_inst : DLH_X1 port map( G => n3942, D => n5922, Q => 
                           REG_11_11_port);
   REG_reg_11_10_inst : DLH_X1 port map( G => n3942, D => n5921, Q => 
                           REG_11_10_port);
   REG_reg_11_9_inst : DLH_X1 port map( G => n3942, D => n5920, Q => 
                           REG_11_9_port);
   REG_reg_11_8_inst : DLH_X1 port map( G => n3942, D => n5919, Q => 
                           REG_11_8_port);
   REG_reg_11_7_inst : DLH_X1 port map( G => n3942, D => n5918, Q => 
                           REG_11_7_port);
   REG_reg_11_6_inst : DLH_X1 port map( G => n3942, D => n5917, Q => 
                           REG_11_6_port);
   REG_reg_11_5_inst : DLH_X1 port map( G => n3942, D => n5916, Q => 
                           REG_11_5_port);
   REG_reg_11_4_inst : DLH_X1 port map( G => n3942, D => n5915, Q => 
                           REG_11_4_port);
   REG_reg_11_3_inst : DLH_X1 port map( G => n3942, D => n5914, Q => 
                           REG_11_3_port);
   REG_reg_11_2_inst : DLH_X1 port map( G => n3942, D => n5913, Q => 
                           REG_11_2_port);
   REG_reg_11_1_inst : DLH_X1 port map( G => n3942, D => n5912, Q => 
                           REG_11_1_port);
   REG_reg_11_0_inst : DLH_X1 port map( G => n3942, D => n5911, Q => 
                           REG_11_0_port);
   REG_reg_12_31_inst : DLH_X1 port map( G => n3944, D => n5942, Q => 
                           REG_12_31_port);
   REG_reg_12_30_inst : DLH_X1 port map( G => n3944, D => n5941, Q => 
                           REG_12_30_port);
   REG_reg_12_29_inst : DLH_X1 port map( G => n3944, D => n5940, Q => 
                           REG_12_29_port);
   REG_reg_12_28_inst : DLH_X1 port map( G => n3944, D => n5939, Q => 
                           REG_12_28_port);
   REG_reg_12_27_inst : DLH_X1 port map( G => n3944, D => n5938, Q => 
                           REG_12_27_port);
   REG_reg_12_26_inst : DLH_X1 port map( G => n3944, D => n5937, Q => 
                           REG_12_26_port);
   REG_reg_12_25_inst : DLH_X1 port map( G => n3944, D => n5936, Q => 
                           REG_12_25_port);
   REG_reg_12_24_inst : DLH_X1 port map( G => n3944, D => n5935, Q => 
                           REG_12_24_port);
   REG_reg_12_23_inst : DLH_X1 port map( G => n3944, D => n5934, Q => 
                           REG_12_23_port);
   REG_reg_12_22_inst : DLH_X1 port map( G => n3944, D => n5933, Q => 
                           REG_12_22_port);
   REG_reg_12_21_inst : DLH_X1 port map( G => n3944, D => n5932, Q => 
                           REG_12_21_port);
   REG_reg_12_20_inst : DLH_X1 port map( G => n3944, D => n5931, Q => 
                           REG_12_20_port);
   REG_reg_12_19_inst : DLH_X1 port map( G => n3944, D => n5930, Q => 
                           REG_12_19_port);
   REG_reg_12_18_inst : DLH_X1 port map( G => n3944, D => n5929, Q => 
                           REG_12_18_port);
   REG_reg_12_17_inst : DLH_X1 port map( G => n3944, D => n5928, Q => 
                           REG_12_17_port);
   REG_reg_12_16_inst : DLH_X1 port map( G => n3944, D => n5927, Q => 
                           REG_12_16_port);
   REG_reg_12_15_inst : DLH_X1 port map( G => n3944, D => n5926, Q => 
                           REG_12_15_port);
   REG_reg_12_14_inst : DLH_X1 port map( G => n3944, D => n5925, Q => 
                           REG_12_14_port);
   REG_reg_12_13_inst : DLH_X1 port map( G => n3944, D => n5924, Q => 
                           REG_12_13_port);
   REG_reg_12_12_inst : DLH_X1 port map( G => n3944, D => n5923, Q => 
                           REG_12_12_port);
   REG_reg_12_11_inst : DLH_X1 port map( G => n3944, D => n5922, Q => 
                           REG_12_11_port);
   REG_reg_12_10_inst : DLH_X1 port map( G => n3944, D => n5921, Q => 
                           REG_12_10_port);
   REG_reg_12_9_inst : DLH_X1 port map( G => n3944, D => n5920, Q => 
                           REG_12_9_port);
   REG_reg_12_8_inst : DLH_X1 port map( G => n3944, D => n5919, Q => 
                           REG_12_8_port);
   REG_reg_12_7_inst : DLH_X1 port map( G => n3944, D => n5918, Q => 
                           REG_12_7_port);
   REG_reg_12_6_inst : DLH_X1 port map( G => n3944, D => n5917, Q => 
                           REG_12_6_port);
   REG_reg_12_5_inst : DLH_X1 port map( G => n3944, D => n5916, Q => 
                           REG_12_5_port);
   REG_reg_12_4_inst : DLH_X1 port map( G => n3944, D => n5915, Q => 
                           REG_12_4_port);
   REG_reg_12_3_inst : DLH_X1 port map( G => n3944, D => n5914, Q => 
                           REG_12_3_port);
   REG_reg_12_2_inst : DLH_X1 port map( G => n3944, D => n5913, Q => 
                           REG_12_2_port);
   REG_reg_12_1_inst : DLH_X1 port map( G => n3944, D => n5912, Q => 
                           REG_12_1_port);
   REG_reg_12_0_inst : DLH_X1 port map( G => n3944, D => n5911, Q => 
                           REG_12_0_port);
   REG_reg_13_31_inst : DLH_X1 port map( G => n3946, D => n5942, Q => 
                           REG_13_31_port);
   REG_reg_13_30_inst : DLH_X1 port map( G => n3946, D => n5941, Q => 
                           REG_13_30_port);
   REG_reg_13_29_inst : DLH_X1 port map( G => n3946, D => n5940, Q => 
                           REG_13_29_port);
   REG_reg_13_28_inst : DLH_X1 port map( G => n3946, D => n5939, Q => 
                           REG_13_28_port);
   REG_reg_13_27_inst : DLH_X1 port map( G => n3946, D => n5938, Q => 
                           REG_13_27_port);
   REG_reg_13_26_inst : DLH_X1 port map( G => n3946, D => n5937, Q => 
                           REG_13_26_port);
   REG_reg_13_25_inst : DLH_X1 port map( G => n3946, D => n5936, Q => 
                           REG_13_25_port);
   REG_reg_13_24_inst : DLH_X1 port map( G => n3946, D => n5935, Q => 
                           REG_13_24_port);
   REG_reg_13_23_inst : DLH_X1 port map( G => n3946, D => n5934, Q => 
                           REG_13_23_port);
   REG_reg_13_22_inst : DLH_X1 port map( G => n3946, D => n5933, Q => 
                           REG_13_22_port);
   REG_reg_13_21_inst : DLH_X1 port map( G => n3946, D => n5932, Q => 
                           REG_13_21_port);
   REG_reg_13_20_inst : DLH_X1 port map( G => n3946, D => n5931, Q => 
                           REG_13_20_port);
   REG_reg_13_19_inst : DLH_X1 port map( G => n3946, D => n5930, Q => 
                           REG_13_19_port);
   REG_reg_13_18_inst : DLH_X1 port map( G => n3946, D => n5929, Q => 
                           REG_13_18_port);
   REG_reg_13_17_inst : DLH_X1 port map( G => n3946, D => n5928, Q => 
                           REG_13_17_port);
   REG_reg_13_16_inst : DLH_X1 port map( G => n3946, D => n5927, Q => 
                           REG_13_16_port);
   REG_reg_13_15_inst : DLH_X1 port map( G => n3946, D => n5926, Q => 
                           REG_13_15_port);
   REG_reg_13_14_inst : DLH_X1 port map( G => n3946, D => n5925, Q => 
                           REG_13_14_port);
   REG_reg_13_13_inst : DLH_X1 port map( G => n3946, D => n5924, Q => 
                           REG_13_13_port);
   REG_reg_13_12_inst : DLH_X1 port map( G => n3946, D => n5923, Q => 
                           REG_13_12_port);
   REG_reg_13_11_inst : DLH_X1 port map( G => n3946, D => n5922, Q => 
                           REG_13_11_port);
   REG_reg_13_10_inst : DLH_X1 port map( G => n3946, D => n5921, Q => 
                           REG_13_10_port);
   REG_reg_13_9_inst : DLH_X1 port map( G => n3946, D => n5920, Q => 
                           REG_13_9_port);
   REG_reg_13_8_inst : DLH_X1 port map( G => n3946, D => n5919, Q => 
                           REG_13_8_port);
   REG_reg_13_7_inst : DLH_X1 port map( G => n3946, D => n5918, Q => 
                           REG_13_7_port);
   REG_reg_13_6_inst : DLH_X1 port map( G => n3946, D => n5917, Q => 
                           REG_13_6_port);
   REG_reg_13_5_inst : DLH_X1 port map( G => n3946, D => n5916, Q => 
                           REG_13_5_port);
   REG_reg_13_4_inst : DLH_X1 port map( G => n3946, D => n5915, Q => 
                           REG_13_4_port);
   REG_reg_13_3_inst : DLH_X1 port map( G => n3946, D => n5914, Q => 
                           REG_13_3_port);
   REG_reg_13_2_inst : DLH_X1 port map( G => n3946, D => n5913, Q => 
                           REG_13_2_port);
   REG_reg_13_1_inst : DLH_X1 port map( G => n3946, D => n5912, Q => 
                           REG_13_1_port);
   REG_reg_13_0_inst : DLH_X1 port map( G => n3946, D => n5911, Q => 
                           REG_13_0_port);
   REG_reg_14_31_inst : DLH_X1 port map( G => n3948, D => n5942, Q => 
                           REG_14_31_port);
   REG_reg_14_30_inst : DLH_X1 port map( G => n3948, D => n5941, Q => 
                           REG_14_30_port);
   REG_reg_14_29_inst : DLH_X1 port map( G => n3948, D => n5940, Q => 
                           REG_14_29_port);
   REG_reg_14_28_inst : DLH_X1 port map( G => n3948, D => n5939, Q => 
                           REG_14_28_port);
   REG_reg_14_27_inst : DLH_X1 port map( G => n3948, D => n5938, Q => 
                           REG_14_27_port);
   REG_reg_14_26_inst : DLH_X1 port map( G => n3948, D => n5937, Q => 
                           REG_14_26_port);
   REG_reg_14_25_inst : DLH_X1 port map( G => n3948, D => n5936, Q => 
                           REG_14_25_port);
   REG_reg_14_24_inst : DLH_X1 port map( G => n3948, D => n5935, Q => 
                           REG_14_24_port);
   REG_reg_14_23_inst : DLH_X1 port map( G => n3948, D => n5934, Q => 
                           REG_14_23_port);
   REG_reg_14_22_inst : DLH_X1 port map( G => n3948, D => n5933, Q => 
                           REG_14_22_port);
   REG_reg_14_21_inst : DLH_X1 port map( G => n3948, D => n5932, Q => 
                           REG_14_21_port);
   REG_reg_14_20_inst : DLH_X1 port map( G => n3948, D => n5931, Q => 
                           REG_14_20_port);
   REG_reg_14_19_inst : DLH_X1 port map( G => n3948, D => n5930, Q => 
                           REG_14_19_port);
   REG_reg_14_18_inst : DLH_X1 port map( G => n3948, D => n5929, Q => 
                           REG_14_18_port);
   REG_reg_14_17_inst : DLH_X1 port map( G => n3948, D => n5928, Q => 
                           REG_14_17_port);
   REG_reg_14_16_inst : DLH_X1 port map( G => n3948, D => n5927, Q => 
                           REG_14_16_port);
   REG_reg_14_15_inst : DLH_X1 port map( G => n3948, D => n5926, Q => 
                           REG_14_15_port);
   REG_reg_14_14_inst : DLH_X1 port map( G => n3948, D => n5925, Q => 
                           REG_14_14_port);
   REG_reg_14_13_inst : DLH_X1 port map( G => n3948, D => n5924, Q => 
                           REG_14_13_port);
   REG_reg_14_12_inst : DLH_X1 port map( G => n3948, D => n5923, Q => 
                           REG_14_12_port);
   REG_reg_14_11_inst : DLH_X1 port map( G => n3948, D => n5922, Q => 
                           REG_14_11_port);
   REG_reg_14_10_inst : DLH_X1 port map( G => n3948, D => n5921, Q => 
                           REG_14_10_port);
   REG_reg_14_9_inst : DLH_X1 port map( G => n3948, D => n5920, Q => 
                           REG_14_9_port);
   REG_reg_14_8_inst : DLH_X1 port map( G => n3948, D => n5919, Q => 
                           REG_14_8_port);
   REG_reg_14_7_inst : DLH_X1 port map( G => n3948, D => n5918, Q => 
                           REG_14_7_port);
   REG_reg_14_6_inst : DLH_X1 port map( G => n3948, D => n5917, Q => 
                           REG_14_6_port);
   REG_reg_14_5_inst : DLH_X1 port map( G => n3948, D => n5916, Q => 
                           REG_14_5_port);
   REG_reg_14_4_inst : DLH_X1 port map( G => n3948, D => n5915, Q => 
                           REG_14_4_port);
   REG_reg_14_3_inst : DLH_X1 port map( G => n3948, D => n5914, Q => 
                           REG_14_3_port);
   REG_reg_14_2_inst : DLH_X1 port map( G => n3948, D => n5913, Q => 
                           REG_14_2_port);
   REG_reg_14_1_inst : DLH_X1 port map( G => n3948, D => n5912, Q => 
                           REG_14_1_port);
   REG_reg_14_0_inst : DLH_X1 port map( G => n3948, D => n5911, Q => 
                           REG_14_0_port);
   REG_reg_15_31_inst : DLH_X1 port map( G => n3954, D => n5942, Q => 
                           REG_15_31_port);
   REG_reg_15_30_inst : DLH_X1 port map( G => n3954, D => n5941, Q => 
                           REG_15_30_port);
   REG_reg_15_29_inst : DLH_X1 port map( G => n3954, D => n5940, Q => 
                           REG_15_29_port);
   REG_reg_15_28_inst : DLH_X1 port map( G => n3954, D => n5939, Q => 
                           REG_15_28_port);
   REG_reg_15_27_inst : DLH_X1 port map( G => n3954, D => n5938, Q => 
                           REG_15_27_port);
   REG_reg_15_26_inst : DLH_X1 port map( G => n3954, D => n5937, Q => 
                           REG_15_26_port);
   REG_reg_15_25_inst : DLH_X1 port map( G => n3954, D => n5936, Q => 
                           REG_15_25_port);
   REG_reg_15_24_inst : DLH_X1 port map( G => n3954, D => n5935, Q => 
                           REG_15_24_port);
   REG_reg_15_23_inst : DLH_X1 port map( G => n3954, D => n5934, Q => 
                           REG_15_23_port);
   REG_reg_15_22_inst : DLH_X1 port map( G => n3954, D => n5933, Q => 
                           REG_15_22_port);
   REG_reg_15_21_inst : DLH_X1 port map( G => n3954, D => n5932, Q => 
                           REG_15_21_port);
   REG_reg_15_20_inst : DLH_X1 port map( G => n3954, D => n5931, Q => 
                           REG_15_20_port);
   REG_reg_15_19_inst : DLH_X1 port map( G => n3954, D => n5930, Q => 
                           REG_15_19_port);
   REG_reg_15_18_inst : DLH_X1 port map( G => n3954, D => n5929, Q => 
                           REG_15_18_port);
   REG_reg_15_17_inst : DLH_X1 port map( G => n3954, D => n5928, Q => 
                           REG_15_17_port);
   REG_reg_15_16_inst : DLH_X1 port map( G => n3954, D => n5927, Q => 
                           REG_15_16_port);
   REG_reg_15_15_inst : DLH_X1 port map( G => n3954, D => n5926, Q => 
                           REG_15_15_port);
   REG_reg_15_14_inst : DLH_X1 port map( G => n3954, D => n5925, Q => 
                           REG_15_14_port);
   REG_reg_15_13_inst : DLH_X1 port map( G => n3954, D => n5924, Q => 
                           REG_15_13_port);
   REG_reg_15_12_inst : DLH_X1 port map( G => n3954, D => n5923, Q => 
                           REG_15_12_port);
   REG_reg_15_11_inst : DLH_X1 port map( G => n3954, D => n5922, Q => 
                           REG_15_11_port);
   REG_reg_15_10_inst : DLH_X1 port map( G => n3954, D => n5921, Q => 
                           REG_15_10_port);
   REG_reg_15_9_inst : DLH_X1 port map( G => n3954, D => n5920, Q => 
                           REG_15_9_port);
   REG_reg_15_8_inst : DLH_X1 port map( G => n3954, D => n5919, Q => 
                           REG_15_8_port);
   REG_reg_15_7_inst : DLH_X1 port map( G => n3954, D => n5918, Q => 
                           REG_15_7_port);
   REG_reg_15_6_inst : DLH_X1 port map( G => n3954, D => n5917, Q => 
                           REG_15_6_port);
   REG_reg_15_5_inst : DLH_X1 port map( G => n3954, D => n5916, Q => 
                           REG_15_5_port);
   REG_reg_15_4_inst : DLH_X1 port map( G => n3954, D => n5915, Q => 
                           REG_15_4_port);
   REG_reg_15_3_inst : DLH_X1 port map( G => n3954, D => n5914, Q => 
                           REG_15_3_port);
   REG_reg_15_2_inst : DLH_X1 port map( G => n3954, D => n5913, Q => 
                           REG_15_2_port);
   REG_reg_15_1_inst : DLH_X1 port map( G => n3954, D => n5912, Q => 
                           REG_15_1_port);
   REG_reg_15_0_inst : DLH_X1 port map( G => n3954, D => n5911, Q => 
                           REG_15_0_port);
   REG_reg_16_31_inst : DLH_X1 port map( G => n3956, D => n5942, Q => 
                           REG_16_31_port);
   REG_reg_16_30_inst : DLH_X1 port map( G => n3956, D => n5941, Q => 
                           REG_16_30_port);
   REG_reg_16_29_inst : DLH_X1 port map( G => n3956, D => n5940, Q => 
                           REG_16_29_port);
   REG_reg_16_28_inst : DLH_X1 port map( G => n3956, D => n5939, Q => 
                           REG_16_28_port);
   REG_reg_16_27_inst : DLH_X1 port map( G => n3956, D => n5938, Q => 
                           REG_16_27_port);
   REG_reg_16_26_inst : DLH_X1 port map( G => n3956, D => n5937, Q => 
                           REG_16_26_port);
   REG_reg_16_25_inst : DLH_X1 port map( G => n3956, D => n5936, Q => 
                           REG_16_25_port);
   REG_reg_16_24_inst : DLH_X1 port map( G => n3956, D => n5935, Q => 
                           REG_16_24_port);
   REG_reg_16_23_inst : DLH_X1 port map( G => n3956, D => n5934, Q => 
                           REG_16_23_port);
   REG_reg_16_22_inst : DLH_X1 port map( G => n3956, D => n5933, Q => 
                           REG_16_22_port);
   REG_reg_16_21_inst : DLH_X1 port map( G => n3956, D => n5932, Q => 
                           REG_16_21_port);
   REG_reg_16_20_inst : DLH_X1 port map( G => n3956, D => n5931, Q => 
                           REG_16_20_port);
   REG_reg_16_19_inst : DLH_X1 port map( G => n3956, D => n5930, Q => 
                           REG_16_19_port);
   REG_reg_16_18_inst : DLH_X1 port map( G => n3956, D => n5929, Q => 
                           REG_16_18_port);
   REG_reg_16_17_inst : DLH_X1 port map( G => n3956, D => n5928, Q => 
                           REG_16_17_port);
   REG_reg_16_16_inst : DLH_X1 port map( G => n3956, D => n5927, Q => 
                           REG_16_16_port);
   REG_reg_16_15_inst : DLH_X1 port map( G => n3956, D => n5926, Q => 
                           REG_16_15_port);
   REG_reg_16_14_inst : DLH_X1 port map( G => n3956, D => n5925, Q => 
                           REG_16_14_port);
   REG_reg_16_13_inst : DLH_X1 port map( G => n3956, D => n5924, Q => 
                           REG_16_13_port);
   REG_reg_16_12_inst : DLH_X1 port map( G => n3956, D => n5923, Q => 
                           REG_16_12_port);
   REG_reg_16_11_inst : DLH_X1 port map( G => n3956, D => n5922, Q => 
                           REG_16_11_port);
   REG_reg_16_10_inst : DLH_X1 port map( G => n3956, D => n5921, Q => 
                           REG_16_10_port);
   REG_reg_16_9_inst : DLH_X1 port map( G => n3956, D => n5920, Q => 
                           REG_16_9_port);
   REG_reg_16_8_inst : DLH_X1 port map( G => n3956, D => n5919, Q => 
                           REG_16_8_port);
   REG_reg_16_7_inst : DLH_X1 port map( G => n3956, D => n5918, Q => 
                           REG_16_7_port);
   REG_reg_16_6_inst : DLH_X1 port map( G => n3956, D => n5917, Q => 
                           REG_16_6_port);
   REG_reg_16_5_inst : DLH_X1 port map( G => n3956, D => n5916, Q => 
                           REG_16_5_port);
   REG_reg_16_4_inst : DLH_X1 port map( G => n3956, D => n5915, Q => 
                           REG_16_4_port);
   REG_reg_16_3_inst : DLH_X1 port map( G => n3956, D => n5914, Q => 
                           REG_16_3_port);
   REG_reg_16_2_inst : DLH_X1 port map( G => n3956, D => n5913, Q => 
                           REG_16_2_port);
   REG_reg_16_1_inst : DLH_X1 port map( G => n3956, D => n5912, Q => 
                           REG_16_1_port);
   REG_reg_16_0_inst : DLH_X1 port map( G => n3956, D => n5911, Q => 
                           REG_16_0_port);
   REG_reg_17_31_inst : DLH_X1 port map( G => n3958, D => n5942, Q => 
                           REG_17_31_port);
   REG_reg_17_30_inst : DLH_X1 port map( G => n3958, D => n5941, Q => 
                           REG_17_30_port);
   REG_reg_17_29_inst : DLH_X1 port map( G => n3958, D => n5940, Q => 
                           REG_17_29_port);
   REG_reg_17_28_inst : DLH_X1 port map( G => n3958, D => n5939, Q => 
                           REG_17_28_port);
   REG_reg_17_27_inst : DLH_X1 port map( G => n3958, D => n5938, Q => 
                           REG_17_27_port);
   REG_reg_17_26_inst : DLH_X1 port map( G => n3958, D => n5937, Q => 
                           REG_17_26_port);
   REG_reg_17_25_inst : DLH_X1 port map( G => n3958, D => n5936, Q => 
                           REG_17_25_port);
   REG_reg_17_24_inst : DLH_X1 port map( G => n3958, D => n5935, Q => 
                           REG_17_24_port);
   REG_reg_17_23_inst : DLH_X1 port map( G => n3958, D => n5934, Q => 
                           REG_17_23_port);
   REG_reg_17_22_inst : DLH_X1 port map( G => n3958, D => n5933, Q => 
                           REG_17_22_port);
   REG_reg_17_21_inst : DLH_X1 port map( G => n3958, D => n5932, Q => 
                           REG_17_21_port);
   REG_reg_17_20_inst : DLH_X1 port map( G => n3958, D => n5931, Q => 
                           REG_17_20_port);
   REG_reg_17_19_inst : DLH_X1 port map( G => n3958, D => n5930, Q => 
                           REG_17_19_port);
   REG_reg_17_18_inst : DLH_X1 port map( G => n3958, D => n5929, Q => 
                           REG_17_18_port);
   REG_reg_17_17_inst : DLH_X1 port map( G => n3958, D => n5928, Q => 
                           REG_17_17_port);
   REG_reg_17_16_inst : DLH_X1 port map( G => n3958, D => n5927, Q => 
                           REG_17_16_port);
   REG_reg_17_15_inst : DLH_X1 port map( G => n3958, D => n5926, Q => 
                           REG_17_15_port);
   REG_reg_17_14_inst : DLH_X1 port map( G => n3958, D => n5925, Q => 
                           REG_17_14_port);
   REG_reg_17_13_inst : DLH_X1 port map( G => n3958, D => n5924, Q => 
                           REG_17_13_port);
   REG_reg_17_12_inst : DLH_X1 port map( G => n3958, D => n5923, Q => 
                           REG_17_12_port);
   REG_reg_17_11_inst : DLH_X1 port map( G => n3958, D => n5922, Q => 
                           REG_17_11_port);
   REG_reg_17_10_inst : DLH_X1 port map( G => n3958, D => n5921, Q => 
                           REG_17_10_port);
   REG_reg_17_9_inst : DLH_X1 port map( G => n3958, D => n5920, Q => 
                           REG_17_9_port);
   REG_reg_17_8_inst : DLH_X1 port map( G => n3958, D => n5919, Q => 
                           REG_17_8_port);
   REG_reg_17_7_inst : DLH_X1 port map( G => n3958, D => n5918, Q => 
                           REG_17_7_port);
   REG_reg_17_6_inst : DLH_X1 port map( G => n3958, D => n5917, Q => 
                           REG_17_6_port);
   REG_reg_17_5_inst : DLH_X1 port map( G => n3958, D => n5916, Q => 
                           REG_17_5_port);
   REG_reg_17_4_inst : DLH_X1 port map( G => n3958, D => n5915, Q => 
                           REG_17_4_port);
   REG_reg_17_3_inst : DLH_X1 port map( G => n3958, D => n5914, Q => 
                           REG_17_3_port);
   REG_reg_17_2_inst : DLH_X1 port map( G => n3958, D => n5913, Q => 
                           REG_17_2_port);
   REG_reg_17_1_inst : DLH_X1 port map( G => n3958, D => n5912, Q => 
                           REG_17_1_port);
   REG_reg_17_0_inst : DLH_X1 port map( G => n3958, D => n5911, Q => 
                           REG_17_0_port);
   REG_reg_18_31_inst : DLH_X1 port map( G => n3960, D => n5942, Q => 
                           REG_18_31_port);
   REG_reg_18_30_inst : DLH_X1 port map( G => n3960, D => n5941, Q => 
                           REG_18_30_port);
   REG_reg_18_29_inst : DLH_X1 port map( G => n3960, D => n5940, Q => 
                           REG_18_29_port);
   REG_reg_18_28_inst : DLH_X1 port map( G => n3960, D => n5939, Q => 
                           REG_18_28_port);
   REG_reg_18_27_inst : DLH_X1 port map( G => n3960, D => n5938, Q => 
                           REG_18_27_port);
   REG_reg_18_26_inst : DLH_X1 port map( G => n3960, D => n5937, Q => 
                           REG_18_26_port);
   REG_reg_18_25_inst : DLH_X1 port map( G => n3960, D => n5936, Q => 
                           REG_18_25_port);
   REG_reg_18_24_inst : DLH_X1 port map( G => n3960, D => n5935, Q => 
                           REG_18_24_port);
   REG_reg_18_23_inst : DLH_X1 port map( G => n3960, D => n5934, Q => 
                           REG_18_23_port);
   REG_reg_18_22_inst : DLH_X1 port map( G => n3960, D => n5933, Q => 
                           REG_18_22_port);
   REG_reg_18_21_inst : DLH_X1 port map( G => n3960, D => n5932, Q => 
                           REG_18_21_port);
   REG_reg_18_20_inst : DLH_X1 port map( G => n3960, D => n5931, Q => 
                           REG_18_20_port);
   REG_reg_18_19_inst : DLH_X1 port map( G => n3960, D => n5930, Q => 
                           REG_18_19_port);
   REG_reg_18_18_inst : DLH_X1 port map( G => n3960, D => n5929, Q => 
                           REG_18_18_port);
   REG_reg_18_17_inst : DLH_X1 port map( G => n3960, D => n5928, Q => 
                           REG_18_17_port);
   REG_reg_18_16_inst : DLH_X1 port map( G => n3960, D => n5927, Q => 
                           REG_18_16_port);
   REG_reg_18_15_inst : DLH_X1 port map( G => n3960, D => n5926, Q => 
                           REG_18_15_port);
   REG_reg_18_14_inst : DLH_X1 port map( G => n3960, D => n5925, Q => 
                           REG_18_14_port);
   REG_reg_18_13_inst : DLH_X1 port map( G => n3960, D => n5924, Q => 
                           REG_18_13_port);
   REG_reg_18_12_inst : DLH_X1 port map( G => n3960, D => n5923, Q => 
                           REG_18_12_port);
   REG_reg_18_11_inst : DLH_X1 port map( G => n3960, D => n5922, Q => 
                           REG_18_11_port);
   REG_reg_18_10_inst : DLH_X1 port map( G => n3960, D => n5921, Q => 
                           REG_18_10_port);
   REG_reg_18_9_inst : DLH_X1 port map( G => n3960, D => n5920, Q => 
                           REG_18_9_port);
   REG_reg_18_8_inst : DLH_X1 port map( G => n3960, D => n5919, Q => 
                           REG_18_8_port);
   REG_reg_18_7_inst : DLH_X1 port map( G => n3960, D => n5918, Q => 
                           REG_18_7_port);
   REG_reg_18_6_inst : DLH_X1 port map( G => n3960, D => n5917, Q => 
                           REG_18_6_port);
   REG_reg_18_5_inst : DLH_X1 port map( G => n3960, D => n5916, Q => 
                           REG_18_5_port);
   REG_reg_18_4_inst : DLH_X1 port map( G => n3960, D => n5915, Q => 
                           REG_18_4_port);
   REG_reg_18_3_inst : DLH_X1 port map( G => n3960, D => n5914, Q => 
                           REG_18_3_port);
   REG_reg_18_2_inst : DLH_X1 port map( G => n3960, D => n5913, Q => 
                           REG_18_2_port);
   REG_reg_18_1_inst : DLH_X1 port map( G => n3960, D => n5912, Q => 
                           REG_18_1_port);
   REG_reg_18_0_inst : DLH_X1 port map( G => n3960, D => n5911, Q => 
                           REG_18_0_port);
   REG_reg_19_31_inst : DLH_X1 port map( G => n3962, D => n5942, Q => 
                           REG_19_31_port);
   REG_reg_19_30_inst : DLH_X1 port map( G => n3962, D => n5941, Q => 
                           REG_19_30_port);
   REG_reg_19_29_inst : DLH_X1 port map( G => n3962, D => n5940, Q => 
                           REG_19_29_port);
   REG_reg_19_28_inst : DLH_X1 port map( G => n3962, D => n5939, Q => 
                           REG_19_28_port);
   REG_reg_19_27_inst : DLH_X1 port map( G => n3962, D => n5938, Q => 
                           REG_19_27_port);
   REG_reg_19_26_inst : DLH_X1 port map( G => n3962, D => n5937, Q => 
                           REG_19_26_port);
   REG_reg_19_25_inst : DLH_X1 port map( G => n3962, D => n5936, Q => 
                           REG_19_25_port);
   REG_reg_19_24_inst : DLH_X1 port map( G => n3962, D => n5935, Q => 
                           REG_19_24_port);
   REG_reg_19_23_inst : DLH_X1 port map( G => n3962, D => n5934, Q => 
                           REG_19_23_port);
   REG_reg_19_22_inst : DLH_X1 port map( G => n3962, D => n5933, Q => 
                           REG_19_22_port);
   REG_reg_19_21_inst : DLH_X1 port map( G => n3962, D => n5932, Q => 
                           REG_19_21_port);
   REG_reg_19_20_inst : DLH_X1 port map( G => n3962, D => n5931, Q => 
                           REG_19_20_port);
   REG_reg_19_19_inst : DLH_X1 port map( G => n3962, D => n5930, Q => 
                           REG_19_19_port);
   REG_reg_19_18_inst : DLH_X1 port map( G => n3962, D => n5929, Q => 
                           REG_19_18_port);
   REG_reg_19_17_inst : DLH_X1 port map( G => n3962, D => n5928, Q => 
                           REG_19_17_port);
   REG_reg_19_16_inst : DLH_X1 port map( G => n3962, D => n5927, Q => 
                           REG_19_16_port);
   REG_reg_19_15_inst : DLH_X1 port map( G => n3962, D => n5926, Q => 
                           REG_19_15_port);
   REG_reg_19_14_inst : DLH_X1 port map( G => n3962, D => n5925, Q => 
                           REG_19_14_port);
   REG_reg_19_13_inst : DLH_X1 port map( G => n3962, D => n5924, Q => 
                           REG_19_13_port);
   REG_reg_19_12_inst : DLH_X1 port map( G => n3962, D => n5923, Q => 
                           REG_19_12_port);
   REG_reg_19_11_inst : DLH_X1 port map( G => n3962, D => n5922, Q => 
                           REG_19_11_port);
   REG_reg_19_10_inst : DLH_X1 port map( G => n3962, D => n5921, Q => 
                           REG_19_10_port);
   REG_reg_19_9_inst : DLH_X1 port map( G => n3962, D => n5920, Q => 
                           REG_19_9_port);
   REG_reg_19_8_inst : DLH_X1 port map( G => n3962, D => n5919, Q => 
                           REG_19_8_port);
   REG_reg_19_7_inst : DLH_X1 port map( G => n3962, D => n5918, Q => 
                           REG_19_7_port);
   REG_reg_19_6_inst : DLH_X1 port map( G => n3962, D => n5917, Q => 
                           REG_19_6_port);
   REG_reg_19_5_inst : DLH_X1 port map( G => n3962, D => n5916, Q => 
                           REG_19_5_port);
   REG_reg_19_4_inst : DLH_X1 port map( G => n3962, D => n5915, Q => 
                           REG_19_4_port);
   REG_reg_19_3_inst : DLH_X1 port map( G => n3962, D => n5914, Q => 
                           REG_19_3_port);
   REG_reg_19_2_inst : DLH_X1 port map( G => n3962, D => n5913, Q => 
                           REG_19_2_port);
   REG_reg_19_1_inst : DLH_X1 port map( G => n3962, D => n5912, Q => 
                           REG_19_1_port);
   REG_reg_19_0_inst : DLH_X1 port map( G => n3962, D => n5911, Q => 
                           REG_19_0_port);
   REG_reg_20_31_inst : DLH_X1 port map( G => n3964, D => n5942, Q => 
                           REG_20_31_port);
   REG_reg_20_30_inst : DLH_X1 port map( G => n3964, D => n5941, Q => 
                           REG_20_30_port);
   REG_reg_20_29_inst : DLH_X1 port map( G => n3964, D => n5940, Q => 
                           REG_20_29_port);
   REG_reg_20_28_inst : DLH_X1 port map( G => n3964, D => n5939, Q => 
                           REG_20_28_port);
   REG_reg_20_27_inst : DLH_X1 port map( G => n3964, D => n5938, Q => 
                           REG_20_27_port);
   REG_reg_20_26_inst : DLH_X1 port map( G => n3964, D => n5937, Q => 
                           REG_20_26_port);
   REG_reg_20_25_inst : DLH_X1 port map( G => n3964, D => n5936, Q => 
                           REG_20_25_port);
   REG_reg_20_24_inst : DLH_X1 port map( G => n3964, D => n5935, Q => 
                           REG_20_24_port);
   REG_reg_20_23_inst : DLH_X1 port map( G => n3964, D => n5934, Q => 
                           REG_20_23_port);
   REG_reg_20_22_inst : DLH_X1 port map( G => n3964, D => n5933, Q => 
                           REG_20_22_port);
   REG_reg_20_21_inst : DLH_X1 port map( G => n3964, D => n5932, Q => 
                           REG_20_21_port);
   REG_reg_20_20_inst : DLH_X1 port map( G => n3964, D => n5931, Q => 
                           REG_20_20_port);
   REG_reg_20_19_inst : DLH_X1 port map( G => n3964, D => n5930, Q => 
                           REG_20_19_port);
   REG_reg_20_18_inst : DLH_X1 port map( G => n3964, D => n5929, Q => 
                           REG_20_18_port);
   REG_reg_20_17_inst : DLH_X1 port map( G => n3964, D => n5928, Q => 
                           REG_20_17_port);
   REG_reg_20_16_inst : DLH_X1 port map( G => n3964, D => n5927, Q => 
                           REG_20_16_port);
   REG_reg_20_15_inst : DLH_X1 port map( G => n3964, D => n5926, Q => 
                           REG_20_15_port);
   REG_reg_20_14_inst : DLH_X1 port map( G => n3964, D => n5925, Q => 
                           REG_20_14_port);
   REG_reg_20_13_inst : DLH_X1 port map( G => n3964, D => n5924, Q => 
                           REG_20_13_port);
   REG_reg_20_12_inst : DLH_X1 port map( G => n3964, D => n5923, Q => 
                           REG_20_12_port);
   REG_reg_20_11_inst : DLH_X1 port map( G => n3964, D => n5922, Q => 
                           REG_20_11_port);
   REG_reg_20_10_inst : DLH_X1 port map( G => n3964, D => n5921, Q => 
                           REG_20_10_port);
   REG_reg_20_9_inst : DLH_X1 port map( G => n3964, D => n5920, Q => 
                           REG_20_9_port);
   REG_reg_20_8_inst : DLH_X1 port map( G => n3964, D => n5919, Q => 
                           REG_20_8_port);
   REG_reg_20_7_inst : DLH_X1 port map( G => n3964, D => n5918, Q => 
                           REG_20_7_port);
   REG_reg_20_6_inst : DLH_X1 port map( G => n3964, D => n5917, Q => 
                           REG_20_6_port);
   REG_reg_20_5_inst : DLH_X1 port map( G => n3964, D => n5916, Q => 
                           REG_20_5_port);
   REG_reg_20_4_inst : DLH_X1 port map( G => n3964, D => n5915, Q => 
                           REG_20_4_port);
   REG_reg_20_3_inst : DLH_X1 port map( G => n3964, D => n5914, Q => 
                           REG_20_3_port);
   REG_reg_20_2_inst : DLH_X1 port map( G => n3964, D => n5913, Q => 
                           REG_20_2_port);
   REG_reg_20_1_inst : DLH_X1 port map( G => n3964, D => n5912, Q => 
                           REG_20_1_port);
   REG_reg_20_0_inst : DLH_X1 port map( G => n3964, D => n5911, Q => 
                           REG_20_0_port);
   REG_reg_21_31_inst : DLH_X1 port map( G => n3966, D => n5942, Q => 
                           REG_21_31_port);
   REG_reg_21_30_inst : DLH_X1 port map( G => n3966, D => n5941, Q => 
                           REG_21_30_port);
   REG_reg_21_29_inst : DLH_X1 port map( G => n3966, D => n5940, Q => 
                           REG_21_29_port);
   REG_reg_21_28_inst : DLH_X1 port map( G => n3966, D => n5939, Q => 
                           REG_21_28_port);
   REG_reg_21_27_inst : DLH_X1 port map( G => n3966, D => n5938, Q => 
                           REG_21_27_port);
   REG_reg_21_26_inst : DLH_X1 port map( G => n3966, D => n5937, Q => 
                           REG_21_26_port);
   REG_reg_21_25_inst : DLH_X1 port map( G => n3966, D => n5936, Q => 
                           REG_21_25_port);
   REG_reg_21_24_inst : DLH_X1 port map( G => n3966, D => n5935, Q => 
                           REG_21_24_port);
   REG_reg_21_23_inst : DLH_X1 port map( G => n3966, D => n5934, Q => 
                           REG_21_23_port);
   REG_reg_21_22_inst : DLH_X1 port map( G => n3966, D => n5933, Q => 
                           REG_21_22_port);
   REG_reg_21_21_inst : DLH_X1 port map( G => n3966, D => n5932, Q => 
                           REG_21_21_port);
   REG_reg_21_20_inst : DLH_X1 port map( G => n3966, D => n5931, Q => 
                           REG_21_20_port);
   REG_reg_21_19_inst : DLH_X1 port map( G => n3966, D => n5930, Q => 
                           REG_21_19_port);
   REG_reg_21_18_inst : DLH_X1 port map( G => n3966, D => n5929, Q => 
                           REG_21_18_port);
   REG_reg_21_17_inst : DLH_X1 port map( G => n3966, D => n5928, Q => 
                           REG_21_17_port);
   REG_reg_21_16_inst : DLH_X1 port map( G => n3966, D => n5927, Q => 
                           REG_21_16_port);
   REG_reg_21_15_inst : DLH_X1 port map( G => n3966, D => n5926, Q => 
                           REG_21_15_port);
   REG_reg_21_14_inst : DLH_X1 port map( G => n3966, D => n5925, Q => 
                           REG_21_14_port);
   REG_reg_21_13_inst : DLH_X1 port map( G => n3966, D => n5924, Q => 
                           REG_21_13_port);
   REG_reg_21_12_inst : DLH_X1 port map( G => n3966, D => n5923, Q => 
                           REG_21_12_port);
   REG_reg_21_11_inst : DLH_X1 port map( G => n3966, D => n5922, Q => 
                           REG_21_11_port);
   REG_reg_21_10_inst : DLH_X1 port map( G => n3966, D => n5921, Q => 
                           REG_21_10_port);
   REG_reg_21_9_inst : DLH_X1 port map( G => n3966, D => n5920, Q => 
                           REG_21_9_port);
   REG_reg_21_8_inst : DLH_X1 port map( G => n3966, D => n5919, Q => 
                           REG_21_8_port);
   REG_reg_21_7_inst : DLH_X1 port map( G => n3966, D => n5918, Q => 
                           REG_21_7_port);
   REG_reg_21_6_inst : DLH_X1 port map( G => n3966, D => n5917, Q => 
                           REG_21_6_port);
   REG_reg_21_5_inst : DLH_X1 port map( G => n3966, D => n5916, Q => 
                           REG_21_5_port);
   REG_reg_21_4_inst : DLH_X1 port map( G => n3966, D => n5915, Q => 
                           REG_21_4_port);
   REG_reg_21_3_inst : DLH_X1 port map( G => n3966, D => n5914, Q => 
                           REG_21_3_port);
   REG_reg_21_2_inst : DLH_X1 port map( G => n3966, D => n5913, Q => 
                           REG_21_2_port);
   REG_reg_21_1_inst : DLH_X1 port map( G => n3966, D => n5912, Q => 
                           REG_21_1_port);
   REG_reg_21_0_inst : DLH_X1 port map( G => n3966, D => n5911, Q => 
                           REG_21_0_port);
   REG_reg_22_31_inst : DLH_X1 port map( G => n3968, D => n5942, Q => 
                           REG_22_31_port);
   REG_reg_22_30_inst : DLH_X1 port map( G => n3968, D => n5941, Q => 
                           REG_22_30_port);
   REG_reg_22_29_inst : DLH_X1 port map( G => n3968, D => n5940, Q => 
                           REG_22_29_port);
   REG_reg_22_28_inst : DLH_X1 port map( G => n3968, D => n5939, Q => 
                           REG_22_28_port);
   REG_reg_22_27_inst : DLH_X1 port map( G => n3968, D => n5938, Q => 
                           REG_22_27_port);
   REG_reg_22_26_inst : DLH_X1 port map( G => n3968, D => n5937, Q => 
                           REG_22_26_port);
   REG_reg_22_25_inst : DLH_X1 port map( G => n3968, D => n5936, Q => 
                           REG_22_25_port);
   REG_reg_22_24_inst : DLH_X1 port map( G => n3968, D => n5935, Q => 
                           REG_22_24_port);
   REG_reg_22_23_inst : DLH_X1 port map( G => n3968, D => n5934, Q => 
                           REG_22_23_port);
   REG_reg_22_22_inst : DLH_X1 port map( G => n3968, D => n5933, Q => 
                           REG_22_22_port);
   REG_reg_22_21_inst : DLH_X1 port map( G => n3968, D => n5932, Q => 
                           REG_22_21_port);
   REG_reg_22_20_inst : DLH_X1 port map( G => n3968, D => n5931, Q => 
                           REG_22_20_port);
   REG_reg_22_19_inst : DLH_X1 port map( G => n3968, D => n5930, Q => 
                           REG_22_19_port);
   REG_reg_22_18_inst : DLH_X1 port map( G => n3968, D => n5929, Q => 
                           REG_22_18_port);
   REG_reg_22_17_inst : DLH_X1 port map( G => n3968, D => n5928, Q => 
                           REG_22_17_port);
   REG_reg_22_16_inst : DLH_X1 port map( G => n3968, D => n5927, Q => 
                           REG_22_16_port);
   REG_reg_22_15_inst : DLH_X1 port map( G => n3968, D => n5926, Q => 
                           REG_22_15_port);
   REG_reg_22_14_inst : DLH_X1 port map( G => n3968, D => n5925, Q => 
                           REG_22_14_port);
   REG_reg_22_13_inst : DLH_X1 port map( G => n3968, D => n5924, Q => 
                           REG_22_13_port);
   REG_reg_22_12_inst : DLH_X1 port map( G => n3968, D => n5923, Q => 
                           REG_22_12_port);
   REG_reg_22_11_inst : DLH_X1 port map( G => n3968, D => n5922, Q => 
                           REG_22_11_port);
   REG_reg_22_10_inst : DLH_X1 port map( G => n3968, D => n5921, Q => 
                           REG_22_10_port);
   REG_reg_22_9_inst : DLH_X1 port map( G => n3968, D => n5920, Q => 
                           REG_22_9_port);
   REG_reg_22_8_inst : DLH_X1 port map( G => n3968, D => n5919, Q => 
                           REG_22_8_port);
   REG_reg_22_7_inst : DLH_X1 port map( G => n3968, D => n5918, Q => 
                           REG_22_7_port);
   REG_reg_22_6_inst : DLH_X1 port map( G => n3968, D => n5917, Q => 
                           REG_22_6_port);
   REG_reg_22_5_inst : DLH_X1 port map( G => n3968, D => n5916, Q => 
                           REG_22_5_port);
   REG_reg_22_4_inst : DLH_X1 port map( G => n3968, D => n5915, Q => 
                           REG_22_4_port);
   REG_reg_22_3_inst : DLH_X1 port map( G => n3968, D => n5914, Q => 
                           REG_22_3_port);
   REG_reg_22_2_inst : DLH_X1 port map( G => n3968, D => n5913, Q => 
                           REG_22_2_port);
   REG_reg_22_1_inst : DLH_X1 port map( G => n3968, D => n5912, Q => 
                           REG_22_1_port);
   REG_reg_22_0_inst : DLH_X1 port map( G => n3968, D => n5911, Q => 
                           REG_22_0_port);
   REG_reg_23_31_inst : DLH_X1 port map( G => n3970, D => n5942, Q => 
                           REG_23_31_port);
   REG_reg_23_30_inst : DLH_X1 port map( G => n3970, D => n5941, Q => 
                           REG_23_30_port);
   REG_reg_23_29_inst : DLH_X1 port map( G => n3970, D => n5940, Q => 
                           REG_23_29_port);
   REG_reg_23_28_inst : DLH_X1 port map( G => n3970, D => n5939, Q => 
                           REG_23_28_port);
   REG_reg_23_27_inst : DLH_X1 port map( G => n3970, D => n5938, Q => 
                           REG_23_27_port);
   REG_reg_23_26_inst : DLH_X1 port map( G => n3970, D => n5937, Q => 
                           REG_23_26_port);
   REG_reg_23_25_inst : DLH_X1 port map( G => n3970, D => n5936, Q => 
                           REG_23_25_port);
   REG_reg_23_24_inst : DLH_X1 port map( G => n3970, D => n5935, Q => 
                           REG_23_24_port);
   REG_reg_23_23_inst : DLH_X1 port map( G => n3970, D => n5934, Q => 
                           REG_23_23_port);
   REG_reg_23_22_inst : DLH_X1 port map( G => n3970, D => n5933, Q => 
                           REG_23_22_port);
   REG_reg_23_21_inst : DLH_X1 port map( G => n3970, D => n5932, Q => 
                           REG_23_21_port);
   REG_reg_23_20_inst : DLH_X1 port map( G => n3970, D => n5931, Q => 
                           REG_23_20_port);
   REG_reg_23_19_inst : DLH_X1 port map( G => n3970, D => n5930, Q => 
                           REG_23_19_port);
   REG_reg_23_18_inst : DLH_X1 port map( G => n3970, D => n5929, Q => 
                           REG_23_18_port);
   REG_reg_23_17_inst : DLH_X1 port map( G => n3970, D => n5928, Q => 
                           REG_23_17_port);
   REG_reg_23_16_inst : DLH_X1 port map( G => n3970, D => n5927, Q => 
                           REG_23_16_port);
   REG_reg_23_15_inst : DLH_X1 port map( G => n3970, D => n5926, Q => 
                           REG_23_15_port);
   REG_reg_23_14_inst : DLH_X1 port map( G => n3970, D => n5925, Q => 
                           REG_23_14_port);
   REG_reg_23_13_inst : DLH_X1 port map( G => n3970, D => n5924, Q => 
                           REG_23_13_port);
   REG_reg_23_12_inst : DLH_X1 port map( G => n3970, D => n5923, Q => 
                           REG_23_12_port);
   REG_reg_23_11_inst : DLH_X1 port map( G => n3970, D => n5922, Q => 
                           REG_23_11_port);
   REG_reg_23_10_inst : DLH_X1 port map( G => n3970, D => n5921, Q => 
                           REG_23_10_port);
   REG_reg_23_9_inst : DLH_X1 port map( G => n3970, D => n5920, Q => 
                           REG_23_9_port);
   REG_reg_23_8_inst : DLH_X1 port map( G => n3970, D => n5919, Q => 
                           REG_23_8_port);
   REG_reg_23_7_inst : DLH_X1 port map( G => n3970, D => n5918, Q => 
                           REG_23_7_port);
   REG_reg_23_6_inst : DLH_X1 port map( G => n3970, D => n5917, Q => 
                           REG_23_6_port);
   REG_reg_23_5_inst : DLH_X1 port map( G => n3970, D => n5916, Q => 
                           REG_23_5_port);
   REG_reg_23_4_inst : DLH_X1 port map( G => n3970, D => n5915, Q => 
                           REG_23_4_port);
   REG_reg_23_3_inst : DLH_X1 port map( G => n3970, D => n5914, Q => 
                           REG_23_3_port);
   REG_reg_23_2_inst : DLH_X1 port map( G => n3970, D => n5913, Q => 
                           REG_23_2_port);
   REG_reg_23_1_inst : DLH_X1 port map( G => n3970, D => n5912, Q => 
                           REG_23_1_port);
   REG_reg_23_0_inst : DLH_X1 port map( G => n3970, D => n5911, Q => 
                           REG_23_0_port);
   REG_reg_24_31_inst : DLH_X1 port map( G => n3972, D => n5942, Q => 
                           REG_24_31_port);
   REG_reg_24_30_inst : DLH_X1 port map( G => n3972, D => n5941, Q => 
                           REG_24_30_port);
   REG_reg_24_29_inst : DLH_X1 port map( G => n3972, D => n5940, Q => 
                           REG_24_29_port);
   REG_reg_24_28_inst : DLH_X1 port map( G => n3972, D => n5939, Q => 
                           REG_24_28_port);
   REG_reg_24_27_inst : DLH_X1 port map( G => n3972, D => n5938, Q => 
                           REG_24_27_port);
   REG_reg_24_26_inst : DLH_X1 port map( G => n3972, D => n5937, Q => 
                           REG_24_26_port);
   REG_reg_24_25_inst : DLH_X1 port map( G => n3972, D => n5936, Q => 
                           REG_24_25_port);
   REG_reg_24_24_inst : DLH_X1 port map( G => n3972, D => n5935, Q => 
                           REG_24_24_port);
   REG_reg_24_23_inst : DLH_X1 port map( G => n3972, D => n5934, Q => 
                           REG_24_23_port);
   REG_reg_24_22_inst : DLH_X1 port map( G => n3972, D => n5933, Q => 
                           REG_24_22_port);
   REG_reg_24_21_inst : DLH_X1 port map( G => n3972, D => n5932, Q => 
                           REG_24_21_port);
   REG_reg_24_20_inst : DLH_X1 port map( G => n3972, D => n5931, Q => 
                           REG_24_20_port);
   REG_reg_24_19_inst : DLH_X1 port map( G => n3972, D => n5930, Q => 
                           REG_24_19_port);
   REG_reg_24_18_inst : DLH_X1 port map( G => n3972, D => n5929, Q => 
                           REG_24_18_port);
   REG_reg_24_17_inst : DLH_X1 port map( G => n3972, D => n5928, Q => 
                           REG_24_17_port);
   REG_reg_24_16_inst : DLH_X1 port map( G => n3972, D => n5927, Q => 
                           REG_24_16_port);
   REG_reg_24_15_inst : DLH_X1 port map( G => n3972, D => n5926, Q => 
                           REG_24_15_port);
   REG_reg_24_14_inst : DLH_X1 port map( G => n3972, D => n5925, Q => 
                           REG_24_14_port);
   REG_reg_24_13_inst : DLH_X1 port map( G => n3972, D => n5924, Q => 
                           REG_24_13_port);
   REG_reg_24_12_inst : DLH_X1 port map( G => n3972, D => n5923, Q => 
                           REG_24_12_port);
   REG_reg_24_11_inst : DLH_X1 port map( G => n3972, D => n5922, Q => 
                           REG_24_11_port);
   REG_reg_24_10_inst : DLH_X1 port map( G => n3972, D => n5921, Q => 
                           REG_24_10_port);
   REG_reg_24_9_inst : DLH_X1 port map( G => n3972, D => n5920, Q => 
                           REG_24_9_port);
   REG_reg_24_8_inst : DLH_X1 port map( G => n3972, D => n5919, Q => 
                           REG_24_8_port);
   REG_reg_24_7_inst : DLH_X1 port map( G => n3972, D => n5918, Q => 
                           REG_24_7_port);
   REG_reg_24_6_inst : DLH_X1 port map( G => n3972, D => n5917, Q => 
                           REG_24_6_port);
   REG_reg_24_5_inst : DLH_X1 port map( G => n3972, D => n5916, Q => 
                           REG_24_5_port);
   REG_reg_24_4_inst : DLH_X1 port map( G => n3972, D => n5915, Q => 
                           REG_24_4_port);
   REG_reg_24_3_inst : DLH_X1 port map( G => n3972, D => n5914, Q => 
                           REG_24_3_port);
   REG_reg_24_2_inst : DLH_X1 port map( G => n3972, D => n5913, Q => 
                           REG_24_2_port);
   REG_reg_24_1_inst : DLH_X1 port map( G => n3972, D => n5912, Q => 
                           REG_24_1_port);
   REG_reg_24_0_inst : DLH_X1 port map( G => n3972, D => n5911, Q => 
                           REG_24_0_port);
   REG_reg_25_31_inst : DLH_X1 port map( G => n3974, D => n5942, Q => 
                           REG_25_31_port);
   REG_reg_25_30_inst : DLH_X1 port map( G => n3974, D => n5941, Q => 
                           REG_25_30_port);
   REG_reg_25_29_inst : DLH_X1 port map( G => n3974, D => n5940, Q => 
                           REG_25_29_port);
   REG_reg_25_28_inst : DLH_X1 port map( G => n3974, D => n5939, Q => 
                           REG_25_28_port);
   REG_reg_25_27_inst : DLH_X1 port map( G => n3974, D => n5938, Q => 
                           REG_25_27_port);
   REG_reg_25_26_inst : DLH_X1 port map( G => n3974, D => n5937, Q => 
                           REG_25_26_port);
   REG_reg_25_25_inst : DLH_X1 port map( G => n3974, D => n5936, Q => 
                           REG_25_25_port);
   REG_reg_25_24_inst : DLH_X1 port map( G => n3974, D => n5935, Q => 
                           REG_25_24_port);
   REG_reg_25_23_inst : DLH_X1 port map( G => n3974, D => n5934, Q => 
                           REG_25_23_port);
   REG_reg_25_22_inst : DLH_X1 port map( G => n3974, D => n5933, Q => 
                           REG_25_22_port);
   REG_reg_25_21_inst : DLH_X1 port map( G => n3974, D => n5932, Q => 
                           REG_25_21_port);
   REG_reg_25_20_inst : DLH_X1 port map( G => n3974, D => n5931, Q => 
                           REG_25_20_port);
   REG_reg_25_19_inst : DLH_X1 port map( G => n3974, D => n5930, Q => 
                           REG_25_19_port);
   REG_reg_25_18_inst : DLH_X1 port map( G => n3974, D => n5929, Q => 
                           REG_25_18_port);
   REG_reg_25_17_inst : DLH_X1 port map( G => n3974, D => n5928, Q => 
                           REG_25_17_port);
   REG_reg_25_16_inst : DLH_X1 port map( G => n3974, D => n5927, Q => 
                           REG_25_16_port);
   REG_reg_25_15_inst : DLH_X1 port map( G => n3974, D => n5926, Q => 
                           REG_25_15_port);
   REG_reg_25_14_inst : DLH_X1 port map( G => n3974, D => n5925, Q => 
                           REG_25_14_port);
   REG_reg_25_13_inst : DLH_X1 port map( G => n3974, D => n5924, Q => 
                           REG_25_13_port);
   REG_reg_25_12_inst : DLH_X1 port map( G => n3974, D => n5923, Q => 
                           REG_25_12_port);
   REG_reg_25_11_inst : DLH_X1 port map( G => n3974, D => n5922, Q => 
                           REG_25_11_port);
   REG_reg_25_10_inst : DLH_X1 port map( G => n3974, D => n5921, Q => 
                           REG_25_10_port);
   REG_reg_25_9_inst : DLH_X1 port map( G => n3974, D => n5920, Q => 
                           REG_25_9_port);
   REG_reg_25_8_inst : DLH_X1 port map( G => n3974, D => n5919, Q => 
                           REG_25_8_port);
   REG_reg_25_7_inst : DLH_X1 port map( G => n3974, D => n5918, Q => 
                           REG_25_7_port);
   REG_reg_25_6_inst : DLH_X1 port map( G => n3974, D => n5917, Q => 
                           REG_25_6_port);
   REG_reg_25_5_inst : DLH_X1 port map( G => n3974, D => n5916, Q => 
                           REG_25_5_port);
   REG_reg_25_4_inst : DLH_X1 port map( G => n3974, D => n5915, Q => 
                           REG_25_4_port);
   REG_reg_25_3_inst : DLH_X1 port map( G => n3974, D => n5914, Q => 
                           REG_25_3_port);
   REG_reg_25_2_inst : DLH_X1 port map( G => n3974, D => n5913, Q => 
                           REG_25_2_port);
   REG_reg_25_1_inst : DLH_X1 port map( G => n3974, D => n5912, Q => 
                           REG_25_1_port);
   REG_reg_25_0_inst : DLH_X1 port map( G => n3974, D => n5911, Q => 
                           REG_25_0_port);
   REG_reg_26_31_inst : DLH_X1 port map( G => n3976, D => n5942, Q => 
                           REG_26_31_port);
   REG_reg_26_30_inst : DLH_X1 port map( G => n3976, D => n5941, Q => 
                           REG_26_30_port);
   REG_reg_26_29_inst : DLH_X1 port map( G => n3976, D => n5940, Q => 
                           REG_26_29_port);
   REG_reg_26_28_inst : DLH_X1 port map( G => n3976, D => n5939, Q => 
                           REG_26_28_port);
   REG_reg_26_27_inst : DLH_X1 port map( G => n3976, D => n5938, Q => 
                           REG_26_27_port);
   REG_reg_26_26_inst : DLH_X1 port map( G => n3976, D => n5937, Q => 
                           REG_26_26_port);
   REG_reg_26_25_inst : DLH_X1 port map( G => n3976, D => n5936, Q => 
                           REG_26_25_port);
   REG_reg_26_24_inst : DLH_X1 port map( G => n3976, D => n5935, Q => 
                           REG_26_24_port);
   REG_reg_26_23_inst : DLH_X1 port map( G => n3976, D => n5934, Q => 
                           REG_26_23_port);
   REG_reg_26_22_inst : DLH_X1 port map( G => n3976, D => n5933, Q => 
                           REG_26_22_port);
   REG_reg_26_21_inst : DLH_X1 port map( G => n3976, D => n5932, Q => 
                           REG_26_21_port);
   REG_reg_26_20_inst : DLH_X1 port map( G => n3976, D => n5931, Q => 
                           REG_26_20_port);
   REG_reg_26_19_inst : DLH_X1 port map( G => n3976, D => n5930, Q => 
                           REG_26_19_port);
   REG_reg_26_18_inst : DLH_X1 port map( G => n3976, D => n5929, Q => 
                           REG_26_18_port);
   REG_reg_26_17_inst : DLH_X1 port map( G => n3976, D => n5928, Q => 
                           REG_26_17_port);
   REG_reg_26_16_inst : DLH_X1 port map( G => n3976, D => n5927, Q => 
                           REG_26_16_port);
   REG_reg_26_15_inst : DLH_X1 port map( G => n3976, D => n5926, Q => 
                           REG_26_15_port);
   REG_reg_26_14_inst : DLH_X1 port map( G => n3976, D => n5925, Q => 
                           REG_26_14_port);
   REG_reg_26_13_inst : DLH_X1 port map( G => n3976, D => n5924, Q => 
                           REG_26_13_port);
   REG_reg_26_12_inst : DLH_X1 port map( G => n3976, D => n5923, Q => 
                           REG_26_12_port);
   REG_reg_26_11_inst : DLH_X1 port map( G => n3976, D => n5922, Q => 
                           REG_26_11_port);
   REG_reg_26_10_inst : DLH_X1 port map( G => n3976, D => n5921, Q => 
                           REG_26_10_port);
   REG_reg_26_9_inst : DLH_X1 port map( G => n3976, D => n5920, Q => 
                           REG_26_9_port);
   REG_reg_26_8_inst : DLH_X1 port map( G => n3976, D => n5919, Q => 
                           REG_26_8_port);
   REG_reg_26_7_inst : DLH_X1 port map( G => n3976, D => n5918, Q => 
                           REG_26_7_port);
   REG_reg_26_6_inst : DLH_X1 port map( G => n3976, D => n5917, Q => 
                           REG_26_6_port);
   REG_reg_26_5_inst : DLH_X1 port map( G => n3976, D => n5916, Q => 
                           REG_26_5_port);
   REG_reg_26_4_inst : DLH_X1 port map( G => n3976, D => n5915, Q => 
                           REG_26_4_port);
   REG_reg_26_3_inst : DLH_X1 port map( G => n3976, D => n5914, Q => 
                           REG_26_3_port);
   REG_reg_26_2_inst : DLH_X1 port map( G => n3976, D => n5913, Q => 
                           REG_26_2_port);
   REG_reg_26_1_inst : DLH_X1 port map( G => n3976, D => n5912, Q => 
                           REG_26_1_port);
   REG_reg_26_0_inst : DLH_X1 port map( G => n3976, D => n5911, Q => 
                           REG_26_0_port);
   REG_reg_27_31_inst : DLH_X1 port map( G => n3978, D => n5942, Q => 
                           REG_27_31_port);
   REG_reg_27_30_inst : DLH_X1 port map( G => n3978, D => n5941, Q => 
                           REG_27_30_port);
   REG_reg_27_29_inst : DLH_X1 port map( G => n3978, D => n5940, Q => 
                           REG_27_29_port);
   REG_reg_27_28_inst : DLH_X1 port map( G => n3978, D => n5939, Q => 
                           REG_27_28_port);
   REG_reg_27_27_inst : DLH_X1 port map( G => n3978, D => n5938, Q => 
                           REG_27_27_port);
   REG_reg_27_26_inst : DLH_X1 port map( G => n3978, D => n5937, Q => 
                           REG_27_26_port);
   REG_reg_27_25_inst : DLH_X1 port map( G => n3978, D => n5936, Q => 
                           REG_27_25_port);
   REG_reg_27_24_inst : DLH_X1 port map( G => n3978, D => n5935, Q => 
                           REG_27_24_port);
   REG_reg_27_23_inst : DLH_X1 port map( G => n3978, D => n5934, Q => 
                           REG_27_23_port);
   REG_reg_27_22_inst : DLH_X1 port map( G => n3978, D => n5933, Q => 
                           REG_27_22_port);
   REG_reg_27_21_inst : DLH_X1 port map( G => n3978, D => n5932, Q => 
                           REG_27_21_port);
   REG_reg_27_20_inst : DLH_X1 port map( G => n3978, D => n5931, Q => 
                           REG_27_20_port);
   REG_reg_27_19_inst : DLH_X1 port map( G => n3978, D => n5930, Q => 
                           REG_27_19_port);
   REG_reg_27_18_inst : DLH_X1 port map( G => n3978, D => n5929, Q => 
                           REG_27_18_port);
   REG_reg_27_17_inst : DLH_X1 port map( G => n3978, D => n5928, Q => 
                           REG_27_17_port);
   REG_reg_27_16_inst : DLH_X1 port map( G => n3978, D => n5927, Q => 
                           REG_27_16_port);
   REG_reg_27_15_inst : DLH_X1 port map( G => n3978, D => n5926, Q => 
                           REG_27_15_port);
   REG_reg_27_14_inst : DLH_X1 port map( G => n3978, D => n5925, Q => 
                           REG_27_14_port);
   REG_reg_27_13_inst : DLH_X1 port map( G => n3978, D => n5924, Q => 
                           REG_27_13_port);
   REG_reg_27_12_inst : DLH_X1 port map( G => n3978, D => n5923, Q => 
                           REG_27_12_port);
   REG_reg_27_11_inst : DLH_X1 port map( G => n3978, D => n5922, Q => 
                           REG_27_11_port);
   REG_reg_27_10_inst : DLH_X1 port map( G => n3978, D => n5921, Q => 
                           REG_27_10_port);
   REG_reg_27_9_inst : DLH_X1 port map( G => n3978, D => n5920, Q => 
                           REG_27_9_port);
   REG_reg_27_8_inst : DLH_X1 port map( G => n3978, D => n5919, Q => 
                           REG_27_8_port);
   REG_reg_27_7_inst : DLH_X1 port map( G => n3978, D => n5918, Q => 
                           REG_27_7_port);
   REG_reg_27_6_inst : DLH_X1 port map( G => n3978, D => n5917, Q => 
                           REG_27_6_port);
   REG_reg_27_5_inst : DLH_X1 port map( G => n3978, D => n5916, Q => 
                           REG_27_5_port);
   REG_reg_27_4_inst : DLH_X1 port map( G => n3978, D => n5915, Q => 
                           REG_27_4_port);
   REG_reg_27_3_inst : DLH_X1 port map( G => n3978, D => n5914, Q => 
                           REG_27_3_port);
   REG_reg_27_2_inst : DLH_X1 port map( G => n3978, D => n5913, Q => 
                           REG_27_2_port);
   REG_reg_27_1_inst : DLH_X1 port map( G => n3978, D => n5912, Q => 
                           REG_27_1_port);
   REG_reg_27_0_inst : DLH_X1 port map( G => n3978, D => n5911, Q => 
                           REG_27_0_port);
   REG_reg_28_31_inst : DLH_X1 port map( G => n3980, D => n5942, Q => 
                           REG_28_31_port);
   REG_reg_28_30_inst : DLH_X1 port map( G => n3980, D => n5941, Q => 
                           REG_28_30_port);
   REG_reg_28_29_inst : DLH_X1 port map( G => n3980, D => n5940, Q => 
                           REG_28_29_port);
   REG_reg_28_28_inst : DLH_X1 port map( G => n3980, D => n5939, Q => 
                           REG_28_28_port);
   REG_reg_28_27_inst : DLH_X1 port map( G => n3980, D => n5938, Q => 
                           REG_28_27_port);
   REG_reg_28_26_inst : DLH_X1 port map( G => n3980, D => n5937, Q => 
                           REG_28_26_port);
   REG_reg_28_25_inst : DLH_X1 port map( G => n3980, D => n5936, Q => 
                           REG_28_25_port);
   REG_reg_28_24_inst : DLH_X1 port map( G => n3980, D => n5935, Q => 
                           REG_28_24_port);
   REG_reg_28_23_inst : DLH_X1 port map( G => n3980, D => n5934, Q => 
                           REG_28_23_port);
   REG_reg_28_22_inst : DLH_X1 port map( G => n3980, D => n5933, Q => 
                           REG_28_22_port);
   REG_reg_28_21_inst : DLH_X1 port map( G => n3980, D => n5932, Q => 
                           REG_28_21_port);
   REG_reg_28_20_inst : DLH_X1 port map( G => n3980, D => n5931, Q => 
                           REG_28_20_port);
   REG_reg_28_19_inst : DLH_X1 port map( G => n3980, D => n5930, Q => 
                           REG_28_19_port);
   REG_reg_28_18_inst : DLH_X1 port map( G => n3980, D => n5929, Q => 
                           REG_28_18_port);
   REG_reg_28_17_inst : DLH_X1 port map( G => n3980, D => n5928, Q => 
                           REG_28_17_port);
   REG_reg_28_16_inst : DLH_X1 port map( G => n3980, D => n5927, Q => 
                           REG_28_16_port);
   REG_reg_28_15_inst : DLH_X1 port map( G => n3980, D => n5926, Q => 
                           REG_28_15_port);
   REG_reg_28_14_inst : DLH_X1 port map( G => n3980, D => n5925, Q => 
                           REG_28_14_port);
   REG_reg_28_13_inst : DLH_X1 port map( G => n3980, D => n5924, Q => 
                           REG_28_13_port);
   REG_reg_28_12_inst : DLH_X1 port map( G => n3980, D => n5923, Q => 
                           REG_28_12_port);
   REG_reg_28_11_inst : DLH_X1 port map( G => n3980, D => n5922, Q => 
                           REG_28_11_port);
   REG_reg_28_10_inst : DLH_X1 port map( G => n3980, D => n5921, Q => 
                           REG_28_10_port);
   REG_reg_28_9_inst : DLH_X1 port map( G => n3980, D => n5920, Q => 
                           REG_28_9_port);
   REG_reg_28_8_inst : DLH_X1 port map( G => n3980, D => n5919, Q => 
                           REG_28_8_port);
   REG_reg_28_7_inst : DLH_X1 port map( G => n3980, D => n5918, Q => 
                           REG_28_7_port);
   REG_reg_28_6_inst : DLH_X1 port map( G => n3980, D => n5917, Q => 
                           REG_28_6_port);
   REG_reg_28_5_inst : DLH_X1 port map( G => n3980, D => n5916, Q => 
                           REG_28_5_port);
   REG_reg_28_4_inst : DLH_X1 port map( G => n3980, D => n5915, Q => 
                           REG_28_4_port);
   REG_reg_28_3_inst : DLH_X1 port map( G => n3980, D => n5914, Q => 
                           REG_28_3_port);
   REG_reg_28_2_inst : DLH_X1 port map( G => n3980, D => n5913, Q => 
                           REG_28_2_port);
   REG_reg_28_1_inst : DLH_X1 port map( G => n3980, D => n5912, Q => 
                           REG_28_1_port);
   REG_reg_28_0_inst : DLH_X1 port map( G => n3980, D => n5911, Q => 
                           REG_28_0_port);
   REG_reg_29_31_inst : DLH_X1 port map( G => n3982, D => n5942, Q => 
                           REG_29_31_port);
   REG_reg_29_30_inst : DLH_X1 port map( G => n3982, D => n5941, Q => 
                           REG_29_30_port);
   REG_reg_29_29_inst : DLH_X1 port map( G => n3982, D => n5940, Q => 
                           REG_29_29_port);
   REG_reg_29_28_inst : DLH_X1 port map( G => n3982, D => n5939, Q => 
                           REG_29_28_port);
   REG_reg_29_27_inst : DLH_X1 port map( G => n3982, D => n5938, Q => 
                           REG_29_27_port);
   REG_reg_29_26_inst : DLH_X1 port map( G => n3982, D => n5937, Q => 
                           REG_29_26_port);
   REG_reg_29_25_inst : DLH_X1 port map( G => n3982, D => n5936, Q => 
                           REG_29_25_port);
   REG_reg_29_24_inst : DLH_X1 port map( G => n3982, D => n5935, Q => 
                           REG_29_24_port);
   REG_reg_29_23_inst : DLH_X1 port map( G => n3982, D => n5934, Q => 
                           REG_29_23_port);
   REG_reg_29_22_inst : DLH_X1 port map( G => n3982, D => n5933, Q => 
                           REG_29_22_port);
   REG_reg_29_21_inst : DLH_X1 port map( G => n3982, D => n5932, Q => 
                           REG_29_21_port);
   REG_reg_29_20_inst : DLH_X1 port map( G => n3982, D => n5931, Q => 
                           REG_29_20_port);
   REG_reg_29_19_inst : DLH_X1 port map( G => n3982, D => n5930, Q => 
                           REG_29_19_port);
   REG_reg_29_18_inst : DLH_X1 port map( G => n3982, D => n5929, Q => 
                           REG_29_18_port);
   REG_reg_29_17_inst : DLH_X1 port map( G => n3982, D => n5928, Q => 
                           REG_29_17_port);
   REG_reg_29_16_inst : DLH_X1 port map( G => n3982, D => n5927, Q => 
                           REG_29_16_port);
   REG_reg_29_15_inst : DLH_X1 port map( G => n3982, D => n5926, Q => 
                           REG_29_15_port);
   REG_reg_29_14_inst : DLH_X1 port map( G => n3982, D => n5925, Q => 
                           REG_29_14_port);
   REG_reg_29_13_inst : DLH_X1 port map( G => n3982, D => n5924, Q => 
                           REG_29_13_port);
   REG_reg_29_12_inst : DLH_X1 port map( G => n3982, D => n5923, Q => 
                           REG_29_12_port);
   REG_reg_29_11_inst : DLH_X1 port map( G => n3982, D => n5922, Q => 
                           REG_29_11_port);
   REG_reg_29_10_inst : DLH_X1 port map( G => n3982, D => n5921, Q => 
                           REG_29_10_port);
   REG_reg_29_9_inst : DLH_X1 port map( G => n3982, D => n5920, Q => 
                           REG_29_9_port);
   REG_reg_29_8_inst : DLH_X1 port map( G => n3982, D => n5919, Q => 
                           REG_29_8_port);
   REG_reg_29_7_inst : DLH_X1 port map( G => n3982, D => n5918, Q => 
                           REG_29_7_port);
   REG_reg_29_6_inst : DLH_X1 port map( G => n3982, D => n5917, Q => 
                           REG_29_6_port);
   REG_reg_29_5_inst : DLH_X1 port map( G => n3982, D => n5916, Q => 
                           REG_29_5_port);
   REG_reg_29_4_inst : DLH_X1 port map( G => n3982, D => n5915, Q => 
                           REG_29_4_port);
   REG_reg_29_3_inst : DLH_X1 port map( G => n3982, D => n5914, Q => 
                           REG_29_3_port);
   REG_reg_29_2_inst : DLH_X1 port map( G => n3982, D => n5913, Q => 
                           REG_29_2_port);
   REG_reg_29_1_inst : DLH_X1 port map( G => n3982, D => n5912, Q => 
                           REG_29_1_port);
   REG_reg_29_0_inst : DLH_X1 port map( G => n3982, D => n5911, Q => 
                           REG_29_0_port);
   REG_reg_30_31_inst : DLH_X1 port map( G => n3984, D => n5942, Q => 
                           REG_30_31_port);
   REG_reg_30_30_inst : DLH_X1 port map( G => n3984, D => n5941, Q => 
                           REG_30_30_port);
   REG_reg_30_29_inst : DLH_X1 port map( G => n3984, D => n5940, Q => 
                           REG_30_29_port);
   REG_reg_30_28_inst : DLH_X1 port map( G => n3984, D => n5939, Q => 
                           REG_30_28_port);
   REG_reg_30_27_inst : DLH_X1 port map( G => n3984, D => n5938, Q => 
                           REG_30_27_port);
   REG_reg_30_26_inst : DLH_X1 port map( G => n3984, D => n5937, Q => 
                           REG_30_26_port);
   REG_reg_30_25_inst : DLH_X1 port map( G => n3984, D => n5936, Q => 
                           REG_30_25_port);
   REG_reg_30_24_inst : DLH_X1 port map( G => n3984, D => n5935, Q => 
                           REG_30_24_port);
   REG_reg_30_23_inst : DLH_X1 port map( G => n3984, D => n5934, Q => 
                           REG_30_23_port);
   REG_reg_30_22_inst : DLH_X1 port map( G => n3984, D => n5933, Q => 
                           REG_30_22_port);
   REG_reg_30_21_inst : DLH_X1 port map( G => n3984, D => n5932, Q => 
                           REG_30_21_port);
   REG_reg_30_20_inst : DLH_X1 port map( G => n3984, D => n5931, Q => 
                           REG_30_20_port);
   REG_reg_30_19_inst : DLH_X1 port map( G => n3984, D => n5930, Q => 
                           REG_30_19_port);
   REG_reg_30_18_inst : DLH_X1 port map( G => n3984, D => n5929, Q => 
                           REG_30_18_port);
   REG_reg_30_17_inst : DLH_X1 port map( G => n3984, D => n5928, Q => 
                           REG_30_17_port);
   REG_reg_30_16_inst : DLH_X1 port map( G => n3984, D => n5927, Q => 
                           REG_30_16_port);
   REG_reg_30_15_inst : DLH_X1 port map( G => n3984, D => n5926, Q => 
                           REG_30_15_port);
   REG_reg_30_14_inst : DLH_X1 port map( G => n3984, D => n5925, Q => 
                           REG_30_14_port);
   REG_reg_30_13_inst : DLH_X1 port map( G => n3984, D => n5924, Q => 
                           REG_30_13_port);
   REG_reg_30_12_inst : DLH_X1 port map( G => n3984, D => n5923, Q => 
                           REG_30_12_port);
   REG_reg_30_11_inst : DLH_X1 port map( G => n3984, D => n5922, Q => 
                           REG_30_11_port);
   REG_reg_30_10_inst : DLH_X1 port map( G => n3984, D => n5921, Q => 
                           REG_30_10_port);
   REG_reg_30_9_inst : DLH_X1 port map( G => n3984, D => n5920, Q => 
                           REG_30_9_port);
   REG_reg_30_8_inst : DLH_X1 port map( G => n3984, D => n5919, Q => 
                           REG_30_8_port);
   REG_reg_30_7_inst : DLH_X1 port map( G => n3984, D => n5918, Q => 
                           REG_30_7_port);
   REG_reg_30_6_inst : DLH_X1 port map( G => n3984, D => n5917, Q => 
                           REG_30_6_port);
   REG_reg_30_5_inst : DLH_X1 port map( G => n3984, D => n5916, Q => 
                           REG_30_5_port);
   REG_reg_30_4_inst : DLH_X1 port map( G => n3984, D => n5915, Q => 
                           REG_30_4_port);
   REG_reg_30_3_inst : DLH_X1 port map( G => n3984, D => n5914, Q => 
                           REG_30_3_port);
   REG_reg_30_2_inst : DLH_X1 port map( G => n3984, D => n5913, Q => 
                           REG_30_2_port);
   REG_reg_30_1_inst : DLH_X1 port map( G => n3984, D => n5912, Q => 
                           REG_30_1_port);
   REG_reg_30_0_inst : DLH_X1 port map( G => n3984, D => n5911, Q => 
                           REG_30_0_port);
   REG_reg_31_31_inst : DLH_X1 port map( G => n3986, D => N253, Q => 
                           REG_31_31_port);
   REG_reg_31_30_inst : DLH_X1 port map( G => n3986, D => N252, Q => 
                           REG_31_30_port);
   REG_reg_31_29_inst : DLH_X1 port map( G => n3986, D => N251, Q => 
                           REG_31_29_port);
   REG_reg_31_28_inst : DLH_X1 port map( G => n3986, D => N250, Q => 
                           REG_31_28_port);
   REG_reg_31_27_inst : DLH_X1 port map( G => n3986, D => N249, Q => 
                           REG_31_27_port);
   REG_reg_31_26_inst : DLH_X1 port map( G => n3986, D => N248, Q => 
                           REG_31_26_port);
   REG_reg_31_25_inst : DLH_X1 port map( G => n3986, D => N247, Q => 
                           REG_31_25_port);
   REG_reg_31_24_inst : DLH_X1 port map( G => n3986, D => N246, Q => 
                           REG_31_24_port);
   REG_reg_31_23_inst : DLH_X1 port map( G => n3986, D => N245, Q => 
                           REG_31_23_port);
   REG_reg_31_22_inst : DLH_X1 port map( G => n3986, D => N244, Q => 
                           REG_31_22_port);
   REG_reg_31_21_inst : DLH_X1 port map( G => n3986, D => N243, Q => 
                           REG_31_21_port);
   REG_reg_31_20_inst : DLH_X1 port map( G => n3986, D => N242, Q => 
                           REG_31_20_port);
   REG_reg_31_19_inst : DLH_X1 port map( G => n3986, D => N241, Q => 
                           REG_31_19_port);
   REG_reg_31_18_inst : DLH_X1 port map( G => n3986, D => N240, Q => 
                           REG_31_18_port);
   REG_reg_31_17_inst : DLH_X1 port map( G => n3986, D => N239, Q => 
                           REG_31_17_port);
   REG_reg_31_16_inst : DLH_X1 port map( G => n3986, D => N238, Q => 
                           REG_31_16_port);
   REG_reg_31_15_inst : DLH_X1 port map( G => n3986, D => N237, Q => 
                           REG_31_15_port);
   REG_reg_31_14_inst : DLH_X1 port map( G => n3986, D => N236, Q => 
                           REG_31_14_port);
   REG_reg_31_13_inst : DLH_X1 port map( G => n3986, D => N235, Q => 
                           REG_31_13_port);
   REG_reg_31_12_inst : DLH_X1 port map( G => n3986, D => N234, Q => 
                           REG_31_12_port);
   REG_reg_31_11_inst : DLH_X1 port map( G => n3986, D => N233, Q => 
                           REG_31_11_port);
   REG_reg_31_10_inst : DLH_X1 port map( G => n3986, D => N232, Q => 
                           REG_31_10_port);
   REG_reg_31_9_inst : DLH_X1 port map( G => n3986, D => N231, Q => 
                           REG_31_9_port);
   REG_reg_31_8_inst : DLH_X1 port map( G => n3986, D => N230, Q => 
                           REG_31_8_port);
   REG_reg_31_7_inst : DLH_X1 port map( G => n3986, D => N229, Q => 
                           REG_31_7_port);
   REG_reg_31_6_inst : DLH_X1 port map( G => n3986, D => N228, Q => 
                           REG_31_6_port);
   REG_reg_31_5_inst : DLH_X1 port map( G => n3986, D => N227, Q => 
                           REG_31_5_port);
   REG_reg_31_4_inst : DLH_X1 port map( G => n3986, D => N226, Q => 
                           REG_31_4_port);
   REG_reg_31_3_inst : DLH_X1 port map( G => n3986, D => N225, Q => 
                           REG_31_3_port);
   REG_reg_31_2_inst : DLH_X1 port map( G => n3986, D => N224, Q => 
                           REG_31_2_port);
   REG_reg_31_1_inst : DLH_X1 port map( G => n3986, D => N223, Q => 
                           REG_31_1_port);
   REG_reg_31_0_inst : DLH_X1 port map( G => n3986, D => N222, Q => 
                           REG_31_0_port);
   OUT2_reg_31_inst : DLH_X1 port map( G => N415, D => N382, Q => OUT2(31));
   OUT2_reg_30_inst : DLH_X1 port map( G => N415, D => N383, Q => OUT2(30));
   OUT2_reg_29_inst : DLH_X1 port map( G => N415, D => N384, Q => OUT2(29));
   OUT2_reg_28_inst : DLH_X1 port map( G => N415, D => N385, Q => OUT2(28));
   OUT2_reg_27_inst : DLH_X1 port map( G => N415, D => N386, Q => OUT2(27));
   OUT2_reg_26_inst : DLH_X1 port map( G => N415, D => N387, Q => OUT2(26));
   OUT2_reg_25_inst : DLH_X1 port map( G => N415, D => N388, Q => OUT2(25));
   OUT2_reg_24_inst : DLH_X1 port map( G => N415, D => N389, Q => OUT2(24));
   OUT2_reg_23_inst : DLH_X1 port map( G => N415, D => N390, Q => OUT2(23));
   OUT2_reg_22_inst : DLH_X1 port map( G => N415, D => N391, Q => OUT2(22));
   OUT2_reg_21_inst : DLH_X1 port map( G => N415, D => N392, Q => OUT2(21));
   OUT2_reg_20_inst : DLH_X1 port map( G => N415, D => N393, Q => OUT2(20));
   OUT2_reg_19_inst : DLH_X1 port map( G => N415, D => N394, Q => OUT2(19));
   OUT2_reg_18_inst : DLH_X1 port map( G => N415, D => N395, Q => OUT2(18));
   OUT2_reg_17_inst : DLH_X1 port map( G => N415, D => N396, Q => OUT2(17));
   OUT2_reg_16_inst : DLH_X1 port map( G => N415, D => N397, Q => OUT2(16));
   OUT2_reg_15_inst : DLH_X1 port map( G => N415, D => N398, Q => OUT2(15));
   OUT2_reg_14_inst : DLH_X1 port map( G => N415, D => N399, Q => OUT2(14));
   OUT2_reg_13_inst : DLH_X1 port map( G => N415, D => N400, Q => OUT2(13));
   OUT2_reg_12_inst : DLH_X1 port map( G => N415, D => N401, Q => OUT2(12));
   OUT2_reg_11_inst : DLH_X1 port map( G => N415, D => N402, Q => OUT2(11));
   OUT2_reg_10_inst : DLH_X1 port map( G => N415, D => N403, Q => OUT2(10));
   OUT2_reg_9_inst : DLH_X1 port map( G => N415, D => N404, Q => OUT2(9));
   OUT2_reg_8_inst : DLH_X1 port map( G => N415, D => N405, Q => OUT2(8));
   OUT2_reg_7_inst : DLH_X1 port map( G => N415, D => N406, Q => OUT2(7));
   OUT2_reg_6_inst : DLH_X1 port map( G => N415, D => N407, Q => OUT2(6));
   OUT2_reg_5_inst : DLH_X1 port map( G => N415, D => N408, Q => OUT2(5));
   OUT2_reg_4_inst : DLH_X1 port map( G => N415, D => N409, Q => OUT2(4));
   OUT2_reg_3_inst : DLH_X1 port map( G => N415, D => N410, Q => OUT2(3));
   OUT2_reg_2_inst : DLH_X1 port map( G => N415, D => N411, Q => OUT2(2));
   OUT2_reg_1_inst : DLH_X1 port map( G => N415, D => N412, Q => OUT2(1));
   OUT2_reg_0_inst : DLH_X1 port map( G => N415, D => N413, Q => OUT2(0));
   OUT1_reg_31_inst : DLH_X1 port map( G => N414, D => N350, Q => OUT1(31));
   OUT1_reg_30_inst : DLH_X1 port map( G => N414, D => N351, Q => OUT1(30));
   OUT1_reg_29_inst : DLH_X1 port map( G => N414, D => N352, Q => OUT1(29));
   OUT1_reg_28_inst : DLH_X1 port map( G => N414, D => N353, Q => OUT1(28));
   OUT1_reg_27_inst : DLH_X1 port map( G => N414, D => N354, Q => OUT1(27));
   OUT1_reg_26_inst : DLH_X1 port map( G => N414, D => N355, Q => OUT1(26));
   OUT1_reg_25_inst : DLH_X1 port map( G => N414, D => N356, Q => OUT1(25));
   OUT1_reg_24_inst : DLH_X1 port map( G => N414, D => N357, Q => OUT1(24));
   OUT1_reg_23_inst : DLH_X1 port map( G => N414, D => N358, Q => OUT1(23));
   OUT1_reg_22_inst : DLH_X1 port map( G => N414, D => N359, Q => OUT1(22));
   OUT1_reg_21_inst : DLH_X1 port map( G => N414, D => N360, Q => OUT1(21));
   OUT1_reg_20_inst : DLH_X1 port map( G => N414, D => N361, Q => OUT1(20));
   OUT1_reg_19_inst : DLH_X1 port map( G => N414, D => N362, Q => OUT1(19));
   OUT1_reg_18_inst : DLH_X1 port map( G => N414, D => N363, Q => OUT1(18));
   OUT1_reg_17_inst : DLH_X1 port map( G => N414, D => N364, Q => OUT1(17));
   OUT1_reg_16_inst : DLH_X1 port map( G => N414, D => N365, Q => OUT1(16));
   OUT1_reg_15_inst : DLH_X1 port map( G => N414, D => N366, Q => OUT1(15));
   OUT1_reg_14_inst : DLH_X1 port map( G => N414, D => N367, Q => OUT1(14));
   OUT1_reg_13_inst : DLH_X1 port map( G => N414, D => N368, Q => OUT1(13));
   OUT1_reg_12_inst : DLH_X1 port map( G => N414, D => N369, Q => OUT1(12));
   OUT1_reg_11_inst : DLH_X1 port map( G => N414, D => N370, Q => OUT1(11));
   OUT1_reg_10_inst : DLH_X1 port map( G => N414, D => N371, Q => OUT1(10));
   OUT1_reg_9_inst : DLH_X1 port map( G => N414, D => N372, Q => OUT1(9));
   OUT1_reg_8_inst : DLH_X1 port map( G => N414, D => N373, Q => OUT1(8));
   OUT1_reg_7_inst : DLH_X1 port map( G => N414, D => N374, Q => OUT1(7));
   OUT1_reg_6_inst : DLH_X1 port map( G => N414, D => N375, Q => OUT1(6));
   OUT1_reg_5_inst : DLH_X1 port map( G => N414, D => N376, Q => OUT1(5));
   OUT1_reg_4_inst : DLH_X1 port map( G => N414, D => N377, Q => OUT1(4));
   OUT1_reg_3_inst : DLH_X1 port map( G => N414, D => N378, Q => OUT1(3));
   OUT1_reg_2_inst : DLH_X1 port map( G => N414, D => N379, Q => OUT1(2));
   OUT1_reg_1_inst : DLH_X1 port map( G => N414, D => N380, Q => OUT1(1));
   OUT1_reg_0_inst : DLH_X1 port map( G => N414, D => N381, Q => OUT1(0));
   U3 : INV_X1 port map( A => N314, ZN => n3923);
   U4 : INV_X1 port map( A => n3923, ZN => n3924);
   U5 : INV_X1 port map( A => N313, ZN => n3925);
   U6 : INV_X1 port map( A => n3925, ZN => n3926);
   U7 : INV_X1 port map( A => N312, ZN => n3927);
   U8 : INV_X1 port map( A => n3927, ZN => n3928);
   U9 : INV_X1 port map( A => N311, ZN => n3929);
   U10 : INV_X1 port map( A => n3929, ZN => n3930);
   U11 : INV_X1 port map( A => N310, ZN => n3931);
   U12 : INV_X1 port map( A => n3931, ZN => n3932);
   U13 : INV_X1 port map( A => N309, ZN => n3933);
   U14 : INV_X1 port map( A => n3933, ZN => n3934);
   U15 : INV_X1 port map( A => N308, ZN => n3935);
   U16 : INV_X1 port map( A => n3935, ZN => n3936);
   U17 : INV_X1 port map( A => N307, ZN => n3937);
   U18 : INV_X1 port map( A => n3937, ZN => n3938);
   U19 : INV_X1 port map( A => N306, ZN => n3939);
   U20 : INV_X1 port map( A => n3939, ZN => n3940);
   U21 : INV_X1 port map( A => N305, ZN => n3941);
   U22 : INV_X1 port map( A => n3941, ZN => n3942);
   U23 : INV_X1 port map( A => N304, ZN => n3943);
   U24 : INV_X1 port map( A => n3943, ZN => n3944);
   U25 : INV_X1 port map( A => N303, ZN => n3945);
   U26 : INV_X1 port map( A => n3945, ZN => n3946);
   U27 : INV_X1 port map( A => N302, ZN => n3947);
   U28 : INV_X1 port map( A => n3947, ZN => n3948);
   U29 : INV_X1 port map( A => N316, ZN => n3949);
   U30 : INV_X1 port map( A => n3949, ZN => n3950);
   U31 : INV_X1 port map( A => N315, ZN => n3951);
   U32 : INV_X1 port map( A => n3951, ZN => n3952);
   U33 : INV_X1 port map( A => N301, ZN => n3953);
   U34 : INV_X1 port map( A => n3953, ZN => n3954);
   U35 : INV_X1 port map( A => N300, ZN => n3955);
   U36 : INV_X1 port map( A => n3955, ZN => n3956);
   U37 : INV_X1 port map( A => N299, ZN => n3957);
   U38 : INV_X1 port map( A => n3957, ZN => n3958);
   U39 : INV_X1 port map( A => N298, ZN => n3959);
   U40 : INV_X1 port map( A => n3959, ZN => n3960);
   U41 : INV_X1 port map( A => N297, ZN => n3961);
   U42 : INV_X1 port map( A => n3961, ZN => n3962);
   U43 : INV_X1 port map( A => N296, ZN => n3963);
   U44 : INV_X1 port map( A => n3963, ZN => n3964);
   U45 : INV_X1 port map( A => N295, ZN => n3965);
   U46 : INV_X1 port map( A => n3965, ZN => n3966);
   U47 : INV_X1 port map( A => N294, ZN => n3967);
   U48 : INV_X1 port map( A => n3967, ZN => n3968);
   U49 : INV_X1 port map( A => N293, ZN => n3969);
   U50 : INV_X1 port map( A => n3969, ZN => n3970);
   U51 : INV_X1 port map( A => N292, ZN => n3971);
   U52 : INV_X1 port map( A => n3971, ZN => n3972);
   U53 : INV_X1 port map( A => N291, ZN => n3973);
   U54 : INV_X1 port map( A => n3973, ZN => n3974);
   U55 : INV_X1 port map( A => N290, ZN => n3975);
   U56 : INV_X1 port map( A => n3975, ZN => n3976);
   U57 : INV_X1 port map( A => N289, ZN => n3977);
   U58 : INV_X1 port map( A => n3977, ZN => n3978);
   U59 : INV_X1 port map( A => N288, ZN => n3979);
   U60 : INV_X1 port map( A => n3979, ZN => n3980);
   U61 : INV_X1 port map( A => N287, ZN => n3981);
   U62 : INV_X1 port map( A => n3981, ZN => n3982);
   U63 : INV_X1 port map( A => N254, ZN => n3983);
   U64 : INV_X1 port map( A => n3983, ZN => n3984);
   U65 : INV_X1 port map( A => N221, ZN => n3985);
   U66 : INV_X1 port map( A => n3985, ZN => n3986);
   U67 : AND2_X2 port map( A1 => n5878, A2 => n5860, ZN => n5203);
   U68 : NAND2_X2 port map( A1 => n5153, A2 => n5132, ZN => n4091);
   U69 : AND2_X2 port map( A1 => n5879, A2 => n5862, ZN => n5208);
   U70 : AND2_X2 port map( A1 => n5857, A2 => n5858, ZN => n5177);
   U71 : NAND2_X2 port map( A1 => n5153, A2 => n5138, ZN => n4077);
   U72 : NAND2_X2 port map( A1 => n5133, A2 => n5126, ZN => n4045);
   U73 : AND2_X2 port map( A1 => n5152, A2 => n5132, ZN => n4074);
   U74 : NAND2_X2 port map( A1 => n5860, A2 => n5859, ZN => n5173);
   U75 : AND2_X2 port map( A1 => n5125, A2 => n5127, ZN => n4041);
   U76 : AND2_X2 port map( A1 => n5878, A2 => n5867, ZN => n5214);
   U77 : AND2_X2 port map( A1 => n5862, A2 => n5858, ZN => n5182);
   U78 : NAND2_X2 port map( A1 => n5152, A2 => n5133, ZN => n4084);
   U79 : NAND2_X2 port map( A1 => n5138, A2 => n5126, ZN => n4052);
   U80 : NAND2_X2 port map( A1 => n5879, A2 => n5871, ZN => n5215);
   U81 : NAND2_X2 port map( A1 => n5863, A2 => n5859, ZN => n5178);
   U82 : AND2_X2 port map( A1 => n5132, A2 => n5127, ZN => n4048);
   U83 : AND2_X2 port map( A1 => n5878, A2 => n5870, ZN => n5219);
   U84 : AND2_X2 port map( A1 => n5867, A2 => n5858, ZN => n5189);
   U85 : NAND2_X2 port map( A1 => n5143, A2 => n5126, ZN => n4059);
   U86 : NAND2_X2 port map( A1 => n5153, A2 => n5125, ZN => n4070);
   U87 : NAND2_X2 port map( A1 => n5879, A2 => n5860, ZN => n5200);
   U88 : NAND2_X2 port map( A1 => n5871, A2 => n5859, ZN => n5190);
   U89 : AND2_X2 port map( A1 => n5152, A2 => n5142, ZN => n4094);
   U90 : AND2_X2 port map( A1 => n5137, A2 => n5127, ZN => n4055);
   U91 : AND2_X2 port map( A1 => n5858, A2 => n5870, ZN => n5194);
   U92 : NAND2_X2 port map( A1 => n5128, A2 => n5126, ZN => n4038);
   U93 : NAND2_X2 port map( A1 => n5878, A2 => n5863, ZN => n5205);
   U94 : AND2_X2 port map( A1 => n5153, A2 => n5133, ZN => n4081);
   U95 : NAND2_X2 port map( A1 => n5879, A2 => n5867, ZN => n5209);
   U96 : NAND2_X2 port map( A1 => n5868, A2 => n5859, ZN => n5184);
   U97 : AND2_X2 port map( A1 => n5152, A2 => n5125, ZN => n4080);
   U98 : AND2_X2 port map( A1 => n5142, A2 => n5127, ZN => n4062);
   U99 : NAND2_X2 port map( A1 => n5860, A2 => n5858, ZN => n5174);
   U100 : NAND2_X2 port map( A1 => n5878, A2 => n5862, ZN => n5211);
   U101 : AND2_X2 port map( A1 => n5125, A2 => n5126, ZN => n4042);
   U102 : NAND2_X2 port map( A1 => n5879, A2 => n5863, ZN => n5199);
   U103 : AND2_X2 port map( A1 => n5857, A2 => n5859, ZN => n5176);
   U104 : AND2_X2 port map( A1 => n5153, A2 => n5128, ZN => n4073);
   U105 : NAND2_X2 port map( A1 => n5152, A2 => n5138, ZN => n4075);
   U106 : NAND2_X2 port map( A1 => n5133, A2 => n5127, ZN => n4043);
   U107 : NAND2_X2 port map( A1 => n5878, A2 => n5868, ZN => n5216);
   U108 : NAND2_X2 port map( A1 => n5871, A2 => n5858, ZN => n5191);
   U109 : AND2_X2 port map( A1 => n5132, A2 => n5126, ZN => n4049);
   U110 : AND2_X2 port map( A1 => n5879, A2 => n5857, ZN => n5202);
   U111 : AND2_X2 port map( A1 => n5862, A2 => n5859, ZN => n5181);
   U112 : AND2_X2 port map( A1 => n5153, A2 => n5143, ZN => n4087);
   U113 : NAND2_X2 port map( A1 => n5152, A2 => n5137, ZN => n4082);
   U114 : NAND2_X2 port map( A1 => n5138, A2 => n5127, ZN => n4050);
   U115 : NAND2_X2 port map( A1 => n5868, A2 => n5858, ZN => n5186);
   U116 : AND2_X2 port map( A1 => n5153, A2 => n5142, ZN => n4095);
   U117 : AND2_X2 port map( A1 => n5137, A2 => n5126, ZN => n4056);
   U118 : NAND2_X2 port map( A1 => n5878, A2 => n5857, ZN => n5204);
   U119 : AND2_X2 port map( A1 => n5879, A2 => n5870, ZN => n5218);
   U120 : AND2_X2 port map( A1 => n5867, A2 => n5859, ZN => n5188);
   U121 : NAND2_X2 port map( A1 => n5152, A2 => n5143, ZN => n4089);
   U122 : NAND2_X2 port map( A1 => n5128, A2 => n5127, ZN => n4036);
   U123 : NAND2_X2 port map( A1 => n5863, A2 => n5858, ZN => n5179);
   U124 : AND2_X2 port map( A1 => n5153, A2 => n5137, ZN => n4088);
   U125 : AND2_X2 port map( A1 => n5126, A2 => n5142, ZN => n4063);
   U126 : AND2_X2 port map( A1 => n5879, A2 => n5868, ZN => n5207);
   U127 : AND2_X2 port map( A1 => n5878, A2 => n5871, ZN => n5213);
   U128 : AND2_X2 port map( A1 => n5870, A2 => n5859, ZN => n5193);
   U129 : NAND2_X2 port map( A1 => n5143, A2 => n5127, ZN => n4057);
   U130 : NAND2_X2 port map( A1 => n5152, A2 => n5128, ZN => n4068);
   U131 : INV_X2 port map( A => n5910, ZN => n3987);
   U132 : INV_X2 port map( A => n5890, ZN => n3988);
   U133 : BUF_X1 port map( A => n3989, Z => n3996);
   U134 : BUF_X1 port map( A => n3989, Z => n3997);
   U135 : BUF_X1 port map( A => n3997, Z => n3991);
   U136 : BUF_X1 port map( A => n3997, Z => n3990);
   U137 : BUF_X1 port map( A => n3997, Z => n3992);
   U138 : BUF_X1 port map( A => n3996, Z => n3993);
   U139 : BUF_X1 port map( A => n3996, Z => n3994);
   U140 : BUF_X1 port map( A => n3996, Z => n3995);
   U141 : BUF_X1 port map( A => RST, Z => n3989);
   U142 : INV_X1 port map( A => n3998, ZN => n5911);
   U143 : INV_X1 port map( A => n3999, ZN => n5912);
   U144 : INV_X1 port map( A => n4000, ZN => n5913);
   U145 : INV_X1 port map( A => n4001, ZN => n5914);
   U146 : INV_X1 port map( A => n4002, ZN => n5915);
   U147 : INV_X1 port map( A => n4003, ZN => n5916);
   U148 : INV_X1 port map( A => n4004, ZN => n5917);
   U149 : INV_X1 port map( A => n4005, ZN => n5918);
   U150 : INV_X1 port map( A => n4006, ZN => n5919);
   U151 : INV_X1 port map( A => n4007, ZN => n5920);
   U152 : INV_X1 port map( A => n4008, ZN => n5921);
   U153 : INV_X1 port map( A => n4009, ZN => n5922);
   U154 : INV_X1 port map( A => n4010, ZN => n5923);
   U155 : INV_X1 port map( A => n4011, ZN => n5924);
   U156 : INV_X1 port map( A => n4012, ZN => n5925);
   U157 : INV_X1 port map( A => n4013, ZN => n5926);
   U158 : INV_X1 port map( A => n4014, ZN => n5927);
   U159 : INV_X1 port map( A => n4015, ZN => n5928);
   U160 : INV_X1 port map( A => n4016, ZN => n5929);
   U161 : INV_X1 port map( A => n4017, ZN => n5930);
   U162 : INV_X1 port map( A => n4018, ZN => n5931);
   U163 : INV_X1 port map( A => n4019, ZN => n5932);
   U164 : INV_X1 port map( A => n4020, ZN => n5933);
   U165 : INV_X1 port map( A => n4021, ZN => n5934);
   U166 : INV_X1 port map( A => n4022, ZN => n5935);
   U167 : INV_X1 port map( A => n4023, ZN => n5936);
   U168 : INV_X1 port map( A => n4024, ZN => n5937);
   U169 : INV_X1 port map( A => n4025, ZN => n5938);
   U170 : INV_X1 port map( A => n4026, ZN => n5939);
   U171 : INV_X1 port map( A => n4027, ZN => n5940);
   U172 : INV_X1 port map( A => n4028, ZN => n5941);
   U173 : INV_X1 port map( A => n4029, ZN => n5942);
   U174 : AND2_X1 port map( A1 => EN_RD2, A2 => EN, ZN => N415);
   U175 : AND2_X1 port map( A1 => EN_RD1, A2 => EN, ZN => N414);
   U176 : NAND2_X1 port map( A1 => n4030, A2 => n4031, ZN => N413);
   U177 : NOR4_X1 port map( A1 => n4032, A2 => n4033, A3 => n4034, A4 => n4035,
                           ZN => n4031);
   U178 : OAI221_X1 port map( B1 => n4036, B2 => n4037, C1 => n4038, C2 => 
                           n4039, A => n4040, ZN => n4035);
   U179 : AOI22_X1 port map( A1 => REG_6_0_port, A2 => n4041, B1 => 
                           REG_14_0_port, B2 => n4042, ZN => n4040);
   U180 : INV_X1 port map( A => REG_12_0_port, ZN => n4039);
   U181 : INV_X1 port map( A => REG_4_0_port, ZN => n4037);
   U182 : OAI221_X1 port map( B1 => n4043, B2 => n4044, C1 => n4045, C2 => 
                           n4046, A => n4047, ZN => n4034);
   U183 : AOI22_X1 port map( A1 => REG_3_0_port, A2 => n4048, B1 => 
                           REG_11_0_port, B2 => n4049, ZN => n4047);
   U184 : OAI221_X1 port map( B1 => n4050, B2 => n4051, C1 => n4052, C2 => 
                           n4053, A => n4054, ZN => n4033);
   U185 : AOI22_X1 port map( A1 => REG_7_0_port, A2 => n4055, B1 => 
                           REG_15_0_port, B2 => n4056, ZN => n4054);
   U186 : OAI221_X1 port map( B1 => n4057, B2 => n4058, C1 => n4059, C2 => 
                           n4060, A => n4061, ZN => n4032);
   U187 : AOI22_X1 port map( A1 => REG_5_0_port, A2 => n4062, B1 => 
                           REG_13_0_port, B2 => n4063, ZN => n4061);
   U188 : NOR4_X1 port map( A1 => n4064, A2 => n4065, A3 => n4066, A4 => n4067,
                           ZN => n4030);
   U189 : OAI221_X1 port map( B1 => n4068, B2 => n4069, C1 => n4070, C2 => 
                           n4071, A => n4072, ZN => n4067);
   U190 : AOI22_X1 port map( A1 => REG_20_0_port, A2 => n4073, B1 => 
                           REG_27_0_port, B2 => n4074, ZN => n4072);
   U191 : INV_X1 port map( A => REG_28_0_port, ZN => n4069);
   U192 : OAI221_X1 port map( B1 => n4075, B2 => n4076, C1 => n4077, C2 => 
                           n4078, A => n4079, ZN => n4066);
   U193 : AOI22_X1 port map( A1 => REG_30_0_port, A2 => n4080, B1 => 
                           REG_16_0_port, B2 => n4081, ZN => n4079);
   U194 : OAI221_X1 port map( B1 => n4082, B2 => n4083, C1 => n4084, C2 => 
                           n4085, A => n4086, ZN => n4065);
   U195 : AOI22_X1 port map( A1 => REG_17_0_port, A2 => n4087, B1 => 
                           REG_23_0_port, B2 => n4088, ZN => n4086);
   U196 : OAI221_X1 port map( B1 => n4089, B2 => n4090, C1 => n4091, C2 => 
                           n4092, A => n4093, ZN => n4064);
   U197 : AOI22_X1 port map( A1 => REG_29_0_port, A2 => n4094, B1 => 
                           REG_21_0_port, B2 => n4095, ZN => n4093);
   U198 : NAND2_X1 port map( A1 => n4096, A2 => n4097, ZN => N412);
   U199 : NOR4_X1 port map( A1 => n4098, A2 => n4099, A3 => n4100, A4 => n4101,
                           ZN => n4097);
   U200 : OAI221_X1 port map( B1 => n4036, B2 => n4102, C1 => n4038, C2 => 
                           n4103, A => n4104, ZN => n4101);
   U201 : AOI22_X1 port map( A1 => REG_6_1_port, A2 => n4041, B1 => 
                           REG_14_1_port, B2 => n4042, ZN => n4104);
   U202 : INV_X1 port map( A => REG_12_1_port, ZN => n4103);
   U203 : INV_X1 port map( A => REG_4_1_port, ZN => n4102);
   U204 : OAI221_X1 port map( B1 => n4043, B2 => n4105, C1 => n4045, C2 => 
                           n4106, A => n4107, ZN => n4100);
   U205 : AOI22_X1 port map( A1 => REG_3_1_port, A2 => n4048, B1 => 
                           REG_11_1_port, B2 => n4049, ZN => n4107);
   U206 : OAI221_X1 port map( B1 => n4050, B2 => n4108, C1 => n4052, C2 => 
                           n4109, A => n4110, ZN => n4099);
   U207 : AOI22_X1 port map( A1 => REG_7_1_port, A2 => n4055, B1 => 
                           REG_15_1_port, B2 => n4056, ZN => n4110);
   U208 : OAI221_X1 port map( B1 => n4057, B2 => n4111, C1 => n4059, C2 => 
                           n4112, A => n4113, ZN => n4098);
   U209 : AOI22_X1 port map( A1 => REG_5_1_port, A2 => n4062, B1 => 
                           REG_13_1_port, B2 => n4063, ZN => n4113);
   U210 : NOR4_X1 port map( A1 => n4114, A2 => n4115, A3 => n4116, A4 => n4117,
                           ZN => n4096);
   U211 : OAI221_X1 port map( B1 => n4068, B2 => n4118, C1 => n4070, C2 => 
                           n4119, A => n4120, ZN => n4117);
   U212 : AOI22_X1 port map( A1 => REG_20_1_port, A2 => n4073, B1 => 
                           REG_27_1_port, B2 => n4074, ZN => n4120);
   U213 : INV_X1 port map( A => REG_28_1_port, ZN => n4118);
   U214 : OAI221_X1 port map( B1 => n4075, B2 => n4121, C1 => n4077, C2 => 
                           n4122, A => n4123, ZN => n4116);
   U215 : AOI22_X1 port map( A1 => REG_30_1_port, A2 => n4080, B1 => 
                           REG_16_1_port, B2 => n4081, ZN => n4123);
   U216 : OAI221_X1 port map( B1 => n4082, B2 => n4124, C1 => n4084, C2 => 
                           n4125, A => n4126, ZN => n4115);
   U217 : AOI22_X1 port map( A1 => REG_17_1_port, A2 => n4087, B1 => 
                           REG_23_1_port, B2 => n4088, ZN => n4126);
   U218 : OAI221_X1 port map( B1 => n4089, B2 => n4127, C1 => n4091, C2 => 
                           n4128, A => n4129, ZN => n4114);
   U219 : AOI22_X1 port map( A1 => REG_29_1_port, A2 => n4094, B1 => 
                           REG_21_1_port, B2 => n4095, ZN => n4129);
   U220 : NAND2_X1 port map( A1 => n4130, A2 => n4131, ZN => N411);
   U221 : NOR4_X1 port map( A1 => n4132, A2 => n4133, A3 => n4134, A4 => n4135,
                           ZN => n4131);
   U222 : OAI221_X1 port map( B1 => n4036, B2 => n4136, C1 => n4038, C2 => 
                           n4137, A => n4138, ZN => n4135);
   U223 : AOI22_X1 port map( A1 => REG_6_2_port, A2 => n4041, B1 => 
                           REG_14_2_port, B2 => n4042, ZN => n4138);
   U224 : INV_X1 port map( A => REG_12_2_port, ZN => n4137);
   U225 : INV_X1 port map( A => REG_4_2_port, ZN => n4136);
   U226 : OAI221_X1 port map( B1 => n4043, B2 => n4139, C1 => n4045, C2 => 
                           n4140, A => n4141, ZN => n4134);
   U227 : AOI22_X1 port map( A1 => REG_3_2_port, A2 => n4048, B1 => 
                           REG_11_2_port, B2 => n4049, ZN => n4141);
   U228 : OAI221_X1 port map( B1 => n4050, B2 => n4142, C1 => n4052, C2 => 
                           n4143, A => n4144, ZN => n4133);
   U229 : AOI22_X1 port map( A1 => REG_7_2_port, A2 => n4055, B1 => 
                           REG_15_2_port, B2 => n4056, ZN => n4144);
   U230 : OAI221_X1 port map( B1 => n4057, B2 => n4145, C1 => n4059, C2 => 
                           n4146, A => n4147, ZN => n4132);
   U231 : AOI22_X1 port map( A1 => REG_5_2_port, A2 => n4062, B1 => 
                           REG_13_2_port, B2 => n4063, ZN => n4147);
   U232 : NOR4_X1 port map( A1 => n4148, A2 => n4149, A3 => n4150, A4 => n4151,
                           ZN => n4130);
   U233 : OAI221_X1 port map( B1 => n4068, B2 => n4152, C1 => n4070, C2 => 
                           n4153, A => n4154, ZN => n4151);
   U234 : AOI22_X1 port map( A1 => REG_20_2_port, A2 => n4073, B1 => 
                           REG_27_2_port, B2 => n4074, ZN => n4154);
   U235 : INV_X1 port map( A => REG_28_2_port, ZN => n4152);
   U236 : OAI221_X1 port map( B1 => n4075, B2 => n4155, C1 => n4077, C2 => 
                           n4156, A => n4157, ZN => n4150);
   U237 : AOI22_X1 port map( A1 => REG_30_2_port, A2 => n4080, B1 => 
                           REG_16_2_port, B2 => n4081, ZN => n4157);
   U238 : OAI221_X1 port map( B1 => n4082, B2 => n4158, C1 => n4084, C2 => 
                           n4159, A => n4160, ZN => n4149);
   U239 : AOI22_X1 port map( A1 => REG_17_2_port, A2 => n4087, B1 => 
                           REG_23_2_port, B2 => n4088, ZN => n4160);
   U240 : OAI221_X1 port map( B1 => n4089, B2 => n4161, C1 => n4091, C2 => 
                           n4162, A => n4163, ZN => n4148);
   U241 : AOI22_X1 port map( A1 => REG_29_2_port, A2 => n4094, B1 => 
                           REG_21_2_port, B2 => n4095, ZN => n4163);
   U242 : NAND2_X1 port map( A1 => n4164, A2 => n4165, ZN => N410);
   U243 : NOR4_X1 port map( A1 => n4166, A2 => n4167, A3 => n4168, A4 => n4169,
                           ZN => n4165);
   U244 : OAI221_X1 port map( B1 => n4036, B2 => n4170, C1 => n4038, C2 => 
                           n4171, A => n4172, ZN => n4169);
   U245 : AOI22_X1 port map( A1 => REG_6_3_port, A2 => n4041, B1 => 
                           REG_14_3_port, B2 => n4042, ZN => n4172);
   U246 : INV_X1 port map( A => REG_12_3_port, ZN => n4171);
   U247 : INV_X1 port map( A => REG_4_3_port, ZN => n4170);
   U248 : OAI221_X1 port map( B1 => n4043, B2 => n4173, C1 => n4045, C2 => 
                           n4174, A => n4175, ZN => n4168);
   U249 : AOI22_X1 port map( A1 => REG_3_3_port, A2 => n4048, B1 => 
                           REG_11_3_port, B2 => n4049, ZN => n4175);
   U250 : OAI221_X1 port map( B1 => n4050, B2 => n4176, C1 => n4052, C2 => 
                           n4177, A => n4178, ZN => n4167);
   U251 : AOI22_X1 port map( A1 => REG_7_3_port, A2 => n4055, B1 => 
                           REG_15_3_port, B2 => n4056, ZN => n4178);
   U252 : OAI221_X1 port map( B1 => n4057, B2 => n4179, C1 => n4059, C2 => 
                           n4180, A => n4181, ZN => n4166);
   U253 : AOI22_X1 port map( A1 => REG_5_3_port, A2 => n4062, B1 => 
                           REG_13_3_port, B2 => n4063, ZN => n4181);
   U254 : NOR4_X1 port map( A1 => n4182, A2 => n4183, A3 => n4184, A4 => n4185,
                           ZN => n4164);
   U255 : OAI221_X1 port map( B1 => n4068, B2 => n4186, C1 => n4070, C2 => 
                           n4187, A => n4188, ZN => n4185);
   U256 : AOI22_X1 port map( A1 => REG_20_3_port, A2 => n4073, B1 => 
                           REG_27_3_port, B2 => n4074, ZN => n4188);
   U257 : INV_X1 port map( A => REG_28_3_port, ZN => n4186);
   U258 : OAI221_X1 port map( B1 => n4075, B2 => n4189, C1 => n4077, C2 => 
                           n4190, A => n4191, ZN => n4184);
   U259 : AOI22_X1 port map( A1 => REG_30_3_port, A2 => n4080, B1 => 
                           REG_16_3_port, B2 => n4081, ZN => n4191);
   U260 : OAI221_X1 port map( B1 => n4082, B2 => n4192, C1 => n4084, C2 => 
                           n4193, A => n4194, ZN => n4183);
   U261 : AOI22_X1 port map( A1 => REG_17_3_port, A2 => n4087, B1 => 
                           REG_23_3_port, B2 => n4088, ZN => n4194);
   U262 : OAI221_X1 port map( B1 => n4089, B2 => n4195, C1 => n4091, C2 => 
                           n4196, A => n4197, ZN => n4182);
   U263 : AOI22_X1 port map( A1 => REG_29_3_port, A2 => n4094, B1 => 
                           REG_21_3_port, B2 => n4095, ZN => n4197);
   U264 : NAND2_X1 port map( A1 => n4198, A2 => n4199, ZN => N409);
   U265 : NOR4_X1 port map( A1 => n4200, A2 => n4201, A3 => n4202, A4 => n4203,
                           ZN => n4199);
   U266 : OAI221_X1 port map( B1 => n4036, B2 => n4204, C1 => n4038, C2 => 
                           n4205, A => n4206, ZN => n4203);
   U267 : AOI22_X1 port map( A1 => REG_6_4_port, A2 => n4041, B1 => 
                           REG_14_4_port, B2 => n4042, ZN => n4206);
   U268 : INV_X1 port map( A => REG_12_4_port, ZN => n4205);
   U269 : INV_X1 port map( A => REG_4_4_port, ZN => n4204);
   U270 : OAI221_X1 port map( B1 => n4043, B2 => n4207, C1 => n4045, C2 => 
                           n4208, A => n4209, ZN => n4202);
   U271 : AOI22_X1 port map( A1 => REG_3_4_port, A2 => n4048, B1 => 
                           REG_11_4_port, B2 => n4049, ZN => n4209);
   U272 : OAI221_X1 port map( B1 => n4050, B2 => n4210, C1 => n4052, C2 => 
                           n4211, A => n4212, ZN => n4201);
   U273 : AOI22_X1 port map( A1 => REG_7_4_port, A2 => n4055, B1 => 
                           REG_15_4_port, B2 => n4056, ZN => n4212);
   U274 : OAI221_X1 port map( B1 => n4057, B2 => n4213, C1 => n4059, C2 => 
                           n4214, A => n4215, ZN => n4200);
   U275 : AOI22_X1 port map( A1 => REG_5_4_port, A2 => n4062, B1 => 
                           REG_13_4_port, B2 => n4063, ZN => n4215);
   U276 : NOR4_X1 port map( A1 => n4216, A2 => n4217, A3 => n4218, A4 => n4219,
                           ZN => n4198);
   U277 : OAI221_X1 port map( B1 => n4068, B2 => n4220, C1 => n4070, C2 => 
                           n4221, A => n4222, ZN => n4219);
   U278 : AOI22_X1 port map( A1 => REG_20_4_port, A2 => n4073, B1 => 
                           REG_27_4_port, B2 => n4074, ZN => n4222);
   U279 : INV_X1 port map( A => REG_28_4_port, ZN => n4220);
   U280 : OAI221_X1 port map( B1 => n4075, B2 => n4223, C1 => n4077, C2 => 
                           n4224, A => n4225, ZN => n4218);
   U281 : AOI22_X1 port map( A1 => REG_30_4_port, A2 => n4080, B1 => 
                           REG_16_4_port, B2 => n4081, ZN => n4225);
   U282 : OAI221_X1 port map( B1 => n4082, B2 => n4226, C1 => n4084, C2 => 
                           n4227, A => n4228, ZN => n4217);
   U283 : AOI22_X1 port map( A1 => REG_17_4_port, A2 => n4087, B1 => 
                           REG_23_4_port, B2 => n4088, ZN => n4228);
   U284 : OAI221_X1 port map( B1 => n4089, B2 => n4229, C1 => n4091, C2 => 
                           n4230, A => n4231, ZN => n4216);
   U285 : AOI22_X1 port map( A1 => REG_29_4_port, A2 => n4094, B1 => 
                           REG_21_4_port, B2 => n4095, ZN => n4231);
   U286 : NAND2_X1 port map( A1 => n4232, A2 => n4233, ZN => N408);
   U287 : NOR4_X1 port map( A1 => n4234, A2 => n4235, A3 => n4236, A4 => n4237,
                           ZN => n4233);
   U288 : OAI221_X1 port map( B1 => n4036, B2 => n4238, C1 => n4038, C2 => 
                           n4239, A => n4240, ZN => n4237);
   U289 : AOI22_X1 port map( A1 => REG_6_5_port, A2 => n4041, B1 => 
                           REG_14_5_port, B2 => n4042, ZN => n4240);
   U290 : INV_X1 port map( A => REG_12_5_port, ZN => n4239);
   U291 : INV_X1 port map( A => REG_4_5_port, ZN => n4238);
   U292 : OAI221_X1 port map( B1 => n4043, B2 => n4241, C1 => n4045, C2 => 
                           n4242, A => n4243, ZN => n4236);
   U293 : AOI22_X1 port map( A1 => REG_3_5_port, A2 => n4048, B1 => 
                           REG_11_5_port, B2 => n4049, ZN => n4243);
   U294 : OAI221_X1 port map( B1 => n4050, B2 => n4244, C1 => n4052, C2 => 
                           n4245, A => n4246, ZN => n4235);
   U295 : AOI22_X1 port map( A1 => REG_7_5_port, A2 => n4055, B1 => 
                           REG_15_5_port, B2 => n4056, ZN => n4246);
   U296 : OAI221_X1 port map( B1 => n4057, B2 => n4247, C1 => n4059, C2 => 
                           n4248, A => n4249, ZN => n4234);
   U297 : AOI22_X1 port map( A1 => REG_5_5_port, A2 => n4062, B1 => 
                           REG_13_5_port, B2 => n4063, ZN => n4249);
   U298 : NOR4_X1 port map( A1 => n4250, A2 => n4251, A3 => n4252, A4 => n4253,
                           ZN => n4232);
   U299 : OAI221_X1 port map( B1 => n4068, B2 => n4254, C1 => n4070, C2 => 
                           n4255, A => n4256, ZN => n4253);
   U300 : AOI22_X1 port map( A1 => REG_20_5_port, A2 => n4073, B1 => 
                           REG_27_5_port, B2 => n4074, ZN => n4256);
   U301 : INV_X1 port map( A => REG_28_5_port, ZN => n4254);
   U302 : OAI221_X1 port map( B1 => n4075, B2 => n4257, C1 => n4077, C2 => 
                           n4258, A => n4259, ZN => n4252);
   U303 : AOI22_X1 port map( A1 => REG_30_5_port, A2 => n4080, B1 => 
                           REG_16_5_port, B2 => n4081, ZN => n4259);
   U304 : OAI221_X1 port map( B1 => n4082, B2 => n4260, C1 => n4084, C2 => 
                           n4261, A => n4262, ZN => n4251);
   U305 : AOI22_X1 port map( A1 => REG_17_5_port, A2 => n4087, B1 => 
                           REG_23_5_port, B2 => n4088, ZN => n4262);
   U306 : OAI221_X1 port map( B1 => n4089, B2 => n4263, C1 => n4091, C2 => 
                           n4264, A => n4265, ZN => n4250);
   U307 : AOI22_X1 port map( A1 => REG_29_5_port, A2 => n4094, B1 => 
                           REG_21_5_port, B2 => n4095, ZN => n4265);
   U308 : NAND2_X1 port map( A1 => n4266, A2 => n4267, ZN => N407);
   U309 : NOR4_X1 port map( A1 => n4268, A2 => n4269, A3 => n4270, A4 => n4271,
                           ZN => n4267);
   U310 : OAI221_X1 port map( B1 => n4036, B2 => n4272, C1 => n4038, C2 => 
                           n4273, A => n4274, ZN => n4271);
   U311 : AOI22_X1 port map( A1 => REG_6_6_port, A2 => n4041, B1 => 
                           REG_14_6_port, B2 => n4042, ZN => n4274);
   U312 : INV_X1 port map( A => REG_12_6_port, ZN => n4273);
   U313 : INV_X1 port map( A => REG_4_6_port, ZN => n4272);
   U314 : OAI221_X1 port map( B1 => n4043, B2 => n4275, C1 => n4045, C2 => 
                           n4276, A => n4277, ZN => n4270);
   U315 : AOI22_X1 port map( A1 => REG_3_6_port, A2 => n4048, B1 => 
                           REG_11_6_port, B2 => n4049, ZN => n4277);
   U316 : OAI221_X1 port map( B1 => n4050, B2 => n4278, C1 => n4052, C2 => 
                           n4279, A => n4280, ZN => n4269);
   U317 : AOI22_X1 port map( A1 => REG_7_6_port, A2 => n4055, B1 => 
                           REG_15_6_port, B2 => n4056, ZN => n4280);
   U318 : OAI221_X1 port map( B1 => n4057, B2 => n4281, C1 => n4059, C2 => 
                           n4282, A => n4283, ZN => n4268);
   U319 : AOI22_X1 port map( A1 => REG_5_6_port, A2 => n4062, B1 => 
                           REG_13_6_port, B2 => n4063, ZN => n4283);
   U320 : NOR4_X1 port map( A1 => n4284, A2 => n4285, A3 => n4286, A4 => n4287,
                           ZN => n4266);
   U321 : OAI221_X1 port map( B1 => n4068, B2 => n4288, C1 => n4070, C2 => 
                           n4289, A => n4290, ZN => n4287);
   U322 : AOI22_X1 port map( A1 => REG_20_6_port, A2 => n4073, B1 => 
                           REG_27_6_port, B2 => n4074, ZN => n4290);
   U323 : INV_X1 port map( A => REG_28_6_port, ZN => n4288);
   U324 : OAI221_X1 port map( B1 => n4075, B2 => n4291, C1 => n4077, C2 => 
                           n4292, A => n4293, ZN => n4286);
   U325 : AOI22_X1 port map( A1 => REG_30_6_port, A2 => n4080, B1 => 
                           REG_16_6_port, B2 => n4081, ZN => n4293);
   U326 : OAI221_X1 port map( B1 => n4082, B2 => n4294, C1 => n4084, C2 => 
                           n4295, A => n4296, ZN => n4285);
   U327 : AOI22_X1 port map( A1 => REG_17_6_port, A2 => n4087, B1 => 
                           REG_23_6_port, B2 => n4088, ZN => n4296);
   U328 : OAI221_X1 port map( B1 => n4089, B2 => n4297, C1 => n4091, C2 => 
                           n4298, A => n4299, ZN => n4284);
   U329 : AOI22_X1 port map( A1 => REG_29_6_port, A2 => n4094, B1 => 
                           REG_21_6_port, B2 => n4095, ZN => n4299);
   U330 : NAND2_X1 port map( A1 => n4300, A2 => n4301, ZN => N406);
   U331 : NOR4_X1 port map( A1 => n4302, A2 => n4303, A3 => n4304, A4 => n4305,
                           ZN => n4301);
   U332 : OAI221_X1 port map( B1 => n4036, B2 => n4306, C1 => n4038, C2 => 
                           n4307, A => n4308, ZN => n4305);
   U333 : AOI22_X1 port map( A1 => REG_6_7_port, A2 => n4041, B1 => 
                           REG_14_7_port, B2 => n4042, ZN => n4308);
   U334 : INV_X1 port map( A => REG_12_7_port, ZN => n4307);
   U335 : INV_X1 port map( A => REG_4_7_port, ZN => n4306);
   U336 : OAI221_X1 port map( B1 => n4043, B2 => n4309, C1 => n4045, C2 => 
                           n4310, A => n4311, ZN => n4304);
   U337 : AOI22_X1 port map( A1 => REG_3_7_port, A2 => n4048, B1 => 
                           REG_11_7_port, B2 => n4049, ZN => n4311);
   U338 : OAI221_X1 port map( B1 => n4050, B2 => n4312, C1 => n4052, C2 => 
                           n4313, A => n4314, ZN => n4303);
   U339 : AOI22_X1 port map( A1 => REG_7_7_port, A2 => n4055, B1 => 
                           REG_15_7_port, B2 => n4056, ZN => n4314);
   U340 : OAI221_X1 port map( B1 => n4057, B2 => n4315, C1 => n4059, C2 => 
                           n4316, A => n4317, ZN => n4302);
   U341 : AOI22_X1 port map( A1 => REG_5_7_port, A2 => n4062, B1 => 
                           REG_13_7_port, B2 => n4063, ZN => n4317);
   U342 : NOR4_X1 port map( A1 => n4318, A2 => n4319, A3 => n4320, A4 => n4321,
                           ZN => n4300);
   U343 : OAI221_X1 port map( B1 => n4068, B2 => n4322, C1 => n4070, C2 => 
                           n4323, A => n4324, ZN => n4321);
   U344 : AOI22_X1 port map( A1 => REG_20_7_port, A2 => n4073, B1 => 
                           REG_27_7_port, B2 => n4074, ZN => n4324);
   U345 : INV_X1 port map( A => REG_28_7_port, ZN => n4322);
   U346 : OAI221_X1 port map( B1 => n4075, B2 => n4325, C1 => n4077, C2 => 
                           n4326, A => n4327, ZN => n4320);
   U347 : AOI22_X1 port map( A1 => REG_30_7_port, A2 => n4080, B1 => 
                           REG_16_7_port, B2 => n4081, ZN => n4327);
   U348 : OAI221_X1 port map( B1 => n4082, B2 => n4328, C1 => n4084, C2 => 
                           n4329, A => n4330, ZN => n4319);
   U349 : AOI22_X1 port map( A1 => REG_17_7_port, A2 => n4087, B1 => 
                           REG_23_7_port, B2 => n4088, ZN => n4330);
   U350 : OAI221_X1 port map( B1 => n4089, B2 => n4331, C1 => n4091, C2 => 
                           n4332, A => n4333, ZN => n4318);
   U351 : AOI22_X1 port map( A1 => REG_29_7_port, A2 => n4094, B1 => 
                           REG_21_7_port, B2 => n4095, ZN => n4333);
   U352 : NAND2_X1 port map( A1 => n4334, A2 => n4335, ZN => N405);
   U353 : NOR4_X1 port map( A1 => n4336, A2 => n4337, A3 => n4338, A4 => n4339,
                           ZN => n4335);
   U354 : OAI221_X1 port map( B1 => n4036, B2 => n4340, C1 => n4038, C2 => 
                           n4341, A => n4342, ZN => n4339);
   U355 : AOI22_X1 port map( A1 => REG_6_8_port, A2 => n4041, B1 => 
                           REG_14_8_port, B2 => n4042, ZN => n4342);
   U356 : INV_X1 port map( A => REG_12_8_port, ZN => n4341);
   U357 : INV_X1 port map( A => REG_4_8_port, ZN => n4340);
   U358 : OAI221_X1 port map( B1 => n4043, B2 => n4343, C1 => n4045, C2 => 
                           n4344, A => n4345, ZN => n4338);
   U359 : AOI22_X1 port map( A1 => REG_3_8_port, A2 => n4048, B1 => 
                           REG_11_8_port, B2 => n4049, ZN => n4345);
   U360 : OAI221_X1 port map( B1 => n4050, B2 => n4346, C1 => n4052, C2 => 
                           n4347, A => n4348, ZN => n4337);
   U361 : AOI22_X1 port map( A1 => REG_7_8_port, A2 => n4055, B1 => 
                           REG_15_8_port, B2 => n4056, ZN => n4348);
   U362 : OAI221_X1 port map( B1 => n4057, B2 => n4349, C1 => n4059, C2 => 
                           n4350, A => n4351, ZN => n4336);
   U363 : AOI22_X1 port map( A1 => REG_5_8_port, A2 => n4062, B1 => 
                           REG_13_8_port, B2 => n4063, ZN => n4351);
   U364 : NOR4_X1 port map( A1 => n4352, A2 => n4353, A3 => n4354, A4 => n4355,
                           ZN => n4334);
   U365 : OAI221_X1 port map( B1 => n4068, B2 => n4356, C1 => n4070, C2 => 
                           n4357, A => n4358, ZN => n4355);
   U366 : AOI22_X1 port map( A1 => REG_20_8_port, A2 => n4073, B1 => 
                           REG_27_8_port, B2 => n4074, ZN => n4358);
   U367 : INV_X1 port map( A => REG_28_8_port, ZN => n4356);
   U368 : OAI221_X1 port map( B1 => n4075, B2 => n4359, C1 => n4077, C2 => 
                           n4360, A => n4361, ZN => n4354);
   U369 : AOI22_X1 port map( A1 => REG_30_8_port, A2 => n4080, B1 => 
                           REG_16_8_port, B2 => n4081, ZN => n4361);
   U370 : OAI221_X1 port map( B1 => n4082, B2 => n4362, C1 => n4084, C2 => 
                           n4363, A => n4364, ZN => n4353);
   U371 : AOI22_X1 port map( A1 => REG_17_8_port, A2 => n4087, B1 => 
                           REG_23_8_port, B2 => n4088, ZN => n4364);
   U372 : OAI221_X1 port map( B1 => n4089, B2 => n4365, C1 => n4091, C2 => 
                           n4366, A => n4367, ZN => n4352);
   U373 : AOI22_X1 port map( A1 => REG_29_8_port, A2 => n4094, B1 => 
                           REG_21_8_port, B2 => n4095, ZN => n4367);
   U374 : NAND2_X1 port map( A1 => n4368, A2 => n4369, ZN => N404);
   U375 : NOR4_X1 port map( A1 => n4370, A2 => n4371, A3 => n4372, A4 => n4373,
                           ZN => n4369);
   U376 : OAI221_X1 port map( B1 => n4036, B2 => n4374, C1 => n4038, C2 => 
                           n4375, A => n4376, ZN => n4373);
   U377 : AOI22_X1 port map( A1 => REG_6_9_port, A2 => n4041, B1 => 
                           REG_14_9_port, B2 => n4042, ZN => n4376);
   U378 : INV_X1 port map( A => REG_12_9_port, ZN => n4375);
   U379 : INV_X1 port map( A => REG_4_9_port, ZN => n4374);
   U380 : OAI221_X1 port map( B1 => n4043, B2 => n4377, C1 => n4045, C2 => 
                           n4378, A => n4379, ZN => n4372);
   U381 : AOI22_X1 port map( A1 => REG_3_9_port, A2 => n4048, B1 => 
                           REG_11_9_port, B2 => n4049, ZN => n4379);
   U382 : OAI221_X1 port map( B1 => n4050, B2 => n4380, C1 => n4052, C2 => 
                           n4381, A => n4382, ZN => n4371);
   U383 : AOI22_X1 port map( A1 => REG_7_9_port, A2 => n4055, B1 => 
                           REG_15_9_port, B2 => n4056, ZN => n4382);
   U384 : OAI221_X1 port map( B1 => n4057, B2 => n4383, C1 => n4059, C2 => 
                           n4384, A => n4385, ZN => n4370);
   U385 : AOI22_X1 port map( A1 => REG_5_9_port, A2 => n4062, B1 => 
                           REG_13_9_port, B2 => n4063, ZN => n4385);
   U386 : NOR4_X1 port map( A1 => n4386, A2 => n4387, A3 => n4388, A4 => n4389,
                           ZN => n4368);
   U387 : OAI221_X1 port map( B1 => n4068, B2 => n4390, C1 => n4070, C2 => 
                           n4391, A => n4392, ZN => n4389);
   U388 : AOI22_X1 port map( A1 => REG_20_9_port, A2 => n4073, B1 => 
                           REG_27_9_port, B2 => n4074, ZN => n4392);
   U389 : INV_X1 port map( A => REG_28_9_port, ZN => n4390);
   U390 : OAI221_X1 port map( B1 => n4075, B2 => n4393, C1 => n4077, C2 => 
                           n4394, A => n4395, ZN => n4388);
   U391 : AOI22_X1 port map( A1 => REG_30_9_port, A2 => n4080, B1 => 
                           REG_16_9_port, B2 => n4081, ZN => n4395);
   U392 : OAI221_X1 port map( B1 => n4082, B2 => n4396, C1 => n4084, C2 => 
                           n4397, A => n4398, ZN => n4387);
   U393 : AOI22_X1 port map( A1 => REG_17_9_port, A2 => n4087, B1 => 
                           REG_23_9_port, B2 => n4088, ZN => n4398);
   U394 : OAI221_X1 port map( B1 => n4089, B2 => n4399, C1 => n4091, C2 => 
                           n4400, A => n4401, ZN => n4386);
   U395 : AOI22_X1 port map( A1 => REG_29_9_port, A2 => n4094, B1 => 
                           REG_21_9_port, B2 => n4095, ZN => n4401);
   U396 : NAND2_X1 port map( A1 => n4402, A2 => n4403, ZN => N403);
   U397 : NOR4_X1 port map( A1 => n4404, A2 => n4405, A3 => n4406, A4 => n4407,
                           ZN => n4403);
   U398 : OAI221_X1 port map( B1 => n4036, B2 => n4408, C1 => n4038, C2 => 
                           n4409, A => n4410, ZN => n4407);
   U399 : AOI22_X1 port map( A1 => REG_6_10_port, A2 => n4041, B1 => 
                           REG_14_10_port, B2 => n4042, ZN => n4410);
   U400 : INV_X1 port map( A => REG_12_10_port, ZN => n4409);
   U401 : INV_X1 port map( A => REG_4_10_port, ZN => n4408);
   U402 : OAI221_X1 port map( B1 => n4043, B2 => n4411, C1 => n4045, C2 => 
                           n4412, A => n4413, ZN => n4406);
   U403 : AOI22_X1 port map( A1 => REG_3_10_port, A2 => n4048, B1 => 
                           REG_11_10_port, B2 => n4049, ZN => n4413);
   U404 : OAI221_X1 port map( B1 => n4050, B2 => n4414, C1 => n4052, C2 => 
                           n4415, A => n4416, ZN => n4405);
   U405 : AOI22_X1 port map( A1 => REG_7_10_port, A2 => n4055, B1 => 
                           REG_15_10_port, B2 => n4056, ZN => n4416);
   U406 : OAI221_X1 port map( B1 => n4057, B2 => n4417, C1 => n4059, C2 => 
                           n4418, A => n4419, ZN => n4404);
   U407 : AOI22_X1 port map( A1 => REG_5_10_port, A2 => n4062, B1 => 
                           REG_13_10_port, B2 => n4063, ZN => n4419);
   U408 : NOR4_X1 port map( A1 => n4420, A2 => n4421, A3 => n4422, A4 => n4423,
                           ZN => n4402);
   U409 : OAI221_X1 port map( B1 => n4068, B2 => n4424, C1 => n4070, C2 => 
                           n4425, A => n4426, ZN => n4423);
   U410 : AOI22_X1 port map( A1 => REG_20_10_port, A2 => n4073, B1 => 
                           REG_27_10_port, B2 => n4074, ZN => n4426);
   U411 : INV_X1 port map( A => REG_28_10_port, ZN => n4424);
   U412 : OAI221_X1 port map( B1 => n4075, B2 => n4427, C1 => n4077, C2 => 
                           n4428, A => n4429, ZN => n4422);
   U413 : AOI22_X1 port map( A1 => REG_30_10_port, A2 => n4080, B1 => 
                           REG_16_10_port, B2 => n4081, ZN => n4429);
   U414 : OAI221_X1 port map( B1 => n4082, B2 => n4430, C1 => n4084, C2 => 
                           n4431, A => n4432, ZN => n4421);
   U415 : AOI22_X1 port map( A1 => REG_17_10_port, A2 => n4087, B1 => 
                           REG_23_10_port, B2 => n4088, ZN => n4432);
   U416 : OAI221_X1 port map( B1 => n4089, B2 => n4433, C1 => n4091, C2 => 
                           n4434, A => n4435, ZN => n4420);
   U417 : AOI22_X1 port map( A1 => REG_29_10_port, A2 => n4094, B1 => 
                           REG_21_10_port, B2 => n4095, ZN => n4435);
   U418 : NAND2_X1 port map( A1 => n4436, A2 => n4437, ZN => N402);
   U419 : NOR4_X1 port map( A1 => n4438, A2 => n4439, A3 => n4440, A4 => n4441,
                           ZN => n4437);
   U420 : OAI221_X1 port map( B1 => n4036, B2 => n4442, C1 => n4038, C2 => 
                           n4443, A => n4444, ZN => n4441);
   U421 : AOI22_X1 port map( A1 => REG_6_11_port, A2 => n4041, B1 => 
                           REG_14_11_port, B2 => n4042, ZN => n4444);
   U422 : INV_X1 port map( A => REG_12_11_port, ZN => n4443);
   U423 : INV_X1 port map( A => REG_4_11_port, ZN => n4442);
   U424 : OAI221_X1 port map( B1 => n4043, B2 => n4445, C1 => n4045, C2 => 
                           n4446, A => n4447, ZN => n4440);
   U425 : AOI22_X1 port map( A1 => REG_3_11_port, A2 => n4048, B1 => 
                           REG_11_11_port, B2 => n4049, ZN => n4447);
   U426 : OAI221_X1 port map( B1 => n4050, B2 => n4448, C1 => n4052, C2 => 
                           n4449, A => n4450, ZN => n4439);
   U427 : AOI22_X1 port map( A1 => REG_7_11_port, A2 => n4055, B1 => 
                           REG_15_11_port, B2 => n4056, ZN => n4450);
   U428 : OAI221_X1 port map( B1 => n4057, B2 => n4451, C1 => n4059, C2 => 
                           n4452, A => n4453, ZN => n4438);
   U429 : AOI22_X1 port map( A1 => REG_5_11_port, A2 => n4062, B1 => 
                           REG_13_11_port, B2 => n4063, ZN => n4453);
   U430 : NOR4_X1 port map( A1 => n4454, A2 => n4455, A3 => n4456, A4 => n4457,
                           ZN => n4436);
   U431 : OAI221_X1 port map( B1 => n4068, B2 => n4458, C1 => n4070, C2 => 
                           n4459, A => n4460, ZN => n4457);
   U432 : AOI22_X1 port map( A1 => REG_20_11_port, A2 => n4073, B1 => 
                           REG_27_11_port, B2 => n4074, ZN => n4460);
   U433 : INV_X1 port map( A => REG_28_11_port, ZN => n4458);
   U434 : OAI221_X1 port map( B1 => n4075, B2 => n4461, C1 => n4077, C2 => 
                           n4462, A => n4463, ZN => n4456);
   U435 : AOI22_X1 port map( A1 => REG_30_11_port, A2 => n4080, B1 => 
                           REG_16_11_port, B2 => n4081, ZN => n4463);
   U436 : OAI221_X1 port map( B1 => n4082, B2 => n4464, C1 => n4084, C2 => 
                           n4465, A => n4466, ZN => n4455);
   U437 : AOI22_X1 port map( A1 => REG_17_11_port, A2 => n4087, B1 => 
                           REG_23_11_port, B2 => n4088, ZN => n4466);
   U438 : OAI221_X1 port map( B1 => n4089, B2 => n4467, C1 => n4091, C2 => 
                           n4468, A => n4469, ZN => n4454);
   U439 : AOI22_X1 port map( A1 => REG_29_11_port, A2 => n4094, B1 => 
                           REG_21_11_port, B2 => n4095, ZN => n4469);
   U440 : NAND2_X1 port map( A1 => n4470, A2 => n4471, ZN => N401);
   U441 : NOR4_X1 port map( A1 => n4472, A2 => n4473, A3 => n4474, A4 => n4475,
                           ZN => n4471);
   U442 : OAI221_X1 port map( B1 => n4036, B2 => n4476, C1 => n4038, C2 => 
                           n4477, A => n4478, ZN => n4475);
   U443 : AOI22_X1 port map( A1 => REG_6_12_port, A2 => n4041, B1 => 
                           REG_14_12_port, B2 => n4042, ZN => n4478);
   U444 : INV_X1 port map( A => REG_12_12_port, ZN => n4477);
   U445 : INV_X1 port map( A => REG_4_12_port, ZN => n4476);
   U446 : OAI221_X1 port map( B1 => n4043, B2 => n4479, C1 => n4045, C2 => 
                           n4480, A => n4481, ZN => n4474);
   U447 : AOI22_X1 port map( A1 => REG_3_12_port, A2 => n4048, B1 => 
                           REG_11_12_port, B2 => n4049, ZN => n4481);
   U448 : OAI221_X1 port map( B1 => n4050, B2 => n4482, C1 => n4052, C2 => 
                           n4483, A => n4484, ZN => n4473);
   U449 : AOI22_X1 port map( A1 => REG_7_12_port, A2 => n4055, B1 => 
                           REG_15_12_port, B2 => n4056, ZN => n4484);
   U450 : OAI221_X1 port map( B1 => n4057, B2 => n4485, C1 => n4059, C2 => 
                           n4486, A => n4487, ZN => n4472);
   U451 : AOI22_X1 port map( A1 => REG_5_12_port, A2 => n4062, B1 => 
                           REG_13_12_port, B2 => n4063, ZN => n4487);
   U452 : NOR4_X1 port map( A1 => n4488, A2 => n4489, A3 => n4490, A4 => n4491,
                           ZN => n4470);
   U453 : OAI221_X1 port map( B1 => n4068, B2 => n4492, C1 => n4070, C2 => 
                           n4493, A => n4494, ZN => n4491);
   U454 : AOI22_X1 port map( A1 => REG_20_12_port, A2 => n4073, B1 => 
                           REG_27_12_port, B2 => n4074, ZN => n4494);
   U455 : INV_X1 port map( A => REG_28_12_port, ZN => n4492);
   U456 : OAI221_X1 port map( B1 => n4075, B2 => n4495, C1 => n4077, C2 => 
                           n4496, A => n4497, ZN => n4490);
   U457 : AOI22_X1 port map( A1 => REG_30_12_port, A2 => n4080, B1 => 
                           REG_16_12_port, B2 => n4081, ZN => n4497);
   U458 : OAI221_X1 port map( B1 => n4082, B2 => n4498, C1 => n4084, C2 => 
                           n4499, A => n4500, ZN => n4489);
   U459 : AOI22_X1 port map( A1 => REG_17_12_port, A2 => n4087, B1 => 
                           REG_23_12_port, B2 => n4088, ZN => n4500);
   U460 : OAI221_X1 port map( B1 => n4089, B2 => n4501, C1 => n4091, C2 => 
                           n4502, A => n4503, ZN => n4488);
   U461 : AOI22_X1 port map( A1 => REG_29_12_port, A2 => n4094, B1 => 
                           REG_21_12_port, B2 => n4095, ZN => n4503);
   U462 : NAND2_X1 port map( A1 => n4504, A2 => n4505, ZN => N400);
   U463 : NOR4_X1 port map( A1 => n4506, A2 => n4507, A3 => n4508, A4 => n4509,
                           ZN => n4505);
   U464 : OAI221_X1 port map( B1 => n4036, B2 => n4510, C1 => n4038, C2 => 
                           n4511, A => n4512, ZN => n4509);
   U465 : AOI22_X1 port map( A1 => REG_6_13_port, A2 => n4041, B1 => 
                           REG_14_13_port, B2 => n4042, ZN => n4512);
   U466 : INV_X1 port map( A => REG_12_13_port, ZN => n4511);
   U467 : INV_X1 port map( A => REG_4_13_port, ZN => n4510);
   U468 : OAI221_X1 port map( B1 => n4043, B2 => n4513, C1 => n4045, C2 => 
                           n4514, A => n4515, ZN => n4508);
   U469 : AOI22_X1 port map( A1 => REG_3_13_port, A2 => n4048, B1 => 
                           REG_11_13_port, B2 => n4049, ZN => n4515);
   U470 : OAI221_X1 port map( B1 => n4050, B2 => n4516, C1 => n4052, C2 => 
                           n4517, A => n4518, ZN => n4507);
   U471 : AOI22_X1 port map( A1 => REG_7_13_port, A2 => n4055, B1 => 
                           REG_15_13_port, B2 => n4056, ZN => n4518);
   U472 : OAI221_X1 port map( B1 => n4057, B2 => n4519, C1 => n4059, C2 => 
                           n4520, A => n4521, ZN => n4506);
   U473 : AOI22_X1 port map( A1 => REG_5_13_port, A2 => n4062, B1 => 
                           REG_13_13_port, B2 => n4063, ZN => n4521);
   U474 : NOR4_X1 port map( A1 => n4522, A2 => n4523, A3 => n4524, A4 => n4525,
                           ZN => n4504);
   U475 : OAI221_X1 port map( B1 => n4068, B2 => n4526, C1 => n4070, C2 => 
                           n4527, A => n4528, ZN => n4525);
   U476 : AOI22_X1 port map( A1 => REG_20_13_port, A2 => n4073, B1 => 
                           REG_27_13_port, B2 => n4074, ZN => n4528);
   U477 : INV_X1 port map( A => REG_28_13_port, ZN => n4526);
   U478 : OAI221_X1 port map( B1 => n4075, B2 => n4529, C1 => n4077, C2 => 
                           n4530, A => n4531, ZN => n4524);
   U479 : AOI22_X1 port map( A1 => REG_30_13_port, A2 => n4080, B1 => 
                           REG_16_13_port, B2 => n4081, ZN => n4531);
   U480 : OAI221_X1 port map( B1 => n4082, B2 => n4532, C1 => n4084, C2 => 
                           n4533, A => n4534, ZN => n4523);
   U481 : AOI22_X1 port map( A1 => REG_17_13_port, A2 => n4087, B1 => 
                           REG_23_13_port, B2 => n4088, ZN => n4534);
   U482 : OAI221_X1 port map( B1 => n4089, B2 => n4535, C1 => n4091, C2 => 
                           n4536, A => n4537, ZN => n4522);
   U483 : AOI22_X1 port map( A1 => REG_29_13_port, A2 => n4094, B1 => 
                           REG_21_13_port, B2 => n4095, ZN => n4537);
   U484 : NAND2_X1 port map( A1 => n4538, A2 => n4539, ZN => N399);
   U485 : NOR4_X1 port map( A1 => n4540, A2 => n4541, A3 => n4542, A4 => n4543,
                           ZN => n4539);
   U486 : OAI221_X1 port map( B1 => n4036, B2 => n4544, C1 => n4038, C2 => 
                           n4545, A => n4546, ZN => n4543);
   U487 : AOI22_X1 port map( A1 => REG_6_14_port, A2 => n4041, B1 => 
                           REG_14_14_port, B2 => n4042, ZN => n4546);
   U488 : INV_X1 port map( A => REG_12_14_port, ZN => n4545);
   U489 : INV_X1 port map( A => REG_4_14_port, ZN => n4544);
   U490 : OAI221_X1 port map( B1 => n4043, B2 => n4547, C1 => n4045, C2 => 
                           n4548, A => n4549, ZN => n4542);
   U491 : AOI22_X1 port map( A1 => REG_3_14_port, A2 => n4048, B1 => 
                           REG_11_14_port, B2 => n4049, ZN => n4549);
   U492 : OAI221_X1 port map( B1 => n4050, B2 => n4550, C1 => n4052, C2 => 
                           n4551, A => n4552, ZN => n4541);
   U493 : AOI22_X1 port map( A1 => REG_7_14_port, A2 => n4055, B1 => 
                           REG_15_14_port, B2 => n4056, ZN => n4552);
   U494 : OAI221_X1 port map( B1 => n4057, B2 => n4553, C1 => n4059, C2 => 
                           n4554, A => n4555, ZN => n4540);
   U495 : AOI22_X1 port map( A1 => REG_5_14_port, A2 => n4062, B1 => 
                           REG_13_14_port, B2 => n4063, ZN => n4555);
   U496 : NOR4_X1 port map( A1 => n4556, A2 => n4557, A3 => n4558, A4 => n4559,
                           ZN => n4538);
   U497 : OAI221_X1 port map( B1 => n4068, B2 => n4560, C1 => n4070, C2 => 
                           n4561, A => n4562, ZN => n4559);
   U498 : AOI22_X1 port map( A1 => REG_20_14_port, A2 => n4073, B1 => 
                           REG_27_14_port, B2 => n4074, ZN => n4562);
   U499 : INV_X1 port map( A => REG_28_14_port, ZN => n4560);
   U500 : OAI221_X1 port map( B1 => n4075, B2 => n4563, C1 => n4077, C2 => 
                           n4564, A => n4565, ZN => n4558);
   U501 : AOI22_X1 port map( A1 => REG_30_14_port, A2 => n4080, B1 => 
                           REG_16_14_port, B2 => n4081, ZN => n4565);
   U502 : OAI221_X1 port map( B1 => n4082, B2 => n4566, C1 => n4084, C2 => 
                           n4567, A => n4568, ZN => n4557);
   U503 : AOI22_X1 port map( A1 => REG_17_14_port, A2 => n4087, B1 => 
                           REG_23_14_port, B2 => n4088, ZN => n4568);
   U504 : OAI221_X1 port map( B1 => n4089, B2 => n4569, C1 => n4091, C2 => 
                           n4570, A => n4571, ZN => n4556);
   U505 : AOI22_X1 port map( A1 => REG_29_14_port, A2 => n4094, B1 => 
                           REG_21_14_port, B2 => n4095, ZN => n4571);
   U506 : NAND2_X1 port map( A1 => n4572, A2 => n4573, ZN => N398);
   U507 : NOR4_X1 port map( A1 => n4574, A2 => n4575, A3 => n4576, A4 => n4577,
                           ZN => n4573);
   U508 : OAI221_X1 port map( B1 => n4036, B2 => n4578, C1 => n4038, C2 => 
                           n4579, A => n4580, ZN => n4577);
   U509 : AOI22_X1 port map( A1 => REG_6_15_port, A2 => n4041, B1 => 
                           REG_14_15_port, B2 => n4042, ZN => n4580);
   U510 : INV_X1 port map( A => REG_12_15_port, ZN => n4579);
   U511 : INV_X1 port map( A => REG_4_15_port, ZN => n4578);
   U512 : OAI221_X1 port map( B1 => n4043, B2 => n4581, C1 => n4045, C2 => 
                           n4582, A => n4583, ZN => n4576);
   U513 : AOI22_X1 port map( A1 => REG_3_15_port, A2 => n4048, B1 => 
                           REG_11_15_port, B2 => n4049, ZN => n4583);
   U514 : OAI221_X1 port map( B1 => n4050, B2 => n4584, C1 => n4052, C2 => 
                           n4585, A => n4586, ZN => n4575);
   U515 : AOI22_X1 port map( A1 => REG_7_15_port, A2 => n4055, B1 => 
                           REG_15_15_port, B2 => n4056, ZN => n4586);
   U516 : OAI221_X1 port map( B1 => n4057, B2 => n4587, C1 => n4059, C2 => 
                           n4588, A => n4589, ZN => n4574);
   U517 : AOI22_X1 port map( A1 => REG_5_15_port, A2 => n4062, B1 => 
                           REG_13_15_port, B2 => n4063, ZN => n4589);
   U518 : NOR4_X1 port map( A1 => n4590, A2 => n4591, A3 => n4592, A4 => n4593,
                           ZN => n4572);
   U519 : OAI221_X1 port map( B1 => n4068, B2 => n4594, C1 => n4070, C2 => 
                           n4595, A => n4596, ZN => n4593);
   U520 : AOI22_X1 port map( A1 => REG_20_15_port, A2 => n4073, B1 => 
                           REG_27_15_port, B2 => n4074, ZN => n4596);
   U521 : INV_X1 port map( A => REG_28_15_port, ZN => n4594);
   U522 : OAI221_X1 port map( B1 => n4075, B2 => n4597, C1 => n4077, C2 => 
                           n4598, A => n4599, ZN => n4592);
   U523 : AOI22_X1 port map( A1 => REG_30_15_port, A2 => n4080, B1 => 
                           REG_16_15_port, B2 => n4081, ZN => n4599);
   U524 : OAI221_X1 port map( B1 => n4082, B2 => n4600, C1 => n4084, C2 => 
                           n4601, A => n4602, ZN => n4591);
   U525 : AOI22_X1 port map( A1 => REG_17_15_port, A2 => n4087, B1 => 
                           REG_23_15_port, B2 => n4088, ZN => n4602);
   U526 : OAI221_X1 port map( B1 => n4089, B2 => n4603, C1 => n4091, C2 => 
                           n4604, A => n4605, ZN => n4590);
   U527 : AOI22_X1 port map( A1 => REG_29_15_port, A2 => n4094, B1 => 
                           REG_21_15_port, B2 => n4095, ZN => n4605);
   U528 : NAND2_X1 port map( A1 => n4606, A2 => n4607, ZN => N397);
   U529 : NOR4_X1 port map( A1 => n4608, A2 => n4609, A3 => n4610, A4 => n4611,
                           ZN => n4607);
   U530 : OAI221_X1 port map( B1 => n4036, B2 => n4612, C1 => n4038, C2 => 
                           n4613, A => n4614, ZN => n4611);
   U531 : AOI22_X1 port map( A1 => REG_6_16_port, A2 => n4041, B1 => 
                           REG_14_16_port, B2 => n4042, ZN => n4614);
   U532 : INV_X1 port map( A => REG_12_16_port, ZN => n4613);
   U533 : INV_X1 port map( A => REG_4_16_port, ZN => n4612);
   U534 : OAI221_X1 port map( B1 => n4043, B2 => n4615, C1 => n4045, C2 => 
                           n4616, A => n4617, ZN => n4610);
   U535 : AOI22_X1 port map( A1 => REG_3_16_port, A2 => n4048, B1 => 
                           REG_11_16_port, B2 => n4049, ZN => n4617);
   U536 : OAI221_X1 port map( B1 => n4050, B2 => n4618, C1 => n4052, C2 => 
                           n4619, A => n4620, ZN => n4609);
   U537 : AOI22_X1 port map( A1 => REG_7_16_port, A2 => n4055, B1 => 
                           REG_15_16_port, B2 => n4056, ZN => n4620);
   U538 : OAI221_X1 port map( B1 => n4057, B2 => n4621, C1 => n4059, C2 => 
                           n4622, A => n4623, ZN => n4608);
   U539 : AOI22_X1 port map( A1 => REG_5_16_port, A2 => n4062, B1 => 
                           REG_13_16_port, B2 => n4063, ZN => n4623);
   U540 : NOR4_X1 port map( A1 => n4624, A2 => n4625, A3 => n4626, A4 => n4627,
                           ZN => n4606);
   U541 : OAI221_X1 port map( B1 => n4068, B2 => n4628, C1 => n4070, C2 => 
                           n4629, A => n4630, ZN => n4627);
   U542 : AOI22_X1 port map( A1 => REG_20_16_port, A2 => n4073, B1 => 
                           REG_27_16_port, B2 => n4074, ZN => n4630);
   U543 : INV_X1 port map( A => REG_28_16_port, ZN => n4628);
   U544 : OAI221_X1 port map( B1 => n4075, B2 => n4631, C1 => n4077, C2 => 
                           n4632, A => n4633, ZN => n4626);
   U545 : AOI22_X1 port map( A1 => REG_30_16_port, A2 => n4080, B1 => 
                           REG_16_16_port, B2 => n4081, ZN => n4633);
   U546 : OAI221_X1 port map( B1 => n4082, B2 => n4634, C1 => n4084, C2 => 
                           n4635, A => n4636, ZN => n4625);
   U547 : AOI22_X1 port map( A1 => REG_17_16_port, A2 => n4087, B1 => 
                           REG_23_16_port, B2 => n4088, ZN => n4636);
   U548 : OAI221_X1 port map( B1 => n4089, B2 => n4637, C1 => n4091, C2 => 
                           n4638, A => n4639, ZN => n4624);
   U549 : AOI22_X1 port map( A1 => REG_29_16_port, A2 => n4094, B1 => 
                           REG_21_16_port, B2 => n4095, ZN => n4639);
   U550 : NAND2_X1 port map( A1 => n4640, A2 => n4641, ZN => N396);
   U551 : NOR4_X1 port map( A1 => n4642, A2 => n4643, A3 => n4644, A4 => n4645,
                           ZN => n4641);
   U552 : OAI221_X1 port map( B1 => n4036, B2 => n4646, C1 => n4038, C2 => 
                           n4647, A => n4648, ZN => n4645);
   U553 : AOI22_X1 port map( A1 => REG_6_17_port, A2 => n4041, B1 => 
                           REG_14_17_port, B2 => n4042, ZN => n4648);
   U554 : INV_X1 port map( A => REG_12_17_port, ZN => n4647);
   U555 : INV_X1 port map( A => REG_4_17_port, ZN => n4646);
   U556 : OAI221_X1 port map( B1 => n4043, B2 => n4649, C1 => n4045, C2 => 
                           n4650, A => n4651, ZN => n4644);
   U557 : AOI22_X1 port map( A1 => REG_3_17_port, A2 => n4048, B1 => 
                           REG_11_17_port, B2 => n4049, ZN => n4651);
   U558 : OAI221_X1 port map( B1 => n4050, B2 => n4652, C1 => n4052, C2 => 
                           n4653, A => n4654, ZN => n4643);
   U559 : AOI22_X1 port map( A1 => REG_7_17_port, A2 => n4055, B1 => 
                           REG_15_17_port, B2 => n4056, ZN => n4654);
   U560 : OAI221_X1 port map( B1 => n4057, B2 => n4655, C1 => n4059, C2 => 
                           n4656, A => n4657, ZN => n4642);
   U561 : AOI22_X1 port map( A1 => REG_5_17_port, A2 => n4062, B1 => 
                           REG_13_17_port, B2 => n4063, ZN => n4657);
   U562 : NOR4_X1 port map( A1 => n4658, A2 => n4659, A3 => n4660, A4 => n4661,
                           ZN => n4640);
   U563 : OAI221_X1 port map( B1 => n4068, B2 => n4662, C1 => n4070, C2 => 
                           n4663, A => n4664, ZN => n4661);
   U564 : AOI22_X1 port map( A1 => REG_20_17_port, A2 => n4073, B1 => 
                           REG_27_17_port, B2 => n4074, ZN => n4664);
   U565 : INV_X1 port map( A => REG_28_17_port, ZN => n4662);
   U566 : OAI221_X1 port map( B1 => n4075, B2 => n4665, C1 => n4077, C2 => 
                           n4666, A => n4667, ZN => n4660);
   U567 : AOI22_X1 port map( A1 => REG_30_17_port, A2 => n4080, B1 => 
                           REG_16_17_port, B2 => n4081, ZN => n4667);
   U568 : OAI221_X1 port map( B1 => n4082, B2 => n4668, C1 => n4084, C2 => 
                           n4669, A => n4670, ZN => n4659);
   U569 : AOI22_X1 port map( A1 => REG_17_17_port, A2 => n4087, B1 => 
                           REG_23_17_port, B2 => n4088, ZN => n4670);
   U570 : OAI221_X1 port map( B1 => n4089, B2 => n4671, C1 => n4091, C2 => 
                           n4672, A => n4673, ZN => n4658);
   U571 : AOI22_X1 port map( A1 => REG_29_17_port, A2 => n4094, B1 => 
                           REG_21_17_port, B2 => n4095, ZN => n4673);
   U572 : NAND2_X1 port map( A1 => n4674, A2 => n4675, ZN => N395);
   U573 : NOR4_X1 port map( A1 => n4676, A2 => n4677, A3 => n4678, A4 => n4679,
                           ZN => n4675);
   U574 : OAI221_X1 port map( B1 => n4036, B2 => n4680, C1 => n4038, C2 => 
                           n4681, A => n4682, ZN => n4679);
   U575 : AOI22_X1 port map( A1 => REG_6_18_port, A2 => n4041, B1 => 
                           REG_14_18_port, B2 => n4042, ZN => n4682);
   U576 : INV_X1 port map( A => REG_12_18_port, ZN => n4681);
   U577 : INV_X1 port map( A => REG_4_18_port, ZN => n4680);
   U578 : OAI221_X1 port map( B1 => n4043, B2 => n4683, C1 => n4045, C2 => 
                           n4684, A => n4685, ZN => n4678);
   U579 : AOI22_X1 port map( A1 => REG_3_18_port, A2 => n4048, B1 => 
                           REG_11_18_port, B2 => n4049, ZN => n4685);
   U580 : OAI221_X1 port map( B1 => n4050, B2 => n4686, C1 => n4052, C2 => 
                           n4687, A => n4688, ZN => n4677);
   U581 : AOI22_X1 port map( A1 => REG_7_18_port, A2 => n4055, B1 => 
                           REG_15_18_port, B2 => n4056, ZN => n4688);
   U582 : OAI221_X1 port map( B1 => n4057, B2 => n4689, C1 => n4059, C2 => 
                           n4690, A => n4691, ZN => n4676);
   U583 : AOI22_X1 port map( A1 => REG_5_18_port, A2 => n4062, B1 => 
                           REG_13_18_port, B2 => n4063, ZN => n4691);
   U584 : NOR4_X1 port map( A1 => n4692, A2 => n4693, A3 => n4694, A4 => n4695,
                           ZN => n4674);
   U585 : OAI221_X1 port map( B1 => n4068, B2 => n4696, C1 => n4070, C2 => 
                           n4697, A => n4698, ZN => n4695);
   U586 : AOI22_X1 port map( A1 => REG_20_18_port, A2 => n4073, B1 => 
                           REG_27_18_port, B2 => n4074, ZN => n4698);
   U587 : INV_X1 port map( A => REG_28_18_port, ZN => n4696);
   U588 : OAI221_X1 port map( B1 => n4075, B2 => n4699, C1 => n4077, C2 => 
                           n4700, A => n4701, ZN => n4694);
   U589 : AOI22_X1 port map( A1 => REG_30_18_port, A2 => n4080, B1 => 
                           REG_16_18_port, B2 => n4081, ZN => n4701);
   U590 : OAI221_X1 port map( B1 => n4082, B2 => n4702, C1 => n4084, C2 => 
                           n4703, A => n4704, ZN => n4693);
   U591 : AOI22_X1 port map( A1 => REG_17_18_port, A2 => n4087, B1 => 
                           REG_23_18_port, B2 => n4088, ZN => n4704);
   U592 : OAI221_X1 port map( B1 => n4089, B2 => n4705, C1 => n4091, C2 => 
                           n4706, A => n4707, ZN => n4692);
   U593 : AOI22_X1 port map( A1 => REG_29_18_port, A2 => n4094, B1 => 
                           REG_21_18_port, B2 => n4095, ZN => n4707);
   U594 : NAND2_X1 port map( A1 => n4708, A2 => n4709, ZN => N394);
   U595 : NOR4_X1 port map( A1 => n4710, A2 => n4711, A3 => n4712, A4 => n4713,
                           ZN => n4709);
   U596 : OAI221_X1 port map( B1 => n4036, B2 => n4714, C1 => n4038, C2 => 
                           n4715, A => n4716, ZN => n4713);
   U597 : AOI22_X1 port map( A1 => REG_6_19_port, A2 => n4041, B1 => 
                           REG_14_19_port, B2 => n4042, ZN => n4716);
   U598 : INV_X1 port map( A => REG_12_19_port, ZN => n4715);
   U599 : INV_X1 port map( A => REG_4_19_port, ZN => n4714);
   U600 : OAI221_X1 port map( B1 => n4043, B2 => n4717, C1 => n4045, C2 => 
                           n4718, A => n4719, ZN => n4712);
   U601 : AOI22_X1 port map( A1 => REG_3_19_port, A2 => n4048, B1 => 
                           REG_11_19_port, B2 => n4049, ZN => n4719);
   U602 : OAI221_X1 port map( B1 => n4050, B2 => n4720, C1 => n4052, C2 => 
                           n4721, A => n4722, ZN => n4711);
   U603 : AOI22_X1 port map( A1 => REG_7_19_port, A2 => n4055, B1 => 
                           REG_15_19_port, B2 => n4056, ZN => n4722);
   U604 : OAI221_X1 port map( B1 => n4057, B2 => n4723, C1 => n4059, C2 => 
                           n4724, A => n4725, ZN => n4710);
   U605 : AOI22_X1 port map( A1 => REG_5_19_port, A2 => n4062, B1 => 
                           REG_13_19_port, B2 => n4063, ZN => n4725);
   U606 : NOR4_X1 port map( A1 => n4726, A2 => n4727, A3 => n4728, A4 => n4729,
                           ZN => n4708);
   U607 : OAI221_X1 port map( B1 => n4068, B2 => n4730, C1 => n4070, C2 => 
                           n4731, A => n4732, ZN => n4729);
   U608 : AOI22_X1 port map( A1 => REG_20_19_port, A2 => n4073, B1 => 
                           REG_27_19_port, B2 => n4074, ZN => n4732);
   U609 : INV_X1 port map( A => REG_28_19_port, ZN => n4730);
   U610 : OAI221_X1 port map( B1 => n4075, B2 => n4733, C1 => n4077, C2 => 
                           n4734, A => n4735, ZN => n4728);
   U611 : AOI22_X1 port map( A1 => REG_30_19_port, A2 => n4080, B1 => 
                           REG_16_19_port, B2 => n4081, ZN => n4735);
   U612 : OAI221_X1 port map( B1 => n4082, B2 => n4736, C1 => n4084, C2 => 
                           n4737, A => n4738, ZN => n4727);
   U613 : AOI22_X1 port map( A1 => REG_17_19_port, A2 => n4087, B1 => 
                           REG_23_19_port, B2 => n4088, ZN => n4738);
   U614 : OAI221_X1 port map( B1 => n4089, B2 => n4739, C1 => n4091, C2 => 
                           n4740, A => n4741, ZN => n4726);
   U615 : AOI22_X1 port map( A1 => REG_29_19_port, A2 => n4094, B1 => 
                           REG_21_19_port, B2 => n4095, ZN => n4741);
   U616 : NAND2_X1 port map( A1 => n4742, A2 => n4743, ZN => N393);
   U617 : NOR4_X1 port map( A1 => n4744, A2 => n4745, A3 => n4746, A4 => n4747,
                           ZN => n4743);
   U618 : OAI221_X1 port map( B1 => n4036, B2 => n4748, C1 => n4038, C2 => 
                           n4749, A => n4750, ZN => n4747);
   U619 : AOI22_X1 port map( A1 => REG_6_20_port, A2 => n4041, B1 => 
                           REG_14_20_port, B2 => n4042, ZN => n4750);
   U620 : INV_X1 port map( A => REG_12_20_port, ZN => n4749);
   U621 : INV_X1 port map( A => REG_4_20_port, ZN => n4748);
   U622 : OAI221_X1 port map( B1 => n4043, B2 => n4751, C1 => n4045, C2 => 
                           n4752, A => n4753, ZN => n4746);
   U623 : AOI22_X1 port map( A1 => REG_3_20_port, A2 => n4048, B1 => 
                           REG_11_20_port, B2 => n4049, ZN => n4753);
   U624 : OAI221_X1 port map( B1 => n4050, B2 => n4754, C1 => n4052, C2 => 
                           n4755, A => n4756, ZN => n4745);
   U625 : AOI22_X1 port map( A1 => REG_7_20_port, A2 => n4055, B1 => 
                           REG_15_20_port, B2 => n4056, ZN => n4756);
   U626 : OAI221_X1 port map( B1 => n4057, B2 => n4757, C1 => n4059, C2 => 
                           n4758, A => n4759, ZN => n4744);
   U627 : AOI22_X1 port map( A1 => REG_5_20_port, A2 => n4062, B1 => 
                           REG_13_20_port, B2 => n4063, ZN => n4759);
   U628 : NOR4_X1 port map( A1 => n4760, A2 => n4761, A3 => n4762, A4 => n4763,
                           ZN => n4742);
   U629 : OAI221_X1 port map( B1 => n4068, B2 => n4764, C1 => n4070, C2 => 
                           n4765, A => n4766, ZN => n4763);
   U630 : AOI22_X1 port map( A1 => REG_20_20_port, A2 => n4073, B1 => 
                           REG_27_20_port, B2 => n4074, ZN => n4766);
   U631 : INV_X1 port map( A => REG_28_20_port, ZN => n4764);
   U632 : OAI221_X1 port map( B1 => n4075, B2 => n4767, C1 => n4077, C2 => 
                           n4768, A => n4769, ZN => n4762);
   U633 : AOI22_X1 port map( A1 => REG_30_20_port, A2 => n4080, B1 => 
                           REG_16_20_port, B2 => n4081, ZN => n4769);
   U634 : OAI221_X1 port map( B1 => n4082, B2 => n4770, C1 => n4084, C2 => 
                           n4771, A => n4772, ZN => n4761);
   U635 : AOI22_X1 port map( A1 => REG_17_20_port, A2 => n4087, B1 => 
                           REG_23_20_port, B2 => n4088, ZN => n4772);
   U636 : OAI221_X1 port map( B1 => n4089, B2 => n4773, C1 => n4091, C2 => 
                           n4774, A => n4775, ZN => n4760);
   U637 : AOI22_X1 port map( A1 => REG_29_20_port, A2 => n4094, B1 => 
                           REG_21_20_port, B2 => n4095, ZN => n4775);
   U638 : NAND2_X1 port map( A1 => n4776, A2 => n4777, ZN => N392);
   U639 : NOR4_X1 port map( A1 => n4778, A2 => n4779, A3 => n4780, A4 => n4781,
                           ZN => n4777);
   U640 : OAI221_X1 port map( B1 => n4036, B2 => n4782, C1 => n4038, C2 => 
                           n4783, A => n4784, ZN => n4781);
   U641 : AOI22_X1 port map( A1 => REG_6_21_port, A2 => n4041, B1 => 
                           REG_14_21_port, B2 => n4042, ZN => n4784);
   U642 : INV_X1 port map( A => REG_12_21_port, ZN => n4783);
   U643 : INV_X1 port map( A => REG_4_21_port, ZN => n4782);
   U644 : OAI221_X1 port map( B1 => n4043, B2 => n4785, C1 => n4045, C2 => 
                           n4786, A => n4787, ZN => n4780);
   U645 : AOI22_X1 port map( A1 => REG_3_21_port, A2 => n4048, B1 => 
                           REG_11_21_port, B2 => n4049, ZN => n4787);
   U646 : OAI221_X1 port map( B1 => n4050, B2 => n4788, C1 => n4052, C2 => 
                           n4789, A => n4790, ZN => n4779);
   U647 : AOI22_X1 port map( A1 => REG_7_21_port, A2 => n4055, B1 => 
                           REG_15_21_port, B2 => n4056, ZN => n4790);
   U648 : OAI221_X1 port map( B1 => n4057, B2 => n4791, C1 => n4059, C2 => 
                           n4792, A => n4793, ZN => n4778);
   U649 : AOI22_X1 port map( A1 => REG_5_21_port, A2 => n4062, B1 => 
                           REG_13_21_port, B2 => n4063, ZN => n4793);
   U650 : NOR4_X1 port map( A1 => n4794, A2 => n4795, A3 => n4796, A4 => n4797,
                           ZN => n4776);
   U651 : OAI221_X1 port map( B1 => n4068, B2 => n4798, C1 => n4070, C2 => 
                           n4799, A => n4800, ZN => n4797);
   U652 : AOI22_X1 port map( A1 => REG_20_21_port, A2 => n4073, B1 => 
                           REG_27_21_port, B2 => n4074, ZN => n4800);
   U653 : INV_X1 port map( A => REG_28_21_port, ZN => n4798);
   U654 : OAI221_X1 port map( B1 => n4075, B2 => n4801, C1 => n4077, C2 => 
                           n4802, A => n4803, ZN => n4796);
   U655 : AOI22_X1 port map( A1 => REG_30_21_port, A2 => n4080, B1 => 
                           REG_16_21_port, B2 => n4081, ZN => n4803);
   U656 : OAI221_X1 port map( B1 => n4082, B2 => n4804, C1 => n4084, C2 => 
                           n4805, A => n4806, ZN => n4795);
   U657 : AOI22_X1 port map( A1 => REG_17_21_port, A2 => n4087, B1 => 
                           REG_23_21_port, B2 => n4088, ZN => n4806);
   U658 : OAI221_X1 port map( B1 => n4089, B2 => n4807, C1 => n4091, C2 => 
                           n4808, A => n4809, ZN => n4794);
   U659 : AOI22_X1 port map( A1 => REG_29_21_port, A2 => n4094, B1 => 
                           REG_21_21_port, B2 => n4095, ZN => n4809);
   U660 : NAND2_X1 port map( A1 => n4810, A2 => n4811, ZN => N391);
   U661 : NOR4_X1 port map( A1 => n4812, A2 => n4813, A3 => n4814, A4 => n4815,
                           ZN => n4811);
   U662 : OAI221_X1 port map( B1 => n4036, B2 => n4816, C1 => n4038, C2 => 
                           n4817, A => n4818, ZN => n4815);
   U663 : AOI22_X1 port map( A1 => REG_6_22_port, A2 => n4041, B1 => 
                           REG_14_22_port, B2 => n4042, ZN => n4818);
   U664 : INV_X1 port map( A => REG_12_22_port, ZN => n4817);
   U665 : INV_X1 port map( A => REG_4_22_port, ZN => n4816);
   U666 : OAI221_X1 port map( B1 => n4043, B2 => n4819, C1 => n4045, C2 => 
                           n4820, A => n4821, ZN => n4814);
   U667 : AOI22_X1 port map( A1 => REG_3_22_port, A2 => n4048, B1 => 
                           REG_11_22_port, B2 => n4049, ZN => n4821);
   U668 : OAI221_X1 port map( B1 => n4050, B2 => n4822, C1 => n4052, C2 => 
                           n4823, A => n4824, ZN => n4813);
   U669 : AOI22_X1 port map( A1 => REG_7_22_port, A2 => n4055, B1 => 
                           REG_15_22_port, B2 => n4056, ZN => n4824);
   U670 : OAI221_X1 port map( B1 => n4057, B2 => n4825, C1 => n4059, C2 => 
                           n4826, A => n4827, ZN => n4812);
   U671 : AOI22_X1 port map( A1 => REG_5_22_port, A2 => n4062, B1 => 
                           REG_13_22_port, B2 => n4063, ZN => n4827);
   U672 : NOR4_X1 port map( A1 => n4828, A2 => n4829, A3 => n4830, A4 => n4831,
                           ZN => n4810);
   U673 : OAI221_X1 port map( B1 => n4068, B2 => n4832, C1 => n4070, C2 => 
                           n4833, A => n4834, ZN => n4831);
   U674 : AOI22_X1 port map( A1 => REG_20_22_port, A2 => n4073, B1 => 
                           REG_27_22_port, B2 => n4074, ZN => n4834);
   U675 : INV_X1 port map( A => REG_28_22_port, ZN => n4832);
   U676 : OAI221_X1 port map( B1 => n4075, B2 => n4835, C1 => n4077, C2 => 
                           n4836, A => n4837, ZN => n4830);
   U677 : AOI22_X1 port map( A1 => REG_30_22_port, A2 => n4080, B1 => 
                           REG_16_22_port, B2 => n4081, ZN => n4837);
   U678 : OAI221_X1 port map( B1 => n4082, B2 => n4838, C1 => n4084, C2 => 
                           n4839, A => n4840, ZN => n4829);
   U679 : AOI22_X1 port map( A1 => REG_17_22_port, A2 => n4087, B1 => 
                           REG_23_22_port, B2 => n4088, ZN => n4840);
   U680 : OAI221_X1 port map( B1 => n4089, B2 => n4841, C1 => n4091, C2 => 
                           n4842, A => n4843, ZN => n4828);
   U681 : AOI22_X1 port map( A1 => REG_29_22_port, A2 => n4094, B1 => 
                           REG_21_22_port, B2 => n4095, ZN => n4843);
   U682 : NAND2_X1 port map( A1 => n4844, A2 => n4845, ZN => N390);
   U683 : NOR4_X1 port map( A1 => n4846, A2 => n4847, A3 => n4848, A4 => n4849,
                           ZN => n4845);
   U684 : OAI221_X1 port map( B1 => n4036, B2 => n4850, C1 => n4038, C2 => 
                           n4851, A => n4852, ZN => n4849);
   U685 : AOI22_X1 port map( A1 => REG_6_23_port, A2 => n4041, B1 => 
                           REG_14_23_port, B2 => n4042, ZN => n4852);
   U686 : INV_X1 port map( A => REG_12_23_port, ZN => n4851);
   U687 : INV_X1 port map( A => REG_4_23_port, ZN => n4850);
   U688 : OAI221_X1 port map( B1 => n4043, B2 => n4853, C1 => n4045, C2 => 
                           n4854, A => n4855, ZN => n4848);
   U689 : AOI22_X1 port map( A1 => REG_3_23_port, A2 => n4048, B1 => 
                           REG_11_23_port, B2 => n4049, ZN => n4855);
   U690 : OAI221_X1 port map( B1 => n4050, B2 => n4856, C1 => n4052, C2 => 
                           n4857, A => n4858, ZN => n4847);
   U691 : AOI22_X1 port map( A1 => REG_7_23_port, A2 => n4055, B1 => 
                           REG_15_23_port, B2 => n4056, ZN => n4858);
   U692 : OAI221_X1 port map( B1 => n4057, B2 => n4859, C1 => n4059, C2 => 
                           n4860, A => n4861, ZN => n4846);
   U693 : AOI22_X1 port map( A1 => REG_5_23_port, A2 => n4062, B1 => 
                           REG_13_23_port, B2 => n4063, ZN => n4861);
   U694 : NOR4_X1 port map( A1 => n4862, A2 => n4863, A3 => n4864, A4 => n4865,
                           ZN => n4844);
   U695 : OAI221_X1 port map( B1 => n4068, B2 => n4866, C1 => n4070, C2 => 
                           n4867, A => n4868, ZN => n4865);
   U696 : AOI22_X1 port map( A1 => REG_20_23_port, A2 => n4073, B1 => 
                           REG_27_23_port, B2 => n4074, ZN => n4868);
   U697 : INV_X1 port map( A => REG_28_23_port, ZN => n4866);
   U698 : OAI221_X1 port map( B1 => n4075, B2 => n4869, C1 => n4077, C2 => 
                           n4870, A => n4871, ZN => n4864);
   U699 : AOI22_X1 port map( A1 => REG_30_23_port, A2 => n4080, B1 => 
                           REG_16_23_port, B2 => n4081, ZN => n4871);
   U700 : OAI221_X1 port map( B1 => n4082, B2 => n4872, C1 => n4084, C2 => 
                           n4873, A => n4874, ZN => n4863);
   U701 : AOI22_X1 port map( A1 => REG_17_23_port, A2 => n4087, B1 => 
                           REG_23_23_port, B2 => n4088, ZN => n4874);
   U702 : OAI221_X1 port map( B1 => n4089, B2 => n4875, C1 => n4091, C2 => 
                           n4876, A => n4877, ZN => n4862);
   U703 : AOI22_X1 port map( A1 => REG_29_23_port, A2 => n4094, B1 => 
                           REG_21_23_port, B2 => n4095, ZN => n4877);
   U704 : NAND2_X1 port map( A1 => n4878, A2 => n4879, ZN => N389);
   U705 : NOR4_X1 port map( A1 => n4880, A2 => n4881, A3 => n4882, A4 => n4883,
                           ZN => n4879);
   U706 : OAI221_X1 port map( B1 => n4036, B2 => n4884, C1 => n4038, C2 => 
                           n4885, A => n4886, ZN => n4883);
   U707 : AOI22_X1 port map( A1 => REG_6_24_port, A2 => n4041, B1 => 
                           REG_14_24_port, B2 => n4042, ZN => n4886);
   U708 : INV_X1 port map( A => REG_12_24_port, ZN => n4885);
   U709 : INV_X1 port map( A => REG_4_24_port, ZN => n4884);
   U710 : OAI221_X1 port map( B1 => n4043, B2 => n4887, C1 => n4045, C2 => 
                           n4888, A => n4889, ZN => n4882);
   U711 : AOI22_X1 port map( A1 => REG_3_24_port, A2 => n4048, B1 => 
                           REG_11_24_port, B2 => n4049, ZN => n4889);
   U712 : OAI221_X1 port map( B1 => n4050, B2 => n4890, C1 => n4052, C2 => 
                           n4891, A => n4892, ZN => n4881);
   U713 : AOI22_X1 port map( A1 => REG_7_24_port, A2 => n4055, B1 => 
                           REG_15_24_port, B2 => n4056, ZN => n4892);
   U714 : OAI221_X1 port map( B1 => n4057, B2 => n4893, C1 => n4059, C2 => 
                           n4894, A => n4895, ZN => n4880);
   U715 : AOI22_X1 port map( A1 => REG_5_24_port, A2 => n4062, B1 => 
                           REG_13_24_port, B2 => n4063, ZN => n4895);
   U716 : NOR4_X1 port map( A1 => n4896, A2 => n4897, A3 => n4898, A4 => n4899,
                           ZN => n4878);
   U717 : OAI221_X1 port map( B1 => n4068, B2 => n4900, C1 => n4070, C2 => 
                           n4901, A => n4902, ZN => n4899);
   U718 : AOI22_X1 port map( A1 => REG_20_24_port, A2 => n4073, B1 => 
                           REG_27_24_port, B2 => n4074, ZN => n4902);
   U719 : INV_X1 port map( A => REG_28_24_port, ZN => n4900);
   U720 : OAI221_X1 port map( B1 => n4075, B2 => n4903, C1 => n4077, C2 => 
                           n4904, A => n4905, ZN => n4898);
   U721 : AOI22_X1 port map( A1 => REG_30_24_port, A2 => n4080, B1 => 
                           REG_16_24_port, B2 => n4081, ZN => n4905);
   U722 : OAI221_X1 port map( B1 => n4082, B2 => n4906, C1 => n4084, C2 => 
                           n4907, A => n4908, ZN => n4897);
   U723 : AOI22_X1 port map( A1 => REG_17_24_port, A2 => n4087, B1 => 
                           REG_23_24_port, B2 => n4088, ZN => n4908);
   U724 : OAI221_X1 port map( B1 => n4089, B2 => n4909, C1 => n4091, C2 => 
                           n4910, A => n4911, ZN => n4896);
   U725 : AOI22_X1 port map( A1 => REG_29_24_port, A2 => n4094, B1 => 
                           REG_21_24_port, B2 => n4095, ZN => n4911);
   U726 : NAND2_X1 port map( A1 => n4912, A2 => n4913, ZN => N388);
   U727 : NOR4_X1 port map( A1 => n4914, A2 => n4915, A3 => n4916, A4 => n4917,
                           ZN => n4913);
   U728 : OAI221_X1 port map( B1 => n4036, B2 => n4918, C1 => n4038, C2 => 
                           n4919, A => n4920, ZN => n4917);
   U729 : AOI22_X1 port map( A1 => REG_6_25_port, A2 => n4041, B1 => 
                           REG_14_25_port, B2 => n4042, ZN => n4920);
   U730 : INV_X1 port map( A => REG_12_25_port, ZN => n4919);
   U731 : INV_X1 port map( A => REG_4_25_port, ZN => n4918);
   U732 : OAI221_X1 port map( B1 => n4043, B2 => n4921, C1 => n4045, C2 => 
                           n4922, A => n4923, ZN => n4916);
   U733 : AOI22_X1 port map( A1 => REG_3_25_port, A2 => n4048, B1 => 
                           REG_11_25_port, B2 => n4049, ZN => n4923);
   U734 : OAI221_X1 port map( B1 => n4050, B2 => n4924, C1 => n4052, C2 => 
                           n4925, A => n4926, ZN => n4915);
   U735 : AOI22_X1 port map( A1 => REG_7_25_port, A2 => n4055, B1 => 
                           REG_15_25_port, B2 => n4056, ZN => n4926);
   U736 : OAI221_X1 port map( B1 => n4057, B2 => n4927, C1 => n4059, C2 => 
                           n4928, A => n4929, ZN => n4914);
   U737 : AOI22_X1 port map( A1 => REG_5_25_port, A2 => n4062, B1 => 
                           REG_13_25_port, B2 => n4063, ZN => n4929);
   U738 : NOR4_X1 port map( A1 => n4930, A2 => n4931, A3 => n4932, A4 => n4933,
                           ZN => n4912);
   U739 : OAI221_X1 port map( B1 => n4068, B2 => n4934, C1 => n4070, C2 => 
                           n4935, A => n4936, ZN => n4933);
   U740 : AOI22_X1 port map( A1 => REG_20_25_port, A2 => n4073, B1 => 
                           REG_27_25_port, B2 => n4074, ZN => n4936);
   U741 : INV_X1 port map( A => REG_28_25_port, ZN => n4934);
   U742 : OAI221_X1 port map( B1 => n4075, B2 => n4937, C1 => n4077, C2 => 
                           n4938, A => n4939, ZN => n4932);
   U743 : AOI22_X1 port map( A1 => REG_30_25_port, A2 => n4080, B1 => 
                           REG_16_25_port, B2 => n4081, ZN => n4939);
   U744 : OAI221_X1 port map( B1 => n4082, B2 => n4940, C1 => n4084, C2 => 
                           n4941, A => n4942, ZN => n4931);
   U745 : AOI22_X1 port map( A1 => REG_17_25_port, A2 => n4087, B1 => 
                           REG_23_25_port, B2 => n4088, ZN => n4942);
   U746 : OAI221_X1 port map( B1 => n4089, B2 => n4943, C1 => n4091, C2 => 
                           n4944, A => n4945, ZN => n4930);
   U747 : AOI22_X1 port map( A1 => REG_29_25_port, A2 => n4094, B1 => 
                           REG_21_25_port, B2 => n4095, ZN => n4945);
   U748 : NAND2_X1 port map( A1 => n4946, A2 => n4947, ZN => N387);
   U749 : NOR4_X1 port map( A1 => n4948, A2 => n4949, A3 => n4950, A4 => n4951,
                           ZN => n4947);
   U750 : OAI221_X1 port map( B1 => n4036, B2 => n4952, C1 => n4038, C2 => 
                           n4953, A => n4954, ZN => n4951);
   U751 : AOI22_X1 port map( A1 => REG_6_26_port, A2 => n4041, B1 => 
                           REG_14_26_port, B2 => n4042, ZN => n4954);
   U752 : INV_X1 port map( A => REG_12_26_port, ZN => n4953);
   U753 : INV_X1 port map( A => REG_4_26_port, ZN => n4952);
   U754 : OAI221_X1 port map( B1 => n4043, B2 => n4955, C1 => n4045, C2 => 
                           n4956, A => n4957, ZN => n4950);
   U755 : AOI22_X1 port map( A1 => REG_3_26_port, A2 => n4048, B1 => 
                           REG_11_26_port, B2 => n4049, ZN => n4957);
   U756 : OAI221_X1 port map( B1 => n4050, B2 => n4958, C1 => n4052, C2 => 
                           n4959, A => n4960, ZN => n4949);
   U757 : AOI22_X1 port map( A1 => REG_7_26_port, A2 => n4055, B1 => 
                           REG_15_26_port, B2 => n4056, ZN => n4960);
   U758 : OAI221_X1 port map( B1 => n4057, B2 => n4961, C1 => n4059, C2 => 
                           n4962, A => n4963, ZN => n4948);
   U759 : AOI22_X1 port map( A1 => REG_5_26_port, A2 => n4062, B1 => 
                           REG_13_26_port, B2 => n4063, ZN => n4963);
   U760 : NOR4_X1 port map( A1 => n4964, A2 => n4965, A3 => n4966, A4 => n4967,
                           ZN => n4946);
   U761 : OAI221_X1 port map( B1 => n4068, B2 => n4968, C1 => n4070, C2 => 
                           n4969, A => n4970, ZN => n4967);
   U762 : AOI22_X1 port map( A1 => REG_20_26_port, A2 => n4073, B1 => 
                           REG_27_26_port, B2 => n4074, ZN => n4970);
   U763 : INV_X1 port map( A => REG_28_26_port, ZN => n4968);
   U764 : OAI221_X1 port map( B1 => n4075, B2 => n4971, C1 => n4077, C2 => 
                           n4972, A => n4973, ZN => n4966);
   U765 : AOI22_X1 port map( A1 => REG_30_26_port, A2 => n4080, B1 => 
                           REG_16_26_port, B2 => n4081, ZN => n4973);
   U766 : OAI221_X1 port map( B1 => n4082, B2 => n4974, C1 => n4084, C2 => 
                           n4975, A => n4976, ZN => n4965);
   U767 : AOI22_X1 port map( A1 => REG_17_26_port, A2 => n4087, B1 => 
                           REG_23_26_port, B2 => n4088, ZN => n4976);
   U768 : OAI221_X1 port map( B1 => n4089, B2 => n4977, C1 => n4091, C2 => 
                           n4978, A => n4979, ZN => n4964);
   U769 : AOI22_X1 port map( A1 => REG_29_26_port, A2 => n4094, B1 => 
                           REG_21_26_port, B2 => n4095, ZN => n4979);
   U770 : NAND2_X1 port map( A1 => n4980, A2 => n4981, ZN => N386);
   U771 : NOR4_X1 port map( A1 => n4982, A2 => n4983, A3 => n4984, A4 => n4985,
                           ZN => n4981);
   U772 : OAI221_X1 port map( B1 => n4036, B2 => n4986, C1 => n4038, C2 => 
                           n4987, A => n4988, ZN => n4985);
   U773 : AOI22_X1 port map( A1 => REG_6_27_port, A2 => n4041, B1 => 
                           REG_14_27_port, B2 => n4042, ZN => n4988);
   U774 : INV_X1 port map( A => REG_12_27_port, ZN => n4987);
   U775 : INV_X1 port map( A => REG_4_27_port, ZN => n4986);
   U776 : OAI221_X1 port map( B1 => n4043, B2 => n4989, C1 => n4045, C2 => 
                           n4990, A => n4991, ZN => n4984);
   U777 : AOI22_X1 port map( A1 => REG_3_27_port, A2 => n4048, B1 => 
                           REG_11_27_port, B2 => n4049, ZN => n4991);
   U778 : OAI221_X1 port map( B1 => n4050, B2 => n4992, C1 => n4052, C2 => 
                           n4993, A => n4994, ZN => n4983);
   U779 : AOI22_X1 port map( A1 => REG_7_27_port, A2 => n4055, B1 => 
                           REG_15_27_port, B2 => n4056, ZN => n4994);
   U780 : OAI221_X1 port map( B1 => n4057, B2 => n4995, C1 => n4059, C2 => 
                           n4996, A => n4997, ZN => n4982);
   U781 : AOI22_X1 port map( A1 => REG_5_27_port, A2 => n4062, B1 => 
                           REG_13_27_port, B2 => n4063, ZN => n4997);
   U782 : NOR4_X1 port map( A1 => n4998, A2 => n4999, A3 => n5000, A4 => n5001,
                           ZN => n4980);
   U783 : OAI221_X1 port map( B1 => n4068, B2 => n5002, C1 => n4070, C2 => 
                           n5003, A => n5004, ZN => n5001);
   U784 : AOI22_X1 port map( A1 => REG_20_27_port, A2 => n4073, B1 => 
                           REG_27_27_port, B2 => n4074, ZN => n5004);
   U785 : INV_X1 port map( A => REG_28_27_port, ZN => n5002);
   U786 : OAI221_X1 port map( B1 => n4075, B2 => n5005, C1 => n4077, C2 => 
                           n5006, A => n5007, ZN => n5000);
   U787 : AOI22_X1 port map( A1 => REG_30_27_port, A2 => n4080, B1 => 
                           REG_16_27_port, B2 => n4081, ZN => n5007);
   U788 : OAI221_X1 port map( B1 => n4082, B2 => n5008, C1 => n4084, C2 => 
                           n5009, A => n5010, ZN => n4999);
   U789 : AOI22_X1 port map( A1 => REG_17_27_port, A2 => n4087, B1 => 
                           REG_23_27_port, B2 => n4088, ZN => n5010);
   U790 : OAI221_X1 port map( B1 => n4089, B2 => n5011, C1 => n4091, C2 => 
                           n5012, A => n5013, ZN => n4998);
   U791 : AOI22_X1 port map( A1 => REG_29_27_port, A2 => n4094, B1 => 
                           REG_21_27_port, B2 => n4095, ZN => n5013);
   U792 : NAND2_X1 port map( A1 => n5014, A2 => n5015, ZN => N385);
   U793 : NOR4_X1 port map( A1 => n5016, A2 => n5017, A3 => n5018, A4 => n5019,
                           ZN => n5015);
   U794 : OAI221_X1 port map( B1 => n4036, B2 => n5020, C1 => n4038, C2 => 
                           n5021, A => n5022, ZN => n5019);
   U795 : AOI22_X1 port map( A1 => REG_6_28_port, A2 => n4041, B1 => 
                           REG_14_28_port, B2 => n4042, ZN => n5022);
   U796 : INV_X1 port map( A => REG_12_28_port, ZN => n5021);
   U797 : INV_X1 port map( A => REG_4_28_port, ZN => n5020);
   U798 : OAI221_X1 port map( B1 => n4043, B2 => n5023, C1 => n4045, C2 => 
                           n5024, A => n5025, ZN => n5018);
   U799 : AOI22_X1 port map( A1 => REG_3_28_port, A2 => n4048, B1 => 
                           REG_11_28_port, B2 => n4049, ZN => n5025);
   U800 : OAI221_X1 port map( B1 => n4050, B2 => n5026, C1 => n4052, C2 => 
                           n5027, A => n5028, ZN => n5017);
   U801 : AOI22_X1 port map( A1 => REG_7_28_port, A2 => n4055, B1 => 
                           REG_15_28_port, B2 => n4056, ZN => n5028);
   U802 : OAI221_X1 port map( B1 => n4057, B2 => n5029, C1 => n4059, C2 => 
                           n5030, A => n5031, ZN => n5016);
   U803 : AOI22_X1 port map( A1 => REG_5_28_port, A2 => n4062, B1 => 
                           REG_13_28_port, B2 => n4063, ZN => n5031);
   U804 : NOR4_X1 port map( A1 => n5032, A2 => n5033, A3 => n5034, A4 => n5035,
                           ZN => n5014);
   U805 : OAI221_X1 port map( B1 => n4068, B2 => n5036, C1 => n4070, C2 => 
                           n5037, A => n5038, ZN => n5035);
   U806 : AOI22_X1 port map( A1 => REG_20_28_port, A2 => n4073, B1 => 
                           REG_27_28_port, B2 => n4074, ZN => n5038);
   U807 : INV_X1 port map( A => REG_28_28_port, ZN => n5036);
   U808 : OAI221_X1 port map( B1 => n4075, B2 => n5039, C1 => n4077, C2 => 
                           n5040, A => n5041, ZN => n5034);
   U809 : AOI22_X1 port map( A1 => REG_30_28_port, A2 => n4080, B1 => 
                           REG_16_28_port, B2 => n4081, ZN => n5041);
   U810 : OAI221_X1 port map( B1 => n4082, B2 => n5042, C1 => n4084, C2 => 
                           n5043, A => n5044, ZN => n5033);
   U811 : AOI22_X1 port map( A1 => REG_17_28_port, A2 => n4087, B1 => 
                           REG_23_28_port, B2 => n4088, ZN => n5044);
   U812 : OAI221_X1 port map( B1 => n4089, B2 => n5045, C1 => n4091, C2 => 
                           n5046, A => n5047, ZN => n5032);
   U813 : AOI22_X1 port map( A1 => REG_29_28_port, A2 => n4094, B1 => 
                           REG_21_28_port, B2 => n4095, ZN => n5047);
   U814 : NAND2_X1 port map( A1 => n5048, A2 => n5049, ZN => N384);
   U815 : NOR4_X1 port map( A1 => n5050, A2 => n5051, A3 => n5052, A4 => n5053,
                           ZN => n5049);
   U816 : OAI221_X1 port map( B1 => n4036, B2 => n5054, C1 => n4038, C2 => 
                           n5055, A => n5056, ZN => n5053);
   U817 : AOI22_X1 port map( A1 => REG_6_29_port, A2 => n4041, B1 => 
                           REG_14_29_port, B2 => n4042, ZN => n5056);
   U818 : INV_X1 port map( A => REG_12_29_port, ZN => n5055);
   U819 : INV_X1 port map( A => REG_4_29_port, ZN => n5054);
   U820 : OAI221_X1 port map( B1 => n4043, B2 => n5057, C1 => n4045, C2 => 
                           n5058, A => n5059, ZN => n5052);
   U821 : AOI22_X1 port map( A1 => REG_3_29_port, A2 => n4048, B1 => 
                           REG_11_29_port, B2 => n4049, ZN => n5059);
   U822 : OAI221_X1 port map( B1 => n4050, B2 => n5060, C1 => n4052, C2 => 
                           n5061, A => n5062, ZN => n5051);
   U823 : AOI22_X1 port map( A1 => REG_7_29_port, A2 => n4055, B1 => 
                           REG_15_29_port, B2 => n4056, ZN => n5062);
   U824 : OAI221_X1 port map( B1 => n4057, B2 => n5063, C1 => n4059, C2 => 
                           n5064, A => n5065, ZN => n5050);
   U825 : AOI22_X1 port map( A1 => REG_5_29_port, A2 => n4062, B1 => 
                           REG_13_29_port, B2 => n4063, ZN => n5065);
   U826 : NOR4_X1 port map( A1 => n5066, A2 => n5067, A3 => n5068, A4 => n5069,
                           ZN => n5048);
   U827 : OAI221_X1 port map( B1 => n4068, B2 => n5070, C1 => n4070, C2 => 
                           n5071, A => n5072, ZN => n5069);
   U828 : AOI22_X1 port map( A1 => REG_20_29_port, A2 => n4073, B1 => 
                           REG_27_29_port, B2 => n4074, ZN => n5072);
   U829 : INV_X1 port map( A => REG_28_29_port, ZN => n5070);
   U830 : OAI221_X1 port map( B1 => n4075, B2 => n5073, C1 => n4077, C2 => 
                           n5074, A => n5075, ZN => n5068);
   U831 : AOI22_X1 port map( A1 => REG_30_29_port, A2 => n4080, B1 => 
                           REG_16_29_port, B2 => n4081, ZN => n5075);
   U832 : OAI221_X1 port map( B1 => n4082, B2 => n5076, C1 => n4084, C2 => 
                           n5077, A => n5078, ZN => n5067);
   U833 : AOI22_X1 port map( A1 => REG_17_29_port, A2 => n4087, B1 => 
                           REG_23_29_port, B2 => n4088, ZN => n5078);
   U834 : OAI221_X1 port map( B1 => n4089, B2 => n5079, C1 => n4091, C2 => 
                           n5080, A => n5081, ZN => n5066);
   U835 : AOI22_X1 port map( A1 => REG_29_29_port, A2 => n4094, B1 => 
                           REG_21_29_port, B2 => n4095, ZN => n5081);
   U836 : NAND2_X1 port map( A1 => n5082, A2 => n5083, ZN => N383);
   U837 : NOR4_X1 port map( A1 => n5084, A2 => n5085, A3 => n5086, A4 => n5087,
                           ZN => n5083);
   U838 : OAI221_X1 port map( B1 => n4036, B2 => n5088, C1 => n4038, C2 => 
                           n5089, A => n5090, ZN => n5087);
   U839 : AOI22_X1 port map( A1 => REG_6_30_port, A2 => n4041, B1 => 
                           REG_14_30_port, B2 => n4042, ZN => n5090);
   U840 : INV_X1 port map( A => REG_12_30_port, ZN => n5089);
   U841 : INV_X1 port map( A => REG_4_30_port, ZN => n5088);
   U842 : OAI221_X1 port map( B1 => n4043, B2 => n5091, C1 => n4045, C2 => 
                           n5092, A => n5093, ZN => n5086);
   U843 : AOI22_X1 port map( A1 => REG_3_30_port, A2 => n4048, B1 => 
                           REG_11_30_port, B2 => n4049, ZN => n5093);
   U844 : OAI221_X1 port map( B1 => n4050, B2 => n5094, C1 => n4052, C2 => 
                           n5095, A => n5096, ZN => n5085);
   U845 : AOI22_X1 port map( A1 => REG_7_30_port, A2 => n4055, B1 => 
                           REG_15_30_port, B2 => n4056, ZN => n5096);
   U846 : OAI221_X1 port map( B1 => n4057, B2 => n5097, C1 => n4059, C2 => 
                           n5098, A => n5099, ZN => n5084);
   U847 : AOI22_X1 port map( A1 => REG_5_30_port, A2 => n4062, B1 => 
                           REG_13_30_port, B2 => n4063, ZN => n5099);
   U848 : NOR4_X1 port map( A1 => n5100, A2 => n5101, A3 => n5102, A4 => n5103,
                           ZN => n5082);
   U849 : OAI221_X1 port map( B1 => n4068, B2 => n5104, C1 => n4070, C2 => 
                           n5105, A => n5106, ZN => n5103);
   U850 : AOI22_X1 port map( A1 => REG_20_30_port, A2 => n4073, B1 => 
                           REG_27_30_port, B2 => n4074, ZN => n5106);
   U851 : INV_X1 port map( A => REG_28_30_port, ZN => n5104);
   U852 : OAI221_X1 port map( B1 => n4075, B2 => n5107, C1 => n4077, C2 => 
                           n5108, A => n5109, ZN => n5102);
   U853 : AOI22_X1 port map( A1 => REG_30_30_port, A2 => n4080, B1 => 
                           REG_16_30_port, B2 => n4081, ZN => n5109);
   U854 : OAI221_X1 port map( B1 => n4082, B2 => n5110, C1 => n4084, C2 => 
                           n5111, A => n5112, ZN => n5101);
   U855 : AOI22_X1 port map( A1 => REG_17_30_port, A2 => n4087, B1 => 
                           REG_23_30_port, B2 => n4088, ZN => n5112);
   U856 : OAI221_X1 port map( B1 => n4089, B2 => n5113, C1 => n4091, C2 => 
                           n5114, A => n5115, ZN => n5100);
   U857 : AOI22_X1 port map( A1 => REG_29_30_port, A2 => n4094, B1 => 
                           REG_21_30_port, B2 => n4095, ZN => n5115);
   U858 : NAND2_X1 port map( A1 => n5116, A2 => n5117, ZN => N382);
   U859 : NOR4_X1 port map( A1 => n5118, A2 => n5119, A3 => n5120, A4 => n5121,
                           ZN => n5117);
   U860 : OAI221_X1 port map( B1 => n4036, B2 => n5122, C1 => n4038, C2 => 
                           n5123, A => n5124, ZN => n5121);
   U861 : AOI22_X1 port map( A1 => REG_6_31_port, A2 => n4041, B1 => 
                           REG_14_31_port, B2 => n4042, ZN => n5124);
   U862 : INV_X1 port map( A => REG_12_31_port, ZN => n5123);
   U863 : INV_X1 port map( A => REG_4_31_port, ZN => n5122);
   U864 : OAI221_X1 port map( B1 => n4043, B2 => n5129, C1 => n4045, C2 => 
                           n5130, A => n5131, ZN => n5120);
   U865 : AOI22_X1 port map( A1 => REG_3_31_port, A2 => n4048, B1 => 
                           REG_11_31_port, B2 => n4049, ZN => n5131);
   U866 : OAI221_X1 port map( B1 => n4050, B2 => n5134, C1 => n4052, C2 => 
                           n5135, A => n5136, ZN => n5119);
   U867 : AOI22_X1 port map( A1 => REG_7_31_port, A2 => n4055, B1 => 
                           REG_15_31_port, B2 => n4056, ZN => n5136);
   U868 : OAI221_X1 port map( B1 => n4057, B2 => n5139, C1 => n4059, C2 => 
                           n5140, A => n5141, ZN => n5118);
   U869 : AOI22_X1 port map( A1 => REG_5_31_port, A2 => n4062, B1 => 
                           REG_13_31_port, B2 => n4063, ZN => n5141);
   U870 : NOR2_X1 port map( A1 => n5144, A2 => ADD_RD2(4), ZN => n5126);
   U871 : NOR2_X1 port map( A1 => ADD_RD2(3), A2 => ADD_RD2(4), ZN => n5127);
   U872 : NOR4_X1 port map( A1 => n5145, A2 => n5146, A3 => n5147, A4 => n5148,
                           ZN => n5116);
   U873 : OAI221_X1 port map( B1 => n4068, B2 => n5149, C1 => n4070, C2 => 
                           n5150, A => n5151, ZN => n5148);
   U874 : AOI22_X1 port map( A1 => REG_20_31_port, A2 => n4073, B1 => 
                           REG_27_31_port, B2 => n4074, ZN => n5151);
   U875 : INV_X1 port map( A => REG_28_31_port, ZN => n5149);
   U876 : NOR3_X1 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(1), A3 => n5154, ZN
                           => n5128);
   U877 : OAI221_X1 port map( B1 => n4075, B2 => n5155, C1 => n4077, C2 => 
                           n5156, A => n5157, ZN => n5147);
   U878 : AOI22_X1 port map( A1 => REG_30_31_port, A2 => n4080, B1 => 
                           REG_16_31_port, B2 => n4081, ZN => n5157);
   U879 : NOR3_X1 port map( A1 => n5154, A2 => ADD_RD2(0), A3 => n5158, ZN => 
                           n5125);
   U880 : NOR3_X1 port map( A1 => ADD_RD2(0), A2 => ADD_RD2(2), A3 => n5158, ZN
                           => n5138);
   U881 : OAI221_X1 port map( B1 => n4082, B2 => n5159, C1 => n4084, C2 => 
                           n5160, A => n5161, ZN => n5146);
   U882 : AOI22_X1 port map( A1 => REG_17_31_port, A2 => n4087, B1 => 
                           REG_23_31_port, B2 => n4088, ZN => n5161);
   U883 : NOR3_X1 port map( A1 => ADD_RD2(1), A2 => ADD_RD2(2), A3 => 
                           ADD_RD2(0), ZN => n5133);
   U884 : NOR3_X1 port map( A1 => n5154, A2 => n5162, A3 => n5158, ZN => n5137)
                           ;
   U885 : OAI221_X1 port map( B1 => n4089, B2 => n5163, C1 => n4091, C2 => 
                           n5164, A => n5165, ZN => n5145);
   U886 : AOI22_X1 port map( A1 => REG_29_31_port, A2 => n4094, B1 => 
                           REG_21_31_port, B2 => n4095, ZN => n5165);
   U887 : NOR3_X1 port map( A1 => n5162, A2 => ADD_RD2(1), A3 => n5154, ZN => 
                           n5142);
   U888 : INV_X1 port map( A => ADD_RD2(2), ZN => n5154);
   U889 : NOR3_X1 port map( A1 => n5162, A2 => ADD_RD2(2), A3 => n5158, ZN => 
                           n5132);
   U890 : INV_X1 port map( A => ADD_RD2(1), ZN => n5158);
   U891 : NOR2_X1 port map( A1 => n5166, A2 => ADD_RD2(3), ZN => n5153);
   U892 : NOR3_X1 port map( A1 => ADD_RD2(1), A2 => ADD_RD2(2), A3 => n5162, ZN
                           => n5143);
   U893 : INV_X1 port map( A => ADD_RD2(0), ZN => n5162);
   U894 : NOR2_X1 port map( A1 => n5166, A2 => n5144, ZN => n5152);
   U895 : INV_X1 port map( A => ADD_RD2(3), ZN => n5144);
   U896 : INV_X1 port map( A => ADD_RD2(4), ZN => n5166);
   U897 : NAND2_X1 port map( A1 => n5167, A2 => n5168, ZN => N381);
   U898 : NOR4_X1 port map( A1 => n5169, A2 => n5170, A3 => n5171, A4 => n5172,
                           ZN => n5168);
   U899 : OAI221_X1 port map( B1 => n4044, B2 => n5173, C1 => n4046, C2 => 
                           n5174, A => n5175, ZN => n5172);
   U900 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_0_port, B1 => n5177, B2 
                           => REG_14_0_port, ZN => n5175);
   U901 : INV_X1 port map( A => REG_8_0_port, ZN => n4046);
   U902 : INV_X1 port map( A => REG_0_0_port, ZN => n4044);
   U903 : OAI221_X1 port map( B1 => n4051, B2 => n5178, C1 => n4053, C2 => 
                           n5179, A => n5180, ZN => n5171);
   U904 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_0_port, B1 => n5182, B2 
                           => REG_12_0_port, ZN => n5180);
   U905 : INV_X1 port map( A => REG_10_0_port, ZN => n4053);
   U906 : INV_X1 port map( A => REG_2_0_port, ZN => n4051);
   U907 : OAI221_X1 port map( B1 => n5183, B2 => n5184, C1 => n5185, C2 => 
                           n5186, A => n5187, ZN => n5170);
   U908 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_0_port, B1 => n5189, B2 
                           => REG_15_0_port, ZN => n5187);
   U909 : INV_X1 port map( A => REG_11_0_port, ZN => n5185);
   U910 : INV_X1 port map( A => REG_3_0_port, ZN => n5183);
   U911 : OAI221_X1 port map( B1 => n4058, B2 => n5190, C1 => n4060, C2 => 
                           n5191, A => n5192, ZN => n5169);
   U912 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_0_port, B1 => n5194, B2 
                           => REG_13_0_port, ZN => n5192);
   U913 : INV_X1 port map( A => REG_9_0_port, ZN => n4060);
   U914 : INV_X1 port map( A => REG_1_0_port, ZN => n4058);
   U915 : NOR4_X1 port map( A1 => n5195, A2 => n5196, A3 => n5197, A4 => n5198,
                           ZN => n5167);
   U916 : OAI221_X1 port map( B1 => n4076, B2 => n5199, C1 => n4085, C2 => 
                           n5200, A => n5201, ZN => n5198);
   U917 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_0_port, B1 => n5203, B2 
                           => REG_16_0_port, ZN => n5201);
   U918 : INV_X1 port map( A => REG_24_0_port, ZN => n4085);
   U919 : INV_X1 port map( A => REG_26_0_port, ZN => n4076);
   U920 : OAI221_X1 port map( B1 => n4071, B2 => n5204, C1 => n4078, C2 => 
                           n5205, A => n5206, ZN => n5197);
   U921 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_0_port, B1 => n5208, B2 
                           => REG_28_0_port, ZN => n5206);
   U922 : INV_X1 port map( A => REG_18_0_port, ZN => n4078);
   U923 : INV_X1 port map( A => REG_22_0_port, ZN => n4071);
   U924 : OAI221_X1 port map( B1 => n4083, B2 => n5209, C1 => n5210, C2 => 
                           n5211, A => n5212, ZN => n5196);
   U925 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_0_port, B1 => n5214, B2 
                           => REG_23_0_port, ZN => n5212);
   U926 : INV_X1 port map( A => REG_20_0_port, ZN => n5210);
   U927 : INV_X1 port map( A => REG_31_0_port, ZN => n4083);
   U928 : OAI221_X1 port map( B1 => n4090, B2 => n5215, C1 => n4092, C2 => 
                           n5216, A => n5217, ZN => n5195);
   U929 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_0_port, B1 => n5219, B2 
                           => REG_21_0_port, ZN => n5217);
   U930 : INV_X1 port map( A => REG_19_0_port, ZN => n4092);
   U931 : INV_X1 port map( A => REG_25_0_port, ZN => n4090);
   U932 : NAND2_X1 port map( A1 => n5220, A2 => n5221, ZN => N380);
   U933 : NOR4_X1 port map( A1 => n5222, A2 => n5223, A3 => n5224, A4 => n5225,
                           ZN => n5221);
   U934 : OAI221_X1 port map( B1 => n4105, B2 => n5173, C1 => n4106, C2 => 
                           n5174, A => n5226, ZN => n5225);
   U935 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_1_port, B1 => n5177, B2 
                           => REG_14_1_port, ZN => n5226);
   U936 : INV_X1 port map( A => REG_8_1_port, ZN => n4106);
   U937 : INV_X1 port map( A => REG_0_1_port, ZN => n4105);
   U938 : OAI221_X1 port map( B1 => n4108, B2 => n5178, C1 => n4109, C2 => 
                           n5179, A => n5227, ZN => n5224);
   U939 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_1_port, B1 => n5182, B2 
                           => REG_12_1_port, ZN => n5227);
   U940 : INV_X1 port map( A => REG_10_1_port, ZN => n4109);
   U941 : INV_X1 port map( A => REG_2_1_port, ZN => n4108);
   U942 : OAI221_X1 port map( B1 => n5228, B2 => n5184, C1 => n5229, C2 => 
                           n5186, A => n5230, ZN => n5223);
   U943 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_1_port, B1 => n5189, B2 
                           => REG_15_1_port, ZN => n5230);
   U944 : INV_X1 port map( A => REG_11_1_port, ZN => n5229);
   U945 : INV_X1 port map( A => REG_3_1_port, ZN => n5228);
   U946 : OAI221_X1 port map( B1 => n4111, B2 => n5190, C1 => n4112, C2 => 
                           n5191, A => n5231, ZN => n5222);
   U947 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_1_port, B1 => n5194, B2 
                           => REG_13_1_port, ZN => n5231);
   U948 : INV_X1 port map( A => REG_9_1_port, ZN => n4112);
   U949 : INV_X1 port map( A => REG_1_1_port, ZN => n4111);
   U950 : NOR4_X1 port map( A1 => n5232, A2 => n5233, A3 => n5234, A4 => n5235,
                           ZN => n5220);
   U951 : OAI221_X1 port map( B1 => n4121, B2 => n5199, C1 => n4125, C2 => 
                           n5200, A => n5236, ZN => n5235);
   U952 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_1_port, B1 => n5203, B2 
                           => REG_16_1_port, ZN => n5236);
   U953 : INV_X1 port map( A => REG_24_1_port, ZN => n4125);
   U954 : INV_X1 port map( A => REG_26_1_port, ZN => n4121);
   U955 : OAI221_X1 port map( B1 => n4119, B2 => n5204, C1 => n4122, C2 => 
                           n5205, A => n5237, ZN => n5234);
   U956 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_1_port, B1 => n5208, B2 
                           => REG_28_1_port, ZN => n5237);
   U957 : INV_X1 port map( A => REG_18_1_port, ZN => n4122);
   U958 : INV_X1 port map( A => REG_22_1_port, ZN => n4119);
   U959 : OAI221_X1 port map( B1 => n4124, B2 => n5209, C1 => n5238, C2 => 
                           n5211, A => n5239, ZN => n5233);
   U960 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_1_port, B1 => n5214, B2 
                           => REG_23_1_port, ZN => n5239);
   U961 : INV_X1 port map( A => REG_20_1_port, ZN => n5238);
   U962 : INV_X1 port map( A => REG_31_1_port, ZN => n4124);
   U963 : OAI221_X1 port map( B1 => n4127, B2 => n5215, C1 => n4128, C2 => 
                           n5216, A => n5240, ZN => n5232);
   U964 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_1_port, B1 => n5219, B2 
                           => REG_21_1_port, ZN => n5240);
   U965 : INV_X1 port map( A => REG_19_1_port, ZN => n4128);
   U966 : INV_X1 port map( A => REG_25_1_port, ZN => n4127);
   U967 : NAND2_X1 port map( A1 => n5241, A2 => n5242, ZN => N379);
   U968 : NOR4_X1 port map( A1 => n5243, A2 => n5244, A3 => n5245, A4 => n5246,
                           ZN => n5242);
   U969 : OAI221_X1 port map( B1 => n4139, B2 => n5173, C1 => n4140, C2 => 
                           n5174, A => n5247, ZN => n5246);
   U970 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_2_port, B1 => n5177, B2 
                           => REG_14_2_port, ZN => n5247);
   U971 : INV_X1 port map( A => REG_8_2_port, ZN => n4140);
   U972 : INV_X1 port map( A => REG_0_2_port, ZN => n4139);
   U973 : OAI221_X1 port map( B1 => n4142, B2 => n5178, C1 => n4143, C2 => 
                           n5179, A => n5248, ZN => n5245);
   U974 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_2_port, B1 => n5182, B2 
                           => REG_12_2_port, ZN => n5248);
   U975 : INV_X1 port map( A => REG_10_2_port, ZN => n4143);
   U976 : INV_X1 port map( A => REG_2_2_port, ZN => n4142);
   U977 : OAI221_X1 port map( B1 => n5249, B2 => n5184, C1 => n5250, C2 => 
                           n5186, A => n5251, ZN => n5244);
   U978 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_2_port, B1 => n5189, B2 
                           => REG_15_2_port, ZN => n5251);
   U979 : INV_X1 port map( A => REG_11_2_port, ZN => n5250);
   U980 : INV_X1 port map( A => REG_3_2_port, ZN => n5249);
   U981 : OAI221_X1 port map( B1 => n4145, B2 => n5190, C1 => n4146, C2 => 
                           n5191, A => n5252, ZN => n5243);
   U982 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_2_port, B1 => n5194, B2 
                           => REG_13_2_port, ZN => n5252);
   U983 : INV_X1 port map( A => REG_9_2_port, ZN => n4146);
   U984 : INV_X1 port map( A => REG_1_2_port, ZN => n4145);
   U985 : NOR4_X1 port map( A1 => n5253, A2 => n5254, A3 => n5255, A4 => n5256,
                           ZN => n5241);
   U986 : OAI221_X1 port map( B1 => n4155, B2 => n5199, C1 => n4159, C2 => 
                           n5200, A => n5257, ZN => n5256);
   U987 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_2_port, B1 => n5203, B2 
                           => REG_16_2_port, ZN => n5257);
   U988 : INV_X1 port map( A => REG_24_2_port, ZN => n4159);
   U989 : INV_X1 port map( A => REG_26_2_port, ZN => n4155);
   U990 : OAI221_X1 port map( B1 => n4153, B2 => n5204, C1 => n4156, C2 => 
                           n5205, A => n5258, ZN => n5255);
   U991 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_2_port, B1 => n5208, B2 
                           => REG_28_2_port, ZN => n5258);
   U992 : INV_X1 port map( A => REG_18_2_port, ZN => n4156);
   U993 : INV_X1 port map( A => REG_22_2_port, ZN => n4153);
   U994 : OAI221_X1 port map( B1 => n4158, B2 => n5209, C1 => n5259, C2 => 
                           n5211, A => n5260, ZN => n5254);
   U995 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_2_port, B1 => n5214, B2 
                           => REG_23_2_port, ZN => n5260);
   U996 : INV_X1 port map( A => REG_20_2_port, ZN => n5259);
   U997 : INV_X1 port map( A => REG_31_2_port, ZN => n4158);
   U998 : OAI221_X1 port map( B1 => n4161, B2 => n5215, C1 => n4162, C2 => 
                           n5216, A => n5261, ZN => n5253);
   U999 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_2_port, B1 => n5219, B2 
                           => REG_21_2_port, ZN => n5261);
   U1000 : INV_X1 port map( A => REG_19_2_port, ZN => n4162);
   U1001 : INV_X1 port map( A => REG_25_2_port, ZN => n4161);
   U1002 : NAND2_X1 port map( A1 => n5262, A2 => n5263, ZN => N378);
   U1003 : NOR4_X1 port map( A1 => n5264, A2 => n5265, A3 => n5266, A4 => n5267
                           , ZN => n5263);
   U1004 : OAI221_X1 port map( B1 => n4173, B2 => n5173, C1 => n4174, C2 => 
                           n5174, A => n5268, ZN => n5267);
   U1005 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_3_port, B1 => n5177, B2 
                           => REG_14_3_port, ZN => n5268);
   U1006 : INV_X1 port map( A => REG_8_3_port, ZN => n4174);
   U1007 : INV_X1 port map( A => REG_0_3_port, ZN => n4173);
   U1008 : OAI221_X1 port map( B1 => n4176, B2 => n5178, C1 => n4177, C2 => 
                           n5179, A => n5269, ZN => n5266);
   U1009 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_3_port, B1 => n5182, B2 
                           => REG_12_3_port, ZN => n5269);
   U1010 : INV_X1 port map( A => REG_10_3_port, ZN => n4177);
   U1011 : INV_X1 port map( A => REG_2_3_port, ZN => n4176);
   U1012 : OAI221_X1 port map( B1 => n5270, B2 => n5184, C1 => n5271, C2 => 
                           n5186, A => n5272, ZN => n5265);
   U1013 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_3_port, B1 => n5189, B2 
                           => REG_15_3_port, ZN => n5272);
   U1014 : INV_X1 port map( A => REG_11_3_port, ZN => n5271);
   U1015 : INV_X1 port map( A => REG_3_3_port, ZN => n5270);
   U1016 : OAI221_X1 port map( B1 => n4179, B2 => n5190, C1 => n4180, C2 => 
                           n5191, A => n5273, ZN => n5264);
   U1017 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_3_port, B1 => n5194, B2 
                           => REG_13_3_port, ZN => n5273);
   U1018 : INV_X1 port map( A => REG_9_3_port, ZN => n4180);
   U1019 : INV_X1 port map( A => REG_1_3_port, ZN => n4179);
   U1020 : NOR4_X1 port map( A1 => n5274, A2 => n5275, A3 => n5276, A4 => n5277
                           , ZN => n5262);
   U1021 : OAI221_X1 port map( B1 => n4189, B2 => n5199, C1 => n4193, C2 => 
                           n5200, A => n5278, ZN => n5277);
   U1022 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_3_port, B1 => n5203, B2
                           => REG_16_3_port, ZN => n5278);
   U1023 : INV_X1 port map( A => REG_24_3_port, ZN => n4193);
   U1024 : INV_X1 port map( A => REG_26_3_port, ZN => n4189);
   U1025 : OAI221_X1 port map( B1 => n4187, B2 => n5204, C1 => n4190, C2 => 
                           n5205, A => n5279, ZN => n5276);
   U1026 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_3_port, B1 => n5208, B2
                           => REG_28_3_port, ZN => n5279);
   U1027 : INV_X1 port map( A => REG_18_3_port, ZN => n4190);
   U1028 : INV_X1 port map( A => REG_22_3_port, ZN => n4187);
   U1029 : OAI221_X1 port map( B1 => n4192, B2 => n5209, C1 => n5280, C2 => 
                           n5211, A => n5281, ZN => n5275);
   U1030 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_3_port, B1 => n5214, B2
                           => REG_23_3_port, ZN => n5281);
   U1031 : INV_X1 port map( A => REG_20_3_port, ZN => n5280);
   U1032 : INV_X1 port map( A => REG_31_3_port, ZN => n4192);
   U1033 : OAI221_X1 port map( B1 => n4195, B2 => n5215, C1 => n4196, C2 => 
                           n5216, A => n5282, ZN => n5274);
   U1034 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_3_port, B1 => n5219, B2
                           => REG_21_3_port, ZN => n5282);
   U1035 : INV_X1 port map( A => REG_19_3_port, ZN => n4196);
   U1036 : INV_X1 port map( A => REG_25_3_port, ZN => n4195);
   U1037 : NAND2_X1 port map( A1 => n5283, A2 => n5284, ZN => N377);
   U1038 : NOR4_X1 port map( A1 => n5285, A2 => n5286, A3 => n5287, A4 => n5288
                           , ZN => n5284);
   U1039 : OAI221_X1 port map( B1 => n4207, B2 => n5173, C1 => n4208, C2 => 
                           n5174, A => n5289, ZN => n5288);
   U1040 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_4_port, B1 => n5177, B2 
                           => REG_14_4_port, ZN => n5289);
   U1041 : INV_X1 port map( A => REG_8_4_port, ZN => n4208);
   U1042 : INV_X1 port map( A => REG_0_4_port, ZN => n4207);
   U1043 : OAI221_X1 port map( B1 => n4210, B2 => n5178, C1 => n4211, C2 => 
                           n5179, A => n5290, ZN => n5287);
   U1044 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_4_port, B1 => n5182, B2 
                           => REG_12_4_port, ZN => n5290);
   U1045 : INV_X1 port map( A => REG_10_4_port, ZN => n4211);
   U1046 : INV_X1 port map( A => REG_2_4_port, ZN => n4210);
   U1047 : OAI221_X1 port map( B1 => n5291, B2 => n5184, C1 => n5292, C2 => 
                           n5186, A => n5293, ZN => n5286);
   U1048 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_4_port, B1 => n5189, B2 
                           => REG_15_4_port, ZN => n5293);
   U1049 : INV_X1 port map( A => REG_11_4_port, ZN => n5292);
   U1050 : INV_X1 port map( A => REG_3_4_port, ZN => n5291);
   U1051 : OAI221_X1 port map( B1 => n4213, B2 => n5190, C1 => n4214, C2 => 
                           n5191, A => n5294, ZN => n5285);
   U1052 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_4_port, B1 => n5194, B2 
                           => REG_13_4_port, ZN => n5294);
   U1053 : INV_X1 port map( A => REG_9_4_port, ZN => n4214);
   U1054 : INV_X1 port map( A => REG_1_4_port, ZN => n4213);
   U1055 : NOR4_X1 port map( A1 => n5295, A2 => n5296, A3 => n5297, A4 => n5298
                           , ZN => n5283);
   U1056 : OAI221_X1 port map( B1 => n4223, B2 => n5199, C1 => n4227, C2 => 
                           n5200, A => n5299, ZN => n5298);
   U1057 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_4_port, B1 => n5203, B2
                           => REG_16_4_port, ZN => n5299);
   U1058 : INV_X1 port map( A => REG_24_4_port, ZN => n4227);
   U1059 : INV_X1 port map( A => REG_26_4_port, ZN => n4223);
   U1060 : OAI221_X1 port map( B1 => n4221, B2 => n5204, C1 => n4224, C2 => 
                           n5205, A => n5300, ZN => n5297);
   U1061 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_4_port, B1 => n5208, B2
                           => REG_28_4_port, ZN => n5300);
   U1062 : INV_X1 port map( A => REG_18_4_port, ZN => n4224);
   U1063 : INV_X1 port map( A => REG_22_4_port, ZN => n4221);
   U1064 : OAI221_X1 port map( B1 => n4226, B2 => n5209, C1 => n5301, C2 => 
                           n5211, A => n5302, ZN => n5296);
   U1065 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_4_port, B1 => n5214, B2
                           => REG_23_4_port, ZN => n5302);
   U1066 : INV_X1 port map( A => REG_20_4_port, ZN => n5301);
   U1067 : INV_X1 port map( A => REG_31_4_port, ZN => n4226);
   U1068 : OAI221_X1 port map( B1 => n4229, B2 => n5215, C1 => n4230, C2 => 
                           n5216, A => n5303, ZN => n5295);
   U1069 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_4_port, B1 => n5219, B2
                           => REG_21_4_port, ZN => n5303);
   U1070 : INV_X1 port map( A => REG_19_4_port, ZN => n4230);
   U1071 : INV_X1 port map( A => REG_25_4_port, ZN => n4229);
   U1072 : NAND2_X1 port map( A1 => n5304, A2 => n5305, ZN => N376);
   U1073 : NOR4_X1 port map( A1 => n5306, A2 => n5307, A3 => n5308, A4 => n5309
                           , ZN => n5305);
   U1074 : OAI221_X1 port map( B1 => n4241, B2 => n5173, C1 => n4242, C2 => 
                           n5174, A => n5310, ZN => n5309);
   U1075 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_5_port, B1 => n5177, B2 
                           => REG_14_5_port, ZN => n5310);
   U1076 : INV_X1 port map( A => REG_8_5_port, ZN => n4242);
   U1077 : INV_X1 port map( A => REG_0_5_port, ZN => n4241);
   U1078 : OAI221_X1 port map( B1 => n4244, B2 => n5178, C1 => n4245, C2 => 
                           n5179, A => n5311, ZN => n5308);
   U1079 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_5_port, B1 => n5182, B2 
                           => REG_12_5_port, ZN => n5311);
   U1080 : INV_X1 port map( A => REG_10_5_port, ZN => n4245);
   U1081 : INV_X1 port map( A => REG_2_5_port, ZN => n4244);
   U1082 : OAI221_X1 port map( B1 => n5312, B2 => n5184, C1 => n5313, C2 => 
                           n5186, A => n5314, ZN => n5307);
   U1083 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_5_port, B1 => n5189, B2 
                           => REG_15_5_port, ZN => n5314);
   U1084 : INV_X1 port map( A => REG_11_5_port, ZN => n5313);
   U1085 : INV_X1 port map( A => REG_3_5_port, ZN => n5312);
   U1086 : OAI221_X1 port map( B1 => n4247, B2 => n5190, C1 => n4248, C2 => 
                           n5191, A => n5315, ZN => n5306);
   U1087 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_5_port, B1 => n5194, B2 
                           => REG_13_5_port, ZN => n5315);
   U1088 : INV_X1 port map( A => REG_9_5_port, ZN => n4248);
   U1089 : INV_X1 port map( A => REG_1_5_port, ZN => n4247);
   U1090 : NOR4_X1 port map( A1 => n5316, A2 => n5317, A3 => n5318, A4 => n5319
                           , ZN => n5304);
   U1091 : OAI221_X1 port map( B1 => n4257, B2 => n5199, C1 => n4261, C2 => 
                           n5200, A => n5320, ZN => n5319);
   U1092 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_5_port, B1 => n5203, B2
                           => REG_16_5_port, ZN => n5320);
   U1093 : INV_X1 port map( A => REG_24_5_port, ZN => n4261);
   U1094 : INV_X1 port map( A => REG_26_5_port, ZN => n4257);
   U1095 : OAI221_X1 port map( B1 => n4255, B2 => n5204, C1 => n4258, C2 => 
                           n5205, A => n5321, ZN => n5318);
   U1096 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_5_port, B1 => n5208, B2
                           => REG_28_5_port, ZN => n5321);
   U1097 : INV_X1 port map( A => REG_18_5_port, ZN => n4258);
   U1098 : INV_X1 port map( A => REG_22_5_port, ZN => n4255);
   U1099 : OAI221_X1 port map( B1 => n4260, B2 => n5209, C1 => n5322, C2 => 
                           n5211, A => n5323, ZN => n5317);
   U1100 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_5_port, B1 => n5214, B2
                           => REG_23_5_port, ZN => n5323);
   U1101 : INV_X1 port map( A => REG_20_5_port, ZN => n5322);
   U1102 : INV_X1 port map( A => REG_31_5_port, ZN => n4260);
   U1103 : OAI221_X1 port map( B1 => n4263, B2 => n5215, C1 => n4264, C2 => 
                           n5216, A => n5324, ZN => n5316);
   U1104 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_5_port, B1 => n5219, B2
                           => REG_21_5_port, ZN => n5324);
   U1105 : INV_X1 port map( A => REG_19_5_port, ZN => n4264);
   U1106 : INV_X1 port map( A => REG_25_5_port, ZN => n4263);
   U1107 : NAND2_X1 port map( A1 => n5325, A2 => n5326, ZN => N375);
   U1108 : NOR4_X1 port map( A1 => n5327, A2 => n5328, A3 => n5329, A4 => n5330
                           , ZN => n5326);
   U1109 : OAI221_X1 port map( B1 => n4275, B2 => n5173, C1 => n4276, C2 => 
                           n5174, A => n5331, ZN => n5330);
   U1110 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_6_port, B1 => n5177, B2 
                           => REG_14_6_port, ZN => n5331);
   U1111 : INV_X1 port map( A => REG_8_6_port, ZN => n4276);
   U1112 : INV_X1 port map( A => REG_0_6_port, ZN => n4275);
   U1113 : OAI221_X1 port map( B1 => n4278, B2 => n5178, C1 => n4279, C2 => 
                           n5179, A => n5332, ZN => n5329);
   U1114 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_6_port, B1 => n5182, B2 
                           => REG_12_6_port, ZN => n5332);
   U1115 : INV_X1 port map( A => REG_10_6_port, ZN => n4279);
   U1116 : INV_X1 port map( A => REG_2_6_port, ZN => n4278);
   U1117 : OAI221_X1 port map( B1 => n5333, B2 => n5184, C1 => n5334, C2 => 
                           n5186, A => n5335, ZN => n5328);
   U1118 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_6_port, B1 => n5189, B2 
                           => REG_15_6_port, ZN => n5335);
   U1119 : INV_X1 port map( A => REG_11_6_port, ZN => n5334);
   U1120 : INV_X1 port map( A => REG_3_6_port, ZN => n5333);
   U1121 : OAI221_X1 port map( B1 => n4281, B2 => n5190, C1 => n4282, C2 => 
                           n5191, A => n5336, ZN => n5327);
   U1122 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_6_port, B1 => n5194, B2 
                           => REG_13_6_port, ZN => n5336);
   U1123 : INV_X1 port map( A => REG_9_6_port, ZN => n4282);
   U1124 : INV_X1 port map( A => REG_1_6_port, ZN => n4281);
   U1125 : NOR4_X1 port map( A1 => n5337, A2 => n5338, A3 => n5339, A4 => n5340
                           , ZN => n5325);
   U1126 : OAI221_X1 port map( B1 => n4291, B2 => n5199, C1 => n4295, C2 => 
                           n5200, A => n5341, ZN => n5340);
   U1127 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_6_port, B1 => n5203, B2
                           => REG_16_6_port, ZN => n5341);
   U1128 : INV_X1 port map( A => REG_24_6_port, ZN => n4295);
   U1129 : INV_X1 port map( A => REG_26_6_port, ZN => n4291);
   U1130 : OAI221_X1 port map( B1 => n4289, B2 => n5204, C1 => n4292, C2 => 
                           n5205, A => n5342, ZN => n5339);
   U1131 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_6_port, B1 => n5208, B2
                           => REG_28_6_port, ZN => n5342);
   U1132 : INV_X1 port map( A => REG_18_6_port, ZN => n4292);
   U1133 : INV_X1 port map( A => REG_22_6_port, ZN => n4289);
   U1134 : OAI221_X1 port map( B1 => n4294, B2 => n5209, C1 => n5343, C2 => 
                           n5211, A => n5344, ZN => n5338);
   U1135 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_6_port, B1 => n5214, B2
                           => REG_23_6_port, ZN => n5344);
   U1136 : INV_X1 port map( A => REG_20_6_port, ZN => n5343);
   U1137 : INV_X1 port map( A => REG_31_6_port, ZN => n4294);
   U1138 : OAI221_X1 port map( B1 => n4297, B2 => n5215, C1 => n4298, C2 => 
                           n5216, A => n5345, ZN => n5337);
   U1139 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_6_port, B1 => n5219, B2
                           => REG_21_6_port, ZN => n5345);
   U1140 : INV_X1 port map( A => REG_19_6_port, ZN => n4298);
   U1141 : INV_X1 port map( A => REG_25_6_port, ZN => n4297);
   U1142 : NAND2_X1 port map( A1 => n5346, A2 => n5347, ZN => N374);
   U1143 : NOR4_X1 port map( A1 => n5348, A2 => n5349, A3 => n5350, A4 => n5351
                           , ZN => n5347);
   U1144 : OAI221_X1 port map( B1 => n4309, B2 => n5173, C1 => n4310, C2 => 
                           n5174, A => n5352, ZN => n5351);
   U1145 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_7_port, B1 => n5177, B2 
                           => REG_14_7_port, ZN => n5352);
   U1146 : INV_X1 port map( A => REG_8_7_port, ZN => n4310);
   U1147 : INV_X1 port map( A => REG_0_7_port, ZN => n4309);
   U1148 : OAI221_X1 port map( B1 => n4312, B2 => n5178, C1 => n4313, C2 => 
                           n5179, A => n5353, ZN => n5350);
   U1149 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_7_port, B1 => n5182, B2 
                           => REG_12_7_port, ZN => n5353);
   U1150 : INV_X1 port map( A => REG_10_7_port, ZN => n4313);
   U1151 : INV_X1 port map( A => REG_2_7_port, ZN => n4312);
   U1152 : OAI221_X1 port map( B1 => n5354, B2 => n5184, C1 => n5355, C2 => 
                           n5186, A => n5356, ZN => n5349);
   U1153 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_7_port, B1 => n5189, B2 
                           => REG_15_7_port, ZN => n5356);
   U1154 : INV_X1 port map( A => REG_11_7_port, ZN => n5355);
   U1155 : INV_X1 port map( A => REG_3_7_port, ZN => n5354);
   U1156 : OAI221_X1 port map( B1 => n4315, B2 => n5190, C1 => n4316, C2 => 
                           n5191, A => n5357, ZN => n5348);
   U1157 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_7_port, B1 => n5194, B2 
                           => REG_13_7_port, ZN => n5357);
   U1158 : INV_X1 port map( A => REG_9_7_port, ZN => n4316);
   U1159 : INV_X1 port map( A => REG_1_7_port, ZN => n4315);
   U1160 : NOR4_X1 port map( A1 => n5358, A2 => n5359, A3 => n5360, A4 => n5361
                           , ZN => n5346);
   U1161 : OAI221_X1 port map( B1 => n4325, B2 => n5199, C1 => n4329, C2 => 
                           n5200, A => n5362, ZN => n5361);
   U1162 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_7_port, B1 => n5203, B2
                           => REG_16_7_port, ZN => n5362);
   U1163 : INV_X1 port map( A => REG_24_7_port, ZN => n4329);
   U1164 : INV_X1 port map( A => REG_26_7_port, ZN => n4325);
   U1165 : OAI221_X1 port map( B1 => n4323, B2 => n5204, C1 => n4326, C2 => 
                           n5205, A => n5363, ZN => n5360);
   U1166 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_7_port, B1 => n5208, B2
                           => REG_28_7_port, ZN => n5363);
   U1167 : INV_X1 port map( A => REG_18_7_port, ZN => n4326);
   U1168 : INV_X1 port map( A => REG_22_7_port, ZN => n4323);
   U1169 : OAI221_X1 port map( B1 => n4328, B2 => n5209, C1 => n5364, C2 => 
                           n5211, A => n5365, ZN => n5359);
   U1170 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_7_port, B1 => n5214, B2
                           => REG_23_7_port, ZN => n5365);
   U1171 : INV_X1 port map( A => REG_20_7_port, ZN => n5364);
   U1172 : INV_X1 port map( A => REG_31_7_port, ZN => n4328);
   U1173 : OAI221_X1 port map( B1 => n4331, B2 => n5215, C1 => n4332, C2 => 
                           n5216, A => n5366, ZN => n5358);
   U1174 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_7_port, B1 => n5219, B2
                           => REG_21_7_port, ZN => n5366);
   U1175 : INV_X1 port map( A => REG_19_7_port, ZN => n4332);
   U1176 : INV_X1 port map( A => REG_25_7_port, ZN => n4331);
   U1177 : NAND2_X1 port map( A1 => n5367, A2 => n5368, ZN => N373);
   U1178 : NOR4_X1 port map( A1 => n5369, A2 => n5370, A3 => n5371, A4 => n5372
                           , ZN => n5368);
   U1179 : OAI221_X1 port map( B1 => n4343, B2 => n5173, C1 => n4344, C2 => 
                           n5174, A => n5373, ZN => n5372);
   U1180 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_8_port, B1 => n5177, B2 
                           => REG_14_8_port, ZN => n5373);
   U1181 : INV_X1 port map( A => REG_8_8_port, ZN => n4344);
   U1182 : INV_X1 port map( A => REG_0_8_port, ZN => n4343);
   U1183 : OAI221_X1 port map( B1 => n4346, B2 => n5178, C1 => n4347, C2 => 
                           n5179, A => n5374, ZN => n5371);
   U1184 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_8_port, B1 => n5182, B2 
                           => REG_12_8_port, ZN => n5374);
   U1185 : INV_X1 port map( A => REG_10_8_port, ZN => n4347);
   U1186 : INV_X1 port map( A => REG_2_8_port, ZN => n4346);
   U1187 : OAI221_X1 port map( B1 => n5375, B2 => n5184, C1 => n5376, C2 => 
                           n5186, A => n5377, ZN => n5370);
   U1188 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_8_port, B1 => n5189, B2 
                           => REG_15_8_port, ZN => n5377);
   U1189 : INV_X1 port map( A => REG_11_8_port, ZN => n5376);
   U1190 : INV_X1 port map( A => REG_3_8_port, ZN => n5375);
   U1191 : OAI221_X1 port map( B1 => n4349, B2 => n5190, C1 => n4350, C2 => 
                           n5191, A => n5378, ZN => n5369);
   U1192 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_8_port, B1 => n5194, B2 
                           => REG_13_8_port, ZN => n5378);
   U1193 : INV_X1 port map( A => REG_9_8_port, ZN => n4350);
   U1194 : INV_X1 port map( A => REG_1_8_port, ZN => n4349);
   U1195 : NOR4_X1 port map( A1 => n5379, A2 => n5380, A3 => n5381, A4 => n5382
                           , ZN => n5367);
   U1196 : OAI221_X1 port map( B1 => n4359, B2 => n5199, C1 => n4363, C2 => 
                           n5200, A => n5383, ZN => n5382);
   U1197 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_8_port, B1 => n5203, B2
                           => REG_16_8_port, ZN => n5383);
   U1198 : INV_X1 port map( A => REG_24_8_port, ZN => n4363);
   U1199 : INV_X1 port map( A => REG_26_8_port, ZN => n4359);
   U1200 : OAI221_X1 port map( B1 => n4357, B2 => n5204, C1 => n4360, C2 => 
                           n5205, A => n5384, ZN => n5381);
   U1201 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_8_port, B1 => n5208, B2
                           => REG_28_8_port, ZN => n5384);
   U1202 : INV_X1 port map( A => REG_18_8_port, ZN => n4360);
   U1203 : INV_X1 port map( A => REG_22_8_port, ZN => n4357);
   U1204 : OAI221_X1 port map( B1 => n4362, B2 => n5209, C1 => n5385, C2 => 
                           n5211, A => n5386, ZN => n5380);
   U1205 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_8_port, B1 => n5214, B2
                           => REG_23_8_port, ZN => n5386);
   U1206 : INV_X1 port map( A => REG_20_8_port, ZN => n5385);
   U1207 : INV_X1 port map( A => REG_31_8_port, ZN => n4362);
   U1208 : OAI221_X1 port map( B1 => n4365, B2 => n5215, C1 => n4366, C2 => 
                           n5216, A => n5387, ZN => n5379);
   U1209 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_8_port, B1 => n5219, B2
                           => REG_21_8_port, ZN => n5387);
   U1210 : INV_X1 port map( A => REG_19_8_port, ZN => n4366);
   U1211 : INV_X1 port map( A => REG_25_8_port, ZN => n4365);
   U1212 : NAND2_X1 port map( A1 => n5388, A2 => n5389, ZN => N372);
   U1213 : NOR4_X1 port map( A1 => n5390, A2 => n5391, A3 => n5392, A4 => n5393
                           , ZN => n5389);
   U1214 : OAI221_X1 port map( B1 => n4377, B2 => n5173, C1 => n4378, C2 => 
                           n5174, A => n5394, ZN => n5393);
   U1215 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_9_port, B1 => n5177, B2 
                           => REG_14_9_port, ZN => n5394);
   U1216 : INV_X1 port map( A => REG_8_9_port, ZN => n4378);
   U1217 : INV_X1 port map( A => REG_0_9_port, ZN => n4377);
   U1218 : OAI221_X1 port map( B1 => n4380, B2 => n5178, C1 => n4381, C2 => 
                           n5179, A => n5395, ZN => n5392);
   U1219 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_9_port, B1 => n5182, B2 
                           => REG_12_9_port, ZN => n5395);
   U1220 : INV_X1 port map( A => REG_10_9_port, ZN => n4381);
   U1221 : INV_X1 port map( A => REG_2_9_port, ZN => n4380);
   U1222 : OAI221_X1 port map( B1 => n5396, B2 => n5184, C1 => n5397, C2 => 
                           n5186, A => n5398, ZN => n5391);
   U1223 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_9_port, B1 => n5189, B2 
                           => REG_15_9_port, ZN => n5398);
   U1224 : INV_X1 port map( A => REG_11_9_port, ZN => n5397);
   U1225 : INV_X1 port map( A => REG_3_9_port, ZN => n5396);
   U1226 : OAI221_X1 port map( B1 => n4383, B2 => n5190, C1 => n4384, C2 => 
                           n5191, A => n5399, ZN => n5390);
   U1227 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_9_port, B1 => n5194, B2 
                           => REG_13_9_port, ZN => n5399);
   U1228 : INV_X1 port map( A => REG_9_9_port, ZN => n4384);
   U1229 : INV_X1 port map( A => REG_1_9_port, ZN => n4383);
   U1230 : NOR4_X1 port map( A1 => n5400, A2 => n5401, A3 => n5402, A4 => n5403
                           , ZN => n5388);
   U1231 : OAI221_X1 port map( B1 => n4393, B2 => n5199, C1 => n4397, C2 => 
                           n5200, A => n5404, ZN => n5403);
   U1232 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_9_port, B1 => n5203, B2
                           => REG_16_9_port, ZN => n5404);
   U1233 : INV_X1 port map( A => REG_24_9_port, ZN => n4397);
   U1234 : INV_X1 port map( A => REG_26_9_port, ZN => n4393);
   U1235 : OAI221_X1 port map( B1 => n4391, B2 => n5204, C1 => n4394, C2 => 
                           n5205, A => n5405, ZN => n5402);
   U1236 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_9_port, B1 => n5208, B2
                           => REG_28_9_port, ZN => n5405);
   U1237 : INV_X1 port map( A => REG_18_9_port, ZN => n4394);
   U1238 : INV_X1 port map( A => REG_22_9_port, ZN => n4391);
   U1239 : OAI221_X1 port map( B1 => n4396, B2 => n5209, C1 => n5406, C2 => 
                           n5211, A => n5407, ZN => n5401);
   U1240 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_9_port, B1 => n5214, B2
                           => REG_23_9_port, ZN => n5407);
   U1241 : INV_X1 port map( A => REG_20_9_port, ZN => n5406);
   U1242 : INV_X1 port map( A => REG_31_9_port, ZN => n4396);
   U1243 : OAI221_X1 port map( B1 => n4399, B2 => n5215, C1 => n4400, C2 => 
                           n5216, A => n5408, ZN => n5400);
   U1244 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_9_port, B1 => n5219, B2
                           => REG_21_9_port, ZN => n5408);
   U1245 : INV_X1 port map( A => REG_19_9_port, ZN => n4400);
   U1246 : INV_X1 port map( A => REG_25_9_port, ZN => n4399);
   U1247 : NAND2_X1 port map( A1 => n5409, A2 => n5410, ZN => N371);
   U1248 : NOR4_X1 port map( A1 => n5411, A2 => n5412, A3 => n5413, A4 => n5414
                           , ZN => n5410);
   U1249 : OAI221_X1 port map( B1 => n4411, B2 => n5173, C1 => n4412, C2 => 
                           n5174, A => n5415, ZN => n5414);
   U1250 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_10_port, B1 => n5177, B2
                           => REG_14_10_port, ZN => n5415);
   U1251 : INV_X1 port map( A => REG_8_10_port, ZN => n4412);
   U1252 : INV_X1 port map( A => REG_0_10_port, ZN => n4411);
   U1253 : OAI221_X1 port map( B1 => n4414, B2 => n5178, C1 => n4415, C2 => 
                           n5179, A => n5416, ZN => n5413);
   U1254 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_10_port, B1 => n5182, B2
                           => REG_12_10_port, ZN => n5416);
   U1255 : INV_X1 port map( A => REG_10_10_port, ZN => n4415);
   U1256 : INV_X1 port map( A => REG_2_10_port, ZN => n4414);
   U1257 : OAI221_X1 port map( B1 => n5417, B2 => n5184, C1 => n5418, C2 => 
                           n5186, A => n5419, ZN => n5412);
   U1258 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_10_port, B1 => n5189, B2
                           => REG_15_10_port, ZN => n5419);
   U1259 : INV_X1 port map( A => REG_11_10_port, ZN => n5418);
   U1260 : INV_X1 port map( A => REG_3_10_port, ZN => n5417);
   U1261 : OAI221_X1 port map( B1 => n4417, B2 => n5190, C1 => n4418, C2 => 
                           n5191, A => n5420, ZN => n5411);
   U1262 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_10_port, B1 => n5194, B2
                           => REG_13_10_port, ZN => n5420);
   U1263 : INV_X1 port map( A => REG_9_10_port, ZN => n4418);
   U1264 : INV_X1 port map( A => REG_1_10_port, ZN => n4417);
   U1265 : NOR4_X1 port map( A1 => n5421, A2 => n5422, A3 => n5423, A4 => n5424
                           , ZN => n5409);
   U1266 : OAI221_X1 port map( B1 => n4427, B2 => n5199, C1 => n4431, C2 => 
                           n5200, A => n5425, ZN => n5424);
   U1267 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_10_port, B1 => n5203, 
                           B2 => REG_16_10_port, ZN => n5425);
   U1268 : INV_X1 port map( A => REG_24_10_port, ZN => n4431);
   U1269 : INV_X1 port map( A => REG_26_10_port, ZN => n4427);
   U1270 : OAI221_X1 port map( B1 => n4425, B2 => n5204, C1 => n4428, C2 => 
                           n5205, A => n5426, ZN => n5423);
   U1271 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_10_port, B1 => n5208, 
                           B2 => REG_28_10_port, ZN => n5426);
   U1272 : INV_X1 port map( A => REG_18_10_port, ZN => n4428);
   U1273 : INV_X1 port map( A => REG_22_10_port, ZN => n4425);
   U1274 : OAI221_X1 port map( B1 => n4430, B2 => n5209, C1 => n5427, C2 => 
                           n5211, A => n5428, ZN => n5422);
   U1275 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_10_port, B1 => n5214, 
                           B2 => REG_23_10_port, ZN => n5428);
   U1276 : INV_X1 port map( A => REG_20_10_port, ZN => n5427);
   U1277 : INV_X1 port map( A => REG_31_10_port, ZN => n4430);
   U1278 : OAI221_X1 port map( B1 => n4433, B2 => n5215, C1 => n4434, C2 => 
                           n5216, A => n5429, ZN => n5421);
   U1279 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_10_port, B1 => n5219, 
                           B2 => REG_21_10_port, ZN => n5429);
   U1280 : INV_X1 port map( A => REG_19_10_port, ZN => n4434);
   U1281 : INV_X1 port map( A => REG_25_10_port, ZN => n4433);
   U1282 : NAND2_X1 port map( A1 => n5430, A2 => n5431, ZN => N370);
   U1283 : NOR4_X1 port map( A1 => n5432, A2 => n5433, A3 => n5434, A4 => n5435
                           , ZN => n5431);
   U1284 : OAI221_X1 port map( B1 => n4445, B2 => n5173, C1 => n4446, C2 => 
                           n5174, A => n5436, ZN => n5435);
   U1285 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_11_port, B1 => n5177, B2
                           => REG_14_11_port, ZN => n5436);
   U1286 : INV_X1 port map( A => REG_8_11_port, ZN => n4446);
   U1287 : INV_X1 port map( A => REG_0_11_port, ZN => n4445);
   U1288 : OAI221_X1 port map( B1 => n4448, B2 => n5178, C1 => n4449, C2 => 
                           n5179, A => n5437, ZN => n5434);
   U1289 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_11_port, B1 => n5182, B2
                           => REG_12_11_port, ZN => n5437);
   U1290 : INV_X1 port map( A => REG_10_11_port, ZN => n4449);
   U1291 : INV_X1 port map( A => REG_2_11_port, ZN => n4448);
   U1292 : OAI221_X1 port map( B1 => n5438, B2 => n5184, C1 => n5439, C2 => 
                           n5186, A => n5440, ZN => n5433);
   U1293 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_11_port, B1 => n5189, B2
                           => REG_15_11_port, ZN => n5440);
   U1294 : INV_X1 port map( A => REG_11_11_port, ZN => n5439);
   U1295 : INV_X1 port map( A => REG_3_11_port, ZN => n5438);
   U1296 : OAI221_X1 port map( B1 => n4451, B2 => n5190, C1 => n4452, C2 => 
                           n5191, A => n5441, ZN => n5432);
   U1297 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_11_port, B1 => n5194, B2
                           => REG_13_11_port, ZN => n5441);
   U1298 : INV_X1 port map( A => REG_9_11_port, ZN => n4452);
   U1299 : INV_X1 port map( A => REG_1_11_port, ZN => n4451);
   U1300 : NOR4_X1 port map( A1 => n5442, A2 => n5443, A3 => n5444, A4 => n5445
                           , ZN => n5430);
   U1301 : OAI221_X1 port map( B1 => n4461, B2 => n5199, C1 => n4465, C2 => 
                           n5200, A => n5446, ZN => n5445);
   U1302 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_11_port, B1 => n5203, 
                           B2 => REG_16_11_port, ZN => n5446);
   U1303 : INV_X1 port map( A => REG_24_11_port, ZN => n4465);
   U1304 : INV_X1 port map( A => REG_26_11_port, ZN => n4461);
   U1305 : OAI221_X1 port map( B1 => n4459, B2 => n5204, C1 => n4462, C2 => 
                           n5205, A => n5447, ZN => n5444);
   U1306 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_11_port, B1 => n5208, 
                           B2 => REG_28_11_port, ZN => n5447);
   U1307 : INV_X1 port map( A => REG_18_11_port, ZN => n4462);
   U1308 : INV_X1 port map( A => REG_22_11_port, ZN => n4459);
   U1309 : OAI221_X1 port map( B1 => n4464, B2 => n5209, C1 => n5448, C2 => 
                           n5211, A => n5449, ZN => n5443);
   U1310 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_11_port, B1 => n5214, 
                           B2 => REG_23_11_port, ZN => n5449);
   U1311 : INV_X1 port map( A => REG_20_11_port, ZN => n5448);
   U1312 : INV_X1 port map( A => REG_31_11_port, ZN => n4464);
   U1313 : OAI221_X1 port map( B1 => n4467, B2 => n5215, C1 => n4468, C2 => 
                           n5216, A => n5450, ZN => n5442);
   U1314 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_11_port, B1 => n5219, 
                           B2 => REG_21_11_port, ZN => n5450);
   U1315 : INV_X1 port map( A => REG_19_11_port, ZN => n4468);
   U1316 : INV_X1 port map( A => REG_25_11_port, ZN => n4467);
   U1317 : NAND2_X1 port map( A1 => n5451, A2 => n5452, ZN => N369);
   U1318 : NOR4_X1 port map( A1 => n5453, A2 => n5454, A3 => n5455, A4 => n5456
                           , ZN => n5452);
   U1319 : OAI221_X1 port map( B1 => n4479, B2 => n5173, C1 => n4480, C2 => 
                           n5174, A => n5457, ZN => n5456);
   U1320 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_12_port, B1 => n5177, B2
                           => REG_14_12_port, ZN => n5457);
   U1321 : INV_X1 port map( A => REG_8_12_port, ZN => n4480);
   U1322 : INV_X1 port map( A => REG_0_12_port, ZN => n4479);
   U1323 : OAI221_X1 port map( B1 => n4482, B2 => n5178, C1 => n4483, C2 => 
                           n5179, A => n5458, ZN => n5455);
   U1324 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_12_port, B1 => n5182, B2
                           => REG_12_12_port, ZN => n5458);
   U1325 : INV_X1 port map( A => REG_10_12_port, ZN => n4483);
   U1326 : INV_X1 port map( A => REG_2_12_port, ZN => n4482);
   U1327 : OAI221_X1 port map( B1 => n5459, B2 => n5184, C1 => n5460, C2 => 
                           n5186, A => n5461, ZN => n5454);
   U1328 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_12_port, B1 => n5189, B2
                           => REG_15_12_port, ZN => n5461);
   U1329 : INV_X1 port map( A => REG_11_12_port, ZN => n5460);
   U1330 : INV_X1 port map( A => REG_3_12_port, ZN => n5459);
   U1331 : OAI221_X1 port map( B1 => n4485, B2 => n5190, C1 => n4486, C2 => 
                           n5191, A => n5462, ZN => n5453);
   U1332 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_12_port, B1 => n5194, B2
                           => REG_13_12_port, ZN => n5462);
   U1333 : INV_X1 port map( A => REG_9_12_port, ZN => n4486);
   U1334 : INV_X1 port map( A => REG_1_12_port, ZN => n4485);
   U1335 : NOR4_X1 port map( A1 => n5463, A2 => n5464, A3 => n5465, A4 => n5466
                           , ZN => n5451);
   U1336 : OAI221_X1 port map( B1 => n4495, B2 => n5199, C1 => n4499, C2 => 
                           n5200, A => n5467, ZN => n5466);
   U1337 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_12_port, B1 => n5203, 
                           B2 => REG_16_12_port, ZN => n5467);
   U1338 : INV_X1 port map( A => REG_24_12_port, ZN => n4499);
   U1339 : INV_X1 port map( A => REG_26_12_port, ZN => n4495);
   U1340 : OAI221_X1 port map( B1 => n4493, B2 => n5204, C1 => n4496, C2 => 
                           n5205, A => n5468, ZN => n5465);
   U1341 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_12_port, B1 => n5208, 
                           B2 => REG_28_12_port, ZN => n5468);
   U1342 : INV_X1 port map( A => REG_18_12_port, ZN => n4496);
   U1343 : INV_X1 port map( A => REG_22_12_port, ZN => n4493);
   U1344 : OAI221_X1 port map( B1 => n4498, B2 => n5209, C1 => n5469, C2 => 
                           n5211, A => n5470, ZN => n5464);
   U1345 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_12_port, B1 => n5214, 
                           B2 => REG_23_12_port, ZN => n5470);
   U1346 : INV_X1 port map( A => REG_20_12_port, ZN => n5469);
   U1347 : INV_X1 port map( A => REG_31_12_port, ZN => n4498);
   U1348 : OAI221_X1 port map( B1 => n4501, B2 => n5215, C1 => n4502, C2 => 
                           n5216, A => n5471, ZN => n5463);
   U1349 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_12_port, B1 => n5219, 
                           B2 => REG_21_12_port, ZN => n5471);
   U1350 : INV_X1 port map( A => REG_19_12_port, ZN => n4502);
   U1351 : INV_X1 port map( A => REG_25_12_port, ZN => n4501);
   U1352 : NAND2_X1 port map( A1 => n5472, A2 => n5473, ZN => N368);
   U1353 : NOR4_X1 port map( A1 => n5474, A2 => n5475, A3 => n5476, A4 => n5477
                           , ZN => n5473);
   U1354 : OAI221_X1 port map( B1 => n4513, B2 => n5173, C1 => n4514, C2 => 
                           n5174, A => n5478, ZN => n5477);
   U1355 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_13_port, B1 => n5177, B2
                           => REG_14_13_port, ZN => n5478);
   U1356 : INV_X1 port map( A => REG_8_13_port, ZN => n4514);
   U1357 : INV_X1 port map( A => REG_0_13_port, ZN => n4513);
   U1358 : OAI221_X1 port map( B1 => n4516, B2 => n5178, C1 => n4517, C2 => 
                           n5179, A => n5479, ZN => n5476);
   U1359 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_13_port, B1 => n5182, B2
                           => REG_12_13_port, ZN => n5479);
   U1360 : INV_X1 port map( A => REG_10_13_port, ZN => n4517);
   U1361 : INV_X1 port map( A => REG_2_13_port, ZN => n4516);
   U1362 : OAI221_X1 port map( B1 => n5480, B2 => n5184, C1 => n5481, C2 => 
                           n5186, A => n5482, ZN => n5475);
   U1363 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_13_port, B1 => n5189, B2
                           => REG_15_13_port, ZN => n5482);
   U1364 : INV_X1 port map( A => REG_11_13_port, ZN => n5481);
   U1365 : INV_X1 port map( A => REG_3_13_port, ZN => n5480);
   U1366 : OAI221_X1 port map( B1 => n4519, B2 => n5190, C1 => n4520, C2 => 
                           n5191, A => n5483, ZN => n5474);
   U1367 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_13_port, B1 => n5194, B2
                           => REG_13_13_port, ZN => n5483);
   U1368 : INV_X1 port map( A => REG_9_13_port, ZN => n4520);
   U1369 : INV_X1 port map( A => REG_1_13_port, ZN => n4519);
   U1370 : NOR4_X1 port map( A1 => n5484, A2 => n5485, A3 => n5486, A4 => n5487
                           , ZN => n5472);
   U1371 : OAI221_X1 port map( B1 => n4529, B2 => n5199, C1 => n4533, C2 => 
                           n5200, A => n5488, ZN => n5487);
   U1372 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_13_port, B1 => n5203, 
                           B2 => REG_16_13_port, ZN => n5488);
   U1373 : INV_X1 port map( A => REG_24_13_port, ZN => n4533);
   U1374 : INV_X1 port map( A => REG_26_13_port, ZN => n4529);
   U1375 : OAI221_X1 port map( B1 => n4527, B2 => n5204, C1 => n4530, C2 => 
                           n5205, A => n5489, ZN => n5486);
   U1376 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_13_port, B1 => n5208, 
                           B2 => REG_28_13_port, ZN => n5489);
   U1377 : INV_X1 port map( A => REG_18_13_port, ZN => n4530);
   U1378 : INV_X1 port map( A => REG_22_13_port, ZN => n4527);
   U1379 : OAI221_X1 port map( B1 => n4532, B2 => n5209, C1 => n5490, C2 => 
                           n5211, A => n5491, ZN => n5485);
   U1380 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_13_port, B1 => n5214, 
                           B2 => REG_23_13_port, ZN => n5491);
   U1381 : INV_X1 port map( A => REG_20_13_port, ZN => n5490);
   U1382 : INV_X1 port map( A => REG_31_13_port, ZN => n4532);
   U1383 : OAI221_X1 port map( B1 => n4535, B2 => n5215, C1 => n4536, C2 => 
                           n5216, A => n5492, ZN => n5484);
   U1384 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_13_port, B1 => n5219, 
                           B2 => REG_21_13_port, ZN => n5492);
   U1385 : INV_X1 port map( A => REG_19_13_port, ZN => n4536);
   U1386 : INV_X1 port map( A => REG_25_13_port, ZN => n4535);
   U1387 : NAND2_X1 port map( A1 => n5493, A2 => n5494, ZN => N367);
   U1388 : NOR4_X1 port map( A1 => n5495, A2 => n5496, A3 => n5497, A4 => n5498
                           , ZN => n5494);
   U1389 : OAI221_X1 port map( B1 => n4547, B2 => n5173, C1 => n4548, C2 => 
                           n5174, A => n5499, ZN => n5498);
   U1390 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_14_port, B1 => n5177, B2
                           => REG_14_14_port, ZN => n5499);
   U1391 : INV_X1 port map( A => REG_8_14_port, ZN => n4548);
   U1392 : INV_X1 port map( A => REG_0_14_port, ZN => n4547);
   U1393 : OAI221_X1 port map( B1 => n4550, B2 => n5178, C1 => n4551, C2 => 
                           n5179, A => n5500, ZN => n5497);
   U1394 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_14_port, B1 => n5182, B2
                           => REG_12_14_port, ZN => n5500);
   U1395 : INV_X1 port map( A => REG_10_14_port, ZN => n4551);
   U1396 : INV_X1 port map( A => REG_2_14_port, ZN => n4550);
   U1397 : OAI221_X1 port map( B1 => n5501, B2 => n5184, C1 => n5502, C2 => 
                           n5186, A => n5503, ZN => n5496);
   U1398 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_14_port, B1 => n5189, B2
                           => REG_15_14_port, ZN => n5503);
   U1399 : INV_X1 port map( A => REG_11_14_port, ZN => n5502);
   U1400 : INV_X1 port map( A => REG_3_14_port, ZN => n5501);
   U1401 : OAI221_X1 port map( B1 => n4553, B2 => n5190, C1 => n4554, C2 => 
                           n5191, A => n5504, ZN => n5495);
   U1402 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_14_port, B1 => n5194, B2
                           => REG_13_14_port, ZN => n5504);
   U1403 : INV_X1 port map( A => REG_9_14_port, ZN => n4554);
   U1404 : INV_X1 port map( A => REG_1_14_port, ZN => n4553);
   U1405 : NOR4_X1 port map( A1 => n5505, A2 => n5506, A3 => n5507, A4 => n5508
                           , ZN => n5493);
   U1406 : OAI221_X1 port map( B1 => n4563, B2 => n5199, C1 => n4567, C2 => 
                           n5200, A => n5509, ZN => n5508);
   U1407 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_14_port, B1 => n5203, 
                           B2 => REG_16_14_port, ZN => n5509);
   U1408 : INV_X1 port map( A => REG_24_14_port, ZN => n4567);
   U1409 : INV_X1 port map( A => REG_26_14_port, ZN => n4563);
   U1410 : OAI221_X1 port map( B1 => n4561, B2 => n5204, C1 => n4564, C2 => 
                           n5205, A => n5510, ZN => n5507);
   U1411 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_14_port, B1 => n5208, 
                           B2 => REG_28_14_port, ZN => n5510);
   U1412 : INV_X1 port map( A => REG_18_14_port, ZN => n4564);
   U1413 : INV_X1 port map( A => REG_22_14_port, ZN => n4561);
   U1414 : OAI221_X1 port map( B1 => n4566, B2 => n5209, C1 => n5511, C2 => 
                           n5211, A => n5512, ZN => n5506);
   U1415 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_14_port, B1 => n5214, 
                           B2 => REG_23_14_port, ZN => n5512);
   U1416 : INV_X1 port map( A => REG_20_14_port, ZN => n5511);
   U1417 : INV_X1 port map( A => REG_31_14_port, ZN => n4566);
   U1418 : OAI221_X1 port map( B1 => n4569, B2 => n5215, C1 => n4570, C2 => 
                           n5216, A => n5513, ZN => n5505);
   U1419 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_14_port, B1 => n5219, 
                           B2 => REG_21_14_port, ZN => n5513);
   U1420 : INV_X1 port map( A => REG_19_14_port, ZN => n4570);
   U1421 : INV_X1 port map( A => REG_25_14_port, ZN => n4569);
   U1422 : NAND2_X1 port map( A1 => n5514, A2 => n5515, ZN => N366);
   U1423 : NOR4_X1 port map( A1 => n5516, A2 => n5517, A3 => n5518, A4 => n5519
                           , ZN => n5515);
   U1424 : OAI221_X1 port map( B1 => n4581, B2 => n5173, C1 => n4582, C2 => 
                           n5174, A => n5520, ZN => n5519);
   U1425 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_15_port, B1 => n5177, B2
                           => REG_14_15_port, ZN => n5520);
   U1426 : INV_X1 port map( A => REG_8_15_port, ZN => n4582);
   U1427 : INV_X1 port map( A => REG_0_15_port, ZN => n4581);
   U1428 : OAI221_X1 port map( B1 => n4584, B2 => n5178, C1 => n4585, C2 => 
                           n5179, A => n5521, ZN => n5518);
   U1429 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_15_port, B1 => n5182, B2
                           => REG_12_15_port, ZN => n5521);
   U1430 : INV_X1 port map( A => REG_10_15_port, ZN => n4585);
   U1431 : INV_X1 port map( A => REG_2_15_port, ZN => n4584);
   U1432 : OAI221_X1 port map( B1 => n5522, B2 => n5184, C1 => n5523, C2 => 
                           n5186, A => n5524, ZN => n5517);
   U1433 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_15_port, B1 => n5189, B2
                           => REG_15_15_port, ZN => n5524);
   U1434 : INV_X1 port map( A => REG_11_15_port, ZN => n5523);
   U1435 : INV_X1 port map( A => REG_3_15_port, ZN => n5522);
   U1436 : OAI221_X1 port map( B1 => n4587, B2 => n5190, C1 => n4588, C2 => 
                           n5191, A => n5525, ZN => n5516);
   U1437 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_15_port, B1 => n5194, B2
                           => REG_13_15_port, ZN => n5525);
   U1438 : INV_X1 port map( A => REG_9_15_port, ZN => n4588);
   U1439 : INV_X1 port map( A => REG_1_15_port, ZN => n4587);
   U1440 : NOR4_X1 port map( A1 => n5526, A2 => n5527, A3 => n5528, A4 => n5529
                           , ZN => n5514);
   U1441 : OAI221_X1 port map( B1 => n4597, B2 => n5199, C1 => n4601, C2 => 
                           n5200, A => n5530, ZN => n5529);
   U1442 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_15_port, B1 => n5203, 
                           B2 => REG_16_15_port, ZN => n5530);
   U1443 : INV_X1 port map( A => REG_24_15_port, ZN => n4601);
   U1444 : INV_X1 port map( A => REG_26_15_port, ZN => n4597);
   U1445 : OAI221_X1 port map( B1 => n4595, B2 => n5204, C1 => n4598, C2 => 
                           n5205, A => n5531, ZN => n5528);
   U1446 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_15_port, B1 => n5208, 
                           B2 => REG_28_15_port, ZN => n5531);
   U1447 : INV_X1 port map( A => REG_18_15_port, ZN => n4598);
   U1448 : INV_X1 port map( A => REG_22_15_port, ZN => n4595);
   U1449 : OAI221_X1 port map( B1 => n4600, B2 => n5209, C1 => n5532, C2 => 
                           n5211, A => n5533, ZN => n5527);
   U1450 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_15_port, B1 => n5214, 
                           B2 => REG_23_15_port, ZN => n5533);
   U1451 : INV_X1 port map( A => REG_20_15_port, ZN => n5532);
   U1452 : INV_X1 port map( A => REG_31_15_port, ZN => n4600);
   U1453 : OAI221_X1 port map( B1 => n4603, B2 => n5215, C1 => n4604, C2 => 
                           n5216, A => n5534, ZN => n5526);
   U1454 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_15_port, B1 => n5219, 
                           B2 => REG_21_15_port, ZN => n5534);
   U1455 : INV_X1 port map( A => REG_19_15_port, ZN => n4604);
   U1456 : INV_X1 port map( A => REG_25_15_port, ZN => n4603);
   U1457 : NAND2_X1 port map( A1 => n5535, A2 => n5536, ZN => N365);
   U1458 : NOR4_X1 port map( A1 => n5537, A2 => n5538, A3 => n5539, A4 => n5540
                           , ZN => n5536);
   U1459 : OAI221_X1 port map( B1 => n4615, B2 => n5173, C1 => n4616, C2 => 
                           n5174, A => n5541, ZN => n5540);
   U1460 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_16_port, B1 => n5177, B2
                           => REG_14_16_port, ZN => n5541);
   U1461 : INV_X1 port map( A => REG_8_16_port, ZN => n4616);
   U1462 : INV_X1 port map( A => REG_0_16_port, ZN => n4615);
   U1463 : OAI221_X1 port map( B1 => n4618, B2 => n5178, C1 => n4619, C2 => 
                           n5179, A => n5542, ZN => n5539);
   U1464 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_16_port, B1 => n5182, B2
                           => REG_12_16_port, ZN => n5542);
   U1465 : INV_X1 port map( A => REG_10_16_port, ZN => n4619);
   U1466 : INV_X1 port map( A => REG_2_16_port, ZN => n4618);
   U1467 : OAI221_X1 port map( B1 => n5543, B2 => n5184, C1 => n5544, C2 => 
                           n5186, A => n5545, ZN => n5538);
   U1468 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_16_port, B1 => n5189, B2
                           => REG_15_16_port, ZN => n5545);
   U1469 : INV_X1 port map( A => REG_11_16_port, ZN => n5544);
   U1470 : INV_X1 port map( A => REG_3_16_port, ZN => n5543);
   U1471 : OAI221_X1 port map( B1 => n4621, B2 => n5190, C1 => n4622, C2 => 
                           n5191, A => n5546, ZN => n5537);
   U1472 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_16_port, B1 => n5194, B2
                           => REG_13_16_port, ZN => n5546);
   U1473 : INV_X1 port map( A => REG_9_16_port, ZN => n4622);
   U1474 : INV_X1 port map( A => REG_1_16_port, ZN => n4621);
   U1475 : NOR4_X1 port map( A1 => n5547, A2 => n5548, A3 => n5549, A4 => n5550
                           , ZN => n5535);
   U1476 : OAI221_X1 port map( B1 => n4631, B2 => n5199, C1 => n4635, C2 => 
                           n5200, A => n5551, ZN => n5550);
   U1477 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_16_port, B1 => n5203, 
                           B2 => REG_16_16_port, ZN => n5551);
   U1478 : INV_X1 port map( A => REG_24_16_port, ZN => n4635);
   U1479 : INV_X1 port map( A => REG_26_16_port, ZN => n4631);
   U1480 : OAI221_X1 port map( B1 => n4629, B2 => n5204, C1 => n4632, C2 => 
                           n5205, A => n5552, ZN => n5549);
   U1481 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_16_port, B1 => n5208, 
                           B2 => REG_28_16_port, ZN => n5552);
   U1482 : INV_X1 port map( A => REG_18_16_port, ZN => n4632);
   U1483 : INV_X1 port map( A => REG_22_16_port, ZN => n4629);
   U1484 : OAI221_X1 port map( B1 => n4634, B2 => n5209, C1 => n5553, C2 => 
                           n5211, A => n5554, ZN => n5548);
   U1485 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_16_port, B1 => n5214, 
                           B2 => REG_23_16_port, ZN => n5554);
   U1486 : INV_X1 port map( A => REG_20_16_port, ZN => n5553);
   U1487 : INV_X1 port map( A => REG_31_16_port, ZN => n4634);
   U1488 : OAI221_X1 port map( B1 => n4637, B2 => n5215, C1 => n4638, C2 => 
                           n5216, A => n5555, ZN => n5547);
   U1489 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_16_port, B1 => n5219, 
                           B2 => REG_21_16_port, ZN => n5555);
   U1490 : INV_X1 port map( A => REG_19_16_port, ZN => n4638);
   U1491 : INV_X1 port map( A => REG_25_16_port, ZN => n4637);
   U1492 : NAND2_X1 port map( A1 => n5556, A2 => n5557, ZN => N364);
   U1493 : NOR4_X1 port map( A1 => n5558, A2 => n5559, A3 => n5560, A4 => n5561
                           , ZN => n5557);
   U1494 : OAI221_X1 port map( B1 => n4649, B2 => n5173, C1 => n4650, C2 => 
                           n5174, A => n5562, ZN => n5561);
   U1495 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_17_port, B1 => n5177, B2
                           => REG_14_17_port, ZN => n5562);
   U1496 : INV_X1 port map( A => REG_8_17_port, ZN => n4650);
   U1497 : INV_X1 port map( A => REG_0_17_port, ZN => n4649);
   U1498 : OAI221_X1 port map( B1 => n4652, B2 => n5178, C1 => n4653, C2 => 
                           n5179, A => n5563, ZN => n5560);
   U1499 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_17_port, B1 => n5182, B2
                           => REG_12_17_port, ZN => n5563);
   U1500 : INV_X1 port map( A => REG_10_17_port, ZN => n4653);
   U1501 : INV_X1 port map( A => REG_2_17_port, ZN => n4652);
   U1502 : OAI221_X1 port map( B1 => n5564, B2 => n5184, C1 => n5565, C2 => 
                           n5186, A => n5566, ZN => n5559);
   U1503 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_17_port, B1 => n5189, B2
                           => REG_15_17_port, ZN => n5566);
   U1504 : INV_X1 port map( A => REG_11_17_port, ZN => n5565);
   U1505 : INV_X1 port map( A => REG_3_17_port, ZN => n5564);
   U1506 : OAI221_X1 port map( B1 => n4655, B2 => n5190, C1 => n4656, C2 => 
                           n5191, A => n5567, ZN => n5558);
   U1507 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_17_port, B1 => n5194, B2
                           => REG_13_17_port, ZN => n5567);
   U1508 : INV_X1 port map( A => REG_9_17_port, ZN => n4656);
   U1509 : INV_X1 port map( A => REG_1_17_port, ZN => n4655);
   U1510 : NOR4_X1 port map( A1 => n5568, A2 => n5569, A3 => n5570, A4 => n5571
                           , ZN => n5556);
   U1511 : OAI221_X1 port map( B1 => n4665, B2 => n5199, C1 => n4669, C2 => 
                           n5200, A => n5572, ZN => n5571);
   U1512 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_17_port, B1 => n5203, 
                           B2 => REG_16_17_port, ZN => n5572);
   U1513 : INV_X1 port map( A => REG_24_17_port, ZN => n4669);
   U1514 : INV_X1 port map( A => REG_26_17_port, ZN => n4665);
   U1515 : OAI221_X1 port map( B1 => n4663, B2 => n5204, C1 => n4666, C2 => 
                           n5205, A => n5573, ZN => n5570);
   U1516 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_17_port, B1 => n5208, 
                           B2 => REG_28_17_port, ZN => n5573);
   U1517 : INV_X1 port map( A => REG_18_17_port, ZN => n4666);
   U1518 : INV_X1 port map( A => REG_22_17_port, ZN => n4663);
   U1519 : OAI221_X1 port map( B1 => n4668, B2 => n5209, C1 => n5574, C2 => 
                           n5211, A => n5575, ZN => n5569);
   U1520 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_17_port, B1 => n5214, 
                           B2 => REG_23_17_port, ZN => n5575);
   U1521 : INV_X1 port map( A => REG_20_17_port, ZN => n5574);
   U1522 : INV_X1 port map( A => REG_31_17_port, ZN => n4668);
   U1523 : OAI221_X1 port map( B1 => n4671, B2 => n5215, C1 => n4672, C2 => 
                           n5216, A => n5576, ZN => n5568);
   U1524 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_17_port, B1 => n5219, 
                           B2 => REG_21_17_port, ZN => n5576);
   U1525 : INV_X1 port map( A => REG_19_17_port, ZN => n4672);
   U1526 : INV_X1 port map( A => REG_25_17_port, ZN => n4671);
   U1527 : NAND2_X1 port map( A1 => n5577, A2 => n5578, ZN => N363);
   U1528 : NOR4_X1 port map( A1 => n5579, A2 => n5580, A3 => n5581, A4 => n5582
                           , ZN => n5578);
   U1529 : OAI221_X1 port map( B1 => n4683, B2 => n5173, C1 => n4684, C2 => 
                           n5174, A => n5583, ZN => n5582);
   U1530 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_18_port, B1 => n5177, B2
                           => REG_14_18_port, ZN => n5583);
   U1531 : INV_X1 port map( A => REG_8_18_port, ZN => n4684);
   U1532 : INV_X1 port map( A => REG_0_18_port, ZN => n4683);
   U1533 : OAI221_X1 port map( B1 => n4686, B2 => n5178, C1 => n4687, C2 => 
                           n5179, A => n5584, ZN => n5581);
   U1534 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_18_port, B1 => n5182, B2
                           => REG_12_18_port, ZN => n5584);
   U1535 : INV_X1 port map( A => REG_10_18_port, ZN => n4687);
   U1536 : INV_X1 port map( A => REG_2_18_port, ZN => n4686);
   U1537 : OAI221_X1 port map( B1 => n5585, B2 => n5184, C1 => n5586, C2 => 
                           n5186, A => n5587, ZN => n5580);
   U1538 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_18_port, B1 => n5189, B2
                           => REG_15_18_port, ZN => n5587);
   U1539 : INV_X1 port map( A => REG_11_18_port, ZN => n5586);
   U1540 : INV_X1 port map( A => REG_3_18_port, ZN => n5585);
   U1541 : OAI221_X1 port map( B1 => n4689, B2 => n5190, C1 => n4690, C2 => 
                           n5191, A => n5588, ZN => n5579);
   U1542 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_18_port, B1 => n5194, B2
                           => REG_13_18_port, ZN => n5588);
   U1543 : INV_X1 port map( A => REG_9_18_port, ZN => n4690);
   U1544 : INV_X1 port map( A => REG_1_18_port, ZN => n4689);
   U1545 : NOR4_X1 port map( A1 => n5589, A2 => n5590, A3 => n5591, A4 => n5592
                           , ZN => n5577);
   U1546 : OAI221_X1 port map( B1 => n4699, B2 => n5199, C1 => n4703, C2 => 
                           n5200, A => n5593, ZN => n5592);
   U1547 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_18_port, B1 => n5203, 
                           B2 => REG_16_18_port, ZN => n5593);
   U1548 : INV_X1 port map( A => REG_24_18_port, ZN => n4703);
   U1549 : INV_X1 port map( A => REG_26_18_port, ZN => n4699);
   U1550 : OAI221_X1 port map( B1 => n4697, B2 => n5204, C1 => n4700, C2 => 
                           n5205, A => n5594, ZN => n5591);
   U1551 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_18_port, B1 => n5208, 
                           B2 => REG_28_18_port, ZN => n5594);
   U1552 : INV_X1 port map( A => REG_18_18_port, ZN => n4700);
   U1553 : INV_X1 port map( A => REG_22_18_port, ZN => n4697);
   U1554 : OAI221_X1 port map( B1 => n4702, B2 => n5209, C1 => n5595, C2 => 
                           n5211, A => n5596, ZN => n5590);
   U1555 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_18_port, B1 => n5214, 
                           B2 => REG_23_18_port, ZN => n5596);
   U1556 : INV_X1 port map( A => REG_20_18_port, ZN => n5595);
   U1557 : INV_X1 port map( A => REG_31_18_port, ZN => n4702);
   U1558 : OAI221_X1 port map( B1 => n4705, B2 => n5215, C1 => n4706, C2 => 
                           n5216, A => n5597, ZN => n5589);
   U1559 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_18_port, B1 => n5219, 
                           B2 => REG_21_18_port, ZN => n5597);
   U1560 : INV_X1 port map( A => REG_19_18_port, ZN => n4706);
   U1561 : INV_X1 port map( A => REG_25_18_port, ZN => n4705);
   U1562 : NAND2_X1 port map( A1 => n5598, A2 => n5599, ZN => N362);
   U1563 : NOR4_X1 port map( A1 => n5600, A2 => n5601, A3 => n5602, A4 => n5603
                           , ZN => n5599);
   U1564 : OAI221_X1 port map( B1 => n4717, B2 => n5173, C1 => n4718, C2 => 
                           n5174, A => n5604, ZN => n5603);
   U1565 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_19_port, B1 => n5177, B2
                           => REG_14_19_port, ZN => n5604);
   U1566 : INV_X1 port map( A => REG_8_19_port, ZN => n4718);
   U1567 : INV_X1 port map( A => REG_0_19_port, ZN => n4717);
   U1568 : OAI221_X1 port map( B1 => n4720, B2 => n5178, C1 => n4721, C2 => 
                           n5179, A => n5605, ZN => n5602);
   U1569 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_19_port, B1 => n5182, B2
                           => REG_12_19_port, ZN => n5605);
   U1570 : INV_X1 port map( A => REG_10_19_port, ZN => n4721);
   U1571 : INV_X1 port map( A => REG_2_19_port, ZN => n4720);
   U1572 : OAI221_X1 port map( B1 => n5606, B2 => n5184, C1 => n5607, C2 => 
                           n5186, A => n5608, ZN => n5601);
   U1573 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_19_port, B1 => n5189, B2
                           => REG_15_19_port, ZN => n5608);
   U1574 : INV_X1 port map( A => REG_11_19_port, ZN => n5607);
   U1575 : INV_X1 port map( A => REG_3_19_port, ZN => n5606);
   U1576 : OAI221_X1 port map( B1 => n4723, B2 => n5190, C1 => n4724, C2 => 
                           n5191, A => n5609, ZN => n5600);
   U1577 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_19_port, B1 => n5194, B2
                           => REG_13_19_port, ZN => n5609);
   U1578 : INV_X1 port map( A => REG_9_19_port, ZN => n4724);
   U1579 : INV_X1 port map( A => REG_1_19_port, ZN => n4723);
   U1580 : NOR4_X1 port map( A1 => n5610, A2 => n5611, A3 => n5612, A4 => n5613
                           , ZN => n5598);
   U1581 : OAI221_X1 port map( B1 => n4733, B2 => n5199, C1 => n4737, C2 => 
                           n5200, A => n5614, ZN => n5613);
   U1582 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_19_port, B1 => n5203, 
                           B2 => REG_16_19_port, ZN => n5614);
   U1583 : INV_X1 port map( A => REG_24_19_port, ZN => n4737);
   U1584 : INV_X1 port map( A => REG_26_19_port, ZN => n4733);
   U1585 : OAI221_X1 port map( B1 => n4731, B2 => n5204, C1 => n4734, C2 => 
                           n5205, A => n5615, ZN => n5612);
   U1586 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_19_port, B1 => n5208, 
                           B2 => REG_28_19_port, ZN => n5615);
   U1587 : INV_X1 port map( A => REG_18_19_port, ZN => n4734);
   U1588 : INV_X1 port map( A => REG_22_19_port, ZN => n4731);
   U1589 : OAI221_X1 port map( B1 => n4736, B2 => n5209, C1 => n5616, C2 => 
                           n5211, A => n5617, ZN => n5611);
   U1590 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_19_port, B1 => n5214, 
                           B2 => REG_23_19_port, ZN => n5617);
   U1591 : INV_X1 port map( A => REG_20_19_port, ZN => n5616);
   U1592 : INV_X1 port map( A => REG_31_19_port, ZN => n4736);
   U1593 : OAI221_X1 port map( B1 => n4739, B2 => n5215, C1 => n4740, C2 => 
                           n5216, A => n5618, ZN => n5610);
   U1594 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_19_port, B1 => n5219, 
                           B2 => REG_21_19_port, ZN => n5618);
   U1595 : INV_X1 port map( A => REG_19_19_port, ZN => n4740);
   U1596 : INV_X1 port map( A => REG_25_19_port, ZN => n4739);
   U1597 : NAND2_X1 port map( A1 => n5619, A2 => n5620, ZN => N361);
   U1598 : NOR4_X1 port map( A1 => n5621, A2 => n5622, A3 => n5623, A4 => n5624
                           , ZN => n5620);
   U1599 : OAI221_X1 port map( B1 => n4751, B2 => n5173, C1 => n4752, C2 => 
                           n5174, A => n5625, ZN => n5624);
   U1600 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_20_port, B1 => n5177, B2
                           => REG_14_20_port, ZN => n5625);
   U1601 : INV_X1 port map( A => REG_8_20_port, ZN => n4752);
   U1602 : INV_X1 port map( A => REG_0_20_port, ZN => n4751);
   U1603 : OAI221_X1 port map( B1 => n4754, B2 => n5178, C1 => n4755, C2 => 
                           n5179, A => n5626, ZN => n5623);
   U1604 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_20_port, B1 => n5182, B2
                           => REG_12_20_port, ZN => n5626);
   U1605 : INV_X1 port map( A => REG_10_20_port, ZN => n4755);
   U1606 : INV_X1 port map( A => REG_2_20_port, ZN => n4754);
   U1607 : OAI221_X1 port map( B1 => n5627, B2 => n5184, C1 => n5628, C2 => 
                           n5186, A => n5629, ZN => n5622);
   U1608 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_20_port, B1 => n5189, B2
                           => REG_15_20_port, ZN => n5629);
   U1609 : INV_X1 port map( A => REG_11_20_port, ZN => n5628);
   U1610 : INV_X1 port map( A => REG_3_20_port, ZN => n5627);
   U1611 : OAI221_X1 port map( B1 => n4757, B2 => n5190, C1 => n4758, C2 => 
                           n5191, A => n5630, ZN => n5621);
   U1612 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_20_port, B1 => n5194, B2
                           => REG_13_20_port, ZN => n5630);
   U1613 : INV_X1 port map( A => REG_9_20_port, ZN => n4758);
   U1614 : INV_X1 port map( A => REG_1_20_port, ZN => n4757);
   U1615 : NOR4_X1 port map( A1 => n5631, A2 => n5632, A3 => n5633, A4 => n5634
                           , ZN => n5619);
   U1616 : OAI221_X1 port map( B1 => n4767, B2 => n5199, C1 => n4771, C2 => 
                           n5200, A => n5635, ZN => n5634);
   U1617 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_20_port, B1 => n5203, 
                           B2 => REG_16_20_port, ZN => n5635);
   U1618 : INV_X1 port map( A => REG_24_20_port, ZN => n4771);
   U1619 : INV_X1 port map( A => REG_26_20_port, ZN => n4767);
   U1620 : OAI221_X1 port map( B1 => n4765, B2 => n5204, C1 => n4768, C2 => 
                           n5205, A => n5636, ZN => n5633);
   U1621 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_20_port, B1 => n5208, 
                           B2 => REG_28_20_port, ZN => n5636);
   U1622 : INV_X1 port map( A => REG_18_20_port, ZN => n4768);
   U1623 : INV_X1 port map( A => REG_22_20_port, ZN => n4765);
   U1624 : OAI221_X1 port map( B1 => n4770, B2 => n5209, C1 => n5637, C2 => 
                           n5211, A => n5638, ZN => n5632);
   U1625 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_20_port, B1 => n5214, 
                           B2 => REG_23_20_port, ZN => n5638);
   U1626 : INV_X1 port map( A => REG_20_20_port, ZN => n5637);
   U1627 : INV_X1 port map( A => REG_31_20_port, ZN => n4770);
   U1628 : OAI221_X1 port map( B1 => n4773, B2 => n5215, C1 => n4774, C2 => 
                           n5216, A => n5639, ZN => n5631);
   U1629 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_20_port, B1 => n5219, 
                           B2 => REG_21_20_port, ZN => n5639);
   U1630 : INV_X1 port map( A => REG_19_20_port, ZN => n4774);
   U1631 : INV_X1 port map( A => REG_25_20_port, ZN => n4773);
   U1632 : NAND2_X1 port map( A1 => n5640, A2 => n5641, ZN => N360);
   U1633 : NOR4_X1 port map( A1 => n5642, A2 => n5643, A3 => n5644, A4 => n5645
                           , ZN => n5641);
   U1634 : OAI221_X1 port map( B1 => n4785, B2 => n5173, C1 => n4786, C2 => 
                           n5174, A => n5646, ZN => n5645);
   U1635 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_21_port, B1 => n5177, B2
                           => REG_14_21_port, ZN => n5646);
   U1636 : INV_X1 port map( A => REG_8_21_port, ZN => n4786);
   U1637 : INV_X1 port map( A => REG_0_21_port, ZN => n4785);
   U1638 : OAI221_X1 port map( B1 => n4788, B2 => n5178, C1 => n4789, C2 => 
                           n5179, A => n5647, ZN => n5644);
   U1639 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_21_port, B1 => n5182, B2
                           => REG_12_21_port, ZN => n5647);
   U1640 : INV_X1 port map( A => REG_10_21_port, ZN => n4789);
   U1641 : INV_X1 port map( A => REG_2_21_port, ZN => n4788);
   U1642 : OAI221_X1 port map( B1 => n5648, B2 => n5184, C1 => n5649, C2 => 
                           n5186, A => n5650, ZN => n5643);
   U1643 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_21_port, B1 => n5189, B2
                           => REG_15_21_port, ZN => n5650);
   U1644 : INV_X1 port map( A => REG_11_21_port, ZN => n5649);
   U1645 : INV_X1 port map( A => REG_3_21_port, ZN => n5648);
   U1646 : OAI221_X1 port map( B1 => n4791, B2 => n5190, C1 => n4792, C2 => 
                           n5191, A => n5651, ZN => n5642);
   U1647 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_21_port, B1 => n5194, B2
                           => REG_13_21_port, ZN => n5651);
   U1648 : INV_X1 port map( A => REG_9_21_port, ZN => n4792);
   U1649 : INV_X1 port map( A => REG_1_21_port, ZN => n4791);
   U1650 : NOR4_X1 port map( A1 => n5652, A2 => n5653, A3 => n5654, A4 => n5655
                           , ZN => n5640);
   U1651 : OAI221_X1 port map( B1 => n4801, B2 => n5199, C1 => n4805, C2 => 
                           n5200, A => n5656, ZN => n5655);
   U1652 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_21_port, B1 => n5203, 
                           B2 => REG_16_21_port, ZN => n5656);
   U1653 : INV_X1 port map( A => REG_24_21_port, ZN => n4805);
   U1654 : INV_X1 port map( A => REG_26_21_port, ZN => n4801);
   U1655 : OAI221_X1 port map( B1 => n4799, B2 => n5204, C1 => n4802, C2 => 
                           n5205, A => n5657, ZN => n5654);
   U1656 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_21_port, B1 => n5208, 
                           B2 => REG_28_21_port, ZN => n5657);
   U1657 : INV_X1 port map( A => REG_18_21_port, ZN => n4802);
   U1658 : INV_X1 port map( A => REG_22_21_port, ZN => n4799);
   U1659 : OAI221_X1 port map( B1 => n4804, B2 => n5209, C1 => n5658, C2 => 
                           n5211, A => n5659, ZN => n5653);
   U1660 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_21_port, B1 => n5214, 
                           B2 => REG_23_21_port, ZN => n5659);
   U1661 : INV_X1 port map( A => REG_20_21_port, ZN => n5658);
   U1662 : INV_X1 port map( A => REG_31_21_port, ZN => n4804);
   U1663 : OAI221_X1 port map( B1 => n4807, B2 => n5215, C1 => n4808, C2 => 
                           n5216, A => n5660, ZN => n5652);
   U1664 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_21_port, B1 => n5219, 
                           B2 => REG_21_21_port, ZN => n5660);
   U1665 : INV_X1 port map( A => REG_19_21_port, ZN => n4808);
   U1666 : INV_X1 port map( A => REG_25_21_port, ZN => n4807);
   U1667 : NAND2_X1 port map( A1 => n5661, A2 => n5662, ZN => N359);
   U1668 : NOR4_X1 port map( A1 => n5663, A2 => n5664, A3 => n5665, A4 => n5666
                           , ZN => n5662);
   U1669 : OAI221_X1 port map( B1 => n4819, B2 => n5173, C1 => n4820, C2 => 
                           n5174, A => n5667, ZN => n5666);
   U1670 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_22_port, B1 => n5177, B2
                           => REG_14_22_port, ZN => n5667);
   U1671 : INV_X1 port map( A => REG_8_22_port, ZN => n4820);
   U1672 : INV_X1 port map( A => REG_0_22_port, ZN => n4819);
   U1673 : OAI221_X1 port map( B1 => n4822, B2 => n5178, C1 => n4823, C2 => 
                           n5179, A => n5668, ZN => n5665);
   U1674 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_22_port, B1 => n5182, B2
                           => REG_12_22_port, ZN => n5668);
   U1675 : INV_X1 port map( A => REG_10_22_port, ZN => n4823);
   U1676 : INV_X1 port map( A => REG_2_22_port, ZN => n4822);
   U1677 : OAI221_X1 port map( B1 => n5669, B2 => n5184, C1 => n5670, C2 => 
                           n5186, A => n5671, ZN => n5664);
   U1678 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_22_port, B1 => n5189, B2
                           => REG_15_22_port, ZN => n5671);
   U1679 : INV_X1 port map( A => REG_11_22_port, ZN => n5670);
   U1680 : INV_X1 port map( A => REG_3_22_port, ZN => n5669);
   U1681 : OAI221_X1 port map( B1 => n4825, B2 => n5190, C1 => n4826, C2 => 
                           n5191, A => n5672, ZN => n5663);
   U1682 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_22_port, B1 => n5194, B2
                           => REG_13_22_port, ZN => n5672);
   U1683 : INV_X1 port map( A => REG_9_22_port, ZN => n4826);
   U1684 : INV_X1 port map( A => REG_1_22_port, ZN => n4825);
   U1685 : NOR4_X1 port map( A1 => n5673, A2 => n5674, A3 => n5675, A4 => n5676
                           , ZN => n5661);
   U1686 : OAI221_X1 port map( B1 => n4835, B2 => n5199, C1 => n4839, C2 => 
                           n5200, A => n5677, ZN => n5676);
   U1687 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_22_port, B1 => n5203, 
                           B2 => REG_16_22_port, ZN => n5677);
   U1688 : INV_X1 port map( A => REG_24_22_port, ZN => n4839);
   U1689 : INV_X1 port map( A => REG_26_22_port, ZN => n4835);
   U1690 : OAI221_X1 port map( B1 => n4833, B2 => n5204, C1 => n4836, C2 => 
                           n5205, A => n5678, ZN => n5675);
   U1691 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_22_port, B1 => n5208, 
                           B2 => REG_28_22_port, ZN => n5678);
   U1692 : INV_X1 port map( A => REG_18_22_port, ZN => n4836);
   U1693 : INV_X1 port map( A => REG_22_22_port, ZN => n4833);
   U1694 : OAI221_X1 port map( B1 => n4838, B2 => n5209, C1 => n5679, C2 => 
                           n5211, A => n5680, ZN => n5674);
   U1695 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_22_port, B1 => n5214, 
                           B2 => REG_23_22_port, ZN => n5680);
   U1696 : INV_X1 port map( A => REG_20_22_port, ZN => n5679);
   U1697 : INV_X1 port map( A => REG_31_22_port, ZN => n4838);
   U1698 : OAI221_X1 port map( B1 => n4841, B2 => n5215, C1 => n4842, C2 => 
                           n5216, A => n5681, ZN => n5673);
   U1699 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_22_port, B1 => n5219, 
                           B2 => REG_21_22_port, ZN => n5681);
   U1700 : INV_X1 port map( A => REG_19_22_port, ZN => n4842);
   U1701 : INV_X1 port map( A => REG_25_22_port, ZN => n4841);
   U1702 : NAND2_X1 port map( A1 => n5682, A2 => n5683, ZN => N358);
   U1703 : NOR4_X1 port map( A1 => n5684, A2 => n5685, A3 => n5686, A4 => n5687
                           , ZN => n5683);
   U1704 : OAI221_X1 port map( B1 => n4853, B2 => n5173, C1 => n4854, C2 => 
                           n5174, A => n5688, ZN => n5687);
   U1705 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_23_port, B1 => n5177, B2
                           => REG_14_23_port, ZN => n5688);
   U1706 : INV_X1 port map( A => REG_8_23_port, ZN => n4854);
   U1707 : INV_X1 port map( A => REG_0_23_port, ZN => n4853);
   U1708 : OAI221_X1 port map( B1 => n4856, B2 => n5178, C1 => n4857, C2 => 
                           n5179, A => n5689, ZN => n5686);
   U1709 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_23_port, B1 => n5182, B2
                           => REG_12_23_port, ZN => n5689);
   U1710 : INV_X1 port map( A => REG_10_23_port, ZN => n4857);
   U1711 : INV_X1 port map( A => REG_2_23_port, ZN => n4856);
   U1712 : OAI221_X1 port map( B1 => n5690, B2 => n5184, C1 => n5691, C2 => 
                           n5186, A => n5692, ZN => n5685);
   U1713 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_23_port, B1 => n5189, B2
                           => REG_15_23_port, ZN => n5692);
   U1714 : INV_X1 port map( A => REG_11_23_port, ZN => n5691);
   U1715 : INV_X1 port map( A => REG_3_23_port, ZN => n5690);
   U1716 : OAI221_X1 port map( B1 => n4859, B2 => n5190, C1 => n4860, C2 => 
                           n5191, A => n5693, ZN => n5684);
   U1717 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_23_port, B1 => n5194, B2
                           => REG_13_23_port, ZN => n5693);
   U1718 : INV_X1 port map( A => REG_9_23_port, ZN => n4860);
   U1719 : INV_X1 port map( A => REG_1_23_port, ZN => n4859);
   U1720 : NOR4_X1 port map( A1 => n5694, A2 => n5695, A3 => n5696, A4 => n5697
                           , ZN => n5682);
   U1721 : OAI221_X1 port map( B1 => n4869, B2 => n5199, C1 => n4873, C2 => 
                           n5200, A => n5698, ZN => n5697);
   U1722 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_23_port, B1 => n5203, 
                           B2 => REG_16_23_port, ZN => n5698);
   U1723 : INV_X1 port map( A => REG_24_23_port, ZN => n4873);
   U1724 : INV_X1 port map( A => REG_26_23_port, ZN => n4869);
   U1725 : OAI221_X1 port map( B1 => n4867, B2 => n5204, C1 => n4870, C2 => 
                           n5205, A => n5699, ZN => n5696);
   U1726 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_23_port, B1 => n5208, 
                           B2 => REG_28_23_port, ZN => n5699);
   U1727 : INV_X1 port map( A => REG_18_23_port, ZN => n4870);
   U1728 : INV_X1 port map( A => REG_22_23_port, ZN => n4867);
   U1729 : OAI221_X1 port map( B1 => n4872, B2 => n5209, C1 => n5700, C2 => 
                           n5211, A => n5701, ZN => n5695);
   U1730 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_23_port, B1 => n5214, 
                           B2 => REG_23_23_port, ZN => n5701);
   U1731 : INV_X1 port map( A => REG_20_23_port, ZN => n5700);
   U1732 : INV_X1 port map( A => REG_31_23_port, ZN => n4872);
   U1733 : OAI221_X1 port map( B1 => n4875, B2 => n5215, C1 => n4876, C2 => 
                           n5216, A => n5702, ZN => n5694);
   U1734 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_23_port, B1 => n5219, 
                           B2 => REG_21_23_port, ZN => n5702);
   U1735 : INV_X1 port map( A => REG_19_23_port, ZN => n4876);
   U1736 : INV_X1 port map( A => REG_25_23_port, ZN => n4875);
   U1737 : NAND2_X1 port map( A1 => n5703, A2 => n5704, ZN => N357);
   U1738 : NOR4_X1 port map( A1 => n5705, A2 => n5706, A3 => n5707, A4 => n5708
                           , ZN => n5704);
   U1739 : OAI221_X1 port map( B1 => n4887, B2 => n5173, C1 => n4888, C2 => 
                           n5174, A => n5709, ZN => n5708);
   U1740 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_24_port, B1 => n5177, B2
                           => REG_14_24_port, ZN => n5709);
   U1741 : INV_X1 port map( A => REG_8_24_port, ZN => n4888);
   U1742 : INV_X1 port map( A => REG_0_24_port, ZN => n4887);
   U1743 : OAI221_X1 port map( B1 => n4890, B2 => n5178, C1 => n4891, C2 => 
                           n5179, A => n5710, ZN => n5707);
   U1744 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_24_port, B1 => n5182, B2
                           => REG_12_24_port, ZN => n5710);
   U1745 : INV_X1 port map( A => REG_10_24_port, ZN => n4891);
   U1746 : INV_X1 port map( A => REG_2_24_port, ZN => n4890);
   U1747 : OAI221_X1 port map( B1 => n5711, B2 => n5184, C1 => n5712, C2 => 
                           n5186, A => n5713, ZN => n5706);
   U1748 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_24_port, B1 => n5189, B2
                           => REG_15_24_port, ZN => n5713);
   U1749 : INV_X1 port map( A => REG_11_24_port, ZN => n5712);
   U1750 : INV_X1 port map( A => REG_3_24_port, ZN => n5711);
   U1751 : OAI221_X1 port map( B1 => n4893, B2 => n5190, C1 => n4894, C2 => 
                           n5191, A => n5714, ZN => n5705);
   U1752 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_24_port, B1 => n5194, B2
                           => REG_13_24_port, ZN => n5714);
   U1753 : INV_X1 port map( A => REG_9_24_port, ZN => n4894);
   U1754 : INV_X1 port map( A => REG_1_24_port, ZN => n4893);
   U1755 : NOR4_X1 port map( A1 => n5715, A2 => n5716, A3 => n5717, A4 => n5718
                           , ZN => n5703);
   U1756 : OAI221_X1 port map( B1 => n4903, B2 => n5199, C1 => n4907, C2 => 
                           n5200, A => n5719, ZN => n5718);
   U1757 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_24_port, B1 => n5203, 
                           B2 => REG_16_24_port, ZN => n5719);
   U1758 : INV_X1 port map( A => REG_24_24_port, ZN => n4907);
   U1759 : INV_X1 port map( A => REG_26_24_port, ZN => n4903);
   U1760 : OAI221_X1 port map( B1 => n4901, B2 => n5204, C1 => n4904, C2 => 
                           n5205, A => n5720, ZN => n5717);
   U1761 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_24_port, B1 => n5208, 
                           B2 => REG_28_24_port, ZN => n5720);
   U1762 : INV_X1 port map( A => REG_18_24_port, ZN => n4904);
   U1763 : INV_X1 port map( A => REG_22_24_port, ZN => n4901);
   U1764 : OAI221_X1 port map( B1 => n4906, B2 => n5209, C1 => n5721, C2 => 
                           n5211, A => n5722, ZN => n5716);
   U1765 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_24_port, B1 => n5214, 
                           B2 => REG_23_24_port, ZN => n5722);
   U1766 : INV_X1 port map( A => REG_20_24_port, ZN => n5721);
   U1767 : INV_X1 port map( A => REG_31_24_port, ZN => n4906);
   U1768 : OAI221_X1 port map( B1 => n4909, B2 => n5215, C1 => n4910, C2 => 
                           n5216, A => n5723, ZN => n5715);
   U1769 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_24_port, B1 => n5219, 
                           B2 => REG_21_24_port, ZN => n5723);
   U1770 : INV_X1 port map( A => REG_19_24_port, ZN => n4910);
   U1771 : INV_X1 port map( A => REG_25_24_port, ZN => n4909);
   U1772 : NAND2_X1 port map( A1 => n5724, A2 => n5725, ZN => N356);
   U1773 : NOR4_X1 port map( A1 => n5726, A2 => n5727, A3 => n5728, A4 => n5729
                           , ZN => n5725);
   U1774 : OAI221_X1 port map( B1 => n4921, B2 => n5173, C1 => n4922, C2 => 
                           n5174, A => n5730, ZN => n5729);
   U1775 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_25_port, B1 => n5177, B2
                           => REG_14_25_port, ZN => n5730);
   U1776 : INV_X1 port map( A => REG_8_25_port, ZN => n4922);
   U1777 : INV_X1 port map( A => REG_0_25_port, ZN => n4921);
   U1778 : OAI221_X1 port map( B1 => n4924, B2 => n5178, C1 => n4925, C2 => 
                           n5179, A => n5731, ZN => n5728);
   U1779 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_25_port, B1 => n5182, B2
                           => REG_12_25_port, ZN => n5731);
   U1780 : INV_X1 port map( A => REG_10_25_port, ZN => n4925);
   U1781 : INV_X1 port map( A => REG_2_25_port, ZN => n4924);
   U1782 : OAI221_X1 port map( B1 => n5732, B2 => n5184, C1 => n5733, C2 => 
                           n5186, A => n5734, ZN => n5727);
   U1783 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_25_port, B1 => n5189, B2
                           => REG_15_25_port, ZN => n5734);
   U1784 : INV_X1 port map( A => REG_11_25_port, ZN => n5733);
   U1785 : INV_X1 port map( A => REG_3_25_port, ZN => n5732);
   U1786 : OAI221_X1 port map( B1 => n4927, B2 => n5190, C1 => n4928, C2 => 
                           n5191, A => n5735, ZN => n5726);
   U1787 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_25_port, B1 => n5194, B2
                           => REG_13_25_port, ZN => n5735);
   U1788 : INV_X1 port map( A => REG_9_25_port, ZN => n4928);
   U1789 : INV_X1 port map( A => REG_1_25_port, ZN => n4927);
   U1790 : NOR4_X1 port map( A1 => n5736, A2 => n5737, A3 => n5738, A4 => n5739
                           , ZN => n5724);
   U1791 : OAI221_X1 port map( B1 => n4937, B2 => n5199, C1 => n4941, C2 => 
                           n5200, A => n5740, ZN => n5739);
   U1792 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_25_port, B1 => n5203, 
                           B2 => REG_16_25_port, ZN => n5740);
   U1793 : INV_X1 port map( A => REG_24_25_port, ZN => n4941);
   U1794 : INV_X1 port map( A => REG_26_25_port, ZN => n4937);
   U1795 : OAI221_X1 port map( B1 => n4935, B2 => n5204, C1 => n4938, C2 => 
                           n5205, A => n5741, ZN => n5738);
   U1796 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_25_port, B1 => n5208, 
                           B2 => REG_28_25_port, ZN => n5741);
   U1797 : INV_X1 port map( A => REG_18_25_port, ZN => n4938);
   U1798 : INV_X1 port map( A => REG_22_25_port, ZN => n4935);
   U1799 : OAI221_X1 port map( B1 => n4940, B2 => n5209, C1 => n5742, C2 => 
                           n5211, A => n5743, ZN => n5737);
   U1800 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_25_port, B1 => n5214, 
                           B2 => REG_23_25_port, ZN => n5743);
   U1801 : INV_X1 port map( A => REG_20_25_port, ZN => n5742);
   U1802 : INV_X1 port map( A => REG_31_25_port, ZN => n4940);
   U1803 : OAI221_X1 port map( B1 => n4943, B2 => n5215, C1 => n4944, C2 => 
                           n5216, A => n5744, ZN => n5736);
   U1804 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_25_port, B1 => n5219, 
                           B2 => REG_21_25_port, ZN => n5744);
   U1805 : INV_X1 port map( A => REG_19_25_port, ZN => n4944);
   U1806 : INV_X1 port map( A => REG_25_25_port, ZN => n4943);
   U1807 : NAND2_X1 port map( A1 => n5745, A2 => n5746, ZN => N355);
   U1808 : NOR4_X1 port map( A1 => n5747, A2 => n5748, A3 => n5749, A4 => n5750
                           , ZN => n5746);
   U1809 : OAI221_X1 port map( B1 => n4955, B2 => n5173, C1 => n4956, C2 => 
                           n5174, A => n5751, ZN => n5750);
   U1810 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_26_port, B1 => n5177, B2
                           => REG_14_26_port, ZN => n5751);
   U1811 : INV_X1 port map( A => REG_8_26_port, ZN => n4956);
   U1812 : INV_X1 port map( A => REG_0_26_port, ZN => n4955);
   U1813 : OAI221_X1 port map( B1 => n4958, B2 => n5178, C1 => n4959, C2 => 
                           n5179, A => n5752, ZN => n5749);
   U1814 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_26_port, B1 => n5182, B2
                           => REG_12_26_port, ZN => n5752);
   U1815 : INV_X1 port map( A => REG_10_26_port, ZN => n4959);
   U1816 : INV_X1 port map( A => REG_2_26_port, ZN => n4958);
   U1817 : OAI221_X1 port map( B1 => n5753, B2 => n5184, C1 => n5754, C2 => 
                           n5186, A => n5755, ZN => n5748);
   U1818 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_26_port, B1 => n5189, B2
                           => REG_15_26_port, ZN => n5755);
   U1819 : INV_X1 port map( A => REG_11_26_port, ZN => n5754);
   U1820 : INV_X1 port map( A => REG_3_26_port, ZN => n5753);
   U1821 : OAI221_X1 port map( B1 => n4961, B2 => n5190, C1 => n4962, C2 => 
                           n5191, A => n5756, ZN => n5747);
   U1822 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_26_port, B1 => n5194, B2
                           => REG_13_26_port, ZN => n5756);
   U1823 : INV_X1 port map( A => REG_9_26_port, ZN => n4962);
   U1824 : INV_X1 port map( A => REG_1_26_port, ZN => n4961);
   U1825 : NOR4_X1 port map( A1 => n5757, A2 => n5758, A3 => n5759, A4 => n5760
                           , ZN => n5745);
   U1826 : OAI221_X1 port map( B1 => n4971, B2 => n5199, C1 => n4975, C2 => 
                           n5200, A => n5761, ZN => n5760);
   U1827 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_26_port, B1 => n5203, 
                           B2 => REG_16_26_port, ZN => n5761);
   U1828 : INV_X1 port map( A => REG_24_26_port, ZN => n4975);
   U1829 : INV_X1 port map( A => REG_26_26_port, ZN => n4971);
   U1830 : OAI221_X1 port map( B1 => n4969, B2 => n5204, C1 => n4972, C2 => 
                           n5205, A => n5762, ZN => n5759);
   U1831 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_26_port, B1 => n5208, 
                           B2 => REG_28_26_port, ZN => n5762);
   U1832 : INV_X1 port map( A => REG_18_26_port, ZN => n4972);
   U1833 : INV_X1 port map( A => REG_22_26_port, ZN => n4969);
   U1834 : OAI221_X1 port map( B1 => n4974, B2 => n5209, C1 => n5763, C2 => 
                           n5211, A => n5764, ZN => n5758);
   U1835 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_26_port, B1 => n5214, 
                           B2 => REG_23_26_port, ZN => n5764);
   U1836 : INV_X1 port map( A => REG_20_26_port, ZN => n5763);
   U1837 : INV_X1 port map( A => REG_31_26_port, ZN => n4974);
   U1838 : OAI221_X1 port map( B1 => n4977, B2 => n5215, C1 => n4978, C2 => 
                           n5216, A => n5765, ZN => n5757);
   U1839 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_26_port, B1 => n5219, 
                           B2 => REG_21_26_port, ZN => n5765);
   U1840 : INV_X1 port map( A => REG_19_26_port, ZN => n4978);
   U1841 : INV_X1 port map( A => REG_25_26_port, ZN => n4977);
   U1842 : NAND2_X1 port map( A1 => n5766, A2 => n5767, ZN => N354);
   U1843 : NOR4_X1 port map( A1 => n5768, A2 => n5769, A3 => n5770, A4 => n5771
                           , ZN => n5767);
   U1844 : OAI221_X1 port map( B1 => n4989, B2 => n5173, C1 => n4990, C2 => 
                           n5174, A => n5772, ZN => n5771);
   U1845 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_27_port, B1 => n5177, B2
                           => REG_14_27_port, ZN => n5772);
   U1846 : INV_X1 port map( A => REG_8_27_port, ZN => n4990);
   U1847 : INV_X1 port map( A => REG_0_27_port, ZN => n4989);
   U1848 : OAI221_X1 port map( B1 => n4992, B2 => n5178, C1 => n4993, C2 => 
                           n5179, A => n5773, ZN => n5770);
   U1849 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_27_port, B1 => n5182, B2
                           => REG_12_27_port, ZN => n5773);
   U1850 : INV_X1 port map( A => REG_10_27_port, ZN => n4993);
   U1851 : INV_X1 port map( A => REG_2_27_port, ZN => n4992);
   U1852 : OAI221_X1 port map( B1 => n5774, B2 => n5184, C1 => n5775, C2 => 
                           n5186, A => n5776, ZN => n5769);
   U1853 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_27_port, B1 => n5189, B2
                           => REG_15_27_port, ZN => n5776);
   U1854 : INV_X1 port map( A => REG_11_27_port, ZN => n5775);
   U1855 : INV_X1 port map( A => REG_3_27_port, ZN => n5774);
   U1856 : OAI221_X1 port map( B1 => n4995, B2 => n5190, C1 => n4996, C2 => 
                           n5191, A => n5777, ZN => n5768);
   U1857 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_27_port, B1 => n5194, B2
                           => REG_13_27_port, ZN => n5777);
   U1858 : INV_X1 port map( A => REG_9_27_port, ZN => n4996);
   U1859 : INV_X1 port map( A => REG_1_27_port, ZN => n4995);
   U1860 : NOR4_X1 port map( A1 => n5778, A2 => n5779, A3 => n5780, A4 => n5781
                           , ZN => n5766);
   U1861 : OAI221_X1 port map( B1 => n5005, B2 => n5199, C1 => n5009, C2 => 
                           n5200, A => n5782, ZN => n5781);
   U1862 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_27_port, B1 => n5203, 
                           B2 => REG_16_27_port, ZN => n5782);
   U1863 : INV_X1 port map( A => REG_24_27_port, ZN => n5009);
   U1864 : INV_X1 port map( A => REG_26_27_port, ZN => n5005);
   U1865 : OAI221_X1 port map( B1 => n5003, B2 => n5204, C1 => n5006, C2 => 
                           n5205, A => n5783, ZN => n5780);
   U1866 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_27_port, B1 => n5208, 
                           B2 => REG_28_27_port, ZN => n5783);
   U1867 : INV_X1 port map( A => REG_18_27_port, ZN => n5006);
   U1868 : INV_X1 port map( A => REG_22_27_port, ZN => n5003);
   U1869 : OAI221_X1 port map( B1 => n5008, B2 => n5209, C1 => n5784, C2 => 
                           n5211, A => n5785, ZN => n5779);
   U1870 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_27_port, B1 => n5214, 
                           B2 => REG_23_27_port, ZN => n5785);
   U1871 : INV_X1 port map( A => REG_20_27_port, ZN => n5784);
   U1872 : INV_X1 port map( A => REG_31_27_port, ZN => n5008);
   U1873 : OAI221_X1 port map( B1 => n5011, B2 => n5215, C1 => n5012, C2 => 
                           n5216, A => n5786, ZN => n5778);
   U1874 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_27_port, B1 => n5219, 
                           B2 => REG_21_27_port, ZN => n5786);
   U1875 : INV_X1 port map( A => REG_19_27_port, ZN => n5012);
   U1876 : INV_X1 port map( A => REG_25_27_port, ZN => n5011);
   U1877 : NAND2_X1 port map( A1 => n5787, A2 => n5788, ZN => N353);
   U1878 : NOR4_X1 port map( A1 => n5789, A2 => n5790, A3 => n5791, A4 => n5792
                           , ZN => n5788);
   U1879 : OAI221_X1 port map( B1 => n5023, B2 => n5173, C1 => n5024, C2 => 
                           n5174, A => n5793, ZN => n5792);
   U1880 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_28_port, B1 => n5177, B2
                           => REG_14_28_port, ZN => n5793);
   U1881 : INV_X1 port map( A => REG_8_28_port, ZN => n5024);
   U1882 : INV_X1 port map( A => REG_0_28_port, ZN => n5023);
   U1883 : OAI221_X1 port map( B1 => n5026, B2 => n5178, C1 => n5027, C2 => 
                           n5179, A => n5794, ZN => n5791);
   U1884 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_28_port, B1 => n5182, B2
                           => REG_12_28_port, ZN => n5794);
   U1885 : INV_X1 port map( A => REG_10_28_port, ZN => n5027);
   U1886 : INV_X1 port map( A => REG_2_28_port, ZN => n5026);
   U1887 : OAI221_X1 port map( B1 => n5795, B2 => n5184, C1 => n5796, C2 => 
                           n5186, A => n5797, ZN => n5790);
   U1888 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_28_port, B1 => n5189, B2
                           => REG_15_28_port, ZN => n5797);
   U1889 : INV_X1 port map( A => REG_11_28_port, ZN => n5796);
   U1890 : INV_X1 port map( A => REG_3_28_port, ZN => n5795);
   U1891 : OAI221_X1 port map( B1 => n5029, B2 => n5190, C1 => n5030, C2 => 
                           n5191, A => n5798, ZN => n5789);
   U1892 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_28_port, B1 => n5194, B2
                           => REG_13_28_port, ZN => n5798);
   U1893 : INV_X1 port map( A => REG_9_28_port, ZN => n5030);
   U1894 : INV_X1 port map( A => REG_1_28_port, ZN => n5029);
   U1895 : NOR4_X1 port map( A1 => n5799, A2 => n5800, A3 => n5801, A4 => n5802
                           , ZN => n5787);
   U1896 : OAI221_X1 port map( B1 => n5039, B2 => n5199, C1 => n5043, C2 => 
                           n5200, A => n5803, ZN => n5802);
   U1897 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_28_port, B1 => n5203, 
                           B2 => REG_16_28_port, ZN => n5803);
   U1898 : INV_X1 port map( A => REG_24_28_port, ZN => n5043);
   U1899 : INV_X1 port map( A => REG_26_28_port, ZN => n5039);
   U1900 : OAI221_X1 port map( B1 => n5037, B2 => n5204, C1 => n5040, C2 => 
                           n5205, A => n5804, ZN => n5801);
   U1901 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_28_port, B1 => n5208, 
                           B2 => REG_28_28_port, ZN => n5804);
   U1902 : INV_X1 port map( A => REG_18_28_port, ZN => n5040);
   U1903 : INV_X1 port map( A => REG_22_28_port, ZN => n5037);
   U1904 : OAI221_X1 port map( B1 => n5042, B2 => n5209, C1 => n5805, C2 => 
                           n5211, A => n5806, ZN => n5800);
   U1905 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_28_port, B1 => n5214, 
                           B2 => REG_23_28_port, ZN => n5806);
   U1906 : INV_X1 port map( A => REG_20_28_port, ZN => n5805);
   U1907 : INV_X1 port map( A => REG_31_28_port, ZN => n5042);
   U1908 : OAI221_X1 port map( B1 => n5045, B2 => n5215, C1 => n5046, C2 => 
                           n5216, A => n5807, ZN => n5799);
   U1909 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_28_port, B1 => n5219, 
                           B2 => REG_21_28_port, ZN => n5807);
   U1910 : INV_X1 port map( A => REG_19_28_port, ZN => n5046);
   U1911 : INV_X1 port map( A => REG_25_28_port, ZN => n5045);
   U1912 : NAND2_X1 port map( A1 => n5808, A2 => n5809, ZN => N352);
   U1913 : NOR4_X1 port map( A1 => n5810, A2 => n5811, A3 => n5812, A4 => n5813
                           , ZN => n5809);
   U1914 : OAI221_X1 port map( B1 => n5057, B2 => n5173, C1 => n5058, C2 => 
                           n5174, A => n5814, ZN => n5813);
   U1915 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_29_port, B1 => n5177, B2
                           => REG_14_29_port, ZN => n5814);
   U1916 : INV_X1 port map( A => REG_8_29_port, ZN => n5058);
   U1917 : INV_X1 port map( A => REG_0_29_port, ZN => n5057);
   U1918 : OAI221_X1 port map( B1 => n5060, B2 => n5178, C1 => n5061, C2 => 
                           n5179, A => n5815, ZN => n5812);
   U1919 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_29_port, B1 => n5182, B2
                           => REG_12_29_port, ZN => n5815);
   U1920 : INV_X1 port map( A => REG_10_29_port, ZN => n5061);
   U1921 : INV_X1 port map( A => REG_2_29_port, ZN => n5060);
   U1922 : OAI221_X1 port map( B1 => n5816, B2 => n5184, C1 => n5817, C2 => 
                           n5186, A => n5818, ZN => n5811);
   U1923 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_29_port, B1 => n5189, B2
                           => REG_15_29_port, ZN => n5818);
   U1924 : INV_X1 port map( A => REG_11_29_port, ZN => n5817);
   U1925 : INV_X1 port map( A => REG_3_29_port, ZN => n5816);
   U1926 : OAI221_X1 port map( B1 => n5063, B2 => n5190, C1 => n5064, C2 => 
                           n5191, A => n5819, ZN => n5810);
   U1927 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_29_port, B1 => n5194, B2
                           => REG_13_29_port, ZN => n5819);
   U1928 : INV_X1 port map( A => REG_9_29_port, ZN => n5064);
   U1929 : INV_X1 port map( A => REG_1_29_port, ZN => n5063);
   U1930 : NOR4_X1 port map( A1 => n5820, A2 => n5821, A3 => n5822, A4 => n5823
                           , ZN => n5808);
   U1931 : OAI221_X1 port map( B1 => n5073, B2 => n5199, C1 => n5077, C2 => 
                           n5200, A => n5824, ZN => n5823);
   U1932 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_29_port, B1 => n5203, 
                           B2 => REG_16_29_port, ZN => n5824);
   U1933 : INV_X1 port map( A => REG_24_29_port, ZN => n5077);
   U1934 : INV_X1 port map( A => REG_26_29_port, ZN => n5073);
   U1935 : OAI221_X1 port map( B1 => n5071, B2 => n5204, C1 => n5074, C2 => 
                           n5205, A => n5825, ZN => n5822);
   U1936 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_29_port, B1 => n5208, 
                           B2 => REG_28_29_port, ZN => n5825);
   U1937 : INV_X1 port map( A => REG_18_29_port, ZN => n5074);
   U1938 : INV_X1 port map( A => REG_22_29_port, ZN => n5071);
   U1939 : OAI221_X1 port map( B1 => n5076, B2 => n5209, C1 => n5826, C2 => 
                           n5211, A => n5827, ZN => n5821);
   U1940 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_29_port, B1 => n5214, 
                           B2 => REG_23_29_port, ZN => n5827);
   U1941 : INV_X1 port map( A => REG_20_29_port, ZN => n5826);
   U1942 : INV_X1 port map( A => REG_31_29_port, ZN => n5076);
   U1943 : OAI221_X1 port map( B1 => n5079, B2 => n5215, C1 => n5080, C2 => 
                           n5216, A => n5828, ZN => n5820);
   U1944 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_29_port, B1 => n5219, 
                           B2 => REG_21_29_port, ZN => n5828);
   U1945 : INV_X1 port map( A => REG_19_29_port, ZN => n5080);
   U1946 : INV_X1 port map( A => REG_25_29_port, ZN => n5079);
   U1947 : NAND2_X1 port map( A1 => n5829, A2 => n5830, ZN => N351);
   U1948 : NOR4_X1 port map( A1 => n5831, A2 => n5832, A3 => n5833, A4 => n5834
                           , ZN => n5830);
   U1949 : OAI221_X1 port map( B1 => n5091, B2 => n5173, C1 => n5092, C2 => 
                           n5174, A => n5835, ZN => n5834);
   U1950 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_30_port, B1 => n5177, B2
                           => REG_14_30_port, ZN => n5835);
   U1951 : INV_X1 port map( A => REG_8_30_port, ZN => n5092);
   U1952 : INV_X1 port map( A => REG_0_30_port, ZN => n5091);
   U1953 : OAI221_X1 port map( B1 => n5094, B2 => n5178, C1 => n5095, C2 => 
                           n5179, A => n5836, ZN => n5833);
   U1954 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_30_port, B1 => n5182, B2
                           => REG_12_30_port, ZN => n5836);
   U1955 : INV_X1 port map( A => REG_10_30_port, ZN => n5095);
   U1956 : INV_X1 port map( A => REG_2_30_port, ZN => n5094);
   U1957 : OAI221_X1 port map( B1 => n5837, B2 => n5184, C1 => n5838, C2 => 
                           n5186, A => n5839, ZN => n5832);
   U1958 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_30_port, B1 => n5189, B2
                           => REG_15_30_port, ZN => n5839);
   U1959 : INV_X1 port map( A => REG_11_30_port, ZN => n5838);
   U1960 : INV_X1 port map( A => REG_3_30_port, ZN => n5837);
   U1961 : OAI221_X1 port map( B1 => n5097, B2 => n5190, C1 => n5098, C2 => 
                           n5191, A => n5840, ZN => n5831);
   U1962 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_30_port, B1 => n5194, B2
                           => REG_13_30_port, ZN => n5840);
   U1963 : INV_X1 port map( A => REG_9_30_port, ZN => n5098);
   U1964 : INV_X1 port map( A => REG_1_30_port, ZN => n5097);
   U1965 : NOR4_X1 port map( A1 => n5841, A2 => n5842, A3 => n5843, A4 => n5844
                           , ZN => n5829);
   U1966 : OAI221_X1 port map( B1 => n5107, B2 => n5199, C1 => n5111, C2 => 
                           n5200, A => n5845, ZN => n5844);
   U1967 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_30_port, B1 => n5203, 
                           B2 => REG_16_30_port, ZN => n5845);
   U1968 : INV_X1 port map( A => REG_24_30_port, ZN => n5111);
   U1969 : INV_X1 port map( A => REG_26_30_port, ZN => n5107);
   U1970 : OAI221_X1 port map( B1 => n5105, B2 => n5204, C1 => n5108, C2 => 
                           n5205, A => n5846, ZN => n5843);
   U1971 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_30_port, B1 => n5208, 
                           B2 => REG_28_30_port, ZN => n5846);
   U1972 : INV_X1 port map( A => REG_18_30_port, ZN => n5108);
   U1973 : INV_X1 port map( A => REG_22_30_port, ZN => n5105);
   U1974 : OAI221_X1 port map( B1 => n5110, B2 => n5209, C1 => n5847, C2 => 
                           n5211, A => n5848, ZN => n5842);
   U1975 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_30_port, B1 => n5214, 
                           B2 => REG_23_30_port, ZN => n5848);
   U1976 : INV_X1 port map( A => REG_20_30_port, ZN => n5847);
   U1977 : INV_X1 port map( A => REG_31_30_port, ZN => n5110);
   U1978 : OAI221_X1 port map( B1 => n5113, B2 => n5215, C1 => n5114, C2 => 
                           n5216, A => n5849, ZN => n5841);
   U1979 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_30_port, B1 => n5219, 
                           B2 => REG_21_30_port, ZN => n5849);
   U1980 : INV_X1 port map( A => REG_19_30_port, ZN => n5114);
   U1981 : INV_X1 port map( A => REG_25_30_port, ZN => n5113);
   U1982 : NAND2_X1 port map( A1 => n5850, A2 => n5851, ZN => N350);
   U1983 : NOR4_X1 port map( A1 => n5852, A2 => n5853, A3 => n5854, A4 => n5855
                           , ZN => n5851);
   U1984 : OAI221_X1 port map( B1 => n5129, B2 => n5173, C1 => n5130, C2 => 
                           n5174, A => n5856, ZN => n5855);
   U1985 : AOI22_X1 port map( A1 => n5176, A2 => REG_6_31_port, B1 => n5177, B2
                           => REG_14_31_port, ZN => n5856);
   U1986 : INV_X1 port map( A => REG_8_31_port, ZN => n5130);
   U1987 : INV_X1 port map( A => REG_0_31_port, ZN => n5129);
   U1988 : OAI221_X1 port map( B1 => n5134, B2 => n5178, C1 => n5135, C2 => 
                           n5179, A => n5861, ZN => n5854);
   U1989 : AOI22_X1 port map( A1 => n5181, A2 => REG_4_31_port, B1 => n5182, B2
                           => REG_12_31_port, ZN => n5861);
   U1990 : INV_X1 port map( A => REG_10_31_port, ZN => n5135);
   U1991 : INV_X1 port map( A => REG_2_31_port, ZN => n5134);
   U1992 : OAI221_X1 port map( B1 => n5864, B2 => n5184, C1 => n5865, C2 => 
                           n5186, A => n5866, ZN => n5853);
   U1993 : AOI22_X1 port map( A1 => n5188, A2 => REG_7_31_port, B1 => n5189, B2
                           => REG_15_31_port, ZN => n5866);
   U1994 : INV_X1 port map( A => REG_11_31_port, ZN => n5865);
   U1995 : INV_X1 port map( A => REG_3_31_port, ZN => n5864);
   U1996 : OAI221_X1 port map( B1 => n5139, B2 => n5190, C1 => n5140, C2 => 
                           n5191, A => n5869, ZN => n5852);
   U1997 : AOI22_X1 port map( A1 => n5193, A2 => REG_5_31_port, B1 => n5194, B2
                           => REG_13_31_port, ZN => n5869);
   U1998 : NOR2_X1 port map( A1 => n5872, A2 => ADD_RD1(4), ZN => n5858);
   U1999 : INV_X1 port map( A => REG_9_31_port, ZN => n5140);
   U2000 : NOR2_X1 port map( A1 => ADD_RD1(3), A2 => ADD_RD1(4), ZN => n5859);
   U2001 : INV_X1 port map( A => REG_1_31_port, ZN => n5139);
   U2002 : NOR4_X1 port map( A1 => n5873, A2 => n5874, A3 => n5875, A4 => n5876
                           , ZN => n5850);
   U2003 : OAI221_X1 port map( B1 => n5155, B2 => n5199, C1 => n5160, C2 => 
                           n5200, A => n5877, ZN => n5876);
   U2004 : AOI22_X1 port map( A1 => n5202, A2 => REG_30_31_port, B1 => n5203, 
                           B2 => REG_16_31_port, ZN => n5877);
   U2005 : NOR3_X1 port map( A1 => ADD_RD1(1), A2 => ADD_RD1(2), A3 => 
                           ADD_RD1(0), ZN => n5860);
   U2006 : INV_X1 port map( A => REG_24_31_port, ZN => n5160);
   U2007 : INV_X1 port map( A => REG_26_31_port, ZN => n5155);
   U2008 : OAI221_X1 port map( B1 => n5150, B2 => n5204, C1 => n5156, C2 => 
                           n5205, A => n5880, ZN => n5875);
   U2009 : AOI22_X1 port map( A1 => n5207, A2 => REG_27_31_port, B1 => n5208, 
                           B2 => REG_28_31_port, ZN => n5880);
   U2010 : NOR3_X1 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(2), A3 => n5881, 
                           ZN => n5863);
   U2011 : INV_X1 port map( A => REG_18_31_port, ZN => n5156);
   U2012 : NOR3_X1 port map( A1 => n5882, A2 => ADD_RD1(0), A3 => n5881, ZN => 
                           n5857);
   U2013 : INV_X1 port map( A => REG_22_31_port, ZN => n5150);
   U2014 : OAI221_X1 port map( B1 => n5159, B2 => n5209, C1 => n5883, C2 => 
                           n5211, A => n5884, ZN => n5874);
   U2015 : AOI22_X1 port map( A1 => n5213, A2 => REG_17_31_port, B1 => n5214, 
                           B2 => REG_23_31_port, ZN => n5884);
   U2016 : NOR3_X1 port map( A1 => ADD_RD1(0), A2 => ADD_RD1(1), A3 => n5882, 
                           ZN => n5862);
   U2017 : INV_X1 port map( A => REG_20_31_port, ZN => n5883);
   U2018 : NOR3_X1 port map( A1 => n5882, A2 => n5885, A3 => n5881, ZN => n5867
                           );
   U2019 : INV_X1 port map( A => REG_31_31_port, ZN => n5159);
   U2020 : OAI221_X1 port map( B1 => n5163, B2 => n5215, C1 => n5164, C2 => 
                           n5216, A => n5886, ZN => n5873);
   U2021 : AOI22_X1 port map( A1 => n5218, A2 => REG_29_31_port, B1 => n5219, 
                           B2 => REG_21_31_port, ZN => n5886);
   U2022 : NOR3_X1 port map( A1 => n5885, A2 => ADD_RD1(1), A3 => n5882, ZN => 
                           n5870);
   U2023 : INV_X1 port map( A => ADD_RD1(2), ZN => n5882);
   U2024 : NOR3_X1 port map( A1 => n5885, A2 => ADD_RD1(2), A3 => n5881, ZN => 
                           n5868);
   U2025 : INV_X1 port map( A => ADD_RD1(1), ZN => n5881);
   U2026 : NOR2_X1 port map( A1 => n5887, A2 => ADD_RD1(3), ZN => n5878);
   U2027 : INV_X1 port map( A => REG_19_31_port, ZN => n5164);
   U2028 : NOR3_X1 port map( A1 => ADD_RD1(1), A2 => ADD_RD1(2), A3 => n5885, 
                           ZN => n5871);
   U2029 : INV_X1 port map( A => ADD_RD1(0), ZN => n5885);
   U2030 : NOR2_X1 port map( A1 => n5887, A2 => n5872, ZN => n5879);
   U2031 : INV_X1 port map( A => ADD_RD1(3), ZN => n5872);
   U2032 : INV_X1 port map( A => ADD_RD1(4), ZN => n5887);
   U2033 : INV_X1 port map( A => REG_25_31_port, ZN => n5163);
   U2034 : NOR2_X1 port map( A1 => n3988, A2 => n4029, ZN => N348);
   U2035 : NOR2_X1 port map( A1 => n3988, A2 => n4028, ZN => N347);
   U2036 : NOR2_X1 port map( A1 => n3988, A2 => n4027, ZN => N346);
   U2037 : NOR2_X1 port map( A1 => n3988, A2 => n4026, ZN => N345);
   U2038 : NOR2_X1 port map( A1 => n3988, A2 => n4025, ZN => N344);
   U2039 : NOR2_X1 port map( A1 => n3988, A2 => n4024, ZN => N343);
   U2040 : NOR2_X1 port map( A1 => n3988, A2 => n4023, ZN => N342);
   U2041 : NOR2_X1 port map( A1 => n3988, A2 => n4022, ZN => N341);
   U2042 : NOR2_X1 port map( A1 => n3988, A2 => n4021, ZN => N340);
   U2043 : NOR2_X1 port map( A1 => n3988, A2 => n4020, ZN => N339);
   U2044 : NOR2_X1 port map( A1 => n3988, A2 => n4019, ZN => N338);
   U2045 : NOR2_X1 port map( A1 => n3988, A2 => n4018, ZN => N337);
   U2046 : NOR2_X1 port map( A1 => n3988, A2 => n4017, ZN => N336);
   U2047 : NOR2_X1 port map( A1 => n3988, A2 => n4016, ZN => N335);
   U2048 : NOR2_X1 port map( A1 => n3988, A2 => n4015, ZN => N334);
   U2049 : NOR2_X1 port map( A1 => n3988, A2 => n4014, ZN => N333);
   U2050 : NOR2_X1 port map( A1 => n3988, A2 => n4013, ZN => N332);
   U2051 : NOR2_X1 port map( A1 => n3988, A2 => n4012, ZN => N331);
   U2052 : NOR2_X1 port map( A1 => n3988, A2 => n4011, ZN => N330);
   U2053 : NOR2_X1 port map( A1 => n3988, A2 => n4010, ZN => N329);
   U2054 : NOR2_X1 port map( A1 => n3988, A2 => n4009, ZN => N328);
   U2055 : NOR2_X1 port map( A1 => n3988, A2 => n4008, ZN => N327);
   U2056 : NOR2_X1 port map( A1 => n3988, A2 => n4007, ZN => N326);
   U2057 : NOR2_X1 port map( A1 => n3988, A2 => n4006, ZN => N325);
   U2058 : NOR2_X1 port map( A1 => n3988, A2 => n4005, ZN => N324);
   U2059 : NOR2_X1 port map( A1 => n3988, A2 => n4004, ZN => N323);
   U2060 : NOR2_X1 port map( A1 => n3988, A2 => n4003, ZN => N322);
   U2061 : NOR2_X1 port map( A1 => n3988, A2 => n4002, ZN => N321);
   U2062 : NOR2_X1 port map( A1 => n3988, A2 => n4001, ZN => N320);
   U2063 : NOR2_X1 port map( A1 => n5888, A2 => n4000, ZN => N319);
   U2064 : NOR2_X1 port map( A1 => n5888, A2 => n3999, ZN => N318);
   U2065 : NOR2_X1 port map( A1 => n5888, A2 => n3998, ZN => N317);
   U2066 : OAI21_X1 port map( B1 => n5889, B2 => n5890, A => n3990, ZN => N316)
                           ;
   U2067 : INV_X1 port map( A => n5888, ZN => n5890);
   U2068 : NOR3_X1 port map( A1 => ADD_WR(3), A2 => ADD_WR(4), A3 => n5891, ZN 
                           => n5888);
   U2069 : OAI21_X1 port map( B1 => n5892, B2 => n5893, A => n3990, ZN => N315)
                           ;
   U2070 : OAI21_X1 port map( B1 => n5892, B2 => n5894, A => n3990, ZN => N314)
                           ;
   U2071 : OAI21_X1 port map( B1 => n5892, B2 => n5895, A => n3990, ZN => N313)
                           ;
   U2072 : OAI21_X1 port map( B1 => n5892, B2 => n5896, A => n3990, ZN => N312)
                           ;
   U2073 : OAI21_X1 port map( B1 => n5892, B2 => n5897, A => n3990, ZN => N311)
                           ;
   U2074 : OAI21_X1 port map( B1 => n5892, B2 => n5898, A => n3990, ZN => N310)
                           ;
   U2075 : OAI21_X1 port map( B1 => n5892, B2 => n5899, A => n3990, ZN => N309)
                           ;
   U2076 : NAND3_X1 port map( A1 => n5900, A2 => n5901, A3 => n5902, ZN => 
                           n5892);
   U2077 : OAI21_X1 port map( B1 => n5891, B2 => n5903, A => n3990, ZN => N308)
                           ;
   U2078 : OAI21_X1 port map( B1 => n5893, B2 => n5903, A => n3990, ZN => N307)
                           ;
   U2079 : OAI21_X1 port map( B1 => n5894, B2 => n5903, A => n3990, ZN => N306)
                           ;
   U2080 : OAI21_X1 port map( B1 => n5895, B2 => n5903, A => n3990, ZN => N305)
                           ;
   U2081 : OAI21_X1 port map( B1 => n5896, B2 => n5903, A => n3991, ZN => N304)
                           ;
   U2082 : OAI21_X1 port map( B1 => n5897, B2 => n5903, A => n3991, ZN => N303)
                           ;
   U2083 : OAI21_X1 port map( B1 => n5898, B2 => n5903, A => n3991, ZN => N302)
                           ;
   U2084 : OAI21_X1 port map( B1 => n5899, B2 => n5903, A => n3991, ZN => N301)
                           ;
   U2085 : NAND3_X1 port map( A1 => n5902, A2 => n5901, A3 => ADD_WR(3), ZN => 
                           n5903);
   U2086 : OAI21_X1 port map( B1 => n5891, B2 => n5904, A => n3991, ZN => N300)
                           ;
   U2087 : OAI21_X1 port map( B1 => n5893, B2 => n5904, A => n3991, ZN => N299)
                           ;
   U2088 : OAI21_X1 port map( B1 => n5894, B2 => n5904, A => n3991, ZN => N298)
                           ;
   U2089 : OAI21_X1 port map( B1 => n5895, B2 => n5904, A => n3991, ZN => N297)
                           ;
   U2090 : OAI21_X1 port map( B1 => n5896, B2 => n5904, A => n3991, ZN => N296)
                           ;
   U2091 : OAI21_X1 port map( B1 => n5897, B2 => n5904, A => n3991, ZN => N295)
                           ;
   U2092 : OAI21_X1 port map( B1 => n5898, B2 => n5904, A => n3991, ZN => N294)
                           ;
   U2093 : OAI21_X1 port map( B1 => n5899, B2 => n5904, A => n3991, ZN => N293)
                           ;
   U2094 : NAND3_X1 port map( A1 => n5902, A2 => n5900, A3 => ADD_WR(4), ZN => 
                           n5904);
   U2095 : OAI21_X1 port map( B1 => n5891, B2 => n5905, A => n3992, ZN => N292)
                           ;
   U2096 : NAND3_X1 port map( A1 => n5906, A2 => n5907, A3 => n5908, ZN => 
                           n5891);
   U2097 : OAI21_X1 port map( B1 => n5893, B2 => n5905, A => n3992, ZN => N291)
                           ;
   U2098 : NAND3_X1 port map( A1 => n5906, A2 => n5907, A3 => ADD_WR(0), ZN => 
                           n5893);
   U2099 : OAI21_X1 port map( B1 => n5894, B2 => n5905, A => n3992, ZN => N290)
                           ;
   U2100 : NAND3_X1 port map( A1 => n5908, A2 => n5907, A3 => ADD_WR(1), ZN => 
                           n5894);
   U2101 : OAI21_X1 port map( B1 => n5895, B2 => n5905, A => n3992, ZN => N289)
                           ;
   U2102 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n5907, A3 => ADD_WR(1), ZN
                           => n5895);
   U2103 : INV_X1 port map( A => ADD_WR(2), ZN => n5907);
   U2104 : OAI21_X1 port map( B1 => n5896, B2 => n5905, A => n3992, ZN => N288)
                           ;
   U2105 : NAND3_X1 port map( A1 => n5908, A2 => n5906, A3 => ADD_WR(2), ZN => 
                           n5896);
   U2106 : OAI21_X1 port map( B1 => n5897, B2 => n5905, A => n3992, ZN => N287)
                           ;
   U2107 : NAND3_X1 port map( A1 => ADD_WR(0), A2 => n5906, A3 => ADD_WR(2), ZN
                           => n5897);
   U2108 : INV_X1 port map( A => ADD_WR(1), ZN => n5906);
   U2109 : OAI21_X1 port map( B1 => n5898, B2 => n5905, A => n3992, ZN => N254)
                           ;
   U2110 : NAND3_X1 port map( A1 => ADD_WR(3), A2 => n5902, A3 => ADD_WR(4), ZN
                           => n5905);
   U2111 : INV_X1 port map( A => n5889, ZN => n5902);
   U2112 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => n5908, A3 => ADD_WR(2), ZN
                           => n5898);
   U2113 : INV_X1 port map( A => ADD_WR(0), ZN => n5908);
   U2114 : NOR2_X1 port map( A1 => n3987, A2 => n4029, ZN => N253);
   U2115 : NAND2_X1 port map( A1 => DATAIN(31), A2 => n3992, ZN => n4029);
   U2116 : NOR2_X1 port map( A1 => n3987, A2 => n4028, ZN => N252);
   U2117 : NAND2_X1 port map( A1 => DATAIN(30), A2 => n3995, ZN => n4028);
   U2118 : NOR2_X1 port map( A1 => n3987, A2 => n4027, ZN => N251);
   U2119 : NAND2_X1 port map( A1 => DATAIN(29), A2 => n3995, ZN => n4027);
   U2120 : NOR2_X1 port map( A1 => n3987, A2 => n4026, ZN => N250);
   U2121 : NAND2_X1 port map( A1 => DATAIN(28), A2 => n3995, ZN => n4026);
   U2122 : NOR2_X1 port map( A1 => n3987, A2 => n4025, ZN => N249);
   U2123 : NAND2_X1 port map( A1 => DATAIN(27), A2 => n3994, ZN => n4025);
   U2124 : NOR2_X1 port map( A1 => n3987, A2 => n4024, ZN => N248);
   U2125 : NAND2_X1 port map( A1 => DATAIN(26), A2 => n3994, ZN => n4024);
   U2126 : NOR2_X1 port map( A1 => n3987, A2 => n4023, ZN => N247);
   U2127 : NAND2_X1 port map( A1 => DATAIN(25), A2 => n3994, ZN => n4023);
   U2128 : NOR2_X1 port map( A1 => n3987, A2 => n4022, ZN => N246);
   U2129 : NAND2_X1 port map( A1 => DATAIN(24), A2 => n3994, ZN => n4022);
   U2130 : NOR2_X1 port map( A1 => n3987, A2 => n4021, ZN => N245);
   U2131 : NAND2_X1 port map( A1 => DATAIN(23), A2 => n3994, ZN => n4021);
   U2132 : NOR2_X1 port map( A1 => n3987, A2 => n4020, ZN => N244);
   U2133 : NAND2_X1 port map( A1 => DATAIN(22), A2 => n3994, ZN => n4020);
   U2134 : NOR2_X1 port map( A1 => n3987, A2 => n4019, ZN => N243);
   U2135 : NAND2_X1 port map( A1 => DATAIN(21), A2 => n3994, ZN => n4019);
   U2136 : NOR2_X1 port map( A1 => n3987, A2 => n4018, ZN => N242);
   U2137 : NAND2_X1 port map( A1 => DATAIN(20), A2 => n3994, ZN => n4018);
   U2138 : NOR2_X1 port map( A1 => n3987, A2 => n4017, ZN => N241);
   U2139 : NAND2_X1 port map( A1 => DATAIN(19), A2 => n3994, ZN => n4017);
   U2140 : NOR2_X1 port map( A1 => n3987, A2 => n4016, ZN => N240);
   U2141 : NAND2_X1 port map( A1 => DATAIN(18), A2 => n3994, ZN => n4016);
   U2142 : NOR2_X1 port map( A1 => n3987, A2 => n4015, ZN => N239);
   U2143 : NAND2_X1 port map( A1 => DATAIN(17), A2 => n3994, ZN => n4015);
   U2144 : NOR2_X1 port map( A1 => n3987, A2 => n4014, ZN => N238);
   U2145 : NAND2_X1 port map( A1 => DATAIN(16), A2 => n3994, ZN => n4014);
   U2146 : NOR2_X1 port map( A1 => n3987, A2 => n4013, ZN => N237);
   U2147 : NAND2_X1 port map( A1 => DATAIN(15), A2 => n3993, ZN => n4013);
   U2148 : NOR2_X1 port map( A1 => n3987, A2 => n4012, ZN => N236);
   U2149 : NAND2_X1 port map( A1 => DATAIN(14), A2 => n3993, ZN => n4012);
   U2150 : NOR2_X1 port map( A1 => n3987, A2 => n4011, ZN => N235);
   U2151 : NAND2_X1 port map( A1 => DATAIN(13), A2 => n3993, ZN => n4011);
   U2152 : NOR2_X1 port map( A1 => n3987, A2 => n4010, ZN => N234);
   U2153 : NAND2_X1 port map( A1 => DATAIN(12), A2 => n3993, ZN => n4010);
   U2154 : NOR2_X1 port map( A1 => n3987, A2 => n4009, ZN => N233);
   U2155 : NAND2_X1 port map( A1 => DATAIN(11), A2 => n3993, ZN => n4009);
   U2156 : NOR2_X1 port map( A1 => n3987, A2 => n4008, ZN => N232);
   U2157 : NAND2_X1 port map( A1 => DATAIN(10), A2 => n3993, ZN => n4008);
   U2158 : NOR2_X1 port map( A1 => n3987, A2 => n4007, ZN => N231);
   U2159 : NAND2_X1 port map( A1 => DATAIN(9), A2 => n3993, ZN => n4007);
   U2160 : NOR2_X1 port map( A1 => n3987, A2 => n4006, ZN => N230);
   U2161 : NAND2_X1 port map( A1 => DATAIN(8), A2 => n3993, ZN => n4006);
   U2162 : NOR2_X1 port map( A1 => n3987, A2 => n4005, ZN => N229);
   U2163 : NAND2_X1 port map( A1 => DATAIN(7), A2 => n3993, ZN => n4005);
   U2164 : NOR2_X1 port map( A1 => n3987, A2 => n4004, ZN => N228);
   U2165 : NAND2_X1 port map( A1 => DATAIN(6), A2 => n3993, ZN => n4004);
   U2166 : NOR2_X1 port map( A1 => n3987, A2 => n4003, ZN => N227);
   U2167 : NAND2_X1 port map( A1 => DATAIN(5), A2 => n3993, ZN => n4003);
   U2168 : NOR2_X1 port map( A1 => n3987, A2 => n4002, ZN => N226);
   U2169 : NAND2_X1 port map( A1 => DATAIN(4), A2 => n3993, ZN => n4002);
   U2170 : NOR2_X1 port map( A1 => n3987, A2 => n4001, ZN => N225);
   U2171 : NAND2_X1 port map( A1 => DATAIN(3), A2 => n3992, ZN => n4001);
   U2172 : NOR2_X1 port map( A1 => n5909, A2 => n4000, ZN => N224);
   U2173 : NAND2_X1 port map( A1 => DATAIN(2), A2 => n3992, ZN => n4000);
   U2174 : NOR2_X1 port map( A1 => n5909, A2 => n3999, ZN => N223);
   U2175 : NAND2_X1 port map( A1 => DATAIN(1), A2 => n3992, ZN => n3999);
   U2176 : NOR2_X1 port map( A1 => n5909, A2 => n3998, ZN => N222);
   U2177 : NAND2_X1 port map( A1 => n3995, A2 => DATAIN(0), ZN => n3998);
   U2178 : OAI21_X1 port map( B1 => n5889, B2 => n5910, A => n3992, ZN => N221)
                           ;
   U2179 : INV_X1 port map( A => n5909, ZN => n5910);
   U2180 : NOR3_X1 port map( A1 => n5900, A2 => n5899, A3 => n5901, ZN => n5909
                           );
   U2181 : INV_X1 port map( A => ADD_WR(4), ZN => n5901);
   U2182 : NAND3_X1 port map( A1 => ADD_WR(1), A2 => ADD_WR(0), A3 => ADD_WR(2)
                           , ZN => n5899);
   U2183 : INV_X1 port map( A => ADD_WR(3), ZN => n5900);
   U2184 : NAND2_X1 port map( A1 => EN_WR, A2 => EN, ZN => n5889);

end SYN_BEHAVIORAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity FFDR_N32 is

   port( CLK, RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 
         0);  REGOUT : out std_logic_vector (31 downto 0));

end FFDR_N32;

architecture SYN_STRUCTURAL of FFDR_N32 is

   component FFD_1
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_2
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_3
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_4
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_5
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_6
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_7
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_8
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_9
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_10
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_11
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_12
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_13
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_14
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_15
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_16
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_17
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_18
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_19
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_20
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_21
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_22
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_23
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_24
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_25
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_26
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_27
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_28
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_29
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_30
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_31
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component FFD_0
      port( CLK, RST, EN, D : in std_logic;  Q : out std_logic);
   end component;

begin
   
   FFI_31 : FFD_0 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(31), Q
                           => REGOUT(31));
   FFI_30 : FFD_31 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(30), 
                           Q => REGOUT(30));
   FFI_29 : FFD_30 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(29), 
                           Q => REGOUT(29));
   FFI_28 : FFD_29 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(28), 
                           Q => REGOUT(28));
   FFI_27 : FFD_28 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(27), 
                           Q => REGOUT(27));
   FFI_26 : FFD_27 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(26), 
                           Q => REGOUT(26));
   FFI_25 : FFD_26 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(25), 
                           Q => REGOUT(25));
   FFI_24 : FFD_25 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(24), 
                           Q => REGOUT(24));
   FFI_23 : FFD_24 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(23), 
                           Q => REGOUT(23));
   FFI_22 : FFD_23 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(22), 
                           Q => REGOUT(22));
   FFI_21 : FFD_22 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(21), 
                           Q => REGOUT(21));
   FFI_20 : FFD_21 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(20), 
                           Q => REGOUT(20));
   FFI_19 : FFD_20 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(19), 
                           Q => REGOUT(19));
   FFI_18 : FFD_19 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(18), 
                           Q => REGOUT(18));
   FFI_17 : FFD_18 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(17), 
                           Q => REGOUT(17));
   FFI_16 : FFD_17 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(16), 
                           Q => REGOUT(16));
   FFI_15 : FFD_16 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(15), 
                           Q => REGOUT(15));
   FFI_14 : FFD_15 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(14), 
                           Q => REGOUT(14));
   FFI_13 : FFD_14 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(13), 
                           Q => REGOUT(13));
   FFI_12 : FFD_13 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(12), 
                           Q => REGOUT(12));
   FFI_11 : FFD_12 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(11), 
                           Q => REGOUT(11));
   FFI_10 : FFD_11 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(10), 
                           Q => REGOUT(10));
   FFI_9 : FFD_10 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(9), Q 
                           => REGOUT(9));
   FFI_8 : FFD_9 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(8), Q 
                           => REGOUT(8));
   FFI_7 : FFD_8 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(7), Q 
                           => REGOUT(7));
   FFI_6 : FFD_7 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(6), Q 
                           => REGOUT(6));
   FFI_5 : FFD_6 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(5), Q 
                           => REGOUT(5));
   FFI_4 : FFD_5 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(4), Q 
                           => REGOUT(4));
   FFI_3 : FFD_4 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(3), Q 
                           => REGOUT(3));
   FFI_2 : FFD_3 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(2), Q 
                           => REGOUT(2));
   FFI_1 : FFD_2 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(1), Q 
                           => REGOUT(1));
   FFI_0 : FFD_1 port map( CLK => CLK, RST => RST, EN => EN, D => REGIN(0), Q 
                           => REGOUT(0));

end SYN_STRUCTURAL;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32 is

   port( CLK, RST : in std_logic;  IR_IN, DRAM_OUT : in std_logic_vector (31 
         downto 0);  IR_LATCH_EN, PC_LATCH_EN, NPC_LATCH_EN, RF_WE, 
         RegA_LATCH_EN, RegB_LATCH_EN, RegIMM_LATCH_EN, MUXA_SEL, MUXB_SEL, 
         ALU_OUTREG_EN, EQ_COND : in std_logic;  ALU_OPCODE : in 
         std_logic_vector (0 to 6);  DRAM_RE, DRAM_WE, LMD_LATCH_EN, JUMP_EN, 
         JUMP_COND, WB_MUX_SEL : in std_logic;  IR_OUT, PC_OUT, ALU_OUT, 
         DRAM_IN : out std_logic_vector (31 downto 0));

end DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32;

architecture SYN_DLX_DATAPATH_ARCH of 
   DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32 is

   component XOR2_X1
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component AND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component BUF_X1
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component BUF_X2
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component CLKBUF_X3
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component BUF_X8
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component 
      DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32_DW01_add_0
      port( A, B : in std_logic_vector (31 downto 0);  CI : in std_logic;  SUM 
            : out std_logic_vector (31 downto 0);  CO : out std_logic);
   end component;
   
   component MUX21_N32_1
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic;  Y : 
            out std_logic_vector (31 downto 0));
   end component;
   
   component LDR_N32_1
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component LD_0
      port( RST, EN, D : in std_logic;  Q : out std_logic);
   end component;
   
   component LDR_N32_2
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component FU_N5
      port( RS1, RS2, RD_MEM, RD_WB : in std_logic_vector (4 downto 0);  
            RF_WE_MEM, RF_WE_WB : in std_logic;  FORWARD_A, FORWARD_B : out 
            std_logic_vector (1 downto 0));
   end component;
   
   component ZERODET_N32
      port( A : in std_logic_vector (31 downto 0);  Y : out std_logic);
   end component;
   
   component ALU_N32_NB8
      port( OP1, OP2 : in std_logic_vector (31 downto 0);  OPC : in 
            std_logic_vector (0 to 6);  Y : out std_logic_vector (31 downto 0);
            Z : out std_logic);
   end component;
   
   component MUX21_N32_2
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic;  Y : 
            out std_logic_vector (31 downto 0));
   end component;
   
   component MUX21_N32_3
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic;  Y : 
            out std_logic_vector (31 downto 0));
   end component;
   
   component MUX41_N32_1
      port( A, B, C, D : in std_logic_vector (31 downto 0);  S : in 
            std_logic_vector (1 downto 0);  Y : out std_logic_vector (31 downto
            0));
   end component;
   
   component MUX41_N32_0
      port( A, B, C, D : in std_logic_vector (31 downto 0);  S : in 
            std_logic_vector (1 downto 0);  Y : out std_logic_vector (31 downto
            0));
   end component;
   
   component LDR_N32_3
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component LDR_N32_4
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component LDR_N32_5
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component REGADDR_N32_OPC6_REG5
      port( INSTR : in std_logic_vector (31 downto 0);  RS1, RS2, RD : out 
            std_logic_vector (4 downto 0));
   end component;
   
   component SIGNEX_N32_OPC6_REG5
      port( INSTR : in std_logic_vector (31 downto 0);  IMM : out 
            std_logic_vector (31 downto 0));
   end component;
   
   component RF_N32_NA5
      port( RST, EN, EN_RD1, EN_RD2, EN_WR : in std_logic;  ADD_RD1, ADD_RD2, 
            ADD_WR : in std_logic_vector (4 downto 0);  DATAIN : in 
            std_logic_vector (31 downto 0);  OUT1, OUT2 : out std_logic_vector 
            (31 downto 0));
   end component;
   
   component LDR_N32_6
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component LDR_N32_0
      port( RST, EN : in std_logic;  REGIN : in std_logic_vector (31 downto 0);
            REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component MUX21_N32_0
      port( A, B : in std_logic_vector (31 downto 0);  S : in std_logic;  Y : 
            out std_logic_vector (31 downto 0));
   end component;
   
   component FFDR_N32
      port( CLK, RST, EN : in std_logic;  REGIN : in std_logic_vector (31 
            downto 0);  REGOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component DFF_X1
      port( D, CK : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal X_Logic1_port, IR_OUT_31_port, IR_OUT_30_port, IR_OUT_29_port, 
      IR_OUT_28_port, IR_OUT_27_port, IR_OUT_26_port, IR_OUT_25_port, 
      IR_OUT_24_port, IR_OUT_23_port, IR_OUT_22_port, IR_OUT_21_port, 
      IR_OUT_20_port, IR_OUT_19_port, IR_OUT_18_port, IR_OUT_17_port, 
      IR_OUT_16_port, IR_OUT_15_port, IR_OUT_14_port, IR_OUT_13_port, 
      IR_OUT_12_port, IR_OUT_11_port, IR_OUT_10_port, IR_OUT_9_port, 
      IR_OUT_8_port, IR_OUT_7_port, IR_OUT_6_port, IR_OUT_5_port, IR_OUT_4_port
      , IR_OUT_3_port, IR_OUT_2_port, IR_OUT_1_port, IR_OUT_0_port, 
      PC_OUT_31_port, PC_OUT_30_port, PC_OUT_29_port, PC_OUT_28_port, 
      PC_OUT_27_port, PC_OUT_26_port, PC_OUT_25_port, PC_OUT_24_port, 
      PC_OUT_23_port, PC_OUT_22_port, PC_OUT_21_port, PC_OUT_20_port, 
      PC_OUT_19_port, PC_OUT_18_port, PC_OUT_17_port, PC_OUT_16_port, 
      PC_OUT_15_port, PC_OUT_14_port, PC_OUT_13_port, PC_OUT_12_port, 
      PC_OUT_11_port, PC_OUT_10_port, PC_OUT_9_port, PC_OUT_8_port, 
      PC_OUT_7_port, PC_OUT_6_port, PC_OUT_5_port, PC_OUT_4_port, PC_OUT_3_port
      , PC_OUT_2_port, PC_OUT_1_port, PC_OUT_0_port, ALU_OUT_31_port, 
      ALU_OUT_30_port, ALU_OUT_29_port, ALU_OUT_28_port, ALU_OUT_27_port, 
      ALU_OUT_26_port, ALU_OUT_25_port, ALU_OUT_24_port, ALU_OUT_23_port, 
      ALU_OUT_22_port, ALU_OUT_21_port, ALU_OUT_20_port, ALU_OUT_19_port, 
      ALU_OUT_18_port, ALU_OUT_17_port, ALU_OUT_16_port, ALU_OUT_15_port, 
      ALU_OUT_14_port, ALU_OUT_13_port, ALU_OUT_12_port, ALU_OUT_11_port, 
      ALU_OUT_10_port, ALU_OUT_9_port, ALU_OUT_8_port, ALU_OUT_7_port, 
      ALU_OUT_6_port, ALU_OUT_5_port, ALU_OUT_4_port, ALU_OUT_3_port, 
      ALU_OUT_2_port, ALU_OUT_1_port, ALU_OUT_0_port, IF_ID_IR_31_port, 
      IF_ID_IR_30_port, IF_ID_IR_29_port, IF_ID_IR_28_port, IF_ID_IR_27_port, 
      IF_ID_IR_26_port, IF_ID_IR_25_port, IF_ID_IR_24_port, IF_ID_IR_23_port, 
      IF_ID_IR_22_port, IF_ID_IR_21_port, IF_ID_IR_20_port, IF_ID_IR_19_port, 
      IF_ID_IR_18_port, IF_ID_IR_17_port, IF_ID_IR_16_port, IF_ID_IR_15_port, 
      IF_ID_IR_14_port, IF_ID_IR_13_port, IF_ID_IR_12_port, IF_ID_IR_11_port, 
      IF_ID_IR_10_port, IF_ID_IR_9_port, IF_ID_IR_8_port, IF_ID_IR_7_port, 
      IF_ID_IR_6_port, IF_ID_IR_5_port, IF_ID_IR_4_port, IF_ID_IR_3_port, 
      IF_ID_IR_2_port, IF_ID_IR_1_port, IF_ID_IR_0_port, ID_EX_NPC_31_port, 
      ID_EX_NPC_30_port, ID_EX_NPC_29_port, ID_EX_NPC_28_port, 
      ID_EX_NPC_27_port, ID_EX_NPC_26_port, ID_EX_NPC_25_port, 
      ID_EX_NPC_24_port, ID_EX_NPC_23_port, ID_EX_NPC_22_port, 
      ID_EX_NPC_21_port, ID_EX_NPC_20_port, ID_EX_NPC_19_port, 
      ID_EX_NPC_18_port, ID_EX_NPC_17_port, ID_EX_NPC_16_port, 
      ID_EX_NPC_15_port, ID_EX_NPC_14_port, ID_EX_NPC_13_port, 
      ID_EX_NPC_12_port, ID_EX_NPC_11_port, ID_EX_NPC_10_port, ID_EX_NPC_9_port
      , ID_EX_NPC_8_port, ID_EX_NPC_7_port, ID_EX_NPC_6_port, ID_EX_NPC_5_port,
      ID_EX_NPC_4_port, ID_EX_NPC_3_port, ID_EX_NPC_2_port, ID_EX_NPC_1_port, 
      ID_EX_NPC_0_port, ID_EX_RS1_4_port, ID_EX_RS1_3_port, ID_EX_RS1_2_port, 
      ID_EX_RS1_1_port, ID_EX_RS1_0_port, ID_EX_RS2_4_port, ID_EX_RS2_3_port, 
      ID_EX_RS2_2_port, ID_EX_RS2_1_port, ID_EX_RS2_0_port, 
      ID_EX_RF_OUT1_31_port, ID_EX_RF_OUT1_30_port, ID_EX_RF_OUT1_29_port, 
      ID_EX_RF_OUT1_28_port, ID_EX_RF_OUT1_27_port, ID_EX_RF_OUT1_26_port, 
      ID_EX_RF_OUT1_25_port, ID_EX_RF_OUT1_24_port, ID_EX_RF_OUT1_23_port, 
      ID_EX_RF_OUT1_22_port, ID_EX_RF_OUT1_21_port, ID_EX_RF_OUT1_20_port, 
      ID_EX_RF_OUT1_19_port, ID_EX_RF_OUT1_18_port, ID_EX_RF_OUT1_17_port, 
      ID_EX_RF_OUT1_16_port, ID_EX_RF_OUT1_15_port, ID_EX_RF_OUT1_14_port, 
      ID_EX_RF_OUT1_13_port, ID_EX_RF_OUT1_12_port, ID_EX_RF_OUT1_11_port, 
      ID_EX_RF_OUT1_10_port, ID_EX_RF_OUT1_9_port, ID_EX_RF_OUT1_8_port, 
      ID_EX_RF_OUT1_7_port, ID_EX_RF_OUT1_6_port, ID_EX_RF_OUT1_5_port, 
      ID_EX_RF_OUT1_4_port, ID_EX_RF_OUT1_3_port, ID_EX_RF_OUT1_2_port, 
      ID_EX_RF_OUT1_1_port, ID_EX_RF_OUT1_0_port, ID_EX_RF_OUT2_31_port, 
      ID_EX_RF_OUT2_30_port, ID_EX_RF_OUT2_29_port, ID_EX_RF_OUT2_28_port, 
      ID_EX_RF_OUT2_27_port, ID_EX_RF_OUT2_26_port, ID_EX_RF_OUT2_25_port, 
      ID_EX_RF_OUT2_24_port, ID_EX_RF_OUT2_23_port, ID_EX_RF_OUT2_22_port, 
      ID_EX_RF_OUT2_21_port, ID_EX_RF_OUT2_20_port, ID_EX_RF_OUT2_19_port, 
      ID_EX_RF_OUT2_18_port, ID_EX_RF_OUT2_17_port, ID_EX_RF_OUT2_16_port, 
      ID_EX_RF_OUT2_15_port, ID_EX_RF_OUT2_14_port, ID_EX_RF_OUT2_13_port, 
      ID_EX_RF_OUT2_12_port, ID_EX_RF_OUT2_11_port, ID_EX_RF_OUT2_10_port, 
      ID_EX_RF_OUT2_9_port, ID_EX_RF_OUT2_8_port, ID_EX_RF_OUT2_7_port, 
      ID_EX_RF_OUT2_6_port, ID_EX_RF_OUT2_5_port, ID_EX_RF_OUT2_4_port, 
      ID_EX_RF_OUT2_3_port, ID_EX_RF_OUT2_2_port, ID_EX_RF_OUT2_1_port, 
      ID_EX_RF_OUT2_0_port, ID_EX_IMM_31_port, ID_EX_IMM_30_port, 
      ID_EX_IMM_29_port, ID_EX_IMM_28_port, ID_EX_IMM_27_port, 
      ID_EX_IMM_26_port, ID_EX_IMM_25_port, ID_EX_IMM_24_port, 
      ID_EX_IMM_23_port, ID_EX_IMM_22_port, ID_EX_IMM_21_port, 
      ID_EX_IMM_20_port, ID_EX_IMM_19_port, ID_EX_IMM_18_port, 
      ID_EX_IMM_17_port, ID_EX_IMM_16_port, ID_EX_IMM_15_port, 
      ID_EX_IMM_14_port, ID_EX_IMM_13_port, ID_EX_IMM_12_port, 
      ID_EX_IMM_11_port, ID_EX_IMM_10_port, ID_EX_IMM_9_port, ID_EX_IMM_8_port,
      ID_EX_IMM_7_port, ID_EX_IMM_6_port, ID_EX_IMM_5_port, ID_EX_IMM_4_port, 
      ID_EX_IMM_3_port, ID_EX_IMM_2_port, ID_EX_IMM_1_port, ID_EX_IMM_0_port, 
      EX_MEM_RF_WE, EX_MEM_BRANCH_DETECT, EX_MEM_RD_4_port, EX_MEM_RD_3_port, 
      EX_MEM_RD_2_port, EX_MEM_RD_1_port, EX_MEM_RD_0_port, MEM_WB_RF_WE, 
      MEM_WB_ALU_OUTPUT_31_port, MEM_WB_ALU_OUTPUT_30_port, 
      MEM_WB_ALU_OUTPUT_29_port, MEM_WB_ALU_OUTPUT_28_port, 
      MEM_WB_ALU_OUTPUT_27_port, MEM_WB_ALU_OUTPUT_26_port, 
      MEM_WB_ALU_OUTPUT_25_port, MEM_WB_ALU_OUTPUT_24_port, 
      MEM_WB_ALU_OUTPUT_23_port, MEM_WB_ALU_OUTPUT_22_port, 
      MEM_WB_ALU_OUTPUT_21_port, MEM_WB_ALU_OUTPUT_20_port, 
      MEM_WB_ALU_OUTPUT_19_port, MEM_WB_ALU_OUTPUT_18_port, 
      MEM_WB_ALU_OUTPUT_17_port, MEM_WB_ALU_OUTPUT_16_port, 
      MEM_WB_ALU_OUTPUT_15_port, MEM_WB_ALU_OUTPUT_14_port, 
      MEM_WB_ALU_OUTPUT_13_port, MEM_WB_ALU_OUTPUT_12_port, 
      MEM_WB_ALU_OUTPUT_11_port, MEM_WB_ALU_OUTPUT_10_port, 
      MEM_WB_ALU_OUTPUT_9_port, MEM_WB_ALU_OUTPUT_8_port, 
      MEM_WB_ALU_OUTPUT_7_port, MEM_WB_ALU_OUTPUT_6_port, 
      MEM_WB_ALU_OUTPUT_5_port, MEM_WB_ALU_OUTPUT_4_port, 
      MEM_WB_ALU_OUTPUT_3_port, MEM_WB_ALU_OUTPUT_2_port, 
      MEM_WB_ALU_OUTPUT_1_port, MEM_WB_ALU_OUTPUT_0_port, 
      MEM_WB_DRAM_OUTPUT_31_port, MEM_WB_DRAM_OUTPUT_30_port, 
      MEM_WB_DRAM_OUTPUT_29_port, MEM_WB_DRAM_OUTPUT_28_port, 
      MEM_WB_DRAM_OUTPUT_27_port, MEM_WB_DRAM_OUTPUT_26_port, 
      MEM_WB_DRAM_OUTPUT_25_port, MEM_WB_DRAM_OUTPUT_24_port, 
      MEM_WB_DRAM_OUTPUT_23_port, MEM_WB_DRAM_OUTPUT_22_port, 
      MEM_WB_DRAM_OUTPUT_21_port, MEM_WB_DRAM_OUTPUT_20_port, 
      MEM_WB_DRAM_OUTPUT_19_port, MEM_WB_DRAM_OUTPUT_18_port, 
      MEM_WB_DRAM_OUTPUT_17_port, MEM_WB_DRAM_OUTPUT_16_port, 
      MEM_WB_DRAM_OUTPUT_15_port, MEM_WB_DRAM_OUTPUT_14_port, 
      MEM_WB_DRAM_OUTPUT_13_port, MEM_WB_DRAM_OUTPUT_12_port, 
      MEM_WB_DRAM_OUTPUT_11_port, MEM_WB_DRAM_OUTPUT_10_port, 
      MEM_WB_DRAM_OUTPUT_9_port, MEM_WB_DRAM_OUTPUT_8_port, 
      MEM_WB_DRAM_OUTPUT_7_port, MEM_WB_DRAM_OUTPUT_6_port, 
      MEM_WB_DRAM_OUTPUT_5_port, MEM_WB_DRAM_OUTPUT_4_port, 
      MEM_WB_DRAM_OUTPUT_3_port, MEM_WB_DRAM_OUTPUT_2_port, 
      MEM_WB_DRAM_OUTPUT_1_port, MEM_WB_DRAM_OUTPUT_0_port, MEM_WB_RD_4_port, 
      MEM_WB_RD_3_port, MEM_WB_RD_2_port, MEM_WB_RD_1_port, MEM_WB_RD_0_port, 
      ID_EX_RF_DATAIN_NEXT_31_port, ID_EX_RF_DATAIN_NEXT_30_port, 
      ID_EX_RF_DATAIN_NEXT_29_port, ID_EX_RF_DATAIN_NEXT_28_port, 
      ID_EX_RF_DATAIN_NEXT_27_port, ID_EX_RF_DATAIN_NEXT_26_port, 
      ID_EX_RF_DATAIN_NEXT_25_port, ID_EX_RF_DATAIN_NEXT_24_port, 
      ID_EX_RF_DATAIN_NEXT_23_port, ID_EX_RF_DATAIN_NEXT_22_port, 
      ID_EX_RF_DATAIN_NEXT_21_port, ID_EX_RF_DATAIN_NEXT_20_port, 
      ID_EX_RF_DATAIN_NEXT_19_port, ID_EX_RF_DATAIN_NEXT_18_port, 
      ID_EX_RF_DATAIN_NEXT_17_port, ID_EX_RF_DATAIN_NEXT_16_port, 
      ID_EX_RF_DATAIN_NEXT_15_port, ID_EX_RF_DATAIN_NEXT_14_port, 
      ID_EX_RF_DATAIN_NEXT_13_port, ID_EX_RF_DATAIN_NEXT_12_port, 
      ID_EX_RF_DATAIN_NEXT_11_port, ID_EX_RF_DATAIN_NEXT_10_port, 
      ID_EX_RF_DATAIN_NEXT_9_port, ID_EX_RF_DATAIN_NEXT_8_port, 
      ID_EX_RF_DATAIN_NEXT_7_port, ID_EX_RF_DATAIN_NEXT_6_port, 
      ID_EX_RF_DATAIN_NEXT_5_port, ID_EX_RF_DATAIN_NEXT_4_port, 
      ID_EX_RF_DATAIN_NEXT_3_port, ID_EX_RF_DATAIN_NEXT_2_port, 
      ID_EX_RF_DATAIN_NEXT_1_port, ID_EX_RF_DATAIN_NEXT_0_port, 
      ID_EX_RF_OUT1_NEXT_31_port, ID_EX_RF_OUT1_NEXT_30_port, 
      ID_EX_RF_OUT1_NEXT_29_port, ID_EX_RF_OUT1_NEXT_28_port, 
      ID_EX_RF_OUT1_NEXT_27_port, ID_EX_RF_OUT1_NEXT_26_port, 
      ID_EX_RF_OUT1_NEXT_25_port, ID_EX_RF_OUT1_NEXT_24_port, 
      ID_EX_RF_OUT1_NEXT_23_port, ID_EX_RF_OUT1_NEXT_22_port, 
      ID_EX_RF_OUT1_NEXT_21_port, ID_EX_RF_OUT1_NEXT_20_port, 
      ID_EX_RF_OUT1_NEXT_19_port, ID_EX_RF_OUT1_NEXT_18_port, 
      ID_EX_RF_OUT1_NEXT_17_port, ID_EX_RF_OUT1_NEXT_16_port, 
      ID_EX_RF_OUT1_NEXT_15_port, ID_EX_RF_OUT1_NEXT_14_port, 
      ID_EX_RF_OUT1_NEXT_13_port, ID_EX_RF_OUT1_NEXT_12_port, 
      ID_EX_RF_OUT1_NEXT_11_port, ID_EX_RF_OUT1_NEXT_10_port, 
      ID_EX_RF_OUT1_NEXT_9_port, ID_EX_RF_OUT1_NEXT_8_port, 
      ID_EX_RF_OUT1_NEXT_7_port, ID_EX_RF_OUT1_NEXT_6_port, 
      ID_EX_RF_OUT1_NEXT_5_port, ID_EX_RF_OUT1_NEXT_4_port, 
      ID_EX_RF_OUT1_NEXT_3_port, ID_EX_RF_OUT1_NEXT_2_port, 
      ID_EX_RF_OUT1_NEXT_1_port, ID_EX_RF_OUT1_NEXT_0_port, 
      ID_EX_RF_OUT2_NEXT_31_port, ID_EX_RF_OUT2_NEXT_30_port, 
      ID_EX_RF_OUT2_NEXT_29_port, ID_EX_RF_OUT2_NEXT_28_port, 
      ID_EX_RF_OUT2_NEXT_27_port, ID_EX_RF_OUT2_NEXT_26_port, 
      ID_EX_RF_OUT2_NEXT_25_port, ID_EX_RF_OUT2_NEXT_24_port, 
      ID_EX_RF_OUT2_NEXT_23_port, ID_EX_RF_OUT2_NEXT_22_port, 
      ID_EX_RF_OUT2_NEXT_21_port, ID_EX_RF_OUT2_NEXT_20_port, 
      ID_EX_RF_OUT2_NEXT_19_port, ID_EX_RF_OUT2_NEXT_18_port, 
      ID_EX_RF_OUT2_NEXT_17_port, ID_EX_RF_OUT2_NEXT_16_port, 
      ID_EX_RF_OUT2_NEXT_15_port, ID_EX_RF_OUT2_NEXT_14_port, 
      ID_EX_RF_OUT2_NEXT_13_port, ID_EX_RF_OUT2_NEXT_12_port, 
      ID_EX_RF_OUT2_NEXT_11_port, ID_EX_RF_OUT2_NEXT_10_port, 
      ID_EX_RF_OUT2_NEXT_9_port, ID_EX_RF_OUT2_NEXT_8_port, 
      ID_EX_RF_OUT2_NEXT_7_port, ID_EX_RF_OUT2_NEXT_6_port, 
      ID_EX_RF_OUT2_NEXT_5_port, ID_EX_RF_OUT2_NEXT_4_port, 
      ID_EX_RF_OUT2_NEXT_3_port, ID_EX_RF_OUT2_NEXT_2_port, 
      ID_EX_RF_OUT2_NEXT_1_port, ID_EX_RF_OUT2_NEXT_0_port, 
      ID_EX_IMM_NEXT_31_port, ID_EX_IMM_NEXT_30_port, ID_EX_IMM_NEXT_29_port, 
      ID_EX_IMM_NEXT_28_port, ID_EX_IMM_NEXT_27_port, ID_EX_IMM_NEXT_26_port, 
      ID_EX_IMM_NEXT_25_port, ID_EX_IMM_NEXT_24_port, ID_EX_IMM_NEXT_23_port, 
      ID_EX_IMM_NEXT_22_port, ID_EX_IMM_NEXT_21_port, ID_EX_IMM_NEXT_20_port, 
      ID_EX_IMM_NEXT_19_port, ID_EX_IMM_NEXT_18_port, ID_EX_IMM_NEXT_17_port, 
      ID_EX_IMM_NEXT_16_port, ID_EX_IMM_NEXT_15_port, ID_EX_IMM_NEXT_14_port, 
      ID_EX_IMM_NEXT_13_port, ID_EX_IMM_NEXT_12_port, ID_EX_IMM_NEXT_11_port, 
      ID_EX_IMM_NEXT_10_port, ID_EX_IMM_NEXT_9_port, ID_EX_IMM_NEXT_8_port, 
      ID_EX_IMM_NEXT_7_port, ID_EX_IMM_NEXT_6_port, ID_EX_IMM_NEXT_5_port, 
      ID_EX_IMM_NEXT_4_port, ID_EX_IMM_NEXT_3_port, ID_EX_IMM_NEXT_2_port, 
      ID_EX_IMM_NEXT_1_port, ID_EX_IMM_NEXT_0_port, 
      EX_MEM_ALU_OUTPUT_NEXT_31_port, EX_MEM_ALU_OUTPUT_NEXT_30_port, 
      EX_MEM_ALU_OUTPUT_NEXT_29_port, EX_MEM_ALU_OUTPUT_NEXT_28_port, 
      EX_MEM_ALU_OUTPUT_NEXT_27_port, EX_MEM_ALU_OUTPUT_NEXT_26_port, 
      EX_MEM_ALU_OUTPUT_NEXT_25_port, EX_MEM_ALU_OUTPUT_NEXT_24_port, 
      EX_MEM_ALU_OUTPUT_NEXT_23_port, EX_MEM_ALU_OUTPUT_NEXT_22_port, 
      EX_MEM_ALU_OUTPUT_NEXT_21_port, EX_MEM_ALU_OUTPUT_NEXT_20_port, 
      EX_MEM_ALU_OUTPUT_NEXT_19_port, EX_MEM_ALU_OUTPUT_NEXT_18_port, 
      EX_MEM_ALU_OUTPUT_NEXT_17_port, EX_MEM_ALU_OUTPUT_NEXT_16_port, 
      EX_MEM_ALU_OUTPUT_NEXT_15_port, EX_MEM_ALU_OUTPUT_NEXT_14_port, 
      EX_MEM_ALU_OUTPUT_NEXT_13_port, EX_MEM_ALU_OUTPUT_NEXT_12_port, 
      EX_MEM_ALU_OUTPUT_NEXT_11_port, EX_MEM_ALU_OUTPUT_NEXT_10_port, 
      EX_MEM_ALU_OUTPUT_NEXT_9_port, EX_MEM_ALU_OUTPUT_NEXT_8_port, 
      EX_MEM_ALU_OUTPUT_NEXT_7_port, EX_MEM_ALU_OUTPUT_NEXT_6_port, 
      EX_MEM_ALU_OUTPUT_NEXT_5_port, EX_MEM_ALU_OUTPUT_NEXT_4_port, 
      EX_MEM_ALU_OUTPUT_NEXT_3_port, EX_MEM_ALU_OUTPUT_NEXT_2_port, 
      EX_MEM_ALU_OUTPUT_NEXT_1_port, EX_MEM_ALU_OUTPUT_NEXT_0_port, 
      EX_MEM_BRANCH_DETECT_NEXT, MEM_WB_DRAM_OUTPUT_NEXT_31_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_30_port, MEM_WB_DRAM_OUTPUT_NEXT_29_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_28_port, MEM_WB_DRAM_OUTPUT_NEXT_27_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_26_port, MEM_WB_DRAM_OUTPUT_NEXT_25_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_24_port, MEM_WB_DRAM_OUTPUT_NEXT_23_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_22_port, MEM_WB_DRAM_OUTPUT_NEXT_21_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_20_port, MEM_WB_DRAM_OUTPUT_NEXT_19_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_18_port, MEM_WB_DRAM_OUTPUT_NEXT_17_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_16_port, MEM_WB_DRAM_OUTPUT_NEXT_15_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_14_port, MEM_WB_DRAM_OUTPUT_NEXT_13_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_12_port, MEM_WB_DRAM_OUTPUT_NEXT_11_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_10_port, MEM_WB_DRAM_OUTPUT_NEXT_9_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_8_port, MEM_WB_DRAM_OUTPUT_NEXT_7_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_6_port, MEM_WB_DRAM_OUTPUT_NEXT_5_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_4_port, MEM_WB_DRAM_OUTPUT_NEXT_3_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_2_port, MEM_WB_DRAM_OUTPUT_NEXT_1_port, 
      MEM_WB_DRAM_OUTPUT_NEXT_0_port, N4, N5, N6, N7, N8, N9, N10, N11, N12, 
      N13, N14, N15, N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27
      , N28, N29, N30, N31, N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, 
      N42, N43, N44, N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56
      , N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, N67, N68, N69, N70, 
      N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N81, N82, N83, N84, N85
      , N86, N87, N88, N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N99, 
      N100, N101, N102, N103, N104, N105, N106, N107, N108, N109, N110, N111, 
      N112, N113, N114, N115, N116, N117, N118, N119, N120, N121, N122, N123, 
      N124, N125, N126, N127, N128, N129, N130, N131, N132, N133, N134, N135, 
      N136, N137, N138, N139, N140, N141, N142, N143, N144, N145, N146, N147, 
      N148, N149, N150, N151, N152, N153, N154, N155, N156, N157, N158, N159, 
      N160, N161, N162, N163, N164, N165, N166, N167, N168, N169, N170, N171, 
      N172, N173, N174, N175, N176, N177, N178, N179, N180, N181, N182, N183, 
      N184, N185, N186, N187, N188, N189, N190, N191, N192, N193, N194, N195, 
      N196, N197, N198, N199, N200, N201, N202, N203, N204, N205, N206, N207, 
      N208, N209, N210, N211, N212, N213, N214, N215, N216, N217, N218, N219, 
      N220, N221, N222, N223, N224, N225, N226, N227, N228, N229, N230, N231, 
      N232, N233, N234, N235, N236, N237, N238, N239, N240, N241, N242, N243, 
      N244, N245, N246, N247, N248, N249, N250, N251, N252, N253, N254, N255, 
      N256, N257, N258, N259, N260, N261, N262, N263, N264, N265, N266, N267, 
      N268, N269, N270, N271, N272, N273, N274, N275, N276, N277, N278, N279, 
      N280, N281, N282, N283, N284, N285, N286, N287, N288, N289, N290, N291, 
      N292, N293, N294, N295, N296, N297, N298, N299, N300, N301, N302, N303, 
      N304, N305, N306, N307, N308, N309, N310, N311, N312, N313, N314, N315, 
      N316, N317, N318, N319, N320, N321, N322, N323, N324, N325, N326, N327, 
      N328, N329, N330, N331, N332, N333, N334, N335, N336, N337, N338, N339, 
      N340, N341, N342, N343, N344, N345, N346, N347, N348, N349, N350, N351, 
      N352, PC_BUS_31_port, PC_BUS_30_port, PC_BUS_29_port, PC_BUS_28_port, 
      PC_BUS_27_port, PC_BUS_26_port, PC_BUS_25_port, PC_BUS_24_port, 
      PC_BUS_23_port, PC_BUS_22_port, PC_BUS_21_port, PC_BUS_20_port, 
      PC_BUS_19_port, PC_BUS_18_port, PC_BUS_17_port, PC_BUS_16_port, 
      PC_BUS_15_port, PC_BUS_14_port, PC_BUS_13_port, PC_BUS_12_port, 
      PC_BUS_11_port, PC_BUS_10_port, PC_BUS_9_port, PC_BUS_8_port, 
      PC_BUS_7_port, PC_BUS_6_port, PC_BUS_5_port, PC_BUS_4_port, PC_BUS_3_port
      , PC_BUS_2_port, PC_BUS_1_port, PC_BUS_0_port, NPC_BUS_31_port, 
      NPC_BUS_30_port, NPC_BUS_29_port, NPC_BUS_28_port, NPC_BUS_27_port, 
      NPC_BUS_26_port, NPC_BUS_25_port, NPC_BUS_24_port, NPC_BUS_23_port, 
      NPC_BUS_22_port, NPC_BUS_21_port, NPC_BUS_20_port, NPC_BUS_19_port, 
      NPC_BUS_18_port, NPC_BUS_17_port, NPC_BUS_16_port, NPC_BUS_15_port, 
      NPC_BUS_14_port, NPC_BUS_13_port, NPC_BUS_12_port, NPC_BUS_11_port, 
      NPC_BUS_10_port, NPC_BUS_9_port, NPC_BUS_8_port, NPC_BUS_7_port, 
      NPC_BUS_6_port, NPC_BUS_5_port, NPC_BUS_4_port, NPC_BUS_3_port, 
      NPC_BUS_2_port, NPC_BUS_1_port, NPC_BUS_0_port, NPC_OUT_31_port, 
      NPC_OUT_30_port, NPC_OUT_29_port, NPC_OUT_28_port, NPC_OUT_27_port, 
      NPC_OUT_26_port, NPC_OUT_25_port, NPC_OUT_24_port, NPC_OUT_23_port, 
      NPC_OUT_22_port, NPC_OUT_21_port, NPC_OUT_20_port, NPC_OUT_19_port, 
      NPC_OUT_18_port, NPC_OUT_17_port, NPC_OUT_16_port, NPC_OUT_15_port, 
      NPC_OUT_14_port, NPC_OUT_13_port, NPC_OUT_12_port, NPC_OUT_11_port, 
      NPC_OUT_10_port, NPC_OUT_9_port, NPC_OUT_8_port, NPC_OUT_7_port, 
      NPC_OUT_6_port, NPC_OUT_5_port, NPC_OUT_4_port, NPC_OUT_3_port, 
      NPC_OUT_2_port, NPC_OUT_1_port, NPC_OUT_0_port, RS1_4_port, RS1_3_port, 
      RS1_2_port, RS1_1_port, RS1_0_port, RS2_4_port, RS2_3_port, RS2_2_port, 
      RS2_1_port, RS2_0_port, RF_OUT1_31_port, RF_OUT1_30_port, RF_OUT1_29_port
      , RF_OUT1_28_port, RF_OUT1_27_port, RF_OUT1_26_port, RF_OUT1_25_port, 
      RF_OUT1_24_port, RF_OUT1_23_port, RF_OUT1_22_port, RF_OUT1_21_port, 
      RF_OUT1_20_port, RF_OUT1_19_port, RF_OUT1_18_port, RF_OUT1_17_port, 
      RF_OUT1_16_port, RF_OUT1_15_port, RF_OUT1_14_port, RF_OUT1_13_port, 
      RF_OUT1_12_port, RF_OUT1_11_port, RF_OUT1_10_port, RF_OUT1_9_port, 
      RF_OUT1_8_port, RF_OUT1_7_port, RF_OUT1_6_port, RF_OUT1_5_port, 
      RF_OUT1_4_port, RF_OUT1_3_port, RF_OUT1_2_port, RF_OUT1_1_port, 
      RF_OUT1_0_port, RF_OUT2_31_port, RF_OUT2_30_port, RF_OUT2_29_port, 
      RF_OUT2_28_port, RF_OUT2_27_port, RF_OUT2_26_port, RF_OUT2_25_port, 
      RF_OUT2_24_port, RF_OUT2_23_port, RF_OUT2_22_port, RF_OUT2_21_port, 
      RF_OUT2_20_port, RF_OUT2_19_port, RF_OUT2_18_port, RF_OUT2_17_port, 
      RF_OUT2_16_port, RF_OUT2_15_port, RF_OUT2_14_port, RF_OUT2_13_port, 
      RF_OUT2_12_port, RF_OUT2_11_port, RF_OUT2_10_port, RF_OUT2_9_port, 
      RF_OUT2_8_port, RF_OUT2_7_port, RF_OUT2_6_port, RF_OUT2_5_port, 
      RF_OUT2_4_port, RF_OUT2_3_port, RF_OUT2_2_port, RF_OUT2_1_port, 
      RF_OUT2_0_port, IMM_OUT_31_port, IMM_OUT_30_port, IMM_OUT_29_port, 
      IMM_OUT_28_port, IMM_OUT_27_port, IMM_OUT_26_port, IMM_OUT_25_port, 
      IMM_OUT_24_port, IMM_OUT_23_port, IMM_OUT_22_port, IMM_OUT_21_port, 
      IMM_OUT_20_port, IMM_OUT_19_port, IMM_OUT_18_port, IMM_OUT_17_port, 
      IMM_OUT_16_port, IMM_OUT_15_port, IMM_OUT_14_port, IMM_OUT_13_port, 
      IMM_OUT_12_port, IMM_OUT_11_port, IMM_OUT_10_port, IMM_OUT_9_port, 
      IMM_OUT_8_port, IMM_OUT_7_port, IMM_OUT_6_port, IMM_OUT_5_port, 
      IMM_OUT_4_port, IMM_OUT_3_port, IMM_OUT_2_port, IMM_OUT_1_port, 
      IMM_OUT_0_port, RD_4_port, RD_3_port, RD_2_port, RD_1_port, RD_0_port, 
      FORWARD_A_1_port, FORWARD_A_0_port, ALU_PREOP1_31_port, 
      ALU_PREOP1_30_port, ALU_PREOP1_29_port, ALU_PREOP1_28_port, 
      ALU_PREOP1_27_port, ALU_PREOP1_26_port, ALU_PREOP1_25_port, 
      ALU_PREOP1_24_port, ALU_PREOP1_23_port, ALU_PREOP1_22_port, 
      ALU_PREOP1_21_port, ALU_PREOP1_20_port, ALU_PREOP1_19_port, 
      ALU_PREOP1_18_port, ALU_PREOP1_17_port, ALU_PREOP1_16_port, 
      ALU_PREOP1_15_port, ALU_PREOP1_14_port, ALU_PREOP1_13_port, 
      ALU_PREOP1_12_port, ALU_PREOP1_11_port, ALU_PREOP1_10_port, 
      ALU_PREOP1_9_port, ALU_PREOP1_8_port, ALU_PREOP1_7_port, 
      ALU_PREOP1_6_port, ALU_PREOP1_5_port, ALU_PREOP1_4_port, 
      ALU_PREOP1_3_port, ALU_PREOP1_2_port, ALU_PREOP1_1_port, 
      ALU_PREOP1_0_port, FORWARD_B_1_port, FORWARD_B_0_port, ALU_OP1_31_port, 
      ALU_OP1_30_port, ALU_OP1_29_port, ALU_OP1_28_port, ALU_OP1_27_port, 
      ALU_OP1_26_port, ALU_OP1_25_port, ALU_OP1_24_port, ALU_OP1_23_port, 
      ALU_OP1_22_port, ALU_OP1_21_port, ALU_OP1_20_port, ALU_OP1_19_port, 
      ALU_OP1_18_port, ALU_OP1_17_port, ALU_OP1_16_port, ALU_OP1_15_port, 
      ALU_OP1_14_port, ALU_OP1_13_port, ALU_OP1_12_port, ALU_OP1_11_port, 
      ALU_OP1_10_port, ALU_OP1_9_port, ALU_OP1_8_port, ALU_OP1_7_port, 
      ALU_OP1_6_port, ALU_OP1_5_port, ALU_OP1_4_port, ALU_OP1_3_port, 
      ALU_OP1_2_port, ALU_OP1_1_port, ALU_OP1_0_port, ALU_OP2_31_port, 
      ALU_OP2_30_port, ALU_OP2_29_port, ALU_OP2_28_port, ALU_OP2_27_port, 
      ALU_OP2_26_port, ALU_OP2_25_port, ALU_OP2_24_port, ALU_OP2_23_port, 
      ALU_OP2_22_port, ALU_OP2_21_port, ALU_OP2_20_port, ALU_OP2_19_port, 
      ALU_OP2_18_port, ALU_OP2_17_port, ALU_OP2_16_port, ALU_OP2_15_port, 
      ALU_OP2_14_port, ALU_OP2_13_port, ALU_OP2_12_port, ALU_OP2_11_port, 
      ALU_OP2_10_port, ALU_OP2_9_port, ALU_OP2_8_port, ALU_OP2_7_port, 
      ALU_OP2_6_port, ALU_OP2_5_port, ALU_OP2_4_port, ALU_OP2_3_port, 
      ALU_OP2_2_port, ALU_OP2_1_port, ALU_OP2_0_port, ALU_OUTPUT_31_port, 
      ALU_OUTPUT_30_port, ALU_OUTPUT_29_port, ALU_OUTPUT_28_port, 
      ALU_OUTPUT_27_port, ALU_OUTPUT_26_port, ALU_OUTPUT_25_port, 
      ALU_OUTPUT_24_port, ALU_OUTPUT_23_port, ALU_OUTPUT_22_port, 
      ALU_OUTPUT_21_port, ALU_OUTPUT_20_port, ALU_OUTPUT_19_port, 
      ALU_OUTPUT_18_port, ALU_OUTPUT_17_port, ALU_OUTPUT_16_port, 
      ALU_OUTPUT_15_port, ALU_OUTPUT_14_port, ALU_OUTPUT_13_port, 
      ALU_OUTPUT_12_port, ALU_OUTPUT_11_port, ALU_OUTPUT_10_port, 
      ALU_OUTPUT_9_port, ALU_OUTPUT_8_port, ALU_OUTPUT_7_port, 
      ALU_OUTPUT_6_port, ALU_OUTPUT_5_port, ALU_OUTPUT_4_port, 
      ALU_OUTPUT_3_port, ALU_OUTPUT_2_port, ALU_OUTPUT_1_port, 
      ALU_OUTPUT_0_port, ZERO_OUT, BRANCH_DETECT, n10_port, n11_port, n12_port,
      n13_port, n14_port, n15_port, n16_port, n17_port, n18_port, n19_port, 
      n20_port, n21_port, n22_port, n23_port, n24_port, n25_port, n26_port, 
      n27_port, n28_port, n29_port, n30_port, n31_port, n32_port, n33_port, 
      n34_port, n35_port, n36_port, n37_port, n38_port, n39_port, n40_port, 
      n41_port, n42_port, n43_port, n44_port, n45_port, n46_port, n47_port, 
      n48_port, n49_port, n50_port, n51_port, n52_port, n53_port, n54_port, 
      n55_port, n56_port, n57_port, n58_port, n59_port, n60_port, n61_port, 
      n62_port, n63_port, n64_port, n65_port, n66_port, n67_port, n68_port, 
      n69_port, n70_port, n71_port, n72_port, n73_port, n74_port, n75_port, 
      n76_port, n77_port, n78_port, n79_port, n80_port, n81_port, n82_port, 
      n83_port, n84_port, n85_port, n86_port, n87_port, n88_port, n89_port, 
      n90_port, n91_port, n92_port, n93_port, n94_port, n95_port, n96_port, 
      n97_port, n98_port, n99_port, n100_port, n101_port, n102_port, n103_port,
      n104_port, n105_port, n106_port, n107_port, n108_port, n109_port, 
      n110_port, n111_port, n112_port, n113_port, n114_port, n115_port, 
      n116_port, n117_port, n2, n3, n4_port, ALU_PREOP2_9_port, 
      ALU_PREOP2_8_port, ALU_PREOP2_7_port, ALU_PREOP2_6_port, 
      ALU_PREOP2_5_port, ALU_PREOP2_4_port, ALU_PREOP2_3_port, 
      ALU_PREOP2_31_port, ALU_PREOP2_30_port, ALU_PREOP2_2_port, 
      ALU_PREOP2_29_port, ALU_PREOP2_28_port, ALU_PREOP2_27_port, 
      ALU_PREOP2_26_port, ALU_PREOP2_25_port, ALU_PREOP2_24_port, 
      ALU_PREOP2_23_port, ALU_PREOP2_22_port, ALU_PREOP2_21_port, 
      ALU_PREOP2_20_port, ALU_PREOP2_1_port, ALU_PREOP2_19_port, 
      ALU_PREOP2_18_port, ALU_PREOP2_17_port, ALU_PREOP2_16_port, 
      ALU_PREOP2_15_port, ALU_PREOP2_14_port, ALU_PREOP2_13_port, 
      ALU_PREOP2_12_port, ALU_PREOP2_11_port, ALU_PREOP2_10_port, 
      ALU_PREOP2_0_port, n191_port, n192_port, n193_port, n194_port, n195_port,
      n196_port, n197_port, n198_port, n199_port, n200_port, n201_port, n_1257,
      n_1258, n_1259, n_1260, n_1261, n_1262, n_1263, n_1264, n_1265, n_1266, 
      n_1267, n_1268, n_1269, n_1270, n_1271, n_1272, n_1273, n_1274, n_1275, 
      n_1276, n_1277, n_1278, n_1279, n_1280, n_1281, n_1282, n_1283, n_1284, 
      n_1285, n_1286, n_1287, n_1288, n_1289, n_1290, n_1291, n_1292, n_1293, 
      n_1294, n_1295, n_1296, n_1297, n_1298, n_1299, n_1300, n_1301, n_1302, 
      n_1303, n_1304, n_1305, n_1306, n_1307, n_1308, n_1309, n_1310, n_1311, 
      n_1312, n_1313, n_1314, n_1315, n_1316, n_1317, n_1318, n_1319, n_1320, 
      n_1321, n_1322, n_1323, n_1324, n_1325, n_1326, n_1327, n_1328, n_1329, 
      n_1330, n_1331, n_1332, n_1333, n_1334, n_1335, n_1336, n_1337, n_1338, 
      n_1339, n_1340, n_1341, n_1342, n_1343, n_1344, n_1345, n_1346, n_1347, 
      n_1348, n_1349, n_1350, n_1351, n_1352, n_1353, n_1354, n_1355, n_1356, 
      n_1357, n_1358, n_1359, n_1360, n_1361, n_1362, n_1363, n_1364, n_1365, 
      n_1366, n_1367, n_1368, n_1369, n_1370, n_1371, n_1372, n_1373, n_1374, 
      n_1375, n_1376, n_1377, n_1378, n_1379, n_1380, n_1381, n_1382, n_1383, 
      n_1384, n_1385, n_1386, n_1387, n_1388, n_1389, n_1390, n_1391, n_1392, 
      n_1393, n_1394, n_1395, n_1396, n_1397, n_1398, n_1399, n_1400, n_1401, 
      n_1402, n_1403, n_1404, n_1405, n_1406, n_1407, n_1408, n_1409, n_1410, 
      n_1411, n_1412, n_1413, n_1414, n_1415, n_1416, n_1417, n_1418, n_1419, 
      n_1420, n_1421, n_1422, n_1423, n_1424, n_1425, n_1426, n_1427, n_1428, 
      n_1429, n_1430, n_1431, n_1432, n_1433, n_1434, n_1435, n_1436, n_1437, 
      n_1438, n_1439, n_1440, n_1441, n_1442, n_1443, n_1444, n_1445, n_1446, 
      n_1447, n_1448, n_1449, n_1450, n_1451, n_1452, n_1453, n_1454, n_1455, 
      n_1456, n_1457, n_1458, n_1459, n_1460, n_1461, n_1462, n_1463, n_1464, 
      n_1465, n_1466, n_1467, n_1468, n_1469, n_1470, n_1471, n_1472, n_1473, 
      n_1474, n_1475, n_1476, n_1477, n_1478, n_1479, n_1480, n_1481, n_1482, 
      n_1483, n_1484, n_1485, n_1486, n_1487, n_1488, n_1489, n_1490, n_1491, 
      n_1492, n_1493, n_1494, n_1495, n_1496, n_1497, n_1498, n_1499, n_1500, 
      n_1501, n_1502, n_1503, n_1504, n_1505, n_1506, n_1507, n_1508, n_1509, 
      n_1510, n_1511, n_1512, n_1513, n_1514, n_1515, n_1516, n_1517, n_1518, 
      n_1519, n_1520, n_1521, n_1522, n_1523, n_1524, n_1525, n_1526, n_1527, 
      n_1528, n_1529, n_1530, n_1531, n_1532, n_1533, n_1534, n_1535, n_1536, 
      n_1537 : std_logic;

begin
   IR_OUT <= ( IR_OUT_31_port, IR_OUT_30_port, IR_OUT_29_port, IR_OUT_28_port, 
      IR_OUT_27_port, IR_OUT_26_port, IR_OUT_25_port, IR_OUT_24_port, 
      IR_OUT_23_port, IR_OUT_22_port, IR_OUT_21_port, IR_OUT_20_port, 
      IR_OUT_19_port, IR_OUT_18_port, IR_OUT_17_port, IR_OUT_16_port, 
      IR_OUT_15_port, IR_OUT_14_port, IR_OUT_13_port, IR_OUT_12_port, 
      IR_OUT_11_port, IR_OUT_10_port, IR_OUT_9_port, IR_OUT_8_port, 
      IR_OUT_7_port, IR_OUT_6_port, IR_OUT_5_port, IR_OUT_4_port, IR_OUT_3_port
      , IR_OUT_2_port, IR_OUT_1_port, IR_OUT_0_port );
   PC_OUT <= ( PC_OUT_31_port, PC_OUT_30_port, PC_OUT_29_port, PC_OUT_28_port, 
      PC_OUT_27_port, PC_OUT_26_port, PC_OUT_25_port, PC_OUT_24_port, 
      PC_OUT_23_port, PC_OUT_22_port, PC_OUT_21_port, PC_OUT_20_port, 
      PC_OUT_19_port, PC_OUT_18_port, PC_OUT_17_port, PC_OUT_16_port, 
      PC_OUT_15_port, PC_OUT_14_port, PC_OUT_13_port, PC_OUT_12_port, 
      PC_OUT_11_port, PC_OUT_10_port, PC_OUT_9_port, PC_OUT_8_port, 
      PC_OUT_7_port, PC_OUT_6_port, PC_OUT_5_port, PC_OUT_4_port, PC_OUT_3_port
      , PC_OUT_2_port, PC_OUT_1_port, PC_OUT_0_port );
   ALU_OUT <= ( ALU_OUT_31_port, ALU_OUT_30_port, ALU_OUT_29_port, 
      ALU_OUT_28_port, ALU_OUT_27_port, ALU_OUT_26_port, ALU_OUT_25_port, 
      ALU_OUT_24_port, ALU_OUT_23_port, ALU_OUT_22_port, ALU_OUT_21_port, 
      ALU_OUT_20_port, ALU_OUT_19_port, ALU_OUT_18_port, ALU_OUT_17_port, 
      ALU_OUT_16_port, ALU_OUT_15_port, ALU_OUT_14_port, ALU_OUT_13_port, 
      ALU_OUT_12_port, ALU_OUT_11_port, ALU_OUT_10_port, ALU_OUT_9_port, 
      ALU_OUT_8_port, ALU_OUT_7_port, ALU_OUT_6_port, ALU_OUT_5_port, 
      ALU_OUT_4_port, ALU_OUT_3_port, ALU_OUT_2_port, ALU_OUT_1_port, 
      ALU_OUT_0_port );
   
   X_Logic1_port <= '1';
   IF_ID_IR_reg_27_inst : DFF_X1 port map( D => N63, CK => n196_port, Q => 
                           IF_ID_IR_27_port, QN => n_1257);
   IF_ID_IR_reg_26_inst : DFF_X1 port map( D => N62, CK => n196_port, Q => 
                           IF_ID_IR_26_port, QN => n_1258);
   IF_ID_IR_reg_25_inst : DFF_X1 port map( D => N61, CK => n196_port, Q => 
                           IF_ID_IR_25_port, QN => n_1259);
   IF_ID_IR_reg_24_inst : DFF_X1 port map( D => N60, CK => n196_port, Q => 
                           IF_ID_IR_24_port, QN => n_1260);
   IF_ID_IR_reg_23_inst : DFF_X1 port map( D => N59, CK => n196_port, Q => 
                           IF_ID_IR_23_port, QN => n_1261);
   IF_ID_IR_reg_22_inst : DFF_X1 port map( D => N58, CK => n196_port, Q => 
                           IF_ID_IR_22_port, QN => n_1262);
   IF_ID_IR_reg_21_inst : DFF_X1 port map( D => N57, CK => n196_port, Q => 
                           IF_ID_IR_21_port, QN => n_1263);
   IF_ID_IR_reg_20_inst : DFF_X1 port map( D => N56, CK => n196_port, Q => 
                           IF_ID_IR_20_port, QN => n_1264);
   IF_ID_IR_reg_19_inst : DFF_X1 port map( D => N55, CK => n196_port, Q => 
                           IF_ID_IR_19_port, QN => n_1265);
   IF_ID_IR_reg_18_inst : DFF_X1 port map( D => N54, CK => n196_port, Q => 
                           IF_ID_IR_18_port, QN => n_1266);
   IF_ID_IR_reg_17_inst : DFF_X1 port map( D => N53, CK => n196_port, Q => 
                           IF_ID_IR_17_port, QN => n_1267);
   IF_ID_IR_reg_16_inst : DFF_X1 port map( D => N52, CK => n196_port, Q => 
                           IF_ID_IR_16_port, QN => n_1268);
   IF_ID_IR_reg_15_inst : DFF_X1 port map( D => N51, CK => n196_port, Q => 
                           IF_ID_IR_15_port, QN => n_1269);
   IF_ID_IR_reg_14_inst : DFF_X1 port map( D => N50, CK => n196_port, Q => 
                           IF_ID_IR_14_port, QN => n_1270);
   IF_ID_IR_reg_13_inst : DFF_X1 port map( D => N49, CK => n196_port, Q => 
                           IF_ID_IR_13_port, QN => n_1271);
   IF_ID_IR_reg_12_inst : DFF_X1 port map( D => N48, CK => n196_port, Q => 
                           IF_ID_IR_12_port, QN => n_1272);
   IF_ID_IR_reg_11_inst : DFF_X1 port map( D => N47, CK => n196_port, Q => 
                           IF_ID_IR_11_port, QN => n_1273);
   IF_ID_IR_reg_10_inst : DFF_X1 port map( D => N46, CK => n195_port, Q => 
                           IF_ID_IR_10_port, QN => n_1274);
   IF_ID_IR_reg_9_inst : DFF_X1 port map( D => N45, CK => n195_port, Q => 
                           IF_ID_IR_9_port, QN => n_1275);
   IF_ID_IR_reg_8_inst : DFF_X1 port map( D => N44, CK => n195_port, Q => 
                           IF_ID_IR_8_port, QN => n_1276);
   IF_ID_IR_reg_7_inst : DFF_X1 port map( D => N43, CK => n195_port, Q => 
                           IF_ID_IR_7_port, QN => n_1277);
   IF_ID_IR_reg_6_inst : DFF_X1 port map( D => N42, CK => n195_port, Q => 
                           IF_ID_IR_6_port, QN => n_1278);
   IF_ID_IR_reg_5_inst : DFF_X1 port map( D => N41, CK => n195_port, Q => 
                           IF_ID_IR_5_port, QN => n_1279);
   IF_ID_IR_reg_4_inst : DFF_X1 port map( D => N40, CK => n195_port, Q => 
                           IF_ID_IR_4_port, QN => n_1280);
   IF_ID_IR_reg_3_inst : DFF_X1 port map( D => N39, CK => n195_port, Q => 
                           IF_ID_IR_3_port, QN => n_1281);
   IF_ID_IR_reg_2_inst : DFF_X1 port map( D => N38, CK => n195_port, Q => 
                           IF_ID_IR_2_port, QN => n_1282);
   IF_ID_IR_reg_1_inst : DFF_X1 port map( D => N37, CK => n195_port, Q => 
                           IF_ID_IR_1_port, QN => n_1283);
   IF_ID_IR_reg_0_inst : DFF_X1 port map( D => N36, CK => n195_port, Q => 
                           IF_ID_IR_0_port, QN => n_1284);
   ID_EX_RF_WE_reg : DFF_X1 port map( D => N100, CK => n197_port, Q => n_1285, 
                           QN => n117_port);
   ID_EX_RS1_reg_4_inst : DFF_X1 port map( D => N105, CK => n196_port, Q => 
                           ID_EX_RS1_4_port, QN => n_1286);
   ID_EX_RS1_reg_3_inst : DFF_X1 port map( D => N104, CK => n196_port, Q => 
                           ID_EX_RS1_3_port, QN => n_1287);
   ID_EX_RS1_reg_2_inst : DFF_X1 port map( D => N103, CK => n196_port, Q => 
                           ID_EX_RS1_2_port, QN => n_1288);
   ID_EX_RS1_reg_1_inst : DFF_X1 port map( D => N102, CK => n196_port, Q => 
                           ID_EX_RS1_1_port, QN => n_1289);
   ID_EX_IMM_reg_31_inst : DFF_X1 port map( D => N211, CK => n195_port, Q => 
                           ID_EX_IMM_31_port, QN => n_1290);
   ID_EX_IMM_reg_30_inst : DFF_X1 port map( D => N210, CK => n195_port, Q => 
                           ID_EX_IMM_30_port, QN => n_1291);
   ID_EX_IMM_reg_29_inst : DFF_X1 port map( D => N209, CK => n195_port, Q => 
                           ID_EX_IMM_29_port, QN => n_1292);
   ID_EX_IMM_reg_28_inst : DFF_X1 port map( D => N208, CK => n195_port, Q => 
                           ID_EX_IMM_28_port, QN => n_1293);
   ID_EX_IMM_reg_27_inst : DFF_X1 port map( D => N207, CK => n195_port, Q => 
                           ID_EX_IMM_27_port, QN => n_1294);
   ID_EX_IMM_reg_26_inst : DFF_X1 port map( D => N206, CK => n195_port, Q => 
                           ID_EX_IMM_26_port, QN => n_1295);
   ID_EX_IMM_reg_25_inst : DFF_X1 port map( D => N205, CK => n195_port, Q => 
                           ID_EX_IMM_25_port, QN => n_1296);
   ID_EX_IMM_reg_24_inst : DFF_X1 port map( D => N204, CK => n195_port, Q => 
                           ID_EX_IMM_24_port, QN => n_1297);
   ID_EX_IMM_reg_23_inst : DFF_X1 port map( D => N203, CK => n195_port, Q => 
                           ID_EX_IMM_23_port, QN => n_1298);
   ID_EX_IMM_reg_22_inst : DFF_X1 port map( D => N202, CK => n195_port, Q => 
                           ID_EX_IMM_22_port, QN => n_1299);
   ID_EX_IMM_reg_21_inst : DFF_X1 port map( D => N201, CK => n195_port, Q => 
                           ID_EX_IMM_21_port, QN => n_1300);
   ID_EX_IMM_reg_20_inst : DFF_X1 port map( D => N200, CK => n195_port, Q => 
                           ID_EX_IMM_20_port, QN => n_1301);
   ID_EX_IMM_reg_19_inst : DFF_X1 port map( D => N199, CK => n195_port, Q => 
                           ID_EX_IMM_19_port, QN => n_1302);
   ID_EX_IMM_reg_18_inst : DFF_X1 port map( D => N198, CK => n195_port, Q => 
                           ID_EX_IMM_18_port, QN => n_1303);
   ID_EX_IMM_reg_17_inst : DFF_X1 port map( D => N197, CK => n195_port, Q => 
                           ID_EX_IMM_17_port, QN => n_1304);
   ID_EX_IMM_reg_16_inst : DFF_X1 port map( D => N196, CK => n195_port, Q => 
                           ID_EX_IMM_16_port, QN => n_1305);
   ID_EX_IMM_reg_15_inst : DFF_X1 port map( D => N195, CK => n195_port, Q => 
                           ID_EX_IMM_15_port, QN => n_1306);
   ID_EX_IMM_reg_14_inst : DFF_X1 port map( D => N194, CK => n195_port, Q => 
                           ID_EX_IMM_14_port, QN => n_1307);
   ID_EX_IMM_reg_13_inst : DFF_X1 port map( D => N193, CK => n195_port, Q => 
                           ID_EX_IMM_13_port, QN => n_1308);
   ID_EX_IMM_reg_12_inst : DFF_X1 port map( D => N192, CK => n195_port, Q => 
                           ID_EX_IMM_12_port, QN => n_1309);
   ID_EX_IMM_reg_11_inst : DFF_X1 port map( D => N191, CK => n195_port, Q => 
                           ID_EX_IMM_11_port, QN => n_1310);
   ID_EX_IMM_reg_10_inst : DFF_X1 port map( D => N190, CK => n195_port, Q => 
                           ID_EX_IMM_10_port, QN => n_1311);
   ID_EX_IMM_reg_9_inst : DFF_X1 port map( D => N189, CK => n195_port, Q => 
                           ID_EX_IMM_9_port, QN => n_1312);
   ID_EX_IMM_reg_8_inst : DFF_X1 port map( D => N188, CK => n195_port, Q => 
                           ID_EX_IMM_8_port, QN => n_1313);
   ID_EX_IMM_reg_7_inst : DFF_X1 port map( D => N187, CK => n195_port, Q => 
                           ID_EX_IMM_7_port, QN => n_1314);
   ID_EX_IMM_reg_6_inst : DFF_X1 port map( D => N186, CK => n195_port, Q => 
                           ID_EX_IMM_6_port, QN => n_1315);
   ID_EX_IMM_reg_5_inst : DFF_X1 port map( D => N185, CK => n195_port, Q => 
                           ID_EX_IMM_5_port, QN => n_1316);
   ID_EX_IMM_reg_4_inst : DFF_X1 port map( D => N184, CK => n195_port, Q => 
                           ID_EX_IMM_4_port, QN => n_1317);
   ID_EX_IMM_reg_3_inst : DFF_X1 port map( D => N183, CK => n195_port, Q => 
                           ID_EX_IMM_3_port, QN => n_1318);
   ID_EX_IMM_reg_2_inst : DFF_X1 port map( D => N182, CK => n195_port, Q => 
                           ID_EX_IMM_2_port, QN => n_1319);
   ID_EX_IMM_reg_1_inst : DFF_X1 port map( D => N181, CK => n195_port, Q => 
                           ID_EX_IMM_1_port, QN => n_1320);
   ID_EX_IMM_reg_0_inst : DFF_X1 port map( D => N180, CK => n195_port, Q => 
                           ID_EX_IMM_0_port, QN => n_1321);
   EX_MEM_RF_WE_reg : DFF_X1 port map( D => N212, CK => n197_port, Q => 
                           EX_MEM_RF_WE, QN => n79_port);
   EX_MEM_RD_reg_4_inst : DFF_X1 port map( D => N282, CK => n196_port, Q => 
                           EX_MEM_RD_4_port, QN => n42_port);
   MEM_WB_RD_reg_4_inst : DFF_X1 port map( D => N352, CK => n196_port, Q => 
                           MEM_WB_RD_4_port, QN => n_1322);
   EX_MEM_RD_reg_3_inst : DFF_X1 port map( D => N281, CK => n196_port, Q => 
                           EX_MEM_RD_3_port, QN => n43_port);
   MEM_WB_RD_reg_3_inst : DFF_X1 port map( D => N351, CK => n196_port, Q => 
                           MEM_WB_RD_3_port, QN => n_1323);
   EX_MEM_RD_reg_2_inst : DFF_X1 port map( D => N280, CK => n196_port, Q => 
                           EX_MEM_RD_2_port, QN => n44_port);
   MEM_WB_RD_reg_2_inst : DFF_X1 port map( D => N350, CK => n196_port, Q => 
                           MEM_WB_RD_2_port, QN => n_1324);
   EX_MEM_RD_reg_1_inst : DFF_X1 port map( D => N279, CK => n196_port, Q => 
                           EX_MEM_RD_1_port, QN => n45_port);
   MEM_WB_RD_reg_1_inst : DFF_X1 port map( D => N349, CK => n196_port, Q => 
                           MEM_WB_RD_1_port, QN => n_1325);
   EX_MEM_RD_reg_0_inst : DFF_X1 port map( D => N278, CK => n196_port, Q => 
                           EX_MEM_RD_0_port, QN => n46_port);
   MEM_WB_RD_reg_0_inst : DFF_X1 port map( D => N348, CK => n196_port, Q => 
                           MEM_WB_RD_0_port, QN => n_1326);
   MEM_WB_RF_WE_reg : DFF_X1 port map( D => N283, CK => n197_port, Q => 
                           MEM_WB_RF_WE, QN => n_1327);
   MEM_WB_DRAM_OUTPUT_reg_31_inst : DFF_X1 port map( D => N347, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_31_port, QN => n_1328);
   MEM_WB_DRAM_OUTPUT_reg_30_inst : DFF_X1 port map( D => N346, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_30_port, QN => n_1329);
   MEM_WB_DRAM_OUTPUT_reg_29_inst : DFF_X1 port map( D => N345, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_29_port, QN => n_1330);
   MEM_WB_DRAM_OUTPUT_reg_28_inst : DFF_X1 port map( D => N344, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_28_port, QN => n_1331);
   MEM_WB_DRAM_OUTPUT_reg_27_inst : DFF_X1 port map( D => N343, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_27_port, QN => n_1332);
   MEM_WB_DRAM_OUTPUT_reg_26_inst : DFF_X1 port map( D => N342, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_26_port, QN => n_1333);
   MEM_WB_DRAM_OUTPUT_reg_25_inst : DFF_X1 port map( D => N341, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_25_port, QN => n_1334);
   MEM_WB_DRAM_OUTPUT_reg_24_inst : DFF_X1 port map( D => N340, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_24_port, QN => n_1335);
   MEM_WB_DRAM_OUTPUT_reg_23_inst : DFF_X1 port map( D => N339, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_23_port, QN => n_1336);
   MEM_WB_DRAM_OUTPUT_reg_22_inst : DFF_X1 port map( D => N338, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_22_port, QN => n_1337);
   MEM_WB_DRAM_OUTPUT_reg_21_inst : DFF_X1 port map( D => N337, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_21_port, QN => n_1338);
   MEM_WB_DRAM_OUTPUT_reg_20_inst : DFF_X1 port map( D => N336, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_20_port, QN => n_1339);
   MEM_WB_DRAM_OUTPUT_reg_19_inst : DFF_X1 port map( D => N335, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_19_port, QN => n_1340);
   MEM_WB_DRAM_OUTPUT_reg_18_inst : DFF_X1 port map( D => N334, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_18_port, QN => n_1341);
   MEM_WB_DRAM_OUTPUT_reg_17_inst : DFF_X1 port map( D => N333, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_17_port, QN => n_1342);
   MEM_WB_DRAM_OUTPUT_reg_16_inst : DFF_X1 port map( D => N332, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_16_port, QN => n_1343);
   MEM_WB_DRAM_OUTPUT_reg_15_inst : DFF_X1 port map( D => N331, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_15_port, QN => n_1344);
   MEM_WB_DRAM_OUTPUT_reg_14_inst : DFF_X1 port map( D => N330, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_14_port, QN => n_1345);
   MEM_WB_DRAM_OUTPUT_reg_13_inst : DFF_X1 port map( D => N329, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_13_port, QN => n_1346);
   MEM_WB_DRAM_OUTPUT_reg_12_inst : DFF_X1 port map( D => N328, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_12_port, QN => n_1347);
   MEM_WB_DRAM_OUTPUT_reg_11_inst : DFF_X1 port map( D => N327, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_11_port, QN => n_1348);
   MEM_WB_DRAM_OUTPUT_reg_10_inst : DFF_X1 port map( D => N326, CK => n196_port
                           , Q => MEM_WB_DRAM_OUTPUT_10_port, QN => n_1349);
   MEM_WB_DRAM_OUTPUT_reg_9_inst : DFF_X1 port map( D => N325, CK => n196_port,
                           Q => MEM_WB_DRAM_OUTPUT_9_port, QN => n_1350);
   MEM_WB_DRAM_OUTPUT_reg_8_inst : DFF_X1 port map( D => N324, CK => n196_port,
                           Q => MEM_WB_DRAM_OUTPUT_8_port, QN => n_1351);
   MEM_WB_DRAM_OUTPUT_reg_7_inst : DFF_X1 port map( D => N323, CK => n196_port,
                           Q => MEM_WB_DRAM_OUTPUT_7_port, QN => n_1352);
   MEM_WB_DRAM_OUTPUT_reg_6_inst : DFF_X1 port map( D => N322, CK => n196_port,
                           Q => MEM_WB_DRAM_OUTPUT_6_port, QN => n_1353);
   MEM_WB_DRAM_OUTPUT_reg_5_inst : DFF_X1 port map( D => N321, CK => n195_port,
                           Q => MEM_WB_DRAM_OUTPUT_5_port, QN => n_1354);
   MEM_WB_DRAM_OUTPUT_reg_4_inst : DFF_X1 port map( D => N320, CK => n195_port,
                           Q => MEM_WB_DRAM_OUTPUT_4_port, QN => n_1355);
   MEM_WB_DRAM_OUTPUT_reg_3_inst : DFF_X1 port map( D => N319, CK => n195_port,
                           Q => MEM_WB_DRAM_OUTPUT_3_port, QN => n_1356);
   MEM_WB_DRAM_OUTPUT_reg_2_inst : DFF_X1 port map( D => N318, CK => n195_port,
                           Q => MEM_WB_DRAM_OUTPUT_2_port, QN => n_1357);
   MEM_WB_DRAM_OUTPUT_reg_1_inst : DFF_X1 port map( D => N317, CK => n195_port,
                           Q => MEM_WB_DRAM_OUTPUT_1_port, QN => n_1358);
   MEM_WB_DRAM_OUTPUT_reg_0_inst : DFF_X1 port map( D => N316, CK => n195_port,
                           Q => MEM_WB_DRAM_OUTPUT_0_port, QN => n_1359);
   ID_EX_RF_OUT2_reg_0_inst : DFF_X1 port map( D => N148, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_0_port, QN => n116_port);
   EX_MEM_RF_OUT2_reg_0_inst : DFF_X1 port map( D => N213, CK => n196_port, Q 
                           => DRAM_IN(0), QN => n_1360);
   ID_EX_RF_OUT2_reg_1_inst : DFF_X1 port map( D => N149, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_1_port, QN => n115_port);
   EX_MEM_RF_OUT2_reg_1_inst : DFF_X1 port map( D => N214, CK => n196_port, Q 
                           => DRAM_IN(1), QN => n_1361);
   ID_EX_RF_OUT2_reg_2_inst : DFF_X1 port map( D => N150, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_2_port, QN => n114_port);
   EX_MEM_RF_OUT2_reg_2_inst : DFF_X1 port map( D => N215, CK => n196_port, Q 
                           => DRAM_IN(2), QN => n_1362);
   ID_EX_RF_OUT2_reg_3_inst : DFF_X1 port map( D => N151, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_3_port, QN => n113_port);
   EX_MEM_RF_OUT2_reg_3_inst : DFF_X1 port map( D => N216, CK => n196_port, Q 
                           => DRAM_IN(3), QN => n_1363);
   ID_EX_RF_OUT2_reg_4_inst : DFF_X1 port map( D => N152, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_4_port, QN => n112_port);
   EX_MEM_RF_OUT2_reg_4_inst : DFF_X1 port map( D => N217, CK => n196_port, Q 
                           => DRAM_IN(4), QN => n_1364);
   ID_EX_RF_OUT2_reg_5_inst : DFF_X1 port map( D => N153, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_5_port, QN => n111_port);
   EX_MEM_RF_OUT2_reg_5_inst : DFF_X1 port map( D => N218, CK => n196_port, Q 
                           => DRAM_IN(5), QN => n_1365);
   ID_EX_RF_OUT2_reg_6_inst : DFF_X1 port map( D => N154, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_6_port, QN => n110_port);
   EX_MEM_RF_OUT2_reg_6_inst : DFF_X1 port map( D => N219, CK => n196_port, Q 
                           => DRAM_IN(6), QN => n_1366);
   ID_EX_RF_OUT2_reg_7_inst : DFF_X1 port map( D => N155, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_7_port, QN => n109_port);
   EX_MEM_RF_OUT2_reg_7_inst : DFF_X1 port map( D => N220, CK => n196_port, Q 
                           => DRAM_IN(7), QN => n_1367);
   ID_EX_RF_OUT2_reg_8_inst : DFF_X1 port map( D => N156, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_8_port, QN => n108_port);
   EX_MEM_RF_OUT2_reg_8_inst : DFF_X1 port map( D => N221, CK => n196_port, Q 
                           => DRAM_IN(8), QN => n_1368);
   ID_EX_RF_OUT2_reg_9_inst : DFF_X1 port map( D => N157, CK => n196_port, Q =>
                           ID_EX_RF_OUT2_9_port, QN => n107_port);
   EX_MEM_RF_OUT2_reg_9_inst : DFF_X1 port map( D => N222, CK => n196_port, Q 
                           => DRAM_IN(9), QN => n_1369);
   ID_EX_RF_OUT2_reg_10_inst : DFF_X1 port map( D => N158, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_10_port, QN => n106_port);
   EX_MEM_RF_OUT2_reg_10_inst : DFF_X1 port map( D => N223, CK => n196_port, Q 
                           => DRAM_IN(10), QN => n_1370);
   ID_EX_RF_OUT2_reg_11_inst : DFF_X1 port map( D => N159, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_11_port, QN => n105_port);
   EX_MEM_RF_OUT2_reg_11_inst : DFF_X1 port map( D => N224, CK => n196_port, Q 
                           => DRAM_IN(11), QN => n_1371);
   ID_EX_RF_OUT2_reg_12_inst : DFF_X1 port map( D => N160, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_12_port, QN => n104_port);
   EX_MEM_RF_OUT2_reg_12_inst : DFF_X1 port map( D => N225, CK => n196_port, Q 
                           => DRAM_IN(12), QN => n_1372);
   ID_EX_RF_OUT2_reg_13_inst : DFF_X1 port map( D => N161, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_13_port, QN => n103_port);
   EX_MEM_RF_OUT2_reg_13_inst : DFF_X1 port map( D => N226, CK => n196_port, Q 
                           => DRAM_IN(13), QN => n_1373);
   ID_EX_RF_OUT2_reg_14_inst : DFF_X1 port map( D => N162, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_14_port, QN => n102_port);
   EX_MEM_RF_OUT2_reg_14_inst : DFF_X1 port map( D => N227, CK => n196_port, Q 
                           => DRAM_IN(14), QN => n_1374);
   ID_EX_RF_OUT2_reg_15_inst : DFF_X1 port map( D => N163, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_15_port, QN => n101_port);
   EX_MEM_RF_OUT2_reg_15_inst : DFF_X1 port map( D => N228, CK => n196_port, Q 
                           => DRAM_IN(15), QN => n_1375);
   ID_EX_RF_OUT2_reg_16_inst : DFF_X1 port map( D => N164, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_16_port, QN => n100_port);
   EX_MEM_RF_OUT2_reg_16_inst : DFF_X1 port map( D => N229, CK => n196_port, Q 
                           => DRAM_IN(16), QN => n_1376);
   ID_EX_RF_OUT2_reg_17_inst : DFF_X1 port map( D => N165, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_17_port, QN => n99_port);
   EX_MEM_RF_OUT2_reg_17_inst : DFF_X1 port map( D => N230, CK => n196_port, Q 
                           => DRAM_IN(17), QN => n_1377);
   ID_EX_RF_OUT2_reg_18_inst : DFF_X1 port map( D => N166, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_18_port, QN => n98_port);
   EX_MEM_RF_OUT2_reg_18_inst : DFF_X1 port map( D => N231, CK => n196_port, Q 
                           => DRAM_IN(18), QN => n_1378);
   ID_EX_RF_OUT2_reg_19_inst : DFF_X1 port map( D => N167, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_19_port, QN => n97_port);
   EX_MEM_RF_OUT2_reg_19_inst : DFF_X1 port map( D => N232, CK => n196_port, Q 
                           => DRAM_IN(19), QN => n_1379);
   ID_EX_RF_OUT2_reg_20_inst : DFF_X1 port map( D => N168, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_20_port, QN => n96_port);
   EX_MEM_RF_OUT2_reg_20_inst : DFF_X1 port map( D => N233, CK => n196_port, Q 
                           => DRAM_IN(20), QN => n_1380);
   ID_EX_RF_OUT2_reg_21_inst : DFF_X1 port map( D => N169, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_21_port, QN => n95_port);
   EX_MEM_RF_OUT2_reg_21_inst : DFF_X1 port map( D => N234, CK => n196_port, Q 
                           => DRAM_IN(21), QN => n_1381);
   ID_EX_RF_OUT2_reg_22_inst : DFF_X1 port map( D => N170, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_22_port, QN => n94_port);
   EX_MEM_RF_OUT2_reg_22_inst : DFF_X1 port map( D => N235, CK => n196_port, Q 
                           => DRAM_IN(22), QN => n_1382);
   ID_EX_RF_OUT2_reg_23_inst : DFF_X1 port map( D => N171, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_23_port, QN => n93_port);
   EX_MEM_RF_OUT2_reg_23_inst : DFF_X1 port map( D => N236, CK => n196_port, Q 
                           => DRAM_IN(23), QN => n_1383);
   ID_EX_RF_OUT2_reg_24_inst : DFF_X1 port map( D => N172, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_24_port, QN => n92_port);
   EX_MEM_RF_OUT2_reg_24_inst : DFF_X1 port map( D => N237, CK => n196_port, Q 
                           => DRAM_IN(24), QN => n_1384);
   ID_EX_RF_OUT2_reg_25_inst : DFF_X1 port map( D => N173, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_25_port, QN => n91_port);
   EX_MEM_RF_OUT2_reg_25_inst : DFF_X1 port map( D => N238, CK => n196_port, Q 
                           => DRAM_IN(25), QN => n_1385);
   ID_EX_RF_OUT2_reg_26_inst : DFF_X1 port map( D => N174, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_26_port, QN => n90_port);
   EX_MEM_RF_OUT2_reg_26_inst : DFF_X1 port map( D => N239, CK => n196_port, Q 
                           => DRAM_IN(26), QN => n_1386);
   ID_EX_RF_OUT2_reg_27_inst : DFF_X1 port map( D => N175, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_27_port, QN => n89_port);
   EX_MEM_RF_OUT2_reg_27_inst : DFF_X1 port map( D => N240, CK => n196_port, Q 
                           => DRAM_IN(27), QN => n_1387);
   ID_EX_RF_OUT2_reg_28_inst : DFF_X1 port map( D => N176, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_28_port, QN => n88_port);
   EX_MEM_RF_OUT2_reg_28_inst : DFF_X1 port map( D => N241, CK => n196_port, Q 
                           => DRAM_IN(28), QN => n_1388);
   ID_EX_RF_OUT2_reg_29_inst : DFF_X1 port map( D => N177, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_29_port, QN => n87_port);
   EX_MEM_RF_OUT2_reg_29_inst : DFF_X1 port map( D => N242, CK => n196_port, Q 
                           => DRAM_IN(29), QN => n_1389);
   ID_EX_RF_OUT2_reg_30_inst : DFF_X1 port map( D => N178, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_30_port, QN => n86_port);
   EX_MEM_RF_OUT2_reg_30_inst : DFF_X1 port map( D => N243, CK => n196_port, Q 
                           => DRAM_IN(30), QN => n_1390);
   ID_EX_RF_OUT2_reg_31_inst : DFF_X1 port map( D => N179, CK => n196_port, Q 
                           => ID_EX_RF_OUT2_31_port, QN => n85_port);
   EX_MEM_RF_OUT2_reg_31_inst : DFF_X1 port map( D => N244, CK => n196_port, Q 
                           => DRAM_IN(31), QN => n_1391);
   ID_EX_RF_OUT1_reg_0_inst : DFF_X1 port map( D => N116, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_0_port, QN => n_1392);
   ID_EX_RF_OUT1_reg_1_inst : DFF_X1 port map( D => N117, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_1_port, QN => n_1393);
   ID_EX_RF_OUT1_reg_2_inst : DFF_X1 port map( D => N118, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_2_port, QN => n_1394);
   ID_EX_RF_OUT1_reg_3_inst : DFF_X1 port map( D => N119, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_3_port, QN => n_1395);
   ID_EX_RF_OUT1_reg_4_inst : DFF_X1 port map( D => N120, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_4_port, QN => n_1396);
   ID_EX_RF_OUT1_reg_5_inst : DFF_X1 port map( D => N121, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_5_port, QN => n_1397);
   ID_EX_RF_OUT1_reg_6_inst : DFF_X1 port map( D => N122, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_6_port, QN => n_1398);
   ID_EX_RF_OUT1_reg_7_inst : DFF_X1 port map( D => N123, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_7_port, QN => n_1399);
   ID_EX_RF_OUT1_reg_8_inst : DFF_X1 port map( D => N124, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_8_port, QN => n_1400);
   ID_EX_RF_OUT1_reg_9_inst : DFF_X1 port map( D => N125, CK => n195_port, Q =>
                           ID_EX_RF_OUT1_9_port, QN => n_1401);
   ID_EX_RF_OUT1_reg_10_inst : DFF_X1 port map( D => N126, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_10_port, QN => n_1402);
   ID_EX_RF_OUT1_reg_11_inst : DFF_X1 port map( D => N127, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_11_port, QN => n_1403);
   ID_EX_RF_OUT1_reg_12_inst : DFF_X1 port map( D => N128, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_12_port, QN => n_1404);
   ID_EX_RF_OUT1_reg_13_inst : DFF_X1 port map( D => N129, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_13_port, QN => n_1405);
   ID_EX_RF_OUT1_reg_14_inst : DFF_X1 port map( D => N130, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_14_port, QN => n_1406);
   ID_EX_RF_OUT1_reg_15_inst : DFF_X1 port map( D => N131, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_15_port, QN => n_1407);
   ID_EX_RF_OUT1_reg_16_inst : DFF_X1 port map( D => N132, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_16_port, QN => n_1408);
   ID_EX_RF_OUT1_reg_17_inst : DFF_X1 port map( D => N133, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_17_port, QN => n_1409);
   ID_EX_RF_OUT1_reg_18_inst : DFF_X1 port map( D => N134, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_18_port, QN => n_1410);
   ID_EX_RF_OUT1_reg_19_inst : DFF_X1 port map( D => N135, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_19_port, QN => n_1411);
   ID_EX_RF_OUT1_reg_20_inst : DFF_X1 port map( D => N136, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_20_port, QN => n_1412);
   ID_EX_RF_OUT1_reg_21_inst : DFF_X1 port map( D => N137, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_21_port, QN => n_1413);
   ID_EX_RF_OUT1_reg_22_inst : DFF_X1 port map( D => N138, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_22_port, QN => n_1414);
   ID_EX_RF_OUT1_reg_23_inst : DFF_X1 port map( D => N139, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_23_port, QN => n_1415);
   ID_EX_RF_OUT1_reg_24_inst : DFF_X1 port map( D => N140, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_24_port, QN => n_1416);
   ID_EX_RF_OUT1_reg_25_inst : DFF_X1 port map( D => N141, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_25_port, QN => n_1417);
   ID_EX_RF_OUT1_reg_26_inst : DFF_X1 port map( D => N142, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_26_port, QN => n_1418);
   ID_EX_RF_OUT1_reg_27_inst : DFF_X1 port map( D => N143, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_27_port, QN => n_1419);
   ID_EX_RF_OUT1_reg_28_inst : DFF_X1 port map( D => N144, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_28_port, QN => n_1420);
   ID_EX_RF_OUT1_reg_29_inst : DFF_X1 port map( D => N145, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_29_port, QN => n_1421);
   ID_EX_RF_OUT1_reg_30_inst : DFF_X1 port map( D => N146, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_30_port, QN => n_1422);
   ID_EX_RF_OUT1_reg_31_inst : DFF_X1 port map( D => N147, CK => n195_port, Q 
                           => ID_EX_RF_OUT1_31_port, QN => n_1423);
   EX_MEM_BRANCH_DETECT_reg : DFF_X1 port map( D => N277, CK => n196_port, Q =>
                           EX_MEM_BRANCH_DETECT, QN => n_1424);
   EX_MEM_ALU_OUTPUT_reg_0_inst : DFF_X1 port map( D => N245, CK => n196_port, 
                           Q => ALU_OUT_0_port, QN => n78_port);
   MEM_WB_ALU_OUTPUT_reg_0_inst : DFF_X1 port map( D => N284, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_0_port, QN => n_1425);
   EX_MEM_ALU_OUTPUT_reg_1_inst : DFF_X1 port map( D => N246, CK => n196_port, 
                           Q => ALU_OUT_1_port, QN => n77_port);
   MEM_WB_ALU_OUTPUT_reg_1_inst : DFF_X1 port map( D => N285, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_1_port, QN => n_1426);
   EX_MEM_ALU_OUTPUT_reg_2_inst : DFF_X1 port map( D => N247, CK => n196_port, 
                           Q => ALU_OUT_2_port, QN => n76_port);
   MEM_WB_ALU_OUTPUT_reg_2_inst : DFF_X1 port map( D => N286, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_2_port, QN => n_1427);
   EX_MEM_ALU_OUTPUT_reg_3_inst : DFF_X1 port map( D => N248, CK => n196_port, 
                           Q => ALU_OUT_3_port, QN => n75_port);
   MEM_WB_ALU_OUTPUT_reg_3_inst : DFF_X1 port map( D => N287, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_3_port, QN => n_1428);
   EX_MEM_ALU_OUTPUT_reg_4_inst : DFF_X1 port map( D => N249, CK => n196_port, 
                           Q => ALU_OUT_4_port, QN => n74_port);
   MEM_WB_ALU_OUTPUT_reg_4_inst : DFF_X1 port map( D => N288, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_4_port, QN => n_1429);
   EX_MEM_ALU_OUTPUT_reg_5_inst : DFF_X1 port map( D => N250, CK => n196_port, 
                           Q => ALU_OUT_5_port, QN => n73_port);
   MEM_WB_ALU_OUTPUT_reg_5_inst : DFF_X1 port map( D => N289, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_5_port, QN => n_1430);
   EX_MEM_ALU_OUTPUT_reg_6_inst : DFF_X1 port map( D => N251, CK => n196_port, 
                           Q => ALU_OUT_6_port, QN => n72_port);
   MEM_WB_ALU_OUTPUT_reg_6_inst : DFF_X1 port map( D => N290, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_6_port, QN => n_1431);
   EX_MEM_ALU_OUTPUT_reg_7_inst : DFF_X1 port map( D => N252, CK => n196_port, 
                           Q => ALU_OUT_7_port, QN => n71_port);
   MEM_WB_ALU_OUTPUT_reg_7_inst : DFF_X1 port map( D => N291, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_7_port, QN => n_1432);
   EX_MEM_ALU_OUTPUT_reg_8_inst : DFF_X1 port map( D => N253, CK => n196_port, 
                           Q => ALU_OUT_8_port, QN => n70_port);
   MEM_WB_ALU_OUTPUT_reg_8_inst : DFF_X1 port map( D => N292, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_8_port, QN => n_1433);
   EX_MEM_ALU_OUTPUT_reg_9_inst : DFF_X1 port map( D => N254, CK => n196_port, 
                           Q => ALU_OUT_9_port, QN => n69_port);
   MEM_WB_ALU_OUTPUT_reg_9_inst : DFF_X1 port map( D => N293, CK => n196_port, 
                           Q => MEM_WB_ALU_OUTPUT_9_port, QN => n_1434);
   EX_MEM_ALU_OUTPUT_reg_10_inst : DFF_X1 port map( D => N255, CK => n197_port,
                           Q => ALU_OUT_10_port, QN => n68_port);
   MEM_WB_ALU_OUTPUT_reg_10_inst : DFF_X1 port map( D => N294, CK => n196_port,
                           Q => MEM_WB_ALU_OUTPUT_10_port, QN => n_1435);
   EX_MEM_ALU_OUTPUT_reg_11_inst : DFF_X1 port map( D => N256, CK => n197_port,
                           Q => ALU_OUT_11_port, QN => n67_port);
   MEM_WB_ALU_OUTPUT_reg_11_inst : DFF_X1 port map( D => N295, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_11_port, QN => n_1436);
   EX_MEM_ALU_OUTPUT_reg_12_inst : DFF_X1 port map( D => N257, CK => n197_port,
                           Q => ALU_OUT_12_port, QN => n66_port);
   MEM_WB_ALU_OUTPUT_reg_12_inst : DFF_X1 port map( D => N296, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_12_port, QN => n_1437);
   EX_MEM_ALU_OUTPUT_reg_13_inst : DFF_X1 port map( D => N258, CK => n197_port,
                           Q => ALU_OUT_13_port, QN => n65_port);
   MEM_WB_ALU_OUTPUT_reg_13_inst : DFF_X1 port map( D => N297, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_13_port, QN => n_1438);
   EX_MEM_ALU_OUTPUT_reg_14_inst : DFF_X1 port map( D => N259, CK => n197_port,
                           Q => ALU_OUT_14_port, QN => n64_port);
   MEM_WB_ALU_OUTPUT_reg_14_inst : DFF_X1 port map( D => N298, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_14_port, QN => n_1439);
   EX_MEM_ALU_OUTPUT_reg_15_inst : DFF_X1 port map( D => N260, CK => n197_port,
                           Q => ALU_OUT_15_port, QN => n63_port);
   MEM_WB_ALU_OUTPUT_reg_15_inst : DFF_X1 port map( D => N299, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_15_port, QN => n_1440);
   EX_MEM_ALU_OUTPUT_reg_16_inst : DFF_X1 port map( D => N261, CK => n197_port,
                           Q => ALU_OUT_16_port, QN => n62_port);
   MEM_WB_ALU_OUTPUT_reg_16_inst : DFF_X1 port map( D => N300, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_16_port, QN => n_1441);
   EX_MEM_ALU_OUTPUT_reg_17_inst : DFF_X1 port map( D => N262, CK => n197_port,
                           Q => ALU_OUT_17_port, QN => n61_port);
   MEM_WB_ALU_OUTPUT_reg_17_inst : DFF_X1 port map( D => N301, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_17_port, QN => n_1442);
   EX_MEM_ALU_OUTPUT_reg_18_inst : DFF_X1 port map( D => N263, CK => n197_port,
                           Q => ALU_OUT_18_port, QN => n60_port);
   MEM_WB_ALU_OUTPUT_reg_18_inst : DFF_X1 port map( D => N302, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_18_port, QN => n_1443);
   EX_MEM_ALU_OUTPUT_reg_19_inst : DFF_X1 port map( D => N264, CK => n197_port,
                           Q => ALU_OUT_19_port, QN => n59_port);
   MEM_WB_ALU_OUTPUT_reg_19_inst : DFF_X1 port map( D => N303, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_19_port, QN => n_1444);
   EX_MEM_ALU_OUTPUT_reg_20_inst : DFF_X1 port map( D => N265, CK => n197_port,
                           Q => ALU_OUT_20_port, QN => n58_port);
   MEM_WB_ALU_OUTPUT_reg_20_inst : DFF_X1 port map( D => N304, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_20_port, QN => n_1445);
   EX_MEM_ALU_OUTPUT_reg_21_inst : DFF_X1 port map( D => N266, CK => n197_port,
                           Q => ALU_OUT_21_port, QN => n57_port);
   MEM_WB_ALU_OUTPUT_reg_21_inst : DFF_X1 port map( D => N305, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_21_port, QN => n_1446);
   EX_MEM_ALU_OUTPUT_reg_22_inst : DFF_X1 port map( D => N267, CK => n197_port,
                           Q => ALU_OUT_22_port, QN => n56_port);
   MEM_WB_ALU_OUTPUT_reg_22_inst : DFF_X1 port map( D => N306, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_22_port, QN => n_1447);
   EX_MEM_ALU_OUTPUT_reg_23_inst : DFF_X1 port map( D => N268, CK => n197_port,
                           Q => ALU_OUT_23_port, QN => n55_port);
   MEM_WB_ALU_OUTPUT_reg_23_inst : DFF_X1 port map( D => N307, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_23_port, QN => n_1448);
   EX_MEM_ALU_OUTPUT_reg_24_inst : DFF_X1 port map( D => N269, CK => n197_port,
                           Q => ALU_OUT_24_port, QN => n54_port);
   MEM_WB_ALU_OUTPUT_reg_24_inst : DFF_X1 port map( D => N308, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_24_port, QN => n_1449);
   EX_MEM_ALU_OUTPUT_reg_25_inst : DFF_X1 port map( D => N270, CK => n197_port,
                           Q => ALU_OUT_25_port, QN => n53_port);
   MEM_WB_ALU_OUTPUT_reg_25_inst : DFF_X1 port map( D => N309, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_25_port, QN => n_1450);
   EX_MEM_ALU_OUTPUT_reg_26_inst : DFF_X1 port map( D => N271, CK => n197_port,
                           Q => ALU_OUT_26_port, QN => n52_port);
   MEM_WB_ALU_OUTPUT_reg_26_inst : DFF_X1 port map( D => N310, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_26_port, QN => n_1451);
   EX_MEM_ALU_OUTPUT_reg_27_inst : DFF_X1 port map( D => N272, CK => n197_port,
                           Q => ALU_OUT_27_port, QN => n51_port);
   MEM_WB_ALU_OUTPUT_reg_27_inst : DFF_X1 port map( D => N311, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_27_port, QN => n_1452);
   EX_MEM_ALU_OUTPUT_reg_28_inst : DFF_X1 port map( D => N273, CK => n197_port,
                           Q => ALU_OUT_28_port, QN => n50_port);
   MEM_WB_ALU_OUTPUT_reg_28_inst : DFF_X1 port map( D => N312, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_28_port, QN => n_1453);
   EX_MEM_ALU_OUTPUT_reg_29_inst : DFF_X1 port map( D => N274, CK => n197_port,
                           Q => ALU_OUT_29_port, QN => n49_port);
   MEM_WB_ALU_OUTPUT_reg_29_inst : DFF_X1 port map( D => N313, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_29_port, QN => n_1454);
   EX_MEM_ALU_OUTPUT_reg_30_inst : DFF_X1 port map( D => N275, CK => n197_port,
                           Q => ALU_OUT_30_port, QN => n48_port);
   MEM_WB_ALU_OUTPUT_reg_30_inst : DFF_X1 port map( D => N314, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_30_port, QN => n_1455);
   EX_MEM_ALU_OUTPUT_reg_31_inst : DFF_X1 port map( D => N276, CK => n197_port,
                           Q => ALU_OUT_31_port, QN => n47_port);
   IF_ID_NPC_reg_0_inst : DFF_X1 port map( D => N4, CK => n195_port, Q => 
                           n_1456, QN => n41_port);
   ID_EX_NPC_reg_0_inst : DFF_X1 port map( D => N68, CK => n195_port, Q => 
                           ID_EX_NPC_0_port, QN => n_1457);
   IF_ID_NPC_reg_1_inst : DFF_X1 port map( D => N5, CK => n195_port, Q => 
                           n_1458, QN => n40_port);
   ID_EX_NPC_reg_1_inst : DFF_X1 port map( D => N69, CK => n195_port, Q => 
                           ID_EX_NPC_1_port, QN => n_1459);
   IF_ID_NPC_reg_2_inst : DFF_X1 port map( D => N6, CK => n195_port, Q => 
                           n_1460, QN => n39_port);
   ID_EX_NPC_reg_2_inst : DFF_X1 port map( D => N70, CK => n195_port, Q => 
                           ID_EX_NPC_2_port, QN => n_1461);
   IF_ID_NPC_reg_3_inst : DFF_X1 port map( D => N7, CK => n195_port, Q => 
                           n_1462, QN => n38_port);
   ID_EX_NPC_reg_3_inst : DFF_X1 port map( D => N71, CK => n195_port, Q => 
                           ID_EX_NPC_3_port, QN => n_1463);
   IF_ID_NPC_reg_4_inst : DFF_X1 port map( D => N8, CK => n195_port, Q => 
                           n_1464, QN => n37_port);
   ID_EX_NPC_reg_4_inst : DFF_X1 port map( D => N72, CK => n195_port, Q => 
                           ID_EX_NPC_4_port, QN => n_1465);
   IF_ID_NPC_reg_5_inst : DFF_X1 port map( D => N9, CK => n195_port, Q => 
                           n_1466, QN => n36_port);
   ID_EX_NPC_reg_5_inst : DFF_X1 port map( D => N73, CK => n195_port, Q => 
                           ID_EX_NPC_5_port, QN => n_1467);
   IF_ID_NPC_reg_6_inst : DFF_X1 port map( D => N10, CK => n195_port, Q => 
                           n_1468, QN => n35_port);
   ID_EX_NPC_reg_6_inst : DFF_X1 port map( D => N74, CK => n195_port, Q => 
                           ID_EX_NPC_6_port, QN => n_1469);
   IF_ID_NPC_reg_7_inst : DFF_X1 port map( D => N11, CK => n195_port, Q => 
                           n_1470, QN => n34_port);
   ID_EX_NPC_reg_7_inst : DFF_X1 port map( D => N75, CK => n195_port, Q => 
                           ID_EX_NPC_7_port, QN => n_1471);
   IF_ID_NPC_reg_8_inst : DFF_X1 port map( D => N12, CK => n195_port, Q => 
                           n_1472, QN => n33_port);
   ID_EX_NPC_reg_8_inst : DFF_X1 port map( D => N76, CK => n195_port, Q => 
                           ID_EX_NPC_8_port, QN => n_1473);
   IF_ID_NPC_reg_9_inst : DFF_X1 port map( D => N13, CK => n195_port, Q => 
                           n_1474, QN => n32_port);
   ID_EX_NPC_reg_9_inst : DFF_X1 port map( D => N77, CK => n195_port, Q => 
                           ID_EX_NPC_9_port, QN => n_1475);
   IF_ID_NPC_reg_10_inst : DFF_X1 port map( D => N14, CK => n195_port, Q => 
                           n_1476, QN => n31_port);
   ID_EX_NPC_reg_10_inst : DFF_X1 port map( D => N78, CK => n195_port, Q => 
                           ID_EX_NPC_10_port, QN => n_1477);
   IF_ID_NPC_reg_11_inst : DFF_X1 port map( D => N15, CK => n195_port, Q => 
                           n_1478, QN => n30_port);
   ID_EX_NPC_reg_11_inst : DFF_X1 port map( D => N79, CK => n195_port, Q => 
                           ID_EX_NPC_11_port, QN => n_1479);
   IF_ID_NPC_reg_12_inst : DFF_X1 port map( D => N16, CK => n195_port, Q => 
                           n_1480, QN => n29_port);
   ID_EX_NPC_reg_12_inst : DFF_X1 port map( D => N80, CK => n195_port, Q => 
                           ID_EX_NPC_12_port, QN => n_1481);
   IF_ID_NPC_reg_13_inst : DFF_X1 port map( D => N17, CK => n195_port, Q => 
                           n_1482, QN => n28_port);
   ID_EX_NPC_reg_13_inst : DFF_X1 port map( D => N81, CK => n195_port, Q => 
                           ID_EX_NPC_13_port, QN => n_1483);
   IF_ID_NPC_reg_14_inst : DFF_X1 port map( D => N18, CK => n195_port, Q => 
                           n_1484, QN => n27_port);
   ID_EX_NPC_reg_14_inst : DFF_X1 port map( D => N82, CK => n195_port, Q => 
                           ID_EX_NPC_14_port, QN => n_1485);
   IF_ID_NPC_reg_15_inst : DFF_X1 port map( D => N19, CK => n195_port, Q => 
                           n_1486, QN => n26_port);
   ID_EX_NPC_reg_15_inst : DFF_X1 port map( D => N83, CK => n195_port, Q => 
                           ID_EX_NPC_15_port, QN => n_1487);
   IF_ID_NPC_reg_16_inst : DFF_X1 port map( D => N20, CK => n195_port, Q => 
                           n_1488, QN => n25_port);
   ID_EX_NPC_reg_16_inst : DFF_X1 port map( D => N84, CK => n195_port, Q => 
                           ID_EX_NPC_16_port, QN => n_1489);
   IF_ID_NPC_reg_17_inst : DFF_X1 port map( D => N21, CK => n195_port, Q => 
                           n_1490, QN => n24_port);
   ID_EX_NPC_reg_17_inst : DFF_X1 port map( D => N85, CK => n195_port, Q => 
                           ID_EX_NPC_17_port, QN => n_1491);
   IF_ID_NPC_reg_18_inst : DFF_X1 port map( D => N22, CK => n195_port, Q => 
                           n_1492, QN => n23_port);
   ID_EX_NPC_reg_18_inst : DFF_X1 port map( D => N86, CK => n195_port, Q => 
                           ID_EX_NPC_18_port, QN => n_1493);
   IF_ID_NPC_reg_19_inst : DFF_X1 port map( D => N23, CK => n195_port, Q => 
                           n_1494, QN => n22_port);
   ID_EX_NPC_reg_19_inst : DFF_X1 port map( D => N87, CK => n195_port, Q => 
                           ID_EX_NPC_19_port, QN => n_1495);
   IF_ID_NPC_reg_20_inst : DFF_X1 port map( D => N24, CK => n195_port, Q => 
                           n_1496, QN => n21_port);
   ID_EX_NPC_reg_20_inst : DFF_X1 port map( D => N88, CK => n195_port, Q => 
                           ID_EX_NPC_20_port, QN => n_1497);
   IF_ID_NPC_reg_21_inst : DFF_X1 port map( D => N25, CK => n195_port, Q => 
                           n_1498, QN => n20_port);
   ID_EX_NPC_reg_21_inst : DFF_X1 port map( D => N89, CK => n195_port, Q => 
                           ID_EX_NPC_21_port, QN => n_1499);
   IF_ID_NPC_reg_22_inst : DFF_X1 port map( D => N26, CK => n195_port, Q => 
                           n_1500, QN => n19_port);
   ID_EX_NPC_reg_22_inst : DFF_X1 port map( D => N90, CK => n195_port, Q => 
                           ID_EX_NPC_22_port, QN => n_1501);
   IF_ID_NPC_reg_23_inst : DFF_X1 port map( D => N27, CK => n195_port, Q => 
                           n_1502, QN => n18_port);
   ID_EX_NPC_reg_23_inst : DFF_X1 port map( D => N91, CK => n195_port, Q => 
                           ID_EX_NPC_23_port, QN => n_1503);
   IF_ID_NPC_reg_24_inst : DFF_X1 port map( D => N28, CK => n195_port, Q => 
                           n_1504, QN => n17_port);
   ID_EX_NPC_reg_24_inst : DFF_X1 port map( D => N92, CK => n195_port, Q => 
                           ID_EX_NPC_24_port, QN => n_1505);
   IF_ID_NPC_reg_25_inst : DFF_X1 port map( D => N29, CK => n195_port, Q => 
                           n_1506, QN => n16_port);
   ID_EX_NPC_reg_25_inst : DFF_X1 port map( D => N93, CK => n195_port, Q => 
                           ID_EX_NPC_25_port, QN => n_1507);
   IF_ID_NPC_reg_26_inst : DFF_X1 port map( D => N30, CK => n195_port, Q => 
                           n_1508, QN => n15_port);
   ID_EX_NPC_reg_26_inst : DFF_X1 port map( D => N94, CK => n195_port, Q => 
                           ID_EX_NPC_26_port, QN => n_1509);
   IF_ID_NPC_reg_27_inst : DFF_X1 port map( D => N31, CK => n195_port, Q => 
                           n_1510, QN => n14_port);
   ID_EX_NPC_reg_27_inst : DFF_X1 port map( D => N95, CK => n195_port, Q => 
                           ID_EX_NPC_27_port, QN => n_1511);
   IF_ID_NPC_reg_28_inst : DFF_X1 port map( D => N32, CK => n195_port, Q => 
                           n_1512, QN => n13_port);
   ID_EX_NPC_reg_28_inst : DFF_X1 port map( D => N96, CK => n195_port, Q => 
                           ID_EX_NPC_28_port, QN => n_1513);
   IF_ID_NPC_reg_29_inst : DFF_X1 port map( D => N33, CK => n195_port, Q => 
                           n_1514, QN => n12_port);
   ID_EX_NPC_reg_29_inst : DFF_X1 port map( D => N97, CK => n195_port, Q => 
                           ID_EX_NPC_29_port, QN => n_1515);
   IF_ID_NPC_reg_30_inst : DFF_X1 port map( D => N34, CK => n195_port, Q => 
                           n_1516, QN => n11_port);
   ID_EX_NPC_reg_30_inst : DFF_X1 port map( D => N98, CK => n195_port, Q => 
                           ID_EX_NPC_30_port, QN => n_1517);
   IF_ID_NPC_reg_31_inst : DFF_X1 port map( D => N35, CK => n195_port, Q => 
                           n_1518, QN => n10_port);
   ID_EX_NPC_reg_31_inst : DFF_X1 port map( D => N99, CK => n195_port, Q => 
                           ID_EX_NPC_31_port, QN => n_1519);
   MEM_WB_ALU_OUTPUT_reg_31_inst : DFF_X1 port map( D => N315, CK => n197_port,
                           Q => MEM_WB_ALU_OUTPUT_31_port, QN => n_1520);
   ID_EX_RS1_reg_0_inst : DFF_X1 port map( D => N101, CK => n196_port, Q => 
                           ID_EX_RS1_0_port, QN => n_1521);
   IF_ID_IR_reg_30_inst : DFF_X1 port map( D => N66, CK => n196_port, Q => 
                           IF_ID_IR_30_port, QN => n_1522);
   IF_ID_IR_reg_31_inst : DFF_X1 port map( D => N67, CK => n196_port, Q => 
                           IF_ID_IR_31_port, QN => n_1523);
   IF_ID_IR_reg_28_inst : DFF_X1 port map( D => N64, CK => n196_port, Q => 
                           IF_ID_IR_28_port, QN => n_1524);
   ID_EX_RD_reg_4_inst : DFF_X1 port map( D => N115, CK => n196_port, Q => 
                           n_1525, QN => n80_port);
   ID_EX_RD_reg_3_inst : DFF_X1 port map( D => N114, CK => n196_port, Q => 
                           n_1526, QN => n81_port);
   ID_EX_RD_reg_1_inst : DFF_X1 port map( D => N112, CK => n196_port, Q => 
                           n_1527, QN => n83_port);
   ID_EX_RD_reg_0_inst : DFF_X1 port map( D => N111, CK => n196_port, Q => 
                           n_1528, QN => n84_port);
   IF_ID_IR_reg_29_inst : DFF_X1 port map( D => N65, CK => n196_port, Q => 
                           IF_ID_IR_29_port, QN => n_1529);
   ID_EX_RS2_reg_0_inst : DFF_X1 port map( D => N106, CK => n196_port, Q => 
                           ID_EX_RS2_0_port, QN => n_1530);
   ID_EX_RS2_reg_1_inst : DFF_X1 port map( D => N107, CK => n196_port, Q => 
                           ID_EX_RS2_1_port, QN => n_1531);
   ID_EX_RS2_reg_2_inst : DFF_X1 port map( D => N108, CK => n196_port, Q => 
                           ID_EX_RS2_2_port, QN => n_1532);
   ID_EX_RS2_reg_3_inst : DFF_X1 port map( D => N109, CK => n196_port, Q => 
                           ID_EX_RS2_3_port, QN => n_1533);
   ID_EX_RS2_reg_4_inst : DFF_X1 port map( D => N110, CK => n196_port, Q => 
                           ID_EX_RS2_4_port, QN => n_1534);
   ID_EX_RD_reg_2_inst : DFF_X1 port map( D => N113, CK => n196_port, Q => 
                           n_1535, QN => n82_port);
   n2 <= '0';
   n3 <= '1';
   n4_port <= '0';
   PROGRAM_COUNTER : FFDR_N32 port map( CLK => n195_port, RST => RST, EN => 
                           PC_LATCH_EN, REGIN(31) => PC_BUS_31_port, REGIN(30) 
                           => PC_BUS_30_port, REGIN(29) => PC_BUS_29_port, 
                           REGIN(28) => PC_BUS_28_port, REGIN(27) => 
                           PC_BUS_27_port, REGIN(26) => PC_BUS_26_port, 
                           REGIN(25) => PC_BUS_25_port, REGIN(24) => 
                           PC_BUS_24_port, REGIN(23) => PC_BUS_23_port, 
                           REGIN(22) => PC_BUS_22_port, REGIN(21) => 
                           PC_BUS_21_port, REGIN(20) => PC_BUS_20_port, 
                           REGIN(19) => PC_BUS_19_port, REGIN(18) => 
                           PC_BUS_18_port, REGIN(17) => PC_BUS_17_port, 
                           REGIN(16) => PC_BUS_16_port, REGIN(15) => 
                           PC_BUS_15_port, REGIN(14) => PC_BUS_14_port, 
                           REGIN(13) => PC_BUS_13_port, REGIN(12) => 
                           PC_BUS_12_port, REGIN(11) => PC_BUS_11_port, 
                           REGIN(10) => PC_BUS_10_port, REGIN(9) => 
                           PC_BUS_9_port, REGIN(8) => PC_BUS_8_port, REGIN(7) 
                           => PC_BUS_7_port, REGIN(6) => PC_BUS_6_port, 
                           REGIN(5) => PC_BUS_5_port, REGIN(4) => PC_BUS_4_port
                           , REGIN(3) => PC_BUS_3_port, REGIN(2) => 
                           PC_BUS_2_port, REGIN(1) => PC_BUS_1_port, REGIN(0) 
                           => PC_BUS_0_port, REGOUT(31) => PC_OUT_31_port, 
                           REGOUT(30) => PC_OUT_30_port, REGOUT(29) => 
                           PC_OUT_29_port, REGOUT(28) => PC_OUT_28_port, 
                           REGOUT(27) => PC_OUT_27_port, REGOUT(26) => 
                           PC_OUT_26_port, REGOUT(25) => PC_OUT_25_port, 
                           REGOUT(24) => PC_OUT_24_port, REGOUT(23) => 
                           PC_OUT_23_port, REGOUT(22) => PC_OUT_22_port, 
                           REGOUT(21) => PC_OUT_21_port, REGOUT(20) => 
                           PC_OUT_20_port, REGOUT(19) => PC_OUT_19_port, 
                           REGOUT(18) => PC_OUT_18_port, REGOUT(17) => 
                           PC_OUT_17_port, REGOUT(16) => PC_OUT_16_port, 
                           REGOUT(15) => PC_OUT_15_port, REGOUT(14) => 
                           PC_OUT_14_port, REGOUT(13) => PC_OUT_13_port, 
                           REGOUT(12) => PC_OUT_12_port, REGOUT(11) => 
                           PC_OUT_11_port, REGOUT(10) => PC_OUT_10_port, 
                           REGOUT(9) => PC_OUT_9_port, REGOUT(8) => 
                           PC_OUT_8_port, REGOUT(7) => PC_OUT_7_port, REGOUT(6)
                           => PC_OUT_6_port, REGOUT(5) => PC_OUT_5_port, 
                           REGOUT(4) => PC_OUT_4_port, REGOUT(3) => 
                           PC_OUT_3_port, REGOUT(2) => PC_OUT_2_port, REGOUT(1)
                           => PC_OUT_1_port, REGOUT(0) => PC_OUT_0_port);
   PC_MUX : MUX21_N32_0 port map( A(31) => NPC_BUS_31_port, A(30) => 
                           NPC_BUS_30_port, A(29) => NPC_BUS_29_port, A(28) => 
                           NPC_BUS_28_port, A(27) => NPC_BUS_27_port, A(26) => 
                           NPC_BUS_26_port, A(25) => NPC_BUS_25_port, A(24) => 
                           NPC_BUS_24_port, A(23) => NPC_BUS_23_port, A(22) => 
                           NPC_BUS_22_port, A(21) => NPC_BUS_21_port, A(20) => 
                           NPC_BUS_20_port, A(19) => NPC_BUS_19_port, A(18) => 
                           NPC_BUS_18_port, A(17) => NPC_BUS_17_port, A(16) => 
                           NPC_BUS_16_port, A(15) => NPC_BUS_15_port, A(14) => 
                           NPC_BUS_14_port, A(13) => NPC_BUS_13_port, A(12) => 
                           NPC_BUS_12_port, A(11) => NPC_BUS_11_port, A(10) => 
                           NPC_BUS_10_port, A(9) => NPC_BUS_9_port, A(8) => 
                           NPC_BUS_8_port, A(7) => NPC_BUS_7_port, A(6) => 
                           NPC_BUS_6_port, A(5) => NPC_BUS_5_port, A(4) => 
                           NPC_BUS_4_port, A(3) => NPC_BUS_3_port, A(2) => 
                           NPC_BUS_2_port, A(1) => NPC_BUS_1_port, A(0) => 
                           NPC_BUS_0_port, B(31) => ALU_OUT_31_port, B(30) => 
                           ALU_OUT_30_port, B(29) => ALU_OUT_29_port, B(28) => 
                           ALU_OUT_28_port, B(27) => ALU_OUT_27_port, B(26) => 
                           ALU_OUT_26_port, B(25) => ALU_OUT_25_port, B(24) => 
                           ALU_OUT_24_port, B(23) => ALU_OUT_23_port, B(22) => 
                           ALU_OUT_22_port, B(21) => ALU_OUT_21_port, B(20) => 
                           ALU_OUT_20_port, B(19) => ALU_OUT_19_port, B(18) => 
                           ALU_OUT_18_port, B(17) => ALU_OUT_17_port, B(16) => 
                           ALU_OUT_16_port, B(15) => ALU_OUT_15_port, B(14) => 
                           ALU_OUT_14_port, B(13) => ALU_OUT_13_port, B(12) => 
                           ALU_OUT_12_port, B(11) => ALU_OUT_11_port, B(10) => 
                           ALU_OUT_10_port, B(9) => ALU_OUT_9_port, B(8) => 
                           ALU_OUT_8_port, B(7) => ALU_OUT_7_port, B(6) => 
                           ALU_OUT_6_port, B(5) => ALU_OUT_5_port, B(4) => 
                           ALU_OUT_4_port, B(3) => ALU_OUT_3_port, B(2) => 
                           ALU_OUT_2_port, B(1) => ALU_OUT_1_port, B(0) => 
                           ALU_OUT_0_port, S => n201_port, Y(31) => 
                           PC_BUS_31_port, Y(30) => PC_BUS_30_port, Y(29) => 
                           PC_BUS_29_port, Y(28) => PC_BUS_28_port, Y(27) => 
                           PC_BUS_27_port, Y(26) => PC_BUS_26_port, Y(25) => 
                           PC_BUS_25_port, Y(24) => PC_BUS_24_port, Y(23) => 
                           PC_BUS_23_port, Y(22) => PC_BUS_22_port, Y(21) => 
                           PC_BUS_21_port, Y(20) => PC_BUS_20_port, Y(19) => 
                           PC_BUS_19_port, Y(18) => PC_BUS_18_port, Y(17) => 
                           PC_BUS_17_port, Y(16) => PC_BUS_16_port, Y(15) => 
                           PC_BUS_15_port, Y(14) => PC_BUS_14_port, Y(13) => 
                           PC_BUS_13_port, Y(12) => PC_BUS_12_port, Y(11) => 
                           PC_BUS_11_port, Y(10) => PC_BUS_10_port, Y(9) => 
                           PC_BUS_9_port, Y(8) => PC_BUS_8_port, Y(7) => 
                           PC_BUS_7_port, Y(6) => PC_BUS_6_port, Y(5) => 
                           PC_BUS_5_port, Y(4) => PC_BUS_4_port, Y(3) => 
                           PC_BUS_3_port, Y(2) => PC_BUS_2_port, Y(1) => 
                           PC_BUS_1_port, Y(0) => PC_BUS_0_port);
   NEXT_PROGRAM_COUNTER : LDR_N32_0 port map( RST => RST, EN => NPC_LATCH_EN, 
                           REGIN(31) => PC_BUS_31_port, REGIN(30) => 
                           PC_BUS_30_port, REGIN(29) => PC_BUS_29_port, 
                           REGIN(28) => PC_BUS_28_port, REGIN(27) => 
                           PC_BUS_27_port, REGIN(26) => PC_BUS_26_port, 
                           REGIN(25) => PC_BUS_25_port, REGIN(24) => 
                           PC_BUS_24_port, REGIN(23) => PC_BUS_23_port, 
                           REGIN(22) => PC_BUS_22_port, REGIN(21) => 
                           PC_BUS_21_port, REGIN(20) => PC_BUS_20_port, 
                           REGIN(19) => PC_BUS_19_port, REGIN(18) => 
                           PC_BUS_18_port, REGIN(17) => PC_BUS_17_port, 
                           REGIN(16) => PC_BUS_16_port, REGIN(15) => 
                           PC_BUS_15_port, REGIN(14) => PC_BUS_14_port, 
                           REGIN(13) => PC_BUS_13_port, REGIN(12) => 
                           PC_BUS_12_port, REGIN(11) => PC_BUS_11_port, 
                           REGIN(10) => PC_BUS_10_port, REGIN(9) => 
                           PC_BUS_9_port, REGIN(8) => PC_BUS_8_port, REGIN(7) 
                           => PC_BUS_7_port, REGIN(6) => PC_BUS_6_port, 
                           REGIN(5) => PC_BUS_5_port, REGIN(4) => PC_BUS_4_port
                           , REGIN(3) => PC_BUS_3_port, REGIN(2) => 
                           PC_BUS_2_port, REGIN(1) => PC_BUS_1_port, REGIN(0) 
                           => PC_BUS_0_port, REGOUT(31) => NPC_OUT_31_port, 
                           REGOUT(30) => NPC_OUT_30_port, REGOUT(29) => 
                           NPC_OUT_29_port, REGOUT(28) => NPC_OUT_28_port, 
                           REGOUT(27) => NPC_OUT_27_port, REGOUT(26) => 
                           NPC_OUT_26_port, REGOUT(25) => NPC_OUT_25_port, 
                           REGOUT(24) => NPC_OUT_24_port, REGOUT(23) => 
                           NPC_OUT_23_port, REGOUT(22) => NPC_OUT_22_port, 
                           REGOUT(21) => NPC_OUT_21_port, REGOUT(20) => 
                           NPC_OUT_20_port, REGOUT(19) => NPC_OUT_19_port, 
                           REGOUT(18) => NPC_OUT_18_port, REGOUT(17) => 
                           NPC_OUT_17_port, REGOUT(16) => NPC_OUT_16_port, 
                           REGOUT(15) => NPC_OUT_15_port, REGOUT(14) => 
                           NPC_OUT_14_port, REGOUT(13) => NPC_OUT_13_port, 
                           REGOUT(12) => NPC_OUT_12_port, REGOUT(11) => 
                           NPC_OUT_11_port, REGOUT(10) => NPC_OUT_10_port, 
                           REGOUT(9) => NPC_OUT_9_port, REGOUT(8) => 
                           NPC_OUT_8_port, REGOUT(7) => NPC_OUT_7_port, 
                           REGOUT(6) => NPC_OUT_6_port, REGOUT(5) => 
                           NPC_OUT_5_port, REGOUT(4) => NPC_OUT_4_port, 
                           REGOUT(3) => NPC_OUT_3_port, REGOUT(2) => 
                           NPC_OUT_2_port, REGOUT(1) => NPC_OUT_1_port, 
                           REGOUT(0) => NPC_OUT_0_port);
   INSTRUCTION_REGISTER : LDR_N32_6 port map( RST => RST, EN => IR_LATCH_EN, 
                           REGIN(31) => IR_IN(31), REGIN(30) => IR_IN(30), 
                           REGIN(29) => IR_IN(29), REGIN(28) => IR_IN(28), 
                           REGIN(27) => IR_IN(27), REGIN(26) => IR_IN(26), 
                           REGIN(25) => IR_IN(25), REGIN(24) => IR_IN(24), 
                           REGIN(23) => IR_IN(23), REGIN(22) => IR_IN(22), 
                           REGIN(21) => IR_IN(21), REGIN(20) => IR_IN(20), 
                           REGIN(19) => IR_IN(19), REGIN(18) => IR_IN(18), 
                           REGIN(17) => IR_IN(17), REGIN(16) => IR_IN(16), 
                           REGIN(15) => IR_IN(15), REGIN(14) => IR_IN(14), 
                           REGIN(13) => IR_IN(13), REGIN(12) => IR_IN(12), 
                           REGIN(11) => IR_IN(11), REGIN(10) => IR_IN(10), 
                           REGIN(9) => IR_IN(9), REGIN(8) => IR_IN(8), REGIN(7)
                           => IR_IN(7), REGIN(6) => IR_IN(6), REGIN(5) => 
                           IR_IN(5), REGIN(4) => IR_IN(4), REGIN(3) => IR_IN(3)
                           , REGIN(2) => IR_IN(2), REGIN(1) => IR_IN(1), 
                           REGIN(0) => IR_IN(0), REGOUT(31) => IR_OUT_31_port, 
                           REGOUT(30) => IR_OUT_30_port, REGOUT(29) => 
                           IR_OUT_29_port, REGOUT(28) => IR_OUT_28_port, 
                           REGOUT(27) => IR_OUT_27_port, REGOUT(26) => 
                           IR_OUT_26_port, REGOUT(25) => IR_OUT_25_port, 
                           REGOUT(24) => IR_OUT_24_port, REGOUT(23) => 
                           IR_OUT_23_port, REGOUT(22) => IR_OUT_22_port, 
                           REGOUT(21) => IR_OUT_21_port, REGOUT(20) => 
                           IR_OUT_20_port, REGOUT(19) => IR_OUT_19_port, 
                           REGOUT(18) => IR_OUT_18_port, REGOUT(17) => 
                           IR_OUT_17_port, REGOUT(16) => IR_OUT_16_port, 
                           REGOUT(15) => IR_OUT_15_port, REGOUT(14) => 
                           IR_OUT_14_port, REGOUT(13) => IR_OUT_13_port, 
                           REGOUT(12) => IR_OUT_12_port, REGOUT(11) => 
                           IR_OUT_11_port, REGOUT(10) => IR_OUT_10_port, 
                           REGOUT(9) => IR_OUT_9_port, REGOUT(8) => 
                           IR_OUT_8_port, REGOUT(7) => IR_OUT_7_port, REGOUT(6)
                           => IR_OUT_6_port, REGOUT(5) => IR_OUT_5_port, 
                           REGOUT(4) => IR_OUT_4_port, REGOUT(3) => 
                           IR_OUT_3_port, REGOUT(2) => IR_OUT_2_port, REGOUT(1)
                           => IR_OUT_1_port, REGOUT(0) => IR_OUT_0_port);
   REGISTER_FILE : RF_N32_NA5 port map( RST => RST, EN => X_Logic1_port, EN_RD1
                           => X_Logic1_port, EN_RD2 => X_Logic1_port, EN_WR => 
                           MEM_WB_RF_WE, ADD_RD1(4) => RS1_4_port, ADD_RD1(3) 
                           => RS1_3_port, ADD_RD1(2) => RS1_2_port, ADD_RD1(1) 
                           => RS1_1_port, ADD_RD1(0) => RS1_0_port, ADD_RD2(4) 
                           => RS2_4_port, ADD_RD2(3) => RS2_3_port, ADD_RD2(2) 
                           => RS2_2_port, ADD_RD2(1) => RS2_1_port, ADD_RD2(0) 
                           => RS2_0_port, ADD_WR(4) => MEM_WB_RD_4_port, 
                           ADD_WR(3) => MEM_WB_RD_3_port, ADD_WR(2) => 
                           MEM_WB_RD_2_port, ADD_WR(1) => MEM_WB_RD_1_port, 
                           ADD_WR(0) => MEM_WB_RD_0_port, DATAIN(31) => 
                           ID_EX_RF_DATAIN_NEXT_31_port, DATAIN(30) => 
                           ID_EX_RF_DATAIN_NEXT_30_port, DATAIN(29) => 
                           ID_EX_RF_DATAIN_NEXT_29_port, DATAIN(28) => 
                           ID_EX_RF_DATAIN_NEXT_28_port, DATAIN(27) => 
                           ID_EX_RF_DATAIN_NEXT_27_port, DATAIN(26) => 
                           ID_EX_RF_DATAIN_NEXT_26_port, DATAIN(25) => 
                           ID_EX_RF_DATAIN_NEXT_25_port, DATAIN(24) => 
                           ID_EX_RF_DATAIN_NEXT_24_port, DATAIN(23) => 
                           ID_EX_RF_DATAIN_NEXT_23_port, DATAIN(22) => 
                           ID_EX_RF_DATAIN_NEXT_22_port, DATAIN(21) => 
                           ID_EX_RF_DATAIN_NEXT_21_port, DATAIN(20) => 
                           ID_EX_RF_DATAIN_NEXT_20_port, DATAIN(19) => 
                           ID_EX_RF_DATAIN_NEXT_19_port, DATAIN(18) => 
                           ID_EX_RF_DATAIN_NEXT_18_port, DATAIN(17) => 
                           ID_EX_RF_DATAIN_NEXT_17_port, DATAIN(16) => 
                           ID_EX_RF_DATAIN_NEXT_16_port, DATAIN(15) => 
                           ID_EX_RF_DATAIN_NEXT_15_port, DATAIN(14) => 
                           ID_EX_RF_DATAIN_NEXT_14_port, DATAIN(13) => 
                           ID_EX_RF_DATAIN_NEXT_13_port, DATAIN(12) => 
                           ID_EX_RF_DATAIN_NEXT_12_port, DATAIN(11) => 
                           ID_EX_RF_DATAIN_NEXT_11_port, DATAIN(10) => 
                           ID_EX_RF_DATAIN_NEXT_10_port, DATAIN(9) => 
                           ID_EX_RF_DATAIN_NEXT_9_port, DATAIN(8) => 
                           ID_EX_RF_DATAIN_NEXT_8_port, DATAIN(7) => 
                           ID_EX_RF_DATAIN_NEXT_7_port, DATAIN(6) => 
                           ID_EX_RF_DATAIN_NEXT_6_port, DATAIN(5) => 
                           ID_EX_RF_DATAIN_NEXT_5_port, DATAIN(4) => 
                           ID_EX_RF_DATAIN_NEXT_4_port, DATAIN(3) => 
                           ID_EX_RF_DATAIN_NEXT_3_port, DATAIN(2) => 
                           ID_EX_RF_DATAIN_NEXT_2_port, DATAIN(1) => 
                           ID_EX_RF_DATAIN_NEXT_1_port, DATAIN(0) => 
                           ID_EX_RF_DATAIN_NEXT_0_port, OUT1(31) => 
                           RF_OUT1_31_port, OUT1(30) => RF_OUT1_30_port, 
                           OUT1(29) => RF_OUT1_29_port, OUT1(28) => 
                           RF_OUT1_28_port, OUT1(27) => RF_OUT1_27_port, 
                           OUT1(26) => RF_OUT1_26_port, OUT1(25) => 
                           RF_OUT1_25_port, OUT1(24) => RF_OUT1_24_port, 
                           OUT1(23) => RF_OUT1_23_port, OUT1(22) => 
                           RF_OUT1_22_port, OUT1(21) => RF_OUT1_21_port, 
                           OUT1(20) => RF_OUT1_20_port, OUT1(19) => 
                           RF_OUT1_19_port, OUT1(18) => RF_OUT1_18_port, 
                           OUT1(17) => RF_OUT1_17_port, OUT1(16) => 
                           RF_OUT1_16_port, OUT1(15) => RF_OUT1_15_port, 
                           OUT1(14) => RF_OUT1_14_port, OUT1(13) => 
                           RF_OUT1_13_port, OUT1(12) => RF_OUT1_12_port, 
                           OUT1(11) => RF_OUT1_11_port, OUT1(10) => 
                           RF_OUT1_10_port, OUT1(9) => RF_OUT1_9_port, OUT1(8) 
                           => RF_OUT1_8_port, OUT1(7) => RF_OUT1_7_port, 
                           OUT1(6) => RF_OUT1_6_port, OUT1(5) => RF_OUT1_5_port
                           , OUT1(4) => RF_OUT1_4_port, OUT1(3) => 
                           RF_OUT1_3_port, OUT1(2) => RF_OUT1_2_port, OUT1(1) 
                           => RF_OUT1_1_port, OUT1(0) => RF_OUT1_0_port, 
                           OUT2(31) => RF_OUT2_31_port, OUT2(30) => 
                           RF_OUT2_30_port, OUT2(29) => RF_OUT2_29_port, 
                           OUT2(28) => RF_OUT2_28_port, OUT2(27) => 
                           RF_OUT2_27_port, OUT2(26) => RF_OUT2_26_port, 
                           OUT2(25) => RF_OUT2_25_port, OUT2(24) => 
                           RF_OUT2_24_port, OUT2(23) => RF_OUT2_23_port, 
                           OUT2(22) => RF_OUT2_22_port, OUT2(21) => 
                           RF_OUT2_21_port, OUT2(20) => RF_OUT2_20_port, 
                           OUT2(19) => RF_OUT2_19_port, OUT2(18) => 
                           RF_OUT2_18_port, OUT2(17) => RF_OUT2_17_port, 
                           OUT2(16) => RF_OUT2_16_port, OUT2(15) => 
                           RF_OUT2_15_port, OUT2(14) => RF_OUT2_14_port, 
                           OUT2(13) => RF_OUT2_13_port, OUT2(12) => 
                           RF_OUT2_12_port, OUT2(11) => RF_OUT2_11_port, 
                           OUT2(10) => RF_OUT2_10_port, OUT2(9) => 
                           RF_OUT2_9_port, OUT2(8) => RF_OUT2_8_port, OUT2(7) 
                           => RF_OUT2_7_port, OUT2(6) => RF_OUT2_6_port, 
                           OUT2(5) => RF_OUT2_5_port, OUT2(4) => RF_OUT2_4_port
                           , OUT2(3) => RF_OUT2_3_port, OUT2(2) => 
                           RF_OUT2_2_port, OUT2(1) => RF_OUT2_1_port, OUT2(0) 
                           => RF_OUT2_0_port);
   SIGN_EXTEND : SIGNEX_N32_OPC6_REG5 port map( INSTR(31) => IF_ID_IR_31_port, 
                           INSTR(30) => IF_ID_IR_30_port, INSTR(29) => 
                           IF_ID_IR_29_port, INSTR(28) => IF_ID_IR_28_port, 
                           INSTR(27) => IF_ID_IR_27_port, INSTR(26) => 
                           IF_ID_IR_26_port, INSTR(25) => IF_ID_IR_25_port, 
                           INSTR(24) => IF_ID_IR_24_port, INSTR(23) => 
                           IF_ID_IR_23_port, INSTR(22) => IF_ID_IR_22_port, 
                           INSTR(21) => IF_ID_IR_21_port, INSTR(20) => 
                           IF_ID_IR_20_port, INSTR(19) => IF_ID_IR_19_port, 
                           INSTR(18) => IF_ID_IR_18_port, INSTR(17) => 
                           IF_ID_IR_17_port, INSTR(16) => IF_ID_IR_16_port, 
                           INSTR(15) => IF_ID_IR_15_port, INSTR(14) => 
                           IF_ID_IR_14_port, INSTR(13) => IF_ID_IR_13_port, 
                           INSTR(12) => IF_ID_IR_12_port, INSTR(11) => 
                           IF_ID_IR_11_port, INSTR(10) => IF_ID_IR_10_port, 
                           INSTR(9) => IF_ID_IR_9_port, INSTR(8) => 
                           IF_ID_IR_8_port, INSTR(7) => IF_ID_IR_7_port, 
                           INSTR(6) => IF_ID_IR_6_port, INSTR(5) => 
                           IF_ID_IR_5_port, INSTR(4) => IF_ID_IR_4_port, 
                           INSTR(3) => IF_ID_IR_3_port, INSTR(2) => 
                           IF_ID_IR_2_port, INSTR(1) => IF_ID_IR_1_port, 
                           INSTR(0) => IF_ID_IR_0_port, IMM(31) => 
                           IMM_OUT_31_port, IMM(30) => IMM_OUT_30_port, IMM(29)
                           => IMM_OUT_29_port, IMM(28) => IMM_OUT_28_port, 
                           IMM(27) => IMM_OUT_27_port, IMM(26) => 
                           IMM_OUT_26_port, IMM(25) => IMM_OUT_25_port, IMM(24)
                           => IMM_OUT_24_port, IMM(23) => IMM_OUT_23_port, 
                           IMM(22) => IMM_OUT_22_port, IMM(21) => 
                           IMM_OUT_21_port, IMM(20) => IMM_OUT_20_port, IMM(19)
                           => IMM_OUT_19_port, IMM(18) => IMM_OUT_18_port, 
                           IMM(17) => IMM_OUT_17_port, IMM(16) => 
                           IMM_OUT_16_port, IMM(15) => IMM_OUT_15_port, IMM(14)
                           => IMM_OUT_14_port, IMM(13) => IMM_OUT_13_port, 
                           IMM(12) => IMM_OUT_12_port, IMM(11) => 
                           IMM_OUT_11_port, IMM(10) => IMM_OUT_10_port, IMM(9) 
                           => IMM_OUT_9_port, IMM(8) => IMM_OUT_8_port, IMM(7) 
                           => IMM_OUT_7_port, IMM(6) => IMM_OUT_6_port, IMM(5) 
                           => IMM_OUT_5_port, IMM(4) => IMM_OUT_4_port, IMM(3) 
                           => IMM_OUT_3_port, IMM(2) => IMM_OUT_2_port, IMM(1) 
                           => IMM_OUT_1_port, IMM(0) => IMM_OUT_0_port);
   REGISTER_ADDRESSER : REGADDR_N32_OPC6_REG5 port map( INSTR(31) => 
                           IF_ID_IR_31_port, INSTR(30) => IF_ID_IR_30_port, 
                           INSTR(29) => IF_ID_IR_29_port, INSTR(28) => 
                           IF_ID_IR_28_port, INSTR(27) => IF_ID_IR_27_port, 
                           INSTR(26) => IF_ID_IR_26_port, INSTR(25) => 
                           IF_ID_IR_25_port, INSTR(24) => IF_ID_IR_24_port, 
                           INSTR(23) => IF_ID_IR_23_port, INSTR(22) => 
                           IF_ID_IR_22_port, INSTR(21) => IF_ID_IR_21_port, 
                           INSTR(20) => IF_ID_IR_20_port, INSTR(19) => 
                           IF_ID_IR_19_port, INSTR(18) => IF_ID_IR_18_port, 
                           INSTR(17) => IF_ID_IR_17_port, INSTR(16) => 
                           IF_ID_IR_16_port, INSTR(15) => IF_ID_IR_15_port, 
                           INSTR(14) => IF_ID_IR_14_port, INSTR(13) => 
                           IF_ID_IR_13_port, INSTR(12) => IF_ID_IR_12_port, 
                           INSTR(11) => IF_ID_IR_11_port, INSTR(10) => 
                           IF_ID_IR_10_port, INSTR(9) => IF_ID_IR_9_port, 
                           INSTR(8) => IF_ID_IR_8_port, INSTR(7) => 
                           IF_ID_IR_7_port, INSTR(6) => IF_ID_IR_6_port, 
                           INSTR(5) => IF_ID_IR_5_port, INSTR(4) => 
                           IF_ID_IR_4_port, INSTR(3) => IF_ID_IR_3_port, 
                           INSTR(2) => IF_ID_IR_2_port, INSTR(1) => 
                           IF_ID_IR_1_port, INSTR(0) => IF_ID_IR_0_port, RS1(4)
                           => RS1_4_port, RS1(3) => RS1_3_port, RS1(2) => 
                           RS1_2_port, RS1(1) => RS1_1_port, RS1(0) => 
                           RS1_0_port, RS2(4) => RS2_4_port, RS2(3) => 
                           RS2_3_port, RS2(2) => RS2_2_port, RS2(1) => 
                           RS2_1_port, RS2(0) => RS2_0_port, RD(4) => RD_4_port
                           , RD(3) => RD_3_port, RD(2) => RD_2_port, RD(1) => 
                           RD_1_port, RD(0) => RD_0_port);
   LATCH_REGA : LDR_N32_5 port map( RST => RST, EN => RegA_LATCH_EN, REGIN(31) 
                           => RF_OUT1_31_port, REGIN(30) => RF_OUT1_30_port, 
                           REGIN(29) => RF_OUT1_29_port, REGIN(28) => 
                           RF_OUT1_28_port, REGIN(27) => RF_OUT1_27_port, 
                           REGIN(26) => RF_OUT1_26_port, REGIN(25) => 
                           RF_OUT1_25_port, REGIN(24) => RF_OUT1_24_port, 
                           REGIN(23) => RF_OUT1_23_port, REGIN(22) => 
                           RF_OUT1_22_port, REGIN(21) => RF_OUT1_21_port, 
                           REGIN(20) => RF_OUT1_20_port, REGIN(19) => 
                           RF_OUT1_19_port, REGIN(18) => RF_OUT1_18_port, 
                           REGIN(17) => RF_OUT1_17_port, REGIN(16) => 
                           RF_OUT1_16_port, REGIN(15) => RF_OUT1_15_port, 
                           REGIN(14) => RF_OUT1_14_port, REGIN(13) => 
                           RF_OUT1_13_port, REGIN(12) => RF_OUT1_12_port, 
                           REGIN(11) => RF_OUT1_11_port, REGIN(10) => 
                           RF_OUT1_10_port, REGIN(9) => RF_OUT1_9_port, 
                           REGIN(8) => RF_OUT1_8_port, REGIN(7) => 
                           RF_OUT1_7_port, REGIN(6) => RF_OUT1_6_port, REGIN(5)
                           => RF_OUT1_5_port, REGIN(4) => RF_OUT1_4_port, 
                           REGIN(3) => RF_OUT1_3_port, REGIN(2) => 
                           RF_OUT1_2_port, REGIN(1) => RF_OUT1_1_port, REGIN(0)
                           => RF_OUT1_0_port, REGOUT(31) => 
                           ID_EX_RF_OUT1_NEXT_31_port, REGOUT(30) => 
                           ID_EX_RF_OUT1_NEXT_30_port, REGOUT(29) => 
                           ID_EX_RF_OUT1_NEXT_29_port, REGOUT(28) => 
                           ID_EX_RF_OUT1_NEXT_28_port, REGOUT(27) => 
                           ID_EX_RF_OUT1_NEXT_27_port, REGOUT(26) => 
                           ID_EX_RF_OUT1_NEXT_26_port, REGOUT(25) => 
                           ID_EX_RF_OUT1_NEXT_25_port, REGOUT(24) => 
                           ID_EX_RF_OUT1_NEXT_24_port, REGOUT(23) => 
                           ID_EX_RF_OUT1_NEXT_23_port, REGOUT(22) => 
                           ID_EX_RF_OUT1_NEXT_22_port, REGOUT(21) => 
                           ID_EX_RF_OUT1_NEXT_21_port, REGOUT(20) => 
                           ID_EX_RF_OUT1_NEXT_20_port, REGOUT(19) => 
                           ID_EX_RF_OUT1_NEXT_19_port, REGOUT(18) => 
                           ID_EX_RF_OUT1_NEXT_18_port, REGOUT(17) => 
                           ID_EX_RF_OUT1_NEXT_17_port, REGOUT(16) => 
                           ID_EX_RF_OUT1_NEXT_16_port, REGOUT(15) => 
                           ID_EX_RF_OUT1_NEXT_15_port, REGOUT(14) => 
                           ID_EX_RF_OUT1_NEXT_14_port, REGOUT(13) => 
                           ID_EX_RF_OUT1_NEXT_13_port, REGOUT(12) => 
                           ID_EX_RF_OUT1_NEXT_12_port, REGOUT(11) => 
                           ID_EX_RF_OUT1_NEXT_11_port, REGOUT(10) => 
                           ID_EX_RF_OUT1_NEXT_10_port, REGOUT(9) => 
                           ID_EX_RF_OUT1_NEXT_9_port, REGOUT(8) => 
                           ID_EX_RF_OUT1_NEXT_8_port, REGOUT(7) => 
                           ID_EX_RF_OUT1_NEXT_7_port, REGOUT(6) => 
                           ID_EX_RF_OUT1_NEXT_6_port, REGOUT(5) => 
                           ID_EX_RF_OUT1_NEXT_5_port, REGOUT(4) => 
                           ID_EX_RF_OUT1_NEXT_4_port, REGOUT(3) => 
                           ID_EX_RF_OUT1_NEXT_3_port, REGOUT(2) => 
                           ID_EX_RF_OUT1_NEXT_2_port, REGOUT(1) => 
                           ID_EX_RF_OUT1_NEXT_1_port, REGOUT(0) => 
                           ID_EX_RF_OUT1_NEXT_0_port);
   LATCH_REGB : LDR_N32_4 port map( RST => RST, EN => RegB_LATCH_EN, REGIN(31) 
                           => RF_OUT2_31_port, REGIN(30) => RF_OUT2_30_port, 
                           REGIN(29) => RF_OUT2_29_port, REGIN(28) => 
                           RF_OUT2_28_port, REGIN(27) => RF_OUT2_27_port, 
                           REGIN(26) => RF_OUT2_26_port, REGIN(25) => 
                           RF_OUT2_25_port, REGIN(24) => RF_OUT2_24_port, 
                           REGIN(23) => RF_OUT2_23_port, REGIN(22) => 
                           RF_OUT2_22_port, REGIN(21) => RF_OUT2_21_port, 
                           REGIN(20) => RF_OUT2_20_port, REGIN(19) => 
                           RF_OUT2_19_port, REGIN(18) => RF_OUT2_18_port, 
                           REGIN(17) => RF_OUT2_17_port, REGIN(16) => 
                           RF_OUT2_16_port, REGIN(15) => RF_OUT2_15_port, 
                           REGIN(14) => RF_OUT2_14_port, REGIN(13) => 
                           RF_OUT2_13_port, REGIN(12) => RF_OUT2_12_port, 
                           REGIN(11) => RF_OUT2_11_port, REGIN(10) => 
                           RF_OUT2_10_port, REGIN(9) => RF_OUT2_9_port, 
                           REGIN(8) => RF_OUT2_8_port, REGIN(7) => 
                           RF_OUT2_7_port, REGIN(6) => RF_OUT2_6_port, REGIN(5)
                           => RF_OUT2_5_port, REGIN(4) => RF_OUT2_4_port, 
                           REGIN(3) => RF_OUT2_3_port, REGIN(2) => 
                           RF_OUT2_2_port, REGIN(1) => RF_OUT2_1_port, REGIN(0)
                           => RF_OUT2_0_port, REGOUT(31) => 
                           ID_EX_RF_OUT2_NEXT_31_port, REGOUT(30) => 
                           ID_EX_RF_OUT2_NEXT_30_port, REGOUT(29) => 
                           ID_EX_RF_OUT2_NEXT_29_port, REGOUT(28) => 
                           ID_EX_RF_OUT2_NEXT_28_port, REGOUT(27) => 
                           ID_EX_RF_OUT2_NEXT_27_port, REGOUT(26) => 
                           ID_EX_RF_OUT2_NEXT_26_port, REGOUT(25) => 
                           ID_EX_RF_OUT2_NEXT_25_port, REGOUT(24) => 
                           ID_EX_RF_OUT2_NEXT_24_port, REGOUT(23) => 
                           ID_EX_RF_OUT2_NEXT_23_port, REGOUT(22) => 
                           ID_EX_RF_OUT2_NEXT_22_port, REGOUT(21) => 
                           ID_EX_RF_OUT2_NEXT_21_port, REGOUT(20) => 
                           ID_EX_RF_OUT2_NEXT_20_port, REGOUT(19) => 
                           ID_EX_RF_OUT2_NEXT_19_port, REGOUT(18) => 
                           ID_EX_RF_OUT2_NEXT_18_port, REGOUT(17) => 
                           ID_EX_RF_OUT2_NEXT_17_port, REGOUT(16) => 
                           ID_EX_RF_OUT2_NEXT_16_port, REGOUT(15) => 
                           ID_EX_RF_OUT2_NEXT_15_port, REGOUT(14) => 
                           ID_EX_RF_OUT2_NEXT_14_port, REGOUT(13) => 
                           ID_EX_RF_OUT2_NEXT_13_port, REGOUT(12) => 
                           ID_EX_RF_OUT2_NEXT_12_port, REGOUT(11) => 
                           ID_EX_RF_OUT2_NEXT_11_port, REGOUT(10) => 
                           ID_EX_RF_OUT2_NEXT_10_port, REGOUT(9) => 
                           ID_EX_RF_OUT2_NEXT_9_port, REGOUT(8) => 
                           ID_EX_RF_OUT2_NEXT_8_port, REGOUT(7) => 
                           ID_EX_RF_OUT2_NEXT_7_port, REGOUT(6) => 
                           ID_EX_RF_OUT2_NEXT_6_port, REGOUT(5) => 
                           ID_EX_RF_OUT2_NEXT_5_port, REGOUT(4) => 
                           ID_EX_RF_OUT2_NEXT_4_port, REGOUT(3) => 
                           ID_EX_RF_OUT2_NEXT_3_port, REGOUT(2) => 
                           ID_EX_RF_OUT2_NEXT_2_port, REGOUT(1) => 
                           ID_EX_RF_OUT2_NEXT_1_port, REGOUT(0) => 
                           ID_EX_RF_OUT2_NEXT_0_port);
   LATCH_REGIMM : LDR_N32_3 port map( RST => RST, EN => RegIMM_LATCH_EN, 
                           REGIN(31) => IMM_OUT_31_port, REGIN(30) => 
                           IMM_OUT_30_port, REGIN(29) => IMM_OUT_29_port, 
                           REGIN(28) => IMM_OUT_28_port, REGIN(27) => 
                           IMM_OUT_27_port, REGIN(26) => IMM_OUT_26_port, 
                           REGIN(25) => IMM_OUT_25_port, REGIN(24) => 
                           IMM_OUT_24_port, REGIN(23) => IMM_OUT_23_port, 
                           REGIN(22) => IMM_OUT_22_port, REGIN(21) => 
                           IMM_OUT_21_port, REGIN(20) => IMM_OUT_20_port, 
                           REGIN(19) => IMM_OUT_19_port, REGIN(18) => 
                           IMM_OUT_18_port, REGIN(17) => IMM_OUT_17_port, 
                           REGIN(16) => IMM_OUT_16_port, REGIN(15) => 
                           IMM_OUT_15_port, REGIN(14) => IMM_OUT_14_port, 
                           REGIN(13) => IMM_OUT_13_port, REGIN(12) => 
                           IMM_OUT_12_port, REGIN(11) => IMM_OUT_11_port, 
                           REGIN(10) => IMM_OUT_10_port, REGIN(9) => 
                           IMM_OUT_9_port, REGIN(8) => IMM_OUT_8_port, REGIN(7)
                           => IMM_OUT_7_port, REGIN(6) => IMM_OUT_6_port, 
                           REGIN(5) => IMM_OUT_5_port, REGIN(4) => 
                           IMM_OUT_4_port, REGIN(3) => IMM_OUT_3_port, REGIN(2)
                           => IMM_OUT_2_port, REGIN(1) => IMM_OUT_1_port, 
                           REGIN(0) => IMM_OUT_0_port, REGOUT(31) => 
                           ID_EX_IMM_NEXT_31_port, REGOUT(30) => 
                           ID_EX_IMM_NEXT_30_port, REGOUT(29) => 
                           ID_EX_IMM_NEXT_29_port, REGOUT(28) => 
                           ID_EX_IMM_NEXT_28_port, REGOUT(27) => 
                           ID_EX_IMM_NEXT_27_port, REGOUT(26) => 
                           ID_EX_IMM_NEXT_26_port, REGOUT(25) => 
                           ID_EX_IMM_NEXT_25_port, REGOUT(24) => 
                           ID_EX_IMM_NEXT_24_port, REGOUT(23) => 
                           ID_EX_IMM_NEXT_23_port, REGOUT(22) => 
                           ID_EX_IMM_NEXT_22_port, REGOUT(21) => 
                           ID_EX_IMM_NEXT_21_port, REGOUT(20) => 
                           ID_EX_IMM_NEXT_20_port, REGOUT(19) => 
                           ID_EX_IMM_NEXT_19_port, REGOUT(18) => 
                           ID_EX_IMM_NEXT_18_port, REGOUT(17) => 
                           ID_EX_IMM_NEXT_17_port, REGOUT(16) => 
                           ID_EX_IMM_NEXT_16_port, REGOUT(15) => 
                           ID_EX_IMM_NEXT_15_port, REGOUT(14) => 
                           ID_EX_IMM_NEXT_14_port, REGOUT(13) => 
                           ID_EX_IMM_NEXT_13_port, REGOUT(12) => 
                           ID_EX_IMM_NEXT_12_port, REGOUT(11) => 
                           ID_EX_IMM_NEXT_11_port, REGOUT(10) => 
                           ID_EX_IMM_NEXT_10_port, REGOUT(9) => 
                           ID_EX_IMM_NEXT_9_port, REGOUT(8) => 
                           ID_EX_IMM_NEXT_8_port, REGOUT(7) => 
                           ID_EX_IMM_NEXT_7_port, REGOUT(6) => 
                           ID_EX_IMM_NEXT_6_port, REGOUT(5) => 
                           ID_EX_IMM_NEXT_5_port, REGOUT(4) => 
                           ID_EX_IMM_NEXT_4_port, REGOUT(3) => 
                           ID_EX_IMM_NEXT_3_port, REGOUT(2) => 
                           ID_EX_IMM_NEXT_2_port, REGOUT(1) => 
                           ID_EX_IMM_NEXT_1_port, REGOUT(0) => 
                           ID_EX_IMM_NEXT_0_port);
   ALU_PRE_MUX1 : MUX41_N32_0 port map( A(31) => ID_EX_RF_OUT1_31_port, A(30) 
                           => ID_EX_RF_OUT1_30_port, A(29) => 
                           ID_EX_RF_OUT1_29_port, A(28) => 
                           ID_EX_RF_OUT1_28_port, A(27) => 
                           ID_EX_RF_OUT1_27_port, A(26) => 
                           ID_EX_RF_OUT1_26_port, A(25) => 
                           ID_EX_RF_OUT1_25_port, A(24) => 
                           ID_EX_RF_OUT1_24_port, A(23) => 
                           ID_EX_RF_OUT1_23_port, A(22) => 
                           ID_EX_RF_OUT1_22_port, A(21) => 
                           ID_EX_RF_OUT1_21_port, A(20) => 
                           ID_EX_RF_OUT1_20_port, A(19) => 
                           ID_EX_RF_OUT1_19_port, A(18) => 
                           ID_EX_RF_OUT1_18_port, A(17) => 
                           ID_EX_RF_OUT1_17_port, A(16) => 
                           ID_EX_RF_OUT1_16_port, A(15) => 
                           ID_EX_RF_OUT1_15_port, A(14) => 
                           ID_EX_RF_OUT1_14_port, A(13) => 
                           ID_EX_RF_OUT1_13_port, A(12) => 
                           ID_EX_RF_OUT1_12_port, A(11) => 
                           ID_EX_RF_OUT1_11_port, A(10) => 
                           ID_EX_RF_OUT1_10_port, A(9) => ID_EX_RF_OUT1_9_port,
                           A(8) => ID_EX_RF_OUT1_8_port, A(7) => 
                           ID_EX_RF_OUT1_7_port, A(6) => ID_EX_RF_OUT1_6_port, 
                           A(5) => ID_EX_RF_OUT1_5_port, A(4) => 
                           ID_EX_RF_OUT1_4_port, A(3) => ID_EX_RF_OUT1_3_port, 
                           A(2) => ID_EX_RF_OUT1_2_port, A(1) => 
                           ID_EX_RF_OUT1_1_port, A(0) => ID_EX_RF_OUT1_0_port, 
                           B(31) => ALU_OUT_31_port, B(30) => ALU_OUT_30_port, 
                           B(29) => ALU_OUT_29_port, B(28) => ALU_OUT_28_port, 
                           B(27) => ALU_OUT_27_port, B(26) => ALU_OUT_26_port, 
                           B(25) => ALU_OUT_25_port, B(24) => ALU_OUT_24_port, 
                           B(23) => ALU_OUT_23_port, B(22) => ALU_OUT_22_port, 
                           B(21) => ALU_OUT_21_port, B(20) => ALU_OUT_20_port, 
                           B(19) => ALU_OUT_19_port, B(18) => ALU_OUT_18_port, 
                           B(17) => ALU_OUT_17_port, B(16) => ALU_OUT_16_port, 
                           B(15) => ALU_OUT_15_port, B(14) => ALU_OUT_14_port, 
                           B(13) => ALU_OUT_13_port, B(12) => ALU_OUT_12_port, 
                           B(11) => ALU_OUT_11_port, B(10) => ALU_OUT_10_port, 
                           B(9) => ALU_OUT_9_port, B(8) => ALU_OUT_8_port, B(7)
                           => ALU_OUT_7_port, B(6) => ALU_OUT_6_port, B(5) => 
                           ALU_OUT_5_port, B(4) => ALU_OUT_4_port, B(3) => 
                           ALU_OUT_3_port, B(2) => ALU_OUT_2_port, B(1) => 
                           ALU_OUT_1_port, B(0) => ALU_OUT_0_port, C(31) => 
                           ID_EX_RF_DATAIN_NEXT_31_port, C(30) => 
                           ID_EX_RF_DATAIN_NEXT_30_port, C(29) => 
                           ID_EX_RF_DATAIN_NEXT_29_port, C(28) => 
                           ID_EX_RF_DATAIN_NEXT_28_port, C(27) => 
                           ID_EX_RF_DATAIN_NEXT_27_port, C(26) => 
                           ID_EX_RF_DATAIN_NEXT_26_port, C(25) => 
                           ID_EX_RF_DATAIN_NEXT_25_port, C(24) => 
                           ID_EX_RF_DATAIN_NEXT_24_port, C(23) => 
                           ID_EX_RF_DATAIN_NEXT_23_port, C(22) => 
                           ID_EX_RF_DATAIN_NEXT_22_port, C(21) => 
                           ID_EX_RF_DATAIN_NEXT_21_port, C(20) => 
                           ID_EX_RF_DATAIN_NEXT_20_port, C(19) => 
                           ID_EX_RF_DATAIN_NEXT_19_port, C(18) => 
                           ID_EX_RF_DATAIN_NEXT_18_port, C(17) => 
                           ID_EX_RF_DATAIN_NEXT_17_port, C(16) => 
                           ID_EX_RF_DATAIN_NEXT_16_port, C(15) => 
                           ID_EX_RF_DATAIN_NEXT_15_port, C(14) => 
                           ID_EX_RF_DATAIN_NEXT_14_port, C(13) => 
                           ID_EX_RF_DATAIN_NEXT_13_port, C(12) => 
                           ID_EX_RF_DATAIN_NEXT_12_port, C(11) => 
                           ID_EX_RF_DATAIN_NEXT_11_port, C(10) => 
                           ID_EX_RF_DATAIN_NEXT_10_port, C(9) => 
                           ID_EX_RF_DATAIN_NEXT_9_port, C(8) => 
                           ID_EX_RF_DATAIN_NEXT_8_port, C(7) => 
                           ID_EX_RF_DATAIN_NEXT_7_port, C(6) => 
                           ID_EX_RF_DATAIN_NEXT_6_port, C(5) => 
                           ID_EX_RF_DATAIN_NEXT_5_port, C(4) => 
                           ID_EX_RF_DATAIN_NEXT_4_port, C(3) => 
                           ID_EX_RF_DATAIN_NEXT_3_port, C(2) => 
                           ID_EX_RF_DATAIN_NEXT_2_port, C(1) => 
                           ID_EX_RF_DATAIN_NEXT_1_port, C(0) => 
                           ID_EX_RF_DATAIN_NEXT_0_port, D(31) => n200_port, 
                           D(30) => n200_port, D(29) => n200_port, D(28) => 
                           n200_port, D(27) => n200_port, D(26) => n200_port, 
                           D(25) => n200_port, D(24) => n200_port, D(23) => 
                           n200_port, D(22) => n200_port, D(21) => n200_port, 
                           D(20) => n200_port, D(19) => n200_port, D(18) => 
                           n200_port, D(17) => n200_port, D(16) => n200_port, 
                           D(15) => n200_port, D(14) => n200_port, D(13) => 
                           n200_port, D(12) => n200_port, D(11) => n200_port, 
                           D(10) => n200_port, D(9) => n200_port, D(8) => 
                           n200_port, D(7) => n200_port, D(6) => n200_port, 
                           D(5) => n200_port, D(4) => n200_port, D(3) => 
                           n200_port, D(2) => n200_port, D(1) => n200_port, 
                           D(0) => n200_port, S(1) => FORWARD_A_1_port, S(0) =>
                           FORWARD_A_0_port, Y(31) => ALU_PREOP1_31_port, Y(30)
                           => ALU_PREOP1_30_port, Y(29) => ALU_PREOP1_29_port, 
                           Y(28) => ALU_PREOP1_28_port, Y(27) => 
                           ALU_PREOP1_27_port, Y(26) => ALU_PREOP1_26_port, 
                           Y(25) => ALU_PREOP1_25_port, Y(24) => 
                           ALU_PREOP1_24_port, Y(23) => ALU_PREOP1_23_port, 
                           Y(22) => ALU_PREOP1_22_port, Y(21) => 
                           ALU_PREOP1_21_port, Y(20) => ALU_PREOP1_20_port, 
                           Y(19) => ALU_PREOP1_19_port, Y(18) => 
                           ALU_PREOP1_18_port, Y(17) => ALU_PREOP1_17_port, 
                           Y(16) => ALU_PREOP1_16_port, Y(15) => 
                           ALU_PREOP1_15_port, Y(14) => ALU_PREOP1_14_port, 
                           Y(13) => ALU_PREOP1_13_port, Y(12) => 
                           ALU_PREOP1_12_port, Y(11) => ALU_PREOP1_11_port, 
                           Y(10) => ALU_PREOP1_10_port, Y(9) => 
                           ALU_PREOP1_9_port, Y(8) => ALU_PREOP1_8_port, Y(7) 
                           => ALU_PREOP1_7_port, Y(6) => ALU_PREOP1_6_port, 
                           Y(5) => ALU_PREOP1_5_port, Y(4) => ALU_PREOP1_4_port
                           , Y(3) => ALU_PREOP1_3_port, Y(2) => 
                           ALU_PREOP1_2_port, Y(1) => ALU_PREOP1_1_port, Y(0) 
                           => ALU_PREOP1_0_port);
   ALU_PRE_MUX2 : MUX41_N32_1 port map( A(31) => ID_EX_RF_OUT2_31_port, A(30) 
                           => ID_EX_RF_OUT2_30_port, A(29) => 
                           ID_EX_RF_OUT2_29_port, A(28) => 
                           ID_EX_RF_OUT2_28_port, A(27) => 
                           ID_EX_RF_OUT2_27_port, A(26) => 
                           ID_EX_RF_OUT2_26_port, A(25) => 
                           ID_EX_RF_OUT2_25_port, A(24) => 
                           ID_EX_RF_OUT2_24_port, A(23) => 
                           ID_EX_RF_OUT2_23_port, A(22) => 
                           ID_EX_RF_OUT2_22_port, A(21) => 
                           ID_EX_RF_OUT2_21_port, A(20) => 
                           ID_EX_RF_OUT2_20_port, A(19) => 
                           ID_EX_RF_OUT2_19_port, A(18) => 
                           ID_EX_RF_OUT2_18_port, A(17) => 
                           ID_EX_RF_OUT2_17_port, A(16) => 
                           ID_EX_RF_OUT2_16_port, A(15) => 
                           ID_EX_RF_OUT2_15_port, A(14) => 
                           ID_EX_RF_OUT2_14_port, A(13) => 
                           ID_EX_RF_OUT2_13_port, A(12) => 
                           ID_EX_RF_OUT2_12_port, A(11) => 
                           ID_EX_RF_OUT2_11_port, A(10) => 
                           ID_EX_RF_OUT2_10_port, A(9) => ID_EX_RF_OUT2_9_port,
                           A(8) => ID_EX_RF_OUT2_8_port, A(7) => 
                           ID_EX_RF_OUT2_7_port, A(6) => ID_EX_RF_OUT2_6_port, 
                           A(5) => ID_EX_RF_OUT2_5_port, A(4) => 
                           ID_EX_RF_OUT2_4_port, A(3) => ID_EX_RF_OUT2_3_port, 
                           A(2) => ID_EX_RF_OUT2_2_port, A(1) => 
                           ID_EX_RF_OUT2_1_port, A(0) => ID_EX_RF_OUT2_0_port, 
                           B(31) => ALU_OUT_31_port, B(30) => ALU_OUT_30_port, 
                           B(29) => ALU_OUT_29_port, B(28) => ALU_OUT_28_port, 
                           B(27) => ALU_OUT_27_port, B(26) => ALU_OUT_26_port, 
                           B(25) => ALU_OUT_25_port, B(24) => ALU_OUT_24_port, 
                           B(23) => ALU_OUT_23_port, B(22) => ALU_OUT_22_port, 
                           B(21) => ALU_OUT_21_port, B(20) => ALU_OUT_20_port, 
                           B(19) => ALU_OUT_19_port, B(18) => ALU_OUT_18_port, 
                           B(17) => ALU_OUT_17_port, B(16) => ALU_OUT_16_port, 
                           B(15) => ALU_OUT_15_port, B(14) => ALU_OUT_14_port, 
                           B(13) => ALU_OUT_13_port, B(12) => ALU_OUT_12_port, 
                           B(11) => ALU_OUT_11_port, B(10) => ALU_OUT_10_port, 
                           B(9) => ALU_OUT_9_port, B(8) => ALU_OUT_8_port, B(7)
                           => ALU_OUT_7_port, B(6) => ALU_OUT_6_port, B(5) => 
                           ALU_OUT_5_port, B(4) => ALU_OUT_4_port, B(3) => 
                           ALU_OUT_3_port, B(2) => ALU_OUT_2_port, B(1) => 
                           ALU_OUT_1_port, B(0) => ALU_OUT_0_port, C(31) => 
                           ID_EX_RF_DATAIN_NEXT_31_port, C(30) => 
                           ID_EX_RF_DATAIN_NEXT_30_port, C(29) => 
                           ID_EX_RF_DATAIN_NEXT_29_port, C(28) => 
                           ID_EX_RF_DATAIN_NEXT_28_port, C(27) => 
                           ID_EX_RF_DATAIN_NEXT_27_port, C(26) => 
                           ID_EX_RF_DATAIN_NEXT_26_port, C(25) => 
                           ID_EX_RF_DATAIN_NEXT_25_port, C(24) => 
                           ID_EX_RF_DATAIN_NEXT_24_port, C(23) => 
                           ID_EX_RF_DATAIN_NEXT_23_port, C(22) => 
                           ID_EX_RF_DATAIN_NEXT_22_port, C(21) => 
                           ID_EX_RF_DATAIN_NEXT_21_port, C(20) => 
                           ID_EX_RF_DATAIN_NEXT_20_port, C(19) => 
                           ID_EX_RF_DATAIN_NEXT_19_port, C(18) => 
                           ID_EX_RF_DATAIN_NEXT_18_port, C(17) => 
                           ID_EX_RF_DATAIN_NEXT_17_port, C(16) => 
                           ID_EX_RF_DATAIN_NEXT_16_port, C(15) => 
                           ID_EX_RF_DATAIN_NEXT_15_port, C(14) => 
                           ID_EX_RF_DATAIN_NEXT_14_port, C(13) => 
                           ID_EX_RF_DATAIN_NEXT_13_port, C(12) => 
                           ID_EX_RF_DATAIN_NEXT_12_port, C(11) => 
                           ID_EX_RF_DATAIN_NEXT_11_port, C(10) => 
                           ID_EX_RF_DATAIN_NEXT_10_port, C(9) => 
                           ID_EX_RF_DATAIN_NEXT_9_port, C(8) => 
                           ID_EX_RF_DATAIN_NEXT_8_port, C(7) => 
                           ID_EX_RF_DATAIN_NEXT_7_port, C(6) => 
                           ID_EX_RF_DATAIN_NEXT_6_port, C(5) => 
                           ID_EX_RF_DATAIN_NEXT_5_port, C(4) => 
                           ID_EX_RF_DATAIN_NEXT_4_port, C(3) => 
                           ID_EX_RF_DATAIN_NEXT_3_port, C(2) => 
                           ID_EX_RF_DATAIN_NEXT_2_port, C(1) => 
                           ID_EX_RF_DATAIN_NEXT_1_port, C(0) => 
                           ID_EX_RF_DATAIN_NEXT_0_port, D(31) => n200_port, 
                           D(30) => n200_port, D(29) => n200_port, D(28) => 
                           n200_port, D(27) => n200_port, D(26) => n200_port, 
                           D(25) => n200_port, D(24) => n200_port, D(23) => 
                           n200_port, D(22) => n200_port, D(21) => n200_port, 
                           D(20) => n200_port, D(19) => n200_port, D(18) => 
                           n200_port, D(17) => n200_port, D(16) => n200_port, 
                           D(15) => n200_port, D(14) => n200_port, D(13) => 
                           n200_port, D(12) => n200_port, D(11) => n200_port, 
                           D(10) => n200_port, D(9) => n200_port, D(8) => 
                           n200_port, D(7) => n200_port, D(6) => n200_port, 
                           D(5) => n200_port, D(4) => n200_port, D(3) => 
                           n200_port, D(2) => n200_port, D(1) => n200_port, 
                           D(0) => n200_port, S(1) => FORWARD_B_1_port, S(0) =>
                           FORWARD_B_0_port, Y(31) => ALU_PREOP2_31_port, Y(30)
                           => ALU_PREOP2_30_port, Y(29) => ALU_PREOP2_29_port, 
                           Y(28) => ALU_PREOP2_28_port, Y(27) => 
                           ALU_PREOP2_27_port, Y(26) => ALU_PREOP2_26_port, 
                           Y(25) => ALU_PREOP2_25_port, Y(24) => 
                           ALU_PREOP2_24_port, Y(23) => ALU_PREOP2_23_port, 
                           Y(22) => ALU_PREOP2_22_port, Y(21) => 
                           ALU_PREOP2_21_port, Y(20) => ALU_PREOP2_20_port, 
                           Y(19) => ALU_PREOP2_19_port, Y(18) => 
                           ALU_PREOP2_18_port, Y(17) => ALU_PREOP2_17_port, 
                           Y(16) => ALU_PREOP2_16_port, Y(15) => 
                           ALU_PREOP2_15_port, Y(14) => ALU_PREOP2_14_port, 
                           Y(13) => ALU_PREOP2_13_port, Y(12) => 
                           ALU_PREOP2_12_port, Y(11) => ALU_PREOP2_11_port, 
                           Y(10) => ALU_PREOP2_10_port, Y(9) => 
                           ALU_PREOP2_9_port, Y(8) => ALU_PREOP2_8_port, Y(7) 
                           => ALU_PREOP2_7_port, Y(6) => ALU_PREOP2_6_port, 
                           Y(5) => ALU_PREOP2_5_port, Y(4) => ALU_PREOP2_4_port
                           , Y(3) => ALU_PREOP2_3_port, Y(2) => 
                           ALU_PREOP2_2_port, Y(1) => ALU_PREOP2_1_port, Y(0) 
                           => ALU_PREOP2_0_port);
   ALU_MUX1 : MUX21_N32_3 port map( A(31) => ALU_PREOP1_31_port, A(30) => 
                           ALU_PREOP1_30_port, A(29) => ALU_PREOP1_29_port, 
                           A(28) => ALU_PREOP1_28_port, A(27) => 
                           ALU_PREOP1_27_port, A(26) => ALU_PREOP1_26_port, 
                           A(25) => ALU_PREOP1_25_port, A(24) => 
                           ALU_PREOP1_24_port, A(23) => ALU_PREOP1_23_port, 
                           A(22) => ALU_PREOP1_22_port, A(21) => 
                           ALU_PREOP1_21_port, A(20) => ALU_PREOP1_20_port, 
                           A(19) => ALU_PREOP1_19_port, A(18) => 
                           ALU_PREOP1_18_port, A(17) => ALU_PREOP1_17_port, 
                           A(16) => ALU_PREOP1_16_port, A(15) => 
                           ALU_PREOP1_15_port, A(14) => ALU_PREOP1_14_port, 
                           A(13) => ALU_PREOP1_13_port, A(12) => 
                           ALU_PREOP1_12_port, A(11) => ALU_PREOP1_11_port, 
                           A(10) => ALU_PREOP1_10_port, A(9) => 
                           ALU_PREOP1_9_port, A(8) => ALU_PREOP1_8_port, A(7) 
                           => ALU_PREOP1_7_port, A(6) => ALU_PREOP1_6_port, 
                           A(5) => ALU_PREOP1_5_port, A(4) => ALU_PREOP1_4_port
                           , A(3) => ALU_PREOP1_3_port, A(2) => 
                           ALU_PREOP1_2_port, A(1) => ALU_PREOP1_1_port, A(0) 
                           => ALU_PREOP1_0_port, B(31) => ID_EX_NPC_31_port, 
                           B(30) => ID_EX_NPC_30_port, B(29) => 
                           ID_EX_NPC_29_port, B(28) => ID_EX_NPC_28_port, B(27)
                           => ID_EX_NPC_27_port, B(26) => ID_EX_NPC_26_port, 
                           B(25) => ID_EX_NPC_25_port, B(24) => 
                           ID_EX_NPC_24_port, B(23) => ID_EX_NPC_23_port, B(22)
                           => ID_EX_NPC_22_port, B(21) => ID_EX_NPC_21_port, 
                           B(20) => ID_EX_NPC_20_port, B(19) => 
                           ID_EX_NPC_19_port, B(18) => ID_EX_NPC_18_port, B(17)
                           => ID_EX_NPC_17_port, B(16) => ID_EX_NPC_16_port, 
                           B(15) => ID_EX_NPC_15_port, B(14) => 
                           ID_EX_NPC_14_port, B(13) => ID_EX_NPC_13_port, B(12)
                           => ID_EX_NPC_12_port, B(11) => ID_EX_NPC_11_port, 
                           B(10) => ID_EX_NPC_10_port, B(9) => ID_EX_NPC_9_port
                           , B(8) => ID_EX_NPC_8_port, B(7) => ID_EX_NPC_7_port
                           , B(6) => ID_EX_NPC_6_port, B(5) => ID_EX_NPC_5_port
                           , B(4) => ID_EX_NPC_4_port, B(3) => ID_EX_NPC_3_port
                           , B(2) => ID_EX_NPC_2_port, B(1) => ID_EX_NPC_1_port
                           , B(0) => ID_EX_NPC_0_port, S => MUXA_SEL, Y(31) => 
                           ALU_OP1_31_port, Y(30) => ALU_OP1_30_port, Y(29) => 
                           ALU_OP1_29_port, Y(28) => ALU_OP1_28_port, Y(27) => 
                           ALU_OP1_27_port, Y(26) => ALU_OP1_26_port, Y(25) => 
                           ALU_OP1_25_port, Y(24) => ALU_OP1_24_port, Y(23) => 
                           ALU_OP1_23_port, Y(22) => ALU_OP1_22_port, Y(21) => 
                           ALU_OP1_21_port, Y(20) => ALU_OP1_20_port, Y(19) => 
                           ALU_OP1_19_port, Y(18) => ALU_OP1_18_port, Y(17) => 
                           ALU_OP1_17_port, Y(16) => ALU_OP1_16_port, Y(15) => 
                           ALU_OP1_15_port, Y(14) => ALU_OP1_14_port, Y(13) => 
                           ALU_OP1_13_port, Y(12) => ALU_OP1_12_port, Y(11) => 
                           ALU_OP1_11_port, Y(10) => ALU_OP1_10_port, Y(9) => 
                           ALU_OP1_9_port, Y(8) => ALU_OP1_8_port, Y(7) => 
                           ALU_OP1_7_port, Y(6) => ALU_OP1_6_port, Y(5) => 
                           ALU_OP1_5_port, Y(4) => ALU_OP1_4_port, Y(3) => 
                           ALU_OP1_3_port, Y(2) => ALU_OP1_2_port, Y(1) => 
                           ALU_OP1_1_port, Y(0) => ALU_OP1_0_port);
   ALU_MUX2 : MUX21_N32_2 port map( A(31) => ALU_PREOP2_31_port, A(30) => 
                           ALU_PREOP2_30_port, A(29) => ALU_PREOP2_29_port, 
                           A(28) => ALU_PREOP2_28_port, A(27) => 
                           ALU_PREOP2_27_port, A(26) => ALU_PREOP2_26_port, 
                           A(25) => ALU_PREOP2_25_port, A(24) => 
                           ALU_PREOP2_24_port, A(23) => ALU_PREOP2_23_port, 
                           A(22) => ALU_PREOP2_22_port, A(21) => 
                           ALU_PREOP2_21_port, A(20) => ALU_PREOP2_20_port, 
                           A(19) => ALU_PREOP2_19_port, A(18) => 
                           ALU_PREOP2_18_port, A(17) => ALU_PREOP2_17_port, 
                           A(16) => ALU_PREOP2_16_port, A(15) => 
                           ALU_PREOP2_15_port, A(14) => ALU_PREOP2_14_port, 
                           A(13) => ALU_PREOP2_13_port, A(12) => 
                           ALU_PREOP2_12_port, A(11) => ALU_PREOP2_11_port, 
                           A(10) => ALU_PREOP2_10_port, A(9) => 
                           ALU_PREOP2_9_port, A(8) => ALU_PREOP2_8_port, A(7) 
                           => ALU_PREOP2_7_port, A(6) => ALU_PREOP2_6_port, 
                           A(5) => ALU_PREOP2_5_port, A(4) => ALU_PREOP2_4_port
                           , A(3) => ALU_PREOP2_3_port, A(2) => 
                           ALU_PREOP2_2_port, A(1) => ALU_PREOP2_1_port, A(0) 
                           => ALU_PREOP2_0_port, B(31) => ID_EX_IMM_31_port, 
                           B(30) => ID_EX_IMM_30_port, B(29) => 
                           ID_EX_IMM_29_port, B(28) => ID_EX_IMM_28_port, B(27)
                           => ID_EX_IMM_27_port, B(26) => ID_EX_IMM_26_port, 
                           B(25) => ID_EX_IMM_25_port, B(24) => 
                           ID_EX_IMM_24_port, B(23) => ID_EX_IMM_23_port, B(22)
                           => ID_EX_IMM_22_port, B(21) => ID_EX_IMM_21_port, 
                           B(20) => ID_EX_IMM_20_port, B(19) => 
                           ID_EX_IMM_19_port, B(18) => ID_EX_IMM_18_port, B(17)
                           => ID_EX_IMM_17_port, B(16) => ID_EX_IMM_16_port, 
                           B(15) => ID_EX_IMM_15_port, B(14) => 
                           ID_EX_IMM_14_port, B(13) => ID_EX_IMM_13_port, B(12)
                           => ID_EX_IMM_12_port, B(11) => ID_EX_IMM_11_port, 
                           B(10) => ID_EX_IMM_10_port, B(9) => ID_EX_IMM_9_port
                           , B(8) => ID_EX_IMM_8_port, B(7) => ID_EX_IMM_7_port
                           , B(6) => ID_EX_IMM_6_port, B(5) => ID_EX_IMM_5_port
                           , B(4) => ID_EX_IMM_4_port, B(3) => ID_EX_IMM_3_port
                           , B(2) => ID_EX_IMM_2_port, B(1) => ID_EX_IMM_1_port
                           , B(0) => ID_EX_IMM_0_port, S => MUXB_SEL, Y(31) => 
                           ALU_OP2_31_port, Y(30) => ALU_OP2_30_port, Y(29) => 
                           ALU_OP2_29_port, Y(28) => ALU_OP2_28_port, Y(27) => 
                           ALU_OP2_27_port, Y(26) => ALU_OP2_26_port, Y(25) => 
                           ALU_OP2_25_port, Y(24) => ALU_OP2_24_port, Y(23) => 
                           ALU_OP2_23_port, Y(22) => ALU_OP2_22_port, Y(21) => 
                           ALU_OP2_21_port, Y(20) => ALU_OP2_20_port, Y(19) => 
                           ALU_OP2_19_port, Y(18) => ALU_OP2_18_port, Y(17) => 
                           ALU_OP2_17_port, Y(16) => ALU_OP2_16_port, Y(15) => 
                           ALU_OP2_15_port, Y(14) => ALU_OP2_14_port, Y(13) => 
                           ALU_OP2_13_port, Y(12) => ALU_OP2_12_port, Y(11) => 
                           ALU_OP2_11_port, Y(10) => ALU_OP2_10_port, Y(9) => 
                           ALU_OP2_9_port, Y(8) => ALU_OP2_8_port, Y(7) => 
                           ALU_OP2_7_port, Y(6) => ALU_OP2_6_port, Y(5) => 
                           ALU_OP2_5_port, Y(4) => ALU_OP2_4_port, Y(3) => 
                           ALU_OP2_3_port, Y(2) => ALU_OP2_2_port, Y(1) => 
                           ALU_OP2_1_port, Y(0) => ALU_OP2_0_port);
   ARITHMETIC_LOGIC_UNIT : ALU_N32_NB8 port map( OP1(31) => ALU_OP1_31_port, 
                           OP1(30) => ALU_OP1_30_port, OP1(29) => 
                           ALU_OP1_29_port, OP1(28) => ALU_OP1_28_port, OP1(27)
                           => ALU_OP1_27_port, OP1(26) => ALU_OP1_26_port, 
                           OP1(25) => ALU_OP1_25_port, OP1(24) => 
                           ALU_OP1_24_port, OP1(23) => ALU_OP1_23_port, OP1(22)
                           => ALU_OP1_22_port, OP1(21) => ALU_OP1_21_port, 
                           OP1(20) => ALU_OP1_20_port, OP1(19) => 
                           ALU_OP1_19_port, OP1(18) => ALU_OP1_18_port, OP1(17)
                           => ALU_OP1_17_port, OP1(16) => ALU_OP1_16_port, 
                           OP1(15) => ALU_OP1_15_port, OP1(14) => 
                           ALU_OP1_14_port, OP1(13) => ALU_OP1_13_port, OP1(12)
                           => ALU_OP1_12_port, OP1(11) => ALU_OP1_11_port, 
                           OP1(10) => ALU_OP1_10_port, OP1(9) => ALU_OP1_9_port
                           , OP1(8) => ALU_OP1_8_port, OP1(7) => ALU_OP1_7_port
                           , OP1(6) => ALU_OP1_6_port, OP1(5) => ALU_OP1_5_port
                           , OP1(4) => ALU_OP1_4_port, OP1(3) => ALU_OP1_3_port
                           , OP1(2) => ALU_OP1_2_port, OP1(1) => ALU_OP1_1_port
                           , OP1(0) => ALU_OP1_0_port, OP2(31) => 
                           ALU_OP2_31_port, OP2(30) => ALU_OP2_30_port, OP2(29)
                           => ALU_OP2_29_port, OP2(28) => ALU_OP2_28_port, 
                           OP2(27) => ALU_OP2_27_port, OP2(26) => 
                           ALU_OP2_26_port, OP2(25) => ALU_OP2_25_port, OP2(24)
                           => ALU_OP2_24_port, OP2(23) => ALU_OP2_23_port, 
                           OP2(22) => ALU_OP2_22_port, OP2(21) => 
                           ALU_OP2_21_port, OP2(20) => ALU_OP2_20_port, OP2(19)
                           => ALU_OP2_19_port, OP2(18) => ALU_OP2_18_port, 
                           OP2(17) => ALU_OP2_17_port, OP2(16) => 
                           ALU_OP2_16_port, OP2(15) => ALU_OP2_15_port, OP2(14)
                           => ALU_OP2_14_port, OP2(13) => ALU_OP2_13_port, 
                           OP2(12) => ALU_OP2_12_port, OP2(11) => 
                           ALU_OP2_11_port, OP2(10) => ALU_OP2_10_port, OP2(9) 
                           => ALU_OP2_9_port, OP2(8) => ALU_OP2_8_port, OP2(7) 
                           => ALU_OP2_7_port, OP2(6) => ALU_OP2_6_port, OP2(5) 
                           => ALU_OP2_5_port, OP2(4) => ALU_OP2_4_port, OP2(3) 
                           => ALU_OP2_3_port, OP2(2) => ALU_OP2_2_port, OP2(1) 
                           => ALU_OP2_1_port, OP2(0) => ALU_OP2_0_port, OPC(0) 
                           => ALU_OPCODE(0), OPC(1) => ALU_OPCODE(1), OPC(2) =>
                           ALU_OPCODE(2), OPC(3) => ALU_OPCODE(3), OPC(4) => 
                           ALU_OPCODE(4), OPC(5) => ALU_OPCODE(5), OPC(6) => 
                           ALU_OPCODE(6), Y(31) => ALU_OUTPUT_31_port, Y(30) =>
                           ALU_OUTPUT_30_port, Y(29) => ALU_OUTPUT_29_port, 
                           Y(28) => ALU_OUTPUT_28_port, Y(27) => 
                           ALU_OUTPUT_27_port, Y(26) => ALU_OUTPUT_26_port, 
                           Y(25) => ALU_OUTPUT_25_port, Y(24) => 
                           ALU_OUTPUT_24_port, Y(23) => ALU_OUTPUT_23_port, 
                           Y(22) => ALU_OUTPUT_22_port, Y(21) => 
                           ALU_OUTPUT_21_port, Y(20) => ALU_OUTPUT_20_port, 
                           Y(19) => ALU_OUTPUT_19_port, Y(18) => 
                           ALU_OUTPUT_18_port, Y(17) => ALU_OUTPUT_17_port, 
                           Y(16) => ALU_OUTPUT_16_port, Y(15) => 
                           ALU_OUTPUT_15_port, Y(14) => ALU_OUTPUT_14_port, 
                           Y(13) => ALU_OUTPUT_13_port, Y(12) => 
                           ALU_OUTPUT_12_port, Y(11) => ALU_OUTPUT_11_port, 
                           Y(10) => ALU_OUTPUT_10_port, Y(9) => 
                           ALU_OUTPUT_9_port, Y(8) => ALU_OUTPUT_8_port, Y(7) 
                           => ALU_OUTPUT_7_port, Y(6) => ALU_OUTPUT_6_port, 
                           Y(5) => ALU_OUTPUT_5_port, Y(4) => ALU_OUTPUT_4_port
                           , Y(3) => ALU_OUTPUT_3_port, Y(2) => 
                           ALU_OUTPUT_2_port, Y(1) => ALU_OUTPUT_1_port, Y(0) 
                           => ALU_OUTPUT_0_port, Z => n_1536);
   ZERO_DETECTOR : ZERODET_N32 port map( A(31) => ALU_PREOP1_31_port, A(30) => 
                           ALU_PREOP1_30_port, A(29) => ALU_PREOP1_29_port, 
                           A(28) => ALU_PREOP1_28_port, A(27) => 
                           ALU_PREOP1_27_port, A(26) => ALU_PREOP1_26_port, 
                           A(25) => ALU_PREOP1_25_port, A(24) => 
                           ALU_PREOP1_24_port, A(23) => ALU_PREOP1_23_port, 
                           A(22) => ALU_PREOP1_22_port, A(21) => 
                           ALU_PREOP1_21_port, A(20) => ALU_PREOP1_20_port, 
                           A(19) => ALU_PREOP1_19_port, A(18) => 
                           ALU_PREOP1_18_port, A(17) => ALU_PREOP1_17_port, 
                           A(16) => ALU_PREOP1_16_port, A(15) => 
                           ALU_PREOP1_15_port, A(14) => ALU_PREOP1_14_port, 
                           A(13) => ALU_PREOP1_13_port, A(12) => 
                           ALU_PREOP1_12_port, A(11) => ALU_PREOP1_11_port, 
                           A(10) => ALU_PREOP1_10_port, A(9) => 
                           ALU_PREOP1_9_port, A(8) => ALU_PREOP1_8_port, A(7) 
                           => ALU_PREOP1_7_port, A(6) => ALU_PREOP1_6_port, 
                           A(5) => ALU_PREOP1_5_port, A(4) => ALU_PREOP1_4_port
                           , A(3) => ALU_PREOP1_3_port, A(2) => 
                           ALU_PREOP1_2_port, A(1) => ALU_PREOP1_1_port, A(0) 
                           => ALU_PREOP1_0_port, Y => ZERO_OUT);
   FORWARDING_UNIT : FU_N5 port map( RS1(4) => ID_EX_RS1_4_port, RS1(3) => 
                           ID_EX_RS1_3_port, RS1(2) => ID_EX_RS1_2_port, RS1(1)
                           => ID_EX_RS1_1_port, RS1(0) => ID_EX_RS1_0_port, 
                           RS2(4) => ID_EX_RS2_4_port, RS2(3) => 
                           ID_EX_RS2_3_port, RS2(2) => ID_EX_RS2_2_port, RS2(1)
                           => ID_EX_RS2_1_port, RS2(0) => ID_EX_RS2_0_port, 
                           RD_MEM(4) => EX_MEM_RD_4_port, RD_MEM(3) => 
                           EX_MEM_RD_3_port, RD_MEM(2) => EX_MEM_RD_2_port, 
                           RD_MEM(1) => EX_MEM_RD_1_port, RD_MEM(0) => 
                           EX_MEM_RD_0_port, RD_WB(4) => MEM_WB_RD_4_port, 
                           RD_WB(3) => MEM_WB_RD_3_port, RD_WB(2) => 
                           MEM_WB_RD_2_port, RD_WB(1) => MEM_WB_RD_1_port, 
                           RD_WB(0) => MEM_WB_RD_0_port, RF_WE_MEM => 
                           EX_MEM_RF_WE, RF_WE_WB => MEM_WB_RF_WE, FORWARD_A(1)
                           => FORWARD_A_1_port, FORWARD_A(0) => 
                           FORWARD_A_0_port, FORWARD_B(1) => FORWARD_B_1_port, 
                           FORWARD_B(0) => FORWARD_B_0_port);
   LATCH_ALUOUT : LDR_N32_2 port map( RST => RST, EN => ALU_OUTREG_EN, 
                           REGIN(31) => ALU_OUTPUT_31_port, REGIN(30) => 
                           ALU_OUTPUT_30_port, REGIN(29) => ALU_OUTPUT_29_port,
                           REGIN(28) => ALU_OUTPUT_28_port, REGIN(27) => 
                           ALU_OUTPUT_27_port, REGIN(26) => ALU_OUTPUT_26_port,
                           REGIN(25) => ALU_OUTPUT_25_port, REGIN(24) => 
                           ALU_OUTPUT_24_port, REGIN(23) => ALU_OUTPUT_23_port,
                           REGIN(22) => ALU_OUTPUT_22_port, REGIN(21) => 
                           ALU_OUTPUT_21_port, REGIN(20) => ALU_OUTPUT_20_port,
                           REGIN(19) => ALU_OUTPUT_19_port, REGIN(18) => 
                           ALU_OUTPUT_18_port, REGIN(17) => ALU_OUTPUT_17_port,
                           REGIN(16) => ALU_OUTPUT_16_port, REGIN(15) => 
                           ALU_OUTPUT_15_port, REGIN(14) => ALU_OUTPUT_14_port,
                           REGIN(13) => ALU_OUTPUT_13_port, REGIN(12) => 
                           ALU_OUTPUT_12_port, REGIN(11) => ALU_OUTPUT_11_port,
                           REGIN(10) => ALU_OUTPUT_10_port, REGIN(9) => 
                           ALU_OUTPUT_9_port, REGIN(8) => ALU_OUTPUT_8_port, 
                           REGIN(7) => ALU_OUTPUT_7_port, REGIN(6) => 
                           ALU_OUTPUT_6_port, REGIN(5) => ALU_OUTPUT_5_port, 
                           REGIN(4) => ALU_OUTPUT_4_port, REGIN(3) => 
                           ALU_OUTPUT_3_port, REGIN(2) => ALU_OUTPUT_2_port, 
                           REGIN(1) => ALU_OUTPUT_1_port, REGIN(0) => 
                           ALU_OUTPUT_0_port, REGOUT(31) => 
                           EX_MEM_ALU_OUTPUT_NEXT_31_port, REGOUT(30) => 
                           EX_MEM_ALU_OUTPUT_NEXT_30_port, REGOUT(29) => 
                           EX_MEM_ALU_OUTPUT_NEXT_29_port, REGOUT(28) => 
                           EX_MEM_ALU_OUTPUT_NEXT_28_port, REGOUT(27) => 
                           EX_MEM_ALU_OUTPUT_NEXT_27_port, REGOUT(26) => 
                           EX_MEM_ALU_OUTPUT_NEXT_26_port, REGOUT(25) => 
                           EX_MEM_ALU_OUTPUT_NEXT_25_port, REGOUT(24) => 
                           EX_MEM_ALU_OUTPUT_NEXT_24_port, REGOUT(23) => 
                           EX_MEM_ALU_OUTPUT_NEXT_23_port, REGOUT(22) => 
                           EX_MEM_ALU_OUTPUT_NEXT_22_port, REGOUT(21) => 
                           EX_MEM_ALU_OUTPUT_NEXT_21_port, REGOUT(20) => 
                           EX_MEM_ALU_OUTPUT_NEXT_20_port, REGOUT(19) => 
                           EX_MEM_ALU_OUTPUT_NEXT_19_port, REGOUT(18) => 
                           EX_MEM_ALU_OUTPUT_NEXT_18_port, REGOUT(17) => 
                           EX_MEM_ALU_OUTPUT_NEXT_17_port, REGOUT(16) => 
                           EX_MEM_ALU_OUTPUT_NEXT_16_port, REGOUT(15) => 
                           EX_MEM_ALU_OUTPUT_NEXT_15_port, REGOUT(14) => 
                           EX_MEM_ALU_OUTPUT_NEXT_14_port, REGOUT(13) => 
                           EX_MEM_ALU_OUTPUT_NEXT_13_port, REGOUT(12) => 
                           EX_MEM_ALU_OUTPUT_NEXT_12_port, REGOUT(11) => 
                           EX_MEM_ALU_OUTPUT_NEXT_11_port, REGOUT(10) => 
                           EX_MEM_ALU_OUTPUT_NEXT_10_port, REGOUT(9) => 
                           EX_MEM_ALU_OUTPUT_NEXT_9_port, REGOUT(8) => 
                           EX_MEM_ALU_OUTPUT_NEXT_8_port, REGOUT(7) => 
                           EX_MEM_ALU_OUTPUT_NEXT_7_port, REGOUT(6) => 
                           EX_MEM_ALU_OUTPUT_NEXT_6_port, REGOUT(5) => 
                           EX_MEM_ALU_OUTPUT_NEXT_5_port, REGOUT(4) => 
                           EX_MEM_ALU_OUTPUT_NEXT_4_port, REGOUT(3) => 
                           EX_MEM_ALU_OUTPUT_NEXT_3_port, REGOUT(2) => 
                           EX_MEM_ALU_OUTPUT_NEXT_2_port, REGOUT(1) => 
                           EX_MEM_ALU_OUTPUT_NEXT_1_port, REGOUT(0) => 
                           EX_MEM_ALU_OUTPUT_NEXT_0_port);
   LATCH_BRANCH : LD_0 port map( RST => RST, EN => ALU_OUTREG_EN, D => 
                           BRANCH_DETECT, Q => EX_MEM_BRANCH_DETECT_NEXT);
   LATCH_LMD : LDR_N32_1 port map( RST => RST, EN => LMD_LATCH_EN, REGIN(31) =>
                           DRAM_OUT(31), REGIN(30) => DRAM_OUT(30), REGIN(29) 
                           => DRAM_OUT(29), REGIN(28) => DRAM_OUT(28), 
                           REGIN(27) => DRAM_OUT(27), REGIN(26) => DRAM_OUT(26)
                           , REGIN(25) => DRAM_OUT(25), REGIN(24) => 
                           DRAM_OUT(24), REGIN(23) => DRAM_OUT(23), REGIN(22) 
                           => DRAM_OUT(22), REGIN(21) => DRAM_OUT(21), 
                           REGIN(20) => DRAM_OUT(20), REGIN(19) => DRAM_OUT(19)
                           , REGIN(18) => DRAM_OUT(18), REGIN(17) => 
                           DRAM_OUT(17), REGIN(16) => DRAM_OUT(16), REGIN(15) 
                           => DRAM_OUT(15), REGIN(14) => DRAM_OUT(14), 
                           REGIN(13) => DRAM_OUT(13), REGIN(12) => DRAM_OUT(12)
                           , REGIN(11) => DRAM_OUT(11), REGIN(10) => 
                           DRAM_OUT(10), REGIN(9) => DRAM_OUT(9), REGIN(8) => 
                           DRAM_OUT(8), REGIN(7) => DRAM_OUT(7), REGIN(6) => 
                           DRAM_OUT(6), REGIN(5) => DRAM_OUT(5), REGIN(4) => 
                           DRAM_OUT(4), REGIN(3) => DRAM_OUT(3), REGIN(2) => 
                           DRAM_OUT(2), REGIN(1) => DRAM_OUT(1), REGIN(0) => 
                           DRAM_OUT(0), REGOUT(31) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_31_port, REGOUT(30) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_30_port, REGOUT(29) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_29_port, REGOUT(28) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_28_port, REGOUT(27) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_27_port, REGOUT(26) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_26_port, REGOUT(25) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_25_port, REGOUT(24) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_24_port, REGOUT(23) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_23_port, REGOUT(22) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_22_port, REGOUT(21) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_21_port, REGOUT(20) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_20_port, REGOUT(19) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_19_port, REGOUT(18) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_18_port, REGOUT(17) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_17_port, REGOUT(16) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_16_port, REGOUT(15) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_15_port, REGOUT(14) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_14_port, REGOUT(13) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_13_port, REGOUT(12) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_12_port, REGOUT(11) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_11_port, REGOUT(10) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_10_port, REGOUT(9) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_9_port, REGOUT(8) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_8_port, REGOUT(7) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_7_port, REGOUT(6) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_6_port, REGOUT(5) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_5_port, REGOUT(4) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_4_port, REGOUT(3) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_3_port, REGOUT(2) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_2_port, REGOUT(1) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_1_port, REGOUT(0) => 
                           MEM_WB_DRAM_OUTPUT_NEXT_0_port);
   WB_MUX : MUX21_N32_1 port map( A(31) => MEM_WB_DRAM_OUTPUT_31_port, A(30) =>
                           MEM_WB_DRAM_OUTPUT_30_port, A(29) => 
                           MEM_WB_DRAM_OUTPUT_29_port, A(28) => 
                           MEM_WB_DRAM_OUTPUT_28_port, A(27) => 
                           MEM_WB_DRAM_OUTPUT_27_port, A(26) => 
                           MEM_WB_DRAM_OUTPUT_26_port, A(25) => 
                           MEM_WB_DRAM_OUTPUT_25_port, A(24) => 
                           MEM_WB_DRAM_OUTPUT_24_port, A(23) => 
                           MEM_WB_DRAM_OUTPUT_23_port, A(22) => 
                           MEM_WB_DRAM_OUTPUT_22_port, A(21) => 
                           MEM_WB_DRAM_OUTPUT_21_port, A(20) => 
                           MEM_WB_DRAM_OUTPUT_20_port, A(19) => 
                           MEM_WB_DRAM_OUTPUT_19_port, A(18) => 
                           MEM_WB_DRAM_OUTPUT_18_port, A(17) => 
                           MEM_WB_DRAM_OUTPUT_17_port, A(16) => 
                           MEM_WB_DRAM_OUTPUT_16_port, A(15) => 
                           MEM_WB_DRAM_OUTPUT_15_port, A(14) => 
                           MEM_WB_DRAM_OUTPUT_14_port, A(13) => 
                           MEM_WB_DRAM_OUTPUT_13_port, A(12) => 
                           MEM_WB_DRAM_OUTPUT_12_port, A(11) => 
                           MEM_WB_DRAM_OUTPUT_11_port, A(10) => 
                           MEM_WB_DRAM_OUTPUT_10_port, A(9) => 
                           MEM_WB_DRAM_OUTPUT_9_port, A(8) => 
                           MEM_WB_DRAM_OUTPUT_8_port, A(7) => 
                           MEM_WB_DRAM_OUTPUT_7_port, A(6) => 
                           MEM_WB_DRAM_OUTPUT_6_port, A(5) => 
                           MEM_WB_DRAM_OUTPUT_5_port, A(4) => 
                           MEM_WB_DRAM_OUTPUT_4_port, A(3) => 
                           MEM_WB_DRAM_OUTPUT_3_port, A(2) => 
                           MEM_WB_DRAM_OUTPUT_2_port, A(1) => 
                           MEM_WB_DRAM_OUTPUT_1_port, A(0) => 
                           MEM_WB_DRAM_OUTPUT_0_port, B(31) => 
                           MEM_WB_ALU_OUTPUT_31_port, B(30) => 
                           MEM_WB_ALU_OUTPUT_30_port, B(29) => 
                           MEM_WB_ALU_OUTPUT_29_port, B(28) => 
                           MEM_WB_ALU_OUTPUT_28_port, B(27) => 
                           MEM_WB_ALU_OUTPUT_27_port, B(26) => 
                           MEM_WB_ALU_OUTPUT_26_port, B(25) => 
                           MEM_WB_ALU_OUTPUT_25_port, B(24) => 
                           MEM_WB_ALU_OUTPUT_24_port, B(23) => 
                           MEM_WB_ALU_OUTPUT_23_port, B(22) => 
                           MEM_WB_ALU_OUTPUT_22_port, B(21) => 
                           MEM_WB_ALU_OUTPUT_21_port, B(20) => 
                           MEM_WB_ALU_OUTPUT_20_port, B(19) => 
                           MEM_WB_ALU_OUTPUT_19_port, B(18) => 
                           MEM_WB_ALU_OUTPUT_18_port, B(17) => 
                           MEM_WB_ALU_OUTPUT_17_port, B(16) => 
                           MEM_WB_ALU_OUTPUT_16_port, B(15) => 
                           MEM_WB_ALU_OUTPUT_15_port, B(14) => 
                           MEM_WB_ALU_OUTPUT_14_port, B(13) => 
                           MEM_WB_ALU_OUTPUT_13_port, B(12) => 
                           MEM_WB_ALU_OUTPUT_12_port, B(11) => 
                           MEM_WB_ALU_OUTPUT_11_port, B(10) => 
                           MEM_WB_ALU_OUTPUT_10_port, B(9) => 
                           MEM_WB_ALU_OUTPUT_9_port, B(8) => 
                           MEM_WB_ALU_OUTPUT_8_port, B(7) => 
                           MEM_WB_ALU_OUTPUT_7_port, B(6) => 
                           MEM_WB_ALU_OUTPUT_6_port, B(5) => 
                           MEM_WB_ALU_OUTPUT_5_port, B(4) => 
                           MEM_WB_ALU_OUTPUT_4_port, B(3) => 
                           MEM_WB_ALU_OUTPUT_3_port, B(2) => 
                           MEM_WB_ALU_OUTPUT_2_port, B(1) => 
                           MEM_WB_ALU_OUTPUT_1_port, B(0) => 
                           MEM_WB_ALU_OUTPUT_0_port, S => WB_MUX_SEL, Y(31) => 
                           ID_EX_RF_DATAIN_NEXT_31_port, Y(30) => 
                           ID_EX_RF_DATAIN_NEXT_30_port, Y(29) => 
                           ID_EX_RF_DATAIN_NEXT_29_port, Y(28) => 
                           ID_EX_RF_DATAIN_NEXT_28_port, Y(27) => 
                           ID_EX_RF_DATAIN_NEXT_27_port, Y(26) => 
                           ID_EX_RF_DATAIN_NEXT_26_port, Y(25) => 
                           ID_EX_RF_DATAIN_NEXT_25_port, Y(24) => 
                           ID_EX_RF_DATAIN_NEXT_24_port, Y(23) => 
                           ID_EX_RF_DATAIN_NEXT_23_port, Y(22) => 
                           ID_EX_RF_DATAIN_NEXT_22_port, Y(21) => 
                           ID_EX_RF_DATAIN_NEXT_21_port, Y(20) => 
                           ID_EX_RF_DATAIN_NEXT_20_port, Y(19) => 
                           ID_EX_RF_DATAIN_NEXT_19_port, Y(18) => 
                           ID_EX_RF_DATAIN_NEXT_18_port, Y(17) => 
                           ID_EX_RF_DATAIN_NEXT_17_port, Y(16) => 
                           ID_EX_RF_DATAIN_NEXT_16_port, Y(15) => 
                           ID_EX_RF_DATAIN_NEXT_15_port, Y(14) => 
                           ID_EX_RF_DATAIN_NEXT_14_port, Y(13) => 
                           ID_EX_RF_DATAIN_NEXT_13_port, Y(12) => 
                           ID_EX_RF_DATAIN_NEXT_12_port, Y(11) => 
                           ID_EX_RF_DATAIN_NEXT_11_port, Y(10) => 
                           ID_EX_RF_DATAIN_NEXT_10_port, Y(9) => 
                           ID_EX_RF_DATAIN_NEXT_9_port, Y(8) => 
                           ID_EX_RF_DATAIN_NEXT_8_port, Y(7) => 
                           ID_EX_RF_DATAIN_NEXT_7_port, Y(6) => 
                           ID_EX_RF_DATAIN_NEXT_6_port, Y(5) => 
                           ID_EX_RF_DATAIN_NEXT_5_port, Y(4) => 
                           ID_EX_RF_DATAIN_NEXT_4_port, Y(3) => 
                           ID_EX_RF_DATAIN_NEXT_3_port, Y(2) => 
                           ID_EX_RF_DATAIN_NEXT_2_port, Y(1) => 
                           ID_EX_RF_DATAIN_NEXT_1_port, Y(0) => 
                           ID_EX_RF_DATAIN_NEXT_0_port);
   add_646 : 
                           DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32_DW01_add_0 
                           port map( A(31) => PC_OUT_31_port, A(30) => 
                           PC_OUT_30_port, A(29) => PC_OUT_29_port, A(28) => 
                           PC_OUT_28_port, A(27) => PC_OUT_27_port, A(26) => 
                           PC_OUT_26_port, A(25) => PC_OUT_25_port, A(24) => 
                           PC_OUT_24_port, A(23) => PC_OUT_23_port, A(22) => 
                           PC_OUT_22_port, A(21) => PC_OUT_21_port, A(20) => 
                           PC_OUT_20_port, A(19) => PC_OUT_19_port, A(18) => 
                           PC_OUT_18_port, A(17) => PC_OUT_17_port, A(16) => 
                           PC_OUT_16_port, A(15) => PC_OUT_15_port, A(14) => 
                           PC_OUT_14_port, A(13) => PC_OUT_13_port, A(12) => 
                           PC_OUT_12_port, A(11) => PC_OUT_11_port, A(10) => 
                           PC_OUT_10_port, A(9) => PC_OUT_9_port, A(8) => 
                           PC_OUT_8_port, A(7) => PC_OUT_7_port, A(6) => 
                           PC_OUT_6_port, A(5) => PC_OUT_5_port, A(4) => 
                           PC_OUT_4_port, A(3) => PC_OUT_3_port, A(2) => 
                           PC_OUT_2_port, A(1) => PC_OUT_1_port, A(0) => 
                           PC_OUT_0_port, B(31) => n4_port, B(30) => n4_port, 
                           B(29) => n4_port, B(28) => n4_port, B(27) => n4_port
                           , B(26) => n4_port, B(25) => n4_port, B(24) => 
                           n4_port, B(23) => n4_port, B(22) => n4_port, B(21) 
                           => n4_port, B(20) => n4_port, B(19) => n4_port, 
                           B(18) => n4_port, B(17) => n4_port, B(16) => n4_port
                           , B(15) => n4_port, B(14) => n4_port, B(13) => 
                           n4_port, B(12) => n4_port, B(11) => n4_port, B(10) 
                           => n4_port, B(9) => n4_port, B(8) => n4_port, B(7) 
                           => n4_port, B(6) => n4_port, B(5) => n4_port, B(4) 
                           => n4_port, B(3) => n4_port, B(2) => n3, B(1) => n2,
                           B(0) => n2, CI => n4_port, SUM(31) => 
                           NPC_BUS_31_port, SUM(30) => NPC_BUS_30_port, SUM(29)
                           => NPC_BUS_29_port, SUM(28) => NPC_BUS_28_port, 
                           SUM(27) => NPC_BUS_27_port, SUM(26) => 
                           NPC_BUS_26_port, SUM(25) => NPC_BUS_25_port, SUM(24)
                           => NPC_BUS_24_port, SUM(23) => NPC_BUS_23_port, 
                           SUM(22) => NPC_BUS_22_port, SUM(21) => 
                           NPC_BUS_21_port, SUM(20) => NPC_BUS_20_port, SUM(19)
                           => NPC_BUS_19_port, SUM(18) => NPC_BUS_18_port, 
                           SUM(17) => NPC_BUS_17_port, SUM(16) => 
                           NPC_BUS_16_port, SUM(15) => NPC_BUS_15_port, SUM(14)
                           => NPC_BUS_14_port, SUM(13) => NPC_BUS_13_port, 
                           SUM(12) => NPC_BUS_12_port, SUM(11) => 
                           NPC_BUS_11_port, SUM(10) => NPC_BUS_10_port, SUM(9) 
                           => NPC_BUS_9_port, SUM(8) => NPC_BUS_8_port, SUM(7) 
                           => NPC_BUS_7_port, SUM(6) => NPC_BUS_6_port, SUM(5) 
                           => NPC_BUS_5_port, SUM(4) => NPC_BUS_4_port, SUM(3) 
                           => NPC_BUS_3_port, SUM(2) => NPC_BUS_2_port, SUM(1) 
                           => NPC_BUS_1_port, SUM(0) => NPC_BUS_0_port, CO => 
                           n_1537);
   U4 : BUF_X2 port map( A => n194_port, Z => n191_port);
   U7 : BUF_X1 port map( A => CLK, Z => n198_port);
   U8 : BUF_X8 port map( A => n198_port, Z => n195_port);
   U9 : BUF_X8 port map( A => n198_port, Z => n196_port);
   U10 : CLKBUF_X3 port map( A => n194_port, Z => n192_port);
   U11 : BUF_X2 port map( A => n198_port, Z => n197_port);
   U12 : BUF_X1 port map( A => n194_port, Z => n193_port);
   U13 : INV_X1 port map( A => RST, ZN => n194_port);
   U14 : INV_X1 port map( A => n199_port, ZN => n201_port);
   U15 : AOI21_X1 port map( B1 => JUMP_EN, B2 => EX_MEM_BRANCH_DETECT, A => 
                           JUMP_COND, ZN => n199_port);
   U16 : NOR2_X1 port map( A1 => n191_port, A2 => n10_port, ZN => N99);
   U17 : NOR2_X1 port map( A1 => n191_port, A2 => n11_port, ZN => N98);
   U18 : NOR2_X1 port map( A1 => n191_port, A2 => n12_port, ZN => N97);
   U19 : NOR2_X1 port map( A1 => n191_port, A2 => n13_port, ZN => N96);
   U20 : NOR2_X1 port map( A1 => n191_port, A2 => n14_port, ZN => N95);
   U21 : NOR2_X1 port map( A1 => n191_port, A2 => n15_port, ZN => N94);
   U22 : NOR2_X1 port map( A1 => n191_port, A2 => n16_port, ZN => N93);
   U23 : NOR2_X1 port map( A1 => n191_port, A2 => n17_port, ZN => N92);
   U24 : NOR2_X1 port map( A1 => n191_port, A2 => n18_port, ZN => N91);
   U25 : NOR2_X1 port map( A1 => n191_port, A2 => n19_port, ZN => N90);
   U26 : AND2_X1 port map( A1 => NPC_OUT_5_port, A2 => RST, ZN => N9);
   U27 : NOR2_X1 port map( A1 => n191_port, A2 => n20_port, ZN => N89);
   U28 : NOR2_X1 port map( A1 => n191_port, A2 => n21_port, ZN => N88);
   U29 : NOR2_X1 port map( A1 => n191_port, A2 => n22_port, ZN => N87);
   U30 : NOR2_X1 port map( A1 => n191_port, A2 => n23_port, ZN => N86);
   U31 : NOR2_X1 port map( A1 => n191_port, A2 => n24_port, ZN => N85);
   U32 : NOR2_X1 port map( A1 => n191_port, A2 => n25_port, ZN => N84);
   U33 : NOR2_X1 port map( A1 => n191_port, A2 => n26_port, ZN => N83);
   U34 : NOR2_X1 port map( A1 => n191_port, A2 => n27_port, ZN => N82);
   U35 : NOR2_X1 port map( A1 => n191_port, A2 => n28_port, ZN => N81);
   U36 : NOR2_X1 port map( A1 => n191_port, A2 => n29_port, ZN => N80);
   U37 : AND2_X1 port map( A1 => NPC_OUT_4_port, A2 => RST, ZN => N8);
   U38 : NOR2_X1 port map( A1 => n191_port, A2 => n30_port, ZN => N79);
   U39 : NOR2_X1 port map( A1 => n191_port, A2 => n31_port, ZN => N78);
   U40 : NOR2_X1 port map( A1 => n191_port, A2 => n32_port, ZN => N77);
   U41 : NOR2_X1 port map( A1 => n191_port, A2 => n33_port, ZN => N76);
   U42 : NOR2_X1 port map( A1 => n191_port, A2 => n34_port, ZN => N75);
   U43 : NOR2_X1 port map( A1 => n191_port, A2 => n35_port, ZN => N74);
   U44 : NOR2_X1 port map( A1 => n191_port, A2 => n36_port, ZN => N73);
   U45 : NOR2_X1 port map( A1 => n191_port, A2 => n37_port, ZN => N72);
   U46 : NOR2_X1 port map( A1 => n191_port, A2 => n38_port, ZN => N71);
   U47 : NOR2_X1 port map( A1 => n191_port, A2 => n39_port, ZN => N70);
   U48 : AND2_X1 port map( A1 => NPC_OUT_3_port, A2 => RST, ZN => N7);
   U49 : NOR2_X1 port map( A1 => n191_port, A2 => n40_port, ZN => N69);
   U50 : NOR2_X1 port map( A1 => n191_port, A2 => n41_port, ZN => N68);
   U51 : AND2_X1 port map( A1 => IR_OUT_31_port, A2 => RST, ZN => N67);
   U52 : AND2_X1 port map( A1 => IR_OUT_30_port, A2 => RST, ZN => N66);
   U53 : AND2_X1 port map( A1 => IR_OUT_29_port, A2 => RST, ZN => N65);
   U54 : AND2_X1 port map( A1 => IR_OUT_28_port, A2 => RST, ZN => N64);
   U55 : AND2_X1 port map( A1 => IR_OUT_27_port, A2 => RST, ZN => N63);
   U56 : AND2_X1 port map( A1 => IR_OUT_26_port, A2 => RST, ZN => N62);
   U57 : AND2_X1 port map( A1 => IR_OUT_25_port, A2 => RST, ZN => N61);
   U58 : AND2_X1 port map( A1 => IR_OUT_24_port, A2 => RST, ZN => N60);
   U59 : AND2_X1 port map( A1 => NPC_OUT_2_port, A2 => RST, ZN => N6);
   U60 : AND2_X1 port map( A1 => IR_OUT_23_port, A2 => RST, ZN => N59);
   U61 : AND2_X1 port map( A1 => IR_OUT_22_port, A2 => RST, ZN => N58);
   U62 : AND2_X1 port map( A1 => IR_OUT_21_port, A2 => RST, ZN => N57);
   U63 : AND2_X1 port map( A1 => IR_OUT_20_port, A2 => RST, ZN => N56);
   U64 : AND2_X1 port map( A1 => IR_OUT_19_port, A2 => RST, ZN => N55);
   U65 : AND2_X1 port map( A1 => IR_OUT_18_port, A2 => RST, ZN => N54);
   U66 : AND2_X1 port map( A1 => IR_OUT_17_port, A2 => RST, ZN => N53);
   U67 : AND2_X1 port map( A1 => IR_OUT_16_port, A2 => RST, ZN => N52);
   U68 : AND2_X1 port map( A1 => IR_OUT_15_port, A2 => RST, ZN => N51);
   U69 : AND2_X1 port map( A1 => IR_OUT_14_port, A2 => RST, ZN => N50);
   U70 : AND2_X1 port map( A1 => NPC_OUT_1_port, A2 => RST, ZN => N5);
   U71 : AND2_X1 port map( A1 => IR_OUT_13_port, A2 => RST, ZN => N49);
   U72 : AND2_X1 port map( A1 => IR_OUT_12_port, A2 => RST, ZN => N48);
   U73 : AND2_X1 port map( A1 => IR_OUT_11_port, A2 => RST, ZN => N47);
   U74 : AND2_X1 port map( A1 => IR_OUT_10_port, A2 => RST, ZN => N46);
   U75 : AND2_X1 port map( A1 => IR_OUT_9_port, A2 => RST, ZN => N45);
   U76 : AND2_X1 port map( A1 => IR_OUT_8_port, A2 => RST, ZN => N44);
   U77 : AND2_X1 port map( A1 => IR_OUT_7_port, A2 => RST, ZN => N43);
   U78 : AND2_X1 port map( A1 => IR_OUT_6_port, A2 => RST, ZN => N42);
   U79 : AND2_X1 port map( A1 => IR_OUT_5_port, A2 => RST, ZN => N41);
   U80 : AND2_X1 port map( A1 => IR_OUT_4_port, A2 => RST, ZN => N40);
   U81 : AND2_X1 port map( A1 => NPC_OUT_0_port, A2 => RST, ZN => N4);
   U82 : AND2_X1 port map( A1 => IR_OUT_3_port, A2 => RST, ZN => N39);
   U83 : AND2_X1 port map( A1 => IR_OUT_2_port, A2 => RST, ZN => N38);
   U84 : AND2_X1 port map( A1 => IR_OUT_1_port, A2 => RST, ZN => N37);
   U85 : AND2_X1 port map( A1 => IR_OUT_0_port, A2 => RST, ZN => N36);
   U86 : NOR2_X1 port map( A1 => n42_port, A2 => n191_port, ZN => N352);
   U87 : NOR2_X1 port map( A1 => n43_port, A2 => n192_port, ZN => N351);
   U88 : NOR2_X1 port map( A1 => n44_port, A2 => n192_port, ZN => N350);
   U89 : AND2_X1 port map( A1 => NPC_OUT_31_port, A2 => RST, ZN => N35);
   U90 : NOR2_X1 port map( A1 => n45_port, A2 => n192_port, ZN => N349);
   U91 : NOR2_X1 port map( A1 => n46_port, A2 => n192_port, ZN => N348);
   U92 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_31_port, A2 => RST, ZN
                           => N347);
   U93 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_30_port, A2 => RST, ZN
                           => N346);
   U94 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_29_port, A2 => RST, ZN
                           => N345);
   U95 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_28_port, A2 => RST, ZN
                           => N344);
   U96 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_27_port, A2 => RST, ZN
                           => N343);
   U97 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_26_port, A2 => RST, ZN
                           => N342);
   U98 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_25_port, A2 => RST, ZN
                           => N341);
   U99 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_24_port, A2 => RST, ZN
                           => N340);
   U100 : AND2_X1 port map( A1 => NPC_OUT_30_port, A2 => RST, ZN => N34);
   U101 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_23_port, A2 => RST, 
                           ZN => N339);
   U102 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_22_port, A2 => RST, 
                           ZN => N338);
   U103 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_21_port, A2 => RST, 
                           ZN => N337);
   U104 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_20_port, A2 => RST, 
                           ZN => N336);
   U105 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_19_port, A2 => RST, 
                           ZN => N335);
   U106 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_18_port, A2 => RST, 
                           ZN => N334);
   U107 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_17_port, A2 => RST, 
                           ZN => N333);
   U108 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_16_port, A2 => RST, 
                           ZN => N332);
   U109 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_15_port, A2 => RST, 
                           ZN => N331);
   U110 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_14_port, A2 => RST, 
                           ZN => N330);
   U111 : AND2_X1 port map( A1 => NPC_OUT_29_port, A2 => RST, ZN => N33);
   U112 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_13_port, A2 => RST, 
                           ZN => N329);
   U113 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_12_port, A2 => RST, 
                           ZN => N328);
   U114 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_11_port, A2 => RST, 
                           ZN => N327);
   U115 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_10_port, A2 => RST, 
                           ZN => N326);
   U116 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_9_port, A2 => RST, ZN
                           => N325);
   U117 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_8_port, A2 => RST, ZN
                           => N324);
   U118 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_7_port, A2 => RST, ZN
                           => N323);
   U119 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_6_port, A2 => RST, ZN
                           => N322);
   U120 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_5_port, A2 => RST, ZN
                           => N321);
   U121 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_4_port, A2 => RST, ZN
                           => N320);
   U122 : AND2_X1 port map( A1 => NPC_OUT_28_port, A2 => RST, ZN => N32);
   U123 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_3_port, A2 => RST, ZN
                           => N319);
   U124 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_2_port, A2 => RST, ZN
                           => N318);
   U125 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_1_port, A2 => RST, ZN
                           => N317);
   U126 : AND2_X1 port map( A1 => MEM_WB_DRAM_OUTPUT_NEXT_0_port, A2 => RST, ZN
                           => N316);
   U127 : NOR2_X1 port map( A1 => n47_port, A2 => n192_port, ZN => N315);
   U128 : NOR2_X1 port map( A1 => n48_port, A2 => n192_port, ZN => N314);
   U129 : NOR2_X1 port map( A1 => n49_port, A2 => n192_port, ZN => N313);
   U130 : NOR2_X1 port map( A1 => n50_port, A2 => n192_port, ZN => N312);
   U131 : NOR2_X1 port map( A1 => n51_port, A2 => n192_port, ZN => N311);
   U132 : NOR2_X1 port map( A1 => n52_port, A2 => n192_port, ZN => N310);
   U133 : AND2_X1 port map( A1 => NPC_OUT_27_port, A2 => RST, ZN => N31);
   U134 : NOR2_X1 port map( A1 => n53_port, A2 => n192_port, ZN => N309);
   U135 : NOR2_X1 port map( A1 => n54_port, A2 => n192_port, ZN => N308);
   U136 : NOR2_X1 port map( A1 => n55_port, A2 => n192_port, ZN => N307);
   U137 : NOR2_X1 port map( A1 => n56_port, A2 => n192_port, ZN => N306);
   U138 : NOR2_X1 port map( A1 => n57_port, A2 => n192_port, ZN => N305);
   U139 : NOR2_X1 port map( A1 => n58_port, A2 => n192_port, ZN => N304);
   U140 : NOR2_X1 port map( A1 => n59_port, A2 => n192_port, ZN => N303);
   U141 : NOR2_X1 port map( A1 => n60_port, A2 => n192_port, ZN => N302);
   U142 : NOR2_X1 port map( A1 => n61_port, A2 => n192_port, ZN => N301);
   U143 : NOR2_X1 port map( A1 => n62_port, A2 => n192_port, ZN => N300);
   U144 : AND2_X1 port map( A1 => NPC_OUT_26_port, A2 => RST, ZN => N30);
   U145 : NOR2_X1 port map( A1 => n63_port, A2 => n192_port, ZN => N299);
   U146 : NOR2_X1 port map( A1 => n64_port, A2 => n192_port, ZN => N298);
   U147 : NOR2_X1 port map( A1 => n65_port, A2 => n192_port, ZN => N297);
   U148 : NOR2_X1 port map( A1 => n66_port, A2 => n192_port, ZN => N296);
   U149 : NOR2_X1 port map( A1 => n67_port, A2 => n192_port, ZN => N295);
   U150 : NOR2_X1 port map( A1 => n68_port, A2 => n192_port, ZN => N294);
   U151 : NOR2_X1 port map( A1 => n69_port, A2 => n192_port, ZN => N293);
   U152 : NOR2_X1 port map( A1 => n70_port, A2 => n192_port, ZN => N292);
   U153 : NOR2_X1 port map( A1 => n71_port, A2 => n192_port, ZN => N291);
   U154 : NOR2_X1 port map( A1 => n72_port, A2 => n192_port, ZN => N290);
   U155 : AND2_X1 port map( A1 => NPC_OUT_25_port, A2 => RST, ZN => N29);
   U156 : NOR2_X1 port map( A1 => n73_port, A2 => n192_port, ZN => N289);
   U157 : NOR2_X1 port map( A1 => n74_port, A2 => n192_port, ZN => N288);
   U158 : NOR2_X1 port map( A1 => n75_port, A2 => n192_port, ZN => N287);
   U159 : NOR2_X1 port map( A1 => n76_port, A2 => n192_port, ZN => N286);
   U160 : NOR2_X1 port map( A1 => n77_port, A2 => n192_port, ZN => N285);
   U161 : NOR2_X1 port map( A1 => n78_port, A2 => n192_port, ZN => N284);
   U162 : NOR2_X1 port map( A1 => n79_port, A2 => n192_port, ZN => N283);
   U163 : NOR2_X1 port map( A1 => n191_port, A2 => n80_port, ZN => N282);
   U164 : NOR2_X1 port map( A1 => n191_port, A2 => n81_port, ZN => N281);
   U165 : NOR2_X1 port map( A1 => n191_port, A2 => n82_port, ZN => N280);
   U166 : AND2_X1 port map( A1 => NPC_OUT_24_port, A2 => RST, ZN => N28);
   U167 : NOR2_X1 port map( A1 => n191_port, A2 => n83_port, ZN => N279);
   U168 : NOR2_X1 port map( A1 => n191_port, A2 => n84_port, ZN => N278);
   U169 : AND2_X1 port map( A1 => EX_MEM_BRANCH_DETECT_NEXT, A2 => RST, ZN => 
                           N277);
   U170 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_31_port, A2 => RST, ZN
                           => N276);
   U171 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_30_port, A2 => RST, ZN
                           => N275);
   U172 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_29_port, A2 => RST, ZN
                           => N274);
   U173 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_28_port, A2 => RST, ZN
                           => N273);
   U174 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_27_port, A2 => RST, ZN
                           => N272);
   U175 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_26_port, A2 => RST, ZN
                           => N271);
   U176 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_25_port, A2 => RST, ZN
                           => N270);
   U177 : AND2_X1 port map( A1 => NPC_OUT_23_port, A2 => RST, ZN => N27);
   U178 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_24_port, A2 => RST, ZN
                           => N269);
   U179 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_23_port, A2 => RST, ZN
                           => N268);
   U180 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_22_port, A2 => RST, ZN
                           => N267);
   U181 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_21_port, A2 => RST, ZN
                           => N266);
   U182 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_20_port, A2 => RST, ZN
                           => N265);
   U183 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_19_port, A2 => RST, ZN
                           => N264);
   U184 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_18_port, A2 => RST, ZN
                           => N263);
   U185 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_17_port, A2 => RST, ZN
                           => N262);
   U186 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_16_port, A2 => RST, ZN
                           => N261);
   U187 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_15_port, A2 => RST, ZN
                           => N260);
   U188 : AND2_X1 port map( A1 => NPC_OUT_22_port, A2 => RST, ZN => N26);
   U189 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_14_port, A2 => RST, ZN
                           => N259);
   U190 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_13_port, A2 => RST, ZN
                           => N258);
   U191 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_12_port, A2 => RST, ZN
                           => N257);
   U192 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_11_port, A2 => RST, ZN
                           => N256);
   U193 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_10_port, A2 => RST, ZN
                           => N255);
   U194 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_9_port, A2 => RST, ZN 
                           => N254);
   U195 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_8_port, A2 => RST, ZN 
                           => N253);
   U196 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_7_port, A2 => RST, ZN 
                           => N252);
   U197 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_6_port, A2 => RST, ZN 
                           => N251);
   U198 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_5_port, A2 => RST, ZN 
                           => N250);
   U199 : AND2_X1 port map( A1 => NPC_OUT_21_port, A2 => RST, ZN => N25);
   U200 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_4_port, A2 => RST, ZN 
                           => N249);
   U201 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_3_port, A2 => RST, ZN 
                           => N248);
   U202 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_2_port, A2 => RST, ZN 
                           => N247);
   U203 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_1_port, A2 => RST, ZN 
                           => N246);
   U204 : AND2_X1 port map( A1 => EX_MEM_ALU_OUTPUT_NEXT_0_port, A2 => RST, ZN 
                           => N245);
   U205 : NOR2_X1 port map( A1 => n85_port, A2 => n192_port, ZN => N244);
   U206 : NOR2_X1 port map( A1 => n86_port, A2 => n192_port, ZN => N243);
   U207 : NOR2_X1 port map( A1 => n87_port, A2 => n192_port, ZN => N242);
   U208 : NOR2_X1 port map( A1 => n88_port, A2 => n192_port, ZN => N241);
   U209 : NOR2_X1 port map( A1 => n89_port, A2 => n192_port, ZN => N240);
   U210 : AND2_X1 port map( A1 => NPC_OUT_20_port, A2 => RST, ZN => N24);
   U211 : NOR2_X1 port map( A1 => n90_port, A2 => n192_port, ZN => N239);
   U212 : NOR2_X1 port map( A1 => n91_port, A2 => n192_port, ZN => N238);
   U213 : NOR2_X1 port map( A1 => n92_port, A2 => n192_port, ZN => N237);
   U214 : NOR2_X1 port map( A1 => n93_port, A2 => n192_port, ZN => N236);
   U215 : NOR2_X1 port map( A1 => n94_port, A2 => n192_port, ZN => N235);
   U216 : NOR2_X1 port map( A1 => n95_port, A2 => n192_port, ZN => N234);
   U217 : NOR2_X1 port map( A1 => n96_port, A2 => n192_port, ZN => N233);
   U218 : NOR2_X1 port map( A1 => n97_port, A2 => n192_port, ZN => N232);
   U219 : NOR2_X1 port map( A1 => n98_port, A2 => n192_port, ZN => N231);
   U220 : NOR2_X1 port map( A1 => n99_port, A2 => n192_port, ZN => N230);
   U221 : AND2_X1 port map( A1 => NPC_OUT_19_port, A2 => RST, ZN => N23);
   U222 : NOR2_X1 port map( A1 => n100_port, A2 => n192_port, ZN => N229);
   U223 : NOR2_X1 port map( A1 => n101_port, A2 => n192_port, ZN => N228);
   U224 : NOR2_X1 port map( A1 => n102_port, A2 => n192_port, ZN => N227);
   U225 : NOR2_X1 port map( A1 => n103_port, A2 => n192_port, ZN => N226);
   U226 : NOR2_X1 port map( A1 => n104_port, A2 => n192_port, ZN => N225);
   U227 : NOR2_X1 port map( A1 => n105_port, A2 => n192_port, ZN => N224);
   U228 : NOR2_X1 port map( A1 => n106_port, A2 => n192_port, ZN => N223);
   U229 : NOR2_X1 port map( A1 => n107_port, A2 => n192_port, ZN => N222);
   U230 : NOR2_X1 port map( A1 => n108_port, A2 => n192_port, ZN => N221);
   U231 : NOR2_X1 port map( A1 => n109_port, A2 => n193_port, ZN => N220);
   U232 : AND2_X1 port map( A1 => NPC_OUT_18_port, A2 => RST, ZN => N22);
   U233 : NOR2_X1 port map( A1 => n110_port, A2 => n193_port, ZN => N219);
   U234 : NOR2_X1 port map( A1 => n111_port, A2 => n193_port, ZN => N218);
   U235 : NOR2_X1 port map( A1 => n112_port, A2 => n193_port, ZN => N217);
   U236 : NOR2_X1 port map( A1 => n113_port, A2 => n193_port, ZN => N216);
   U237 : NOR2_X1 port map( A1 => n114_port, A2 => n193_port, ZN => N215);
   U238 : NOR2_X1 port map( A1 => n115_port, A2 => n193_port, ZN => N214);
   U239 : NOR2_X1 port map( A1 => n116_port, A2 => n191_port, ZN => N213);
   U240 : NOR2_X1 port map( A1 => n191_port, A2 => n117_port, ZN => N212);
   U241 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_31_port, A2 => RST, ZN => N211
                           );
   U242 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_30_port, A2 => RST, ZN => N210
                           );
   U243 : AND2_X1 port map( A1 => NPC_OUT_17_port, A2 => RST, ZN => N21);
   U244 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_29_port, A2 => RST, ZN => N209
                           );
   U245 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_28_port, A2 => RST, ZN => N208
                           );
   U246 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_27_port, A2 => RST, ZN => N207
                           );
   U247 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_26_port, A2 => RST, ZN => N206
                           );
   U248 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_25_port, A2 => RST, ZN => N205
                           );
   U249 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_24_port, A2 => RST, ZN => N204
                           );
   U250 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_23_port, A2 => RST, ZN => N203
                           );
   U251 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_22_port, A2 => RST, ZN => N202
                           );
   U252 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_21_port, A2 => RST, ZN => N201
                           );
   U253 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_20_port, A2 => RST, ZN => N200
                           );
   U254 : AND2_X1 port map( A1 => NPC_OUT_16_port, A2 => RST, ZN => N20);
   U255 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_19_port, A2 => RST, ZN => N199
                           );
   U256 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_18_port, A2 => RST, ZN => N198
                           );
   U257 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_17_port, A2 => RST, ZN => N197
                           );
   U258 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_16_port, A2 => RST, ZN => N196
                           );
   U259 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_15_port, A2 => RST, ZN => N195
                           );
   U260 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_14_port, A2 => RST, ZN => N194
                           );
   U261 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_13_port, A2 => RST, ZN => N193
                           );
   U262 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_12_port, A2 => RST, ZN => N192
                           );
   U263 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_11_port, A2 => RST, ZN => N191
                           );
   U264 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_10_port, A2 => RST, ZN => N190
                           );
   U265 : AND2_X1 port map( A1 => NPC_OUT_15_port, A2 => RST, ZN => N19);
   U266 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_9_port, A2 => RST, ZN => N189)
                           ;
   U267 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_8_port, A2 => RST, ZN => N188)
                           ;
   U268 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_7_port, A2 => RST, ZN => N187)
                           ;
   U269 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_6_port, A2 => RST, ZN => N186)
                           ;
   U270 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_5_port, A2 => RST, ZN => N185)
                           ;
   U271 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_4_port, A2 => RST, ZN => N184)
                           ;
   U272 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_3_port, A2 => RST, ZN => N183)
                           ;
   U273 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_2_port, A2 => RST, ZN => N182)
                           ;
   U274 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_1_port, A2 => RST, ZN => N181)
                           ;
   U275 : AND2_X1 port map( A1 => ID_EX_IMM_NEXT_0_port, A2 => RST, ZN => N180)
                           ;
   U276 : AND2_X1 port map( A1 => NPC_OUT_14_port, A2 => RST, ZN => N18);
   U277 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_31_port, A2 => RST, ZN => 
                           N179);
   U278 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_30_port, A2 => RST, ZN => 
                           N178);
   U279 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_29_port, A2 => RST, ZN => 
                           N177);
   U280 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_28_port, A2 => RST, ZN => 
                           N176);
   U281 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_27_port, A2 => RST, ZN => 
                           N175);
   U282 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_26_port, A2 => RST, ZN => 
                           N174);
   U283 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_25_port, A2 => RST, ZN => 
                           N173);
   U284 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_24_port, A2 => RST, ZN => 
                           N172);
   U285 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_23_port, A2 => RST, ZN => 
                           N171);
   U286 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_22_port, A2 => RST, ZN => 
                           N170);
   U287 : AND2_X1 port map( A1 => NPC_OUT_13_port, A2 => RST, ZN => N17);
   U288 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_21_port, A2 => RST, ZN => 
                           N169);
   U289 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_20_port, A2 => RST, ZN => 
                           N168);
   U290 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_19_port, A2 => RST, ZN => 
                           N167);
   U291 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_18_port, A2 => RST, ZN => 
                           N166);
   U292 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_17_port, A2 => RST, ZN => 
                           N165);
   U293 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_16_port, A2 => RST, ZN => 
                           N164);
   U294 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_15_port, A2 => RST, ZN => 
                           N163);
   U295 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_14_port, A2 => RST, ZN => 
                           N162);
   U296 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_13_port, A2 => RST, ZN => 
                           N161);
   U297 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_12_port, A2 => RST, ZN => 
                           N160);
   U298 : AND2_X1 port map( A1 => NPC_OUT_12_port, A2 => RST, ZN => N16);
   U299 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_11_port, A2 => RST, ZN => 
                           N159);
   U300 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_10_port, A2 => RST, ZN => 
                           N158);
   U301 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_9_port, A2 => RST, ZN => 
                           N157);
   U302 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_8_port, A2 => RST, ZN => 
                           N156);
   U303 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_7_port, A2 => RST, ZN => 
                           N155);
   U304 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_6_port, A2 => RST, ZN => 
                           N154);
   U305 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_5_port, A2 => RST, ZN => 
                           N153);
   U306 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_4_port, A2 => RST, ZN => 
                           N152);
   U307 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_3_port, A2 => RST, ZN => 
                           N151);
   U308 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_2_port, A2 => RST, ZN => 
                           N150);
   U309 : AND2_X1 port map( A1 => NPC_OUT_11_port, A2 => RST, ZN => N15);
   U310 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_1_port, A2 => RST, ZN => 
                           N149);
   U311 : AND2_X1 port map( A1 => ID_EX_RF_OUT2_NEXT_0_port, A2 => RST, ZN => 
                           N148);
   U312 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_31_port, A2 => RST, ZN => 
                           N147);
   U313 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_30_port, A2 => RST, ZN => 
                           N146);
   U314 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_29_port, A2 => RST, ZN => 
                           N145);
   U315 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_28_port, A2 => RST, ZN => 
                           N144);
   U316 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_27_port, A2 => RST, ZN => 
                           N143);
   U317 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_26_port, A2 => RST, ZN => 
                           N142);
   U318 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_25_port, A2 => RST, ZN => 
                           N141);
   U319 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_24_port, A2 => RST, ZN => 
                           N140);
   U320 : AND2_X1 port map( A1 => NPC_OUT_10_port, A2 => RST, ZN => N14);
   U321 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_23_port, A2 => RST, ZN => 
                           N139);
   U322 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_22_port, A2 => RST, ZN => 
                           N138);
   U323 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_21_port, A2 => RST, ZN => 
                           N137);
   U324 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_20_port, A2 => RST, ZN => 
                           N136);
   U325 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_19_port, A2 => RST, ZN => 
                           N135);
   U326 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_18_port, A2 => RST, ZN => 
                           N134);
   U327 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_17_port, A2 => RST, ZN => 
                           N133);
   U328 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_16_port, A2 => RST, ZN => 
                           N132);
   U329 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_15_port, A2 => RST, ZN => 
                           N131);
   U330 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_14_port, A2 => RST, ZN => 
                           N130);
   U331 : AND2_X1 port map( A1 => NPC_OUT_9_port, A2 => RST, ZN => N13);
   U332 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_13_port, A2 => RST, ZN => 
                           N129);
   U333 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_12_port, A2 => RST, ZN => 
                           N128);
   U334 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_11_port, A2 => RST, ZN => 
                           N127);
   U335 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_10_port, A2 => RST, ZN => 
                           N126);
   U336 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_9_port, A2 => RST, ZN => 
                           N125);
   U337 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_8_port, A2 => RST, ZN => 
                           N124);
   U338 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_7_port, A2 => RST, ZN => 
                           N123);
   U339 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_6_port, A2 => RST, ZN => 
                           N122);
   U340 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_5_port, A2 => RST, ZN => 
                           N121);
   U341 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_4_port, A2 => RST, ZN => 
                           N120);
   U342 : AND2_X1 port map( A1 => NPC_OUT_8_port, A2 => RST, ZN => N12);
   U343 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_3_port, A2 => RST, ZN => 
                           N119);
   U344 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_2_port, A2 => RST, ZN => 
                           N118);
   U345 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_1_port, A2 => RST, ZN => 
                           N117);
   U346 : AND2_X1 port map( A1 => ID_EX_RF_OUT1_NEXT_0_port, A2 => RST, ZN => 
                           N116);
   U347 : AND2_X1 port map( A1 => RD_4_port, A2 => RST, ZN => N115);
   U348 : AND2_X1 port map( A1 => RD_3_port, A2 => RST, ZN => N114);
   U349 : AND2_X1 port map( A1 => RD_2_port, A2 => RST, ZN => N113);
   U350 : AND2_X1 port map( A1 => RD_1_port, A2 => RST, ZN => N112);
   U351 : AND2_X1 port map( A1 => RD_0_port, A2 => RST, ZN => N111);
   U352 : AND2_X1 port map( A1 => RS2_4_port, A2 => RST, ZN => N110);
   U353 : AND2_X1 port map( A1 => NPC_OUT_7_port, A2 => RST, ZN => N11);
   U354 : AND2_X1 port map( A1 => RS2_3_port, A2 => RST, ZN => N109);
   U355 : AND2_X1 port map( A1 => RS2_2_port, A2 => RST, ZN => N108);
   U356 : AND2_X1 port map( A1 => RS2_1_port, A2 => RST, ZN => N107);
   U357 : AND2_X1 port map( A1 => RS2_0_port, A2 => RST, ZN => N106);
   U358 : AND2_X1 port map( A1 => RS1_4_port, A2 => RST, ZN => N105);
   U359 : AND2_X1 port map( A1 => RS1_3_port, A2 => RST, ZN => N104);
   U360 : AND2_X1 port map( A1 => RS1_2_port, A2 => RST, ZN => N103);
   U361 : AND2_X1 port map( A1 => RS1_1_port, A2 => RST, ZN => N102);
   U362 : AND2_X1 port map( A1 => RS1_0_port, A2 => RST, ZN => N101);
   U363 : AND2_X1 port map( A1 => RF_WE, A2 => RST, ZN => N100);
   U364 : AND2_X1 port map( A1 => NPC_OUT_6_port, A2 => RST, ZN => N10);
   U365 : XOR2_X1 port map( A => ZERO_OUT, B => EQ_COND, Z => BRANCH_DETECT);
   n200_port <= '0';

end SYN_DLX_DATAPATH_ARCH;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity 
   DLX_CU_MICROCODE_MEM_SIZE64_FUNC_SIZE11_OP_CODE_SIZE6_IR_SIZE32_CW_SIZE17 is

   port( CLK, RST : in std_logic;  IR_IN : in std_logic_vector (31 downto 0);  
         IR_LATCH_EN, PC_LATCH_EN, NPC_LATCH_EN, RF_WE, RegA_LATCH_EN, 
         RegB_LATCH_EN, RegIMM_LATCH_EN, MUXA_SEL, MUXB_SEL, ALU_OUTREG_EN, 
         EQ_COND : out std_logic;  ALU_OPCODE : out std_logic_vector (0 to 6); 
         DRAM_RE, DRAM_WE, LMD_LATCH_EN, JUMP_EN, JUMP_COND, WB_MUX_SEL : out 
         std_logic);

end DLX_CU_MICROCODE_MEM_SIZE64_FUNC_SIZE11_OP_CODE_SIZE6_IR_SIZE32_CW_SIZE17;

architecture SYN_DLX_CU_HW of 
   DLX_CU_MICROCODE_MEM_SIZE64_FUNC_SIZE11_OP_CODE_SIZE6_IR_SIZE32_CW_SIZE17 is

   component INV_X1
      port( A : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NOR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component NAND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI21_X1
      port( B1, B2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND4_X1
      port( A1, A2, A3, A4 : in std_logic;  ZN : out std_logic);
   end component;
   
   component AND3_X1
      port( A1, A2, A3 : in std_logic;  ZN : out std_logic);
   end component;
   
   component MUX2_X1
      port( A, B, S : in std_logic;  Z : out std_logic);
   end component;
   
   component AOI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component AOI221_X1
      port( B1, B2, C1, C2, A : in std_logic;  ZN : out std_logic);
   end component;
   
   component OAI211_X1
      port( C1, C2, A, B : in std_logic;  ZN : out std_logic);
   end component;
   
   component OR2_X1
      port( A1, A2 : in std_logic;  ZN : out std_logic);
   end component;
   
   component BUF_X1
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component DFFR_X1
      port( D, CK, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   component DFFS_X1
      port( D, CK, SN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal aluOpcode1_6_port, aluOpcode1_5_port, aluOpcode1_4_port, 
      aluOpcode1_3_port, aluOpcode1_2_port, aluOpcode1_1_port, 
      aluOpcode1_0_port, aluOpcode2_6_port, aluOpcode2_5_port, 
      aluOpcode2_4_port, aluOpcode2_3_port, aluOpcode2_2_port, 
      aluOpcode2_1_port, aluOpcode2_0_port, IR_LATCH_EN_port, n169, n170, n171,
      n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, 
      n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, 
      n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, 
      n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, 
      n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, 
      n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, 
      n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, 
      n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, 
      n268, n_1538, n_1539, n_1540, n_1541, n_1542, n_1543, n_1544, n_1545, 
      n_1546, n_1547, n_1548, n_1549, n_1550, n_1551 : std_logic;

begin
   IR_LATCH_EN <= IR_LATCH_EN_port;
   PC_LATCH_EN <= IR_LATCH_EN_port;
   NPC_LATCH_EN <= IR_LATCH_EN_port;
   
   aluOpcode2_reg_6_inst : DFFS_X1 port map( D => aluOpcode1_6_port, CK => n170
                           , SN => RST, Q => aluOpcode2_6_port, QN => n_1538);
   aluOpcode2_reg_5_inst : DFFS_X1 port map( D => aluOpcode1_5_port, CK => n170
                           , SN => RST, Q => aluOpcode2_5_port, QN => n_1539);
   aluOpcode2_reg_4_inst : DFFR_X1 port map( D => aluOpcode1_4_port, CK => n170
                           , RN => RST, Q => aluOpcode2_4_port, QN => n_1540);
   aluOpcode2_reg_3_inst : DFFR_X1 port map( D => aluOpcode1_3_port, CK => n170
                           , RN => RST, Q => aluOpcode2_3_port, QN => n_1541);
   aluOpcode2_reg_2_inst : DFFS_X1 port map( D => aluOpcode1_2_port, CK => n171
                           , SN => RST, Q => aluOpcode2_2_port, QN => n_1542);
   aluOpcode2_reg_1_inst : DFFS_X1 port map( D => aluOpcode1_1_port, CK => n171
                           , SN => RST, Q => aluOpcode2_1_port, QN => n_1543);
   aluOpcode2_reg_0_inst : DFFR_X1 port map( D => aluOpcode1_0_port, CK => n170
                           , RN => RST, Q => aluOpcode2_0_port, QN => n_1544);
   aluOpcode3_reg_6_inst : DFFS_X1 port map( D => aluOpcode2_6_port, CK => n170
                           , SN => RST, Q => ALU_OPCODE(0), QN => n_1545);
   aluOpcode3_reg_5_inst : DFFS_X1 port map( D => aluOpcode2_5_port, CK => n170
                           , SN => RST, Q => ALU_OPCODE(1), QN => n_1546);
   aluOpcode3_reg_4_inst : DFFR_X1 port map( D => aluOpcode2_4_port, CK => n170
                           , RN => RST, Q => ALU_OPCODE(2), QN => n_1547);
   aluOpcode3_reg_3_inst : DFFR_X1 port map( D => aluOpcode2_3_port, CK => n170
                           , RN => RST, Q => ALU_OPCODE(3), QN => n_1548);
   aluOpcode3_reg_2_inst : DFFS_X1 port map( D => aluOpcode2_2_port, CK => n170
                           , SN => RST, Q => ALU_OPCODE(4), QN => n_1549);
   aluOpcode3_reg_1_inst : DFFS_X1 port map( D => aluOpcode2_1_port, CK => n171
                           , SN => RST, Q => ALU_OPCODE(5), QN => n_1550);
   aluOpcode3_reg_0_inst : DFFR_X1 port map( D => aluOpcode2_0_port, CK => n170
                           , RN => RST, Q => ALU_OPCODE(6), QN => n_1551);
   WB_MUX_SEL <= '0';
   JUMP_COND <= '0';
   JUMP_EN <= '0';
   LMD_LATCH_EN <= '0';
   DRAM_WE <= '0';
   DRAM_RE <= '0';
   EQ_COND <= '0';
   ALU_OUTREG_EN <= '0';
   MUXB_SEL <= '0';
   MUXA_SEL <= '0';
   RegIMM_LATCH_EN <= '0';
   RegB_LATCH_EN <= '0';
   RegA_LATCH_EN <= '0';
   RF_WE <= '0';
   IR_LATCH_EN_port <= '0';
   U17 : BUF_X1 port map( A => n172, Z => n170);
   U18 : BUF_X1 port map( A => n172, Z => n171);
   U19 : INV_X1 port map( A => RST, ZN => n169);
   U20 : BUF_X1 port map( A => CLK, Z => n172);
   U21 : OAI211_X1 port map( C1 => n173, C2 => n174, A => n175, B => RST, ZN =>
                           aluOpcode1_6_port);
   U22 : NAND3_X1 port map( A1 => n176, A2 => n175, A3 => RST, ZN => 
                           aluOpcode1_5_port);
   U23 : OR2_X1 port map( A1 => n177, A2 => n178, ZN => n175);
   U24 : OR3_X1 port map( A1 => n179, A2 => n180, A3 => n181, ZN => n176);
   U25 : OAI211_X1 port map( C1 => n182, C2 => n183, A => n184, B => n185, ZN 
                           => n181);
   U26 : NOR3_X1 port map( A1 => n186, A2 => IR_IN(28), A3 => n187, ZN => n183)
                           ;
   U27 : NOR2_X1 port map( A1 => n188, A2 => n169, ZN => aluOpcode1_4_port);
   U28 : AOI211_X1 port map( C1 => n189, C2 => n173, A => n180, B => n174, ZN 
                           => n188);
   U29 : OAI211_X1 port map( C1 => n190, C2 => n191, A => n192, B => n193, ZN 
                           => n180);
   U30 : NOR2_X1 port map( A1 => n194, A2 => n169, ZN => aluOpcode1_3_port);
   U31 : NOR3_X1 port map( A1 => n195, A2 => n174, A3 => n179, ZN => n194);
   U32 : NAND2_X1 port map( A1 => n196, A2 => n197, ZN => n179);
   U33 : OAI21_X1 port map( B1 => n198, B2 => n186, A => n199, ZN => n197);
   U34 : OAI21_X1 port map( B1 => n200, B2 => n182, A => n201, ZN => n174);
   U35 : OAI211_X1 port map( C1 => n202, C2 => n184, A => n192, B => n185, ZN 
                           => n195);
   U36 : AOI21_X1 port map( B1 => IR_IN(3), B2 => n177, A => n203, ZN => n202);
   U37 : OAI211_X1 port map( C1 => n204, C2 => n178, A => n205, B => RST, ZN =>
                           aluOpcode1_2_port);
   U38 : NAND4_X1 port map( A1 => n201, A2 => n184, A3 => n185, A4 => n206, ZN 
                           => n205);
   U39 : AOI221_X1 port map( B1 => n207, B2 => n208, C1 => n209, C2 => n210, A 
                           => n211, ZN => n206);
   U40 : INV_X1 port map( A => n212, ZN => n211);
   U41 : NAND2_X1 port map( A1 => n190, A2 => n213, ZN => n210);
   U42 : NOR2_X1 port map( A1 => n187, A2 => n208, ZN => n190);
   U43 : OR3_X1 port map( A1 => n214, A2 => n215, A3 => n203, ZN => n178);
   U44 : NAND3_X1 port map( A1 => n216, A2 => n217, A3 => n218, ZN => n203);
   U45 : MUX2_X1 port map( A => n219, B => n220, S => n221, Z => n218);
   U46 : NAND2_X1 port map( A1 => n222, A2 => IR_IN(3), ZN => n220);
   U47 : INV_X1 port map( A => n223, ZN => n214);
   U48 : NOR3_X1 port map( A1 => n224, A2 => IR_IN(2), A3 => IR_IN(0), ZN => 
                           n204);
   U49 : OAI221_X1 port map( B1 => n225, B2 => n226, C1 => n227, C2 => n228, A 
                           => RST, ZN => aluOpcode1_1_port);
   U50 : OAI21_X1 port map( B1 => IR_IN(0), B2 => n229, A => n223, ZN => n228);
   U51 : AOI21_X1 port map( B1 => n230, B2 => n231, A => n184, ZN => n223);
   U52 : NOR2_X1 port map( A1 => IR_IN(0), A2 => IR_IN(5), ZN => n231);
   U53 : NAND3_X1 port map( A1 => n216, A2 => n219, A3 => n232, ZN => n227);
   U54 : NAND3_X1 port map( A1 => n233, A2 => n234, A3 => IR_IN(3), ZN => n232)
                           ;
   U55 : NAND3_X1 port map( A1 => n222, A2 => n235, A3 => IR_IN(0), ZN => n219)
                           ;
   U56 : OAI221_X1 port map( B1 => n182, B2 => n236, C1 => n237, C2 => n213, A 
                           => n238, ZN => n226);
   U57 : NAND4_X1 port map( A1 => n212, A2 => n192, A3 => n196, A4 => n184, ZN 
                           => n225);
   U58 : INV_X1 port map( A => n173, ZN => n184);
   U59 : NAND3_X1 port map( A1 => IR_IN(27), A2 => n239, A3 => IR_IN(26), ZN =>
                           n196);
   U60 : NAND4_X1 port map( A1 => IR_IN(31), A2 => n187, A3 => IR_IN(29), A4 =>
                           n240, ZN => n192);
   U61 : NAND2_X1 port map( A1 => n207, A2 => n241, ZN => n212);
   U62 : OAI21_X1 port map( B1 => n242, B2 => n213, A => n243, ZN => n241);
   U63 : AOI21_X1 port map( B1 => n244, B2 => n245, A => n169, ZN => 
                           aluOpcode1_0_port);
   U64 : AOI211_X1 port map( C1 => n173, C2 => n246, A => n247, B => n248, ZN 
                           => n245);
   U65 : AOI21_X1 port map( B1 => n182, B2 => n201, A => n249, ZN => n248);
   U66 : NAND2_X1 port map( A1 => n208, A2 => n250, ZN => n201);
   U67 : INV_X1 port map( A => n209, ZN => n182);
   U68 : NOR3_X1 port map( A1 => IR_IN(30), A2 => IR_IN(31), A3 => n251, ZN => 
                           n209);
   U69 : AOI211_X1 port map( C1 => n243, C2 => n252, A => n242, B => n253, ZN 
                           => n247);
   U70 : INV_X1 port map( A => IR_IN(31), ZN => n242);
   U71 : NAND2_X1 port map( A1 => IR_IN(26), A2 => n208, ZN => n252);
   U72 : NOR2_X1 port map( A1 => n254, A2 => IR_IN(27), ZN => n208);
   U73 : NAND2_X1 port map( A1 => n255, A2 => n216, ZN => n246);
   U74 : NAND4_X1 port map( A1 => n230, A2 => IR_IN(1), A3 => IR_IN(5), A4 => 
                           n256, ZN => n216);
   U75 : MUX2_X1 port map( A => n257, B => n258, S => n256, Z => n255);
   U76 : INV_X1 port map( A => IR_IN(0), ZN => n256);
   U77 : AOI21_X1 port map( B1 => n177, B2 => n235, A => n215, ZN => n258);
   U78 : AND3_X1 port map( A1 => IR_IN(1), A2 => n259, A3 => n230, ZN => n215);
   U79 : AND4_X1 port map( A1 => IR_IN(2), A2 => n260, A3 => n235, A4 => n261, 
                           ZN => n230);
   U80 : INV_X1 port map( A => IR_IN(5), ZN => n259);
   U81 : INV_X1 port map( A => IR_IN(3), ZN => n235);
   U82 : AOI21_X1 port map( B1 => IR_IN(3), B2 => n177, A => n189, ZN => n257);
   U83 : INV_X1 port map( A => n217, ZN => n189);
   U84 : NAND4_X1 port map( A1 => IR_IN(4), A2 => IR_IN(3), A3 => n233, A4 => 
                           n262, ZN => n217);
   U85 : OAI21_X1 port map( B1 => IR_IN(1), B2 => n221, A => n263, ZN => n262);
   U86 : NAND2_X1 port map( A1 => n224, A2 => n229, ZN => n177);
   U87 : NAND3_X1 port map( A1 => n234, A2 => n261, A3 => n233, ZN => n229);
   U88 : INV_X1 port map( A => n264, ZN => n233);
   U89 : INV_X1 port map( A => IR_IN(4), ZN => n261);
   U90 : INV_X1 port map( A => n263, ZN => n234);
   U91 : NAND2_X1 port map( A1 => IR_IN(1), A2 => n221, ZN => n263);
   U92 : INV_X1 port map( A => IR_IN(2), ZN => n221);
   U93 : INV_X1 port map( A => n222, ZN => n224);
   U94 : NOR3_X1 port map( A1 => IR_IN(1), A2 => IR_IN(4), A3 => n264, ZN => 
                           n222);
   U95 : NAND2_X1 port map( A1 => IR_IN(5), A2 => n260, ZN => n264);
   U96 : NOR3_X1 port map( A1 => IR_IN(6), A2 => IR_IN(10), A3 => n265, ZN => 
                           n260);
   U97 : OR3_X1 port map( A1 => IR_IN(9), A2 => IR_IN(8), A3 => IR_IN(7), ZN =>
                           n265);
   U98 : NOR3_X1 port map( A1 => n237, A2 => IR_IN(26), A3 => n200, ZN => n173)
                           ;
   U99 : INV_X1 port map( A => n198, ZN => n200);
   U100 : NOR2_X1 port map( A1 => IR_IN(27), A2 => IR_IN(28), ZN => n198);
   U101 : INV_X1 port map( A => n266, ZN => n244);
   U102 : OAI221_X1 port map( B1 => n185, B2 => n236, C1 => n213, C2 => n191, A
                           => n238, ZN => n266);
   U103 : INV_X1 port map( A => n267, ZN => n238);
   U104 : OAI221_X1 port map( B1 => n191, B2 => n268, C1 => n237, C2 => n243, A
                           => n193, ZN => n267);
   U105 : NAND4_X1 port map( A1 => IR_IN(31), A2 => n187, A3 => n251, A4 => 
                           n240, ZN => n193);
   U106 : INV_X1 port map( A => n187, ZN => n243);
   U107 : NOR3_X1 port map( A1 => n236, A2 => IR_IN(28), A3 => n249, ZN => n187
                           );
   U108 : INV_X1 port map( A => n250, ZN => n237);
   U109 : NOR3_X1 port map( A1 => IR_IN(30), A2 => IR_IN(31), A3 => IR_IN(29), 
                           ZN => n250);
   U110 : NAND2_X1 port map( A1 => n249, A2 => n236, ZN => n268);
   U111 : INV_X1 port map( A => n199, ZN => n191);
   U112 : NOR2_X1 port map( A1 => n253, A2 => IR_IN(31), ZN => n199);
   U113 : INV_X1 port map( A => n207, ZN => n253);
   U114 : NOR2_X1 port map( A1 => n240, A2 => n251, ZN => n207);
   U115 : INV_X1 port map( A => IR_IN(29), ZN => n251);
   U116 : INV_X1 port map( A => n186, ZN => n213);
   U117 : NOR3_X1 port map( A1 => IR_IN(26), A2 => IR_IN(28), A3 => n236, ZN =>
                           n186);
   U118 : INV_X1 port map( A => IR_IN(27), ZN => n236);
   U119 : NAND2_X1 port map( A1 => n239, A2 => n249, ZN => n185);
   U120 : INV_X1 port map( A => IR_IN(26), ZN => n249);
   U121 : NOR4_X1 port map( A1 => n240, A2 => n254, A3 => IR_IN(29), A4 => 
                           IR_IN(31), ZN => n239);
   U122 : INV_X1 port map( A => IR_IN(28), ZN => n254);
   U123 : INV_X1 port map( A => IR_IN(30), ZN => n240);

end SYN_DLX_CU_HW;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_DLX.all;

entity DLX is

   port( CLK, RST : in std_logic);

end DLX;

architecture SYN_DLX_RTL of DLX is

   component DLX_DRAM_N256_NW32
      port( CLK, RST, RE, WE : in std_logic;  ADDR, DIN : in std_logic_vector 
            (31 downto 0);  DOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component DLX_IRAM_RAM_DEPTH256_I_SIZE32
      port( RST : in std_logic;  ADDR : in std_logic_vector (31 downto 0);  
            DOUT : out std_logic_vector (31 downto 0));
   end component;
   
   component DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32
      port( CLK, RST : in std_logic;  IR_IN, DRAM_OUT : in std_logic_vector (31
            downto 0);  IR_LATCH_EN, PC_LATCH_EN, NPC_LATCH_EN, RF_WE, 
            RegA_LATCH_EN, RegB_LATCH_EN, RegIMM_LATCH_EN, MUXA_SEL, MUXB_SEL, 
            ALU_OUTREG_EN, EQ_COND : in std_logic;  ALU_OPCODE : in 
            std_logic_vector (0 to 6);  DRAM_RE, DRAM_WE, LMD_LATCH_EN, JUMP_EN
            , JUMP_COND, WB_MUX_SEL : in std_logic;  IR_OUT, PC_OUT, ALU_OUT, 
            DRAM_IN : out std_logic_vector (31 downto 0));
   end component;
   
   component 
      DLX_CU_MICROCODE_MEM_SIZE64_FUNC_SIZE11_OP_CODE_SIZE6_IR_SIZE32_CW_SIZE17
      port( CLK, RST : in std_logic;  IR_IN : in std_logic_vector (31 downto 0)
            ;  IR_LATCH_EN, PC_LATCH_EN, NPC_LATCH_EN, RF_WE, RegA_LATCH_EN, 
            RegB_LATCH_EN, RegIMM_LATCH_EN, MUXA_SEL, MUXB_SEL, ALU_OUTREG_EN, 
            EQ_COND : out std_logic;  ALU_OPCODE : out std_logic_vector (0 to 
            6);  DRAM_RE, DRAM_WE, LMD_LATCH_EN, JUMP_EN, JUMP_COND, WB_MUX_SEL
            : out std_logic);
   end component;
   
   signal IR_31_port, IR_30_port, IR_29_port, IR_28_port, IR_27_port, 
      IR_26_port, IR_25_port, IR_24_port, IR_23_port, IR_22_port, IR_21_port, 
      IR_20_port, IR_19_port, IR_18_port, IR_17_port, IR_16_port, IR_15_port, 
      IR_14_port, IR_13_port, IR_12_port, IR_11_port, IR_10_port, IR_9_port, 
      IR_8_port, IR_7_port, IR_6_port, IR_5_port, IR_4_port, IR_3_port, 
      IR_2_port, IR_1_port, IR_0_port, IR_LATCH_EN_i, PC_LATCH_EN_i, 
      NPC_LATCH_EN_i, RF_WE_i, RegA_LATCH_EN_i, RegB_LATCH_EN_i, 
      RegIMM_LATCH_EN_i, MUXA_SEL_i, MUXB_SEL_i, ALU_OUTREG_EN_i, EQ_COND_i, 
      ALU_OPCODE_i_0_port, ALU_OPCODE_i_1_port, ALU_OPCODE_i_2_port, 
      ALU_OPCODE_i_3_port, ALU_OPCODE_i_4_port, ALU_OPCODE_i_5_port, 
      ALU_OPCODE_i_6_port, DRAM_RE_i, DRAM_WE_i, LMD_LATCH_EN_i, JUMP_EN_i, 
      JUMP_COND_i, WB_MUX_SEL_i, IR_BUS_31_port, IR_BUS_30_port, IR_BUS_29_port
      , IR_BUS_28_port, IR_BUS_27_port, IR_BUS_26_port, IR_BUS_25_port, 
      IR_BUS_24_port, IR_BUS_23_port, IR_BUS_22_port, IR_BUS_21_port, 
      IR_BUS_20_port, IR_BUS_19_port, IR_BUS_18_port, IR_BUS_17_port, 
      IR_BUS_16_port, IR_BUS_15_port, IR_BUS_14_port, IR_BUS_13_port, 
      IR_BUS_12_port, IR_BUS_11_port, IR_BUS_10_port, IR_BUS_9_port, 
      IR_BUS_8_port, IR_BUS_7_port, IR_BUS_6_port, IR_BUS_5_port, IR_BUS_4_port
      , IR_BUS_3_port, IR_BUS_2_port, IR_BUS_1_port, IR_BUS_0_port, 
      DATA_OUT_31_port, DATA_OUT_30_port, DATA_OUT_29_port, DATA_OUT_28_port, 
      DATA_OUT_27_port, DATA_OUT_26_port, DATA_OUT_25_port, DATA_OUT_24_port, 
      DATA_OUT_23_port, DATA_OUT_22_port, DATA_OUT_21_port, DATA_OUT_20_port, 
      DATA_OUT_19_port, DATA_OUT_18_port, DATA_OUT_17_port, DATA_OUT_16_port, 
      DATA_OUT_15_port, DATA_OUT_14_port, DATA_OUT_13_port, DATA_OUT_12_port, 
      DATA_OUT_11_port, DATA_OUT_10_port, DATA_OUT_9_port, DATA_OUT_8_port, 
      DATA_OUT_7_port, DATA_OUT_6_port, DATA_OUT_5_port, DATA_OUT_4_port, 
      DATA_OUT_3_port, DATA_OUT_2_port, DATA_OUT_1_port, DATA_OUT_0_port, 
      PC_31_port, PC_30_port, PC_29_port, PC_28_port, PC_27_port, PC_26_port, 
      PC_25_port, PC_24_port, PC_23_port, PC_22_port, PC_21_port, PC_20_port, 
      PC_19_port, PC_18_port, PC_17_port, PC_16_port, PC_15_port, PC_14_port, 
      PC_13_port, PC_12_port, PC_11_port, PC_10_port, PC_9_port, PC_8_port, 
      PC_7_port, PC_6_port, PC_5_port, PC_4_port, PC_3_port, PC_2_port, 
      PC_1_port, PC_0_port, DATA_ADDR_31_port, DATA_ADDR_30_port, 
      DATA_ADDR_29_port, DATA_ADDR_28_port, DATA_ADDR_27_port, 
      DATA_ADDR_26_port, DATA_ADDR_25_port, DATA_ADDR_24_port, 
      DATA_ADDR_23_port, DATA_ADDR_22_port, DATA_ADDR_21_port, 
      DATA_ADDR_20_port, DATA_ADDR_19_port, DATA_ADDR_18_port, 
      DATA_ADDR_17_port, DATA_ADDR_16_port, DATA_ADDR_15_port, 
      DATA_ADDR_14_port, DATA_ADDR_13_port, DATA_ADDR_12_port, 
      DATA_ADDR_11_port, DATA_ADDR_10_port, DATA_ADDR_9_port, DATA_ADDR_8_port,
      DATA_ADDR_7_port, DATA_ADDR_6_port, DATA_ADDR_5_port, DATA_ADDR_4_port, 
      DATA_ADDR_3_port, DATA_ADDR_2_port, DATA_ADDR_1_port, DATA_ADDR_0_port, 
      DATA_IN_31_port, DATA_IN_30_port, DATA_IN_29_port, DATA_IN_28_port, 
      DATA_IN_27_port, DATA_IN_26_port, DATA_IN_25_port, DATA_IN_24_port, 
      DATA_IN_23_port, DATA_IN_22_port, DATA_IN_21_port, DATA_IN_20_port, 
      DATA_IN_19_port, DATA_IN_18_port, DATA_IN_17_port, DATA_IN_16_port, 
      DATA_IN_15_port, DATA_IN_14_port, DATA_IN_13_port, DATA_IN_12_port, 
      DATA_IN_11_port, DATA_IN_10_port, DATA_IN_9_port, DATA_IN_8_port, 
      DATA_IN_7_port, DATA_IN_6_port, DATA_IN_5_port, DATA_IN_4_port, 
      DATA_IN_3_port, DATA_IN_2_port, DATA_IN_1_port, DATA_IN_0_port, n_1552, 
      n_1553, n_1554, n_1555, n_1556, n_1557, n_1558, n_1559, n_1560, n_1561, 
      n_1562, n_1563, n_1564, n_1565, n_1566, n_1567, n_1568 : std_logic;

begin
   
   CU_I : 
                           DLX_CU_MICROCODE_MEM_SIZE64_FUNC_SIZE11_OP_CODE_SIZE6_IR_SIZE32_CW_SIZE17 
                           port map( CLK => CLK, RST => RST, IR_IN(31) => 
                           IR_31_port, IR_IN(30) => IR_30_port, IR_IN(29) => 
                           IR_29_port, IR_IN(28) => IR_28_port, IR_IN(27) => 
                           IR_27_port, IR_IN(26) => IR_26_port, IR_IN(25) => 
                           IR_25_port, IR_IN(24) => IR_24_port, IR_IN(23) => 
                           IR_23_port, IR_IN(22) => IR_22_port, IR_IN(21) => 
                           IR_21_port, IR_IN(20) => IR_20_port, IR_IN(19) => 
                           IR_19_port, IR_IN(18) => IR_18_port, IR_IN(17) => 
                           IR_17_port, IR_IN(16) => IR_16_port, IR_IN(15) => 
                           IR_15_port, IR_IN(14) => IR_14_port, IR_IN(13) => 
                           IR_13_port, IR_IN(12) => IR_12_port, IR_IN(11) => 
                           IR_11_port, IR_IN(10) => IR_10_port, IR_IN(9) => 
                           IR_9_port, IR_IN(8) => IR_8_port, IR_IN(7) => 
                           IR_7_port, IR_IN(6) => IR_6_port, IR_IN(5) => 
                           IR_5_port, IR_IN(4) => IR_4_port, IR_IN(3) => 
                           IR_3_port, IR_IN(2) => IR_2_port, IR_IN(1) => 
                           IR_1_port, IR_IN(0) => IR_0_port, IR_LATCH_EN => 
                           n_1552, PC_LATCH_EN => n_1553, NPC_LATCH_EN => 
                           n_1554, RF_WE => n_1555, RegA_LATCH_EN => n_1556, 
                           RegB_LATCH_EN => n_1557, RegIMM_LATCH_EN => n_1558, 
                           MUXA_SEL => n_1559, MUXB_SEL => n_1560, 
                           ALU_OUTREG_EN => n_1561, EQ_COND => n_1562, 
                           ALU_OPCODE(0) => ALU_OPCODE_i_0_port, ALU_OPCODE(1) 
                           => ALU_OPCODE_i_1_port, ALU_OPCODE(2) => 
                           ALU_OPCODE_i_2_port, ALU_OPCODE(3) => 
                           ALU_OPCODE_i_3_port, ALU_OPCODE(4) => 
                           ALU_OPCODE_i_4_port, ALU_OPCODE(5) => 
                           ALU_OPCODE_i_5_port, ALU_OPCODE(6) => 
                           ALU_OPCODE_i_6_port, DRAM_RE => n_1563, DRAM_WE => 
                           n_1564, LMD_LATCH_EN => n_1565, JUMP_EN => n_1566, 
                           JUMP_COND => n_1567, WB_MUX_SEL => n_1568);
   DATAPATH_I : 
                           DLX_DATAPATH_IR_SIZE32_PC_SIZE32_RS_SIZE5_ALU_SIZE32_DRAM_SIZE32 
                           port map( CLK => CLK, RST => RST, IR_IN(31) => 
                           IR_BUS_31_port, IR_IN(30) => IR_BUS_30_port, 
                           IR_IN(29) => IR_BUS_29_port, IR_IN(28) => 
                           IR_BUS_28_port, IR_IN(27) => IR_BUS_27_port, 
                           IR_IN(26) => IR_BUS_26_port, IR_IN(25) => 
                           IR_BUS_25_port, IR_IN(24) => IR_BUS_24_port, 
                           IR_IN(23) => IR_BUS_23_port, IR_IN(22) => 
                           IR_BUS_22_port, IR_IN(21) => IR_BUS_21_port, 
                           IR_IN(20) => IR_BUS_20_port, IR_IN(19) => 
                           IR_BUS_19_port, IR_IN(18) => IR_BUS_18_port, 
                           IR_IN(17) => IR_BUS_17_port, IR_IN(16) => 
                           IR_BUS_16_port, IR_IN(15) => IR_BUS_15_port, 
                           IR_IN(14) => IR_BUS_14_port, IR_IN(13) => 
                           IR_BUS_13_port, IR_IN(12) => IR_BUS_12_port, 
                           IR_IN(11) => IR_BUS_11_port, IR_IN(10) => 
                           IR_BUS_10_port, IR_IN(9) => IR_BUS_9_port, IR_IN(8) 
                           => IR_BUS_8_port, IR_IN(7) => IR_BUS_7_port, 
                           IR_IN(6) => IR_BUS_6_port, IR_IN(5) => IR_BUS_5_port
                           , IR_IN(4) => IR_BUS_4_port, IR_IN(3) => 
                           IR_BUS_3_port, IR_IN(2) => IR_BUS_2_port, IR_IN(1) 
                           => IR_BUS_1_port, IR_IN(0) => IR_BUS_0_port, 
                           DRAM_OUT(31) => DATA_OUT_31_port, DRAM_OUT(30) => 
                           DATA_OUT_30_port, DRAM_OUT(29) => DATA_OUT_29_port, 
                           DRAM_OUT(28) => DATA_OUT_28_port, DRAM_OUT(27) => 
                           DATA_OUT_27_port, DRAM_OUT(26) => DATA_OUT_26_port, 
                           DRAM_OUT(25) => DATA_OUT_25_port, DRAM_OUT(24) => 
                           DATA_OUT_24_port, DRAM_OUT(23) => DATA_OUT_23_port, 
                           DRAM_OUT(22) => DATA_OUT_22_port, DRAM_OUT(21) => 
                           DATA_OUT_21_port, DRAM_OUT(20) => DATA_OUT_20_port, 
                           DRAM_OUT(19) => DATA_OUT_19_port, DRAM_OUT(18) => 
                           DATA_OUT_18_port, DRAM_OUT(17) => DATA_OUT_17_port, 
                           DRAM_OUT(16) => DATA_OUT_16_port, DRAM_OUT(15) => 
                           DATA_OUT_15_port, DRAM_OUT(14) => DATA_OUT_14_port, 
                           DRAM_OUT(13) => DATA_OUT_13_port, DRAM_OUT(12) => 
                           DATA_OUT_12_port, DRAM_OUT(11) => DATA_OUT_11_port, 
                           DRAM_OUT(10) => DATA_OUT_10_port, DRAM_OUT(9) => 
                           DATA_OUT_9_port, DRAM_OUT(8) => DATA_OUT_8_port, 
                           DRAM_OUT(7) => DATA_OUT_7_port, DRAM_OUT(6) => 
                           DATA_OUT_6_port, DRAM_OUT(5) => DATA_OUT_5_port, 
                           DRAM_OUT(4) => DATA_OUT_4_port, DRAM_OUT(3) => 
                           DATA_OUT_3_port, DRAM_OUT(2) => DATA_OUT_2_port, 
                           DRAM_OUT(1) => DATA_OUT_1_port, DRAM_OUT(0) => 
                           DATA_OUT_0_port, IR_LATCH_EN => IR_LATCH_EN_i, 
                           PC_LATCH_EN => PC_LATCH_EN_i, NPC_LATCH_EN => 
                           NPC_LATCH_EN_i, RF_WE => RF_WE_i, RegA_LATCH_EN => 
                           RegA_LATCH_EN_i, RegB_LATCH_EN => RegB_LATCH_EN_i, 
                           RegIMM_LATCH_EN => RegIMM_LATCH_EN_i, MUXA_SEL => 
                           MUXA_SEL_i, MUXB_SEL => MUXB_SEL_i, ALU_OUTREG_EN =>
                           ALU_OUTREG_EN_i, EQ_COND => EQ_COND_i, ALU_OPCODE(0)
                           => ALU_OPCODE_i_0_port, ALU_OPCODE(1) => 
                           ALU_OPCODE_i_1_port, ALU_OPCODE(2) => 
                           ALU_OPCODE_i_2_port, ALU_OPCODE(3) => 
                           ALU_OPCODE_i_3_port, ALU_OPCODE(4) => 
                           ALU_OPCODE_i_4_port, ALU_OPCODE(5) => 
                           ALU_OPCODE_i_5_port, ALU_OPCODE(6) => 
                           ALU_OPCODE_i_6_port, DRAM_RE => DRAM_RE_i, DRAM_WE 
                           => DRAM_WE_i, LMD_LATCH_EN => LMD_LATCH_EN_i, 
                           JUMP_EN => JUMP_EN_i, JUMP_COND => JUMP_COND_i, 
                           WB_MUX_SEL => WB_MUX_SEL_i, IR_OUT(31) => IR_31_port
                           , IR_OUT(30) => IR_30_port, IR_OUT(29) => IR_29_port
                           , IR_OUT(28) => IR_28_port, IR_OUT(27) => IR_27_port
                           , IR_OUT(26) => IR_26_port, IR_OUT(25) => IR_25_port
                           , IR_OUT(24) => IR_24_port, IR_OUT(23) => IR_23_port
                           , IR_OUT(22) => IR_22_port, IR_OUT(21) => IR_21_port
                           , IR_OUT(20) => IR_20_port, IR_OUT(19) => IR_19_port
                           , IR_OUT(18) => IR_18_port, IR_OUT(17) => IR_17_port
                           , IR_OUT(16) => IR_16_port, IR_OUT(15) => IR_15_port
                           , IR_OUT(14) => IR_14_port, IR_OUT(13) => IR_13_port
                           , IR_OUT(12) => IR_12_port, IR_OUT(11) => IR_11_port
                           , IR_OUT(10) => IR_10_port, IR_OUT(9) => IR_9_port, 
                           IR_OUT(8) => IR_8_port, IR_OUT(7) => IR_7_port, 
                           IR_OUT(6) => IR_6_port, IR_OUT(5) => IR_5_port, 
                           IR_OUT(4) => IR_4_port, IR_OUT(3) => IR_3_port, 
                           IR_OUT(2) => IR_2_port, IR_OUT(1) => IR_1_port, 
                           IR_OUT(0) => IR_0_port, PC_OUT(31) => PC_31_port, 
                           PC_OUT(30) => PC_30_port, PC_OUT(29) => PC_29_port, 
                           PC_OUT(28) => PC_28_port, PC_OUT(27) => PC_27_port, 
                           PC_OUT(26) => PC_26_port, PC_OUT(25) => PC_25_port, 
                           PC_OUT(24) => PC_24_port, PC_OUT(23) => PC_23_port, 
                           PC_OUT(22) => PC_22_port, PC_OUT(21) => PC_21_port, 
                           PC_OUT(20) => PC_20_port, PC_OUT(19) => PC_19_port, 
                           PC_OUT(18) => PC_18_port, PC_OUT(17) => PC_17_port, 
                           PC_OUT(16) => PC_16_port, PC_OUT(15) => PC_15_port, 
                           PC_OUT(14) => PC_14_port, PC_OUT(13) => PC_13_port, 
                           PC_OUT(12) => PC_12_port, PC_OUT(11) => PC_11_port, 
                           PC_OUT(10) => PC_10_port, PC_OUT(9) => PC_9_port, 
                           PC_OUT(8) => PC_8_port, PC_OUT(7) => PC_7_port, 
                           PC_OUT(6) => PC_6_port, PC_OUT(5) => PC_5_port, 
                           PC_OUT(4) => PC_4_port, PC_OUT(3) => PC_3_port, 
                           PC_OUT(2) => PC_2_port, PC_OUT(1) => PC_1_port, 
                           PC_OUT(0) => PC_0_port, ALU_OUT(31) => 
                           DATA_ADDR_31_port, ALU_OUT(30) => DATA_ADDR_30_port,
                           ALU_OUT(29) => DATA_ADDR_29_port, ALU_OUT(28) => 
                           DATA_ADDR_28_port, ALU_OUT(27) => DATA_ADDR_27_port,
                           ALU_OUT(26) => DATA_ADDR_26_port, ALU_OUT(25) => 
                           DATA_ADDR_25_port, ALU_OUT(24) => DATA_ADDR_24_port,
                           ALU_OUT(23) => DATA_ADDR_23_port, ALU_OUT(22) => 
                           DATA_ADDR_22_port, ALU_OUT(21) => DATA_ADDR_21_port,
                           ALU_OUT(20) => DATA_ADDR_20_port, ALU_OUT(19) => 
                           DATA_ADDR_19_port, ALU_OUT(18) => DATA_ADDR_18_port,
                           ALU_OUT(17) => DATA_ADDR_17_port, ALU_OUT(16) => 
                           DATA_ADDR_16_port, ALU_OUT(15) => DATA_ADDR_15_port,
                           ALU_OUT(14) => DATA_ADDR_14_port, ALU_OUT(13) => 
                           DATA_ADDR_13_port, ALU_OUT(12) => DATA_ADDR_12_port,
                           ALU_OUT(11) => DATA_ADDR_11_port, ALU_OUT(10) => 
                           DATA_ADDR_10_port, ALU_OUT(9) => DATA_ADDR_9_port, 
                           ALU_OUT(8) => DATA_ADDR_8_port, ALU_OUT(7) => 
                           DATA_ADDR_7_port, ALU_OUT(6) => DATA_ADDR_6_port, 
                           ALU_OUT(5) => DATA_ADDR_5_port, ALU_OUT(4) => 
                           DATA_ADDR_4_port, ALU_OUT(3) => DATA_ADDR_3_port, 
                           ALU_OUT(2) => DATA_ADDR_2_port, ALU_OUT(1) => 
                           DATA_ADDR_1_port, ALU_OUT(0) => DATA_ADDR_0_port, 
                           DRAM_IN(31) => DATA_IN_31_port, DRAM_IN(30) => 
                           DATA_IN_30_port, DRAM_IN(29) => DATA_IN_29_port, 
                           DRAM_IN(28) => DATA_IN_28_port, DRAM_IN(27) => 
                           DATA_IN_27_port, DRAM_IN(26) => DATA_IN_26_port, 
                           DRAM_IN(25) => DATA_IN_25_port, DRAM_IN(24) => 
                           DATA_IN_24_port, DRAM_IN(23) => DATA_IN_23_port, 
                           DRAM_IN(22) => DATA_IN_22_port, DRAM_IN(21) => 
                           DATA_IN_21_port, DRAM_IN(20) => DATA_IN_20_port, 
                           DRAM_IN(19) => DATA_IN_19_port, DRAM_IN(18) => 
                           DATA_IN_18_port, DRAM_IN(17) => DATA_IN_17_port, 
                           DRAM_IN(16) => DATA_IN_16_port, DRAM_IN(15) => 
                           DATA_IN_15_port, DRAM_IN(14) => DATA_IN_14_port, 
                           DRAM_IN(13) => DATA_IN_13_port, DRAM_IN(12) => 
                           DATA_IN_12_port, DRAM_IN(11) => DATA_IN_11_port, 
                           DRAM_IN(10) => DATA_IN_10_port, DRAM_IN(9) => 
                           DATA_IN_9_port, DRAM_IN(8) => DATA_IN_8_port, 
                           DRAM_IN(7) => DATA_IN_7_port, DRAM_IN(6) => 
                           DATA_IN_6_port, DRAM_IN(5) => DATA_IN_5_port, 
                           DRAM_IN(4) => DATA_IN_4_port, DRAM_IN(3) => 
                           DATA_IN_3_port, DRAM_IN(2) => DATA_IN_2_port, 
                           DRAM_IN(1) => DATA_IN_1_port, DRAM_IN(0) => 
                           DATA_IN_0_port);
   IRAM_I : DLX_IRAM_RAM_DEPTH256_I_SIZE32 port map( RST => RST, ADDR(31) => 
                           PC_31_port, ADDR(30) => PC_30_port, ADDR(29) => 
                           PC_29_port, ADDR(28) => PC_28_port, ADDR(27) => 
                           PC_27_port, ADDR(26) => PC_26_port, ADDR(25) => 
                           PC_25_port, ADDR(24) => PC_24_port, ADDR(23) => 
                           PC_23_port, ADDR(22) => PC_22_port, ADDR(21) => 
                           PC_21_port, ADDR(20) => PC_20_port, ADDR(19) => 
                           PC_19_port, ADDR(18) => PC_18_port, ADDR(17) => 
                           PC_17_port, ADDR(16) => PC_16_port, ADDR(15) => 
                           PC_15_port, ADDR(14) => PC_14_port, ADDR(13) => 
                           PC_13_port, ADDR(12) => PC_12_port, ADDR(11) => 
                           PC_11_port, ADDR(10) => PC_10_port, ADDR(9) => 
                           PC_9_port, ADDR(8) => PC_8_port, ADDR(7) => 
                           PC_7_port, ADDR(6) => PC_6_port, ADDR(5) => 
                           PC_5_port, ADDR(4) => PC_4_port, ADDR(3) => 
                           PC_3_port, ADDR(2) => PC_2_port, ADDR(1) => 
                           PC_1_port, ADDR(0) => PC_0_port, DOUT(31) => 
                           IR_BUS_31_port, DOUT(30) => IR_BUS_30_port, DOUT(29)
                           => IR_BUS_29_port, DOUT(28) => IR_BUS_28_port, 
                           DOUT(27) => IR_BUS_27_port, DOUT(26) => 
                           IR_BUS_26_port, DOUT(25) => IR_BUS_25_port, DOUT(24)
                           => IR_BUS_24_port, DOUT(23) => IR_BUS_23_port, 
                           DOUT(22) => IR_BUS_22_port, DOUT(21) => 
                           IR_BUS_21_port, DOUT(20) => IR_BUS_20_port, DOUT(19)
                           => IR_BUS_19_port, DOUT(18) => IR_BUS_18_port, 
                           DOUT(17) => IR_BUS_17_port, DOUT(16) => 
                           IR_BUS_16_port, DOUT(15) => IR_BUS_15_port, DOUT(14)
                           => IR_BUS_14_port, DOUT(13) => IR_BUS_13_port, 
                           DOUT(12) => IR_BUS_12_port, DOUT(11) => 
                           IR_BUS_11_port, DOUT(10) => IR_BUS_10_port, DOUT(9) 
                           => IR_BUS_9_port, DOUT(8) => IR_BUS_8_port, DOUT(7) 
                           => IR_BUS_7_port, DOUT(6) => IR_BUS_6_port, DOUT(5) 
                           => IR_BUS_5_port, DOUT(4) => IR_BUS_4_port, DOUT(3) 
                           => IR_BUS_3_port, DOUT(2) => IR_BUS_2_port, DOUT(1) 
                           => IR_BUS_1_port, DOUT(0) => IR_BUS_0_port);
   DRAM_I : DLX_DRAM_N256_NW32 port map( CLK => CLK, RST => RST, RE => 
                           DRAM_RE_i, WE => DRAM_WE_i, ADDR(31) => 
                           DATA_ADDR_31_port, ADDR(30) => DATA_ADDR_30_port, 
                           ADDR(29) => DATA_ADDR_29_port, ADDR(28) => 
                           DATA_ADDR_28_port, ADDR(27) => DATA_ADDR_27_port, 
                           ADDR(26) => DATA_ADDR_26_port, ADDR(25) => 
                           DATA_ADDR_25_port, ADDR(24) => DATA_ADDR_24_port, 
                           ADDR(23) => DATA_ADDR_23_port, ADDR(22) => 
                           DATA_ADDR_22_port, ADDR(21) => DATA_ADDR_21_port, 
                           ADDR(20) => DATA_ADDR_20_port, ADDR(19) => 
                           DATA_ADDR_19_port, ADDR(18) => DATA_ADDR_18_port, 
                           ADDR(17) => DATA_ADDR_17_port, ADDR(16) => 
                           DATA_ADDR_16_port, ADDR(15) => DATA_ADDR_15_port, 
                           ADDR(14) => DATA_ADDR_14_port, ADDR(13) => 
                           DATA_ADDR_13_port, ADDR(12) => DATA_ADDR_12_port, 
                           ADDR(11) => DATA_ADDR_11_port, ADDR(10) => 
                           DATA_ADDR_10_port, ADDR(9) => DATA_ADDR_9_port, 
                           ADDR(8) => DATA_ADDR_8_port, ADDR(7) => 
                           DATA_ADDR_7_port, ADDR(6) => DATA_ADDR_6_port, 
                           ADDR(5) => DATA_ADDR_5_port, ADDR(4) => 
                           DATA_ADDR_4_port, ADDR(3) => DATA_ADDR_3_port, 
                           ADDR(2) => DATA_ADDR_2_port, ADDR(1) => 
                           DATA_ADDR_1_port, ADDR(0) => DATA_ADDR_0_port, 
                           DIN(31) => DATA_IN_31_port, DIN(30) => 
                           DATA_IN_30_port, DIN(29) => DATA_IN_29_port, DIN(28)
                           => DATA_IN_28_port, DIN(27) => DATA_IN_27_port, 
                           DIN(26) => DATA_IN_26_port, DIN(25) => 
                           DATA_IN_25_port, DIN(24) => DATA_IN_24_port, DIN(23)
                           => DATA_IN_23_port, DIN(22) => DATA_IN_22_port, 
                           DIN(21) => DATA_IN_21_port, DIN(20) => 
                           DATA_IN_20_port, DIN(19) => DATA_IN_19_port, DIN(18)
                           => DATA_IN_18_port, DIN(17) => DATA_IN_17_port, 
                           DIN(16) => DATA_IN_16_port, DIN(15) => 
                           DATA_IN_15_port, DIN(14) => DATA_IN_14_port, DIN(13)
                           => DATA_IN_13_port, DIN(12) => DATA_IN_12_port, 
                           DIN(11) => DATA_IN_11_port, DIN(10) => 
                           DATA_IN_10_port, DIN(9) => DATA_IN_9_port, DIN(8) =>
                           DATA_IN_8_port, DIN(7) => DATA_IN_7_port, DIN(6) => 
                           DATA_IN_6_port, DIN(5) => DATA_IN_5_port, DIN(4) => 
                           DATA_IN_4_port, DIN(3) => DATA_IN_3_port, DIN(2) => 
                           DATA_IN_2_port, DIN(1) => DATA_IN_1_port, DIN(0) => 
                           DATA_IN_0_port, DOUT(31) => DATA_OUT_31_port, 
                           DOUT(30) => DATA_OUT_30_port, DOUT(29) => 
                           DATA_OUT_29_port, DOUT(28) => DATA_OUT_28_port, 
                           DOUT(27) => DATA_OUT_27_port, DOUT(26) => 
                           DATA_OUT_26_port, DOUT(25) => DATA_OUT_25_port, 
                           DOUT(24) => DATA_OUT_24_port, DOUT(23) => 
                           DATA_OUT_23_port, DOUT(22) => DATA_OUT_22_port, 
                           DOUT(21) => DATA_OUT_21_port, DOUT(20) => 
                           DATA_OUT_20_port, DOUT(19) => DATA_OUT_19_port, 
                           DOUT(18) => DATA_OUT_18_port, DOUT(17) => 
                           DATA_OUT_17_port, DOUT(16) => DATA_OUT_16_port, 
                           DOUT(15) => DATA_OUT_15_port, DOUT(14) => 
                           DATA_OUT_14_port, DOUT(13) => DATA_OUT_13_port, 
                           DOUT(12) => DATA_OUT_12_port, DOUT(11) => 
                           DATA_OUT_11_port, DOUT(10) => DATA_OUT_10_port, 
                           DOUT(9) => DATA_OUT_9_port, DOUT(8) => 
                           DATA_OUT_8_port, DOUT(7) => DATA_OUT_7_port, DOUT(6)
                           => DATA_OUT_6_port, DOUT(5) => DATA_OUT_5_port, 
                           DOUT(4) => DATA_OUT_4_port, DOUT(3) => 
                           DATA_OUT_3_port, DOUT(2) => DATA_OUT_2_port, DOUT(1)
                           => DATA_OUT_1_port, DOUT(0) => DATA_OUT_0_port);
   WB_MUX_SEL_i <= '0';
   JUMP_COND_i <= '0';
   JUMP_EN_i <= '0';
   LMD_LATCH_EN_i <= '0';
   DRAM_WE_i <= '0';
   DRAM_RE_i <= '0';
   EQ_COND_i <= '0';
   ALU_OUTREG_EN_i <= '0';
   MUXB_SEL_i <= '0';
   MUXA_SEL_i <= '0';
   RegIMM_LATCH_EN_i <= '0';
   RegB_LATCH_EN_i <= '0';
   RegA_LATCH_EN_i <= '0';
   RF_WE_i <= '0';
   NPC_LATCH_EN_i <= '0';
   PC_LATCH_EN_i <= '0';
   IR_LATCH_EN_i <= '0';

end SYN_DLX_RTL;
