library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ENCODER is

	port	(	B:	in	std_logic_vector(2 downto 0);
			Y:	out	std_logic_vector(2 downto 0));

end ENCODER;

architecture BEHAVIORAL of ENCODER is 
begin
	process(B)
		begin
			-- Booth's encoding
			case b is
				when "000"	=> Y <= "000"; -- 0
				when "001"	=> Y <= "001"; -- A
				when "010"	=> Y <= "001"; -- A
				when "011"	=> Y <= "011"; -- 2A
				when "100"	=> Y <= "100"; -- -2A
				when "101"	=> Y <= "010"; -- -A
				when "110"	=> Y <= "010"; -- -A
				when "111"	=> Y <= "000"; -- 0
				when others	=> Y <= "ZZZ";
			end case;
	end process;

end architecture BEHAVIORAL;
