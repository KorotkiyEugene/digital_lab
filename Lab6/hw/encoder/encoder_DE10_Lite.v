module encoder_DE10_Lite (SW, HEX0, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;
output  [6:0]   HEX0;

wire    [2:0]   bin;

enc8in enc_inst(.i_one_hot (SW[7:0]), 
                .o_bin (bin),
                .o_active (LEDR[0])
                );

dec_7seg    ind_hex0(.i_dat ({1'b0, bin}), 
                     .o_seg (HEX0)
                    );

endmodule

