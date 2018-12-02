module enc8in (i_one_hot, o_bin, o_active);

input       [7:0] i_one_hot;
output reg  [2:0] o_bin;
output reg        o_active;

always @* begin
    o_bin[0] = i_one_hot[1] | i_one_hot[3] | i_one_hot[5] | i_one_hot[7];
    o_bin[1] = i_one_hot[2] | i_one_hot[3] | i_one_hot[6] | i_one_hot[7];
    o_bin[2] = i_one_hot[4] | i_one_hot[5] | i_one_hot[6] | i_one_hot[7];
    o_active = |i_one_hot;
end

endmodule

