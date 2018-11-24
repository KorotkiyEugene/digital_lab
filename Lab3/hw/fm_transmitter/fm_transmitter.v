module fm_transmitter(MAX10_CLK1_50, GPIO, KEY, LEDR);

input           MAX10_CLK1_50;
inout   [35:0]  GPIO;
input   [1:0]   KEY;
output  [9:0]   LEDR;

parameter   NCO_PHASE_STEP_CARRIER = 32'h5C28_F5C2; // 90 MHz FM carrier, 250 MHz sys_clk

wire    sys_rst_n = KEY[0];
wire    sys_clk;

wire    [7:0]   uart_dat;
reg     [7:0]   sample;

reg     [31:0]  nco_phase;
reg     [31:0]  nco_phase_step;
wire    [31:0]  nco_phase_step_carrier = NCO_PHASE_STEP_CARRIER;
wire    [31:0]  nco_phase_step_deviation = { {(32-8-13){sample[7]}}, sample, 13'b0 };

mypll pll_inst(.inclk0 (MAX10_CLK1_50),
                .c0 (sys_clk), // 250 MHz clock
                .locked (LEDR[0])
                );
    
simple_uart_receiver uart_rec(.i_clk (sys_clk), 
                                .i_rst_n (sys_rst_n), 
                                .i_rx (GPIO[0]), 
                                .o_dat (uart_dat), 
                                .o_dat_vld ()
                                );
                               
always @(posedge sys_clk)
    sample <= uart_dat - 128;
    
always @(posedge sys_clk)
    nco_phase_step <= nco_phase_step_carrier + nco_phase_step_deviation;
    
always @(posedge sys_clk)
    nco_phase <= nco_phase + nco_phase_step;

assign GPIO[35] = nco_phase[31];
                                
endmodule
