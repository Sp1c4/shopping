module LED (input [2:0] mode,
            input clk,
            input rstn,
            output reg led_pwn
    
);

    reg [29:0] cnt;
    reg [29:0] cnt_num;
    
    always@(posedge clk or negedge rstn)
    begin
        if(!rstn)
        begin
            cnt <= 29'b0;
            led_pwn <= 1'b0;
            cnt_num <= 1'b0;
        end
        else if(cnt_num == 0) begin
            led_pwn <= 1;
        end
        else if(cnt == cnt_num) begin
            cnt <= 32'b0;
            led_pwn <= ~led_pwn;
        end
        else cnt <= cnt + 1'b1;

    
        case(mode)
        
        3'h0: cnt_num = cnt_num;
        3'h1: cnt_num = 30'd50000000;
        3'h2: cnt_num = 30'd1000000000;
        3'h3: cnt_num = 0;
        default: cnt_num = cnt_num;
        endcase

    end
endmodule