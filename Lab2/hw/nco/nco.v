module nco(MAX10_CLK1_50, KEY, SW, VGA_R);

input           MAX10_CLK1_50;
input   [1:0]   KEY;
input   [9:0]   SW;
output  [3:0]   VGA_R;

reg     [3:0]   sin_table_rom[1023:0];
reg     [31:0]  phase;
reg     [3:0]   dac_data;
reg     [31:0]  freq_step;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];

assign  VGA_R = dac_data;   

initial $readmemh("sin_table_4bit.hex", sin_table_rom);

always @(posedge sys_clk)
    dac_data <= sin_table_rom[phase[31:22]];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        freq_step <= 0;
    end else begin
        freq_step <= {14'd0, SW, 8'd0};   //for simplicity here we dont use synchronization
    end
end

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        phase <= 0;
    end else begin
        phase <= phase + freq_step;
    end
end

endmodule

