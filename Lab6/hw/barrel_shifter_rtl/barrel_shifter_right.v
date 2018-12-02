module barrel_shifter_right (i_data, i_sa, i_st, o_data);

parameter DATA_WIDTH = 10;
parameter SA_WIDTH = $clog2(DATA_WIDTH);

input                     i_st;    // st - shift type (0:logical 1:arithmetic)
input   [DATA_WIDTH-1:0]  i_data;
input   [SA_WIDTH-1:0]    i_sa;    // sa -shift amount
output  [DATA_WIDTH-1:0]  o_data;

reg     [DATA_WIDTH-1:0]  shift_result;

always @* begin
    shift_result = $signed({ (i_st & i_data[DATA_WIDTH-1]) , i_data}) >>> i_sa;
end

assign o_data = shift_result;

endmodule

