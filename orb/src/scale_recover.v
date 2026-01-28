module scale_recover(start,rst_n,clk,num_fast1,num_fast2,addr_b_fast1,addr_b_fast2,XY_in_fast1,XY_in_fast2,
                     XYO_fast1,XYO_fast2,addr_out_fast1,addr_out_fast2,wren_XYO_fast1,wren_XYO_fast2,num_total,num_L1);
  input start;
  input rst_n;
  input clk;
  input [13:0] num_fast1;
  input [13:0] num_fast2;
  input [19:0] XY_in_fast1;
  input [19:0] XY_in_fast2;
  output [13:0] addr_b_fast1;
  output [13:0] addr_b_fast2;
  output [21:0] XYO_fast1;
  output [21:0] XYO_fast2;
  output [13:0] addr_out_fast1;
  output [13:0] addr_out_fast2;
  output wren_XYO_fast1;
  output wren_XYO_fast2;
  output [14:0] num_total;
  output [13:0] num_L1;
  
  wire [9:0] X_fast1;
  wire [9:0] Y_fast1;
  wire [9:0] X_fast2;
  wire [9:0] Y_fast2;
  wire [22:0] result_X;
  wire [22:0] result_Y;
  
  reg [13:0] addr_b_fast1;
  reg [13:0] addr_b_fast2;
  reg [13:0] addr_out_fast2_tp1;
  reg [13:0] addr_out_fast2_tp2;
  reg [13:0] addr_out_fast2_tp3;
  reg [13:0] addr_out_fast2_tp4;
  reg [13:0] addr_out_fast2_tp5;
  reg [13:0] addr_out_fast2_tp6;
  reg [13:0] addr_out_fast1;
  reg [13:0] addr_out_fast1_tp1;
  reg [13:0] addr_out_fast2;
  reg wren_XYO_fast1;
  reg wren_XYO_fast2;
  reg [14:0] num_total;
  reg [13:0] num_L1;
  
  
  assign X_fast2 = XY_in_fast2[19:10] - 5'd19;
  assign Y_fast2 = XY_in_fast2[9:0] - 5'd19;
  assign X_fast1 = XY_in_fast1[19:10] - 5'd19;
  assign Y_fast1 = XY_in_fast1 [9:0] - 5'd19;
  assign aclr = ~rst_n;
  assign XYO_fast1 = {X_fast1,Y_fast1,2'b01};
  assign XYO_fast2 = {result_X[21:12],result_Y[21:12],2'b10};
  
  mul7 mul_7(.aclr(aclr),
             .clock(clk),
             .dataa(X_fast2),
             .result(result_X));
           
  mul8 mul_8(.aclr(aclr),
             .clock(clk),
             .dataa(Y_fast2),
             .result(result_Y));
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_fast1 <= 14'd0;
    else if(start==1)
      addr_b_fast1 <= 14'd0;
    else if(addr_b_fast1<num_fast1-1'b1)
      addr_b_fast1 <= addr_b_fast1 + 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_fast2 <= 14'd0;
    else if(start==1)
      addr_b_fast2 <= 14'd0;
    else if(addr_b_fast2<num_fast2-1'b1)
      addr_b_fast2 <= addr_b_fast2 + 1'b1;
  end
    
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        addr_out_fast1_tp1 <= 14'd0;
        addr_out_fast1 <= 14'd0;
      end
    else
      begin
        addr_out_fast1_tp1 <= addr_b_fast1;
        addr_out_fast1 <= addr_out_fast1_tp1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        addr_out_fast2_tp1 <= 14'd0;
        addr_out_fast2_tp2 <= 14'd0;
        addr_out_fast2_tp3 <= 14'd0;
        addr_out_fast2_tp4 <= 14'd0;
        addr_out_fast2_tp5 <= 14'd0;
        addr_out_fast2_tp6 <= 14'd0;
        addr_out_fast2 <= 14'd0;
      end
    else
      begin
        addr_out_fast2_tp1 <= addr_b_fast2 + num_fast1;
        addr_out_fast2_tp2 <= addr_out_fast2_tp1;
        addr_out_fast2_tp3 <= addr_out_fast2_tp2;
        addr_out_fast2_tp4 <= addr_out_fast2_tp3;
        addr_out_fast2_tp5 <= addr_out_fast2_tp4;
        addr_out_fast2_tp6 <= addr_out_fast2_tp5;
        addr_out_fast2 <= addr_out_fast2_tp6;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      wren_XYO_fast1 <= 1'b0;
    else if(start==1)
      wren_XYO_fast1 <= 1'b1;
    else if(addr_out_fast1==num_fast1-1'b1)
      wren_XYO_fast1 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      wren_XYO_fast2 <= 1'b0;
    else if(start==1)
      wren_XYO_fast2 <= 1'b1;
    else if(addr_out_fast2==num_fast1+num_fast2-1'b1)
      wren_XYO_fast2 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      num_total <= 15'd0;
    else if(start==1)
      num_total <= num_fast1 + num_fast2;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      num_L1 <= 14'd0;
    else if(start==1)
      num_L1 <= num_fast1;
  end
  
endmodule
        
              