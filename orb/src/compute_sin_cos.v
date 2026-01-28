module compute_sin_cos(addr_in,start,rst_n,clk,m10,m01,m10_op,m01_op,sin,cos,addr_out,wren);
  input [20:0] m10;
  input [20:0] m01;
  input [7:0] m10_op;
  input [7:0] m01_op;
  input start;
  input rst_n;
  input clk;
  input [13:0] addr_in;
  
  output [12:0] sin;
  output [12:0] cos;
  output [13:0] addr_out;
  output wren;
  
  wire [13:0] addr_in;
  wire signed [20:0] m10;
  wire signed [20:0] m01;
  wire signed  [7:0] m10_op;
  wire signed  [7:0] m01_op;
  reg signed [32:0] m10_ext;
  reg signed [32:0] m01_ext;
  reg signed [32:0] m10_ext_tp1;
  reg signed [32:0] m01_ext_tp1;
  reg signed [32:0] m10_ext_tp2;
  reg signed [32:0] m01_ext_tp2;
  reg signed [32:0] m10_ext_tp3;
  reg signed [32:0] m01_ext_tp3;
  reg signed [32:0] m10_ext_tp4;
  reg signed [32:0] m01_ext_tp4;
  reg signed [32:0] m10_ext_tp5;
  reg signed [32:0] m01_ext_tp5;
  reg signed [32:0] m10_ext_tp6;
  reg signed [32:0] m01_ext_tp6;
  reg signed [32:0] m10_ext_tp7;
  reg signed [32:0] m01_ext_tp7;
  reg signed [32:0] m10_ext_tp8;
  reg signed [32:0] m01_ext_tp8;
  reg signed [32:0] m10_ext_tp9;
  reg signed [32:0] m01_ext_tp9;
  reg signed [32:0] m10_ext_tp10;
  reg signed [32:0] m01_ext_tp10;
  reg signed [32:0] m10_ext_tp11;
  reg signed [32:0] m01_ext_tp11;
  reg signed [32:0] m10_ext_tp12;
  reg signed [32:0] m01_ext_tp12;
  reg signed [32:0] m10_ext_tp13;
  reg signed [32:0] m01_ext_tp13;
  reg signed [32:0] m10_ext_tp14;
  reg signed [32:0] m01_ext_tp14;
  reg signed [32:0] m10_ext_tp15;
  reg signed [32:0] m01_ext_tp15;
  reg signed [32:0] m10_ext_tp16;
  reg signed [32:0] m01_ext_tp16;
  reg signed [32:0] m10_numer;
  reg signed [32:0] m01_numer;
  
  wire signed [32:0] sin_temp;
  wire signed [32:0] cos_temp;
  
  wire signed [12:0] sin;
  wire signed [12:0] cos;
  
  reg en;
  wire signed [40:0] temp1;
  wire signed [40:0] temp1_tp1;
  wire signed [40:0] temp1_tp2;
  wire aclr;
  reg wren;
 
  
  wire [20:0] denom;
  reg [13:0] addr_temp1 ;
  reg [13:0] addr_temp2 ;
  reg [13:0] addr_temp3 ;
  reg [13:0] addr_temp4 ;
  reg [13:0] addr_temp5 ;
  reg [13:0] addr_temp6 ;
  reg [13:0] addr_temp7 ;
  reg [13:0] addr_temp8 ;
  reg [13:0] addr_temp9 ;
  reg [13:0] addr_temp10;
  reg [13:0] addr_temp11;
  reg [13:0] addr_temp12;
  reg [13:0] addr_temp13;
  reg [13:0] addr_temp14;
  reg [13:0] addr_temp15;
  reg [13:0] addr_temp16;
  reg [13:0] addr_temp17;
  reg [13:0] addr_temp18;
  reg [13:0] addr_temp19;
  reg [13:0] addr_temp20;
  reg [13:0] addr_temp21;
  reg [13:0] addr_temp22;
  reg [13:0] addr_temp23;
  reg [13:0] addr_temp24;
  reg [13:0] addr_temp25;
  reg [13:0] addr_temp26;
  reg [13:0] addr_temp27;
  reg [13:0] addr_temp28;
  reg [13:0] addr_temp29;
  reg [13:0] addr_temp30;
  reg [13:0] addr_temp31;
  reg [13:0] addr_temp32;
  reg [13:0] addr_temp33;
  reg [13:0] addr_temp34;
  reg [13:0] addr_temp35;
  reg [13:0] addr_temp36;
  reg [13:0] addr_temp37;
  reg [13:0] addr_temp38;
  reg [13:0] addr_temp39;
  reg [13:0] addr_temp40;
  reg [13:0] addr_temp41;
  reg [13:0] addr_temp42;
  reg [13:0] addr_out;
  
  
  assign aclr = ~rst_n;
  assign temp1 = temp1_tp1 + temp1_tp2;
  assign sin = {sin_temp[32],sin_temp[11:0]};
  assign cos = {cos_temp[32],cos_temp[11:0]};
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        en <= 1'b0;
        wren <= 1'b0;
      end
    else if(start==1'b1)
      begin
        en <= 1'b1;
        wren <= 1'b1;
      end      
  end
  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        m10_ext <= 33'd0;
        m01_ext <= 33'd0;
      end
    else if(en==1'b1)
      begin
        m10_ext <= {m10,12'b000000000000};
        m01_ext <= {m01,12'b000000000000};
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        m10_ext_tp1 <= 32'd0;
        m01_ext_tp1 <= 32'd0;
        m10_ext_tp2 <= 32'd0;
        m01_ext_tp2 <= 32'd0;
        m10_ext_tp3 <= 32'd0;
        m01_ext_tp3 <= 32'd0;
        m10_ext_tp4 <= 32'd0;
        m01_ext_tp4 <= 32'd0;
        m10_ext_tp5 <= 32'd0;
        m01_ext_tp5 <= 32'd0;
        m10_ext_tp6 <= 32'd0;
        m01_ext_tp6 <= 32'd0;
        m10_ext_tp7 <= 32'd0;
        m01_ext_tp7 <= 32'd0;
        m10_ext_tp8 <= 32'd0;
        m01_ext_tp8 <= 32'd0;
        m10_ext_tp9 <= 32'd0;
        m01_ext_tp9 <= 32'd0;
        m10_ext_tp10 <= 32'd0;
        m01_ext_tp10 <= 32'd0;
        m10_ext_tp11 <= 32'd0;
        m01_ext_tp11 <= 32'd0;
        m10_ext_tp12 <= 32'd0;
        m01_ext_tp12 <= 32'd0;
        m10_ext_tp13 <= 32'd0;
        m01_ext_tp13 <= 32'd0;
        m10_ext_tp14 <= 32'd0;
        m01_ext_tp14 <= 32'd0;
        m10_ext_tp15 <= 32'd0;
        m01_ext_tp15 <= 32'd0;
        m10_ext_tp16 <= 32'd0;
        m01_ext_tp16 <= 32'd0;
      end
    else if(en==1'b1)
      begin
        m10_ext_tp1 <= m10_ext;
        m01_ext_tp1 <= m01_ext;
        m10_ext_tp2 <= m10_ext_tp1;
        m01_ext_tp2 <= m01_ext_tp1;
        m10_ext_tp3 <= m10_ext_tp2;
        m01_ext_tp3 <= m01_ext_tp2;
        m10_ext_tp4 <= m10_ext_tp3;
        m01_ext_tp4 <= m01_ext_tp3;
        m10_ext_tp5 <= m10_ext_tp4;
        m01_ext_tp5 <= m01_ext_tp4;
        m10_ext_tp6 <= m10_ext_tp5;
        m01_ext_tp6 <= m01_ext_tp5;
        m10_ext_tp7 <= m10_ext_tp6;
        m01_ext_tp7 <= m01_ext_tp6;
        m10_ext_tp8 <= m10_ext_tp7;
        m01_ext_tp8 <= m01_ext_tp7;
        m10_ext_tp9 <= m10_ext_tp8;
        m01_ext_tp9 <= m01_ext_tp8;
        m10_ext_tp10 <= m10_ext_tp9;
        m01_ext_tp10 <= m01_ext_tp9;
        m10_ext_tp11 <= m10_ext_tp10;
        m01_ext_tp11 <= m01_ext_tp10;
        m10_ext_tp12 <= m10_ext_tp11;
        m01_ext_tp12 <= m01_ext_tp11;
        m10_ext_tp13 <= m10_ext_tp12;
        m01_ext_tp13 <= m01_ext_tp12;
        m10_ext_tp14 <= m10_ext_tp13;
        m01_ext_tp14 <= m01_ext_tp13;
        m10_ext_tp15 <= m10_ext_tp14;
        m01_ext_tp15 <= m01_ext_tp14;
        m10_ext_tp16 <= m10_ext_tp15;
        m01_ext_tp16 <= m01_ext_tp15;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        m10_numer <= 33'd0;
        m01_numer <= 33'd0;
      end
    else if(en==1'b1)
      begin
        m10_numer <= m10_ext_tp16;
        m01_numer <= m01_ext_tp16;
      end
  end
  
  
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     begin
       addr_temp1  <= 14'd0;
       addr_temp2  <= 14'd0;
       addr_temp3  <= 14'd0;
       addr_temp4  <= 14'd0;
       addr_temp5  <= 14'd0;
       addr_temp6  <= 14'd0;
       addr_temp7  <= 14'd0;
       addr_temp8  <= 14'd0;
       addr_temp9  <= 14'd0;
       addr_temp10 <= 14'd0;
       addr_temp11 <= 14'd0;
       addr_temp12 <= 14'd0;
       addr_temp13 <= 14'd0;
       addr_temp14 <= 14'd0;
       addr_temp15 <= 14'd0;
       addr_temp16 <= 14'd0;
       addr_temp17 <= 14'd0;
       addr_temp18 <= 14'd0;
       addr_temp19 <= 14'd0;
       addr_temp20 <= 14'd0;
       addr_temp21 <= 14'd0;
       addr_temp22 <= 14'd0;
       addr_temp23 <= 14'd0;
       addr_temp24 <= 14'd0;
       addr_temp25 <= 14'd0;
       addr_temp26 <= 14'd0;
       addr_temp27 <= 14'd0;
       addr_temp28 <= 14'd0;
       addr_temp29 <= 14'd0;
       addr_temp30 <= 14'd0;
       addr_temp31 <= 14'd0;
       addr_temp32 <= 14'd0;
       addr_temp33 <= 14'd0;
       addr_temp34 <= 14'd0;
       addr_temp35 <= 14'd0;
       addr_temp36 <= 14'd0;
       addr_temp37 <= 14'd0;
       addr_temp38 <= 14'd0;
       addr_temp39 <= 14'd0;
       addr_temp40 <= 14'd0;
       addr_temp41 <= 14'd0;
       addr_temp42 <= 14'd0;
       addr_out <= 14'd0;
     end
   else if(en==1'b1)
     begin
       addr_temp1  <= addr_in;
       addr_temp2  <= addr_temp1 ;
       addr_temp3  <= addr_temp2 ;
       addr_temp4  <= addr_temp3 ;
       addr_temp5  <= addr_temp4 ;
       addr_temp6  <= addr_temp5 ;
       addr_temp7  <= addr_temp6 ;
       addr_temp8  <= addr_temp7 ;
       addr_temp9  <= addr_temp8 ;
       addr_temp10 <= addr_temp9 ;
       addr_temp11 <= addr_temp10;
       addr_temp12 <= addr_temp11;
       addr_temp13 <= addr_temp12;
       addr_temp14 <= addr_temp13;
       addr_temp15 <= addr_temp14;
       addr_temp16 <= addr_temp15;
       addr_temp17 <= addr_temp16;
       addr_temp18 <= addr_temp17;
       addr_temp19 <= addr_temp18;
       addr_temp20 <= addr_temp19;
       addr_temp21 <= addr_temp20;
       addr_temp22 <= addr_temp21;
       addr_temp23 <= addr_temp22;
       addr_temp24 <= addr_temp23;
       addr_temp25 <= addr_temp24;
       addr_temp26 <= addr_temp25;
       addr_temp27 <= addr_temp26;
       addr_temp28 <= addr_temp27;
       addr_temp29 <= addr_temp28;
       addr_temp30 <= addr_temp29;
       addr_temp31 <= addr_temp30;
       addr_temp32 <= addr_temp31;
       addr_temp33 <= addr_temp32;
       addr_temp34 <= addr_temp33;
       addr_temp35 <= addr_temp34;
       addr_temp36 <= addr_temp35;
       addr_temp37 <= addr_temp36;
       addr_temp38 <= addr_temp37;
       addr_temp39 <= addr_temp38;
       addr_temp40 <= addr_temp39;
       addr_temp41 <= addr_temp40;
       addr_temp42 <= addr_temp41;
       addr_out <= addr_temp42;
     end
 end 
      
      
mul5 mul_1(.aclr(aclr),
           .clock(clk),
           .dataa(m10),
           .ena(en),
           .result(temp1_tp1));  
              
mul5 mul_2(.aclr(aclr),
           .clock(clk),
           .dataa(m01),
           .ena(en),
           .result(temp1_tp2));        
  
  
sqrt sq1(.aclr(aclr),
  
         .clk(clk),
  
         .ena(en),
  
         .radical(temp1),
  
         .q(denom),
  
         .remainder());
  
         
  
         

   div d1(.clock(clk),

          .denom(denom),

          .numer(m10_numer),

          .quotient(cos_temp),

          .remain());

     

   div d2(.clock(clk),

          .denom(denom),

          .numer(m01_numer),

          .quotient(sin_temp),

          .remain());     

          

          endmodule  

          
  
         
  
         
  
         
  
         
   
  
  
  
