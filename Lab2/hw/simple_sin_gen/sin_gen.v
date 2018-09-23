module sin_gen(MAX10_CLK1_50, KEY, VGA_R);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
output  [3:0]   VGA_R;

reg     [3:0]   sin_table_rom[1023:0];
reg     [9:0]   phase;
reg     [3:0]   dac_data;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];

assign  VGA_R = dac_data;   

initial $readmemh("sin_table_4bit.hex", sin_table_rom);

always @(posedge sys_clk)
    dac_data <= sin_table_rom[phase];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        phase <= 0;
    end else begin
        phase <= phase + 1'b1;
    end
end

endmodule

