module simple_pwm (MAX10_CLK1_50, KEY, SW, GPIO);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
input   [9:0]   SW;
inout   [35:0]  GPIO;

wire            sys_clk = MAX10_CLK1_50;

reg     [9:0]   cnt_ff  = 0;
reg     [9:0]   dc_ff   = 0;
reg             out_ff  = 1'b1;
reg             en_ff   = 1'b1;

always @(posedge sys_clk) begin
    en_ff <= KEY[0];
    dc_ff <= SW;
end

always @(posedge sys_clk)
    if(en_ff)
        cnt_ff <= cnt_ff + 1'b1;

always @(posedge sys_clk)
    out_ff <= (cnt_ff < dc_ff);

assign GPIO[0] = out_ff;

endmodule

