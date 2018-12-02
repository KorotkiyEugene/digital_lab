`timescale 1 ns / 1 ps

module testbench;

parameter DELAY = 20;

reg     [15:0]  one_hot;
wire    [3:0]   bin;
wire            active;

priority_encoder #(.ONEHOT_WIDTH(16)) enc_inst(.i_one_hot (one_hot), 
                                                .o_bin (bin),
                                                .o_active (active)
                                                );

initial begin
    
    one_hot = 16'b0;
    #DELAY;

    one_hot = 16'b1;

    repeat (15) begin
        #DELAY;
        one_hot = one_hot << 1;
    end

    repeat (100) begin
        #DELAY;
        one_hot = $random;
    end

    $finish;

end

endmodule
