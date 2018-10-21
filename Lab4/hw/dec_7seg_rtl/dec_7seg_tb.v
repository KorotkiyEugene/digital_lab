`timescale 1ns / 1ps

module dec_7seg_tb;

parameter DELAY = 20;

reg     [3:0]   bin_code;
wire    [6:0]   segments;

dec_7seg    dec_7seg_inst(.i_dat (bin_code), 
                          .o_seg (segments)
                          );

integer unsigned i;

initial begin

    for (i = 0; i < 16; i = i + 1) begin
        bin_code = i;
        #DELAY;
    end

    $finish;

end

endmodule

