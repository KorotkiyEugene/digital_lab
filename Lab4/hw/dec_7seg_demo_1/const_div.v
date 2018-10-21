module const_div(i_clk, i_rst_n, o_clk);

input           i_clk;
input           i_rst_n;
output  reg     o_clk;

parameter       DIV_BY      = 7;
localparam      CNT_CONST   = DIV_BY - 1;
localparam      N           = $clog2(DIV_BY);

reg     [N-1:0] cnt;

wire    preload_cnt = ~|cnt;

always @(posedge i_clk)
    o_clk <= preload_cnt;

always @(posedge i_clk, negedge i_rst_n) begin
    if(~i_rst_n) begin
        cnt <= CNT_CONST;
    end else begin
        if (preload_cnt)
            cnt <= CNT_CONST;
        else
            cnt <= cnt - 1'b1;
    end
end

endmodule

