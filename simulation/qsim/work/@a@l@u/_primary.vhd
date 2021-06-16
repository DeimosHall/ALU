library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        C               : in     vl_logic;
        D               : in     vl_logic;
        buss            : in     vl_logic_vector(3 downto 0);
        led             : out    vl_logic;
        resultado       : out    vl_logic_vector(7 downto 0);
        display         : out    vl_logic_vector(6 downto 0)
    );
end ALU;
