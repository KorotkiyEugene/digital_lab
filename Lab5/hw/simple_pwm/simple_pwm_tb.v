`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;

wire [35:0] gpio;
wire        o_pwm;
reg         i_clk;
reg         i_pwm_en;
reg [9:0]   i_pwm_dc;

integer i = 0;

simple_pwm simple_pwm_inst (.MAX10_CLK1_50 (i_clk), 
                            .KEY ({1'b0, i_pwm_en}), 
                            .SW (i_pwm_dc), 
                            .GPIO (gpio)
                           );

assign o_pwm = gpio[0];

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_pwm_dc = 0;

    repeat(10) @(negedge i_clk);

    for (i=0; i<1024; i=i+1) begin   
        i_pwm_dc = i;   
        i_pwm_en = $random();      
        repeat (5*1024) @(negedge i_clk);
    end

    $finish;  
end
  
endmodule
