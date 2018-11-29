`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;
parameter DIV_BY = 7;

wire [35:0] gpio;        
wire        o_clk;
reg         i_clk, i_rst_n;
reg [9:0]   i_div_by;

integer i = 0;

prog_div prog_div_inst(.MAX10_CLK1_50(i_clk), 
                        .KEY ({i_rst_n, 1'b0}),
                        .SW (i_div_by), 
                        .GPIO (gpio)
                        );

assign o_clk = gpio[0];

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;
    i_div_by = 0;

    @(negedge i_clk) i_rst_n = 1;

    repeat(10) @(negedge i_clk);

    for (i=1; i<1024; i=i+1) begin   
        i_div_by = i;         
        repeat(5*i) @(negedge i_clk);
    end

    $finish;  
end
  
endmodule
