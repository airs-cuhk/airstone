module line_buffer(clk,rst_n,din,dout,en);
  input clk;
  input rst_n;
  input din;
  input en;
  output dout;
  parameter width_ext=678;
  
  wire [7:0] din;
  wire [7:0] dout;
  reg [7:0] ram [0:width_ext-1];
  reg [9:0] i;
  assign dout = ram[width_ext-1];
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        for(i=0;i<width_ext;i=i+1)
          ram[i] <= 8'b00000000;
      end
    else if(en==1'b1)
      begin
        ram[0] <= din;
        for(i=1;i<width_ext;i=i+1)
          ram[i] <= ram[i-1];
      end
  end
     
endmodule   
        
        
      
