module pwm_control_period (i_clk, i_period, i_duty_cyle, o_pwm);

parameter PWM_WIDTH = 10;

input                   i_clk;
input   [PWM_WIDTH-1:0] i_period;       // max val for pwm counter
input   [PWM_WIDTH-1:0] i_duty_cyle;    // i_duty_cyle should be less or equal then i_period
output                  o_pwm;

reg     [PWM_WIDTH-1:0] cnt_ff  = 0;
reg     [PWM_WIDTH-1:0] duty_cyle_ff = 0;
reg     [PWM_WIDTH-1:0] period_ff = 0;
reg                     out_ff  = 1'b0;

always @(posedge i_clk) begin
    period_ff    <= i_period;
    duty_cyle_ff <= i_duty_cyle;
end

always @(posedge i_clk)
    if(cnt_ff == period_ff)
        cnt_ff <= 0;
    else 
        cnt_ff <= cnt_ff + 1'b1;

always @(posedge i_clk)
    out_ff <= (cnt_ff < duty_cyle_ff);

assign o_pwm = out_ff;

endmodule

