module lfsr10bit(KEY, SW, LEDR);

input   [1:0]   KEY;
input   [9:0]   SW;
output  [9:0]   LEDR;

reg     [9:0]   lfsr;

wire            clk = KEY[0];
wire            rst_n = KEY[1];

wire    lfsr_lsb = ~(lfsr[9] ^ lfsr[6]);

assign LEDR = lfsr;

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        lfsr <= 0;
    end else begin
        lfsr <= {lfsr[8:0], lfsr_lsb};
    end
end

endmodule
