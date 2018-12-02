module mux_2in1_type2 (i_dat0, i_dat1, i_sel, o_dat);

parameter WIDTH = 8;

input                    i_sel;
input       [WIDTH-1:0]  i_dat0;
input       [WIDTH-1:0]  i_dat1;
output reg  [WIDTH-1:0]  o_dat;

always @* begin
    if (i_sel)
        o_dat = i_dat1;
    else
        o_dat = i_dat0;
end

endmodule

