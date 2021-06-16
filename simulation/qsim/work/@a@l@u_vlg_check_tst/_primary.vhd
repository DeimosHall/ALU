library verilog;
use verilog.vl_types.all;
entity ALU_vlg_check_tst is
    port(
        display         : in     vl_logic_vector(6 downto 0);
        led             : in     vl_logic;
        resultado       : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end ALU_vlg_check_tst;
