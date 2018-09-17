module counter(MAX10_CLK1_50, KEY, LEDR);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
output  [9:0]   LEDR;

reg     [9:0] cnt;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];

assign LEDR = cnt;

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt <= 10'd0;
    end else begin
        cnt <= cnt + 1'b1;
    end
end


endmodule

