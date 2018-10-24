`timescale 1ns / 1ps

module clock_tb;

parameter PERIOD = 20;
parameter DELAY_CYCLES = 60*60*24*10;

reg         i_clk;
reg         i_rst_n;

wire [6:0]  hex0, hex1, hex2, hex3, hex4, hex5;

clock #(.DIV_CONST(10) ) clock_inst(.MAX10_CLK1_50 (i_clk), 
                                 .KEY ({i_rst_n, 1'b0}), 
                                 .HEX0 (hex0),
                                 .HEX1 (hex1),
                                 .HEX2 (hex2),
                                 .HEX3 (hex3),
                                 .HEX4 (hex4),
                                 .HEX5 (hex5)
                                );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin

    i_rst_n = 1'b0;

    @(negedge i_clk) i_rst_n = 1'b1;

    repeat (DELAY_CYCLES) @(negedge i_clk);

    $finish;

end

endmodule

