module barrel_shifter_DE10_Lite (KEY, SW, LEDR);

input   [1:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;

barrel_shifter_right bsr_inst(.i_data (SW[7:0]), 
                              .i_sa ({~KEY[0], SW[9:8]}), 
                              .i_st (KEY[1]), 
                              .o_data (LEDR[7:0])
                              );

endmodule

