`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/22 14:55:22
// Design Name: 
// Module Name: top
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


module top(
	
	input clk,
	input start,
	input rst_n,
	
	output [21:0]XYO_fast1  ,		
	output [21:0]XYO_fast2  ,

    output [13:0] num_fast1,  
    output [13:0] num_fast2,
	
	output wren_XYO_fast1   ,
    output wren_XYO_fast2 
    );

wire  [18 : 0] addra		;
wire  [18 : 0] addrb		;
wire [7:0]	  data_in_1 ;
wire [7:0]	  data_in_2 ;

reg start_reg;

always@(posedge clk or negedge rst_n)begin
if(!rst_n)
	start_reg<=0;
else if(start)
	start_reg<=1;
else
	start_reg<=start_reg;
end


	
//always@(posedge clk or negedge rst_n)begin
//if(!rst_n)
//	addra<=0;
//else if(start_reg)begin
//	if(addra == 19'd307200 -1)
//		addra<=0;
//	else
//		addra<=addra+1;
//end
//else
//	addra<=addra;
//end
//
//	
//always@(posedge clk or negedge rst_n)begin
//if(!rst_n)
//	addrb<=0;
//else if(start_reg)begin
//	if(addrb == 19'd307200 -1)
//		addrb<=0;
//	else
//		addrb<=addrb+1;
//end
//else
//	addrb<=addrb;
//end




rom_left inst_left (
  .clka(clk),    // input wire clka
  .ena(start_reg),      // input wire ena
  .addra(addra),  // input wire [18 : 0] addra
  .douta(data_in_1),  // output wire [7 : 0] douta
  
  .clkb(clk),    // input wire clkb
  .enb(start_reg),      // input wire enb
  .addrb(addrb),  // input wire [18 : 0] addrb
  .doutb(data_in_2)  // output wire [7 : 0] doutb
);


	
ORBExtractor_hc18_test inst_orbextractor_test
(
.clk				(clk			),
.start				(start			),
.rst_n				(rst_n			),
.data_in_1			(data_in_1		),
.data_in_2			(data_in_2		),
.addr_out1			(addra			),
.addr_out2			(addrb			),
.XYO_fast1			(XYO_fast1		),
.XYO_fast2			(XYO_fast2		),

.num_fast1			(num_fast1)		,
.num_fast2			(num_fast2)		,

.wren_a_fast1		(wren_XYO_fast1 ),
.wren_a_fast2		(wren_XYO_fast2 )
	);    

	
	
endmodule
