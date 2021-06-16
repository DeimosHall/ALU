library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is

	port (A, B: in std_logic_vector(3 downto 0);
			C, D: in std_ulogic;
			buss: in std_logic_vector(3 downto 0);
			led: out std_logic := '0';
			resultado: out std_logic_vector(7 downto 0);
			display: out std_logic_vector(6 downto 0));

end ALU;

architecture behavioral of ALU is
	
begin

	process(A, B, buss) begin
		case buss is
			when "0000" =>
				resultado <= "000" & ('0' & A) + ('0' & B);
			when "0001" =>
				if(A < B) then
					resultado <= "000" & ('0' & B) - ('0' & A);
					led <= '1';
				else
					resultado <= "000" & ('0' & A) - ('0' & B);
					led <=  '0';
				end if;
			when "0010" =>
				resultado <= std_logic_vector(unsigned(A) * unsigned(B));
			when "0011" =>
				resultado <= "0000" & std_logic_vector(unsigned(A) / unsigned(B));
			when "0100" =>
				resultado <= "000" & (('0' & A) + 1);
			when "0101" =>
				if(A = 0) then
					resultado <= "00000001";
					led <= '1';
				else
					resultado <= "000" & (('0' & A) - 1);
				end if;
			when "0110" =>
				resultado <= "0000000" & (C and D);
			when "0111" =>
				resultado <= "0000000" & (C or D);
			when "1000" =>
				resultado <= "0000000" & (C nor D);
			when "1001" =>
				resultado <= "0000000" & (C nand D);
			when "1010" =>
				resultado <= "0000000" & (C xor D);
			when "1011" =>
				resultado <= "0000000" & (C xnor D);
			when "1100" =>
				resultado <= "0000000" & (not C);
			when others =>
		end case;
	end process;
	
end behavioral;