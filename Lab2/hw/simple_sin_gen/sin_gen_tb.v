`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;

reg         i_clk, i_rst_n;
wire [3:0]  o_dac;

sin_gen  gen_inst(.MAX10_CLK1_50 (i_clk), 
                    .KEY ({i_rst_n, 1'b0}), 
                    .VGA_R (o_dac)
                    );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;

    @(negedge i_clk) i_rst_n = 1;

    repeat (10000) @(negedge i_clk);

    $finish;  
end
  
endmodule
