module Searchbyband(clk,rst_n,start,fx,num_left,num_right,XYO_left,XYO_right,descriptor1_left,descriptor2_left,descriptor1_right,descriptor2_right,
                    addr_b_XYO_left,addr_b_XYO_right,addr_b1_descriptor_left,addr_b2_descriptor_left,addr_b1_descriptor_right,
                    addr_b2_descriptor_right,XYOXYO,bestdist,addr_out,wren,num_matches,start_SAD);
input clk;
input rst_n;
input start;
input [8:0] fx; 
input [14:0] num_left;
input [14:0] num_right;
input [21:0] XYO_left;
input [21:0] XYO_right;
input [7:0] descriptor1_left;
input [7:0] descriptor2_left;
input [7:0] descriptor1_right;
input [7:0] descriptor2_right;
output [13:0] addr_b_XYO_left;
output [13:0] addr_b_XYO_right;
output [18:0] addr_b1_descriptor_left;
output [18:0] addr_b2_descriptor_left;
output [18:0] addr_b1_descriptor_right;
output [18:0] addr_b2_descriptor_right;
output [43:0] XYOXYO;
output [7:0] bestdist;
output [14:0] addr_out;
output wren;
output [14:0] num_matches;
output start_SAD;

reg [1:0] count;
reg flag1;
reg flag2;
reg endl;
wire [9:0] X_left;
wire [9:0] Y_left;
wire [9:0] X_right;
wire [9:0] Y_right;
wire [9:0] temp1_1;
wire [9:0] temp1_2;
wire [9:0] temp2_1;
wire [9:0] temp2_2;
wire [10:0] temp3;
reg [4:0] count_des;
wire [7:0] dist_temp1;
wire [7:0] dist_temp2;
wire [1:0] dist_temp101;
wire [1:0] dist_temp102;
wire [1:0] dist_temp103;
wire [1:0] dist_temp104;
wire [1:0] dist_temp201;
wire [1:0] dist_temp202;
wire [1:0] dist_temp203;
wire [1:0] dist_temp204;

wire [2:0] dist_temp301;
wire [2:0] dist_temp302;
wire [2:0] dist_temp303;
wire [2:0] dist_temp304;

reg [3:0] dist_temp401;
reg [3:0] dist_temp402;
reg [7:0] total_dist;
reg [7:0] best_dist_temp;
reg [7:0] bestdist;
reg [43:0] XYOXYO_temp;
reg [43:0] XYOXYO;

reg [13:0] addr_b_XYO_left;
reg [13:0] addr_b_XYO_right;
reg [18:0] addr_b1_descriptor_left;
reg [18:0] addr_b2_descriptor_left;
reg [18:0] addr_b1_descriptor_right;
reg [18:0] addr_b2_descriptor_right;

reg [13:0] addr_b_XYO_right_tp1;
reg [13:0] addr_b_XYO_right_tp2;
reg [13:0] addr_b_XYO_right_tp3;
reg [14:0] addr_out_tp;
reg wren;
reg end_search;
reg [14:0] num_matches;
reg start_SAD;
reg [1:0] count_start_SAD;

assign X_left = XYO_left[21:12];
assign Y_left = XYO_left[11:2];
assign X_right = XYO_right[21:12];
assign Y_right = XYO_right[11:2];
assign temp1_1 = Y_right + 2'd2;
assign temp1_2 = Y_right + 2'd3;
assign temp2_1 = Y_left + 2'd2;
assign temp2_2 = Y_left + 2'd3;
assign temp3 = X_right + fx;

assign dist_temp1 = descriptor1_left ^ descriptor1_right;
assign dist_temp2 = descriptor2_left ^ descriptor2_right;

assign dist_temp101 = dist_temp1[7] + dist_temp1[6];
assign dist_temp102 = dist_temp1[5] + dist_temp1[4];
assign dist_temp103 = dist_temp1[3] + dist_temp1[2];
assign dist_temp104 = dist_temp1[1] + dist_temp1[0];
assign dist_temp201 = dist_temp2[7] + dist_temp2[6];
assign dist_temp202 = dist_temp2[5] + dist_temp2[4];
assign dist_temp203 = dist_temp2[3] + dist_temp2[2];
assign dist_temp204 = dist_temp2[1] + dist_temp2[0];

