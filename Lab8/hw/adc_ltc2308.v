module adc_ltc2308(i_clk, // max 40Mhz
                   i_rst_n,
                   
                   i_measure_ch,
                   o_measure_done,
                   o_measure_data,
	
                   //adc interface
                   ADC_CONVST,
                   ADC_SCK,
                   ADC_SDI,
                   ADC_SDO 
                  );

input              i_clk;
input              i_rst_n;

input       [2:0]  i_measure_ch;

output  reg        o_measure_done = 1'b0;
output  reg [11:0] o_measure_data;

output  reg        ADC_CONVST = 1'b0;
output             ADC_SCK;
output  reg        ADC_SDI;
input              ADC_SDO;


/////////////////////////////////
// Timing definition 

// using 40MHz clock
// to acheive fsample = 500KHz
// ntcyc = 2us / 25ns  = 80

localparam DATA_BITS_NUM      =  12;
localparam CMD_BITS_NUM       =  6;
localparam CH_NUM             =  8;

localparam tWHCONV            =  3;   // CONVST High Time, min 20 ns
localparam tCONV              =  64;  // tCONV: type 1.3 us, MAX 1.6 us, 1600/25(assumed clk is 40mhz)=64  -> 1.3us/25ns = 52
                                      // set 64 for suite for 1.6 us max

localparam tHCONVST           =  3; 

localparam tCONVST_HIGH_START =  0; 	
localparam tCONVST_HIGH_END   =  tCONVST_HIGH_START+ tWHCONV; 

localparam tCONFIG_START      =  tCONVST_HIGH_END;
localparam tCONFIG_END        =  tCLK_START+ CMD_BITS_NUM - 1; 	

localparam tCLK_START         =  tCONVST_HIGH_START + tCONV;
localparam tCLK_END           =  tCLK_START + DATA_BITS_NUM;

localparam tDONE              =  tCLK_END + tHCONVST;

localparam UNI_MODE           = 1'b1;   //1: Unipolar, 0:Bipolar
localparam SLP_MODE           = 1'b0;   //1: enable sleep
localparam SD                 = 1'b1;   //1: single-ended, 0: differential

reg                      clk_enable = 1'b0;

reg  [15:0]              tick;

reg  [DATA_BITS_NUM-1:0] read_data;
reg  [3:0]               write_pos;

wire [CMD_BITS_NUM-1:0]  config_cmd = {SD, i_measure_ch, UNI_MODE, SLP_MODE};

wire                     config_init   = (tick == tCONFIG_START);
wire                     config_enable = (tick > tCLK_START && tick <= tCONFIG_END);
wire                     config_done   = (tick > tCONFIG_END);

reg  [2:0]               sdi_index;	
										  
assign ADC_SCK = clk_enable & i_clk;										  

always @ (posedge i_clk, negedge i_rst_n) begin
    if (~i_rst_n)
        tick <= 0;
    else if (tick < tDONE)
        tick <= tick + 1;
    else
        tick <= 0;    
end

always @ (negedge i_clk, negedge i_rst_n) begin
    if (~i_rst_n)
        ADC_CONVST <= 1'b0;
    else 
     	  ADC_CONVST <= ( tick >= tCONVST_HIGH_START && tick < tCONVST_HIGH_END );
end

always @ (negedge i_clk, negedge i_rst_n) begin
    if (~i_rst_n)
       clk_enable <= 1'b0;
    else if ((tick >= tCLK_START && tick < tCLK_END))
        clk_enable <= 1'b1;
    else
        clk_enable <= 1'b0;
end

always @ (negedge i_clk, negedge i_rst_n) begin // posedge??
    if (~i_rst_n) begin
        read_data <= 0;
        write_pos <= DATA_BITS_NUM-1;
    end else if (tick == 2) begin
        read_data <= 0;
        write_pos <= DATA_BITS_NUM-1;
    end else if (clk_enable) begin
        read_data[write_pos] <= ADC_SDO;
        write_pos <= write_pos - 1;
    end
end

always @ (posedge i_clk, negedge i_rst_n) begin
    if (~i_rst_n) begin
        o_measure_done <= 1'b0;
		  o_measure_data <= 0;
    end else if (tick == tDONE) begin
        o_measure_done <= 1'b1;
		  o_measure_data <= read_data;
    end else
	     o_measure_done <= 1'b0;
end

always @(negedge i_clk) begin
    if (config_init) begin
        ADC_SDI <= config_cmd[CMD_BITS_NUM-1];
        sdi_index <= CMD_BITS_NUM-2;
    end else if (config_enable) begin
        ADC_SDI <= config_cmd[sdi_index];
        sdi_index <= sdi_index - 1;
    end else if (config_done)
        ADC_SDI <= 1'b0;
end

endmodule
