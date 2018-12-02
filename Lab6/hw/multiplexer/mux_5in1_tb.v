`timescale 1 ns / 1 ps

module testbench;

parameter DELAY = 20;
parameter WIDTH = 8;

reg     [WIDTH-1:0]  i_dat0, i_dat1, i_dat2, i_dat3, i_dat4;;
reg     [2:0]        i_sel;
wire    [WIDTH-1:0]  o_dat;

integer i;

mux_5in1 #(.WIDTH(WIDTH)) mux_inst(.i_dat0 (i_dat0), 
                                   .i_dat1 (i_dat1), 
                                   .i_dat2 (i_dat2), 
                                   .i_dat3 (i_dat3), 
                                   .i_dat4 (i_dat4), 
                                   .i_sel (i_sel), 
                                   .o_dat (o_dat)
                                   );

initial begin
    
    for (i=0; i<8; i=i+1) begin

        i_sel = i;

        repeat (10) begin
            i_dat0 = $random;
            i_dat1 = $random;
            i_dat2 = $random;
            i_dat3 = $random;
            i_dat4 = $random;
            #DELAY;
        end

    end

    $finish;

end

endmodule