assign dist_temp301 = dist_temp101 + dist_temp102;
assign dist_temp302 = dist_temp103 + dist_temp104;
assign dist_temp303 = dist_temp201 + dist_temp202;
assign dist_temp304 = dist_temp203 + dist_temp204;

assign addr_out = (addr_out_tp>0)? addr_out_tp - 1'b1 : 15'd0; 


always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      addr_b_XYO_right_tp1 <= 14'd0;
      addr_b_XYO_right_tp2 <= 14'd0;
      addr_b_XYO_right_tp3 <= 14'd0;
    end
  else
    begin
      addr_b_XYO_right_tp1 <= addr_b_XYO_right;
      addr_b_XYO_right_tp2 <= addr_b_XYO_right_tp1;
      addr_b_XYO_right_tp3 <= addr_b_XYO_right_tp2;
    end
end
    


always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count <= 2'd0;
  else if(start==1)
    count <= 2'd0;
  else
    begin
      if(count<3)
        count <= count + 1'b1;
      else if(count==3)
        count <= 2'd0;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_des <= 5'd0;
  else if(start==1)
    count_des <= 5'd0;
  else if(flag1==0)
    begin
      if(count_des<24)
        count_des <= count_des + 1'b1;
      else
        count_des <= 5'd0;
    end
  else
    count_des <= 5'd0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    flag2 <= 1'b0;
  else if(start==1)
    flag2 <= 1'b0;
  else if(count_des==20 && flag1==0)
    flag2 <= 1'b1;
  else
    flag2 <= 1'b0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_b_XYO_left <= 14'd0;
  else if(start==1)
    addr_b_XYO_left <= 14'd0;
  else if(endl==1 && addr_b_XYO_left<num_left-1 && count==3)
    addr_b_XYO_left <= addr_b_XYO_left + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_b_XYO_right <= 14'd0;
  else if(start==1)
    addr_b_XYO_right <= 14'd0;
  else if(addr_b_XYO_right<num_right-1)
    begin
      if(flag2==1)
        addr_b_XYO_right <= addr_b_XYO_right + 1'b1;
      else if(count==3 && flag1==1)
        addr_b_XYO_right <= addr_b_XYO_right + 1'b1;
    end
  else if(endl==1 && addr_b_XYO_left<num_left-1)
    addr_b_XYO_right <= 14'd0;
