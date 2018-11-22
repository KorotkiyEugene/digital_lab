module const_div(i_clk, i_rst_n, o_clk);

input           i_clk;
input           i_rst_n;
output          o_clk;

parameter       DIV_BY = 7;
localparam      N = $clog2(DIV_BY);

reg     [N-1:0] cnt;

wire    [N-1:0] cnt_max      = (DIV_BY-1);
wire            sync_rst_cnt = (cnt_max== cnt);

assign o_clk = sync_rst_cnt;

always @(posedge i_clk, negedge i_rst_n) begin
    if(~i_rst_n) begin
        cnt <= 0;
    end else begin
        if (sync_rst_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1'b1;
    end
end

endmodule
