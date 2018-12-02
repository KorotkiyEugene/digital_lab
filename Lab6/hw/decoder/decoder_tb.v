`timescale 1 ns / 1 ps

module testbench;

parameter DELAY = 20;
parameter DEC_OUT_NUM = 17;

reg     [$clog2(DEC_OUT_NUM)-1:0]   bin;
wire    [DEC_OUT_NUM-1:0]           one_hot;

integer i;

decoder #(.ONE_HOT_WIDTH(DEC_OUT_NUM)) dec_inst(.i_bin (bin), 
                                                .o_one_hot (one_hot)
                                               );

initial begin

    for (i=0; i<DEC_OUT_NUM; i=i+1) begin
        bin = i;
        #DELAY;
    end

    $finish;

end


endmodule

