module dec_7seg_demo (SW, HEX0);

input   [9:0]   SW;
output  [7:0]   HEX0;  

dec_7seg    dec_7seg_inst(.i_dat (SW[3:0]), 
                          .o_seg (HEX0)
                          );


endmodule

