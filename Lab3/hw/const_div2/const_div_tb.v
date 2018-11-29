`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;
parameter DIV_BY = 7;

reg         i_clk, i_rst_n;
wire        o_clk;
wire [35:0] gpio;

const_div #(.DIV_BY(DIV_BY)) const_div_inst(.MAX10_CLK1_50(i_clk), 
                                            .KEY ({i_rst_n, 1'b0}), 
                                            .GPIO (gpio)
                                            );

assign o_clk = gpio[0];

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;

    @(negedge i_clk) i_rst_n = 1;

    repeat (30) @(negedge i_clk);

    $finish;  
end
  
endmodule
