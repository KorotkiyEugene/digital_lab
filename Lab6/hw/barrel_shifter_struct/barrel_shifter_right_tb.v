`timescale 1ns / 1ps

module testbench;

parameter DELAY = 20;
parameter N = 10_000;

reg          i_st;    // st - shift type (0:logical 1:arithmetic)
reg   [7:0]  i_data;
reg   [2:0]  i_sa;    // sa -shift amount
wire  [7:0]  o_data;

barrel_shifter_right  bsr_inst(.i_data (i_data), 
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

