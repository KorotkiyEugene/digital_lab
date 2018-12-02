module decoder (i_bin, o_one_hot);

parameter ONE_HOT_WIDTH = 8;
parameter BIN_WIDTH = $clog2(ONE_HOT_WIDTH);

input       [BIN_WIDTH-1:0]     i_bin;
output reg  [ONE_HOT_WIDTH-1:0] o_one_hot;

always @* begin
    o_one_hot = 0;
    o_one_hot[i_bin] = 1'b1;
end

endmodule

