module bin2dec(bitCode, num_2, num_1, num_0);
 
//定义和初始化
input [7:0] bitCode;
output reg [3:0] num_2,num_1,num_0;
integer i;
 
always@(bitCode)
	begin 
                num_2=4'd0;
		num_1=4'd0;
		num_0=4'd0;
 
		for(i=7;i>=0;i=i-1)   
			begin	
                if(num_2>=5)
					num_2=num_2+3;
				if(num_1>=5)
					num_1=num_1+3;
 
				if(num_0>=5)
					num_0=num_0+3;
 
				num_2 = num_2<<1;
				num_2[0] = num_1[3];
 
                num_1 = num_1<<1;
				num_1[0] = num_0[3];
 
				num_0 = num_0<<1;
				num_0[0]= bitCode[i];
			end		
	end	
endmodule