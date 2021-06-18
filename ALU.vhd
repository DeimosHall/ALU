library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is

	port (clk: in std_logic;
			A, B: in std_logic_vector(3 downto 0);
			buss: in std_logic_vector(4 downto 0);
			A2: out std_logic_vector(3 downto 0);
			led: out std_logic := '0';
			displays: out std_logic_vector(1 downto 0);
			segmentos: out std_logic_vector(6 downto 0));

end ALU;

architecture behavioral of ALU is

	signal resultado: std_logic_vector(7 downto 0) := "00000000";
	signal contador: integer range 0 to 100000;
	signal seleccion: std_logic_vector(1 downto 0) := "00";
	signal mostrarDisplay: std_logic_vector(1 downto 0) := "00";
	signal num1, num2: std_logic_vector(6 downto 0);
	
begin

	process(A, B, buss) begin
		case buss is
			when "00000" => -- Suma
				resultado <= "000" & ('0' & A) + ('0' & B);
				led <= '0';
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
				led <= '0';
			when "00011" => -- Division
				resultado <= "0000" & std_logic_vector(unsigned(A) / unsigned(B));
				led <= '0';
			when "00100" => -- Incremento
				resultado <= "000" & (('0' & A) + 1);
				led <= '0';
			when "00101" => -- Decremento
				if(A = 0) then
					resultado <= "00000001";
					led <= '1';
				else
					resultado <= "000" & (('0' & A) - 1);
					led <= '0';
				end if;
			when "00110" =>
				A2 <= "000" & (A(0) and B(0));
				led <= '0';
			when "00111" =>
				A2 <= "000" & (A(0) or B(0));
				led <= '0';
			when "01000" =>
				A2 <= "000" & (A(0) nor B(0));
				led <= '0';
			when "01001" =>
				A2 <= "000" & (A(0) nand B(0));
				led <= '0';
			when "01010" =>
				A2 <= "000" & (A(0) xor B(0));
				led <= '0';
			when "01011" =>
				A2 <= "000" & (A(0) xnor B(0));
				led <= '0';
			when "01100" =>
				A2 <= "000" & (not A(0));
				led <= '0';
			when "01101" =>
				A2 <= std_logic_vector(unsigned(A) SLL to_integer(unsigned(B)));
				led <= '0';
			when "01110" =>
				A2 <= std_logic_vector(unsigned(A) SRL to_integer(unsigned(B)));
				led <= '0';
			when "01111" =>
				A2 <= to_stdlogicvector(to_bitvector(A) SLA to_integer(unsigned(B)));
				led <= '0';
			when "10000" =>
				A2 <= to_stdlogicvector(to_bitvector(A) SRA to_integer(unsigned(B)));
				led <= '0';
			when "10001" =>
				A2 <= std_logic_vector(unsigned(A) ROL to_integer(unsigned(B)));
				led <= '0';
			when "10010" =>
				A2 <= std_logic_vector(unsigned(A) ROR to_integer(unsigned(B)));
				led <= '0';
			when others => 
		end case;
	end process;
	
	process(clk) begin
		if rising_edge(clk) then
			if contador < 100000 then
				contador <= contador + 1;
			else
				seleccion <= seleccion + 1;
				contador <= 0;
			end if;
		end if;
	end process;
	
	process(seleccion) begin
		case seleccion is
			when "00" => mostrarDisplay <= "01";
			when "01" => mostrarDisplay <= "10";
			when others =>
		end case;
		case mostrarDisplay is
			when "01" => segmentos <= num1;
			when "10" => segmentos <= num2;
			when others =>
		end case;
	end process;
	
	displays <= mostrarDisplay;
	
	-- Para displays anodo común
	with resultado(3 downto 0) select
		num1 <=
		"0000001" when "0000", -- 0
		"1001111" when "0001", -- 1
		"0010010" when "0010", -- 2
		"0000110" when "0011", -- 3
		"1001100" when "0100", -- 4
		"0100100" when "0101", -- 5
		"0100000" when "0110", -- 6
		"0001111" when "0111", -- 7
		"0000000" when "1000", -- 8
		"0001100" when "1001", -- 9
		"0001000" when "1010", -- A
		"0000000" when "1011", -- B
		"0110001" when "1100", -- C
		"0000001" when "1101", -- D
		"0110000" when "1110", -- E
		"0111000" when "1111", -- F
		"1111111" when others;
	
	with resultado(7 downto 4) select
		num2 <=
		"0000001" when "0000", -- 0
		"1001111" when "0001", -- 1
		"0010010" when "0010", -- 2
		"0000110" when "0011", -- 3
		"1001100" when "0100", -- 4
		"0100100" when "0101", -- 5
		"0100000" when "0110", -- 6
		"0001111" when "0111", -- 7
		"0000000" when "1000", -- 8
		"0001100" when "1001", -- 9
		"0001000" when "1010", -- A
		"0000000" when "1011", -- B
		"0110001" when "1100", -- C
		"0000001" when "1101", -- D
		"0110000" when "1110", -- E
		"0111000" when "1111", -- F
		"1111111" when others;
	
end behavioral;

