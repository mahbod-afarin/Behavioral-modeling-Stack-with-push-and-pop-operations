module testBench();
reg clk;
reg RstN;
reg [7:0] Data_In;
reg Push;
reg Pop;
wire [2:0] SP;
wire [7:0] Data_Out;
wire Full;
wire Empty;
Stack s(clk, RstN, Data_In, Push, Pop, SP, Data_Out, Full, Empty);

always
#2 clk = ~clk;	

initial 
 begin
  clk = 1'b0;
	RstN = 1;
	Pop = 0;
	Push = 0;
	#8
	RstN = 0;
	Push = 1;
	Data_In = 1;
	#4
	Data_In = 2;
	#4
	Data_In = 3;
	#4
	Data_In = 4;
	#4
	Data_In = 5;
	#4
	Data_In = 6;
	#4
	Data_In = 7;
	#4
	Data_In = 8;
	#16
	Pop = 1;
	Data_In = 0;
	#12
	Push = 0;
end
endmodule



