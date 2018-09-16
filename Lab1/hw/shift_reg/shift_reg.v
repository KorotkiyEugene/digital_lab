module shift_reg (KEY, SW, LEDR);

input   [1:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;

wire            clk = KEY[0];
wire            rst_n = KEY[1];

reg     [9:0]   shift_reg;

assign LEDR = shift_reg;
                                        
always @(posedge clk, negedge rst_n)

    if (~rst_n) begin
        shift_reg <= 0;
    end else begin
        shift_reg <= {shift_reg[8:0], SW[0]};    
    end
    
endmodule
