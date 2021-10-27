module keyboard_filter(clk,rstn,key_in,key_pulse);
    input clk;
    input rstn;
    input [15:0] key_in;
   
    output reg [15:0] key_pulse;
    reg [15:0] key_reg0;
    reg [15:0] key_reg1;
    reg [15:0] key_reg2;
    wire [15:0] key_deb;
    reg [15:0] key_debb; 
    parameter CNTMAX = 999;
    reg [19:0] cnt = 0;
    reg state;
    reg next_state;
    
    parameter s0 = 1'b0;
    parameter s1 = 1'b1;
    
    always@(posedge clk or negedge rstn) begin
        if(!rstn)
            cnt <= 0;
        else if(cnt == CNTMAX)
            cnt <= 0;
        else
            cnt <= cnt + 1'b1;
    end
     
    
    
    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            key_reg0 <= 16'hffff;
            key_reg1 <= 16'hffff;
            key_reg2 <= 16'hffff;
        end
        else if(cnt == CNTMAX) begin
            key_reg0 <= key_in;
            key_reg1 <= key_reg0;
            key_reg2 <= key_reg1;
        end
    end
    assign key_deb = (~key_reg0&~key_reg1& ~key_reg2);


    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            state <= s0;
            next_state <= s0;
            key_debb <= 0;

        end
        else begin
            state <= next_state;
            key_debb <= key_deb;
           
        end
    end
    always@(state or key_deb or key_debb)begin
         case(state)
        s0:if(key_deb == key_debb) begin
                next_state <= s0;
                key_pulse <= 16'b0;
            end
            else begin
            next_state <= s1;
            key_pulse <= key_deb;
            end    

        s1:if(key_deb == key_debb) begin
            next_state <= s1;
            key_pulse <= 16'b0;
            end
            else begin
            next_state <= s0;
            key_pulse <= 16'b0;
            end
        default:next_state<=s0;
        endcase
    end




/*   always@(posedge clk) begin
            if(key_debb==key_deb)
           key_pulse <= 1'b0;
        else if(key_deb == 16'h0)begin
            key_pulse <= 1'b0;
            key_debb <= key_deb;
        end
        else begin
            key_pulse <= 1'b1;
            key_debb <= key_deb;
        end
            
    end
*/

/*    always@(posedge clk) 
        case(key_deb) 
            16'h0001 : key <= 4'b0000;
            16'h0002 : key <= 4'b0001;
            16'h0004 : key <= 4'b0010;
            16'h0008 : key <= 4'b0011;
            16'h0010 : key <= 4'b0100;
            16'h0020 : key <= 4'b0101;
            16'h0040 : key <= 4'b0110;
            16'h0080 : key <= 4'b0111;
            16'h0100 : key <= 4'b1000;
            16'h0200 : key <= 4'b1001;
            16'h0400 : key <= 4'b1010;
            16'h0800 : key <= 4'b1011;
            16'h1000 : key <= 4'b1100;
            16'h2000 : key <= 4'b1101;
            16'h4000 : key <= 4'b1110;
            16'h8000 : key <= 4'b1111;
        endcase
*/

endmodule