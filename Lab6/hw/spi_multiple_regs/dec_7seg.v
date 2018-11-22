module dec_7seg(i_dat, o_seg);

input       [3:0]   i_dat;
output  reg [6:0]   o_seg;

always @* begin

    case (i_dat)

        4'h0: o_seg = 7'b1000000;
        4'h1: o_seg = 7'b1111001;
        4'h2: o_seg = 7'b0100100;
        4'h3: o_seg = 7'b0110000;
        4'h4: o_seg = 7'b0011001;
        4'h5: o_seg = 7'b0010010;
        4'h6: o_seg = 7'b0000010;
        4'h7: o_seg = 7'b1111000;
        4'h8: o_seg = 7'b0000000;
        4'h9: o_seg = 7'b0011000;
        4'hA: o_seg = 7'b0001000;
        4'hB: o_seg = 7'b0000011;
        4'hC: o_seg = 7'b1000110;
        4'hD: o_seg = 7'b0100001;
        4'hE: o_seg = 7'b0000110;
        4'hF: o_seg = 7'b0001110;

    endcase

end


endmodule

