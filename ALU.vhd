library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is

	port (A, B: in std_logic_vector(3 downto 0);
			C, D: in std_logic;
			salida: out std_logic;
			buss: in std_logic_vector(3 downto 0);
			led: out std_logic := '0';
			resultado: out std_logic_vector(7 downto 0);
			display: out std_logic_vector(6 downto 0));

end ALU;

architecture behavioral of ALU is
	
begin

	process(A,B,buss) begin
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
				salida <= A and B;
			when "0111" =>
				salida <= A or B;
			when "1000" =>
				salida <= A nor B;
			when "1001" =>
				salida <= A nand B;
			when "1010" =>
				salida <= A xor B;
			when "1011" =>
				salida <= A xnor B;
			when "1100" =>
				salida <= not A;
			when others =>
		end case;
	end process;
	
end behavioral;