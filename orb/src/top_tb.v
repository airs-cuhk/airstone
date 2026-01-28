`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/22 15:31:59
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb();
	
reg	clk,start,rst_n;
wire [21:0]	XYO_fast1;
wire [21:0]	XYO_fast2;

wire [13:0] num_fast1;  
wire [13:0] num_fast2;

wire 	    wren_XYO_fast1;
wire 	    wren_XYO_fast2;
	
always #10 	clk =~clk;

initial begin
rst_n = 0;start=0;clk=0;
#100  rst_n = 1;
#700000  start=1;
#100 start=0;

end

glbl glbl();
	
	
top inst_top(
	
	.clk	(clk),
	.start	(start),
	.rst_n  (rst_n),

	.XYO_fast1  	  (XYO_fast1),		
	.XYO_fast2  	  (XYO_fast2),
	
	.num_fast1		   (num_fast1),
	.num_fast2		   (num_fast2),	
	
	.wren_XYO_fast1   (wren_XYO_fast1),
    .wren_XYO_fast2   (wren_XYO_fast2)

    );	

//wire			valid_o			 ;//待保存数据有效标志信号，高电平有效

reg				valid_flag = 1'b0		;
reg		[21:0]	wr_txt_fast1			 ;
reg 	[13:0]	num_fast1_reg			;
reg 	[13:0]	num_fast2_reg			;
always@(posedge clk)begin
	if(wren_XYO_fast1)begin
		valid_flag   <= 1'b1;
	end else begin
		valid_flag   <= valid_flag;
	end
end

always@(posedge clk)begin
	if(valid_flag)begin
		wr_txt_fast1 <= XYO_fast1;
		num_fast1_reg<= num_fast1;
	end else begin
		wr_txt_fast1   <= wr_txt_fast1;
		num_fast1_reg<= num_fast1_reg;
	end
end


reg				valid_flag1 = 1'b0		 ;
reg		[21:0]	wr_txt_fast2			 ;
always@(posedge clk)begin
	if(wren_XYO_fast2)begin
		valid_flag1   <= 1'b1;
	end else begin
		valid_flag1   <= valid_flag1;
	end
end

always@(posedge clk)begin
	if(valid_flag1)begin
		wr_txt_fast2 <= XYO_fast2;
		num_fast2_reg<= num_fast2;
	end else begin
		wr_txt_fast2 <= wr_txt_fast2;
		num_fast2_reg<= num_fast2_reg;
	end
end



integer w_file; // w_file 是一个文件描述，需要定义为 integer 类型
integer w_file1; // w_file 是一个文件描述，需要定义为 integer 类型
//initial w_file = $fopen("/home/work/output_file/data_o.txt");//Linux系统下文件保存路径示例
initial w_file =  $fopen("D:/modesim2020_project/orb_extra/data_fast1.txt");//win系统下文件保存路径示例
initial w_file1 = $fopen("D:/modesim2020_project/orb_extra/data_fast2.txt");//win系统下文件保存路径示例

//always@(posedge clk) begin//仅在valid_flag变化的情况下才将wr_txt写入文件
//	if(valid_flag)
//		$fwrite(w_file,"%d %d %d\n",num_fast1_reg,wr_txt_fast1[21:12],wr_txt_fast1[11:2]);// %h 十六进制保存，\n：换行符
//end

always@(posedge clk) begin//仅在valid_flag变化的情况下才将wr_txt写入文件
	if(valid_flag)
		$fwrite(w_file,"%d %h\n",num_fast1_reg,wr_txt_fast1);// %h 十六进制保存，\n：换行符
end


//always@(posedge clk) begin//仅在valid_flag变化的情况下才将wr_txt写入文件
//	if(valid_flag1)
//		$fwrite(w_file1,"%h %h %d\n",num_fast2_reg,wr_txt_fast2[21:12],wr_txt_fast2[11:2]);// %h 十六进制保存，\n：换行符
//end

always@(posedge clk) begin//仅在valid_flag变化的情况下才将wr_txt写入文件
	if(valid_flag1)
		$fwrite(w_file1,"%d %h\n",num_fast2_reg,wr_txt_fast2);// %h 十六进制保存，\n：换行符
end
	
endmodule
