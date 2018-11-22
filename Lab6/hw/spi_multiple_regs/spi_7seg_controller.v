module spi_7seg_controller(MAX10_CLK1_50, 
                            GPIO, 
                            KEY, 
                            HEX0, 
                            HEX1, 
                            HEX2, 
                            HEX3, 
                            HEX4, 
                            HEX5
                            );

input           MAX10_CLK1_50;
input   [35:0]  GPIO;
input   [1:0]   KEY;
output  [6:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];

wire    spi_sck     = GPIO[0];
wire    spi_cs      = GPIO[1];
wire    spi_mosi    = GPIO[2];

wire    sck_rs_edg;
wire    tr_cmplt;

reg     [7:0]   spi_dat_ff;

reg     [2:0]   sck_sync_ff;
reg     [2:0]   cs_sync_ff;
reg     [1:0]   mosi_sync_ff;   

reg             ctrl_or_data_ff; // 0 -> waiting ctrl word (address, etc) 
                                 // 1 -> waiting data word

reg             spi_recv_byte_ff;

reg     [2:0]   cnt_ff;

reg     [2:0]   addr_ff;
reg     [6:0]   digits[5:0];

assign  HEX0 = digits[0];
assign  HEX1 = digits[1];
assign  HEX2 = digits[2];
assign  HEX3 = digits[3];
assign  HEX4 = digits[4];
assign  HEX5 = digits[5];

/******************************************************************************
*                           SPI old part                                      *
******************************************************************************/

assign    sck_rs_edg    = ~sck_sync_ff[2] & sck_sync_ff[1];
assign    tr_cmplt      = ~cs_sync_ff[2] & cs_sync_ff[1];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n)
        sck_sync_ff <= 3'b000;
    else
        sck_sync_ff <= {sck_sync_ff[1:0], spi_sck};
end 
    
always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n)
        cs_sync_ff <= 3'b111;
    else
        cs_sync_ff <= {cs_sync_ff[1:0], spi_cs};   
end    

always @(posedge sys_clk)
    mosi_sync_ff <= {mosi_sync_ff[0], spi_mosi}; 

always @(posedge sys_clk) begin
    if (sck_rs_edg)
        spi_dat_ff <= {spi_dat_ff[6:0], mosi_sync_ff[1]};
end

/******************************************************************************
*                           SPI new part                                      *
******************************************************************************/

always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n)
        cnt_ff <= 3'd0;
    else if (cs_sync_ff[2])
        cnt_ff <= 3'd0;
    else if (sck_rs_edg)
        cnt_ff <= cnt_ff + 1'b1;
end 

always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n)
        spi_recv_byte_ff <= 1'b0;
    else if (sck_rs_edg & (3'd7 == cnt_ff) )
        spi_recv_byte_ff <= 1'b1;
    else
        spi_recv_byte_ff <= 1'b0;
end 

always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n)
        ctrl_or_data_ff <= 1'b0;
    else if (cs_sync_ff[2])
        ctrl_or_data_ff <= 1'b0;
    else if (spi_recv_byte_ff & ~ctrl_or_data_ff )
        ctrl_or_data_ff <= 1'b1;
end 

always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n)
        addr_ff <= 3'd0;
    else if (cs_sync_ff[2])
        addr_ff <= 3'd0;
    else if (spi_recv_byte_ff & ~ctrl_or_data_ff )
        addr_ff <= spi_dat_ff[2:0];
    else if (spi_recv_byte_ff)
        addr_ff <= addr_ff + 1'b1;
end 

always @(posedge sys_clk) begin
    if (spi_recv_byte_ff & ctrl_or_data_ff)
        digits[addr_ff] <= spi_dat_ff[6:0];
end 
        
endmodule
