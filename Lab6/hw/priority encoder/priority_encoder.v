module priority_encoder (i_one_hot, o_bin, o_active);

parameter ONEHOT_WIDTH = 16;
parameter BIN_WIDTH = $clog2(ONEHOT_WIDTH);

input       [ONEHOT_WIDTH-1:0]  i_one_hot;
output reg  [BIN_WIDTH-1:0]     o_bin;
output                          o_active;

integer i = 0;

assign o_active = |i_one_hot;

always @* begin

    o_bin = 0;

    for (i=0; i<ONEHOT_WIDTH; i=i+1)
        if (i_one_hot[i])
            o_bin = i;

end

endmodule
