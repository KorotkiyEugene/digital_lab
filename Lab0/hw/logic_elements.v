module logic_elements(SW, LEDR);

input   [9:0]   SW;
output  [9:0]   LEDR;

wire    [9:0]   y;
wire    [9:0]   x;

assign LEDR = y;
assign x = SW;

assign y[0] = ~x[0];

assign y[1] = x[0] & x[1];

assign y[2] = ~(x[0] & x[1]);

assign y[3] = x[0] | x[1];

assign y[4] = ~(x[0] | x[1]);

assign y[5] = x[0] ^ x[1];

assign y[9:6] = 4'b1010;

endmodule
