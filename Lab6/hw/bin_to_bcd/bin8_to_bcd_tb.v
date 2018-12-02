`timescale 1ns / 1ps

module testbench;

parameter DELAY = 20;

reg   [7:0]   bin;
wire  [11:0]  bcd;

integer i;

bin8_to_bcd bin2bcd_inst (.i_bin (bin), 
                          .o_bcd (bcd)
                          );

initial begin
    
    for (i=0; i<256; i=i+1) begin
        bin = i;
        #DELAY;
    end

    $finish;

end

endmodule

