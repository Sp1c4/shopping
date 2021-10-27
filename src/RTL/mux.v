module mux(sel,in1,in2,in3,in4,in5,in6,data_out);
    input [2:0] sel;
    input [3:0] in1,in2,in3,in4,in5,in6;
    output reg [3:0] data_out;
    always@(*)
        case(sel) 
            3'b000 : data_out = in1;
            3'b001 : data_out = in2;
            3'b010 : data_out = in3;
            3'b011 : data_out = in4;
            3'b100 : data_out = in5;
            3'b101 : data_out = in6;
            default : data_out = 0;
        endcase
endmodule