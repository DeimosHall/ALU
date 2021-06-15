library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is

	port (A, B: in std_logic_vector(3 downto 0);
			buss: in std_logic_vector(1 downto 0);
			led: out std_logic;
			resultado: out std_logic_vector(4 downto 0);
			display: out std_logic_vector(6 downto 0));

end ALU;

architecture behavioral of ALU is

	signal operacion: std_logic_vector(3 downto 0);
	signal tmp: std_logic_vector(4 downto 0);
	signal carry: std_logic;
	
begin

	process(A,B,buss) begin
		case buss is
			when "00" =>
				operacion <= A + B;
			when "01" =>
				if(A - B) < 0 then
					operacion <= B - A;
					led <= '1';
				else
					operacion <= A - B;
				end if;
			when others =>
				operacion <= "0000";
		end case;
	end process;
	
	tmp <= ('0' & A) + ('0' & B);
	carry <= tmp(4);
	resultado <= carry & operacion;
	
end behavioral;