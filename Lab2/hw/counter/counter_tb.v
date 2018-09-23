`timescale 1ns / 1ps

module counter_tb;

parameter PERIOD = 20;

reg         i_clk, i_rst_n;
wire [9:0]  o_cnt_dat;

counter cnt_inst(.MAX10_CLK1_50(i_clk), 
                    .KEY ({i_rst_n, 1'b0}), 
                    .LEDR (o_cnt_dat)
                );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;

    @(negedge i_clk) i_rst_n = 1;

    repeat (2000) @(negedge i_clk);

    $finish;  
end
  
endmodule
