module bin8_to_bcd_DE10_Lite (SW, HEX0, HEX1, HEX2);

input   [9:0]   SW;
output  [6:0]   HEX0, HEX1, HEX2;

wire    [11:0]  bcd;

bin8_to_bcd bin2bcd_inst (.i_bin (SW[7:0]), 
                          .o_bcd (bcd)
                          );

dec_7seg    bcd0(.i_dat (bcd[3:0]), 
                 .o_seg (HEX0)
                 );

dec_7seg    bcd1(.i_dat (bcd[7:4]), 
                 .o_seg (HEX1)
                 );

dec_7seg    bcd2(.i_dat (bcd[11:8]), 
                 .o_seg (HEX2)
                 );

endmodule

