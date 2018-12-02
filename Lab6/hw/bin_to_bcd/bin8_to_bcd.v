module bin8_to_bcd (i_bin, o_bcd);

input       [7:0]   i_bin;
output reg  [11:0]  o_bcd;

integer i;   
     
always @* begin

    o_bcd = 0;

    for (i = 0; i < 8; i = i+1) begin

        o_bcd = {o_bcd[10:0], i_bin[7-i]};              

        if(i < 7 && o_bcd[3:0] > 4) 
            o_bcd[3:0] = o_bcd[3:0] + 3;

        if(i < 7 && o_bcd[7:4] > 4)
            o_bcd[7:4] = o_bcd[7:4] + 3;

        if(i < 7 && o_bcd[11:8] > 4)
            o_bcd[11:8] = o_bcd[11:8] + 3;  

    end

end     

endmodule

