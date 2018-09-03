module simple_spi(MAX10_CLK1_50, ARDUINO_IO, LEDR);

input           MAX10_CLK1_50;
input   [15:0]  ARDUINO_IO;
output  [9:0]   LEDR;

wire    sys_clk     = MAX10_CLK1_50;

wire    spi_sck     = ARDUINO_IO[0];
wire    spi_mosi    = ARDUINO_IO[1];
wire    spi_cs      = ARDUINO_IO[2];

wire    sck_rs_edg  = ~sck_sync_ff[2] & sck_sync_ff[1];
wire    tr_cmplt    = ~cs_sync_ff[2] & cs_sync_ff[1];

reg     [9:0]   user_reg_ff;
reg     [7:0]   spi_dat_ff;

reg     [2:0]   sck_sync_ff = 3'b0;
reg     [2:0]   cs_sync_ff  = 3'b0;
reg     [1:0]   mosi_sync_ff = 2'b0;   

assign LEDR = user_reg_ff;

always @(posedge sys_clk)
    sck_sync_ff <= {sck_sync_ff[1:0], spi_sck};

always @(posedge sys_clk)
    cs_sync_ff <= {cs_sync_ff[1:0], spi_cs};

always @(posedge sys_clk)
    mosi_sync_ff <= {mosi_sync_ff[0], spi_mosi};

always @(posedge sys_clk)
    if (sck_rs_edg)
        spi_dat_ff <= {spi_dat_ff[6:0], mosi_sync_ff[1]};

always @(posedge sys_clk)
    if (tr_cmplt)
        user_reg_ff <= spi_dat_ff;
        
endmodule
