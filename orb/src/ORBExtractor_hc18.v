module ORBExtractor_hc18(clk,start,rst_n,XYO_fast1,XYO_fast2,addr_XYO_fast1,addr_XYO_fast2,wren_XYO_fast1,wren_XYO_fast2,descriptor_fast1,descriptor_fast2,
                    addr_desc_fast1,addr_desc_fast2,wren_desc_fast1,wren_desc_fast2,data_extend_out1,data_extend_out2,addr_extend_out1,addr_extend_out2,
                    wren_extend1,wren_extend2,data_in_1,data_in_2,addr_out1,addr_out2,start_match,num_total,num_L1);    
  input start;
  input rst_n;
  input clk; 
  input [7:0] data_in_1;
  input [7:0] data_in_2;
  output [21:0] XYO_fast1;
  output [21:0] XYO_fast2;
  output [13:0] addr_XYO_fast1;
  output [13:0] addr_XYO_fast2;
  output wren_XYO_fast1;
  output wren_XYO_fast2;
  output [127:0] descriptor_fast1;
  output [127:0] descriptor_fast2;
  output [14:0] addr_desc_fast1;
  output [14:0] addr_desc_fast2;
  output wren_desc_fast1;
  output wren_desc_fast2;
  output [7:0] data_extend_out1;
  output [7:0] data_extend_out2;
  output [18:0] addr_extend_out1;
  output [18:0] addr_extend_out2;
  output wren_extend1;
  output wren_extend2;
  output [18:0] addr_out1;
  output [18:0] addr_out2;
  output start_match;
  output [14:0] num_total;
  output [13:0] num_L1;
  

  
  parameter width_b=640,height_b=480,width=533,height=400,sx=13'b1001100110110,sy=13'b1001100110011;

  //parameter width_b=96,height_b=96,width=80,height=80,sx=13'b1001100110110,sy=13'b1001100110011;

  reg [9:0] X,Y;
  reg [9:0] X_temp,Y_temp;
  reg [9:0] X_tc,Y_tc;
  wire [12:0] scaleX,scaleY;
  wire [7:0] data_out;
  reg [18:0] addr_out;
  reg [18:0] addr_b1,addr_b2;
  
  wire [22:0] oldX,oldY;
  reg [22:0] oldX_tc,oldY_tc;
  wire [31:0] data_temp;
  reg enable_oldXY;
  reg enable_addr_b;
  reg enable_data_in;
  reg enable_backup;
  reg enable_new;
  reg enable_XY_temp;
  reg enable_oldXY_tc;
  reg enable_XY_tc;
  reg count;
  reg [7:0] backup_1,backup_2;
  reg wren_a_linear;
  wire wren_b_linear;
  reg sel;
  reg sel2;
  reg sel3;
  
  wire [18:0] addr_b_extend1;
  wire [18:0] addr_now;
  reg start_extend;
  reg [1:0] count_start_extend;
  wire [7:0] data_extend_out1;
  wire [18:0] addr_extend_out1;
  wire wren_a_extend1;
  wire wren_b_extend1;
  
  wire [7:0] data_extend_out2;
  wire [18:0] addr_extend_out2;
  wire [7:0] data_extend_in2;
  wire [18:0] addr_b_extend2;
  wire wren_a_extend2;
  wire wren_b_extend2;
  
  wire start_fast_detect1;
  wire start_fast_detect2;
  
  wire [7:0] data_fast_in1;
  wire [18:0] addr_b_fast1;
  wire [19:0] dout_fast1;
  wire [13:0] num_fast1;
  wire [20:0] m10_fast1;
  wire [20:0] m01_fast1;
  wire [7:0] m10_op_fast1;
  wire [7:0] m01_op_fast1;
  wire start_cd1;
  wire wren_a_fast1;
  wire wren_b_fast1;
  wire [13:0] addr_out_fast1;
  
  wire [7:0]  data_fast_in2;
  wire [18:0] addr_b_fast2; 
  wire [19:0] dout_fast2;
  wire [13:0] num_fast2;
  wire [20:0] m10_fast2;
  wire [20:0] m01_fast2;
  wire [7:0] m10_op_fast2;
  wire [7:0] m01_op_fast2;
  wire start_cd2;
  wire wren_a_fast2;
  wire wren_b_fast2;
  wire [13:0] addr_out_fast2;
  
  wire [18:0] addr_b_cd1;
  wire [18:0] addr_now2;
  
  wire [18:0] addr_b_cd2;
  wire [18:0] addr_now3;
  
  wire  signed [12:0] sin_1;
  wire  signed [12:0] cos_1;
  wire  signed [12:0] sin_2;
  wire  signed [12:0] cos_2;
  
  wire [25:0] sc_1;
  wire [25:0] sc_2;
  
  wire [13:0] addr_out_sc1;
  wire [13:0] addr_out_sc2;
  
  wire wren_a_sc1;
  wire wren_b_sc1;
  wire wren_a_sc2;
  wire wren_b_sc2;
  
  wire [13:0] addr_corner_1;
  wire [5:0] addr_mod_1;
  wire [19:0] XY_in_1;
  wire [25:0] sc_in_1;
  wire [79:0] mod_1;
  wire [14:0] addr_desc_fast1;
  wire [127:0] descriptor_fast1;
  wire end_cd1;
  
  wire [13:0] addr_corner_2;
  wire [5:0] addr_mod_2;
  wire [19:0] XY_in_2;
  wire [25:0] sc_in_2;
  wire [79:0] mod_2;
  wire [14:0] addr_desc_fast2;
  wire [127:0] descriptor_fast2;
  wire end_cd2;
  
  wire [19:0] XY_in_fast1;
  wire [19:0] XY_in_fast2;
  wire [21:0] XYO_fast1;
  wire [21:0] XYO_fast2;
  wire [13:0] addr_XYO_fast1;
  wire [13:0] addr_XYO_fast2;
  wire [13:0] addr_bb_fast1;
  wire [13:0] addr_bb_fast2;
  wire [13:0] addr_now4;
  wire [13:0] addr_now5;
  
  
  wire [11:0] data_temp_tp1;
  wire [11:0] data_temp_tp2;
  wire [23:0] data_temp_tp3;
  wire [23:0] data_temp_tp4;
  wire [23:0] data_temp_tp5;
  wire [23:0] data_temp_tp6;
  wire [31:0] data_temp_tp7;
  wire [31:0] data_temp_tp8;
  wire [31:0] data_temp_tp9;
  wire [31:0] data_temp_tp10;
  reg [31:0] data_temp_tp11;
  reg [31:0] data_temp_tp12;
  
  wire [9:0] addr_out_tp1;
  wire [9:0] addr_out_tp2;
  wire [18:0] addr_out_tp3;
  wire [13:0] addr_out_tp4;
  wire [11:0] addr_out_tp5;
  wire [18:0] addr_out_tp6;
  wire [11:0] addr_out_tp7;
  wire [18:0] addr_out_tp8;
  reg [18:0] addr_out_tp9;
  reg [18:0] addr_out_tp10;
  reg [18:0] addr_out_tp11;
  reg [18:0] addr_out_tp12;  
  wire [10:0] addr_b_tp1;
  wire [10:0] addr_b_tp2;
  wire [19:0] addr_b_tp3;
  wire [17:0] addr_b_tp4; 
  wire [19:0] addr_b_tp5;
  wire [19:0] addr_b_tp6;
  wire [17:0] addr_b_tp7;
  wire [19:0] addr_b_tp8;
  
  reg [7:0] backup_1_lay1;
 // reg [7:0] backup_1_lay2;
  reg [7:0] backup_2_lay1;
 // reg [7:0] backup_2_lay2;
  reg [7:0] data_in_1_lay1;
 // reg [7:0] data_in_1_lay2;
  reg [7:0] data_in_2_lay1;
 // reg [7:0] data_in_2_lay2;
  
  
  wire aclr;
  reg start_match;
  
  assign wren_b_linear = 0;
  assign wren_b_extend1 = 0;
  assign wren_b_extend2 = 0;
  assign scaleX = sx;
  assign scaleY = sy;
  assign wren_b_fast1 = 0;
  
  assign wren_b_fast2 = 0;
  assign wren_b_sc1 = 0;
  assign wren_b_sc2 = 0;
  
  assign data_out = data_temp[31:24];
  assign sc_1 = {sin_1,cos_1};
  assign sc_2 = {sin_2,cos_2};
  
  assign data_temp_tp1 = 13'b1000000000000 - oldX_tc[11:0];
  assign data_temp_tp2 = 13'b1000000000000 - oldY_tc[11:0];
  assign addr_out_tp1 = X_tc - 1'b1;
  assign addr_out_tp2 = Y_tc - 1'b1;
  assign addr_out_tp3 = {addr_out_tp2,9'b000000000};
  assign addr_out_tp4 = {addr_out_tp2,4'b0000};
  assign addr_out_tp5 = {addr_out_tp2,2'b00};
  assign addr_out_tp6 = addr_out_tp3 + addr_out_tp4;
  assign addr_out_tp7 = addr_out_tp5 + addr_out_tp2;
  assign addr_out_tp8 = addr_out_tp6 + addr_out_tp7;
  assign addr_b_tp1 = oldX[22:12] - 1'b1;
  assign addr_b_tp2 = oldY[22:12] - 1'b1;
  assign addr_b_tp3 = {addr_b_tp2,9'b000000000};
  assign addr_b_tp4 = {addr_b_tp2,7'b0000000};
  assign addr_b_tp5 = addr_b_tp3 + addr_b_tp4;
  assign addr_b_tp6 = {oldY[22:12],9'b000000000};
  assign addr_b_tp7 = {oldY[22:12],7'b0000000};
  assign addr_b_tp8 = addr_b_tp6 + addr_b_tp7;
  assign data_temp = data_temp_tp11 + data_temp_tp12;
  
  assign aclr = ~rst_n;
  
  assign wren_extend1 = wren_a_extend1;
  assign wren_extend2 = wren_a_extend2;
  assign addr_out1 = addr_now;
  assign addr_out2 = addr_b2;
  
  mux_2_1 m1(.sel(sel),
             .din_1(addr_b1),
             .din_2(addr_b_extend1),
             .dout(addr_now));
             
  extend_border eb2(.clk(clk),
                    .start(start_extend), 
                    .rst_n(rst_n),
					.din(data_in_1),
					
                    .dout(data_extend_out1),
                    .addr_out(addr_extend_out1),                    
                    .addr_b(addr_b_extend1),
                    .wren(wren_a_extend1),
                    .start_fast_detect(start_fast_detect1)); 
                    
  ram_dp_533  ram2        (.address_a(addr_out),
                                 .address_b(addr_b_extend2),
                                 .clock(clk),
                                 .data_a(data_out),
                                 .data_b(),
                                 .wren_a(wren_a_linear),
                                 .wren_b(wren_b_linear),
                                 .q_a(),
                                 .q_b(data_extend_in2));
                                 
  ram_dp_678 ram3(.address_a(addr_extend_out1),
                         .address_b(addr_now2),
                         .clock(clk),
                         .data_a(data_extend_out1),
                         .data_b(),
                         .wren_a(wren_a_extend1),
                         .wren_b(wren_b_extend1),
                         .q_a(),
                         .q_b(data_fast_in1));
                         
  extend_border_2     eb3(.clk(clk),
                          .start(start_extend),
                          .rst_n(rst_n),
                          .dout(data_extend_out2),
                          .addr_out(addr_extend_out2),
                          .din(data_extend_in2),
                          .addr_b(addr_b_extend2),
                          .wren(wren_a_extend2),
                          .start_fast_detect(start_fast_detect2));
                          
  ram_dp_571 ram4(.address_a(addr_extend_out2),
                        .address_b(addr_now3),
                        .clock(clk),
                        .data_a(data_extend_out2),
                        .data_b(),
                        .wren_a(wren_a_extend2),
                        .wren_b(wren_b_extend2),
                        .q_a(),
                        .q_b(data_fast_in2));
                        
  fast_detect_v2 fast1(.clk(clk),
                    .rst_n(rst_n),
                    .start(start_fast_detect1),
                    .din(data_fast_in1),
                    .addr_b(addr_b_fast1),
                    .dout(dout_fast1),
                    .num_fast(num_fast1),
                    .m10(m10_fast1),
                    .m01(m01_fast1),
                    .m10_op(m10_op_fast1),
                    .m01_op(m01_op_fast1),
                    .start_gb(start_cd1),
                    .wren(wren_a_fast1),
                    .addr_out(addr_out_fast1)); 
                    
  fast_detect_v2_571  fast2         (.clk(clk),
                                     .rst_n(rst_n),
                                     .start(start_fast_detect2),
                                     .din(data_fast_in2),
                                     .addr_b(addr_b_fast2),
                                     .dout(dout_fast2),
                                     .num_fast(num_fast2),
                                     .m10(m10_fast2),
                                     .m01(m01_fast2),
                                     .m10_op(m10_op_fast2),
                                     .m01_op(m01_op_fast2),
                                     .start_gb(start_cd2),
                                     .wren(wren_a_fast2),
                                     .addr_out(addr_out_fast2)
                                     );
                                     
  compute_sin_cos sc1(.start(start_fast_detect1),
                      .clk(clk),
                      .rst_n(rst_n),
                      .addr_in(addr_out_fast1),
                      .m10(m10_fast1),
                      .m01(m01_fast1),
                      .m10_op(m10_op_fast1),
                      .m01_op(m01_op_fast1),
                      .sin(sin_1),
                      .cos(cos_1),
                      .addr_out(addr_out_sc1),
                      .wren(wren_a_sc1));
                      
                      
  compute_sin_cos sc2(.start(start_fast_detect2),
                      .clk(clk),
                      .rst_n(rst_n),
                      .addr_in(addr_out_fast2),
                      .m10(m10_fast2),
                      .m01(m01_fast2),
                      .m10_op(m10_op_fast2),
                      .m01_op(m01_op_fast2),
                      .sin(sin_2),
                      .cos(cos_2),
                      .addr_out(addr_out_sc2),
                      .wren(wren_a_sc2));
                      
  compute_descriptor_hc18 cd1(.clk(clk),
                              .rst_n(rst_n),
                              .start(start_cd1),
                              .total(num_fast1),
                              .XY_in(XY_in_1),
                              .sc_in(sc_in_1),
                              .mod(mod_1),
                              .din(data_fast_in1),
                              .addr_b(addr_b_cd1),
                              .addr_corner(addr_corner_1),
                              .addr_mod(addr_mod_1),
                              .addr_out(addr_desc_fast1),
                              .dout(descriptor_fast1),
                              .end_cd(end_cd1),
                              .wren(wren_desc_fast1));
  
  compute_descriptor_571_hc18 cd2(.clk(clk),
                                  .rst_n(rst_n),
                                  .start(start_cd1),
                                  .total(num_fast2),
                                  .num_fast1(num_fast1),
                                  .XY_in(XY_in_2),
                                  .sc_in(sc_in_2),
                                  .mod(mod_2),
                                  .din(data_fast_in2),
                                  .addr_b(addr_b_cd2),
                                  .addr_corner(addr_corner_2),
                                  .addr_mod(addr_mod_2),
                                  .addr_out(addr_desc_fast2),
                                  .dout(descriptor_fast2),
                                  .end_cd(end_cd2),
                                  .wren(wren_desc_fast2));
  
  
  scale_recover sr(.start(start_cd1),
                   .rst_n(rst_n),
                   .clk(clk),
                   .num_fast1(num_fast1),
                   .num_fast2(num_fast2),
                   .addr_b_fast1(addr_bb_fast1),
                   .addr_b_fast2(addr_bb_fast2),
                   .XY_in_fast1(XY_in_fast1),
                   .XY_in_fast2(XY_in_fast2),
                   .XYO_fast1(XYO_fast1),
                   .XYO_fast2(XYO_fast2),
                   .addr_out_fast1(addr_XYO_fast1),
                   .addr_out_fast2(addr_XYO_fast2),
                   .wren_XYO_fast1(wren_XYO_fast1),
                   .wren_XYO_fast2(wren_XYO_fast2),
                   .num_total(num_total),
                   .num_L1(num_L1));
                           
                     
  mux_2_1 m2(.sel(sel2),
             .din_1(addr_b_fast1),
             .din_2(addr_b_cd1),
             .dout(addr_now2));
             
  mux_2_1 m3(.sel(sel3),
             .din_1(addr_b_fast2),
             .din_2(addr_b_cd2),
             .dout(addr_now3));
             
  mux_2_1_b m4(.sel(sel2),
               .din_1(addr_out_fast1),
               .din_2(addr_bb_fast1),
               .dout(addr_now4));
               
  mux_2_1_b m5(.sel(sel3),
               .din_1(addr_out_fast2),
               .din_2(addr_bb_fast2),
               .dout(addr_now5));
             
  ram_dp_fast ram5 (.address_a(addr_now4),
                    .address_b(addr_corner_1),
                    .clock(clk),
                    .data_a(dout_fast1),
                    .data_b(),
                    .wren_a(wren_a_fast1),
                    .wren_b(wren_b_fast1),
                    .q_a(XY_in_fast1),
                    .q_b(XY_in_1));
  
  ram_dp_fast ram6( .address_a(addr_now5),
                    .address_b(addr_corner_2),
                    .clock(clk),
                    .data_a(dout_fast2),
                    .data_b(),
                    .wren_a(wren_a_fast2),
                    .wren_b(wren_b_fast2),
                    .q_a(XY_in_fast2),
                    .q_b(XY_in_2));
                    
  ram_dp_sc ram7(   .address_a(addr_out_sc1),
                    .address_b(addr_corner_1),
                    .clock(clk),
                    .data_a(sc_1),
                    .data_b(),
                    .wren_a(wren_a_sc1),
                    .wren_b(wren_b_sc1),
                    .q_a(),
                    .q_b(sc_in_1));  
                    
  ram_dp_sc ram8(   .address_a(addr_out_sc2),
                    .address_b(addr_corner_2),
                    .clock(clk),
                    .data_a(sc_2),
                    .data_b(),
                    .wren_a(wren_a_sc2),
                    .wren_b(wren_b_sc2),
                    .q_a(),
                    .q_b(sc_in_2));
                    
  rom_hc18 rom1(.address(addr_mod_1),
	              .clock(clk),
	              .q(mod_1));
	            
	rom_hc18 rom2(.address(addr_mod_2),
	              .clock(clk),
	              .q(mod_2));
	            
	mul1 mul_1(.aclr(aclr),
	           .clken(enable_oldXY),
	           .clock(clk),
	           .dataa(X),
	           .result(oldX));
	           
	mul2 mul_2(.aclr(aclr),
	           .clken(enable_oldXY),
	           .clock(clk),
	           .dataa(Y),
	           .result(oldY));
	           
	           
	mul3 mul_3_1(.aclr(aclr),
	             .clken(enable_new),
	             .clock(clk),
	             .dataa(data_temp_tp1),
	             .datab(data_temp_tp2),
	             .result(data_temp_tp3));
	             
	mul3 mul_3_2(.aclr(aclr),
	             .clken(enable_new),
	             .clock(clk),
	             .dataa(oldX_tc[11:0]),
	             .datab(data_temp_tp2),
	             .result(data_temp_tp4));
	             
	mul3 mul_3_3(.aclr(aclr),
	             .clken(enable_new),
	             .clock(clk),
	             .dataa(data_temp_tp1),
	             .datab(oldY_tc[11:0]),
	             .result(data_temp_tp5));
	             
	mul3 mul_3_4(.aclr(aclr),
	             .clken(enable_new),
	             .clock(clk),
	             .dataa(oldX_tc[11:0]),
	             .datab(oldY_tc[11:0]),
	             .result(data_temp_tp6));
	             
  mul4 mul_4_1(.aclr(aclr),
               .clken(enable_new),
               .clock(clk),
               .dataa(data_temp_tp3),
               .datab(backup_1_lay1),
               .result(data_temp_tp7));
               
  mul4 mul_4_2(.aclr(aclr),
               .clken(enable_new),
               .clock(clk),
               .dataa(data_temp_tp4),
               .datab(backup_2_lay1),
               .result(data_temp_tp8));
               
  mul4 mul_4_3(.aclr(aclr),
               .clken(enable_new),
               .clock(clk),
               .dataa(data_temp_tp5),
               .datab(data_in_1_lay1),
               .result(data_temp_tp9));
               
  mul4 mul_4_4(.aclr(aclr),
               .clken(enable_new),
               .clock(clk),
               .dataa(data_temp_tp6),
               .datab(data_in_2_lay1),
               .result(data_temp_tp10));
               
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X <= 10'd0;
        Y <= 10'd0;
      end   
    else if(start==1'b1)
      begin
        X <= 10'd1;
        Y <= 10'd1;
      end
    else if(count==1'b1 && X<width)
        X <= X + 1'b1;
    else if(count==1'b1 && X==width && Y<height)
      begin
        X <= 10'd1;
        Y <= Y + 1'b1;
      end
  end 
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count <= 1'b0;
    else if (start==1'b1)
      count <= 1'b0;
    else
      count <= ~count;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        enable_addr_b <= 1'b0;
        enable_XY_temp <= 1'b0;
        enable_data_in <= 1'b0;
        enable_oldXY_tc <= 1'b0;
        enable_backup <= 1'b0;
        enable_XY_tc <= 1'b0;
        enable_new <= 1'b0;
      end
    else if(addr_out==width*height-1'b1)
      begin
        enable_addr_b <= 1'b0;
        enable_XY_temp <= 1'b0;
        enable_data_in <= 1'b0;
        enable_oldXY_tc <= 1'b0;
        enable_backup <= 1'b0;
        enable_XY_tc <= 1'b0;
        enable_new <= 1'b0;
      end
    else
      begin
        enable_addr_b <= enable_oldXY;
        enable_XY_temp <= enable_oldXY;
        enable_data_in <= enable_addr_b;
        enable_oldXY_tc <= enable_addr_b;
        //enable_backup <= enable_data_in;
        enable_XY_tc <= enable_data_in;
        enable_backup <= enable_XY_tc;
        //enable_new <= enable_backup; 
        enable_new <= enable_XY_tc;       
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        enable_oldXY <= 1'b0;
        wren_a_linear <= 1'b0;
      end
    else if(start==1'b1)
      begin
        enable_oldXY <= 1'b1;
        wren_a_linear <= 1'b1;
      end
    else if(addr_out==width*height-1'b1)
	//else if(addr_out==100*100-1'b1)
      begin
        enable_oldXY <= 1'b0;
        wren_a_linear <= 1'b0;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      sel <= 1'b0;
    else if(addr_out==width*height-1'b1)
      sel <= 1'b1;
    else
      sel <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      sel2 <= 1'b0;
    else if(wren_a_fast1==1'b0)
      sel2 <= 1'b1;
    else
      sel2 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      sel3 <= 1'b0;
    else if(wren_a_fast2==1'b0)
      sel3 <= 1'b1;
    else
      sel3 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count_start_extend <= 2'b00;
    else if(start==1'b1)
      count_start_extend <= 2'b00;
    else if(addr_out==width*height-1'b1 && count_start_extend< 2'd2)
      count_start_extend <= count_start_extend + 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      start_extend <= 1'b0;
    else if(addr_out==width*height-1'b1 && count_start_extend==2'd0)
      start_extend <= 1'b1;
    else if(count_start_extend==2'd2)
      start_extend <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_temp <= 10'd0;
        Y_temp <= 10'd0;
      end
    else if(count==1'b1 && enable_XY_temp==1'b1)
      begin
        X_temp <= X;
        Y_temp <= Y;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_tc <= 10'd0;
        Y_tc <= 10'd0;
      end
    else if(count==1'b1 && enable_XY_tc==1'b1)
      begin
        X_tc <= X_temp;
        Y_tc <= Y_temp;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        oldX_tc <= 23'd0;
        oldY_tc <= 23'd0;
      end
    else if(count==1'b0 && enable_oldXY_tc==1'b1)
      begin
        oldX_tc <= oldX;
        oldY_tc <= oldY;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        addr_b1 <= 19'd0;
        addr_b2 <= 19'd0;
      end
    else if(count==1'b1 && enable_addr_b==1'b1)
      begin
        addr_b1 <= addr_b_tp1 + addr_b_tp5;
        addr_b2 <= oldX[22:12] + addr_b_tp5;
      end
    else if(count==1'b0 && enable_addr_b==1'b1)
      begin
        addr_b1 <= addr_b_tp1 + addr_b_tp8;
        addr_b2 <= oldX[22:12] + addr_b_tp8;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        backup_1 <= 8'd0;
        backup_2 <= 8'd0;
      end
    else if(count==1'b0 && enable_backup==1'b1)
      begin
        backup_1 <= data_in_1;
        backup_2 <= data_in_2;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        data_temp_tp11 <= 32'd0;
        data_temp_tp12 <= 32'd0;
        addr_out_tp9 <= 19'd0;
      end
    else if(count==1'b0 && enable_new==1'b1)
      begin
        data_temp_tp11 <= data_temp_tp7 + data_temp_tp8;
        data_temp_tp12 <= data_temp_tp9 + data_temp_tp10;
        addr_out_tp9 <= addr_out_tp1 + addr_out_tp8;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        backup_1_lay1 <= 8'd0;
      //  backup_1_lay2 <= 8'd0;
        backup_2_lay1 <= 8'd0;
      //  backup_2_lay2 <= 8'd0;
        data_in_1_lay1 <= 8'd0;
      //  data_in_1_lay2 <= 8'd0;
        data_in_2_lay1 <= 8'd0;
      //  data_in_2_lay2 <= 8'd0;
        addr_out_tp10 <= 19'd0;
        addr_out_tp11 <= 19'd0;
        addr_out_tp12 <= 19'd0;
        addr_out <= 19'd0;
      end
    else
      begin
        backup_1_lay1 <= backup_1;
     //   backup_1_lay2 <= backup_1_lay1;
        backup_2_lay1 <= backup_2;
     //   backup_2_lay2 <= backup_2_lay1;
        data_in_1_lay1 <= data_in_1;
     //   data_in_1_lay2 <= data_in_1_lay1;
        data_in_2_lay1 <= data_in_2;
     //   data_in_2_lay2 <= data_in_2_lay1;
        addr_out_tp10 <= addr_out_tp9;
        addr_out_tp11 <= addr_out_tp10;
        addr_out_tp12 <= addr_out_tp11;
        addr_out <= addr_out_tp12; 
      end
  end
 

         
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     start_match <= 1'd0;
   else if(start==1)
     start_match <= 1'b0;
   else if(end_cd1==1 && end_cd2==1)     
     start_match <= 1'd1;
   else
     start_match <= 1'd0;       
 end
       
         
       
      
endmodule

