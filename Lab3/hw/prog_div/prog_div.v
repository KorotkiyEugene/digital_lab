module prog_div(MAX10_CLK1_50, KEY, SW, GPIO);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
input   [9:0]   SW;
output  [35:0]  GPIO;

reg     [9:0]   cnt_ff;
reg     [9:0]   div_const_ff;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];
wire    preload_cnt = ~|cnt_ff;

assign GPIO[0] = preload_cnt;

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        div_const_ff <= 1;
    end else begin
        div_const_ff <= SW; //for simplicity here we don't use synchronization
    end
end

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt_ff <= 0;
    end else begin
        if (preload_cnt)
            cnt_ff <= div_const_ff;
        else
            cnt_ff <= cnt_ff - 1'b1;
    end
end

endmodule

