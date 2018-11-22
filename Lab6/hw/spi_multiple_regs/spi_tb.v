`timescale 1ns / 1ps

module spi_tb;

parameter PERIOD = 20;

reg         i_clk, i_rst_n, i_spi_mosi, i_spi_sck, i_spi_cs;
wire [7:0]  o_data;

reg  [7:0]  spi_send_buf = 8'hAA;

integer i;

simple_spi spi_inst(.MAX10_CLK1_50(i_clk), 
                    .GPIO({33'b0, i_spi_mosi, i_spi_cs, i_spi_sck}), 
                    .KEY({i_rst_n, 1'b0}), 
                    .LEDR(o_data)
                    );

initial begin
    i_clk = 0;
    forever #(PERIOD/2) i_clk = ~i_clk;
end

initial begin
    i_rst_n = 1'b0;
    i_spi_mosi = 1'b0; 
    i_spi_sck = 1'b0;
    i_spi_cs = 1'b1;
    spi_inst.spi_dat_ff = 8'h00;
    spi_inst.user_reg_ff = 8'h00;

    @(negedge i_clk) i_rst_n = 1;

    repeat (5) @(negedge i_clk);

    i_spi_cs = 1'b0;
        
    for(i=0; i<8; i=i+1) begin
        i_spi_sck = 1'b0;
        i_spi_mosi = spi_send_buf[7-i];
        repeat (5) @(negedge i_clk);
        i_spi_sck = 1'b1;
        repeat (5) @(negedge i_clk);
    end

    i_spi_cs = 1'b1;
    repeat (10) @(negedge i_clk);

    $finish;  
end
  
endmodule