end
        
        
 

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    flag1 <= 1'b0;
  else if(start==1)
    flag1 <= 1'b1;
  else
    begin
      if(XYO_right[1:0]==2'b01)
        begin
          if(temp1_1>=Y_left && temp2_1>=Y_right && temp3>=X_left && X_left>=X_right)
            flag1 <= 1'b0;
          else
            flag1 <= 1'b1;
        end
      else if(XYO_right[1:0]==2'b10)
        begin
          if(temp1_2>=Y_left && temp2_2>=Y_right && temp3>=X_left && X_left>=X_right)
            flag1 <= 1'b0;
          else
            flag1 <= 1'b1;
        end
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      addr_b1_descriptor_left <= 19'd0;
      addr_b2_descriptor_left <= 19'd0;
      addr_b1_descriptor_right <= 19'd0;
      addr_b2_descriptor_right <= 19'd0;
    end
  else if(start==1)
    begin
      addr_b1_descriptor_left <= 19'd0;
      addr_b2_descriptor_left <= 19'd0;
      addr_b1_descriptor_right <= 19'd0;
      addr_b2_descriptor_right <= 19'd0;
    end
  else if(flag1==0)
    begin
      if(count_des<16)
        begin
          addr_b1_descriptor_left <= {addr_b_XYO_left,5'd0} + {count_des,1'b0};
          addr_b2_descriptor_left <= {addr_b_XYO_left,5'd0} + {count_des,1'b0} + 1'b1;
          addr_b1_descriptor_right <= {addr_b_XYO_right,5'd0} + {count_des,1'b0};
          addr_b2_descriptor_right <= {addr_b_XYO_right,5'd0} + {count_des,1'b0} + 1'b1;
        end
    end
  else
    begin
      addr_b1_descriptor_left <= 19'd0;
      addr_b2_descriptor_left <= 19'd0;
      addr_b1_descriptor_right <= 19'd0;
      addr_b2_descriptor_right <= 19'd0;
    end
end
      
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      dist_temp401 <= 4'd0;
      dist_temp402 <= 4'd0;
    end      
  else if(start==1)
    begin
      dist_temp401 <= 4'd0;
      dist_temp402 <= 4'd0;
    end
  else if(count_des>2 && count_des<19 && flag1==0)
    begin
      dist_temp401 <= dist_temp301 + dist_temp302;
      dist_temp402 <= dist_temp303 + dist_temp304;
    end
  else
    begin
      dist_temp401 <= 4'd0;
      dist_temp402 <= 4'd0;
    end
end
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    total_dist <= 8'd0;
  else if(start==1)
    total_dist <= 8'd0;
  else if(flag1==0)
    begin
      if(count_des>3 && count_des<20)
        total_dist <= total_dist + dist_temp401 + dist_temp402;
      else
        total_dist <= 8'd0;
    end
  else
    total_dist <= 8'd0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    best_dist_temp <= 8'd0;
  else if(start==1 || endl==1)
    best_dist_temp <= 8'd255;
  else if(flag1==0 && count_des==20)
    begin
      if(total_dist<best_dist_temp)
        best_dist_temp <= total_dist;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    endl <= 1'b0;
  else if(start==1)
    endl <= 1'b0;
  else if(addr_b_XYO_right_tp3==num_right-1)
    begin
      if(flag1==1 && count==3)
        endl <= 1'b1;
      else
        begin
          if(count_des==20)
            endl <= 1'b1;
        end
    end  
  else
    endl <= 1'b0;
end
 // else if(addr_b_XYO_right==num_right-1 && count_des==20)
   // endl <= 1'b1;
//  else
//    endl <= 1'b0;
//end    
    
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestdist <= 8'd0;
  else if(start==1)
    bestdist <= 8'd0;
  else if(endl==1 && best_dist_temp<75)
    bestdist <= best_dist_temp;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    XYOXYO_temp <= 44'd0;
  else if(start==1 || endl==1)
    XYOXYO_temp <= 44'd0;
  else if(flag1==0 && count_des==20)
    begin
      if(total_dist<best_dist_temp)
        XYOXYO_temp <= {XYO_left,XYO_right};
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    XYOXYO <= 44'd0;
  else if(start==1)
    XYOXYO <= 44'd0;
  else if(endl==1 && best_dist_temp<75)
    XYOXYO <= XYOXYO_temp;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_out_tp <= 15'd0;
  else if(start==1)
    addr_out_tp <= 15'd0;
  else if(endl==1 && best_dist_temp<75)
    addr_out_tp <= addr_out_tp + 1'b1;
end
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    end_search <= 1'b0;
  else if(start==1)
    end_search <= 1'b0;
  else if(addr_b_XYO_left==num_left-1 && addr_b_XYO_right==num_right-1 && endl==1)
    end_search <= 1'b1;
end 
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    wren <= 1'b0;
  else if(start==1)
    wren <= 1'b1;
  else if(end_search==1)
    wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    num_matches <= 15'd0;
  else if(start==1)
    num_matches <= 15'd0;
  else if(end_search==1)
    num_matches <= addr_out_tp;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_start_SAD <= 2'd0;
  else if(start==1)
    count_start_SAD <= 2'd0;
  else if(end_search==1 && count_start_SAD<3)
    count_start_SAD <= count_start_SAD + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    start_SAD <= 1'b0;
  else if(start==1)
    start_SAD <= 1'b0;
  else if(end_search==1 && count_start_SAD<3)
    start_SAD <= 1'b1;
  else 
    start_SAD <= 1'b0;
end

endmodule    
    
      
      
          
    
    

       
      