module counter(clk,counter);
    input clk;
    parameter DIVCLK_CNTMAX = 24999; //时钟分频计数的最大值
    reg [31:0] cnt = 0;              
    reg divclk_reg = 0;
    always@(posedge clk) begin
        if(cnt == DIVCLK_CNTMAX) begin
            cnt <= 0;
            divclk_reg <= ~divclk_reg;
        end
        else
            cnt <= cnt + 1;
    end 

    output reg [2:0] counter = 0;
    always@(posedge divclk_reg) begin
        if(counter == 3'b110)
            counter <= 3'b000;
        else 
            counter <= counter + 1'b1;
    end

endmodule