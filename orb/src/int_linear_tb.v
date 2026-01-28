`timescale 10ns/1ns
module int_linear_tb();
  reg start;
  reg rst;
  reg clk;
  wire [19:0] dout1;
  wire [13:0] num_fast1;
  
  wire [19:0] dout2;
  wire [13:0] num_fast2;
  wire [20:0] m10_fast1;
  wire [20:0] m01_fast1;
  wire [20:0] m10_fast2;
  wire [20:0] m01_fast2;

  
  
  
  integer file_3;
  

  int_linear_v3 test (.start(start),
                   .rst_n(rst),          
                   .clk(clk),
                   .dout_fast1(dout1),
                   .num_fast1(num_fast1),
                   .dout_fast2(dout2),
                   .num_fast2(num_fast2),
                   .m10_fast1(m10_fast1),
                   .m01_fast1(m01_fast1),
                   .m10_fast2(m10_fast2),
                   .m01_fast2(m01_fast2));
                   
 
  initial
    $readmemb("C:/Users/admistrater/Desktop/linear/men.txt",test.ram1.ram);
  
                     
                         
  initial
  begin
    clk = 0;
    rst = 1;
    start = 0;
    #11 start = 1;
    #31 start = 0;
    
  end
  
  always #1 clk = ~clk;
  
  
  initial
    file_3 = $fopen("C:/Users/admistrater/Desktop/fast3.txt","w+");
  
  initial
    $fmonitor(file_3,"%b %b",dout1,dout2);

  
    
  
endmodule
