module keyboard_scan(rstn,clk,col,row,key);
    input rstn;
    input clk;
    input [3:0] col; 
    output reg [3:0] row = 4'b1110; //行
    output reg [15:0] key;        //按键独热码
    reg [31:0] cnt = 0;           //按键扫描分频时钟计数
    reg scan_clk = 0;             //分频时钟
    
    //时钟分频
    always@(posedge clk or negedge rstn) 
    begin
        if(~rstn) begin
            cnt <= 0;
        end
        else if(cnt == 2499) begin
            cnt <= 0;
            scan_clk <= ~scan_clk;
        end
        else
            cnt <= cnt + 1;
    end

    //行滚动扫描
    always@(posedge scan_clk)
        row <= {row[2:0],row[3]};
    //扫描定位
    always @(negedge scan_clk)
    case(row)
        4'b1110 : key[3:0] <= col;
        4'b1101 : key[7:4] <= col;
        4'b1011 : key[11:8] <= col;
        4'b0111 : key[15:12] <= col;
        default : key <= 0;
    endcase
endmodule