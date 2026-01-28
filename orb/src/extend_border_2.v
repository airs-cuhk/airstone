module extend_border_2(clk,start,rst_n,din,dout,addr_out,addr_b,wren,start_fast_detect);
  input clk;
  input start;
  input rst_n;
  input din;
  output dout;
  output addr_out;
  output addr_b;
  output wren;
  output start_fast_detect;
  
 // parameter width_ext=571,height_ext=438,border=19,width=533,height=400,bt=18;
  
  wire [7:0] din;
  reg [7:0] dout;
  reg [18:0] addr_b;
  reg [18:0] addr_out;
  
  reg [9:0] X;
  reg [9:0] Y;
  reg [9:0] oldX;
  reg [9:0] oldY;
  reg [9:0] X_temp1;
  reg [9:0] Y_temp1;
  reg [9:0] X_temp2;
  reg [9:0] Y_temp2;
  reg [9:0] X_tc;
  reg [9:0] Y_tc;
  
  reg wren;
  reg start_fast_detect;
  reg enable_oldXY;
  reg enable_addr_b;
  reg enable_out;
  reg enable_din;
  reg enable_temp;
  
  reg [1:0] count_start_fast;
  
  wire [18:0] addr_b_tp1;
  wire [13:0] addr_b_tp2;
  wire [11:0] addr_b_tp3;
  wire [18:0] addr_b_tp4;
  wire [12:0] addr_b_tp5;
  wire [18:0] addr_b_tp6;
  
  wire [18:0] addr_out_tp1;
  wire [14:0] addr_out_tp2;
  wire [13:0] addr_out_tp3;
  wire [12:0] addr_out_tp4;
  wire [10:0] addr_out_tp5;
  reg [18:0] addr_out_tp6;
  reg [14:0] addr_out_tp7;
  reg [11:0] addr_out_tp8;
  wire [18:0] addr_out_tp9;
  wire [12:0] addr_out_tp10;
  //wire [18:0] addr_out_tp11;
  
  reg [9:0] X_tc_late1;
  
  
  assign addr_b_tp1 = {oldY,9'b000000000};
  assign addr_b_tp2 = {oldY,4'b0000};
  assign addr_b_tp3 = {oldY,2'b00};
  assign addr_b_tp4 = addr_b_tp1 + addr_b_tp2;
  assign addr_b_tp5 = addr_b_tp3 + oldY;
  assign addr_b_tp6 = addr_b_tp4 + addr_b_tp5;
  
  assign addr_out_tp1 = {Y_tc,9'b000000000};
  assign addr_out_tp2 = {Y_tc,5'b00000};
  assign addr_out_tp3 = {Y_tc,4'b0000};
  assign addr_out_tp4 = {Y_tc,3'b000};
  assign addr_out_tp5 = {Y_tc,1'b0};
  //assign addr_out_tp6 = addr_out_tp1 + addr_out_tp2;
  //assign addr_out_tp7 = addr_out_tp3 + addr_out_tp4;
  //assign addr_out_tp8 = addr_out_tp5 + Y_tc;
 // assign addr_out_tp8 = addr_out_tp5 + X_tc;
  assign addr_out_tp9 = addr_out_tp6 + addr_out_tp7;
  assign addr_out_tp10 = addr_out_tp8 + X_tc_late1;
  //assign addr_out_tp11 = addr_out_tp9 + addr_out_tp10;
  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        addr_out_tp6 <= 19'd0;
        addr_out_tp7 <= 15'd0;
        addr_out_tp8 <= 12'd0;
      end
    else if(start==1)
      begin
        addr_out_tp6 <= 19'd0;
        addr_out_tp7 <= 15'd0;
        addr_out_tp8 <= 12'd0;
      end
    else 
      begin
        addr_out_tp6 <= addr_out_tp1 + addr_out_tp2;
        addr_out_tp7 <= addr_out_tp3 + addr_out_tp4;
        addr_out_tp8 <= addr_out_tp5 + Y_tc;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      X_tc_late1 <= 10'd0;
    else if(start==1)
      X_tc_late1 <= 10'd0;
    else
      X_tc_late1 <= X_tc;
  end
  
  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X <= 10'b0000000000;
        Y <= 10'b0000000000;
      end
    else if(start==1'b1)
      begin
        X <= 10'b0000000000;
        Y <= 10'b0000000000;
      end
    else if(X<570)
      X <= X + 1'b1;
    else if(X==570 && Y<437)
      begin
        X <= 10'b0000000000;
        Y <= Y + 1'b1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_temp1 <= 10'b0000000000;
        Y_temp1 <= 10'b0000000000;
        X_temp2 <= 10'b0000000000;
        Y_temp2 <= 10'b0000000000;
        X_tc <= 10'b0000000000;
        Y_tc <= 10'b0000000000;
      end
    else
      begin
        X_temp1 <= X;
        Y_temp1 <= Y;
        X_temp2 <= X_temp1;
        Y_temp2 <= Y_temp1;
        X_tc <= X_temp2;
        Y_tc <= Y_temp2;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        enable_addr_b <= 1'b0;
        enable_out <= 1'b0;
        enable_din <= 1'b0;
        enable_temp <= 1'b0;
      end
    else if(addr_out==250097)
      begin
        enable_addr_b <= 1'b0;
        enable_out <= 1'b0;
        enable_din <= 1'b0; 
        enable_temp <= 1'b0;
      end
    else
      begin
        enable_addr_b <= enable_oldXY;
        enable_din <= enable_addr_b;
        enable_temp <= enable_din;
        enable_out <= enable_temp;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        enable_oldXY <= 1'b0;
        wren <= 1'b0;
      end
    else if(start==1'b1)
      begin
        enable_oldXY <= 1'b1;
        wren <= 1'b1;
      end
    else if(addr_out==250097)
      begin
        enable_oldXY <= 1'b0;
        wren <= 1'b0;
      end
  end
  
 always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count_start_fast <= 2'b00;
    else if(start==1'b1)
      count_start_fast <= 2'b00;
    else if(addr_out==250097 && count_start_fast< 2'd2)
      count_start_fast <= count_start_fast + 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      start_fast_detect <= 1'b0;
    else if(addr_out==250097 && count_start_fast==2'd0)
      start_fast_detect <= 1'b1;
    else if(count_start_fast==2'd2)
      start_fast_detect <= 1'b0;
  end
     
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        oldX <= 10'b0000000000;
        oldY <= 10'b0000000000;
      end
    else if(enable_oldXY==1'b1)
      begin
        if(Y<=18)
          begin
            oldY <= 10'd18 - Y;
            if(X<=18)   
                oldX <= 10'd18 - X;
            else if(X>=552) 
                oldX <= 11'd1084 - X;
            else
                oldX <= X - 10'd19;
          end
        else if(Y>=419)
          begin
            oldY <= 10'd818 - Y;
            if(X<=18)
                oldX <= 10'd18 - X;
            else if(X>=552)    
                oldX <= 11'd1084 - X;
            else
                oldX <= X - 10'd19;
          end
        else 
          begin
            oldY <= Y - 10'd19;
            if(X<=18)
                oldX <= 10'd18 - X;
            else if(X>=552)
                oldX <= 11'd1084 - X;
            else
                oldX <= X - 10'd19;
          end 
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
        addr_b <= 18'b000000000000000000;
    else if(enable_addr_b==1'b1)
        addr_b <= oldX + addr_b_tp6;
  end
       
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        addr_out <= 18'b000000000000000000;
        dout <= 8'b00000000;
      end
    else if(enable_out==1'b1)
      begin
        addr_out <= addr_out_tp9 + addr_out_tp10;
        dout <= din;
      end
  end

endmodule
           
  
       
      
  
