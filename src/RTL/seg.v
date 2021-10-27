module seg(input clk,
           input rstn,
           input [7:0] bin,
           input [1:0] choose,
           output [7:0] seg_led,
           output [5:0] seg_sel
           );

    
    wire [2:0] clk_scan;
    counter counter(
    .clk(clk),
    .counter(clk_scan)
    );

    reg [3:0] data_1,data_2,data_3,data_4,data_5,data_6;
    wire [3:0] num_0,num_1,num_2,data_disp;

    bin2dec bin2dec(
        .bitCode(bin),
        .num_0(num_0),
        .num_1(num_1),
        .num_2(num_2)
    );

    always @(posedge clk or negedge rstn)
    begin
        if(!rstn) begin
            data_1 <= 0;
            data_2 <= 0;
            data_3 <= 0;
            data_4 <= 0;
            data_5 <= 0;
            data_6 <= 0;

        end
        else if(choose == 2'b01) begin
            data_1 <= num_2;
            data_2 <= num_1;
            data_3 <= num_0;
        end
        else if(choose == 2'b10) begin
            data_4 <= num_2;
            data_5 <= num_1;
            data_6 <= num_0;
        end
    end

    mux mux(
    .sel(clk_scan),
    .in1(data_1),
    .in2(data_2),
    .in3(data_3),
    .in4(data_4),
    .in5(data_5),
    .in6(data_6),
    .data_out(data_disp)
    );

    seg_led_decoder seg_led_decoder(
        .data_disp(data_disp),
        .seg_led(seg_led)
    );
    seg_sel_decoder seg_sel_decoder(
        .bit_disp(clk_scan),
        .seg_sel(seg_sel)
    );
endmodule