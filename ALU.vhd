library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is

	port (A, B: in std_logic_vector(3 downto 0);
			C, D: in std_ulogic;
			buss: in std_logic_vector(4 downto 0);
			A2: out std_logic_vector(3 downto 0);
			led: out std_logic := '0';
			resultado: out std_logic_vector(7 downto 0);
			display: out std_logic_vector(6 downto 0));

end ALU;

architecture behavioral of ALU is

begin

	process(A, B, buss) begin
		case buss is
			when "00000" => -- Suma
				resultado <= "000" & ('0' & A) + ('0' & B);
			when "00001" => -- Resta
				if(A < B) then
					resultado <= "000" & ('0' & B) - ('0' & A);
					led <= '1';
				else
					resultado <= "000" & ('0' & A) - ('0' & B);
					led <=  '0';
				end if;
			when "00010" => -- Multiplicacion
				resultado <= std_logic_vector(unsigned(A) * unsigned(B));
			when "00011" => -- Division
				resultado <= "0000" & std_logic_vector(unsigned(A) / unsigned(B));
			when "00100" => -- Incremento
				resultado <= "000" & (('0' & A) + 1);
			when "00101" => -- Decremento
				if(A = 0) then
					resultado <= "00000001";
					led <= '1';
				else
					resultado <= "000" & (('0' & A) - 1);
				end if;
			when "00110" =>
				resultado <= "0000000" & (C and D);
			when "00111" =>
				resultado <= "0000000" & (C or D);
			when "01000" =>
				resultado <= "0000000" & (C nor D);
			when "01001" =>
				resultado <= "0000000" & (C nand D);
			when "01010" =>
				resultado <= "0000000" & (C xor D);
			when "01011" =>
				resultado <= "0000000" & (C xnor D);
			when "01100" =>
				resultado <= "0000000" & (not C);
			when "01101" =>
				A2 <= std_logic_vector(unsigned(A) SLL to_integer(unsigned(B)));
			when "01110" =>
				A2 <= std_logic_vector(unsigned(A) SRL to_integer(unsigned(B)));
			when "01111" =>
--				A2 <= std_logic_vector(unsigned(A) SLA to_integer(unsigned(B)));
			when "10000" =>
				
			when "10001" =>
				
			when "10010" =>
				
			when others =>
		end case;
	end process;
	
end behavioral;