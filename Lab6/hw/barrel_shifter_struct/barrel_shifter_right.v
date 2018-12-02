module barrel_shifter_right (i_data, i_sa, i_st, o_data);

input          i_st;    // st - shift type (0:logical 1:arithmetic)
input   [7:0]  i_data;
input   [2:0]  i_sa;    // sa -shift amount
output  [7:0]  o_data;

wire    [7:0]  mux0_to_mux1;
wire    [7:0]  mux1_to_mux2;

mux_2in1_type2 #(.WIDTH(8)) mux0(.i_dat0 (i_data), 
                                 .i_dat1 ({i_st & i_data[7], i_data[7:1]}), 
                                 .i_sel (i_sa[0]), 
                                 .o_dat (mux0_to_mux1)
                                 );

mux_2in1_type2 #(.WIDTH(8)) mux1(.i_dat0 (mux0_to_mux1), 
                                 .i_dat1 ({ {2{i_st & mux0_to_mux1[7]}}, mux0_to_mux1[7:2]}), 
                                 .i_sel (i_sa[1]), 
                                 .o_dat (mux1_to_mux2)
                                 );

mux_2in1_type2 #(.WIDTH(8)) mux2(.i_dat0 (mux1_to_mux2), 
                                 .i_dat1 ({ {4{i_st & mux1_to_mux2[7]}}, mux1_to_mux2[7:4]}), 
                                 .i_sel (i_sa[2]), 
                                 .o_dat (o_data)
                                 );

endmodule

