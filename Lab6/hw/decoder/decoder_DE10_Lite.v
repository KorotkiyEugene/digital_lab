module decoder_DE10_Lite (SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

decoder #(.ONE_HOT_WIDTH(10)) dec_inst(.i_bin (SW[3:0]), 
                                       .o_one_hot (LEDR)
                                       );

endmodule

