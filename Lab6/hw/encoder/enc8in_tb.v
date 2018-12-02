`timescale 1 ns / 1 ps

module testbench;

parameter DELAY = 20;

reg     [7:0] one_hot;
wire    [2:0] bin;
wire          active;

enc8in enc_inst(.i_one_hot (one_hot), 
                .o_bin (bin),
                .o_active (active)
                );

initial begin
    
    one_hot = 8'b0;
    #DELAY;

    one_hot = 8'b1;

    repeat (7) begin
        #DELAY;
        one_hot = one_hot << 1;
    end

    repeat (30) begin
        #DELAY;
        one_hot = $random;
    end

    $finish;

end

endmodule
