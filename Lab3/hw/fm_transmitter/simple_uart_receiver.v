//Designed for 8 bit data, 2 stop bits, 230400bps

module simple_uart_receiver(i_clk, i_rst_n, i_rx, o_dat, o_dat_vld);

input           i_clk;
input           i_rst_n;
input           i_rx;
output  reg     o_dat_vld;
output  [7:0]   o_dat;

parameter       RCONST = 1085; //230400bps for 250MHz i_clk

reg     [10:0]  baud_rate_cnt;
reg     [3:0]   bit_cnt;
reg     [7:0]   shift_reg;
reg     [1:0]   rx_sync;
reg     [7:0]   data_reg;

assign o_dat = data_reg;

always @(posedge i_clk)
    if ( (9 == bit_cnt) && (RCONST/2 == baud_rate_cnt) ) begin
        data_reg    <= shift_reg;
        o_dat_vld   <= 1'b1;
    end else begin
        o_dat_vld   <= 1'b0;
    end

always @(posedge i_clk)
    rx_sync <= {rx_sync[0], i_rx};

always @(posedge i_clk)
    if( RCONST/2 == baud_rate_cnt )
        shift_reg <= {rx_sync[1], shift_reg[7:1]};

always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n) begin
        baud_rate_cnt <= 0;
    end else begin
        if ( (RCONST == baud_rate_cnt) || (10 == bit_cnt) )
            baud_rate_cnt <= 0;
        else
            baud_rate_cnt <= baud_rate_cnt + 1'b1;
    end

always @(posedge i_clk, negedge i_rst_n)
    if (~i_rst_n) begin
        bit_cnt <= 0;
    end else begin
        if ( (10 == bit_cnt) && (1'b0 == rx_sync[1]) )
            bit_cnt <= 0;
        else if (RCONST == baud_rate_cnt)
            bit_cnt <= bit_cnt + 1'b1;
    end

endmodule

