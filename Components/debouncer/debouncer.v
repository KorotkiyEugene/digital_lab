module debouncer(i_clk, i_button, o_buttton);

parameter CNT_WIDTH = 16;

input   i_clk;
input   i_button;
output  o_buttton;

reg                 but_sync1_ff = 1'b0;
reg                 but_sync2_ff = 1'b0;

reg [CNT_WIDTH-1:0] cnt = 0;
wire                cnt_full = &cnt;

reg                 but_state;
wire                but_new_state = but_sync2_ff;
wire                but_state_dif = but_state ^ but_new_state;

assign o_buttton = but_state;

always @(posedge i_clk)
    but_sync1_ff <= i_button;

always @(posedge i_clk)
    but_sync2_ff <= but_sync1_ff;
    
always @(posedge i_clk)
    if (cnt_full)
        but_state <= ~but_state;
    
always @(posedge i_clk) begin
    if (but_state_dif) begin
        cnt <= cnt + 1'b1;
    end else begin
        cnt <= 0;
    end
end   

endmodule
