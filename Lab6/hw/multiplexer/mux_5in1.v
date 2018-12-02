module mux_5in1 (i_dat0, i_dat1, i_dat2, i_dat3, i_dat4, i_sel, o_dat);

parameter WIDTH = 8;

input       [2:0]        i_sel;
input       [WIDTH-1:0]  i_dat0, i_dat1, i_dat2, i_dat3, i_dat4;
output reg  [WIDTH-1:0]  o_dat;

always @* begin

    o_dat = 0;

    case (i_sel)

    3'd0: o_dat = i_dat0;

    3'd1: o_dat = i_dat1;

    3'd2: o_dat = i_dat2;

    3'd3: o_dat = i_dat3;

    3'd4: o_dat = i_dat4;

    endcase

end

endmodule

