module AHBlite_Decoder
#(
    /*led enable parameter*/
    parameter Port0_en = 1,
    /************************/

    /*keyboard enable parameter*/
    parameter Port1_en = 1,
    /************************/

    /*RAMCODE enable parameter*/
    parameter Port2_en = 1,
    /************************/

    parameter Port3_en = 1,
    
    /*leg_seg enable parameter*/
    parameter Port4_en = 1
    /************************/
)(
    input [31:0] HADDR,


    output wire P0_HSEL,

    output wire P1_HSEL,

    output wire P2_HSEL,

    output wire P3_HSEL,

    output wire P4_HSEL       
);

//LED-----------------------------------

//0x40000010
/*Insert led code there*/   
assign P0_HSEL = (HADDR[31:4] == 28'h4000001) ? Port0_en : 1'b0;
/***********************************/

//0X40000000 key_data/key_clear
/*Insert keyboard decoder code there*/
assign P1_HSEL = (HADDR[31:4] == 28'h4000000) ? Port1_en : 1'b0;
/***********************************/

/*Insert RAMDATA decoder code there*/
assign P3_HSEL = (HADDR[31:16] == 16'h2000) ? Port3_en : 1'b0;
/***********************************/


/*Insert RAMCODE decoder code there*/
assign P2_HSEL = (HADDR[31:16] == 16'h0000) ? Port2_en : 1'b0;
/***********************************/

//0x40000020
/*Insert led_seg code there*/   
assign P4_HSEL = (HADDR[31:4] == 28'h4000002) ? Port4_en : 1'b0;
endmodule