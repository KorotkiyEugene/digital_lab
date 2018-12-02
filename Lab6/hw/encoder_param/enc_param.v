module enc_param (i_one_hot, o_bin, o_active);

parameter ONEHOT_WIDTH = 16;
parameter BIN_WIDTH = $clog2(ONEHOT_WIDTH);

input   [ONEHOT_WIDTH-1:0]  i_one_hot;
output  [BIN_WIDTH-1:0]     o_bin;
output                      o_active;

genvar i,j;

assign o_active = |i_one_hot;

generate
	for (j=0; j<BIN_WIDTH; j=j+1)
	begin : jl
		wire [ONEHOT_WIDTH-1:0] tmp_mask;
		for (i=0; i<ONEHOT_WIDTH; i=i+1)
		begin : il
			assign tmp_mask[i] = i[j];
		end
		assign o_bin[j] = |(tmp_mask & i_one_hot);
	end
endgenerate

endmodule
