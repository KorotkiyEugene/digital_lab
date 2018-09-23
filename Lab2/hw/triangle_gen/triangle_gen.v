module triangle_gen(MAX10_CLK1_50, KEY, VGA_R);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
output  [3:0]   VGA_R;

reg     [9:0]   clk_div_cnt;
reg     [3:0]   dac_cnt;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];

assign VGA_R = dac_cnt;

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        clk_div_cnt <= 10'd0;
    end else begin
        clk_div_cnt <= clk_div_cnt + 1'b1;
    end
end

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        dac_cnt <= 4'd0;
    end else begin
        if(&clk_div_cnt)
            dac_cnt <= dac_cnt + 1'b1;
    end
end


endmodule
