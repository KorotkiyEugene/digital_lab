module top(CLOCK_50, KEY, LEDR, ADC_CONVST, ADC_SCLK, ADC_DIN, ADC_DOUT, GPIO_0);

input           CLOCK_50;

input   [1:0]   KEY;

output  [9:0]   LEDR;

output  [35:0]  GPIO_0;

output          ADC_CONVST;
output          ADC_SCLK;
input           ADC_DOUT;
output          ADC_DIN;

wire            pll_locked;

wire            sys_rst_n = KEY[1];
wire            sys_clk;            // 100 MHz
wire            adc_clk;            // 40 MHz

wire    [11:0]  fifo_in_data;
wire    [11:0]  fifo_out_data;

wire            fifo_full;
wire            fifo_empty;

wire            fifo_write_req;
reg             fifo_read_ack = 1'b0;

reg             adc_data_valid = 1'b0;
reg     [11:0]  adc_data;
wire            adc_measure_done;
reg             adc_measure_done_ff = 1'b0;

reg     [7:0]   tick_cnt          = 8'd0;

reg     [3:0]   pll_locked_ff     = 4'b0000;

assign          LEDR[0]           = pll_locked;
assign          GPIO_0[11:0]      = adc_data;
assign          GPIO_0[12]        = adc_data_valid;

assign          fifo_write_req    = ~adc_measure_done_ff & adc_measure_done & ~fifo_full; 

system_pll sys_pll ( .refclk (CLOCK_50),
                     .rst (~sys_rst_n),
                     .outclk_0 (sys_clk),
                     .outclk_1 (adc_clk),
                     .locked (pll_locked)
	               );
                   
adc_ltc2308 adc (.i_clk (adc_clk),
	             .i_rst_n (pll_locked_ff[3]), // posedge triggle
	             .i_measure_ch (3'd0),
	             .o_measure_done (adc_measure_done),
	             .o_measure_data (fifo_in_data),
	
	             // adc interface
	             .ADC_CONVST (ADC_CONVST),
	             .ADC_SCK (ADC_SCLK),
	             .ADC_SDI (ADC_DIN),
	             .ADC_SDO (ADC_DOUT)
                 );
                 
adc_fifo adc_fifo_inst( .aclr(~sys_rst_n),
                        .data (fifo_in_data),
                        .rdclk (sys_clk),
                        .rdreq (fifo_read_ack),
                        .wrclk (adc_clk),
                        .wrreq (fifo_write_req),
                        .q (fifo_out_data),
                        .rdempty (fifo_empty),
                        .wrfull (fifo_full)
                       );
                       
always @(posedge adc_clk, negedge sys_rst_n)
    if (~sys_rst_n)
        adc_measure_done_ff <= 1'b0;
    else
        adc_measure_done_ff <= adc_measure_done;    

always @(posedge adc_clk, negedge sys_rst_n)
    if (~sys_rst_n)
        pll_locked_ff <= 4'b0000;
    else
        pll_locked_ff <= {pll_locked_ff[2:0], pll_locked}; 

always @(posedge sys_clk, negedge sys_rst_n)
    if (~sys_rst_n) begin
        tick_cnt       <= 8'd0;
        fifo_read_ack  <= 1'b0;
        adc_data       <= 12'd0;
        adc_data_valid <= 1'b0;
    end else begin
        tick_cnt       <= tick_cnt + 1'b1;
        fifo_read_ack  <= 1'b0;
        adc_data_valid <= 1'b0;
        
        if (8'd199 == tick_cnt) begin
            tick_cnt       <= 8'd0;
            adc_data_valid <= ~fifo_empty;
            fifo_read_ack  <= ~fifo_empty;
            adc_data       <= fifo_out_data - 12'd2048;
        end
        
    end 
        
endmodule

