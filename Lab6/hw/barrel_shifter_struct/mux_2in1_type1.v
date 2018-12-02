module mux_2in1_type1 (i_dat0, i_dat1, i_sel, o_dat);

parameter WIDTH = 8;

input                i_sel;
input   [WIDTH-1:0]  i_dat0;
input   [WIDTH-1:0]  i_dat1;
output  [WIDTH-1:0]  o_dat;

assign  o_dat = i_sel ? i_dat1 : i_dat0;

endmodule

