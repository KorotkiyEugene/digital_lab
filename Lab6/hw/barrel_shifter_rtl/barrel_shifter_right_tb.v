`timescale 1ns / 1ps

module testbench;

parameter DATA_WIDTH = 16;
parameter SA_WIDTH = $clog2(DATA_WIDTH);
parameter DELAY = 20;
parameter N = 10_000;

reg                     i_st;    // st - shift type (0:logical 1:arithmetic)
reg   [DATA_WIDTH-1:0]  i_data;
reg   [SA_WIDTH-1:0]    i_sa;    // sa -shift amount
wire  [DATA_WIDTH-1:0]  o_data;

barrel_shifter_right #(.DATA_WIDTH (DATA_WIDTH)) bsr_inst(.i_data (i_data), 
                                                           .i_sa (i_sa), 
                                                           .i_st (i_st), 
                                                           .o_data (o_data)
                                                           );
initial begin

    repeat (N) begin
        i_st    = $random;
        i_sa    = $random;
        i_data  = $random;
        #DELAY;
    end

    $finish;

end

endmodule

