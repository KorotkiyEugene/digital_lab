module dec_7seg_demo (MAX10_CLK1_50, KEY, HEX0);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
output  [7:0]   HEX0;

parameter DIV_CONST = 50_000_000;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1]; 

wire    tick_event;

reg     [3:0]   cnt;

dec_7seg    dec_7seg_inst(.i_dat (cnt), 
                          .o_seg (HEX0)
                          );

const_div #(.DIV_BY(DIV_CONST)) div_inst(.i_clk (sys_clk), 
                                         .i_rst_n (sys_rst_n), 
                                         .o_clk (tick_event)
                                        );

always @(posedge sys_clk, negedge sys_rst_n) begin

    if (~sys_rst_n) begin

        cnt <= 4'd0;

    end else begin

        if (tick_event)
            cnt <= cnt + 1'b1;

    end

end

endmodule

