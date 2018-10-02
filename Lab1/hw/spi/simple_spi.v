module simple_spi(MAX10_CLK1_50, GPIO, KEY, LEDR);

input           MAX10_CLK1_50;
input   [35:0]  GPIO;
input   [1:0]   KEY;
output  [9:0]   LEDR;

wire    sys_clk     = MAX10_CLK1_50;
wire    sys_rst_n   = KEY[1];

wire    spi_sck     = GPIO[0];
wire    spi_cs      = GPIO[1];
wire    spi_mosi    = GPIO[2];

wire    sck_rs_edg;
wire    tr_cmplt;

reg     [7:0]   user_reg_ff;
reg     [7:0]   spi_dat_ff;

reg     [2:0]   sck_sync_ff;
reg     [2:0]   cs_sync_ff;
reg     [1:0]   mosi_sync_ff;   

assign LEDR = user_reg_ff;

assign    sck_rs_edg    = ~sck_sync_ff[2] & sck_sync_ff[1];
assign    tr_cmplt      = ~cs_sync_ff[2] & cs_sync_ff[1];

// you should obligatorily implement reset on all control lines
always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n) begin
        sck_sync_ff <= 3'b000;
    end else begin
        sck_sync_ff <= {sck_sync_ff[1:0], spi_sck};
    end
end 
    
always @(posedge sys_clk, negedge sys_rst_n) begin
    if (~sys_rst_n) begin
        cs_sync_ff <= 3'b111;
    end else begin
        cs_sync_ff <= {cs_sync_ff[1:0], spi_cs};
    end    
end    

// it is not necessary implement reset on data lines
// but you can do it if you want
always @(posedge sys_clk)
    mosi_sync_ff <= {mosi_sync_ff[0], spi_mosi}; 

always @(posedge sys_clk) begin
    if (sck_rs_edg)
        spi_dat_ff <= {spi_dat_ff[6:0], mosi_sync_ff[1]};
end

always @(posedge sys_clk)
    if (tr_cmplt)
        user_reg_ff <= spi_dat_ff;
        
endmodule
