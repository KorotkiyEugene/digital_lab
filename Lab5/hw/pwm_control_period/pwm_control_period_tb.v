`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 20;
parameter PWM_WIDTH = 10;

wire                o_pwm;
reg                 i_clk;
reg [PWM_WIDTH-1:0] i_period;       // max val for pwm counter
reg [PWM_WIDTH-1:0] i_duty_cyle;    // i_duty_cyle should be less or equal then i_period

integer i = 0;
integer j = 0;

pwm_control_period #(.PWM_WIDTH(PWM_WIDTH)) pwm_inst(.i_clk (i_clk), 
                                                    .i_period (i_period), 
                                                    .i_duty_cyle (i_duty_cyle), 
                                                    .o_pwm (o_pwm)
                                                    );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_duty_cyle = 0;
    i_period = 0;

    repeat(10) @(negedge i_clk);

    for (j=PWM_WIDTH/2; j<=PWM_WIDTH; j=j+1) begin

        i_period = (1'b1<<j) - 1'b1;
        @(negedge i_clk);
        
        for (i=0; i<=i_period; i=i+1) begin   
            i_duty_cyle = i;      
            repeat (5*(i_period + 1)) @(negedge i_clk);
        end

    end

    $finish;  
end
  
endmodule
