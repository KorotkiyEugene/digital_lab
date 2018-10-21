`timescale 1ns / 1ps

module dec_7seg_demo_tb;

parameter PERIOD = 20;
parameter DELAY_CYCLES = 16*50_000_000;

reg         i_clk;
reg         i_rst_n;

wire [6:0]  o_seg;

dec_7seg_demo dec_7seg_demo_inst(.MAX10_CLK1_50 (i_clk), 
                                 .KEY ({i_rst_n, 1'b0}), 
                                 .HEX0 (o_seg)
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

