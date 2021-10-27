module AHBlite_LED (
    input wire          HCLK, 
    input wire          HRESETn,       
    input wire          HSEL,                   
    input wire  [31:0]  HADDR,          
    input wire  [3:0]   HPROT,         
    input wire  [2:0]   HSIZE,          
    input wire  [1:0]   HTRANS,         
    input wire  [31:0]  HWDATA,         
    input wire          HWRITE,                  
    input wire          HREADY,         
    output wire         HREADYOUT,
    output wire [31:0]  HRDATA,    
    output wire         HRESP, 

    output      [2:0]   mode

);
assign HRESP = 1'b0;
assign HREADYOUT = 1'b1;
wire write_en;
assign write_en = HSEL & HTRANS[1] & HWRITE & HREADY;

reg wr_en_reg;
always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) wr_en_reg <= 1'b0;
    else if (write_en) wr_en_reg <= 1'b1;
    else wr_en_reg <= 1'b0;
end
assign mode = wr_en_reg ? HWDATA[2:0] : 3'd0;
assign HRDATA ={29'd0,mode};

endmodule