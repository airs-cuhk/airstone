module SAD(start,clk,rst_n,num_matches,XYOXYO,data_left1,data_left2,data_right1,data_right2,fx,mbf,addr_b_matches,addr_b_data_left1,addr_b_data_left2,addr_b_data_right1,
           addr_b_data_right2,depth_out,bestuR_out,XYOXYO_out,bestdist_out,addr_out,depth_t);
  input start;
  input clk;
  input rst_n;
  input [14:0] num_matches;
  input [43:0] XYOXYO;
  input [7:0] data_left1;
  input [7:0] data_left2;
  input [7:0] data_right1;
  input [7:0] data_right2;
  input [8:0] fx;
  input [8:0] mbf;
  output [14:0] addr_b_matches;
  output [18:0] addr_b_data_left1;
  output [18:0] addr_b_data_left2;
  output [18:0] addr_b_data_right1;
  output [18:0] addr_b_data_right2; 
  output [32:0] depth_out;
  output [12:0] depth_t;
  output [21:0] bestuR_out;
  output [43:0] XYOXYO_out;
  output [11:0] bestdist_out;
  output [14:0] addr_out; 

 // reg [43:0] XYOXYO_midterm;
 wire [12:0] depth_t;
 assign depth_t = depth_out[22:10];
  reg flag_midterm;
  reg [43:0] XYOXYO_tc;
  reg [14:0] addr_b_matches;

  wire [9:0] X_in_left;
  wire [9:0] Y_in_left;
  wire [9:0] X_in_right;
  wire [9:0] Y_in_right;
  
  wire aclr;
  
  wire [21:0] result_X_left;
  wire [21:0] result_Y_left;
  wire [21:0] result_X_right;
  wire [21:0] result_Y_right;
  
  wire [9:0] scaledX_left;
  wire [9:0] scaledY_left;
  wire [9:0] scaledX_right;
  wire [9:0] scaledY_right;

  reg [43:0] XYOXYO_tc_tp1;
  reg [43:0] XYOXYO_tc_tp2;
  reg [43:0] XYOXYO_tc_tp3;
  reg [43:0] XYOXYO_tc_tp4;
  reg [43:0] XYOXYO_tc_tp5;

  reg [18:0] addr_b_data_left1;
  reg [18:0] addr_b_data_left2;
  reg [18:0] addr_b_data_right1;
  reg [18:0] addr_b_data_right2; 
  reg [2:0] num;
  reg en_left1;
  reg en_XY_left1;
  reg [9:0] X_left1;
  reg [9:0] Y_left1;
  wire [7:0] taps0_left1,taps1_left1,taps2_left1,taps3_left1,taps4_left1,taps5_left1,taps6_left1,taps7_left1,taps8_left1,taps9_left1,taps10_left1;
  reg [7:0] win11_11_left1,win11_10_left1,win11_9_left1,win11_8_left1,win11_7_left1,win11_6_left1,win11_5_left1,win11_4_left1,win11_3_left1,
            win11_2_left1,win11_1_left1;
  reg [7:0] win10_11_left1,win10_10_left1,win10_9_left1,win10_8_left1,win10_7_left1,win10_6_left1,win10_5_left1,win10_4_left1,win10_3_left1,
            win10_2_left1,win10_1_left1;
  reg [7:0] win9_11_left1,win9_10_left1,win9_9_left1,win9_8_left1,win9_7_left1,win9_6_left1,win9_5_left1,win9_4_left1,win9_3_left1,
            win9_2_left1,win9_1_left1;
  reg [7:0] win8_11_left1,win8_10_left1,win8_9_left1,win8_8_left1,win8_7_left1,win8_6_left1,win8_5_left1,win8_4_left1,win8_3_left1,
            win8_2_left1,win8_1_left1;
  reg [7:0] win7_11_left1,win7_10_left1,win7_9_left1,win7_8_left1,win7_7_left1,win7_6_left1,win7_5_left1,win7_4_left1,win7_3_left1,
            win7_2_left1,win7_1_left1;
  reg [7:0] win6_11_left1,win6_10_left1,win6_9_left1,win6_8_left1,win6_7_left1,win6_6_left1,win6_5_left1,win6_4_left1,win6_3_left1,
            win6_2_left1,win6_1_left1;
  reg [7:0] win5_11_left1,win5_10_left1,win5_9_left1,win5_8_left1,win5_7_left1,win5_6_left1,win5_5_left1,win5_4_left1,win5_3_left1,
            win5_2_left1,win5_1_left1;
  reg [7:0] win4_11_left1,win4_10_left1,win4_9_left1,win4_8_left1,win4_7_left1,win4_6_left1,win4_5_left1,win4_4_left1,win4_3_left1,
            win4_2_left1,win4_1_left1;  
  reg [7:0] win3_11_left1,win3_10_left1,win3_9_left1,win3_8_left1,win3_7_left1,win3_6_left1,win3_5_left1,win3_4_left1,win3_3_left1,
            win3_2_left1,win3_1_left1;  
  reg [7:0] win2_11_left1,win2_10_left1,win2_9_left1,win2_8_left1,win2_7_left1,win2_6_left1,win2_5_left1,win2_4_left1,win2_3_left1,
            win2_2_left1,win2_1_left1;
  reg [7:0] win1_11_left1,win1_10_left1,win1_9_left1,win1_8_left1,win1_7_left1,win1_6_left1,win1_5_left1,win1_4_left1,win1_3_left1,
            win1_2_left1,win1_1_left1;  
 
  reg [9:0] count_left1;
  reg act_Y_left1;
  wire [19:0] XY_left1;
  wire [19:0] XY_in_left;

  reg en_right1;
  reg en_XY_right1;
  reg [9:0] X_right1;
  reg [9:0] Y_right1;
  wire [7:0] taps0_right1,taps1_right1,taps2_right1,taps3_right1,taps4_right1,taps5_right1,taps6_right1,taps7_right1,taps8_right1,taps9_right1,taps10_right1;
  reg [7:0] win11_21_right1,win11_20_right1,win11_19_right1,win11_18_right1,win11_17_right1,win11_16_right1,win11_15_right1,win11_14_right1,win11_13_right1,
            win11_12_right1,win11_11_right1,win11_10_right1,win11_9_right1,win11_8_right1,win11_7_right1,win11_6_right1,win11_5_right1,win11_4_right1,
            win11_3_right1,win11_2_right1,win11_1_right1;
  reg [7:0] win10_21_right1,win10_20_right1,win10_19_right1,win10_18_right1,win10_17_right1,win10_16_right1,win10_15_right1,win10_14_right1,win10_13_right1,
            win10_12_right1,win10_11_right1,win10_10_right1,win10_9_right1,win10_8_right1,win10_7_right1,win10_6_right1,win10_5_right1,win10_4_right1,
            win10_3_right1,win10_2_right1,win10_1_right1;
  reg [7:0] win9_21_right1,win9_20_right1,win9_19_right1,win9_18_right1,win9_17_right1,win9_16_right1,win9_15_right1,win9_14_right1,win9_13_right1,
            win9_12_right1,win9_11_right1,win9_10_right1,win9_9_right1,win9_8_right1,win9_7_right1,win9_6_right1,win9_5_right1,win9_4_right1,
            win9_3_right1,win9_2_right1,win9_1_right1;
  reg [7:0] win8_21_right1,win8_20_right1,win8_19_right1,win8_18_right1,win8_17_right1,win8_16_right1,win8_15_right1,win8_14_right1,win8_13_right1,
            win8_12_right1,win8_11_right1,win8_10_right1,win8_9_right1,win8_8_right1,win8_7_right1,win8_6_right1,win8_5_right1,win8_4_right1,
            win8_3_right1,win8_2_right1,win8_1_right1;
  reg [7:0] win7_21_right1,win7_20_right1,win7_19_right1,win7_18_right1,win7_17_right1,win7_16_right1,win7_15_right1,win7_14_right1,win7_13_right1,
            win7_12_right1,win7_11_right1,win7_10_right1,win7_9_right1,win7_8_right1,win7_7_right1,win7_6_right1,win7_5_right1,win7_4_right1,
            win7_3_right1,win7_2_right1,win7_1_right1;
  reg [7:0] win6_21_right1,win6_20_right1,win6_19_right1,win6_18_right1,win6_17_right1,win6_16_right1,win6_15_right1,win6_14_right1,win6_13_right1,
            win6_12_right1,win6_11_right1,win6_10_right1,win6_9_right1,win6_8_right1,win6_7_right1,win6_6_right1,win6_5_right1,win6_4_right1,
            win6_3_right1,win6_2_right1,win6_1_right1;
  reg [7:0] win5_21_right1,win5_20_right1,win5_19_right1,win5_18_right1,win5_17_right1,win5_16_right1,win5_15_right1,win5_14_right1,win5_13_right1,
            win5_12_right1,win5_11_right1,win5_10_right1,win5_9_right1,win5_8_right1,win5_7_right1,win5_6_right1,win5_5_right1,win5_4_right1,
            win5_3_right1,win5_2_right1,win5_1_right1;
  reg [7:0] win4_21_right1,win4_20_right1,win4_19_right1,win4_18_right1,win4_17_right1,win4_16_right1,win4_15_right1,win4_14_right1,win4_13_right1,
            win4_12_right1,win4_11_right1,win4_10_right1,win4_9_right1,win4_8_right1,win4_7_right1,win4_6_right1,win4_5_right1,win4_4_right1,
            win4_3_right1,win4_2_right1,win4_1_right1; 
  reg [7:0] win3_21_right1,win3_20_right1,win3_19_right1,win3_18_right1,win3_17_right1,win3_16_right1,win3_15_right1,win3_14_right1,win3_13_right1,
            win3_12_right1,win3_11_right1,win3_10_right1,win3_9_right1,win3_8_right1,win3_7_right1,win3_6_right1,win3_5_right1,win3_4_right1,
            win3_3_right1,win3_2_right1,win3_1_right1;
  reg [7:0] win2_21_right1,win2_20_right1,win2_19_right1,win2_18_right1,win2_17_right1,win2_16_right1,win2_15_right1,win2_14_right1,win2_13_right1,
            win2_12_right1,win2_11_right1,win2_10_right1,win2_9_right1,win2_8_right1,win2_7_right1,win2_6_right1,win2_5_right1,win2_4_right1,
            win2_3_right1,win2_2_right1,win2_1_right1;
  reg [7:0] win1_21_right1,win1_20_right1,win1_19_right1,win1_18_right1,win1_17_right1,win1_16_right1,win1_15_right1,win1_14_right1,win1_13_right1,
            win1_12_right1,win1_11_right1,win1_10_right1,win1_9_right1,win1_8_right1,win1_7_right1,win1_6_right1,win1_5_right1,win1_4_right1,
            win1_3_right1,win1_2_right1,win1_1_right1;  
  reg [9:0] count_right1;
  reg act_Y_right1;
  wire [19:0] XY_right1;
  wire [19:0] XY_in_right;

  reg signed [8:0] norm11_left,norm10_left,norm9_left,norm8_left,norm7_left,norm6_left,norm5_left,norm4_left,norm3_left,
            norm2_left,norm1_left;  
  reg signed [8:0] norm11_right,norm10_right,norm9_right,norm8_right,norm7_right,norm6_right,norm5_right,norm4_right,norm3_right,
            norm2_right,norm1_right; 
  reg [3:0] count_windows,count_windows_late1,count_windows_late2,count_windows_late3,count_windows_late4,count_windows_late5;
  reg [3:0] count_cols,count_cols_late1,count_cols_late2,count_cols_late3,count_cols_late4,count_cols_late5; 
  wire signed [9:0] diff1,diff2,diff3,diff4,diff5,diff6,diff7,diff8,diff9,diff10,diff11;
  wire [9:0] sum_tp1,sum_tp2,sum_tp3,sum_tp4,sum_tp5,sum_tp6;
  reg [10:0] sum_tp7,sum_tp8,sum_tp9;
  wire [11:0] sum; 
  reg [11:0] max_sum_w1,max_sum_w2,max_sum_w3,max_sum_w4,max_sum_w5,max_sum_w6,max_sum_w7,max_sum_w8,max_sum_w9,max_sum_w10,max_sum_w11;
  reg [11:0] bestdist;
  reg [3:0] bestincR;
  reg [11:0] dist1,dist2,dist3;
  wire signed [12:0] numer_tp1;
  wire signed [24:0] numer;
  wire [11:0] denom_tp1,denom_tp2;
  wire [12:0] denom_tp3;
  wire [13:0] denom;
  reg en_dR;
  wire signed [24:0] deltaR;
  
  reg [19:0] scaledXY_left;
  reg [19:0] scaledXY_right;
 // reg [19:0] scaledXY_tc_left;
  //reg [19:0] scaledXY_tc_right;
  reg en_left2;
  reg en_right2;
  reg [9:0] count_left2;
  reg [9:0] count_right2;
  reg en_XY_left2;
  reg en_XY_right2;
  reg act_Y_left2;
  reg act_Y_right2;
  reg [9:0] X_left2;
  reg [9:0] Y_left2;
  reg [9:0] X_right2;
  reg [9:0] Y_right2;
  wire [19:0] XY_left2;
  wire [19:0] XY_right2;
  wire [7:0] taps0_left2,taps1_left2,taps2_left2,taps3_left2,taps4_left2,taps5_left2,taps6_left2,taps7_left2,taps8_left2,taps9_left2,taps10_left2;
  wire [7:0] taps0_right2,taps1_right2,taps2_right2,taps3_right2,taps4_right2,taps5_right2,taps6_right2,taps7_right2,taps8_right2,taps9_right2,taps10_right2;
  reg [7:0] win11_11_left2,win11_10_left2,win11_9_left2,win11_8_left2,win11_7_left2,win11_6_left2,win11_5_left2,win11_4_left2,win11_3_left2,
            win11_2_left2,win11_1_left2;
  reg [7:0] win10_11_left2,win10_10_left2,win10_9_left2,win10_8_left2,win10_7_left2,win10_6_left2,win10_5_left2,win10_4_left2,win10_3_left2,
            win10_2_left2,win10_1_left2;
  reg [7:0] win9_11_left2,win9_10_left2,win9_9_left2,win9_8_left2,win9_7_left2,win9_6_left2,win9_5_left2,win9_4_left2,win9_3_left2,
            win9_2_left2,win9_1_left2;
  reg [7:0] win8_11_left2,win8_10_left2,win8_9_left2,win8_8_left2,win8_7_left2,win8_6_left2,win8_5_left2,win8_4_left2,win8_3_left2,
            win8_2_left2,win8_1_left2;
  reg [7:0] win7_11_left2,win7_10_left2,win7_9_left2,win7_8_left2,win7_7_left2,win7_6_left2,win7_5_left2,win7_4_left2,win7_3_left2,
            win7_2_left2,win7_1_left2;
  reg [7:0] win6_11_left2,win6_10_left2,win6_9_left2,win6_8_left2,win6_7_left2,win6_6_left2,win6_5_left2,win6_4_left2,win6_3_left2,
            win6_2_left2,win6_1_left2;
  reg [7:0] win5_11_left2,win5_10_left2,win5_9_left2,win5_8_left2,win5_7_left2,win5_6_left2,win5_5_left2,win5_4_left2,win5_3_left2,
            win5_2_left2,win5_1_left2;
  reg [7:0] win4_11_left2,win4_10_left2,win4_9_left2,win4_8_left2,win4_7_left2,win4_6_left2,win4_5_left2,win4_4_left2,win4_3_left2,
            win4_2_left2,win4_1_left2;  
  reg [7:0] win3_11_left2,win3_10_left2,win3_9_left2,win3_8_left2,win3_7_left2,win3_6_left2,win3_5_left2,win3_4_left2,win3_3_left2,
            win3_2_left2,win3_1_left2;  
  reg [7:0] win2_11_left2,win2_10_left2,win2_9_left2,win2_8_left2,win2_7_left2,win2_6_left2,win2_5_left2,win2_4_left2,win2_3_left2,
            win2_2_left2,win2_1_left2;
  reg [7:0] win1_11_left2,win1_10_left2,win1_9_left2,win1_8_left2,win1_7_left2,win1_6_left2,win1_5_left2,win1_4_left2,win1_3_left2,
            win1_2_left2,win1_1_left2;
  
  reg [7:0] win11_21_right2,win11_20_right2,win11_19_right2,win11_18_right2,win11_17_right2,win11_16_right2,win11_15_right2,win11_14_right2,win11_13_right2,
            win11_12_right2,win11_11_right2,win11_10_right2,win11_9_right2,win11_8_right2,win11_7_right2,win11_6_right2,win11_5_right2,win11_4_right2,
            win11_3_right2,win11_2_right2,win11_1_right2;
  reg [7:0] win10_21_right2,win10_20_right2,win10_19_right2,win10_18_right2,win10_17_right2,win10_16_right2,win10_15_right2,win10_14_right2,win10_13_right2,
            win10_12_right2,win10_11_right2,win10_10_right2,win10_9_right2,win10_8_right2,win10_7_right2,win10_6_right2,win10_5_right2,win10_4_right2,
            win10_3_right2,win10_2_right2,win10_1_right2;
  reg [7:0] win9_21_right2,win9_20_right2,win9_19_right2,win9_18_right2,win9_17_right2,win9_16_right2,win9_15_right2,win9_14_right2,win9_13_right2,
            win9_12_right2,win9_11_right2,win9_10_right2,win9_9_right2,win9_8_right2,win9_7_right2,win9_6_right2,win9_5_right2,win9_4_right2,
            win9_3_right2,win9_2_right2,win9_1_right2;
  reg [7:0] win8_21_right2,win8_20_right2,win8_19_right2,win8_18_right2,win8_17_right2,win8_16_right2,win8_15_right2,win8_14_right2,win8_13_right2,
            win8_12_right2,win8_11_right2,win8_10_right2,win8_9_right2,win8_8_right2,win8_7_right2,win8_6_right2,win8_5_right2,win8_4_right2,
            win8_3_right2,win8_2_right2,win8_1_right2;
  reg [7:0] win7_21_right2,win7_20_right2,win7_19_right2,win7_18_right2,win7_17_right2,win7_16_right2,win7_15_right2,win7_14_right2,win7_13_right2,
            win7_12_right2,win7_11_right2,win7_10_right2,win7_9_right2,win7_8_right2,win7_7_right2,win7_6_right2,win7_5_right2,win7_4_right2,
            win7_3_right2,win7_2_right2,win7_1_right2;
  reg [7:0] win6_21_right2,win6_20_right2,win6_19_right2,win6_18_right2,win6_17_right2,win6_16_right2,win6_15_right2,win6_14_right2,win6_13_right2,
            win6_12_right2,win6_11_right2,win6_10_right2,win6_9_right2,win6_8_right2,win6_7_right2,win6_6_right2,win6_5_right2,win6_4_right2,
            win6_3_right2,win6_2_right2,win6_1_right2;
  reg [7:0] win5_21_right2,win5_20_right2,win5_19_right2,win5_18_right2,win5_17_right2,win5_16_right2,win5_15_right2,win5_14_right2,win5_13_right2,
            win5_12_right2,win5_11_right2,win5_10_right2,win5_9_right2,win5_8_right2,win5_7_right2,win5_6_right2,win5_5_right2,win5_4_right2,
            win5_3_right2,win5_2_right2,win5_1_right2;
  reg [7:0] win4_21_right2,win4_20_right2,win4_19_right2,win4_18_right2,win4_17_right2,win4_16_right2,win4_15_right2,win4_14_right2,win4_13_right2,
            win4_12_right2,win4_11_right2,win4_10_right2,win4_9_right2,win4_8_right2,win4_7_right2,win4_6_right2,win4_5_right2,win4_4_right2,
            win4_3_right2,win4_2_right2,win4_1_right2; 
  reg [7:0] win3_21_right2,win3_20_right2,win3_19_right2,win3_18_right2,win3_17_right2,win3_16_right2,win3_15_right2,win3_14_right2,win3_13_right2,
            win3_12_right2,win3_11_right2,win3_10_right2,win3_9_right2,win3_8_right2,win3_7_right2,win3_6_right2,win3_5_right2,win3_4_right2,
            win3_3_right2,win3_2_right2,win3_1_right2;
  reg [7:0] win2_21_right2,win2_20_right2,win2_19_right2,win2_18_right2,win2_17_right2,win2_16_right2,win2_15_right2,win2_14_right2,win2_13_right2,
            win2_12_right2,win2_11_right2,win2_10_right2,win2_9_right2,win2_8_right2,win2_7_right2,win2_6_right2,win2_5_right2,win2_4_right2,
            win2_3_right2,win2_2_right2,win2_1_right2;
  reg [7:0] win1_21_right2,win1_20_right2,win1_19_right2,win1_18_right2,win1_17_right2,win1_16_right2,win1_15_right2,win1_14_right2,win1_13_right2,
            win1_12_right2,win1_11_right2,win1_10_right2,win1_9_right2,win1_8_right2,win1_7_right2,win1_6_right2,win1_5_right2,win1_4_right2,
            win1_3_right2,win1_2_right2,win1_1_right2; 
  
  reg [5:0] count_arith;
  wire signed [22:0] X_right_bestuR;
  reg signed [12:0] deltaR_bestuR;
  reg en_bestuR;
  reg signed [22:0] bestuR_tp1;
  wire [21:0] bestuR_tp2;
  reg en_mul10;
  wire [34:0] bestuR_tp3;
  reg [21:0] bestuR_tp4;
  reg [21:0] bestuR_tp5;
  reg [21:0] bestuR_tp6;
  reg [21:0] bestuR_tp7;
  reg [21:0] bestuR_tp8;
  wire [21:0] bestuR;
  reg signed [22:0] disparity;
  reg en_depth;
  wire signed [22:0] maxD;
  wire [32:0] mbf_depth;
  wire [21:0] disparity_depth;
  wire [32:0] depth;
  reg [14:0] addr_out_tp;  
  reg [32:0] depth_out;
  reg [21:0] bestuR_out;
  reg [43:0] XYOXYO_out;
  reg [11:0] bestdist_out;
  reg endl,endl_tp1,endl_tp2,endl_tp3,endl_tp4,endl_tp5,endl_tp6,endl_tp7,endl_tp8;
  wire signed [22:0] a,b,c,d,e,f,g,h;
  
  
  assign X_in_left = XYOXYO_tc[43:34];
  assign Y_in_left = XYOXYO_tc[33:24];
  assign X_in_right = XYOXYO_tc[21:12];
  assign Y_in_right = XYOXYO_tc[11:2];
  assign aclr = ~rst_n;
 
  assign scaledX_left = (result_X_left[11]==1)? result_X_left[21:12]+1'b1 : result_X_left[21:12];
  assign scaledY_left = (result_Y_left[11]==1)? result_Y_left[21:12]+1'b1 : result_Y_left[21:12];
  assign scaledX_right = (result_X_right[11]==1)? result_X_right[21:12]+1'b1 : result_X_right[21:12];
  assign scaledY_right = (result_Y_right[11]==1)? result_Y_right[21:12]+1'b1 : result_Y_right[21:12];
 // assign scaledXY_left = {scaledX_left,scaledY_left};
 // assign scaledXY_right = {scaledX_right,scaledY_left};
 
  assign XY_in_left = XYOXYO_tc_tp5[43:24];
  assign XY_in_right = {XYOXYO_tc_tp5[21:12],XYOXYO_tc_tp5[33:24]};
  assign XY_left1 = {X_left1,Y_left1};
  assign XY_right1 = {X_right1,Y_right1};
  assign XY_left2 = {X_left2,Y_left2};
  assign XY_right2 = {X_right2,Y_right2};
  
  assign diff1 = (norm1_left>norm1_right)? norm1_left-norm1_right : norm1_right-norm1_left;
  assign diff2 = (norm2_left>norm2_right)? norm2_left-norm2_right : norm2_right-norm2_left;
  assign diff3 = (norm3_left>norm3_right)? norm3_left-norm3_right : norm3_right-norm3_left;
  assign diff4 = (norm4_left>norm4_right)? norm4_left-norm4_right : norm4_right-norm4_left;
  assign diff5 = (norm5_left>norm5_right)? norm5_left-norm5_right : norm5_right-norm5_left;
  assign diff6 = (norm6_left>norm6_right)? norm6_left-norm6_right : norm6_right-norm6_left;
  assign diff7 = (norm7_left>norm7_right)? norm7_left-norm7_right : norm7_right-norm7_left;
  assign diff8 = (norm8_left>norm8_right)? norm8_left-norm8_right : norm8_right-norm8_left;
  assign diff9 = (norm9_left>norm9_right)? norm9_left-norm9_right : norm9_right-norm9_left;
  assign diff10 = (norm10_left>norm10_right)? norm10_left-norm10_right : norm10_right-norm10_left;
  assign diff11 = (norm11_left>norm11_right)? norm11_left-norm11_right : norm11_right-norm11_left;
  
  assign sum_tp1 = diff1 + diff2;
  assign sum_tp2 = diff3 + diff4;
  assign sum_tp3 = diff5 + diff6;
  assign sum_tp4 = diff7 + diff8;
  assign sum_tp5 = diff9 + diff10;
  assign sum_tp6 = diff11;
  
  assign sum = sum_tp7 + sum_tp8 + sum_tp9;
  
  assign numer_tp1 = dist1 - dist3;
  assign numer = {numer_tp1,12'd0};
  assign denom_tp1 = dist1 - dist2;
  assign denom_tp2 = dist3 - dist2;
  assign denom_tp3 = denom_tp1 + denom_tp2;
  assign denom = {denom_tp3,1'b0};
  
  
  assign X_right_bestuR = (XYOXYO_tc_tp5[23:22]==2'b01)? {1'b0,XYOXYO_tc_tp5[21:12],12'd0} : {1'b0,scaledX_right,12'd0};
  assign bestuR_tp2 = bestuR_tp1[21:0];
  assign bestuR = (XYOXYO_tc_tp5[23:22]==2'b01)? bestuR_tp8 : bestuR_tp3[33:12];
  assign maxD = {2'd0,fx,12'd0};
  assign mbf_depth = {mbf,24'd0};
  assign disparity_depth = disparity[21:0];
  assign addr_out = (addr_out_tp==15'd0)? 15'd0 : addr_out_tp - 1'b1;
  
  assign a = X_right_bestuR - 16'd16384;
  assign b = X_right_bestuR - 16'd12288;
  assign c = X_right_bestuR - 16'd8192;
  assign d = X_right_bestuR - 16'd4096;
  assign e = X_right_bestuR + 16'd4096;
  assign f = X_right_bestuR + 16'd8192;
  assign g = X_right_bestuR + 16'd12288;
  assign h = X_right_bestuR + 16'd16384;
  
mul9 m1(.aclr(aclr),
        .dataa(X_in_left),
        .clock(clk),
        .result(result_X_left));
        
mul9 m2(.aclr(aclr),
        .dataa(Y_in_left),
        .clock(clk),
        .result(result_Y_left));
        
mul9 m3(.aclr(aclr),
        .dataa(X_in_right),
        .clock(clk),
        .result(result_X_right));
        
mul9 m4(.aclr(aclr),
        .dataa(Y_in_right),
        .clock(clk),
        .result(result_Y_right));
        
line_buffer_11_678 lb1(.clken(en_left1),
                       .clock(clk),
                       .shiftin(data_left1),
                       .shiftout(),
                       .taps0x(taps0_left1),
                       .taps1x(taps1_left1),
                       .taps2x(taps2_left1),
                       .taps3x(taps3_left1),
                       .taps4x(taps4_left1),
                       .taps5x(taps5_left1),
                       .taps6x(taps6_left1),
                       .taps7x(taps7_left1),
                       .taps8x(taps8_left1),
                       .taps9x(taps9_left1),
                       .taps10x(taps10_left1));
                       
line_buffer_11_678 lb2(.clken(en_right1),
                       .clock(clk),
                       .shiftin(data_right1),
                       .shiftout(),
                       .taps0x(taps0_right1),
                       .taps1x(taps1_right1),
                       .taps2x(taps2_right1),
                       .taps3x(taps3_right1),
                       .taps4x(taps4_right1),
                       .taps5x(taps5_right1),
                       .taps6x(taps6_right1),
                       .taps7x(taps7_right1),
                       .taps8x(taps8_right1),
                       .taps9x(taps9_right1),
                       .taps10x(taps10_right1));
                       
line_buffer_11_571 lb3(.clken(en_left2),
                       .clock(clk),
                       .shiftin(data_left2),
                       .shiftout(),
                       .taps0x(taps0_left2),
                       .taps1x(taps1_left2),
                       .taps2x(taps2_left2),
                       .taps3x(taps3_left2),
                       .taps4x(taps4_left2),
                       .taps5x(taps5_left2),
                       .taps6x(taps6_left2),
                       .taps7x(taps7_left2),
                       .taps8x(taps8_left2),
                       .taps9x(taps9_left2),
                       .taps10x(taps10_left2));
                       
line_buffer_11_571 lb4(.clken(en_right2),
                       .clock(clk),
                       .shiftin(data_right2),
                       .shiftout(),
                       .taps0x(taps0_right2),
                       .taps1x(taps1_right2),
                       .taps2x(taps2_right2),
                       .taps3x(taps3_right2),
                       .taps4x(taps4_right2),
                       .taps5x(taps5_right2),
                       .taps6x(taps6_right2),
                       .taps7x(taps7_right2),
                       .taps8x(taps8_right2),
                       .taps9x(taps9_right2),
                       .taps10x(taps10_right2));
                      
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_11_left1 <= 8'd0;
        win10_11_left1 <= 8'd0;
        win9_11_left1 <= 8'd0;
        win8_11_left1 <= 8'd0;
        win7_11_left1 <= 8'd0;
        win6_11_left1 <= 8'd0;
        win5_11_left1 <= 8'd0;
        win4_11_left1 <= 8'd0;
        win3_11_left1 <= 8'd0;
        win2_11_left1 <= 8'd0;
        win1_11_left1 <= 8'd0;
      end
    else if(en_left1==1 && addr_b_data_left1>=16950)
      begin
        win11_11_left1 <= taps0_left1;
        win10_11_left1 <= taps1_left1;
        win9_11_left1 <= taps2_left1;
        win8_11_left1 <= taps3_left1;
        win7_11_left1 <= taps4_left1;
        win6_11_left1 <= taps5_left1;
        win5_11_left1 <= taps6_left1;
        win4_11_left1 <= taps7_left1;
        win3_11_left1 <= taps8_left1;
        win2_11_left1 <= taps9_left1;
        win1_11_left1 <= taps10_left1;
      end
  end
    
    
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_10_left1 <= 8'd0;
        win11_9_left1 <= 8'd0;
        win11_8_left1 <= 8'd0;
        win11_7_left1 <= 8'd0;
        win11_6_left1 <= 8'd0;
        win11_5_left1 <= 8'd0;
        win11_4_left1 <= 8'd0;
        win11_3_left1 <= 8'd0;
        win11_2_left1 <= 8'd0;
        win11_1_left1 <= 8'd0;
        win10_10_left1 <= 8'd0;
        win10_9_left1 <= 8'd0;
        win10_8_left1 <= 8'd0;
        win10_7_left1 <= 8'd0;
        win10_6_left1 <= 8'd0;
        win10_5_left1 <= 8'd0;
        win10_4_left1 <= 8'd0;
        win10_3_left1 <= 8'd0;
        win10_2_left1 <= 8'd0;
        win10_1_left1 <= 8'd0;
        win9_10_left1 <= 8'd0;
        win9_9_left1 <= 8'd0;
        win9_8_left1 <= 8'd0;
        win9_7_left1 <= 8'd0;
        win9_6_left1 <= 8'd0;
        win9_5_left1 <= 8'd0;
        win9_4_left1 <= 8'd0;
        win9_3_left1 <= 8'd0;
        win9_2_left1 <= 8'd0;
        win9_1_left1 <= 8'd0;
        win8_10_left1 <= 8'd0;
        win8_9_left1 <= 8'd0;
        win8_8_left1 <= 8'd0;
        win8_7_left1 <= 8'd0;
        win8_6_left1 <= 8'd0;
        win8_5_left1 <= 8'd0;
        win8_4_left1 <= 8'd0;
        win8_3_left1 <= 8'd0;
        win8_2_left1 <= 8'd0;
        win8_1_left1 <= 8'd0;
        win7_10_left1 <= 8'd0;
        win7_9_left1 <= 8'd0;
        win7_8_left1 <= 8'd0;
        win7_7_left1 <= 8'd0;
        win7_6_left1 <= 8'd0;
        win7_5_left1 <= 8'd0;
        win7_4_left1 <= 8'd0;
        win7_3_left1 <= 8'd0;
        win7_2_left1 <= 8'd0;
        win7_1_left1 <= 8'd0;
        win6_10_left1 <= 8'd0;
        win6_9_left1 <= 8'd0;
        win6_8_left1 <= 8'd0;
        win6_7_left1 <= 8'd0;
        win6_6_left1 <= 8'd0;
        win6_5_left1 <= 8'd0;
        win6_4_left1 <= 8'd0;
        win6_3_left1 <= 8'd0;
        win6_2_left1 <= 8'd0;
        win6_1_left1 <= 8'd0;
        win5_10_left1 <= 8'd0;
        win5_9_left1 <= 8'd0;
        win5_8_left1 <= 8'd0;
        win5_7_left1 <= 8'd0;
        win5_6_left1 <= 8'd0;
        win5_5_left1 <= 8'd0;
        win5_4_left1 <= 8'd0;
        win5_3_left1 <= 8'd0;
        win5_2_left1 <= 8'd0;
        win5_1_left1 <= 8'd0;   
        win4_10_left1 <= 8'd0;
        win4_9_left1 <= 8'd0;
        win4_8_left1 <= 8'd0;
        win4_7_left1 <= 8'd0;
        win4_6_left1 <= 8'd0;
        win4_5_left1 <= 8'd0;
        win4_4_left1 <= 8'd0;
        win4_3_left1 <= 8'd0;
        win4_2_left1 <= 8'd0;
        win4_1_left1 <= 8'd0;
        win3_10_left1 <= 8'd0;
        win3_9_left1 <= 8'd0;
        win3_8_left1 <= 8'd0;
        win3_7_left1 <= 8'd0;
        win3_6_left1 <= 8'd0;
        win3_5_left1 <= 8'd0;
        win3_4_left1 <= 8'd0;
        win3_3_left1 <= 8'd0;
        win3_2_left1 <= 8'd0;
        win3_1_left1 <= 8'd0;
        win2_10_left1 <= 8'd0;
        win2_9_left1 <= 8'd0;
        win2_8_left1 <= 8'd0;
        win2_7_left1 <= 8'd0;
        win2_6_left1 <= 8'd0;
        win2_5_left1 <= 8'd0;
        win2_4_left1 <= 8'd0;
        win2_3_left1 <= 8'd0;
        win2_2_left1 <= 8'd0;
        win2_1_left1 <= 8'd0;              
        win1_10_left1 <= 8'd0;
        win1_9_left1 <= 8'd0;
        win1_8_left1 <= 8'd0;
        win1_7_left1 <= 8'd0;
        win1_6_left1 <= 8'd0;
        win1_5_left1 <= 8'd0;
        win1_4_left1 <= 8'd0;
        win1_3_left1 <= 8'd0;
        win1_2_left1 <= 8'd0;
        win1_1_left1 <= 8'd0; 
      end
    else if(en_left1==1)
      begin
        win11_10_left1 <= win11_11_left1;
        win11_9_left1 <= win11_10_left1;
        win11_8_left1 <= win11_9_left1;
        win11_7_left1 <= win11_8_left1;
        win11_6_left1 <= win11_7_left1;
        win11_5_left1 <= win11_6_left1;
        win11_4_left1 <= win11_5_left1;
        win11_3_left1 <= win11_4_left1;
        win11_2_left1 <= win11_3_left1;
        win11_1_left1 <= win11_2_left1;
        win10_10_left1 <= win10_11_left1;
        win10_9_left1 <= win10_10_left1;
        win10_8_left1 <= win10_9_left1;
        win10_7_left1 <= win10_8_left1;
        win10_6_left1 <= win10_7_left1;
        win10_5_left1 <= win10_6_left1;
        win10_4_left1 <= win10_5_left1;
        win10_3_left1 <= win10_4_left1;
        win10_2_left1 <= win10_3_left1;
        win10_1_left1 <= win10_2_left1;
        win9_10_left1 <= win9_11_left1;
        win9_9_left1 <= win9_10_left1;
        win9_8_left1 <= win9_9_left1;
        win9_7_left1 <= win9_8_left1;
        win9_6_left1 <= win9_7_left1;
        win9_5_left1 <= win9_6_left1;
        win9_4_left1 <= win9_5_left1;
        win9_3_left1 <= win9_4_left1;
        win9_2_left1 <= win9_3_left1;
        win9_1_left1 <= win9_2_left1;
        win8_10_left1 <= win8_11_left1;
        win8_9_left1 <= win8_10_left1;
        win8_8_left1 <= win8_9_left1;
        win8_7_left1 <= win8_8_left1;
        win8_6_left1 <= win8_7_left1;
        win8_5_left1 <= win8_6_left1;
        win8_4_left1 <= win8_5_left1;
        win8_3_left1 <= win8_4_left1;
        win8_2_left1 <= win8_3_left1;
        win8_1_left1 <= win8_2_left1;
        win7_10_left1 <= win7_11_left1;
        win7_9_left1 <= win7_10_left1;
        win7_8_left1 <= win7_9_left1;
        win7_7_left1 <= win7_8_left1;
        win7_6_left1 <= win7_7_left1;
        win7_5_left1 <= win7_6_left1;
        win7_4_left1 <= win7_5_left1;
        win7_3_left1 <= win7_4_left1;
        win7_2_left1 <= win7_3_left1;
        win7_1_left1 <= win7_2_left1;
        win6_10_left1 <= win6_11_left1;
        win6_9_left1 <= win6_10_left1;
        win6_8_left1 <= win6_9_left1;
        win6_7_left1 <= win6_8_left1;
        win6_6_left1 <= win6_7_left1;
        win6_5_left1 <= win6_6_left1;
        win6_4_left1 <= win6_5_left1;
        win6_3_left1 <= win6_4_left1;
        win6_2_left1 <= win6_3_left1;
        win6_1_left1 <= win6_2_left1;
        win5_10_left1 <= win5_11_left1;
        win5_9_left1 <= win5_10_left1;
        win5_8_left1 <= win5_9_left1;
        win5_7_left1 <= win5_8_left1;
        win5_6_left1 <= win5_7_left1;
        win5_5_left1 <= win5_6_left1;
        win5_4_left1 <= win5_5_left1;
        win5_3_left1 <= win5_4_left1;
        win5_2_left1 <= win5_3_left1;
        win5_1_left1 <= win5_2_left1;
        win4_10_left1 <= win4_11_left1;
        win4_9_left1 <= win4_10_left1;
        win4_8_left1 <= win4_9_left1;
        win4_7_left1 <= win4_8_left1;
        win4_6_left1 <= win4_7_left1;
        win4_5_left1 <= win4_6_left1;
        win4_4_left1 <= win4_5_left1;
        win4_3_left1 <= win4_4_left1;
        win4_2_left1 <= win4_3_left1;
        win4_1_left1 <= win4_2_left1;
        win3_10_left1 <= win3_11_left1;
        win3_9_left1 <= win3_10_left1;
        win3_8_left1 <= win3_9_left1;
        win3_7_left1 <= win3_8_left1;
        win3_6_left1 <= win3_7_left1;
        win3_5_left1 <= win3_6_left1;
        win3_4_left1 <= win3_5_left1;
        win3_3_left1 <= win3_4_left1;
        win3_2_left1 <= win3_3_left1;
        win3_1_left1 <= win3_2_left1;
        win2_10_left1 <= win2_11_left1;
        win2_9_left1 <= win2_10_left1;
        win2_8_left1 <= win2_9_left1;
        win2_7_left1 <= win2_8_left1;
        win2_6_left1 <= win2_7_left1;
        win2_5_left1 <= win2_6_left1;
        win2_4_left1 <= win2_5_left1;
        win2_3_left1 <= win2_4_left1;
        win2_2_left1 <= win2_3_left1;
        win2_1_left1 <= win2_2_left1;
        win1_10_left1 <= win1_11_left1;
        win1_9_left1 <= win1_10_left1;
        win1_8_left1 <= win1_9_left1;
        win1_7_left1 <= win1_8_left1;
        win1_6_left1 <= win1_7_left1;
        win1_5_left1 <= win1_6_left1;
        win1_4_left1 <= win1_5_left1;
        win1_3_left1 <= win1_4_left1;
        win1_2_left1 <= win1_3_left1;
        win1_1_left1 <= win1_2_left1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_21_right1 <= 8'd0;
        win10_21_right1 <= 8'd0;
        win9_21_right1 <= 8'd0;
        win8_21_right1 <= 8'd0;
        win7_21_right1 <= 8'd0;
        win6_21_right1 <= 8'd0;
        win5_21_right1 <= 8'd0;
        win4_21_right1 <= 8'd0;
        win3_21_right1 <= 8'd0;
        win2_21_right1 <= 8'd0;
        win1_21_right1 <= 8'd0;
      end
    else if(en_right1==1 && addr_b_data_right1>=16950)
      begin
        win11_21_right1 <= taps0_right1;
        win10_21_right1 <= taps1_right1;
        win9_21_right1 <= taps2_right1;
        win8_21_right1 <= taps3_right1;
        win7_21_right1 <= taps4_right1;
        win6_21_right1 <= taps5_right1;
        win5_21_right1 <= taps6_right1;
        win4_21_right1 <= taps7_right1;
        win3_21_right1 <= taps8_right1;
        win2_21_right1 <= taps9_right1;
        win1_21_right1 <= taps10_right1;
      end
  end
    
    
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_20_right1 <= 8'd0;
        win11_19_right1 <= 8'd0;
        win11_18_right1 <= 8'd0;
        win11_17_right1 <= 8'd0;
        win11_16_right1 <= 8'd0;
        win11_15_right1 <= 8'd0;
        win11_14_right1 <= 8'd0;
        win11_13_right1 <= 8'd0;
        win11_12_right1 <= 8'd0;
        win11_11_right1 <= 8'd0;       
        win11_10_right1 <= 8'd0;
        win11_9_right1 <= 8'd0;
        win11_8_right1 <= 8'd0;
        win11_7_right1 <= 8'd0;
        win11_6_right1 <= 8'd0;
        win11_5_right1 <= 8'd0;
        win11_4_right1 <= 8'd0;
        win11_3_right1 <= 8'd0;
        win11_2_right1 <= 8'd0;
        win11_1_right1 <= 8'd0;
        win10_20_right1 <= 8'd0;
        win10_19_right1 <= 8'd0;
        win10_18_right1 <= 8'd0;
        win10_17_right1 <= 8'd0;
        win10_16_right1 <= 8'd0;
        win10_15_right1 <= 8'd0;
        win10_14_right1 <= 8'd0;
        win10_13_right1 <= 8'd0;
        win10_12_right1 <= 8'd0;
        win10_11_right1 <= 8'd0;       
        win10_10_right1 <= 8'd0;
        win10_9_right1 <= 8'd0;
        win10_8_right1 <= 8'd0;
        win10_7_right1 <= 8'd0;
        win10_6_right1 <= 8'd0;
        win10_5_right1 <= 8'd0;
        win10_4_right1 <= 8'd0;
        win10_3_right1 <= 8'd0;
        win10_2_right1 <= 8'd0;
        win10_1_right1 <= 8'd0;
        win9_20_right1 <= 8'd0;
        win9_19_right1 <= 8'd0;
        win9_18_right1 <= 8'd0;
        win9_17_right1 <= 8'd0;
        win9_16_right1 <= 8'd0;
        win9_15_right1 <= 8'd0;
        win9_14_right1 <= 8'd0;
        win9_13_right1 <= 8'd0;
        win9_12_right1 <= 8'd0;
        win9_11_right1 <= 8'd0;       
        win9_10_right1 <= 8'd0;
        win9_9_right1 <= 8'd0;
        win9_8_right1 <= 8'd0;
        win9_7_right1 <= 8'd0;
        win9_6_right1 <= 8'd0;
        win9_5_right1 <= 8'd0;
        win9_4_right1 <= 8'd0;
        win9_3_right1 <= 8'd0;
        win9_2_right1 <= 8'd0;
        win9_1_right1 <= 8'd0;
        win8_20_right1 <= 8'd0;
        win8_19_right1 <= 8'd0;
        win8_18_right1 <= 8'd0;
        win8_17_right1 <= 8'd0;
        win8_16_right1 <= 8'd0;
        win8_15_right1 <= 8'd0;
        win8_14_right1 <= 8'd0;
        win8_13_right1 <= 8'd0;
        win8_12_right1 <= 8'd0;
        win8_11_right1 <= 8'd0;       
        win8_10_right1 <= 8'd0;
        win8_9_right1 <= 8'd0;
        win8_8_right1 <= 8'd0;
        win8_7_right1 <= 8'd0;
        win8_6_right1 <= 8'd0;
        win8_5_right1 <= 8'd0;
        win8_4_right1 <= 8'd0;
        win8_3_right1 <= 8'd0;
        win8_2_right1 <= 8'd0;
        win8_1_right1 <= 8'd0;
        win7_20_right1 <= 8'd0;
        win7_19_right1 <= 8'd0;
        win7_18_right1 <= 8'd0;
        win7_17_right1 <= 8'd0;
        win7_16_right1 <= 8'd0;
        win7_15_right1 <= 8'd0;
        win7_14_right1 <= 8'd0;
        win7_13_right1 <= 8'd0;
        win7_12_right1 <= 8'd0;
        win7_11_right1 <= 8'd0;       
        win7_10_right1 <= 8'd0;
        win7_9_right1 <= 8'd0;
        win7_8_right1 <= 8'd0;
        win7_7_right1 <= 8'd0;
        win7_6_right1 <= 8'd0;
        win7_5_right1 <= 8'd0;
        win7_4_right1 <= 8'd0;
        win7_3_right1 <= 8'd0;
        win7_2_right1 <= 8'd0;
        win7_1_right1 <= 8'd0;
        win6_20_right1 <= 8'd0;
        win6_19_right1 <= 8'd0;
        win6_18_right1 <= 8'd0;
        win6_17_right1 <= 8'd0;
        win6_16_right1 <= 8'd0;
        win6_15_right1 <= 8'd0;
        win6_14_right1 <= 8'd0;
        win6_13_right1 <= 8'd0;
        win6_12_right1 <= 8'd0;
        win6_11_right1 <= 8'd0;       
        win6_10_right1 <= 8'd0;
        win6_9_right1 <= 8'd0;
        win6_8_right1 <= 8'd0;
        win6_7_right1 <= 8'd0;
        win6_6_right1 <= 8'd0;
        win6_5_right1 <= 8'd0;
        win6_4_right1 <= 8'd0;
        win6_3_right1 <= 8'd0;
        win6_2_right1 <= 8'd0;
        win6_1_right1 <= 8'd0;
        win5_20_right1 <= 8'd0;
        win5_19_right1 <= 8'd0;
        win5_18_right1 <= 8'd0;
        win5_17_right1 <= 8'd0;
        win5_16_right1 <= 8'd0;
        win5_15_right1 <= 8'd0;
        win5_14_right1 <= 8'd0;
        win5_13_right1 <= 8'd0;
        win5_12_right1 <= 8'd0;
        win5_11_right1 <= 8'd0;       
        win5_10_right1 <= 8'd0;
        win5_9_right1 <= 8'd0;
        win5_8_right1 <= 8'd0;
        win5_7_right1 <= 8'd0;
        win5_6_right1 <= 8'd0;
        win5_5_right1 <= 8'd0;
        win5_4_right1 <= 8'd0;
        win5_3_right1 <= 8'd0;
        win5_2_right1 <= 8'd0;
        win5_1_right1 <= 8'd0;   
        win4_20_right1 <= 8'd0;
        win4_19_right1 <= 8'd0;
        win4_18_right1 <= 8'd0;
        win4_17_right1 <= 8'd0;
        win4_16_right1 <= 8'd0;
        win4_15_right1 <= 8'd0;
        win4_14_right1 <= 8'd0;
        win4_13_right1 <= 8'd0;
        win4_12_right1 <= 8'd0;
        win4_11_right1 <= 8'd0;       
        win4_10_right1 <= 8'd0;
        win4_9_right1 <= 8'd0;
        win4_8_right1 <= 8'd0;
        win4_7_right1 <= 8'd0;
        win4_6_right1 <= 8'd0;
        win4_5_right1 <= 8'd0;
        win4_4_right1 <= 8'd0;
        win4_3_right1 <= 8'd0;
        win4_2_right1 <= 8'd0;
        win4_1_right1 <= 8'd0;
        win3_20_right1 <= 8'd0;
        win3_19_right1 <= 8'd0;
        win3_18_right1 <= 8'd0;
        win3_17_right1 <= 8'd0;
        win3_16_right1 <= 8'd0;
        win3_15_right1 <= 8'd0;
        win3_14_right1 <= 8'd0;
        win3_13_right1 <= 8'd0;
        win3_12_right1 <= 8'd0;
        win3_11_right1 <= 8'd0;       
        win3_10_right1 <= 8'd0;
        win3_9_right1 <= 8'd0;
        win3_8_right1 <= 8'd0;
        win3_7_right1 <= 8'd0;
        win3_6_right1 <= 8'd0;
        win3_5_right1 <= 8'd0;
        win3_4_right1 <= 8'd0;
        win3_3_right1 <= 8'd0;
        win3_2_right1 <= 8'd0;
        win3_1_right1 <= 8'd0;
        win2_20_right1 <= 8'd0;
        win2_19_right1 <= 8'd0;
        win2_18_right1 <= 8'd0;
        win2_17_right1 <= 8'd0;
        win2_16_right1 <= 8'd0;
        win2_15_right1 <= 8'd0;
        win2_14_right1 <= 8'd0;
        win2_13_right1 <= 8'd0;
        win2_12_right1 <= 8'd0;
        win2_11_right1 <= 8'd0;       
        win2_10_right1 <= 8'd0;
        win2_9_right1 <= 8'd0;
        win2_8_right1 <= 8'd0;
        win2_7_right1 <= 8'd0;
        win2_6_right1 <= 8'd0;
        win2_5_right1 <= 8'd0;
        win2_4_right1 <= 8'd0;
        win2_3_right1 <= 8'd0;
        win2_2_right1 <= 8'd0;
        win2_1_right1 <= 8'd0;              
        win1_20_right1 <= 8'd0;
        win1_19_right1 <= 8'd0;
        win1_18_right1 <= 8'd0;
        win1_17_right1 <= 8'd0;
        win1_16_right1 <= 8'd0;
        win1_15_right1 <= 8'd0;
        win1_14_right1 <= 8'd0;
        win1_13_right1 <= 8'd0;
        win1_12_right1 <= 8'd0;
        win1_11_right1 <= 8'd0;       
        win1_10_right1 <= 8'd0;
        win1_9_right1 <= 8'd0;
        win1_8_right1 <= 8'd0;
        win1_7_right1 <= 8'd0;
        win1_6_right1 <= 8'd0;
        win1_5_right1 <= 8'd0;
        win1_4_right1 <= 8'd0;
        win1_3_right1 <= 8'd0;
        win1_2_right1 <= 8'd0;
        win1_1_right1 <= 8'd0; 
      end
    else if(en_right1==1)
      begin
        win11_20_right1 <= win11_21_right1;
        win11_19_right1 <= win11_20_right1;
        win11_18_right1 <= win11_19_right1;
        win11_17_right1 <= win11_18_right1;
        win11_16_right1 <= win11_17_right1;
        win11_15_right1 <= win11_16_right1;
        win11_14_right1 <= win11_15_right1;
        win11_13_right1 <= win11_14_right1;
        win11_12_right1 <= win11_13_right1;
        win11_11_right1 <= win11_12_right1;
        win11_10_right1 <= win11_11_right1;
        win11_9_right1 <= win11_10_right1;
        win11_8_right1 <= win11_9_right1;
        win11_7_right1 <= win11_8_right1;
        win11_6_right1 <= win11_7_right1;
        win11_5_right1 <= win11_6_right1;
        win11_4_right1 <= win11_5_right1;
        win11_3_right1 <= win11_4_right1;
        win11_2_right1 <= win11_3_right1;
        win11_1_right1 <= win11_2_right1;
        win10_20_right1 <= win10_21_right1;
        win10_19_right1 <= win10_20_right1;
        win10_18_right1 <= win10_19_right1;
        win10_17_right1 <= win10_18_right1;
        win10_16_right1 <= win10_17_right1;
        win10_15_right1 <= win10_16_right1;
        win10_14_right1 <= win10_15_right1;
        win10_13_right1 <= win10_14_right1;
        win10_12_right1 <= win10_13_right1;
        win10_11_right1 <= win10_12_right1;
        win10_10_right1 <= win10_11_right1;
        win10_9_right1 <= win10_10_right1;
        win10_8_right1 <= win10_9_right1;
        win10_7_right1 <= win10_8_right1;
        win10_6_right1 <= win10_7_right1;
        win10_5_right1 <= win10_6_right1;
        win10_4_right1 <= win10_5_right1;
        win10_3_right1 <= win10_4_right1;
        win10_2_right1 <= win10_3_right1;
        win10_1_right1 <= win10_2_right1;
        win9_20_right1 <= win9_21_right1;
        win9_19_right1 <= win9_20_right1;
        win9_18_right1 <= win9_19_right1;
        win9_17_right1 <= win9_18_right1;
        win9_16_right1 <= win9_17_right1;
        win9_15_right1 <= win9_16_right1;
        win9_14_right1 <= win9_15_right1;
        win9_13_right1 <= win9_14_right1;
        win9_12_right1 <= win9_13_right1;
        win9_11_right1 <= win9_12_right1;
        win9_10_right1 <= win9_11_right1;
        win9_9_right1 <= win9_10_right1;
        win9_8_right1 <= win9_9_right1;
        win9_7_right1 <= win9_8_right1;
        win9_6_right1 <= win9_7_right1;
        win9_5_right1 <= win9_6_right1;
        win9_4_right1 <= win9_5_right1;
        win9_3_right1 <= win9_4_right1;
        win9_2_right1 <= win9_3_right1;
        win9_1_right1 <= win9_2_right1;
        win8_20_right1 <= win8_21_right1;
        win8_19_right1 <= win8_20_right1;
        win8_18_right1 <= win8_19_right1;
        win8_17_right1 <= win8_18_right1;
        win8_16_right1 <= win8_17_right1;
        win8_15_right1 <= win8_16_right1;
        win8_14_right1 <= win8_15_right1;
        win8_13_right1 <= win8_14_right1;
        win8_12_right1 <= win8_13_right1;
        win8_11_right1 <= win8_12_right1;
        win8_10_right1 <= win8_11_right1;
        win8_9_right1 <= win8_10_right1;
        win8_8_right1 <= win8_9_right1;
        win8_7_right1 <= win8_8_right1;
        win8_6_right1 <= win8_7_right1;
        win8_5_right1 <= win8_6_right1;
        win8_4_right1 <= win8_5_right1;
        win8_3_right1 <= win8_4_right1;
        win8_2_right1 <= win8_3_right1;
        win8_1_right1 <= win8_2_right1;
        win7_20_right1 <= win7_21_right1;
        win7_19_right1 <= win7_20_right1;
        win7_18_right1 <= win7_19_right1;
        win7_17_right1 <= win7_18_right1;
        win7_16_right1 <= win7_17_right1;
        win7_15_right1 <= win7_16_right1;
        win7_14_right1 <= win7_15_right1;
        win7_13_right1 <= win7_14_right1;
        win7_12_right1 <= win7_13_right1;
        win7_11_right1 <= win7_12_right1;
        win7_10_right1 <= win7_11_right1;
        win7_9_right1 <= win7_10_right1;
        win7_8_right1 <= win7_9_right1;
        win7_7_right1 <= win7_8_right1;
        win7_6_right1 <= win7_7_right1;
        win7_5_right1 <= win7_6_right1;
        win7_4_right1 <= win7_5_right1;
        win7_3_right1 <= win7_4_right1;
        win7_2_right1 <= win7_3_right1;
        win7_1_right1 <= win7_2_right1;
        win6_20_right1 <= win6_21_right1;
        win6_19_right1 <= win6_20_right1;
        win6_18_right1 <= win6_19_right1;
        win6_17_right1 <= win6_18_right1;
        win6_16_right1 <= win6_17_right1;
        win6_15_right1 <= win6_16_right1;
        win6_14_right1 <= win6_15_right1;
        win6_13_right1 <= win6_14_right1;
        win6_12_right1 <= win6_13_right1;
        win6_11_right1 <= win6_12_right1;
        win6_10_right1 <= win6_11_right1;
        win6_9_right1 <= win6_10_right1;
        win6_8_right1 <= win6_9_right1;
        win6_7_right1 <= win6_8_right1;
        win6_6_right1 <= win6_7_right1;
        win6_5_right1 <= win6_6_right1;
        win6_4_right1 <= win6_5_right1;
        win6_3_right1 <= win6_4_right1;
        win6_2_right1 <= win6_3_right1;
        win6_1_right1 <= win6_2_right1;
        win5_20_right1 <= win5_21_right1;
        win5_19_right1 <= win5_20_right1;
        win5_18_right1 <= win5_19_right1;
        win5_17_right1 <= win5_18_right1;
        win5_16_right1 <= win5_17_right1;
        win5_15_right1 <= win5_16_right1;
        win5_14_right1 <= win5_15_right1;
        win5_13_right1 <= win5_14_right1;
        win5_12_right1 <= win5_13_right1;
        win5_11_right1 <= win5_12_right1;
        win5_10_right1 <= win5_11_right1;
        win5_9_right1 <= win5_10_right1;
        win5_8_right1 <= win5_9_right1;
        win5_7_right1 <= win5_8_right1;
        win5_6_right1 <= win5_7_right1;
        win5_5_right1 <= win5_6_right1;
        win5_4_right1 <= win5_5_right1;
        win5_3_right1 <= win5_4_right1;
        win5_2_right1 <= win5_3_right1;
        win5_1_right1 <= win5_2_right1;
        win4_20_right1 <= win4_21_right1;
        win4_19_right1 <= win4_20_right1;
        win4_18_right1 <= win4_19_right1;
        win4_17_right1 <= win4_18_right1;
        win4_16_right1 <= win4_17_right1;
        win4_15_right1 <= win4_16_right1;
        win4_14_right1 <= win4_15_right1;
        win4_13_right1 <= win4_14_right1;
        win4_12_right1 <= win4_13_right1;
        win4_11_right1 <= win4_12_right1;
        win4_10_right1 <= win4_11_right1;
        win4_9_right1 <= win4_10_right1;
        win4_8_right1 <= win4_9_right1;
        win4_7_right1 <= win4_8_right1;
        win4_6_right1 <= win4_7_right1;
        win4_5_right1 <= win4_6_right1;
        win4_4_right1 <= win4_5_right1;
        win4_3_right1 <= win4_4_right1;
        win4_2_right1 <= win4_3_right1;
        win4_1_right1 <= win4_2_right1;
        win3_20_right1 <= win3_21_right1;
        win3_19_right1 <= win3_20_right1;
        win3_18_right1 <= win3_19_right1;
        win3_17_right1 <= win3_18_right1;
        win3_16_right1 <= win3_17_right1;
        win3_15_right1 <= win3_16_right1;
        win3_14_right1 <= win3_15_right1;
        win3_13_right1 <= win3_14_right1;
        win3_12_right1 <= win3_13_right1;
        win3_11_right1 <= win3_12_right1;
        win3_10_right1 <= win3_11_right1;
        win3_9_right1 <= win3_10_right1;
        win3_8_right1 <= win3_9_right1;
        win3_7_right1 <= win3_8_right1;
        win3_6_right1 <= win3_7_right1;
        win3_5_right1 <= win3_6_right1;
        win3_4_right1 <= win3_5_right1;
        win3_3_right1 <= win3_4_right1;
        win3_2_right1 <= win3_3_right1;
        win3_1_right1 <= win3_2_right1;
        win2_20_right1 <= win2_21_right1;
        win2_19_right1 <= win2_20_right1;
        win2_18_right1 <= win2_19_right1;
        win2_17_right1 <= win2_18_right1;
        win2_16_right1 <= win2_17_right1;
        win2_15_right1 <= win2_16_right1;
        win2_14_right1 <= win2_15_right1;
        win2_13_right1 <= win2_14_right1;
        win2_12_right1 <= win2_13_right1;
        win2_11_right1 <= win2_12_right1;
        win2_10_right1 <= win2_11_right1;
        win2_9_right1 <= win2_10_right1;
        win2_8_right1 <= win2_9_right1;
        win2_7_right1 <= win2_8_right1;
        win2_6_right1 <= win2_7_right1;
        win2_5_right1 <= win2_6_right1;
        win2_4_right1 <= win2_5_right1;
        win2_3_right1 <= win2_4_right1;
        win2_2_right1 <= win2_3_right1;
        win2_1_right1 <= win2_2_right1;
        win1_20_right1 <= win1_21_right1;
        win1_19_right1 <= win1_20_right1;
        win1_18_right1 <= win1_19_right1;
        win1_17_right1 <= win1_18_right1;
        win1_16_right1 <= win1_17_right1;
        win1_15_right1 <= win1_16_right1;
        win1_14_right1 <= win1_15_right1;
        win1_13_right1 <= win1_14_right1;
        win1_12_right1 <= win1_13_right1;
        win1_11_right1 <= win1_12_right1;
        win1_10_right1 <= win1_11_right1;
        win1_9_right1 <= win1_10_right1;
        win1_8_right1 <= win1_9_right1;
        win1_7_right1 <= win1_8_right1;
        win1_6_right1 <= win1_7_right1;
        win1_5_right1 <= win1_6_right1;
        win1_4_right1 <= win1_5_right1;
        win1_3_right1 <= win1_4_right1;
        win1_2_right1 <= win1_3_right1;
        win1_1_right1 <= win1_2_right1;
      end
  end      
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_11_left2 <= 8'd0;
        win10_11_left2 <= 8'd0;
        win9_11_left2 <= 8'd0;
        win8_11_left2 <= 8'd0;
        win7_11_left2 <= 8'd0;
        win6_11_left2 <= 8'd0;
        win5_11_left2 <= 8'd0;
        win4_11_left2 <= 8'd0;
        win3_11_left2 <= 8'd0;
        win2_11_left2 <= 8'd0;
        win1_11_left2 <= 8'd0;
      end
    else if(en_left2==1 && addr_b_data_left2>=14275)
      begin
        win11_11_left2 <= taps0_left2;
        win10_11_left2 <= taps1_left2;
        win9_11_left2 <= taps2_left2;
        win8_11_left2 <= taps3_left2;
        win7_11_left2 <= taps4_left2;
        win6_11_left2 <= taps5_left2;
        win5_11_left2 <= taps6_left2;
        win4_11_left2 <= taps7_left2;
        win3_11_left2 <= taps8_left2;
        win2_11_left2 <= taps9_left2;
        win1_11_left2 <= taps10_left2;
      end
  end   
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_10_left2 <= 8'd0;
        win11_9_left2 <= 8'd0;
        win11_8_left2 <= 8'd0;
        win11_7_left2 <= 8'd0;
        win11_6_left2 <= 8'd0;
        win11_5_left2 <= 8'd0;
        win11_4_left2 <= 8'd0;
        win11_3_left2 <= 8'd0;
        win11_2_left2 <= 8'd0;
        win11_1_left2 <= 8'd0;
        win10_10_left2 <= 8'd0;
        win10_9_left2 <= 8'd0;
        win10_8_left2 <= 8'd0;
        win10_7_left2 <= 8'd0;
        win10_6_left2 <= 8'd0;
        win10_5_left2 <= 8'd0;
        win10_4_left2 <= 8'd0;
        win10_3_left2 <= 8'd0;
        win10_2_left2 <= 8'd0;
        win10_1_left2 <= 8'd0;
        win9_10_left2 <= 8'd0;
        win9_9_left2 <= 8'd0;
        win9_8_left2 <= 8'd0;
        win9_7_left2 <= 8'd0;
        win9_6_left2 <= 8'd0;
        win9_5_left2 <= 8'd0;
        win9_4_left2 <= 8'd0;
        win9_3_left2 <= 8'd0;
        win9_2_left2 <= 8'd0;
        win9_1_left2 <= 8'd0;
        win8_10_left2 <= 8'd0;
        win8_9_left2 <= 8'd0;
        win8_8_left2 <= 8'd0;
        win8_7_left2 <= 8'd0;
        win8_6_left2 <= 8'd0;
        win8_5_left2 <= 8'd0;
        win8_4_left2 <= 8'd0;
        win8_3_left2 <= 8'd0;
        win8_2_left2 <= 8'd0;
        win8_1_left2 <= 8'd0;
        win7_10_left2 <= 8'd0;
        win7_9_left2 <= 8'd0;
        win7_8_left2 <= 8'd0;
        win7_7_left2 <= 8'd0;
        win7_6_left2 <= 8'd0;
        win7_5_left2 <= 8'd0;
        win7_4_left2 <= 8'd0;
        win7_3_left2 <= 8'd0;
        win7_2_left2 <= 8'd0;
        win7_1_left2 <= 8'd0;
        win6_10_left2 <= 8'd0;
        win6_9_left2 <= 8'd0;
        win6_8_left2 <= 8'd0;
        win6_7_left2 <= 8'd0;
        win6_6_left2 <= 8'd0;
        win6_5_left2 <= 8'd0;
        win6_4_left2 <= 8'd0;
        win6_3_left2 <= 8'd0;
        win6_2_left2 <= 8'd0;
        win6_1_left2 <= 8'd0;
        win5_10_left2 <= 8'd0;
        win5_9_left2 <= 8'd0;
        win5_8_left2 <= 8'd0;
        win5_7_left2 <= 8'd0;
        win5_6_left2 <= 8'd0;
        win5_5_left2 <= 8'd0;
        win5_4_left2 <= 8'd0;
        win5_3_left2 <= 8'd0;
        win5_2_left2 <= 8'd0;
        win5_1_left2 <= 8'd0;   
        win4_10_left2 <= 8'd0;
        win4_9_left2 <= 8'd0;
        win4_8_left2 <= 8'd0;
        win4_7_left2 <= 8'd0;
        win4_6_left2 <= 8'd0;
        win4_5_left2 <= 8'd0;
        win4_4_left2 <= 8'd0;
        win4_3_left2 <= 8'd0;
        win4_2_left2 <= 8'd0;
        win4_1_left2 <= 8'd0;
        win3_10_left2 <= 8'd0;
        win3_9_left2 <= 8'd0;
        win3_8_left2 <= 8'd0;
        win3_7_left2 <= 8'd0;
        win3_6_left2 <= 8'd0;
        win3_5_left2 <= 8'd0;
        win3_4_left2 <= 8'd0;
        win3_3_left2 <= 8'd0;
        win3_2_left2 <= 8'd0;
        win3_1_left2 <= 8'd0;
        win2_10_left2 <= 8'd0;
        win2_9_left2 <= 8'd0;
        win2_8_left2 <= 8'd0;
        win2_7_left2 <= 8'd0;
        win2_6_left2 <= 8'd0;
        win2_5_left2 <= 8'd0;
        win2_4_left2 <= 8'd0;
        win2_3_left2 <= 8'd0;
        win2_2_left2 <= 8'd0;
        win2_1_left2 <= 8'd0;              
        win1_10_left2 <= 8'd0;
        win1_9_left2 <= 8'd0;
        win1_8_left2 <= 8'd0;
        win1_7_left2 <= 8'd0;
        win1_6_left2 <= 8'd0;
        win1_5_left2 <= 8'd0;
        win1_4_left2 <= 8'd0;
        win1_3_left2 <= 8'd0;
        win1_2_left2 <= 8'd0;
        win1_1_left2 <= 8'd0; 
      end
    else if(en_left2==1)
      begin
        win11_10_left2 <= win11_11_left2;
        win11_9_left2 <= win11_10_left2;
        win11_8_left2 <= win11_9_left2;
        win11_7_left2 <= win11_8_left2;
        win11_6_left2 <= win11_7_left2;
        win11_5_left2 <= win11_6_left2;
        win11_4_left2 <= win11_5_left2;
        win11_3_left2 <= win11_4_left2;
        win11_2_left2 <= win11_3_left2;
        win11_1_left2 <= win11_2_left2;
        win10_10_left2 <= win10_11_left2;
        win10_9_left2 <= win10_10_left2;
        win10_8_left2 <= win10_9_left2;
        win10_7_left2 <= win10_8_left2;
        win10_6_left2 <= win10_7_left2;
        win10_5_left2 <= win10_6_left2;
        win10_4_left2 <= win10_5_left2;
        win10_3_left2 <= win10_4_left2;
        win10_2_left2 <= win10_3_left2;
        win10_1_left2 <= win10_2_left2;
        win9_10_left2 <= win9_11_left2;
        win9_9_left2 <= win9_10_left2;
        win9_8_left2 <= win9_9_left2;
        win9_7_left2 <= win9_8_left2;
        win9_6_left2 <= win9_7_left2;
        win9_5_left2 <= win9_6_left2;
        win9_4_left2 <= win9_5_left2;
        win9_3_left2 <= win9_4_left2;
        win9_2_left2 <= win9_3_left2;
        win9_1_left2 <= win9_2_left2;
        win8_10_left2 <= win8_11_left2;
        win8_9_left2 <= win8_10_left2;
        win8_8_left2 <= win8_9_left2;
        win8_7_left2 <= win8_8_left2;
        win8_6_left2 <= win8_7_left2;
        win8_5_left2 <= win8_6_left2;
        win8_4_left2 <= win8_5_left2;
        win8_3_left2 <= win8_4_left2;
        win8_2_left2 <= win8_3_left2;
        win8_1_left2 <= win8_2_left2;
        win7_10_left2 <= win7_11_left2;
        win7_9_left2 <= win7_10_left2;
        win7_8_left2 <= win7_9_left2;
        win7_7_left2 <= win7_8_left2;
        win7_6_left2 <= win7_7_left2;
        win7_5_left2 <= win7_6_left2;
        win7_4_left2 <= win7_5_left2;
        win7_3_left2 <= win7_4_left2;
        win7_2_left2 <= win7_3_left2;
        win7_1_left2 <= win7_2_left2;
        win6_10_left2 <= win6_11_left2;
        win6_9_left2 <= win6_10_left2;
        win6_8_left2 <= win6_9_left2;
        win6_7_left2 <= win6_8_left2;
        win6_6_left2 <= win6_7_left2;
        win6_5_left2 <= win6_6_left2;
        win6_4_left2 <= win6_5_left2;
        win6_3_left2 <= win6_4_left2;
        win6_2_left2 <= win6_3_left2;
        win6_1_left2 <= win6_2_left2;
        win5_10_left2 <= win5_11_left2;
        win5_9_left2 <= win5_10_left2;
        win5_8_left2 <= win5_9_left2;
        win5_7_left2 <= win5_8_left2;
        win5_6_left2 <= win5_7_left2;
        win5_5_left2 <= win5_6_left2;
        win5_4_left2 <= win5_5_left2;
        win5_3_left2 <= win5_4_left2;
        win5_2_left2 <= win5_3_left2;
        win5_1_left2 <= win5_2_left2;
        win4_10_left2 <= win4_11_left2;
        win4_9_left2 <= win4_10_left2;
        win4_8_left2 <= win4_9_left2;
        win4_7_left2 <= win4_8_left2;
        win4_6_left2 <= win4_7_left2;
        win4_5_left2 <= win4_6_left2;
        win4_4_left2 <= win4_5_left2;
        win4_3_left2 <= win4_4_left2;
        win4_2_left2 <= win4_3_left2;
        win4_1_left2 <= win4_2_left2;
        win3_10_left2 <= win3_11_left2;
        win3_9_left2 <= win3_10_left2;
        win3_8_left2 <= win3_9_left2;
        win3_7_left2 <= win3_8_left2;
        win3_6_left2 <= win3_7_left2;
        win3_5_left2 <= win3_6_left2;
        win3_4_left2 <= win3_5_left2;
        win3_3_left2 <= win3_4_left2;
        win3_2_left2 <= win3_3_left2;
        win3_1_left2 <= win3_2_left2;
        win2_10_left2 <= win2_11_left2;
        win2_9_left2 <= win2_10_left2;
        win2_8_left2 <= win2_9_left2;
        win2_7_left2 <= win2_8_left2;
        win2_6_left2 <= win2_7_left2;
        win2_5_left2 <= win2_6_left2;
        win2_4_left2 <= win2_5_left2;
        win2_3_left2 <= win2_4_left2;
        win2_2_left2 <= win2_3_left2;
        win2_1_left2 <= win2_2_left2;
        win1_10_left2 <= win1_11_left2;
        win1_9_left2 <= win1_10_left2;
        win1_8_left2 <= win1_9_left2;
        win1_7_left2 <= win1_8_left2;
        win1_6_left2 <= win1_7_left2;
        win1_5_left2 <= win1_6_left2;
        win1_4_left2 <= win1_5_left2;
        win1_3_left2 <= win1_4_left2;
        win1_2_left2 <= win1_3_left2;
        win1_1_left2 <= win1_2_left2;
      end
  end  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_21_right2 <= 8'd0;
        win10_21_right2 <= 8'd0;
        win9_21_right2 <= 8'd0;
        win8_21_right2 <= 8'd0;
        win7_21_right2 <= 8'd0;
        win6_21_right2 <= 8'd0;
        win5_21_right2 <= 8'd0;
        win4_21_right2 <= 8'd0;
        win3_21_right2 <= 8'd0;
        win2_21_right2 <= 8'd0;
        win1_21_right2 <= 8'd0;
      end
    else if(en_right2==1 && addr_b_data_right2>=16950)
      begin
        win11_21_right2 <= taps0_right2;
        win10_21_right2 <= taps1_right2;
        win9_21_right2 <= taps2_right2;
        win8_21_right2 <= taps3_right2;
        win7_21_right2 <= taps4_right2;
        win6_21_right2 <= taps5_right2;
        win5_21_right2 <= taps6_right2;
        win4_21_right2 <= taps7_right2;
        win3_21_right2 <= taps8_right2;
        win2_21_right2 <= taps9_right2;
        win1_21_right2 <= taps10_right2;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        win11_20_right2 <= 8'd0;
        win11_19_right2 <= 8'd0;
        win11_18_right2 <= 8'd0;
        win11_17_right2 <= 8'd0;
        win11_16_right2 <= 8'd0;
        win11_15_right2 <= 8'd0;
        win11_14_right2 <= 8'd0;
        win11_13_right2 <= 8'd0;
        win11_12_right2 <= 8'd0;
        win11_11_right2 <= 8'd0;       
        win11_10_right2 <= 8'd0;
        win11_9_right2 <= 8'd0;
        win11_8_right2 <= 8'd0;
        win11_7_right2 <= 8'd0;
        win11_6_right2 <= 8'd0;
        win11_5_right2 <= 8'd0;
        win11_4_right2 <= 8'd0;
        win11_3_right2 <= 8'd0;
        win11_2_right2 <= 8'd0;
        win11_1_right2 <= 8'd0;
        win10_20_right2 <= 8'd0;
        win10_19_right2 <= 8'd0;
        win10_18_right2 <= 8'd0;
        win10_17_right2 <= 8'd0;
        win10_16_right2 <= 8'd0;
        win10_15_right2 <= 8'd0;
        win10_14_right2 <= 8'd0;
        win10_13_right2 <= 8'd0;
        win10_12_right2 <= 8'd0;
        win10_11_right2 <= 8'd0;       
        win10_10_right2 <= 8'd0;
        win10_9_right2 <= 8'd0;
        win10_8_right2 <= 8'd0;
        win10_7_right2 <= 8'd0;
        win10_6_right2 <= 8'd0;
        win10_5_right2 <= 8'd0;
        win10_4_right2 <= 8'd0;
        win10_3_right2 <= 8'd0;
        win10_2_right2 <= 8'd0;
        win10_1_right2 <= 8'd0;
        win9_20_right2 <= 8'd0;
        win9_19_right2 <= 8'd0;
        win9_18_right2 <= 8'd0;
        win9_17_right2 <= 8'd0;
        win9_16_right2 <= 8'd0;
        win9_15_right2 <= 8'd0;
        win9_14_right2 <= 8'd0;
        win9_13_right2 <= 8'd0;
        win9_12_right2 <= 8'd0;
        win9_11_right2 <= 8'd0;       
        win9_10_right2 <= 8'd0;
        win9_9_right2 <= 8'd0;
        win9_8_right2 <= 8'd0;
        win9_7_right2 <= 8'd0;
        win9_6_right2 <= 8'd0;
        win9_5_right2 <= 8'd0;
        win9_4_right2 <= 8'd0;
        win9_3_right2 <= 8'd0;
        win9_2_right2 <= 8'd0;
        win9_1_right2 <= 8'd0;
        win8_20_right2 <= 8'd0;
        win8_19_right2 <= 8'd0;
        win8_18_right2 <= 8'd0;
        win8_17_right2 <= 8'd0;
        win8_16_right2 <= 8'd0;
        win8_15_right2 <= 8'd0;
        win8_14_right2 <= 8'd0;
        win8_13_right2 <= 8'd0;
        win8_12_right2 <= 8'd0;
        win8_11_right2 <= 8'd0;       
        win8_10_right2 <= 8'd0;
        win8_9_right2 <= 8'd0;
        win8_8_right2 <= 8'd0;
        win8_7_right2 <= 8'd0;
        win8_6_right2 <= 8'd0;
        win8_5_right2 <= 8'd0;
        win8_4_right2 <= 8'd0;
        win8_3_right2 <= 8'd0;
        win8_2_right2 <= 8'd0;
        win8_1_right2 <= 8'd0;
        win7_20_right2 <= 8'd0;
        win7_19_right2 <= 8'd0;
        win7_18_right2 <= 8'd0;
        win7_17_right2 <= 8'd0;
        win7_16_right2 <= 8'd0;
        win7_15_right2 <= 8'd0;
        win7_14_right2 <= 8'd0;
        win7_13_right2 <= 8'd0;
        win7_12_right2 <= 8'd0;
        win7_11_right2 <= 8'd0;       
        win7_10_right2 <= 8'd0;
        win7_9_right2 <= 8'd0;
        win7_8_right2 <= 8'd0;
        win7_7_right2 <= 8'd0;
        win7_6_right2 <= 8'd0;
        win7_5_right2 <= 8'd0;
        win7_4_right2 <= 8'd0;
        win7_3_right2 <= 8'd0;
        win7_2_right2 <= 8'd0;
        win7_1_right2 <= 8'd0;
        win6_20_right2 <= 8'd0;
        win6_19_right2 <= 8'd0;
        win6_18_right2 <= 8'd0;
        win6_17_right2 <= 8'd0;
        win6_16_right2 <= 8'd0;
        win6_15_right2 <= 8'd0;
        win6_14_right2 <= 8'd0;
        win6_13_right2 <= 8'd0;
        win6_12_right2 <= 8'd0;
        win6_11_right2 <= 8'd0;       
        win6_10_right2 <= 8'd0;
        win6_9_right2 <= 8'd0;
        win6_8_right2 <= 8'd0;
        win6_7_right2 <= 8'd0;
        win6_6_right2 <= 8'd0;
        win6_5_right2 <= 8'd0;
        win6_4_right2 <= 8'd0;
        win6_3_right2 <= 8'd0;
        win6_2_right2 <= 8'd0;
        win6_1_right2 <= 8'd0;
        win5_20_right2 <= 8'd0;
        win5_19_right2 <= 8'd0;
        win5_18_right2 <= 8'd0;
        win5_17_right2 <= 8'd0;
        win5_16_right2 <= 8'd0;
        win5_15_right2 <= 8'd0;
        win5_14_right2 <= 8'd0;
        win5_13_right2 <= 8'd0;
        win5_12_right2 <= 8'd0;
        win5_11_right2 <= 8'd0;       
        win5_10_right2 <= 8'd0;
        win5_9_right2 <= 8'd0;
        win5_8_right2 <= 8'd0;
        win5_7_right2 <= 8'd0;
        win5_6_right2 <= 8'd0;
        win5_5_right2 <= 8'd0;
        win5_4_right2 <= 8'd0;
        win5_3_right2 <= 8'd0;
        win5_2_right2 <= 8'd0;
        win5_1_right2 <= 8'd0;   
        win4_20_right2 <= 8'd0;
        win4_19_right2 <= 8'd0;
        win4_18_right2 <= 8'd0;
        win4_17_right2 <= 8'd0;
        win4_16_right2 <= 8'd0;
        win4_15_right2 <= 8'd0;
        win4_14_right2 <= 8'd0;
        win4_13_right2 <= 8'd0;
        win4_12_right2 <= 8'd0;
        win4_11_right2 <= 8'd0;       
        win4_10_right2 <= 8'd0;
        win4_9_right2 <= 8'd0;
        win4_8_right2 <= 8'd0;
        win4_7_right2 <= 8'd0;
        win4_6_right2 <= 8'd0;
        win4_5_right2 <= 8'd0;
        win4_4_right2 <= 8'd0;
        win4_3_right2 <= 8'd0;
        win4_2_right2 <= 8'd0;
        win4_1_right2 <= 8'd0;
        win3_20_right2 <= 8'd0;
        win3_19_right2 <= 8'd0;
        win3_18_right2 <= 8'd0;
        win3_17_right2 <= 8'd0;
        win3_16_right2 <= 8'd0;
        win3_15_right2 <= 8'd0;
        win3_14_right2 <= 8'd0;
        win3_13_right2 <= 8'd0;
        win3_12_right2 <= 8'd0;
        win3_11_right2 <= 8'd0;       
        win3_10_right2 <= 8'd0;
        win3_9_right2 <= 8'd0;
        win3_8_right2 <= 8'd0;
        win3_7_right2 <= 8'd0;
        win3_6_right2 <= 8'd0;
        win3_5_right2 <= 8'd0;
        win3_4_right2 <= 8'd0;
        win3_3_right2 <= 8'd0;
        win3_2_right2 <= 8'd0;
        win3_1_right2 <= 8'd0;
        win2_20_right2 <= 8'd0;
        win2_19_right2 <= 8'd0;
        win2_18_right2 <= 8'd0;
        win2_17_right2 <= 8'd0;
        win2_16_right2 <= 8'd0;
        win2_15_right2 <= 8'd0;
        win2_14_right2 <= 8'd0;
        win2_13_right2 <= 8'd0;
        win2_12_right2 <= 8'd0;
        win2_11_right2 <= 8'd0;       
        win2_10_right2 <= 8'd0;
        win2_9_right2 <= 8'd0;
        win2_8_right2 <= 8'd0;
        win2_7_right2 <= 8'd0;
        win2_6_right2 <= 8'd0;
        win2_5_right2 <= 8'd0;
        win2_4_right2 <= 8'd0;
        win2_3_right2 <= 8'd0;
        win2_2_right2 <= 8'd0;
        win2_1_right2 <= 8'd0;              
        win1_20_right2 <= 8'd0;
        win1_19_right2 <= 8'd0;
        win1_18_right2 <= 8'd0;
        win1_17_right2 <= 8'd0;
        win1_16_right2 <= 8'd0;
        win1_15_right2 <= 8'd0;
        win1_14_right2 <= 8'd0;
        win1_13_right2 <= 8'd0;
        win1_12_right2 <= 8'd0;
        win1_11_right2 <= 8'd0;       
        win1_10_right2 <= 8'd0;
        win1_9_right2 <= 8'd0;
        win1_8_right2 <= 8'd0;
        win1_7_right2 <= 8'd0;
        win1_6_right2 <= 8'd0;
        win1_5_right2 <= 8'd0;
        win1_4_right2 <= 8'd0;
        win1_3_right2 <= 8'd0;
        win1_2_right2 <= 8'd0;
        win1_1_right2 <= 8'd0; 
      end
    else if(en_right2==1)
      begin
        win11_20_right2 <= win11_21_right2;
        win11_19_right2 <= win11_20_right2;
        win11_18_right2 <= win11_19_right2;
        win11_17_right2 <= win11_18_right2;
        win11_16_right2 <= win11_17_right2;
        win11_15_right2 <= win11_16_right2;
        win11_14_right2 <= win11_15_right2;
        win11_13_right2 <= win11_14_right2;
        win11_12_right2 <= win11_13_right2;
        win11_11_right2 <= win11_12_right2;
        win11_10_right2 <= win11_11_right2;
        win11_9_right2 <= win11_10_right2;
        win11_8_right2 <= win11_9_right2;
        win11_7_right2 <= win11_8_right2;
        win11_6_right2 <= win11_7_right2;
        win11_5_right2 <= win11_6_right2;
        win11_4_right2 <= win11_5_right2;
        win11_3_right2 <= win11_4_right2;
        win11_2_right2 <= win11_3_right2;
        win11_1_right2 <= win11_2_right2;
        win10_20_right2 <= win10_21_right2;
        win10_19_right2 <= win10_20_right2;
        win10_18_right2 <= win10_19_right2;
        win10_17_right2 <= win10_18_right2;
        win10_16_right2 <= win10_17_right2;
        win10_15_right2 <= win10_16_right2;
        win10_14_right2 <= win10_15_right2;
        win10_13_right2 <= win10_14_right2;
        win10_12_right2 <= win10_13_right2;
        win10_11_right2 <= win10_12_right2;
        win10_10_right2 <= win10_11_right2;
        win10_9_right2 <= win10_10_right2;
        win10_8_right2 <= win10_9_right2;
        win10_7_right2 <= win10_8_right2;
        win10_6_right2 <= win10_7_right2;
        win10_5_right2 <= win10_6_right2;
        win10_4_right2 <= win10_5_right2;
        win10_3_right2 <= win10_4_right2;
        win10_2_right2 <= win10_3_right2;
        win10_1_right2 <= win10_2_right2;
        win9_20_right2 <= win9_21_right2;
        win9_19_right2 <= win9_20_right2;
        win9_18_right2 <= win9_19_right2;
        win9_17_right2 <= win9_18_right2;
        win9_16_right2 <= win9_17_right2;
        win9_15_right2 <= win9_16_right2;
        win9_14_right2 <= win9_15_right2;
        win9_13_right2 <= win9_14_right2;
        win9_12_right2 <= win9_13_right2;
        win9_11_right2 <= win9_12_right2;
        win9_10_right2 <= win9_11_right2;
        win9_9_right2 <= win9_10_right2;
        win9_8_right2 <= win9_9_right2;
        win9_7_right2 <= win9_8_right2;
        win9_6_right2 <= win9_7_right2;
        win9_5_right2 <= win9_6_right2;
        win9_4_right2 <= win9_5_right2;
        win9_3_right2 <= win9_4_right2;
        win9_2_right2 <= win9_3_right2;
        win9_1_right2 <= win9_2_right2;
        win8_20_right2 <= win8_21_right2;
        win8_19_right2 <= win8_20_right2;
        win8_18_right2 <= win8_19_right2;
        win8_17_right2 <= win8_18_right2;
        win8_16_right2 <= win8_17_right2;
        win8_15_right2 <= win8_16_right2;
        win8_14_right2 <= win8_15_right2;
        win8_13_right2 <= win8_14_right2;
        win8_12_right2 <= win8_13_right2;
        win8_11_right2 <= win8_12_right2;
        win8_10_right2 <= win8_11_right2;
        win8_9_right2 <= win8_10_right2;
        win8_8_right2 <= win8_9_right2;
        win8_7_right2 <= win8_8_right2;
        win8_6_right2 <= win8_7_right2;
        win8_5_right2 <= win8_6_right2;
        win8_4_right2 <= win8_5_right2;
        win8_3_right2 <= win8_4_right2;
        win8_2_right2 <= win8_3_right2;
        win8_1_right2 <= win8_2_right2;
        win7_20_right2 <= win7_21_right2;
        win7_19_right2 <= win7_20_right2;
        win7_18_right2 <= win7_19_right2;
        win7_17_right2 <= win7_18_right2;
        win7_16_right2 <= win7_17_right2;
        win7_15_right2 <= win7_16_right2;
        win7_14_right2 <= win7_15_right2;
        win7_13_right2 <= win7_14_right2;
        win7_12_right2 <= win7_13_right2;
        win7_11_right2 <= win7_12_right2;
        win7_10_right2 <= win7_11_right2;
        win7_9_right2 <= win7_10_right2;
        win7_8_right2 <= win7_9_right2;
        win7_7_right2 <= win7_8_right2;
        win7_6_right2 <= win7_7_right2;
        win7_5_right2 <= win7_6_right2;
        win7_4_right2 <= win7_5_right2;
        win7_3_right2 <= win7_4_right2;
        win7_2_right2 <= win7_3_right2;
        win7_1_right2 <= win7_2_right2;
        win6_20_right2 <= win6_21_right2;
        win6_19_right2 <= win6_20_right2;
        win6_18_right2 <= win6_19_right2;
        win6_17_right2 <= win6_18_right2;
        win6_16_right2 <= win6_17_right2;
        win6_15_right2 <= win6_16_right2;
        win6_14_right2 <= win6_15_right2;
        win6_13_right2 <= win6_14_right2;
        win6_12_right2 <= win6_13_right2;
        win6_11_right2 <= win6_12_right2;
        win6_10_right2 <= win6_11_right2;
        win6_9_right2 <= win6_10_right2;
        win6_8_right2 <= win6_9_right2;
        win6_7_right2 <= win6_8_right2;
        win6_6_right2 <= win6_7_right2;
        win6_5_right2 <= win6_6_right2;
        win6_4_right2 <= win6_5_right2;
        win6_3_right2 <= win6_4_right2;
        win6_2_right2 <= win6_3_right2;
        win6_1_right2 <= win6_2_right2;
        win5_20_right2 <= win5_21_right2;
        win5_19_right2 <= win5_20_right2;
        win5_18_right2 <= win5_19_right2;
        win5_17_right2 <= win5_18_right2;
        win5_16_right2 <= win5_17_right2;
        win5_15_right2 <= win5_16_right2;
        win5_14_right2 <= win5_15_right2;
        win5_13_right2 <= win5_14_right2;
        win5_12_right2 <= win5_13_right2;
        win5_11_right2 <= win5_12_right2;
        win5_10_right2 <= win5_11_right2;
        win5_9_right2 <= win5_10_right2;
        win5_8_right2 <= win5_9_right2;
        win5_7_right2 <= win5_8_right2;
        win5_6_right2 <= win5_7_right2;
        win5_5_right2 <= win5_6_right2;
        win5_4_right2 <= win5_5_right2;
        win5_3_right2 <= win5_4_right2;
        win5_2_right2 <= win5_3_right2;
        win5_1_right2 <= win5_2_right2;
        win4_20_right2 <= win4_21_right2;
        win4_19_right2 <= win4_20_right2;
        win4_18_right2 <= win4_19_right2;
        win4_17_right2 <= win4_18_right2;
        win4_16_right2 <= win4_17_right2;
        win4_15_right2 <= win4_16_right2;
        win4_14_right2 <= win4_15_right2;
        win4_13_right2 <= win4_14_right2;
        win4_12_right2 <= win4_13_right2;
        win4_11_right2 <= win4_12_right2;
        win4_10_right2 <= win4_11_right2;
        win4_9_right2 <= win4_10_right2;
        win4_8_right2 <= win4_9_right2;
        win4_7_right2 <= win4_8_right2;
        win4_6_right2 <= win4_7_right2;
        win4_5_right2 <= win4_6_right2;
        win4_4_right2 <= win4_5_right2;
        win4_3_right2 <= win4_4_right2;
        win4_2_right2 <= win4_3_right2;
        win4_1_right2 <= win4_2_right2;
        win3_20_right2 <= win3_21_right2;
        win3_19_right2 <= win3_20_right2;
        win3_18_right2 <= win3_19_right2;
        win3_17_right2 <= win3_18_right2;
        win3_16_right2 <= win3_17_right2;
        win3_15_right2 <= win3_16_right2;
        win3_14_right2 <= win3_15_right2;
        win3_13_right2 <= win3_14_right2;
        win3_12_right2 <= win3_13_right2;
        win3_11_right2 <= win3_12_right2;
        win3_10_right2 <= win3_11_right2;
        win3_9_right2 <= win3_10_right2;
        win3_8_right2 <= win3_9_right2;
        win3_7_right2 <= win3_8_right2;
        win3_6_right2 <= win3_7_right2;
        win3_5_right2 <= win3_6_right2;
        win3_4_right2 <= win3_5_right2;
        win3_3_right2 <= win3_4_right2;
        win3_2_right2 <= win3_3_right2;
        win3_1_right2 <= win3_2_right2;
        win2_20_right2 <= win2_21_right2;
        win2_19_right2 <= win2_20_right2;
        win2_18_right2 <= win2_19_right2;
        win2_17_right2 <= win2_18_right2;
        win2_16_right2 <= win2_17_right2;
        win2_15_right2 <= win2_16_right2;
        win2_14_right2 <= win2_15_right2;
        win2_13_right2 <= win2_14_right2;
        win2_12_right2 <= win2_13_right2;
        win2_11_right2 <= win2_12_right2;
        win2_10_right2 <= win2_11_right2;
        win2_9_right2 <= win2_10_right2;
        win2_8_right2 <= win2_9_right2;
        win2_7_right2 <= win2_8_right2;
        win2_6_right2 <= win2_7_right2;
        win2_5_right2 <= win2_6_right2;
        win2_4_right2 <= win2_5_right2;
        win2_3_right2 <= win2_4_right2;
        win2_2_right2 <= win2_3_right2;
        win2_1_right2 <= win2_2_right2;
        win1_20_right2 <= win1_21_right2;
        win1_19_right2 <= win1_20_right2;
        win1_18_right2 <= win1_19_right2;
        win1_17_right2 <= win1_18_right2;
        win1_16_right2 <= win1_17_right2;
        win1_15_right2 <= win1_16_right2;
        win1_14_right2 <= win1_15_right2;
        win1_13_right2 <= win1_14_right2;
        win1_12_right2 <= win1_13_right2;
        win1_11_right2 <= win1_12_right2;
        win1_10_right2 <= win1_11_right2;
        win1_9_right2 <= win1_10_right2;
        win1_8_right2 <= win1_9_right2;
        win1_7_right2 <= win1_8_right2;
        win1_6_right2 <= win1_7_right2;
        win1_5_right2 <= win1_6_right2;
        win1_4_right2 <= win1_5_right2;
        win1_3_right2 <= win1_4_right2;
        win1_2_right2 <= win1_3_right2;
        win1_1_right2 <= win1_2_right2;
      end
  end        
        
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      num <= 3'd0;
    else if(start==1)
      num <= 3'd0;
    else if(num<4)
      num <= num + 1'b1;
    else if(num==4)
      num <= 3'd0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      flag_midterm <= 1'b0;
    else if(start==1)
      flag_midterm <= 1'b0;
    else if(num==4)
      flag_midterm <= 1'b1;
  end

//  always@(posedge clk or negedge rst_n)
//  begin
//    if(!rst_n)
//      XYOXYO_midterm <= 44'd0;
//    else if(start==1)
//      XYOXYO_midterm <= 44'd0;
//    else if(flag_midterm==0)
//      begin
//        if(num==2 || num==3)
//          begin
//            if(XYOXYO[33:24]>XYOXYO_midterm[33:24])
//              XYOXYO_midterm <= XYOXYO;
//            else
//              begin
//                if(XYOXYO[21:12]>=XYOXYO_midterm[21:12])
//                  XYOXYO_midterm <= XYOXYO;
//              end
//          end
//      end
//    else
//      begin
//        if(endl_tp3==1'b1)
//          begin
//            if(XYOXYO[33:24]>XYOXYO_midterm[33:24])
//              XYOXYO_midterm <= XYOXYO;
//            else
//              begin
//                if(XYOXYO[21:12]>=XYOXYO_midterm[21:12])
//                  XYOXYO_midterm <= XYOXYO;
//              end
//          end
//      end
//  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      XYOXYO_tc <= 44'd0;
    else if(start==1)
      XYOXYO_tc <= 44'd0;
    else if(flag_midterm==0)
      begin
        if(num==2)
          begin
            if(XYOXYO[33:24]>XYOXYO_tc[33:24])
              XYOXYO_tc <= XYOXYO;
            else
              begin
                if(XYOXYO[21:12]>=XYOXYO_tc[21:12])
                  XYOXYO_tc <= XYOXYO;
                //else
                  //XYOXYO_tc <= XYOXYO;
              end
          end
      end
    else
      begin
        if(endl_tp3==1'b1)
          begin
            if(XYOXYO[23:22]==2'b01)
              begin
                if(XYOXYO[33:24]>XYOXYO_tc[33:24])
                  XYOXYO_tc <= XYOXYO;
                else
                  begin
                    if(XYOXYO[21:12]>=XYOXYO_tc[21:12])
                      XYOXYO_tc <= XYOXYO;
                //else
                  //XYOXYO_tc <= XYOXYO;
                  end
              end
            else
              XYOXYO_tc <= XYOXYO;              
          end
      end
  end               
            
        

  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_matches <= 15'd0;
    else if(start==1)
      addr_b_matches <= 15'd0;
   // else if(addr_b_matches<1)
   //   addr_b_matches <= addr_b_matches + 1'b1;
    else if(endl==1 && addr_b_matches<num_matches-1)
      addr_b_matches <= addr_b_matches + 1'b1;
   // else if(endl_tp3==1 && XYOXYO[33:24]==XYOXYO_tc[33:24] && XYOXYO[21:12]<XYOXYO_tc[21:12])
   //   addr_b_matches <= addr_b_matches + 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        XYOXYO_tc_tp1 <= 44'd0;
        XYOXYO_tc_tp2 <= 44'd0;
        XYOXYO_tc_tp3 <= 44'd0;
        XYOXYO_tc_tp4 <= 44'd0;
        XYOXYO_tc_tp5 <= 44'd0; 
      end
    else if(start==1)
      begin
        XYOXYO_tc_tp1 <= 44'd0;
        XYOXYO_tc_tp2 <= 44'd0;
        XYOXYO_tc_tp3 <= 44'd0;
        XYOXYO_tc_tp4 <= 44'd0;
        XYOXYO_tc_tp5 <= 44'd0;
      end
    else
      begin
        XYOXYO_tc_tp1 <= XYOXYO_tc;
        XYOXYO_tc_tp2 <= XYOXYO_tc_tp1; 
        XYOXYO_tc_tp3 <= XYOXYO_tc_tp2; 
        XYOXYO_tc_tp4 <= XYOXYO_tc_tp3; 
        XYOXYO_tc_tp5 <= XYOXYO_tc_tp4;  
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        scaledXY_left <= 20'd0;
        scaledXY_right <= 20'd0;
      end
    else if(start==1)
      begin
        scaledXY_left <= 20'd0;
        scaledXY_right <= 20'd0;
      end
    else if(XYOXYO_tc_tp4[23:22]==2'b10)
      begin
        if(scaledY_left>scaledXY_left[9:0])
          begin
            scaledXY_left <= {scaledX_left,scaledY_left};
            scaledXY_right <= {scaledX_right,scaledY_left};
          end
        else if(scaledY_left==scaledXY_left[9:0])
          begin
            if(scaledX_left>=scaledXY_left[19:10] && scaledX_right>=scaledXY_right[19:10])
              begin
                scaledXY_left <= {scaledX_left,scaledY_left};
                scaledXY_right <= {scaledX_right,scaledY_left};
              end
          end
      end
    else
      begin
        scaledXY_left <= 20'd0;
        scaledXY_right <= 20'd0;
      end
  end
                
          
        
      
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_data_left1 <= 19'd0;
    else if(start==1)
      addr_b_data_left1 <= 19'd0;
    else if(addr_b_data_left1<351203)
      begin
        if(num==4 && XY_left1!=XY_in_left && XYOXYO_tc_tp5[23:22]==2'b01)
          addr_b_data_left1 <= addr_b_data_left1 + 1'b1;
      end
  end  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_data_right1 <= 19'd0;
    else if(start==1)
      addr_b_data_right1 <= 19'd0;
    else if(addr_b_data_right1<351203)
      begin
        if(num==4 && XY_right1!=XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
          addr_b_data_right1 <= addr_b_data_right1 + 1'b1;
      end
  end  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_data_left2 <= 19'd0;
    else if(start==1)
      addr_b_data_left2 <= 19'd0;
    else if(addr_b_data_left2<250097)
      begin
        if(num==4 && XY_left2!=scaledXY_left && XYOXYO_tc_tp5[23:22]==2'b10)
          addr_b_data_left2 <= addr_b_data_left2 + 1'b1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b_data_right2 <= 19'd0;
    else if(start==1)
      addr_b_data_right2 <= 19'd0;
    else if(addr_b_data_right2<250097)
      begin
        if(num==4 && XY_right2!=scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
          addr_b_data_right2 <= addr_b_data_right2 + 1'b1;
      end
  end
    
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_left1 <= 1'b0;
    else if(start==1)
      en_left1 <= 1'b0;
    else if(num==1 && XYOXYO_tc_tp5[23:22]==2'b01)
      begin
        if(XY_left1==XY_in_left)
          en_left1 <= 1'b0;
        else
          en_left1 <= 1'b1;
      end
    else
      en_left1 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_right1 <= 1'b0;
    else if(start==1)
      en_right1 <= 1'b0;
    else if(num==1 && XYOXYO_tc_tp5[23:22]==2'b01)
      begin
        if(XY_right1==XY_in_right)
          en_right1 <= 1'b0;
        else
          en_right1 <= 1'b1;
      end
    else
      en_right1 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_left2 <= 1'b0;
    else if(start==1)
      en_left2 <= 1'b0;
    else if(num==1 && XYOXYO_tc_tp5[23:22]==2'b10)
      begin
        if(XY_left2==scaledXY_left)
          en_left2 <= 1'b0;
        else
          en_left2 <= 1'b1;
      end
    else
      en_left2 <= 1'b0;
  end
  
  always@(posedge clk or  negedge rst_n)
  begin
    if(!rst_n)
      en_right2 <= 1'b0;
    else if(start==1)
      en_right2 <= 1'b0;
    else if(num==1 && XYOXYO_tc_tp5[23:22]==2'b10)
      begin
        if(XY_right2==scaledXY_right)
          en_right2 <= 1'b0;
        else
          en_right2 <= 1'b1;
      end
    else
      en_right2 <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count_left1 <= 10'd0;
    else if(start==1)
      count_left1 <= 10'd0;
    else if(en_left1==1 && addr_b_data_left1>=16950)
      begin
        if(count_left1<=677)
          count_left1 <= count_left1 + 1'b1;
        else
          count_left1 <= 1'b1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count_right1 <= 10'd0;
    else if(start==1)
      count_right1 <= 10'd0;
    else if(en_right1==1 && addr_b_data_right1>=16950)
      begin
        if(count_right1<=677)
          count_right1 <= count_right1 + 1'b1;
        else
          count_right1 <= 1'b1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count_left2 <= 10'd0;
    else if(start==1)
      count_left2 <= 10'd0;
    else if(en_left2==1 && addr_b_data_left2>=14275)
      begin
        if(count_left2<=570)
          count_left2 <= count_left2 + 1'b1;
        else
          count_left2 <= 1'b1;
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      count_right2 <= 10'd0;
    else if(start==1)
      count_right2 <= 10'd0;
    else if(en_right2==1 && addr_b_data_right2>=14275)
      begin
        if(count_right2<=570)
          count_right2 <= count_right2 + 1'b1;
        else
          count_right2 <= 1'b1;
      end
  end   
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_XY_left1 <= 1'b0;
    else 
      en_XY_left1 <= en_left1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_XY_right1 <= 1'b0;
    else 
      en_XY_right1 <= en_right1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_XY_left2 <= 1'b0;
    else
      en_XY_left2 <= en_left2;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en_XY_right2 <= 1'b0;
    else 
      en_XY_right2 <= en_right2;
  end
    
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      act_Y_left1 <= 1'b0;
    else if(start==1)
      act_Y_left1 <= 1'b0;
    else if(count_left1==30)
      act_Y_left1 <= 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_left1 <= 10'd0;
        Y_left1 <= 10'd0;
      end
    else if(start==1)
      begin
        X_left1 <= 10'd0;
        Y_left1 <= 10'd0;
      end
    else if(en_XY_left1==1)
      begin
        if(count_left1>25)
           X_left1 <= count_left1 - 5'd25;
        else if(count_left1==25)
          begin
            if(act_Y_left1==1)
              begin
                X_left1 <= 10'd0;
                Y_left1 <= Y_left1 + 1'b1;
              end
            else
              X_left1 <= 10'd0;
          end
      end  
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      act_Y_right1 <= 1'b0;
    else if(start==1)
      act_Y_right1 <= 1'b0;
    else if(count_right1==35)
      act_Y_right1 <= 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_right1 <= 10'd0;
        Y_right1 <= 10'd0;
      end
    else if(start==1)
      begin
        X_right1 <= 10'd0;
        Y_right1 <= 10'd0;
      end
    else if(en_XY_right1==1)
      begin
        if(count_right1>30)
           X_right1 <= count_right1 - 5'd30;
        else if(count_right1==30)
          begin
            if(act_Y_right1==1)
              begin
                X_right1 <= 10'd0;
                Y_right1 <= Y_right1 + 1'b1;
              end
            else
              X_right1 <= 10'd0;
          end
      end  
  end  
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      act_Y_left2 <= 1'b0;
    else if(start==1)
      act_Y_left2 <= 1'b0;
    else if(count_left2==30)
      act_Y_left2 <= 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_left2 <= 10'd0;
        Y_left2 <= 10'd0;
      end
    else if(start==1)
      begin
        X_left2 <= 10'd0;
        Y_left2 <= 10'd0;
      end
    else if(en_XY_left2==1)
      begin
        if(count_left2>25)
          X_left2 <= count_left2 - 5'd25;
        else if(count_left2==25)
          begin
            if(act_Y_left2==1)
              begin
                X_left2 <= 10'd0;
                Y_left2 <= Y_left2 + 1'b1;
              end
            else
              X_left2 <= 10'd0;
          end
      end
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      act_Y_right2 <= 1'b0;
    else if(start==1)
      act_Y_right2 <= 1'b0;
    else if(count_right2==35)
      act_Y_right2 <= 1'b1;
  end   
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        X_right2 <= 10'd0;
        Y_right2 <= 10'd0;
      end
    else if(start==1)
      begin
        X_right2 <= 10'd0;
        Y_right2 <= 10'd0;
      end
    else if(en_XY_right2==1)
      begin
        if(count_right2>30)
           X_right2 <= count_right2 - 5'd30;
        else if(count_right2==30)
          begin
            if(act_Y_right2==1)
              begin
                X_right2 <= 10'd0;
                Y_right2 <= Y_right2 + 1'b1;
              end
            else
              X_right2 <= 10'd0;
          end
      end  
  end    

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_windows <= 4'd0;
  else if(start==1)
    count_windows <= 4'd1;
  else if(XYOXYO_tc_tp5[23:22]==2'b01 && XY_left1==XY_in_left && XY_right1==XY_in_right)
    begin
      if(count_windows<11 && count_cols==11)
        count_windows <= count_windows + 1'b1;
    end
  else if(XYOXYO_tc_tp5[23:22]==2'b10 && XY_left2==scaledXY_left && XY_right2==scaledXY_right)
    begin
      if(count_windows<11 && count_cols==11)
        count_windows <= count_windows + 1'b1;
    end
  else
    count_windows <= 4'd1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_cols <= 4'd0;
  else if(start==1)
    count_cols <= 4'd0;
  else if(XYOXYO_tc_tp5[23:22]==2'b01 && XY_left1==XY_in_left && XY_right1==XY_in_right)
    begin
      if(count_cols<11)
        count_cols <= count_cols + 1'b1;
      else if(count_cols==11 && count_windows!=11)
        count_cols <= 1'b1;
    end
  else if(XYOXYO_tc_tp5[23:22]==2'b10 && XY_left2==scaledXY_left && XY_right2==scaledXY_right)
    begin
      if(count_cols<11)
        count_cols <= count_cols + 1'b1;
      else if(count_cols==11 && count_windows!=11)
        count_cols <= 1'b1;
    end
  else
    count_cols <= 4'd0;
end 
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      norm1_left <= 9'd0;
      norm2_left <= 9'd0;
      norm3_left <= 9'd0;
      norm4_left <= 9'd0;
      norm5_left <= 9'd0;
      norm6_left <= 9'd0;
      norm7_left <= 9'd0;
      norm8_left <= 9'd0;
      norm9_left <= 9'd0;
      norm10_left <= 9'd0;
      norm11_left <= 9'd0;
    end
  else if(start==1)
    begin
      norm1_left <= 9'd0;
      norm2_left <= 9'd0;
      norm3_left <= 9'd0;
      norm4_left <= 9'd0;
      norm5_left <= 9'd0;
      norm6_left <= 9'd0;
      norm7_left <= 9'd0;
      norm8_left <= 9'd0;
      norm9_left <= 9'd0;
      norm10_left <= 9'd0;
      norm11_left <= 9'd0;
    end
  else if(XYOXYO_tc_tp5[23:22]==2'b01)
    begin
      if(count_cols==1)
        begin
          norm1_left <= win1_1_left1 - win6_6_left1;
          norm2_left <= win2_1_left1 - win6_6_left1;
          norm3_left <= win3_1_left1 - win6_6_left1;
          norm4_left <= win4_1_left1 - win6_6_left1;
          norm5_left <= win5_1_left1 - win6_6_left1;
          norm6_left <= win6_1_left1 - win6_6_left1;
          norm7_left <= win7_1_left1 - win6_6_left1;
          norm8_left <= win8_1_left1 - win6_6_left1;
          norm9_left <= win9_1_left1 - win6_6_left1;
          norm10_left <= win10_1_left1 - win6_6_left1;
          norm11_left <= win11_1_left1 - win6_6_left1;
        end
      else if(count_cols==2)
        begin
          norm1_left <= win1_2_left1 - win6_6_left1;
          norm2_left <= win2_2_left1 - win6_6_left1;
          norm3_left <= win3_2_left1 - win6_6_left1;
          norm4_left <= win4_2_left1 - win6_6_left1;
          norm5_left <= win5_2_left1 - win6_6_left1;
          norm6_left <= win6_2_left1 - win6_6_left1;
          norm7_left <= win7_2_left1 - win6_6_left1;
          norm8_left <= win8_2_left1 - win6_6_left1;
          norm9_left <= win9_2_left1 - win6_6_left1;
          norm10_left <= win10_2_left1 - win6_6_left1;
          norm11_left <= win11_2_left1 - win6_6_left1;
        end
      else if(count_cols==3)
        begin
          norm1_left <= win1_3_left1 - win6_6_left1;
          norm2_left <= win2_3_left1 - win6_6_left1;
          norm3_left <= win3_3_left1 - win6_6_left1;
          norm4_left <= win4_3_left1 - win6_6_left1;
          norm5_left <= win5_3_left1 - win6_6_left1;
          norm6_left <= win6_3_left1 - win6_6_left1;
          norm7_left <= win7_3_left1 - win6_6_left1;
          norm8_left <= win8_3_left1 - win6_6_left1;
          norm9_left <= win9_3_left1 - win6_6_left1;
          norm10_left <= win10_3_left1 - win6_6_left1;
          norm11_left <= win11_3_left1 - win6_6_left1;
        end
      else if(count_cols==4)
        begin
          norm1_left <= win1_4_left1 - win6_6_left1;
          norm2_left <= win2_4_left1 - win6_6_left1;
          norm3_left <= win3_4_left1 - win6_6_left1;
          norm4_left <= win4_4_left1 - win6_6_left1;
          norm5_left <= win5_4_left1 - win6_6_left1;
          norm6_left <= win6_4_left1 - win6_6_left1;
          norm7_left <= win7_4_left1 - win6_6_left1;
          norm8_left <= win8_4_left1 - win6_6_left1;
          norm9_left <= win9_4_left1 - win6_6_left1;
          norm10_left <= win10_4_left1 - win6_6_left1;
          norm11_left <= win11_4_left1 - win6_6_left1;
        end
      else if(count_cols==5)
        begin
          norm1_left <= win1_5_left1 - win6_6_left1;
          norm2_left <= win2_5_left1 - win6_6_left1;
          norm3_left <= win3_5_left1 - win6_6_left1;
          norm4_left <= win4_5_left1 - win6_6_left1;
          norm5_left <= win5_5_left1 - win6_6_left1;
          norm6_left <= win6_5_left1 - win6_6_left1;
          norm7_left <= win7_5_left1 - win6_6_left1;
          norm8_left <= win8_5_left1 - win6_6_left1;
          norm9_left <= win9_5_left1 - win6_6_left1;
          norm10_left <= win10_5_left1 - win6_6_left1;
          norm11_left <= win11_5_left1 - win6_6_left1;
        end
      else if(count_cols==6)
        begin
          norm1_left <= win1_6_left1 - win6_6_left1;
          norm2_left <= win2_6_left1 - win6_6_left1;
          norm3_left <= win3_6_left1 - win6_6_left1;
          norm4_left <= win4_6_left1 - win6_6_left1;
          norm5_left <= win5_6_left1 - win6_6_left1;
          norm6_left <= 9'd0;
          norm7_left <= win7_6_left1 - win6_6_left1;
          norm8_left <= win8_6_left1 - win6_6_left1;
          norm9_left <= win9_6_left1 - win6_6_left1;
          norm10_left <= win10_6_left1 - win6_6_left1;
          norm11_left <= win11_6_left1 - win6_6_left1;
        end
      else if(count_cols==7)
        begin
          norm1_left <= win1_7_left1 - win6_6_left1;
          norm2_left <= win2_7_left1 - win6_6_left1;
          norm3_left <= win3_7_left1 - win6_6_left1;
          norm4_left <= win4_7_left1 - win6_6_left1;
          norm5_left <= win5_7_left1 - win6_6_left1;
          norm6_left <= win6_7_left1 - win6_6_left1;
          norm7_left <= win7_7_left1 - win6_6_left1;
          norm8_left <= win8_7_left1 - win6_6_left1;
          norm9_left <= win9_7_left1 - win6_6_left1;
          norm10_left <= win10_7_left1 - win6_6_left1;
          norm11_left <= win11_7_left1 - win6_6_left1;
        end
      else if(count_cols==8)
        begin
          norm1_left <= win1_8_left1 - win6_6_left1;
          norm2_left <= win2_8_left1 - win6_6_left1;
          norm3_left <= win3_8_left1 - win6_6_left1;
          norm4_left <= win4_8_left1 - win6_6_left1;
          norm5_left <= win5_8_left1 - win6_6_left1;
          norm6_left <= win6_8_left1 - win6_6_left1;
          norm7_left <= win7_8_left1 - win6_6_left1;
          norm8_left <= win8_8_left1 - win6_6_left1;
          norm9_left <= win9_8_left1 - win6_6_left1;
          norm10_left <= win10_8_left1 - win6_6_left1;
          norm11_left <= win11_8_left1 - win6_6_left1;
        end
      else if(count_cols==9)
        begin
          norm1_left <= win1_9_left1 - win6_6_left1;
          norm2_left <= win2_9_left1 - win6_6_left1;
          norm3_left <= win3_9_left1 - win6_6_left1;
          norm4_left <= win4_9_left1 - win6_6_left1;
          norm5_left <= win5_9_left1 - win6_6_left1;
          norm6_left <= win6_9_left1 - win6_6_left1;
          norm7_left <= win7_9_left1 - win6_6_left1;
          norm8_left <= win8_9_left1 - win6_6_left1;
          norm9_left <= win9_9_left1 - win6_6_left1;
          norm10_left <= win10_9_left1 - win6_6_left1;
          norm11_left <= win11_9_left1 - win6_6_left1;
        end
      else if(count_cols==10)
        begin
          norm1_left <= win1_10_left1 - win6_6_left1;
          norm2_left <= win2_10_left1 - win6_6_left1;
          norm3_left <= win3_10_left1 - win6_6_left1;
          norm4_left <= win4_10_left1 - win6_6_left1;
          norm5_left <= win5_10_left1 - win6_6_left1;
          norm6_left <= win6_10_left1 - win6_6_left1;
          norm7_left <= win7_10_left1 - win6_6_left1;
          norm8_left <= win8_10_left1 - win6_6_left1;
          norm9_left <= win9_10_left1 - win6_6_left1;
          norm10_left <= win10_10_left1 - win6_6_left1;
          norm11_left <= win11_10_left1 - win6_6_left1;
        end
      else if(count_cols==11)
        begin
          norm1_left <= win1_11_left1 - win6_6_left1;
          norm2_left <= win2_11_left1 - win6_6_left1;
          norm3_left <= win3_11_left1 - win6_6_left1;
          norm4_left <= win4_11_left1 - win6_6_left1;
          norm5_left <= win5_11_left1 - win6_6_left1;
          norm6_left <= win6_11_left1 - win6_6_left1;
          norm7_left <= win7_11_left1 - win6_6_left1;
          norm8_left <= win8_11_left1 - win6_6_left1;
          norm9_left <= win9_11_left1 - win6_6_left1;
          norm10_left <= win10_11_left1 - win6_6_left1;
          norm11_left <= win11_11_left1 - win6_6_left1;
        end
      else
        begin
          norm1_left <= 9'd0;
          norm2_left <= 9'd0;
          norm3_left <= 9'd0;
          norm4_left <= 9'd0;
          norm5_left <= 9'd0;
          norm6_left <= 9'd0;
          norm7_left <= 9'd0;
          norm8_left <= 9'd0;
          norm9_left <= 9'd0;
          norm10_left <= 9'd0;
          norm11_left <= 9'd0;
        end
    end
  else if(XYOXYO_tc_tp5[23:22]==2'b10)
    begin
      if(count_cols==1)
        begin
          norm1_left <= win1_1_left2 - win6_6_left2;
          norm2_left <= win2_1_left2 - win6_6_left2;
          norm3_left <= win3_1_left2 - win6_6_left2;
          norm4_left <= win4_1_left2 - win6_6_left2;
          norm5_left <= win5_1_left2 - win6_6_left2;
          norm6_left <= win6_1_left2 - win6_6_left2;
          norm7_left <= win7_1_left2 - win6_6_left2;
          norm8_left <= win8_1_left2 - win6_6_left2;
          norm9_left <= win9_1_left2 - win6_6_left2;
          norm10_left <= win10_1_left2 - win6_6_left2;
          norm11_left <= win11_1_left2 - win6_6_left2;
        end
      else if(count_cols==2)
        begin
          norm1_left <= win1_2_left2 - win6_6_left2;
          norm2_left <= win2_2_left2 - win6_6_left2;
          norm3_left <= win3_2_left2 - win6_6_left2;
          norm4_left <= win4_2_left2 - win6_6_left2;
          norm5_left <= win5_2_left2 - win6_6_left2;
          norm6_left <= win6_2_left2 - win6_6_left2;
          norm7_left <= win7_2_left2 - win6_6_left2;
          norm8_left <= win8_2_left2 - win6_6_left2;
          norm9_left <= win9_2_left2 - win6_6_left2;
          norm10_left <= win10_2_left2 - win6_6_left2;
          norm11_left <= win11_2_left2 - win6_6_left2;
        end
      else if(count_cols==3)
        begin
          norm1_left <= win1_3_left2 - win6_6_left2;
          norm2_left <= win2_3_left2 - win6_6_left2;
          norm3_left <= win3_3_left2 - win6_6_left2;
          norm4_left <= win4_3_left2 - win6_6_left2;
          norm5_left <= win5_3_left2 - win6_6_left2;
          norm6_left <= win6_3_left2 - win6_6_left2;
          norm7_left <= win7_3_left2 - win6_6_left2;
          norm8_left <= win8_3_left2 - win6_6_left2;
          norm9_left <= win9_3_left2 - win6_6_left2;
          norm10_left <= win10_3_left2 - win6_6_left2;
          norm11_left <= win11_3_left2 - win6_6_left2;
        end
      else if(count_cols==4)
        begin
          norm1_left <= win1_4_left2 - win6_6_left2;
          norm2_left <= win2_4_left2 - win6_6_left2;
          norm3_left <= win3_4_left2 - win6_6_left2;
          norm4_left <= win4_4_left2 - win6_6_left2;
          norm5_left <= win5_4_left2 - win6_6_left2;
          norm6_left <= win6_4_left2 - win6_6_left2;
          norm7_left <= win7_4_left2 - win6_6_left2;
          norm8_left <= win8_4_left2 - win6_6_left2;
          norm9_left <= win9_4_left2 - win6_6_left2;
          norm10_left <= win10_4_left2 - win6_6_left2;
          norm11_left <= win11_4_left2 - win6_6_left2;
        end
      else if(count_cols==5)
        begin
          norm1_left <= win1_5_left2 - win6_6_left2;
          norm2_left <= win2_5_left2 - win6_6_left2;
          norm3_left <= win3_5_left2 - win6_6_left2;
          norm4_left <= win4_5_left2 - win6_6_left2;
          norm5_left <= win5_5_left2 - win6_6_left2;
          norm6_left <= win6_5_left2 - win6_6_left2;
          norm7_left <= win7_5_left2 - win6_6_left2;
          norm8_left <= win8_5_left2 - win6_6_left2;
          norm9_left <= win9_5_left2 - win6_6_left2;
          norm10_left <= win10_5_left2 - win6_6_left2;
          norm11_left <= win11_5_left2 - win6_6_left2;
        end
      else if(count_cols==6)
        begin
          norm1_left <= win1_6_left2 - win6_6_left2;
          norm2_left <= win2_6_left2 - win6_6_left2;
          norm3_left <= win3_6_left2 - win6_6_left2;
          norm4_left <= win4_6_left2 - win6_6_left2;
          norm5_left <= win5_6_left2 - win6_6_left2;
          norm6_left <= 9'd0;
          norm7_left <= win7_6_left2 - win6_6_left2;
          norm8_left <= win8_6_left2 - win6_6_left2;
          norm9_left <= win9_6_left2 - win6_6_left2;
          norm10_left <= win10_6_left2 - win6_6_left2;
          norm11_left <= win11_6_left2 - win6_6_left2;
        end
      else if(count_cols==7)
        begin
          norm1_left <= win1_7_left2 - win6_6_left2;
          norm2_left <= win2_7_left2 - win6_6_left2;
          norm3_left <= win3_7_left2 - win6_6_left2;
          norm4_left <= win4_7_left2 - win6_6_left2;
          norm5_left <= win5_7_left2 - win6_6_left2;
          norm6_left <= win6_7_left2 - win6_6_left2;
          norm7_left <= win7_7_left2 - win6_6_left2;
          norm8_left <= win8_7_left2 - win6_6_left2;
          norm9_left <= win9_7_left2 - win6_6_left2;
          norm10_left <= win10_7_left2 - win6_6_left2;
          norm11_left <= win11_7_left2 - win6_6_left2;
        end
      else if(count_cols==8)
        begin
          norm1_left <= win1_8_left2 - win6_6_left2;
          norm2_left <= win2_8_left2 - win6_6_left2;
          norm3_left <= win3_8_left2 - win6_6_left2;
          norm4_left <= win4_8_left2 - win6_6_left2;
          norm5_left <= win5_8_left2 - win6_6_left2;
          norm6_left <= win6_8_left2 - win6_6_left2;
          norm7_left <= win7_8_left2 - win6_6_left2;
          norm8_left <= win8_8_left2 - win6_6_left2;
          norm9_left <= win9_8_left2 - win6_6_left2;
          norm10_left <= win10_8_left2 - win6_6_left2;
          norm11_left <= win11_8_left2 - win6_6_left2;
        end
      else if(count_cols==9)
        begin
          norm1_left <= win1_9_left2 - win6_6_left2;
          norm2_left <= win2_9_left2 - win6_6_left2;
          norm3_left <= win3_9_left2 - win6_6_left2;
          norm4_left <= win4_9_left2 - win6_6_left2;
          norm5_left <= win5_9_left2 - win6_6_left2;
          norm6_left <= win6_9_left2 - win6_6_left2;
          norm7_left <= win7_9_left2 - win6_6_left2;
          norm8_left <= win8_9_left2 - win6_6_left2;
          norm9_left <= win9_9_left2 - win6_6_left2;
          norm10_left <= win10_9_left2 - win6_6_left2;
          norm11_left <= win11_9_left2 - win6_6_left2;
        end
      else if(count_cols==10)
        begin
          norm1_left <= win1_10_left2 - win6_6_left2;
          norm2_left <= win2_10_left2 - win6_6_left2;
          norm3_left <= win3_10_left2 - win6_6_left2;
          norm4_left <= win4_10_left2 - win6_6_left2;
          norm5_left <= win5_10_left2 - win6_6_left2;
          norm6_left <= win6_10_left2 - win6_6_left2;
          norm7_left <= win7_10_left2 - win6_6_left2;
          norm8_left <= win8_10_left2 - win6_6_left2;
          norm9_left <= win9_10_left2 - win6_6_left2;
          norm10_left <= win10_10_left2 - win6_6_left2;
          norm11_left <= win11_10_left2 - win6_6_left2;
        end
      else if(count_cols==11)
        begin
          norm1_left <= win1_11_left2 - win6_6_left2;
          norm2_left <= win2_11_left2 - win6_6_left2;
          norm3_left <= win3_11_left2 - win6_6_left2;
          norm4_left <= win4_11_left2 - win6_6_left2;
          norm5_left <= win5_11_left2 - win6_6_left2;
          norm6_left <= win6_11_left2 - win6_6_left2;
          norm7_left <= win7_11_left2 - win6_6_left2;
          norm8_left <= win8_11_left2 - win6_6_left2;
          norm9_left <= win9_11_left2 - win6_6_left2;
          norm10_left <= win10_11_left2 - win6_6_left2;
          norm11_left <= win11_11_left2 - win6_6_left2;
        end
      else
        begin
          norm1_left <= 9'd0;
          norm2_left <= 9'd0;
          norm3_left <= 9'd0;
          norm4_left <= 9'd0;
          norm5_left <= 9'd0;
          norm6_left <= 9'd0;
          norm7_left <= 9'd0;
          norm8_left <= 9'd0;
          norm9_left <= 9'd0;
          norm10_left <= 9'd0;
          norm11_left <= 9'd0;
        end
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      norm1_right <= 9'd0;
      norm2_right <= 9'd0;
      norm3_right <= 9'd0;
      norm4_right <= 9'd0;
      norm5_right <= 9'd0;
      norm6_right <= 9'd0;
      norm7_right <= 9'd0;
      norm8_right <= 9'd0;
      norm9_right <= 9'd0;
      norm10_right <= 9'd0;
      norm11_right <= 9'd0;
    end
  else if(start==1)
    begin
      norm1_right <= 9'd0;
      norm2_right <= 9'd0;
      norm3_right <= 9'd0;
      norm4_right <= 9'd0;
      norm5_right <= 9'd0;
      norm6_right <= 9'd0;
      norm7_right <= 9'd0;
      norm8_right <= 9'd0;
      norm9_right <= 9'd0;
      norm10_right <= 9'd0;
      norm11_right <= 9'd0;
    end
  else if(XYOXYO_tc_tp5[23:22]==2'b01)
    begin
      if(count_windows==1)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_1_right1 - win6_6_right1;
              norm2_right <= win2_1_right1 - win6_6_right1;
              norm3_right <= win3_1_right1 - win6_6_right1;
              norm4_right <= win4_1_right1 - win6_6_right1;
              norm5_right <= win5_1_right1 - win6_6_right1;
              norm6_right <= win6_1_right1 - win6_6_right1;
              norm7_right <= win7_1_right1 - win6_6_right1;
              norm8_right <= win8_1_right1 - win6_6_right1;
              norm9_right <= win9_1_right1 - win6_6_right1;
              norm10_right <= win10_1_right1 - win6_6_right1;
              norm11_right <= win11_1_right1 - win6_6_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_2_right1 - win6_6_right1;
               norm2_right <= win2_2_right1 - win6_6_right1;
               norm3_right <= win3_2_right1 - win6_6_right1;
               norm4_right <= win4_2_right1 - win6_6_right1;
               norm5_right <= win5_2_right1 - win6_6_right1;
               norm6_right <= win6_2_right1 - win6_6_right1;
               norm7_right <= win7_2_right1 - win6_6_right1;
               norm8_right <= win8_2_right1 - win6_6_right1;
               norm9_right <= win9_2_right1 - win6_6_right1;
               norm10_right <= win10_2_right1 - win6_6_right1;
               norm11_right <= win11_2_right1 - win6_6_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_3_right1 - win6_6_right1;
               norm2_right <= win2_3_right1 - win6_6_right1;
               norm3_right <= win3_3_right1 - win6_6_right1;
               norm4_right <= win4_3_right1 - win6_6_right1;
               norm5_right <= win5_3_right1 - win6_6_right1;
               norm6_right <= win6_3_right1 - win6_6_right1;
               norm7_right <= win7_3_right1 - win6_6_right1;
               norm8_right <= win8_3_right1 - win6_6_right1;
               norm9_right <= win9_3_right1 - win6_6_right1;
               norm10_right <= win10_3_right1 - win6_6_right1;
               norm11_right <= win11_3_right1 - win6_6_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_4_right1 - win6_6_right1;
               norm2_right <= win2_4_right1 - win6_6_right1;
               norm3_right <= win3_4_right1 - win6_6_right1;
               norm4_right <= win4_4_right1 - win6_6_right1;
               norm5_right <= win5_4_right1 - win6_6_right1;
               norm6_right <= win6_4_right1 - win6_6_right1;
               norm7_right <= win7_4_right1 - win6_6_right1;
               norm8_right <= win8_4_right1 - win6_6_right1;
               norm9_right <= win9_4_right1 - win6_6_right1;
               norm10_right <= win10_4_right1 - win6_6_right1;
               norm11_right <= win11_4_right1 - win6_6_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_5_right1 - win6_6_right1;
               norm2_right <= win2_5_right1 - win6_6_right1;
               norm3_right <= win3_5_right1 - win6_6_right1;
               norm4_right <= win4_5_right1 - win6_6_right1;
               norm5_right <= win5_5_right1 - win6_6_right1;
               norm6_right <= win6_5_right1 - win6_6_right1;
               norm7_right <= win7_5_right1 - win6_6_right1;
               norm8_right <= win8_5_right1 - win6_6_right1;
               norm9_right <= win9_5_right1 - win6_6_right1;
               norm10_right <= win10_5_right1 - win6_6_right1;
               norm11_right <= win11_5_right1 - win6_6_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_6_right1 - win6_6_right1;
               norm2_right <= win2_6_right1 - win6_6_right1;
               norm3_right <= win3_6_right1 - win6_6_right1;
               norm4_right <= win4_6_right1 - win6_6_right1;
               norm5_right <= win5_6_right1 - win6_6_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_6_right1 - win6_6_right1;
               norm8_right <= win8_6_right1 - win6_6_right1;
               norm9_right <= win9_6_right1 - win6_6_right1;
               norm10_right <= win10_6_right1 - win6_6_right1;
               norm11_right <= win11_6_right1 - win6_6_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_7_right1 - win6_6_right1;
               norm2_right <= win2_7_right1 - win6_6_right1;
               norm3_right <= win3_7_right1 - win6_6_right1;
               norm4_right <= win4_7_right1 - win6_6_right1;
               norm5_right <= win5_7_right1 - win6_6_right1;
               norm6_right <= win6_7_right1 - win6_6_right1;
               norm7_right <= win7_7_right1 - win6_6_right1;
               norm8_right <= win8_7_right1 - win6_6_right1;
               norm9_right <= win9_7_right1 - win6_6_right1;
               norm10_right <= win10_7_right1 - win6_6_right1;
               norm11_right <= win11_7_right1 - win6_6_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_8_right1 - win6_6_right1;
               norm2_right <= win2_8_right1 - win6_6_right1;
               norm3_right <= win3_8_right1 - win6_6_right1;
               norm4_right <= win4_8_right1 - win6_6_right1;
               norm5_right <= win5_8_right1 - win6_6_right1;
               norm6_right <= win6_8_right1 - win6_6_right1;
               norm7_right <= win7_8_right1 - win6_6_right1;
               norm8_right <= win8_8_right1 - win6_6_right1;
               norm9_right <= win9_8_right1 - win6_6_right1;
               norm10_right <= win10_8_right1 - win6_6_right1;
               norm11_right <= win11_8_right1 - win6_6_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_9_right1 - win6_6_right1;
               norm2_right <= win2_9_right1 - win6_6_right1;
               norm3_right <= win3_9_right1 - win6_6_right1;
               norm4_right <= win4_9_right1 - win6_6_right1;
               norm5_right <= win5_9_right1 - win6_6_right1;
               norm6_right <= win6_9_right1 - win6_6_right1;
               norm7_right <= win7_9_right1 - win6_6_right1;
               norm8_right <= win8_9_right1 - win6_6_right1;
               norm9_right <= win9_9_right1 - win6_6_right1;
               norm10_right <= win10_9_right1 - win6_6_right1;
               norm11_right <= win11_9_right1 - win6_6_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_10_right1 - win6_6_right1;
               norm2_right <= win2_10_right1 - win6_6_right1;
               norm3_right <= win3_10_right1 - win6_6_right1;
               norm4_right <= win4_10_right1 - win6_6_right1;
               norm5_right <= win5_10_right1 - win6_6_right1;
               norm6_right <= win6_10_right1 - win6_6_right1;
               norm7_right <= win7_10_right1 - win6_6_right1;
               norm8_right <= win8_10_right1 - win6_6_right1;
               norm9_right <= win9_10_right1 - win6_6_right1;
               norm10_right <= win10_10_right1 - win6_6_right1;
               norm11_right <= win11_10_right1 - win6_6_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_11_right1 - win6_6_right1;
               norm2_right <= win2_11_right1 - win6_6_right1;
               norm3_right <= win3_11_right1 - win6_6_right1;
               norm4_right <= win4_11_right1 - win6_6_right1;
               norm5_right <= win5_11_right1 - win6_6_right1;
               norm6_right <= win6_11_right1 - win6_6_right1;
               norm7_right <= win7_11_right1 - win6_6_right1;
               norm8_right <= win8_11_right1 - win6_6_right1;
               norm9_right <= win9_11_right1 - win6_6_right1;
               norm10_right <= win10_11_right1 - win6_6_right1;
               norm11_right <= win11_11_right1 - win6_6_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==2)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_2_right1 - win6_7_right1;
              norm2_right <= win2_2_right1 - win6_7_right1;
              norm3_right <= win3_2_right1 - win6_7_right1;
              norm4_right <= win4_2_right1 - win6_7_right1;
              norm5_right <= win5_2_right1 - win6_7_right1;
              norm6_right <= win6_2_right1 - win6_7_right1;
              norm7_right <= win7_2_right1 - win6_7_right1;
              norm8_right <= win8_2_right1 - win6_7_right1;
              norm9_right <= win9_2_right1 - win6_7_right1;
              norm10_right <= win10_2_right1 - win6_7_right1;
              norm11_right <= win11_2_right1 - win6_7_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_3_right1 - win6_7_right1;
               norm2_right <= win2_3_right1 - win6_7_right1;
               norm3_right <= win3_3_right1 - win6_7_right1;
               norm4_right <= win4_3_right1 - win6_7_right1;
               norm5_right <= win5_3_right1 - win6_7_right1;
               norm6_right <= win6_3_right1 - win6_7_right1;
               norm7_right <= win7_3_right1 - win6_7_right1;
               norm8_right <= win8_3_right1 - win6_7_right1;
               norm9_right <= win9_3_right1 - win6_7_right1;
               norm10_right <= win10_3_right1 - win6_7_right1;
               norm11_right <= win11_3_right1 - win6_7_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_4_right1 - win6_7_right1;
               norm2_right <= win2_4_right1 - win6_7_right1;
               norm3_right <= win3_4_right1 - win6_7_right1;
               norm4_right <= win4_4_right1 - win6_7_right1;
               norm5_right <= win5_4_right1 - win6_7_right1;
               norm6_right <= win6_4_right1 - win6_7_right1;
               norm7_right <= win7_4_right1 - win6_7_right1;
               norm8_right <= win8_4_right1 - win6_7_right1;
               norm9_right <= win9_4_right1 - win6_7_right1;
               norm10_right <= win10_4_right1 - win6_7_right1;
               norm11_right <= win11_4_right1 - win6_7_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_5_right1 - win6_7_right1;
               norm2_right <= win2_5_right1 - win6_7_right1;
               norm3_right <= win3_5_right1 - win6_7_right1;
               norm4_right <= win4_5_right1 - win6_7_right1;
               norm5_right <= win5_5_right1 - win6_7_right1;
               norm6_right <= win6_5_right1 - win6_7_right1;
               norm7_right <= win7_5_right1 - win6_7_right1;
               norm8_right <= win8_5_right1 - win6_7_right1;
               norm9_right <= win9_5_right1 - win6_7_right1;
               norm10_right <= win10_5_right1 - win6_7_right1;
               norm11_right <= win11_5_right1 - win6_7_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_6_right1 - win6_7_right1;
               norm2_right <= win2_6_right1 - win6_7_right1;
               norm3_right <= win3_6_right1 - win6_7_right1;
               norm4_right <= win4_6_right1 - win6_7_right1;
               norm5_right <= win5_6_right1 - win6_7_right1;
               norm6_right <= win6_6_right1 - win6_7_right1;
               norm7_right <= win7_6_right1 - win6_7_right1;
               norm8_right <= win8_6_right1 - win6_7_right1;
               norm9_right <= win9_6_right1 - win6_7_right1;
               norm10_right <= win10_6_right1 - win6_7_right1;
               norm11_right <= win11_6_right1 - win6_7_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_7_right1 - win6_7_right1;
               norm2_right <= win2_7_right1 - win6_7_right1;
               norm3_right <= win3_7_right1 - win6_7_right1;
               norm4_right <= win4_7_right1 - win6_7_right1;
               norm5_right <= win5_7_right1 - win6_7_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_7_right1 - win6_7_right1;
               norm8_right <= win8_7_right1 - win6_7_right1;
               norm9_right <= win9_7_right1 - win6_7_right1;
               norm10_right <= win10_7_right1 - win6_7_right1;
               norm11_right <= win11_7_right1 - win6_7_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_8_right1 - win6_7_right1;
               norm2_right <= win2_8_right1 - win6_7_right1;
               norm3_right <= win3_8_right1 - win6_7_right1;
               norm4_right <= win4_8_right1 - win6_7_right1;
               norm5_right <= win5_8_right1 - win6_7_right1;
               norm6_right <= win6_8_right1 - win6_7_right1;
               norm7_right <= win7_8_right1 - win6_7_right1;
               norm8_right <= win8_8_right1 - win6_7_right1;
               norm9_right <= win9_8_right1 - win6_7_right1;
               norm10_right <= win10_8_right1 - win6_7_right1;
               norm11_right <= win11_8_right1 - win6_7_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_9_right1 - win6_7_right1;
               norm2_right <= win2_9_right1 - win6_7_right1;
               norm3_right <= win3_9_right1 - win6_7_right1;
               norm4_right <= win4_9_right1 - win6_7_right1;
               norm5_right <= win5_9_right1 - win6_7_right1;
               norm6_right <= win6_9_right1 - win6_7_right1;
               norm7_right <= win7_9_right1 - win6_7_right1;
               norm8_right <= win8_9_right1 - win6_7_right1;
               norm9_right <= win9_9_right1 - win6_7_right1;
               norm10_right <= win10_9_right1 - win6_7_right1;
               norm11_right <= win11_9_right1 - win6_7_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_10_right1 - win6_7_right1;
               norm2_right <= win2_10_right1 - win6_7_right1;
               norm3_right <= win3_10_right1 - win6_7_right1;
               norm4_right <= win4_10_right1 - win6_7_right1;
               norm5_right <= win5_10_right1 - win6_7_right1;
               norm6_right <= win6_10_right1 - win6_7_right1;
               norm7_right <= win7_10_right1 - win6_7_right1;
               norm8_right <= win8_10_right1 - win6_7_right1;
               norm9_right <= win9_10_right1 - win6_7_right1;
               norm10_right <= win10_10_right1 - win6_7_right1;
               norm11_right <= win11_10_right1 - win6_7_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_11_right1 - win6_7_right1;
               norm2_right <= win2_11_right1 - win6_7_right1;
               norm3_right <= win3_11_right1 - win6_7_right1;
               norm4_right <= win4_11_right1 - win6_7_right1;
               norm5_right <= win5_11_right1 - win6_7_right1;
               norm6_right <= win6_11_right1 - win6_7_right1;
               norm7_right <= win7_11_right1 - win6_7_right1;
               norm8_right <= win8_11_right1 - win6_7_right1;
               norm9_right <= win9_11_right1 - win6_7_right1;
               norm10_right <= win10_11_right1 - win6_7_right1;
               norm11_right <= win11_11_right1 - win6_7_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_12_right1 - win6_7_right1;
               norm2_right <= win2_12_right1 - win6_7_right1;
               norm3_right <= win3_12_right1 - win6_7_right1;
               norm4_right <= win4_12_right1 - win6_7_right1;
               norm5_right <= win5_12_right1 - win6_7_right1;
               norm6_right <= win6_12_right1 - win6_7_right1;
               norm7_right <= win7_12_right1 - win6_7_right1;
               norm8_right <= win8_12_right1 - win6_7_right1;
               norm9_right <= win9_12_right1 - win6_7_right1;
               norm10_right <= win10_12_right1 - win6_7_right1;
               norm11_right <= win11_12_right1 - win6_7_right1;
             end
          else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==3)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_3_right1 - win6_8_right1;
              norm2_right <= win2_3_right1 - win6_8_right1;
              norm3_right <= win3_3_right1 - win6_8_right1;
              norm4_right <= win4_3_right1 - win6_8_right1;
              norm5_right <= win5_3_right1 - win6_8_right1;
              norm6_right <= win6_3_right1 - win6_8_right1;
              norm7_right <= win7_3_right1 - win6_8_right1;
              norm8_right <= win8_3_right1 - win6_8_right1;
              norm9_right <= win9_3_right1 - win6_8_right1;
              norm10_right <= win10_3_right1 - win6_8_right1;
              norm11_right <= win11_3_right1 - win6_8_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_4_right1 - win6_8_right1;
               norm2_right <= win2_4_right1 - win6_8_right1;
               norm3_right <= win3_4_right1 - win6_8_right1;
               norm4_right <= win4_4_right1 - win6_8_right1;
               norm5_right <= win5_4_right1 - win6_8_right1;
               norm6_right <= win6_4_right1 - win6_8_right1;
               norm7_right <= win7_4_right1 - win6_8_right1;
               norm8_right <= win8_4_right1 - win6_8_right1;
               norm9_right <= win9_4_right1 - win6_8_right1;
               norm10_right <= win10_4_right1 - win6_8_right1;
               norm11_right <= win11_4_right1 - win6_8_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_5_right1 - win6_8_right1;
               norm2_right <= win2_5_right1 - win6_8_right1;
               norm3_right <= win3_5_right1 - win6_8_right1;
               norm4_right <= win4_5_right1 - win6_8_right1;
               norm5_right <= win5_5_right1 - win6_8_right1;
               norm6_right <= win6_5_right1 - win6_8_right1;
               norm7_right <= win7_5_right1 - win6_8_right1;
               norm8_right <= win8_5_right1 - win6_8_right1;
               norm9_right <= win9_5_right1 - win6_8_right1;
               norm10_right <= win10_5_right1 - win6_8_right1;
               norm11_right <= win11_5_right1 - win6_8_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_6_right1 - win6_8_right1;
               norm2_right <= win2_6_right1 - win6_8_right1;
               norm3_right <= win3_6_right1 - win6_8_right1;
               norm4_right <= win4_6_right1 - win6_8_right1;
               norm5_right <= win5_6_right1 - win6_8_right1;
               norm6_right <= win6_6_right1 - win6_8_right1;
               norm7_right <= win7_6_right1 - win6_8_right1;
               norm8_right <= win8_6_right1 - win6_8_right1;
               norm9_right <= win9_6_right1 - win6_8_right1;
               norm10_right <= win10_6_right1 - win6_8_right1;
               norm11_right <= win11_6_right1 - win6_8_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_7_right1 - win6_8_right1;
               norm2_right <= win2_7_right1 - win6_8_right1;
               norm3_right <= win3_7_right1 - win6_8_right1;
               norm4_right <= win4_7_right1 - win6_8_right1;
               norm5_right <= win5_7_right1 - win6_8_right1;
               norm6_right <= win6_7_right1 - win6_8_right1;
               norm7_right <= win7_7_right1 - win6_8_right1;
               norm8_right <= win8_7_right1 - win6_8_right1;
               norm9_right <= win9_7_right1 - win6_8_right1;
               norm10_right <= win10_7_right1 - win6_8_right1;
               norm11_right <= win11_7_right1 - win6_8_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_8_right1 - win6_8_right1;
               norm2_right <= win2_8_right1 - win6_8_right1;
               norm3_right <= win3_8_right1 - win6_8_right1;
               norm4_right <= win4_8_right1 - win6_8_right1;
               norm5_right <= win5_8_right1 - win6_8_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_8_right1 - win6_8_right1;
               norm8_right <= win8_8_right1 - win6_8_right1;
               norm9_right <= win9_8_right1 - win6_8_right1;
               norm10_right <= win10_8_right1 - win6_8_right1;
               norm11_right <= win11_8_right1 - win6_8_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_9_right1 - win6_8_right1;
               norm2_right <= win2_9_right1 - win6_8_right1;
               norm3_right <= win3_9_right1 - win6_8_right1;
               norm4_right <= win4_9_right1 - win6_8_right1;
               norm5_right <= win5_9_right1 - win6_8_right1;
               norm6_right <= win6_9_right1 - win6_8_right1;
               norm7_right <= win7_9_right1 - win6_8_right1;
               norm8_right <= win8_9_right1 - win6_8_right1;
               norm9_right <= win9_9_right1 - win6_8_right1;
               norm10_right <= win10_9_right1 - win6_8_right1;
               norm11_right <= win11_9_right1 - win6_8_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_10_right1 - win6_8_right1;
               norm2_right <= win2_10_right1 - win6_8_right1;
               norm3_right <= win3_10_right1 - win6_8_right1;
               norm4_right <= win4_10_right1 - win6_8_right1;
               norm5_right <= win5_10_right1 - win6_8_right1;
               norm6_right <= win6_10_right1 - win6_8_right1;
               norm7_right <= win7_10_right1 - win6_8_right1;
               norm8_right <= win8_10_right1 - win6_8_right1;
               norm9_right <= win9_10_right1 - win6_8_right1;
               norm10_right <= win10_10_right1 - win6_8_right1;
               norm11_right <= win11_10_right1 - win6_8_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_11_right1 - win6_8_right1;
               norm2_right <= win2_11_right1 - win6_8_right1;
               norm3_right <= win3_11_right1 - win6_8_right1;
               norm4_right <= win4_11_right1 - win6_8_right1;
               norm5_right <= win5_11_right1 - win6_8_right1;
               norm6_right <= win6_11_right1 - win6_8_right1;
               norm7_right <= win7_11_right1 - win6_8_right1;
               norm8_right <= win8_11_right1 - win6_8_right1;
               norm9_right <= win9_11_right1 - win6_8_right1;
               norm10_right <= win10_11_right1 - win6_8_right1;
               norm11_right <= win11_11_right1 - win6_8_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_12_right1 - win6_8_right1;
               norm2_right <= win2_12_right1 - win6_8_right1;
               norm3_right <= win3_12_right1 - win6_8_right1;
               norm4_right <= win4_12_right1 - win6_8_right1;
               norm5_right <= win5_12_right1 - win6_8_right1;
               norm6_right <= win6_12_right1 - win6_8_right1;
               norm7_right <= win7_12_right1 - win6_8_right1;
               norm8_right <= win8_12_right1 - win6_8_right1;
               norm9_right <= win9_12_right1 - win6_8_right1;
               norm10_right <= win10_12_right1 - win6_8_right1;
               norm11_right <= win11_12_right1 - win6_8_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_13_right1 - win6_8_right1;
               norm2_right <= win2_13_right1 - win6_8_right1;
               norm3_right <= win3_13_right1 - win6_8_right1;
               norm4_right <= win4_13_right1 - win6_8_right1;
               norm5_right <= win5_13_right1 - win6_8_right1;
               norm6_right <= win6_13_right1 - win6_8_right1;
               norm7_right <= win7_13_right1 - win6_8_right1;
               norm8_right <= win8_13_right1 - win6_8_right1;
               norm9_right <= win9_13_right1 - win6_8_right1;
               norm10_right <= win10_13_right1 - win6_8_right1;
               norm11_right <= win11_13_right1 - win6_8_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==4)
        begin
           if(count_cols==1)
            begin
              norm1_right <= win1_4_right1 - win6_9_right1;
              norm2_right <= win2_4_right1 - win6_9_right1;
              norm3_right <= win3_4_right1 - win6_9_right1;
              norm4_right <= win4_4_right1 - win6_9_right1;
              norm5_right <= win5_4_right1 - win6_9_right1;
              norm6_right <= win6_4_right1 - win6_9_right1;
              norm7_right <= win7_4_right1 - win6_9_right1;
              norm8_right <= win8_4_right1 - win6_9_right1;
              norm9_right <= win9_4_right1 - win6_9_right1;
              norm10_right <= win10_4_right1 - win6_9_right1;
              norm11_right <= win11_4_right1 - win6_9_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_5_right1 - win6_9_right1;
               norm2_right <= win2_5_right1 - win6_9_right1;
               norm3_right <= win3_5_right1 - win6_9_right1;
               norm4_right <= win4_5_right1 - win6_9_right1;
               norm5_right <= win5_5_right1 - win6_9_right1;
               norm6_right <= win6_5_right1 - win6_9_right1;
               norm7_right <= win7_5_right1 - win6_9_right1;
               norm8_right <= win8_5_right1 - win6_9_right1;
               norm9_right <= win9_5_right1 - win6_9_right1;
               norm10_right <= win10_5_right1 - win6_9_right1;
               norm11_right <= win11_5_right1 - win6_9_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_6_right1 - win6_9_right1;
               norm2_right <= win2_6_right1 - win6_9_right1;
               norm3_right <= win3_6_right1 - win6_9_right1;
               norm4_right <= win4_6_right1 - win6_9_right1;
               norm5_right <= win5_6_right1 - win6_9_right1;
               norm6_right <= win6_6_right1 - win6_9_right1;
               norm7_right <= win7_6_right1 - win6_9_right1;
               norm8_right <= win8_6_right1 - win6_9_right1;
               norm9_right <= win9_6_right1 - win6_9_right1;
               norm10_right <= win10_6_right1 - win6_9_right1;
               norm11_right <= win11_6_right1 - win6_9_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_7_right1 - win6_9_right1;
               norm2_right <= win2_7_right1 - win6_9_right1;
               norm3_right <= win3_7_right1 - win6_9_right1;
               norm4_right <= win4_7_right1 - win6_9_right1;
               norm5_right <= win5_7_right1 - win6_9_right1;
               norm6_right <= win6_7_right1 - win6_9_right1;
               norm7_right <= win7_7_right1 - win6_9_right1;
               norm8_right <= win8_7_right1 - win6_9_right1;
               norm9_right <= win9_7_right1 - win6_9_right1;
               norm10_right <= win10_7_right1 - win6_9_right1;
               norm11_right <= win11_7_right1 - win6_9_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_8_right1 - win6_9_right1;
               norm2_right <= win2_8_right1 - win6_9_right1;
               norm3_right <= win3_8_right1 - win6_9_right1;
               norm4_right <= win4_8_right1 - win6_9_right1;
               norm5_right <= win5_8_right1 - win6_9_right1;
               norm6_right <= win6_8_right1 - win6_9_right1;
               norm7_right <= win7_8_right1 - win6_9_right1;
               norm8_right <= win8_8_right1 - win6_9_right1;
               norm9_right <= win9_8_right1 - win6_9_right1;
               norm10_right <= win10_8_right1 - win6_9_right1;
               norm11_right <= win11_8_right1 - win6_9_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_9_right1 - win6_9_right1;
               norm2_right <= win2_9_right1 - win6_9_right1;
               norm3_right <= win3_9_right1 - win6_9_right1;
               norm4_right <= win4_9_right1 - win6_9_right1;
               norm5_right <= win5_9_right1 - win6_9_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_9_right1 - win6_9_right1;
               norm8_right <= win8_9_right1 - win6_9_right1;
               norm9_right <= win9_9_right1 - win6_9_right1;
               norm10_right <= win10_9_right1 - win6_9_right1;
               norm11_right <= win11_9_right1 - win6_9_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_10_right1 - win6_9_right1;
               norm2_right <= win2_10_right1 - win6_9_right1;
               norm3_right <= win3_10_right1 - win6_9_right1;
               norm4_right <= win4_10_right1 - win6_9_right1;
               norm5_right <= win5_10_right1 - win6_9_right1;
               norm6_right <= win6_10_right1 - win6_9_right1;
               norm7_right <= win7_10_right1 - win6_9_right1;
               norm8_right <= win8_10_right1 - win6_9_right1;
               norm9_right <= win9_10_right1 - win6_9_right1;
               norm10_right <= win10_10_right1 - win6_9_right1;
               norm11_right <= win11_10_right1 - win6_9_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_11_right1 - win6_9_right1;
               norm2_right <= win2_11_right1 - win6_9_right1;
               norm3_right <= win3_11_right1 - win6_9_right1;
               norm4_right <= win4_11_right1 - win6_9_right1;
               norm5_right <= win5_11_right1 - win6_9_right1;
               norm6_right <= win6_11_right1 - win6_9_right1;
               norm7_right <= win7_11_right1 - win6_9_right1;
               norm8_right <= win8_11_right1 - win6_9_right1;
               norm9_right <= win9_11_right1 - win6_9_right1;
               norm10_right <= win10_11_right1 - win6_9_right1;
               norm11_right <= win11_11_right1 - win6_9_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_12_right1 - win6_9_right1;
               norm2_right <= win2_12_right1 - win6_9_right1;
               norm3_right <= win3_12_right1 - win6_9_right1;
               norm4_right <= win4_12_right1 - win6_9_right1;
               norm5_right <= win5_12_right1 - win6_9_right1;
               norm6_right <= win6_12_right1 - win6_9_right1;
               norm7_right <= win7_12_right1 - win6_9_right1;
               norm8_right <= win8_12_right1 - win6_9_right1;
               norm9_right <= win9_12_right1 - win6_9_right1;
               norm10_right <= win10_12_right1 - win6_9_right1;
               norm11_right <= win11_12_right1 - win6_9_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_13_right1 - win6_9_right1;
               norm2_right <= win2_13_right1 - win6_9_right1;
               norm3_right <= win3_13_right1 - win6_9_right1;
               norm4_right <= win4_13_right1 - win6_9_right1;
               norm5_right <= win5_13_right1 - win6_9_right1;
               norm6_right <= win6_13_right1 - win6_9_right1;
               norm7_right <= win7_13_right1 - win6_9_right1;
               norm8_right <= win8_13_right1 - win6_9_right1;
               norm9_right <= win9_13_right1 - win6_9_right1;
               norm10_right <= win10_13_right1 - win6_9_right1;
               norm11_right <= win11_13_right1 - win6_9_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_14_right1 - win6_9_right1;
               norm2_right <= win2_14_right1 - win6_9_right1;
               norm3_right <= win3_14_right1 - win6_9_right1;
               norm4_right <= win4_14_right1 - win6_9_right1;
               norm5_right <= win5_14_right1 - win6_9_right1;
               norm6_right <= win6_14_right1 - win6_9_right1;
               norm7_right <= win7_14_right1 - win6_9_right1;
               norm8_right <= win8_14_right1 - win6_9_right1;
               norm9_right <= win9_14_right1 - win6_9_right1;
               norm10_right <= win10_14_right1 - win6_9_right1;
               norm11_right <= win11_14_right1 - win6_9_right1;
             end
           else        
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==5)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_5_right1 - win6_10_right1;
              norm2_right <= win2_5_right1 - win6_10_right1;
              norm3_right <= win3_5_right1 - win6_10_right1;
              norm4_right <= win4_5_right1 - win6_10_right1;
              norm5_right <= win5_5_right1 - win6_10_right1;
              norm6_right <= win6_5_right1 - win6_10_right1;
              norm7_right <= win7_5_right1 - win6_10_right1;
              norm8_right <= win8_5_right1 - win6_10_right1;
              norm9_right <= win9_5_right1 - win6_10_right1;
              norm10_right <= win10_5_right1 - win6_10_right1;
              norm11_right <= win11_5_right1 - win6_10_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_6_right1 - win6_10_right1;
               norm2_right <= win2_6_right1 - win6_10_right1;
               norm3_right <= win3_6_right1 - win6_10_right1;
               norm4_right <= win4_6_right1 - win6_10_right1;
               norm5_right <= win5_6_right1 - win6_10_right1;
               norm6_right <= win6_6_right1 - win6_10_right1;
               norm7_right <= win7_6_right1 - win6_10_right1;
               norm8_right <= win8_6_right1 - win6_10_right1;
               norm9_right <= win9_6_right1 - win6_10_right1;
               norm10_right <= win10_6_right1 - win6_10_right1;
               norm11_right <= win11_6_right1 - win6_10_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_7_right1 - win6_10_right1;
               norm2_right <= win2_7_right1 - win6_10_right1;
               norm3_right <= win3_7_right1 - win6_10_right1;
               norm4_right <= win4_7_right1 - win6_10_right1;
               norm5_right <= win5_7_right1 - win6_10_right1;
               norm6_right <= win6_7_right1 - win6_10_right1;
               norm7_right <= win7_7_right1 - win6_10_right1;
               norm8_right <= win8_7_right1 - win6_10_right1;
               norm9_right <= win9_7_right1 - win6_10_right1;
               norm10_right <= win10_7_right1 - win6_10_right1;
               norm11_right <= win11_7_right1 - win6_10_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_8_right1 - win6_10_right1;
               norm2_right <= win2_8_right1 - win6_10_right1;
               norm3_right <= win3_8_right1 - win6_10_right1;
               norm4_right <= win4_8_right1 - win6_10_right1;
               norm5_right <= win5_8_right1 - win6_10_right1;
               norm6_right <= win6_8_right1 - win6_10_right1;
               norm7_right <= win7_8_right1 - win6_10_right1;
               norm8_right <= win8_8_right1 - win6_10_right1;
               norm9_right <= win9_8_right1 - win6_10_right1;
               norm10_right <= win10_8_right1 - win6_10_right1;
               norm11_right <= win11_8_right1 - win6_10_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_9_right1 - win6_10_right1;
               norm2_right <= win2_9_right1 - win6_10_right1;
               norm3_right <= win3_9_right1 - win6_10_right1;
               norm4_right <= win4_9_right1 - win6_10_right1;
               norm5_right <= win5_9_right1 - win6_10_right1;
               norm6_right <= win6_9_right1 - win6_10_right1;
               norm7_right <= win7_9_right1 - win6_10_right1;
               norm8_right <= win8_9_right1 - win6_10_right1;
               norm9_right <= win9_9_right1 - win6_10_right1;
               norm10_right <= win10_9_right1 - win6_10_right1;
               norm11_right <= win11_9_right1 - win6_10_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_10_right1 - win6_10_right1;
               norm2_right <= win2_10_right1 - win6_10_right1;
               norm3_right <= win3_10_right1 - win6_10_right1;
               norm4_right <= win4_10_right1 - win6_10_right1;
               norm5_right <= win5_10_right1 - win6_10_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_10_right1 - win6_10_right1;
               norm8_right <= win8_10_right1 - win6_10_right1;
               norm9_right <= win9_10_right1 - win6_10_right1;
               norm10_right <= win10_10_right1 - win6_10_right1;
               norm11_right <= win11_10_right1 - win6_10_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_11_right1 - win6_10_right1;
               norm2_right <= win2_11_right1 - win6_10_right1;
               norm3_right <= win3_11_right1 - win6_10_right1;
               norm4_right <= win4_11_right1 - win6_10_right1;
               norm5_right <= win5_11_right1 - win6_10_right1;
               norm6_right <= win6_11_right1 - win6_10_right1;
               norm7_right <= win7_11_right1 - win6_10_right1;
               norm8_right <= win8_11_right1 - win6_10_right1;
               norm9_right <= win9_11_right1 - win6_10_right1;
               norm10_right <= win10_11_right1 - win6_10_right1;
               norm11_right <= win11_11_right1 - win6_10_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_12_right1 - win6_10_right1;
               norm2_right <= win2_12_right1 - win6_10_right1;
               norm3_right <= win3_12_right1 - win6_10_right1;
               norm4_right <= win4_12_right1 - win6_10_right1;
               norm5_right <= win5_12_right1 - win6_10_right1;
               norm6_right <= win6_12_right1 - win6_10_right1;
               norm7_right <= win7_12_right1 - win6_10_right1;
               norm8_right <= win8_12_right1 - win6_10_right1;
               norm9_right <= win9_12_right1 - win6_10_right1;
               norm10_right <= win10_12_right1 - win6_10_right1;
               norm11_right <= win11_12_right1 - win6_10_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_13_right1 - win6_10_right1;
               norm2_right <= win2_13_right1 - win6_10_right1;
               norm3_right <= win3_13_right1 - win6_10_right1;
               norm4_right <= win4_13_right1 - win6_10_right1;
               norm5_right <= win5_13_right1 - win6_10_right1;
               norm6_right <= win6_13_right1 - win6_10_right1;
               norm7_right <= win7_13_right1 - win6_10_right1;
               norm8_right <= win8_13_right1 - win6_10_right1;
               norm9_right <= win9_13_right1 - win6_10_right1;
               norm10_right <= win10_13_right1 - win6_10_right1;
               norm11_right <= win11_13_right1 - win6_10_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_14_right1 - win6_10_right1;
               norm2_right <= win2_14_right1 - win6_10_right1;
               norm3_right <= win3_14_right1 - win6_10_right1;
               norm4_right <= win4_14_right1 - win6_10_right1;
               norm5_right <= win5_14_right1 - win6_10_right1;
               norm6_right <= win6_14_right1 - win6_10_right1;
               norm7_right <= win7_14_right1 - win6_10_right1;
               norm8_right <= win8_14_right1 - win6_10_right1;
               norm9_right <= win9_14_right1 - win6_10_right1;
               norm10_right <= win10_14_right1 - win6_10_right1;
               norm11_right <= win11_14_right1 - win6_10_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_15_right1 - win6_10_right1;
               norm2_right <= win2_15_right1 - win6_10_right1;
               norm3_right <= win3_15_right1 - win6_10_right1;
               norm4_right <= win4_15_right1 - win6_10_right1;
               norm5_right <= win5_15_right1 - win6_10_right1;
               norm6_right <= win6_15_right1 - win6_10_right1;
               norm7_right <= win7_15_right1 - win6_10_right1;
               norm8_right <= win8_15_right1 - win6_10_right1;
               norm9_right <= win9_15_right1 - win6_10_right1;
               norm10_right <= win10_15_right1 - win6_10_right1;
               norm11_right <= win11_15_right1 - win6_10_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==6)
        begin
           if(count_cols==1)
            begin
              norm1_right <= win1_6_right1 - win6_11_right1;
              norm2_right <= win2_6_right1 - win6_11_right1;
              norm3_right <= win3_6_right1 - win6_11_right1;
              norm4_right <= win4_6_right1 - win6_11_right1;
              norm5_right <= win5_6_right1 - win6_11_right1;
              norm6_right <= win6_6_right1 - win6_11_right1;
              norm7_right <= win7_6_right1 - win6_11_right1;
              norm8_right <= win8_6_right1 - win6_11_right1;
              norm9_right <= win9_6_right1 - win6_11_right1;
              norm10_right <= win10_6_right1 - win6_11_right1;
              norm11_right <= win11_6_right1 - win6_11_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_7_right1 - win6_11_right1;
               norm2_right <= win2_7_right1 - win6_11_right1;
               norm3_right <= win3_7_right1 - win6_11_right1;
               norm4_right <= win4_7_right1 - win6_11_right1;
               norm5_right <= win5_7_right1 - win6_11_right1;
               norm6_right <= win6_7_right1 - win6_11_right1;
               norm7_right <= win7_7_right1 - win6_11_right1;
               norm8_right <= win8_7_right1 - win6_11_right1;
               norm9_right <= win9_7_right1 - win6_11_right1;
               norm10_right <= win10_7_right1 - win6_11_right1;
               norm11_right <= win11_7_right1 - win6_11_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_8_right1 - win6_11_right1;
               norm2_right <= win2_8_right1 - win6_11_right1;
               norm3_right <= win3_8_right1 - win6_11_right1;
               norm4_right <= win4_8_right1 - win6_11_right1;
               norm5_right <= win5_8_right1 - win6_11_right1;
               norm6_right <= win6_8_right1 - win6_11_right1;
               norm7_right <= win7_8_right1 - win6_11_right1;
               norm8_right <= win8_8_right1 - win6_11_right1;
               norm9_right <= win9_8_right1 - win6_11_right1;
               norm10_right <= win10_8_right1 - win6_11_right1;
               norm11_right <= win11_8_right1 - win6_11_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_9_right1 - win6_11_right1;
               norm2_right <= win2_9_right1 - win6_11_right1;
               norm3_right <= win3_9_right1 - win6_11_right1;
               norm4_right <= win4_9_right1 - win6_11_right1;
               norm5_right <= win5_9_right1 - win6_11_right1;
               norm6_right <= win6_9_right1 - win6_11_right1;
               norm7_right <= win7_9_right1 - win6_11_right1;
               norm8_right <= win8_9_right1 - win6_11_right1;
               norm9_right <= win9_9_right1 - win6_11_right1;
               norm10_right <= win10_9_right1 - win6_11_right1;
               norm11_right <= win11_9_right1 - win6_11_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_10_right1 - win6_11_right1;
               norm2_right <= win2_10_right1 - win6_11_right1;
               norm3_right <= win3_10_right1 - win6_11_right1;
               norm4_right <= win4_10_right1 - win6_11_right1;
               norm5_right <= win5_10_right1 - win6_11_right1;
               norm6_right <= win6_10_right1 - win6_11_right1;
               norm7_right <= win7_10_right1 - win6_11_right1;
               norm8_right <= win8_10_right1 - win6_11_right1;
               norm9_right <= win9_10_right1 - win6_11_right1;
               norm10_right <= win10_10_right1 - win6_11_right1;
               norm11_right <= win11_10_right1 - win6_11_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_11_right1 - win6_11_right1;
               norm2_right <= win2_11_right1 - win6_11_right1;
               norm3_right <= win3_11_right1 - win6_11_right1;
               norm4_right <= win4_11_right1 - win6_11_right1;
               norm5_right <= win5_11_right1 - win6_11_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_11_right1 - win6_11_right1;
               norm8_right <= win8_11_right1 - win6_11_right1;
               norm9_right <= win9_11_right1 - win6_11_right1;
               norm10_right <= win10_11_right1 - win6_11_right1;
               norm11_right <= win11_11_right1 - win6_11_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_12_right1 - win6_11_right1;
               norm2_right <= win2_12_right1 - win6_11_right1;
               norm3_right <= win3_12_right1 - win6_11_right1;
               norm4_right <= win4_12_right1 - win6_11_right1;
               norm5_right <= win5_12_right1 - win6_11_right1;
               norm6_right <= win6_12_right1 - win6_11_right1;
               norm7_right <= win7_12_right1 - win6_11_right1;
               norm8_right <= win8_12_right1 - win6_11_right1;
               norm9_right <= win9_12_right1 - win6_11_right1;
               norm10_right <= win10_12_right1 - win6_11_right1;
               norm11_right <= win11_12_right1 - win6_11_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_13_right1 - win6_11_right1;
               norm2_right <= win2_13_right1 - win6_11_right1;
               norm3_right <= win3_13_right1 - win6_11_right1;
               norm4_right <= win4_13_right1 - win6_11_right1;
               norm5_right <= win5_13_right1 - win6_11_right1;
               norm6_right <= win6_13_right1 - win6_11_right1;
               norm7_right <= win7_13_right1 - win6_11_right1;
               norm8_right <= win8_13_right1 - win6_11_right1;
               norm9_right <= win9_13_right1 - win6_11_right1;
               norm10_right <= win10_13_right1 - win6_11_right1;
               norm11_right <= win11_13_right1 - win6_11_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_14_right1 - win6_11_right1;
               norm2_right <= win2_14_right1 - win6_11_right1;
               norm3_right <= win3_14_right1 - win6_11_right1;
               norm4_right <= win4_14_right1 - win6_11_right1;
               norm5_right <= win5_14_right1 - win6_11_right1;
               norm6_right <= win6_14_right1 - win6_11_right1;
               norm7_right <= win7_14_right1 - win6_11_right1;
               norm8_right <= win8_14_right1 - win6_11_right1;
               norm9_right <= win9_14_right1 - win6_11_right1;
               norm10_right <= win10_14_right1 - win6_11_right1;
               norm11_right <= win11_14_right1 - win6_11_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_15_right1 - win6_11_right1;
               norm2_right <= win2_15_right1 - win6_11_right1;
               norm3_right <= win3_15_right1 - win6_11_right1;
               norm4_right <= win4_15_right1 - win6_11_right1;
               norm5_right <= win5_15_right1 - win6_11_right1;
               norm6_right <= win6_15_right1 - win6_11_right1;
               norm7_right <= win7_15_right1 - win6_11_right1;
               norm8_right <= win8_15_right1 - win6_11_right1;
               norm9_right <= win9_15_right1 - win6_11_right1;
               norm10_right <= win10_15_right1 - win6_11_right1;
               norm11_right <= win11_15_right1 - win6_11_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_16_right1 - win6_11_right1;
               norm2_right <= win2_16_right1 - win6_11_right1;
               norm3_right <= win3_16_right1 - win6_11_right1;
               norm4_right <= win4_16_right1 - win6_11_right1;
               norm5_right <= win5_16_right1 - win6_11_right1;
               norm6_right <= win6_16_right1 - win6_11_right1;
               norm7_right <= win7_16_right1 - win6_11_right1;
               norm8_right <= win8_16_right1 - win6_11_right1;
               norm9_right <= win9_16_right1 - win6_11_right1;
               norm10_right <= win10_16_right1 - win6_11_right1;
               norm11_right <= win11_16_right1 - win6_11_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==7)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_7_right1 - win6_12_right1;
              norm2_right <= win2_7_right1 - win6_12_right1;
              norm3_right <= win3_7_right1 - win6_12_right1;
              norm4_right <= win4_7_right1 - win6_12_right1;
              norm5_right <= win5_7_right1 - win6_12_right1;
              norm6_right <= win6_7_right1 - win6_12_right1;
              norm7_right <= win7_7_right1 - win6_12_right1;
              norm8_right <= win8_7_right1 - win6_12_right1;
              norm9_right <= win9_7_right1 - win6_12_right1;
              norm10_right <= win10_7_right1 - win6_12_right1;
              norm11_right <= win11_7_right1 - win6_12_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_8_right1 - win6_12_right1;
               norm2_right <= win2_8_right1 - win6_12_right1;
               norm3_right <= win3_8_right1 - win6_12_right1;
               norm4_right <= win4_8_right1 - win6_12_right1;
               norm5_right <= win5_8_right1 - win6_12_right1;
               norm6_right <= win6_8_right1 - win6_12_right1;
               norm7_right <= win7_8_right1 - win6_12_right1;
               norm8_right <= win8_8_right1 - win6_12_right1;
               norm9_right <= win9_8_right1 - win6_12_right1;
               norm10_right <= win10_8_right1 - win6_12_right1;
               norm11_right <= win11_8_right1 - win6_12_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_9_right1 - win6_12_right1;
               norm2_right <= win2_9_right1 - win6_12_right1;
               norm3_right <= win3_9_right1 - win6_12_right1;
               norm4_right <= win4_9_right1 - win6_12_right1;
               norm5_right <= win5_9_right1 - win6_12_right1;
               norm6_right <= win6_9_right1 - win6_12_right1;
               norm7_right <= win7_9_right1 - win6_12_right1;
               norm8_right <= win8_9_right1 - win6_12_right1;
               norm9_right <= win9_9_right1 - win6_12_right1;
               norm10_right <= win10_9_right1 - win6_12_right1;
               norm11_right <= win11_9_right1 - win6_12_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_10_right1 - win6_12_right1;
               norm2_right <= win2_10_right1 - win6_12_right1;
               norm3_right <= win3_10_right1 - win6_12_right1;
               norm4_right <= win4_10_right1 - win6_12_right1;
               norm5_right <= win5_10_right1 - win6_12_right1;
               norm6_right <= win6_10_right1 - win6_12_right1;
               norm7_right <= win7_10_right1 - win6_12_right1;
               norm8_right <= win8_10_right1 - win6_12_right1;
               norm9_right <= win9_10_right1 - win6_12_right1;
               norm10_right <= win10_10_right1 - win6_12_right1;
               norm11_right <= win11_10_right1 - win6_12_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_11_right1 - win6_12_right1;
               norm2_right <= win2_11_right1 - win6_12_right1;
               norm3_right <= win3_11_right1 - win6_12_right1;
               norm4_right <= win4_11_right1 - win6_12_right1;
               norm5_right <= win5_11_right1 - win6_12_right1;
               norm6_right <= win6_11_right1 - win6_12_right1;
               norm7_right <= win7_11_right1 - win6_12_right1;
               norm8_right <= win8_11_right1 - win6_12_right1;
               norm9_right <= win9_11_right1 - win6_12_right1;
               norm10_right <= win10_11_right1 - win6_12_right1;
               norm11_right <= win11_11_right1 - win6_12_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_12_right1 - win6_12_right1;
               norm2_right <= win2_12_right1 - win6_12_right1;
               norm3_right <= win3_12_right1 - win6_12_right1;
               norm4_right <= win4_12_right1 - win6_12_right1;
               norm5_right <= win5_12_right1 - win6_12_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_12_right1 - win6_12_right1;
               norm8_right <= win8_12_right1 - win6_12_right1;
               norm9_right <= win9_12_right1 - win6_12_right1;
               norm10_right <= win10_12_right1 - win6_12_right1;
               norm11_right <= win11_12_right1 - win6_12_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_13_right1 - win6_12_right1;
               norm2_right <= win2_13_right1 - win6_12_right1;
               norm3_right <= win3_13_right1 - win6_12_right1;
               norm4_right <= win4_13_right1 - win6_12_right1;
               norm5_right <= win5_13_right1 - win6_12_right1;
               norm6_right <= win6_13_right1 - win6_12_right1;
               norm7_right <= win7_13_right1 - win6_12_right1;
               norm8_right <= win8_13_right1 - win6_12_right1;
               norm9_right <= win9_13_right1 - win6_12_right1;
               norm10_right <= win10_13_right1 - win6_12_right1;
               norm11_right <= win11_13_right1 - win6_12_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_14_right1 - win6_12_right1;
               norm2_right <= win2_14_right1 - win6_12_right1;
               norm3_right <= win3_14_right1 - win6_12_right1;
               norm4_right <= win4_14_right1 - win6_12_right1;
               norm5_right <= win5_14_right1 - win6_12_right1;
               norm6_right <= win6_14_right1 - win6_12_right1;
               norm7_right <= win7_14_right1 - win6_12_right1;
               norm8_right <= win8_14_right1 - win6_12_right1;
               norm9_right <= win9_14_right1 - win6_12_right1;
               norm10_right <= win10_14_right1 - win6_12_right1;
               norm11_right <= win11_14_right1 - win6_12_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_15_right1 - win6_12_right1;
               norm2_right <= win2_15_right1 - win6_12_right1;
               norm3_right <= win3_15_right1 - win6_12_right1;
               norm4_right <= win4_15_right1 - win6_12_right1;
               norm5_right <= win5_15_right1 - win6_12_right1;
               norm6_right <= win6_15_right1 - win6_12_right1;
               norm7_right <= win7_15_right1 - win6_12_right1;
               norm8_right <= win8_15_right1 - win6_12_right1;
               norm9_right <= win9_15_right1 - win6_12_right1;
               norm10_right <= win10_15_right1 - win6_12_right1;
               norm11_right <= win11_15_right1 - win6_12_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_16_right1 - win6_12_right1;
               norm2_right <= win2_16_right1 - win6_12_right1;
               norm3_right <= win3_16_right1 - win6_12_right1;
               norm4_right <= win4_16_right1 - win6_12_right1;
               norm5_right <= win5_16_right1 - win6_12_right1;
               norm6_right <= win6_16_right1 - win6_12_right1;
               norm7_right <= win7_16_right1 - win6_12_right1;
               norm8_right <= win8_16_right1 - win6_12_right1;
               norm9_right <= win9_16_right1 - win6_12_right1;
               norm10_right <= win10_16_right1 - win6_12_right1;
               norm11_right <= win11_16_right1 - win6_12_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_17_right1 - win6_12_right1;
               norm2_right <= win2_17_right1 - win6_12_right1;
               norm3_right <= win3_17_right1 - win6_12_right1;
               norm4_right <= win4_17_right1 - win6_12_right1;
               norm5_right <= win5_17_right1 - win6_12_right1;
               norm6_right <= win6_17_right1 - win6_12_right1;
               norm7_right <= win7_17_right1 - win6_12_right1;
               norm8_right <= win8_17_right1 - win6_12_right1;
               norm9_right <= win9_17_right1 - win6_12_right1;
               norm10_right <= win10_17_right1 - win6_12_right1;
               norm11_right <= win11_17_right1 - win6_12_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==8)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_8_right1 - win6_13_right1;
              norm2_right <= win2_8_right1 - win6_13_right1;
              norm3_right <= win3_8_right1 - win6_13_right1;
              norm4_right <= win4_8_right1 - win6_13_right1;
              norm5_right <= win5_8_right1 - win6_13_right1;
              norm6_right <= win6_8_right1 - win6_13_right1;
              norm7_right <= win7_8_right1 - win6_13_right1;
              norm8_right <= win8_8_right1 - win6_13_right1;
              norm9_right <= win9_8_right1 - win6_13_right1;
              norm10_right <= win10_8_right1 - win6_13_right1;
              norm11_right <= win11_8_right1 - win6_13_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_9_right1 - win6_13_right1;
               norm2_right <= win2_9_right1 - win6_13_right1;
               norm3_right <= win3_9_right1 - win6_13_right1;
               norm4_right <= win4_9_right1 - win6_13_right1;
               norm5_right <= win5_9_right1 - win6_13_right1;
               norm6_right <= win6_9_right1 - win6_13_right1;
               norm7_right <= win7_9_right1 - win6_13_right1;
               norm8_right <= win8_9_right1 - win6_13_right1;
               norm9_right <= win9_9_right1 - win6_13_right1;
               norm10_right <= win10_9_right1 - win6_13_right1;
               norm11_right <= win11_9_right1 - win6_13_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_10_right1 - win6_13_right1;
               norm2_right <= win2_10_right1 - win6_13_right1;
               norm3_right <= win3_10_right1 - win6_13_right1;
               norm4_right <= win4_10_right1 - win6_13_right1;
               norm5_right <= win5_10_right1 - win6_13_right1;
               norm6_right <= win6_10_right1 - win6_13_right1;
               norm7_right <= win7_10_right1 - win6_13_right1;
               norm8_right <= win8_10_right1 - win6_13_right1;
               norm9_right <= win9_10_right1 - win6_13_right1;
               norm10_right <= win10_10_right1 - win6_13_right1;
               norm11_right <= win11_10_right1 - win6_13_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_11_right1 - win6_13_right1;
               norm2_right <= win2_11_right1 - win6_13_right1;
               norm3_right <= win3_11_right1 - win6_13_right1;
               norm4_right <= win4_11_right1 - win6_13_right1;
               norm5_right <= win5_11_right1 - win6_13_right1;
               norm6_right <= win6_11_right1 - win6_13_right1;
               norm7_right <= win7_11_right1 - win6_13_right1;
               norm8_right <= win8_11_right1 - win6_13_right1;
               norm9_right <= win9_11_right1 - win6_13_right1;
               norm10_right <= win10_11_right1 - win6_13_right1;
               norm11_right <= win11_11_right1 - win6_13_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_12_right1 - win6_13_right1;
               norm2_right <= win2_12_right1 - win6_13_right1;
               norm3_right <= win3_12_right1 - win6_13_right1;
               norm4_right <= win4_12_right1 - win6_13_right1;
               norm5_right <= win5_12_right1 - win6_13_right1;
               norm6_right <= win6_12_right1 - win6_13_right1;
               norm7_right <= win7_12_right1 - win6_13_right1;
               norm8_right <= win8_12_right1 - win6_13_right1;
               norm9_right <= win9_12_right1 - win6_13_right1;
               norm10_right <= win10_12_right1 - win6_13_right1;
               norm11_right <= win11_12_right1 - win6_13_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_13_right1 - win6_13_right1;
               norm2_right <= win2_13_right1 - win6_13_right1;
               norm3_right <= win3_13_right1 - win6_13_right1;
               norm4_right <= win4_13_right1 - win6_13_right1;
               norm5_right <= win5_13_right1 - win6_13_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_13_right1 - win6_13_right1;
               norm8_right <= win8_13_right1 - win6_13_right1;
               norm9_right <= win9_13_right1 - win6_13_right1;
               norm10_right <= win10_13_right1 - win6_13_right1;
               norm11_right <= win11_13_right1 - win6_13_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_14_right1 - win6_13_right1;
               norm2_right <= win2_14_right1 - win6_13_right1;
               norm3_right <= win3_14_right1 - win6_13_right1;
               norm4_right <= win4_14_right1 - win6_13_right1;
               norm5_right <= win5_14_right1 - win6_13_right1;
               norm6_right <= win6_14_right1 - win6_13_right1;
               norm7_right <= win7_14_right1 - win6_13_right1;
               norm8_right <= win8_14_right1 - win6_13_right1;
               norm9_right <= win9_14_right1 - win6_13_right1;
               norm10_right <= win10_14_right1 - win6_13_right1;
               norm11_right <= win11_14_right1 - win6_13_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_15_right1 - win6_13_right1;
               norm2_right <= win2_15_right1 - win6_13_right1;
               norm3_right <= win3_15_right1 - win6_13_right1;
               norm4_right <= win4_15_right1 - win6_13_right1;
               norm5_right <= win5_15_right1 - win6_13_right1;
               norm6_right <= win6_15_right1 - win6_13_right1;
               norm7_right <= win7_15_right1 - win6_13_right1;
               norm8_right <= win8_15_right1 - win6_13_right1;
               norm9_right <= win9_15_right1 - win6_13_right1;
               norm10_right <= win10_15_right1 - win6_13_right1;
               norm11_right <= win11_15_right1 - win6_13_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_16_right1 - win6_13_right1;
               norm2_right <= win2_16_right1 - win6_13_right1;
               norm3_right <= win3_16_right1 - win6_13_right1;
               norm4_right <= win4_16_right1 - win6_13_right1;
               norm5_right <= win5_16_right1 - win6_13_right1;
               norm6_right <= win6_16_right1 - win6_13_right1;
               norm7_right <= win7_16_right1 - win6_13_right1;
               norm8_right <= win8_16_right1 - win6_13_right1;
               norm9_right <= win9_16_right1 - win6_13_right1;
               norm10_right <= win10_16_right1 - win6_13_right1;
               norm11_right <= win11_16_right1 - win6_13_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_17_right1 - win6_13_right1;
               norm2_right <= win2_17_right1 - win6_13_right1;
               norm3_right <= win3_17_right1 - win6_13_right1;
               norm4_right <= win4_17_right1 - win6_13_right1;
               norm5_right <= win5_17_right1 - win6_13_right1;
               norm6_right <= win6_17_right1 - win6_13_right1;
               norm7_right <= win7_17_right1 - win6_13_right1;
               norm8_right <= win8_17_right1 - win6_13_right1;
               norm9_right <= win9_17_right1 - win6_13_right1;
               norm10_right <= win10_17_right1 - win6_13_right1;
               norm11_right <= win11_17_right1 - win6_13_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_18_right1 - win6_13_right1;
               norm2_right <= win2_18_right1 - win6_13_right1;
               norm3_right <= win3_18_right1 - win6_13_right1;
               norm4_right <= win4_18_right1 - win6_13_right1;
               norm5_right <= win5_18_right1 - win6_13_right1;
               norm6_right <= win6_18_right1 - win6_13_right1;
               norm7_right <= win7_18_right1 - win6_13_right1;
               norm8_right <= win8_18_right1 - win6_13_right1;
               norm9_right <= win9_18_right1 - win6_13_right1;
               norm10_right <= win10_18_right1 - win6_13_right1;
               norm11_right <= win11_18_right1 - win6_13_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==9)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_9_right1 - win6_14_right1;
              norm2_right <= win2_9_right1 - win6_14_right1;
              norm3_right <= win3_9_right1 - win6_14_right1;
              norm4_right <= win4_9_right1 - win6_14_right1;
              norm5_right <= win5_9_right1 - win6_14_right1;
              norm6_right <= win6_9_right1 - win6_14_right1;
              norm7_right <= win7_9_right1 - win6_14_right1;
              norm8_right <= win8_9_right1 - win6_14_right1;
              norm9_right <= win9_9_right1 - win6_14_right1;
              norm10_right <= win10_9_right1 - win6_14_right1;
              norm11_right <= win11_9_right1 - win6_14_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_10_right1 - win6_14_right1;
               norm2_right <= win2_10_right1 - win6_14_right1;
               norm3_right <= win3_10_right1 - win6_14_right1;
               norm4_right <= win4_10_right1 - win6_14_right1;
               norm5_right <= win5_10_right1 - win6_14_right1;
               norm6_right <= win6_10_right1 - win6_14_right1;
               norm7_right <= win7_10_right1 - win6_14_right1;
               norm8_right <= win8_10_right1 - win6_14_right1;
               norm9_right <= win9_10_right1 - win6_14_right1;
               norm10_right <= win10_10_right1 - win6_14_right1;
               norm11_right <= win11_10_right1 - win6_14_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_11_right1 - win6_14_right1;
               norm2_right <= win2_11_right1 - win6_14_right1;
               norm3_right <= win3_11_right1 - win6_14_right1;
               norm4_right <= win4_11_right1 - win6_14_right1;
               norm5_right <= win5_11_right1 - win6_14_right1;
               norm6_right <= win6_11_right1 - win6_14_right1;
               norm7_right <= win7_11_right1 - win6_14_right1;
               norm8_right <= win8_11_right1 - win6_14_right1;
               norm9_right <= win9_11_right1 - win6_14_right1;
               norm10_right <= win10_11_right1 - win6_14_right1;
               norm11_right <= win11_11_right1 - win6_14_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_12_right1 - win6_14_right1;
               norm2_right <= win2_12_right1 - win6_14_right1;
               norm3_right <= win3_12_right1 - win6_14_right1;
               norm4_right <= win4_12_right1 - win6_14_right1;
               norm5_right <= win5_12_right1 - win6_14_right1;
               norm6_right <= win6_12_right1 - win6_14_right1;
               norm7_right <= win7_12_right1 - win6_14_right1;
               norm8_right <= win8_12_right1 - win6_14_right1;
               norm9_right <= win9_12_right1 - win6_14_right1;
               norm10_right <= win10_12_right1 - win6_14_right1;
               norm11_right <= win11_12_right1 - win6_14_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_13_right1 - win6_14_right1;
               norm2_right <= win2_13_right1 - win6_14_right1;
               norm3_right <= win3_13_right1 - win6_14_right1;
               norm4_right <= win4_13_right1 - win6_14_right1;
               norm5_right <= win5_13_right1 - win6_14_right1;
               norm6_right <= win6_13_right1 - win6_14_right1;
               norm7_right <= win7_13_right1 - win6_14_right1;
               norm8_right <= win8_13_right1 - win6_14_right1;
               norm9_right <= win9_13_right1 - win6_14_right1;
               norm10_right <= win10_13_right1 - win6_14_right1;
               norm11_right <= win11_13_right1 - win6_14_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_14_right1 - win6_14_right1;
               norm2_right <= win2_14_right1 - win6_14_right1;
               norm3_right <= win3_14_right1 - win6_14_right1;
               norm4_right <= win4_14_right1 - win6_14_right1;
               norm5_right <= win5_14_right1 - win6_14_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_14_right1 - win6_14_right1;
               norm8_right <= win8_14_right1 - win6_14_right1;
               norm9_right <= win9_14_right1 - win6_14_right1;
               norm10_right <= win10_14_right1 - win6_14_right1;
               norm11_right <= win11_14_right1 - win6_14_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_15_right1 - win6_14_right1;
               norm2_right <= win2_15_right1 - win6_14_right1;
               norm3_right <= win3_15_right1 - win6_14_right1;
               norm4_right <= win4_15_right1 - win6_14_right1;
               norm5_right <= win5_15_right1 - win6_14_right1;
               norm6_right <= win6_15_right1 - win6_14_right1;
               norm7_right <= win7_15_right1 - win6_14_right1;
               norm8_right <= win8_15_right1 - win6_14_right1;
               norm9_right <= win9_15_right1 - win6_14_right1;
               norm10_right <= win10_15_right1 - win6_14_right1;
               norm11_right <= win11_15_right1 - win6_14_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_16_right1 - win6_14_right1;
               norm2_right <= win2_16_right1 - win6_14_right1;
               norm3_right <= win3_16_right1 - win6_14_right1;
               norm4_right <= win4_16_right1 - win6_14_right1;
               norm5_right <= win5_16_right1 - win6_14_right1;
               norm6_right <= win6_16_right1 - win6_14_right1;
               norm7_right <= win7_16_right1 - win6_14_right1;
               norm8_right <= win8_16_right1 - win6_14_right1;
               norm9_right <= win9_16_right1 - win6_14_right1;
               norm10_right <= win10_16_right1 - win6_14_right1;
               norm11_right <= win11_16_right1 - win6_14_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_17_right1 - win6_14_right1;
               norm2_right <= win2_17_right1 - win6_14_right1;
               norm3_right <= win3_17_right1 - win6_14_right1;
               norm4_right <= win4_17_right1 - win6_14_right1;
               norm5_right <= win5_17_right1 - win6_14_right1;
               norm6_right <= win6_17_right1 - win6_14_right1;
               norm7_right <= win7_17_right1 - win6_14_right1;
               norm8_right <= win8_17_right1 - win6_14_right1;
               norm9_right <= win9_17_right1 - win6_14_right1;
               norm10_right <= win10_17_right1 - win6_14_right1;
               norm11_right <= win11_17_right1 - win6_14_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_18_right1 - win6_14_right1;
               norm2_right <= win2_18_right1 - win6_14_right1;
               norm3_right <= win3_18_right1 - win6_14_right1;
               norm4_right <= win4_18_right1 - win6_14_right1;
               norm5_right <= win5_18_right1 - win6_14_right1;
               norm6_right <= win6_18_right1 - win6_14_right1;
               norm7_right <= win7_18_right1 - win6_14_right1;
               norm8_right <= win8_18_right1 - win6_14_right1;
               norm9_right <= win9_18_right1 - win6_14_right1;
               norm10_right <= win10_18_right1 - win6_14_right1;
               norm11_right <= win11_18_right1 - win6_14_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_19_right1 - win6_14_right1;
               norm2_right <= win2_19_right1 - win6_14_right1;
               norm3_right <= win3_19_right1 - win6_14_right1;
               norm4_right <= win4_19_right1 - win6_14_right1;
               norm5_right <= win5_19_right1 - win6_14_right1;
               norm6_right <= win6_19_right1 - win6_14_right1;
               norm7_right <= win7_19_right1 - win6_14_right1;
               norm8_right <= win8_19_right1 - win6_14_right1;
               norm9_right <= win9_19_right1 - win6_14_right1;
               norm10_right <= win10_19_right1 - win6_14_right1;
               norm11_right <= win11_19_right1 - win6_14_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==10)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_10_right1 - win6_15_right1;
              norm2_right <= win2_10_right1 - win6_15_right1;
              norm3_right <= win3_10_right1 - win6_15_right1;
              norm4_right <= win4_10_right1 - win6_15_right1;
              norm5_right <= win5_10_right1 - win6_15_right1;
              norm6_right <= win6_10_right1 - win6_15_right1;
              norm7_right <= win7_10_right1 - win6_15_right1;
              norm8_right <= win8_10_right1 - win6_15_right1;
              norm9_right <= win9_10_right1 - win6_15_right1;
              norm10_right <= win10_10_right1 - win6_15_right1;
              norm11_right <= win11_10_right1 - win6_15_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_11_right1 - win6_15_right1;
               norm2_right <= win2_11_right1 - win6_15_right1;
               norm3_right <= win3_11_right1 - win6_15_right1;
               norm4_right <= win4_11_right1 - win6_15_right1;
               norm5_right <= win5_11_right1 - win6_15_right1;
               norm6_right <= win6_11_right1 - win6_15_right1;
               norm7_right <= win7_11_right1 - win6_15_right1;
               norm8_right <= win8_11_right1 - win6_15_right1;
               norm9_right <= win9_11_right1 - win6_15_right1;
               norm10_right <= win10_11_right1 - win6_15_right1;
               norm11_right <= win11_11_right1 - win6_15_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_12_right1 - win6_15_right1;
               norm2_right <= win2_12_right1 - win6_15_right1;
               norm3_right <= win3_12_right1 - win6_15_right1;
               norm4_right <= win4_12_right1 - win6_15_right1;
               norm5_right <= win5_12_right1 - win6_15_right1;
               norm6_right <= win6_12_right1 - win6_15_right1;
               norm7_right <= win7_12_right1 - win6_15_right1;
               norm8_right <= win8_12_right1 - win6_15_right1;
               norm9_right <= win9_12_right1 - win6_15_right1;
               norm10_right <= win10_12_right1 - win6_15_right1;
               norm11_right <= win11_12_right1 - win6_15_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_13_right1 - win6_15_right1;
               norm2_right <= win2_13_right1 - win6_15_right1;
               norm3_right <= win3_13_right1 - win6_15_right1;
               norm4_right <= win4_13_right1 - win6_15_right1;
               norm5_right <= win5_13_right1 - win6_15_right1;
               norm6_right <= win6_13_right1 - win6_15_right1;
               norm7_right <= win7_13_right1 - win6_15_right1;
               norm8_right <= win8_13_right1 - win6_15_right1;
               norm9_right <= win9_13_right1 - win6_15_right1;
               norm10_right <= win10_13_right1 - win6_15_right1;
               norm11_right <= win11_13_right1 - win6_15_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_14_right1 - win6_15_right1;
               norm2_right <= win2_14_right1 - win6_15_right1;
               norm3_right <= win3_14_right1 - win6_15_right1;
               norm4_right <= win4_14_right1 - win6_15_right1;
               norm5_right <= win5_14_right1 - win6_15_right1;
               norm6_right <= win6_14_right1 - win6_15_right1;
               norm7_right <= win7_14_right1 - win6_15_right1;
               norm8_right <= win8_14_right1 - win6_15_right1;
               norm9_right <= win9_14_right1 - win6_15_right1;
               norm10_right <= win10_14_right1 - win6_15_right1;
               norm11_right <= win11_14_right1 - win6_15_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_15_right1 - win6_15_right1;
               norm2_right <= win2_15_right1 - win6_15_right1;
               norm3_right <= win3_15_right1 - win6_15_right1;
               norm4_right <= win4_15_right1 - win6_15_right1;
               norm5_right <= win5_15_right1 - win6_15_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_15_right1 - win6_15_right1;
               norm8_right <= win8_15_right1 - win6_15_right1;
               norm9_right <= win9_15_right1 - win6_15_right1;
               norm10_right <= win10_15_right1 - win6_15_right1;
               norm11_right <= win11_15_right1 - win6_15_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_16_right1 - win6_15_right1;
               norm2_right <= win2_16_right1 - win6_15_right1;
               norm3_right <= win3_16_right1 - win6_15_right1;
               norm4_right <= win4_16_right1 - win6_15_right1;
               norm5_right <= win5_16_right1 - win6_15_right1;
               norm6_right <= win6_16_right1 - win6_15_right1;
               norm7_right <= win7_16_right1 - win6_15_right1;
               norm8_right <= win8_16_right1 - win6_15_right1;
               norm9_right <= win9_16_right1 - win6_15_right1;
               norm10_right <= win10_16_right1 - win6_15_right1;
               norm11_right <= win11_16_right1 - win6_15_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_17_right1 - win6_15_right1;
               norm2_right <= win2_17_right1 - win6_15_right1;
               norm3_right <= win3_17_right1 - win6_15_right1;
               norm4_right <= win4_17_right1 - win6_15_right1;
               norm5_right <= win5_17_right1 - win6_15_right1;
               norm6_right <= win6_17_right1 - win6_15_right1;
               norm7_right <= win7_17_right1 - win6_15_right1;
               norm8_right <= win8_17_right1 - win6_15_right1;
               norm9_right <= win9_17_right1 - win6_15_right1;
               norm10_right <= win10_17_right1 - win6_15_right1;
               norm11_right <= win11_17_right1 - win6_15_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_18_right1 - win6_15_right1;
               norm2_right <= win2_18_right1 - win6_15_right1;
               norm3_right <= win3_18_right1 - win6_15_right1;
               norm4_right <= win4_18_right1 - win6_15_right1;
               norm5_right <= win5_18_right1 - win6_15_right1;
               norm6_right <= win6_18_right1 - win6_15_right1;
               norm7_right <= win7_18_right1 - win6_15_right1;
               norm8_right <= win8_18_right1 - win6_15_right1;
               norm9_right <= win9_18_right1 - win6_15_right1;
               norm10_right <= win10_18_right1 - win6_15_right1;
               norm11_right <= win11_18_right1 - win6_15_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_19_right1 - win6_15_right1;
               norm2_right <= win2_19_right1 - win6_15_right1;
               norm3_right <= win3_19_right1 - win6_15_right1;
               norm4_right <= win4_19_right1 - win6_15_right1;
               norm5_right <= win5_19_right1 - win6_15_right1;
               norm6_right <= win6_19_right1 - win6_15_right1;
               norm7_right <= win7_19_right1 - win6_15_right1;
               norm8_right <= win8_19_right1 - win6_15_right1;
               norm9_right <= win9_19_right1 - win6_15_right1;
               norm10_right <= win10_19_right1 - win6_15_right1;
               norm11_right <= win11_19_right1 - win6_15_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_20_right1 - win6_15_right1;
               norm2_right <= win2_20_right1 - win6_15_right1;
               norm3_right <= win3_20_right1 - win6_15_right1;
               norm4_right <= win4_20_right1 - win6_15_right1;
               norm5_right <= win5_20_right1 - win6_15_right1;
               norm6_right <= win6_20_right1 - win6_15_right1;
               norm7_right <= win7_20_right1 - win6_15_right1;
               norm8_right <= win8_20_right1 - win6_15_right1;
               norm9_right <= win9_20_right1 - win6_15_right1;
               norm10_right <= win10_20_right1 - win6_15_right1;
               norm11_right <= win11_20_right1 - win6_15_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==11)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_11_right1 - win6_16_right1;
              norm2_right <= win2_11_right1 - win6_16_right1;
              norm3_right <= win3_11_right1 - win6_16_right1;
              norm4_right <= win4_11_right1 - win6_16_right1;
              norm5_right <= win5_11_right1 - win6_16_right1;
              norm6_right <= win6_11_right1 - win6_16_right1;
              norm7_right <= win7_11_right1 - win6_16_right1;
              norm8_right <= win8_11_right1 - win6_16_right1;
              norm9_right <= win9_11_right1 - win6_16_right1;
              norm10_right <= win10_11_right1 - win6_16_right1;
              norm11_right <= win11_11_right1 - win6_16_right1;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_12_right1 - win6_16_right1;
               norm2_right <= win2_12_right1 - win6_16_right1;
               norm3_right <= win3_12_right1 - win6_16_right1;
               norm4_right <= win4_12_right1 - win6_16_right1;
               norm5_right <= win5_12_right1 - win6_16_right1;
               norm6_right <= win6_12_right1 - win6_16_right1;
               norm7_right <= win7_12_right1 - win6_16_right1;
               norm8_right <= win8_12_right1 - win6_16_right1;
               norm9_right <= win9_12_right1 - win6_16_right1;
               norm10_right <= win10_12_right1 - win6_16_right1;
               norm11_right <= win11_12_right1 - win6_16_right1;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_13_right1 - win6_16_right1;
               norm2_right <= win2_13_right1 - win6_16_right1;
               norm3_right <= win3_13_right1 - win6_16_right1;
               norm4_right <= win4_13_right1 - win6_16_right1;
               norm5_right <= win5_13_right1 - win6_16_right1;
               norm6_right <= win6_13_right1 - win6_16_right1;
               norm7_right <= win7_13_right1 - win6_16_right1;
               norm8_right <= win8_13_right1 - win6_16_right1;
               norm9_right <= win9_13_right1 - win6_16_right1;
               norm10_right <= win10_13_right1 - win6_16_right1;
               norm11_right <= win11_13_right1 - win6_16_right1;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_14_right1 - win6_16_right1;
               norm2_right <= win2_14_right1 - win6_16_right1;
               norm3_right <= win3_14_right1 - win6_16_right1;
               norm4_right <= win4_14_right1 - win6_16_right1;
               norm5_right <= win5_14_right1 - win6_16_right1;
               norm6_right <= win6_14_right1 - win6_16_right1;
               norm7_right <= win7_14_right1 - win6_16_right1;
               norm8_right <= win8_14_right1 - win6_16_right1;
               norm9_right <= win9_14_right1 - win6_16_right1;
               norm10_right <= win10_14_right1 - win6_16_right1;
               norm11_right <= win11_14_right1 - win6_16_right1;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_15_right1 - win6_16_right1;
               norm2_right <= win2_15_right1 - win6_16_right1;
               norm3_right <= win3_15_right1 - win6_16_right1;
               norm4_right <= win4_15_right1 - win6_16_right1;
               norm5_right <= win5_15_right1 - win6_16_right1;
               norm6_right <= win6_15_right1 - win6_16_right1;
               norm7_right <= win7_15_right1 - win6_16_right1;
               norm8_right <= win8_15_right1 - win6_16_right1;
               norm9_right <= win9_15_right1 - win6_16_right1;
               norm10_right <= win10_15_right1 - win6_16_right1;
               norm11_right <= win11_15_right1 - win6_16_right1;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_16_right1 - win6_16_right1;
               norm2_right <= win2_16_right1 - win6_16_right1;
               norm3_right <= win3_16_right1 - win6_16_right1;
               norm4_right <= win4_16_right1 - win6_16_right1;
               norm5_right <= win5_16_right1 - win6_16_right1;
               norm6_right <= 9'd0;
               norm7_right <= win7_16_right1 - win6_16_right1;
               norm8_right <= win8_16_right1 - win6_16_right1;
               norm9_right <= win9_16_right1 - win6_16_right1;
               norm10_right <= win10_16_right1 - win6_16_right1;
               norm11_right <= win11_16_right1 - win6_16_right1;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_17_right1 - win6_16_right1;
               norm2_right <= win2_17_right1 - win6_16_right1;
               norm3_right <= win3_17_right1 - win6_16_right1;
               norm4_right <= win4_17_right1 - win6_16_right1;
               norm5_right <= win5_17_right1 - win6_16_right1;
               norm6_right <= win6_17_right1 - win6_16_right1;
               norm7_right <= win7_17_right1 - win6_16_right1;
               norm8_right <= win8_17_right1 - win6_16_right1;
               norm9_right <= win9_17_right1 - win6_16_right1;
               norm10_right <= win10_17_right1 - win6_16_right1;
               norm11_right <= win11_17_right1 - win6_16_right1;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_18_right1 - win6_16_right1;
               norm2_right <= win2_18_right1 - win6_16_right1;
               norm3_right <= win3_18_right1 - win6_16_right1;
               norm4_right <= win4_18_right1 - win6_16_right1;
               norm5_right <= win5_18_right1 - win6_16_right1;
               norm6_right <= win6_18_right1 - win6_16_right1;
               norm7_right <= win7_18_right1 - win6_16_right1;
               norm8_right <= win8_18_right1 - win6_16_right1;
               norm9_right <= win9_18_right1 - win6_16_right1;
               norm10_right <= win10_18_right1 - win6_16_right1;
               norm11_right <= win11_18_right1 - win6_16_right1;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_19_right1 - win6_16_right1;
               norm2_right <= win2_19_right1 - win6_16_right1;
               norm3_right <= win3_19_right1 - win6_16_right1;
               norm4_right <= win4_19_right1 - win6_16_right1;
               norm5_right <= win5_19_right1 - win6_16_right1;
               norm6_right <= win6_19_right1 - win6_16_right1;
               norm7_right <= win7_19_right1 - win6_16_right1;
               norm8_right <= win8_19_right1 - win6_16_right1;
               norm9_right <= win9_19_right1 - win6_16_right1;
               norm10_right <= win10_19_right1 - win6_16_right1;
               norm11_right <= win11_19_right1 - win6_16_right1;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_20_right1 - win6_16_right1;
               norm2_right <= win2_20_right1 - win6_16_right1;
               norm3_right <= win3_20_right1 - win6_16_right1;
               norm4_right <= win4_20_right1 - win6_16_right1;
               norm5_right <= win5_20_right1 - win6_16_right1;
               norm6_right <= win6_20_right1 - win6_16_right1;
               norm7_right <= win7_20_right1 - win6_16_right1;
               norm8_right <= win8_20_right1 - win6_16_right1;
               norm9_right <= win9_20_right1 - win6_16_right1;
               norm10_right <= win10_20_right1 - win6_16_right1;
               norm11_right <= win11_20_right1 - win6_16_right1;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_21_right1 - win6_16_right1;
               norm2_right <= win2_21_right1 - win6_16_right1;
               norm3_right <= win3_21_right1 - win6_16_right1;
               norm4_right <= win4_21_right1 - win6_16_right1;
               norm5_right <= win5_21_right1 - win6_16_right1;
               norm6_right <= win6_21_right1 - win6_16_right1;
               norm7_right <= win7_21_right1 - win6_16_right1;
               norm8_right <= win8_21_right1 - win6_16_right1;
               norm9_right <= win9_21_right1 - win6_16_right1;
               norm10_right <= win10_21_right1 - win6_16_right1;
               norm11_right <= win11_21_right1 - win6_16_right1;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
    end
  else if(XYOXYO_tc_tp5[23:22]==2'b10)
    begin
      if(count_windows==1)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_1_right2 - win6_6_right2;
              norm2_right <= win2_1_right2 - win6_6_right2;
              norm3_right <= win3_1_right2 - win6_6_right2;
              norm4_right <= win4_1_right2 - win6_6_right2;
              norm5_right <= win5_1_right2 - win6_6_right2;
              norm6_right <= win6_1_right2 - win6_6_right2;
              norm7_right <= win7_1_right2 - win6_6_right2;
              norm8_right <= win8_1_right2 - win6_6_right2;
              norm9_right <= win9_1_right2 - win6_6_right2;
              norm10_right <= win10_1_right2 - win6_6_right2;
              norm11_right <= win11_1_right2 - win6_6_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_2_right2 - win6_6_right2;
               norm2_right <= win2_2_right2 - win6_6_right2;
               norm3_right <= win3_2_right2 - win6_6_right2;
               norm4_right <= win4_2_right2 - win6_6_right2;
               norm5_right <= win5_2_right2 - win6_6_right2;
               norm6_right <= win6_2_right2 - win6_6_right2;
               norm7_right <= win7_2_right2 - win6_6_right2;
               norm8_right <= win8_2_right2 - win6_6_right2;
               norm9_right <= win9_2_right2 - win6_6_right2;
               norm10_right <= win10_2_right2 - win6_6_right2;
               norm11_right <= win11_2_right2 - win6_6_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_3_right2 - win6_6_right2;
               norm2_right <= win2_3_right2 - win6_6_right2;
               norm3_right <= win3_3_right2 - win6_6_right2;
               norm4_right <= win4_3_right2 - win6_6_right2;
               norm5_right <= win5_3_right2 - win6_6_right2;
               norm6_right <= win6_3_right2 - win6_6_right2;
               norm7_right <= win7_3_right2 - win6_6_right2;
               norm8_right <= win8_3_right2 - win6_6_right2;
               norm9_right <= win9_3_right2 - win6_6_right2;
               norm10_right <= win10_3_right2 - win6_6_right2;
               norm11_right <= win11_3_right2 - win6_6_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_4_right2 - win6_6_right2;
               norm2_right <= win2_4_right2 - win6_6_right2;
               norm3_right <= win3_4_right2 - win6_6_right2;
               norm4_right <= win4_4_right2 - win6_6_right2;
               norm5_right <= win5_4_right2 - win6_6_right2;
               norm6_right <= win6_4_right2 - win6_6_right2;
               norm7_right <= win7_4_right2 - win6_6_right2;
               norm8_right <= win8_4_right2 - win6_6_right2;
               norm9_right <= win9_4_right2 - win6_6_right2;
               norm10_right <= win10_4_right2 - win6_6_right2;
               norm11_right <= win11_4_right2 - win6_6_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_5_right2 - win6_6_right2;
               norm2_right <= win2_5_right2 - win6_6_right2;
               norm3_right <= win3_5_right2 - win6_6_right2;
               norm4_right <= win4_5_right2 - win6_6_right2;
               norm5_right <= win5_5_right2 - win6_6_right2;
               norm6_right <= win6_5_right2 - win6_6_right2;
               norm7_right <= win7_5_right2 - win6_6_right2;
               norm8_right <= win8_5_right2 - win6_6_right2;
               norm9_right <= win9_5_right2 - win6_6_right2;
               norm10_right <= win10_5_right2 - win6_6_right2;
               norm11_right <= win11_5_right2 - win6_6_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_6_right2 - win6_6_right2;
               norm2_right <= win2_6_right2 - win6_6_right2;
               norm3_right <= win3_6_right2 - win6_6_right2;
               norm4_right <= win4_6_right2 - win6_6_right2;
               norm5_right <= win5_6_right2 - win6_6_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_6_right2 - win6_6_right2;
               norm8_right <= win8_6_right2 - win6_6_right2;
               norm9_right <= win9_6_right2 - win6_6_right2;
               norm10_right <= win10_6_right2 - win6_6_right2;
               norm11_right <= win11_6_right2 - win6_6_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_7_right2 - win6_6_right2;
               norm2_right <= win2_7_right2 - win6_6_right2;
               norm3_right <= win3_7_right2 - win6_6_right2;
               norm4_right <= win4_7_right2 - win6_6_right2;
               norm5_right <= win5_7_right2 - win6_6_right2;
               norm6_right <= win6_7_right2 - win6_6_right2;
               norm7_right <= win7_7_right2 - win6_6_right2;
               norm8_right <= win8_7_right2 - win6_6_right2;
               norm9_right <= win9_7_right2 - win6_6_right2;
               norm10_right <= win10_7_right2 - win6_6_right2;
               norm11_right <= win11_7_right2 - win6_6_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_8_right2 - win6_6_right2;
               norm2_right <= win2_8_right2 - win6_6_right2;
               norm3_right <= win3_8_right2 - win6_6_right2;
               norm4_right <= win4_8_right2 - win6_6_right2;
               norm5_right <= win5_8_right2 - win6_6_right2;
               norm6_right <= win6_8_right2 - win6_6_right2;
               norm7_right <= win7_8_right2 - win6_6_right2;
               norm8_right <= win8_8_right2 - win6_6_right2;
               norm9_right <= win9_8_right2 - win6_6_right2;
               norm10_right <= win10_8_right2 - win6_6_right2;
               norm11_right <= win11_8_right2 - win6_6_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_9_right2 - win6_6_right2;
               norm2_right <= win2_9_right2 - win6_6_right2;
               norm3_right <= win3_9_right2 - win6_6_right2;
               norm4_right <= win4_9_right2 - win6_6_right2;
               norm5_right <= win5_9_right2 - win6_6_right2;
               norm6_right <= win6_9_right2 - win6_6_right2;
               norm7_right <= win7_9_right2 - win6_6_right2;
               norm8_right <= win8_9_right2 - win6_6_right2;
               norm9_right <= win9_9_right2 - win6_6_right2;
               norm10_right <= win10_9_right2 - win6_6_right2;
               norm11_right <= win11_9_right2 - win6_6_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_10_right2 - win6_6_right2;
               norm2_right <= win2_10_right2 - win6_6_right2;
               norm3_right <= win3_10_right2 - win6_6_right2;
               norm4_right <= win4_10_right2 - win6_6_right2;
               norm5_right <= win5_10_right2 - win6_6_right2;
               norm6_right <= win6_10_right2 - win6_6_right2;
               norm7_right <= win7_10_right2 - win6_6_right2;
               norm8_right <= win8_10_right2 - win6_6_right2;
               norm9_right <= win9_10_right2 - win6_6_right2;
               norm10_right <= win10_10_right2 - win6_6_right2;
               norm11_right <= win11_10_right2 - win6_6_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_11_right2 - win6_6_right2;
               norm2_right <= win2_11_right2 - win6_6_right2;
               norm3_right <= win3_11_right2 - win6_6_right2;
               norm4_right <= win4_11_right2 - win6_6_right2;
               norm5_right <= win5_11_right2 - win6_6_right2;
               norm6_right <= win6_11_right2 - win6_6_right2;
               norm7_right <= win7_11_right2 - win6_6_right2;
               norm8_right <= win8_11_right2 - win6_6_right2;
               norm9_right <= win9_11_right2 - win6_6_right2;
               norm10_right <= win10_11_right2 - win6_6_right2;
               norm11_right <= win11_11_right2 - win6_6_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==2)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_2_right2 - win6_7_right2;
              norm2_right <= win2_2_right2 - win6_7_right2;
              norm3_right <= win3_2_right2 - win6_7_right2;
              norm4_right <= win4_2_right2 - win6_7_right2;
              norm5_right <= win5_2_right2 - win6_7_right2;
              norm6_right <= win6_2_right2 - win6_7_right2;
              norm7_right <= win7_2_right2 - win6_7_right2;
              norm8_right <= win8_2_right2 - win6_7_right2;
              norm9_right <= win9_2_right2 - win6_7_right2;
              norm10_right <= win10_2_right2 - win6_7_right2;
              norm11_right <= win11_2_right2 - win6_7_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_3_right2 - win6_7_right2;
               norm2_right <= win2_3_right2 - win6_7_right2;
               norm3_right <= win3_3_right2 - win6_7_right2;
               norm4_right <= win4_3_right2 - win6_7_right2;
               norm5_right <= win5_3_right2 - win6_7_right2;
               norm6_right <= win6_3_right2 - win6_7_right2;
               norm7_right <= win7_3_right2 - win6_7_right2;
               norm8_right <= win8_3_right2 - win6_7_right2;
               norm9_right <= win9_3_right2 - win6_7_right2;
               norm10_right <= win10_3_right2 - win6_7_right2;
               norm11_right <= win11_3_right2 - win6_7_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_4_right2 - win6_7_right2;
               norm2_right <= win2_4_right2 - win6_7_right2;
               norm3_right <= win3_4_right2 - win6_7_right2;
               norm4_right <= win4_4_right2 - win6_7_right2;
               norm5_right <= win5_4_right2 - win6_7_right2;
               norm6_right <= win6_4_right2 - win6_7_right2;
               norm7_right <= win7_4_right2 - win6_7_right2;
               norm8_right <= win8_4_right2 - win6_7_right2;
               norm9_right <= win9_4_right2 - win6_7_right2;
               norm10_right <= win10_4_right2 - win6_7_right2;
               norm11_right <= win11_4_right2 - win6_7_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_5_right2 - win6_7_right2;
               norm2_right <= win2_5_right2 - win6_7_right2;
               norm3_right <= win3_5_right2 - win6_7_right2;
               norm4_right <= win4_5_right2 - win6_7_right2;
               norm5_right <= win5_5_right2 - win6_7_right2;
               norm6_right <= win6_5_right2 - win6_7_right2;
               norm7_right <= win7_5_right2 - win6_7_right2;
               norm8_right <= win8_5_right2 - win6_7_right2;
               norm9_right <= win9_5_right2 - win6_7_right2;
               norm10_right <= win10_5_right2 - win6_7_right2;
               norm11_right <= win11_5_right2 - win6_7_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_6_right2 - win6_7_right2;
               norm2_right <= win2_6_right2 - win6_7_right2;
               norm3_right <= win3_6_right2 - win6_7_right2;
               norm4_right <= win4_6_right2 - win6_7_right2;
               norm5_right <= win5_6_right2 - win6_7_right2;
               norm6_right <= win6_6_right2 - win6_7_right2;
               norm7_right <= win7_6_right2 - win6_7_right2;
               norm8_right <= win8_6_right2 - win6_7_right2;
               norm9_right <= win9_6_right2 - win6_7_right2;
               norm10_right <= win10_6_right2 - win6_7_right2;
               norm11_right <= win11_6_right2 - win6_7_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_7_right2 - win6_7_right2;
               norm2_right <= win2_7_right2 - win6_7_right2;
               norm3_right <= win3_7_right2 - win6_7_right2;
               norm4_right <= win4_7_right2 - win6_7_right2;
               norm5_right <= win5_7_right2 - win6_7_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_7_right2 - win6_7_right2;
               norm8_right <= win8_7_right2 - win6_7_right2;
               norm9_right <= win9_7_right2 - win6_7_right2;
               norm10_right <= win10_7_right2 - win6_7_right2;
               norm11_right <= win11_7_right2 - win6_7_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_8_right2 - win6_7_right2;
               norm2_right <= win2_8_right2 - win6_7_right2;
               norm3_right <= win3_8_right2 - win6_7_right2;
               norm4_right <= win4_8_right2 - win6_7_right2;
               norm5_right <= win5_8_right2 - win6_7_right2;
               norm6_right <= win6_8_right2 - win6_7_right2;
               norm7_right <= win7_8_right2 - win6_7_right2;
               norm8_right <= win8_8_right2 - win6_7_right2;
               norm9_right <= win9_8_right2 - win6_7_right2;
               norm10_right <= win10_8_right2 - win6_7_right2;
               norm11_right <= win11_8_right2 - win6_7_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_9_right2 - win6_7_right2;
               norm2_right <= win2_9_right2 - win6_7_right2;
               norm3_right <= win3_9_right2 - win6_7_right2;
               norm4_right <= win4_9_right2 - win6_7_right2;
               norm5_right <= win5_9_right2 - win6_7_right2;
               norm6_right <= win6_9_right2 - win6_7_right2;
               norm7_right <= win7_9_right2 - win6_7_right2;
               norm8_right <= win8_9_right2 - win6_7_right2;
               norm9_right <= win9_9_right2 - win6_7_right2;
               norm10_right <= win10_9_right2 - win6_7_right2;
               norm11_right <= win11_9_right2 - win6_7_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_10_right2 - win6_7_right2;
               norm2_right <= win2_10_right2 - win6_7_right2;
               norm3_right <= win3_10_right2 - win6_7_right2;
               norm4_right <= win4_10_right2 - win6_7_right2;
               norm5_right <= win5_10_right2 - win6_7_right2;
               norm6_right <= win6_10_right2 - win6_7_right2;
               norm7_right <= win7_10_right2 - win6_7_right2;
               norm8_right <= win8_10_right2 - win6_7_right2;
               norm9_right <= win9_10_right2 - win6_7_right2;
               norm10_right <= win10_10_right2 - win6_7_right2;
               norm11_right <= win11_10_right2 - win6_7_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_11_right2 - win6_7_right2;
               norm2_right <= win2_11_right2 - win6_7_right2;
               norm3_right <= win3_11_right2 - win6_7_right2;
               norm4_right <= win4_11_right2 - win6_7_right2;
               norm5_right <= win5_11_right2 - win6_7_right2;
               norm6_right <= win6_11_right2 - win6_7_right2;
               norm7_right <= win7_11_right2 - win6_7_right2;
               norm8_right <= win8_11_right2 - win6_7_right2;
               norm9_right <= win9_11_right2 - win6_7_right2;
               norm10_right <= win10_11_right2 - win6_7_right2;
               norm11_right <= win11_11_right2 - win6_7_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_12_right2 - win6_7_right2;
               norm2_right <= win2_12_right2 - win6_7_right2;
               norm3_right <= win3_12_right2 - win6_7_right2;
               norm4_right <= win4_12_right2 - win6_7_right2;
               norm5_right <= win5_12_right2 - win6_7_right2;
               norm6_right <= win6_12_right2 - win6_7_right2;
               norm7_right <= win7_12_right2 - win6_7_right2;
               norm8_right <= win8_12_right2 - win6_7_right2;
               norm9_right <= win9_12_right2 - win6_7_right2;
               norm10_right <= win10_12_right2 - win6_7_right2;
               norm11_right <= win11_12_right2 - win6_7_right2;
             end
          else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==3)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_3_right2 - win6_8_right2;
              norm2_right <= win2_3_right2 - win6_8_right2;
              norm3_right <= win3_3_right2 - win6_8_right2;
              norm4_right <= win4_3_right2 - win6_8_right2;
              norm5_right <= win5_3_right2 - win6_8_right2;
              norm6_right <= win6_3_right2 - win6_8_right2;
              norm7_right <= win7_3_right2 - win6_8_right2;
              norm8_right <= win8_3_right2 - win6_8_right2;
              norm9_right <= win9_3_right2 - win6_8_right2;
              norm10_right <= win10_3_right2 - win6_8_right2;
              norm11_right <= win11_3_right2 - win6_8_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_4_right2 - win6_8_right2;
               norm2_right <= win2_4_right2 - win6_8_right2;
               norm3_right <= win3_4_right2 - win6_8_right2;
               norm4_right <= win4_4_right2 - win6_8_right2;
               norm5_right <= win5_4_right2 - win6_8_right2;
               norm6_right <= win6_4_right2 - win6_8_right2;
               norm7_right <= win7_4_right2 - win6_8_right2;
               norm8_right <= win8_4_right2 - win6_8_right2;
               norm9_right <= win9_4_right2 - win6_8_right2;
               norm10_right <= win10_4_right2 - win6_8_right2;
               norm11_right <= win11_4_right2 - win6_8_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_5_right2 - win6_8_right2;
               norm2_right <= win2_5_right2 - win6_8_right2;
               norm3_right <= win3_5_right2 - win6_8_right2;
               norm4_right <= win4_5_right2 - win6_8_right2;
               norm5_right <= win5_5_right2 - win6_8_right2;
               norm6_right <= win6_5_right2 - win6_8_right2;
               norm7_right <= win7_5_right2 - win6_8_right2;
               norm8_right <= win8_5_right2 - win6_8_right2;
               norm9_right <= win9_5_right2 - win6_8_right2;
               norm10_right <= win10_5_right2 - win6_8_right2;
               norm11_right <= win11_5_right2 - win6_8_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_6_right2 - win6_8_right2;
               norm2_right <= win2_6_right2 - win6_8_right2;
               norm3_right <= win3_6_right2 - win6_8_right2;
               norm4_right <= win4_6_right2 - win6_8_right2;
               norm5_right <= win5_6_right2 - win6_8_right2;
               norm6_right <= win6_6_right2 - win6_8_right2;
               norm7_right <= win7_6_right2 - win6_8_right2;
               norm8_right <= win8_6_right2 - win6_8_right2;
               norm9_right <= win9_6_right2 - win6_8_right2;
               norm10_right <= win10_6_right2 - win6_8_right2;
               norm11_right <= win11_6_right2 - win6_8_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_7_right2 - win6_8_right2;
               norm2_right <= win2_7_right2 - win6_8_right2;
               norm3_right <= win3_7_right2 - win6_8_right2;
               norm4_right <= win4_7_right2 - win6_8_right2;
               norm5_right <= win5_7_right2 - win6_8_right2;
               norm6_right <= win6_7_right2 - win6_8_right2;
               norm7_right <= win7_7_right2 - win6_8_right2;
               norm8_right <= win8_7_right2 - win6_8_right2;
               norm9_right <= win9_7_right2 - win6_8_right2;
               norm10_right <= win10_7_right2 - win6_8_right2;
               norm11_right <= win11_7_right2 - win6_8_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_8_right2 - win6_8_right2;
               norm2_right <= win2_8_right2 - win6_8_right2;
               norm3_right <= win3_8_right2 - win6_8_right2;
               norm4_right <= win4_8_right2 - win6_8_right2;
               norm5_right <= win5_8_right2 - win6_8_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_8_right2 - win6_8_right2;
               norm8_right <= win8_8_right2 - win6_8_right2;
               norm9_right <= win9_8_right2 - win6_8_right2;
               norm10_right <= win10_8_right2 - win6_8_right2;
               norm11_right <= win11_8_right2 - win6_8_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_9_right2 - win6_8_right2;
               norm2_right <= win2_9_right2 - win6_8_right2;
               norm3_right <= win3_9_right2 - win6_8_right2;
               norm4_right <= win4_9_right2 - win6_8_right2;
               norm5_right <= win5_9_right2 - win6_8_right2;
               norm6_right <= win6_9_right2 - win6_8_right2;
               norm7_right <= win7_9_right2 - win6_8_right2;
               norm8_right <= win8_9_right2 - win6_8_right2;
               norm9_right <= win9_9_right2 - win6_8_right2;
               norm10_right <= win10_9_right2 - win6_8_right2;
               norm11_right <= win11_9_right2 - win6_8_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_10_right2 - win6_8_right2;
               norm2_right <= win2_10_right2 - win6_8_right2;
               norm3_right <= win3_10_right2 - win6_8_right2;
               norm4_right <= win4_10_right2 - win6_8_right2;
               norm5_right <= win5_10_right2 - win6_8_right2;
               norm6_right <= win6_10_right2 - win6_8_right2;
               norm7_right <= win7_10_right2 - win6_8_right2;
               norm8_right <= win8_10_right2 - win6_8_right2;
               norm9_right <= win9_10_right2 - win6_8_right2;
               norm10_right <= win10_10_right2 - win6_8_right2;
               norm11_right <= win11_10_right2 - win6_8_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_11_right2 - win6_8_right2;
               norm2_right <= win2_11_right2 - win6_8_right2;
               norm3_right <= win3_11_right2 - win6_8_right2;
               norm4_right <= win4_11_right2 - win6_8_right2;
               norm5_right <= win5_11_right2 - win6_8_right2;
               norm6_right <= win6_11_right2 - win6_8_right2;
               norm7_right <= win7_11_right2 - win6_8_right2;
               norm8_right <= win8_11_right2 - win6_8_right2;
               norm9_right <= win9_11_right2 - win6_8_right2;
               norm10_right <= win10_11_right2 - win6_8_right2;
               norm11_right <= win11_11_right2 - win6_8_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_12_right2 - win6_8_right2;
               norm2_right <= win2_12_right2 - win6_8_right2;
               norm3_right <= win3_12_right2 - win6_8_right2;
               norm4_right <= win4_12_right2 - win6_8_right2;
               norm5_right <= win5_12_right2 - win6_8_right2;
               norm6_right <= win6_12_right2 - win6_8_right2;
               norm7_right <= win7_12_right2 - win6_8_right2;
               norm8_right <= win8_12_right2 - win6_8_right2;
               norm9_right <= win9_12_right2 - win6_8_right2;
               norm10_right <= win10_12_right2 - win6_8_right2;
               norm11_right <= win11_12_right2 - win6_8_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_13_right2 - win6_8_right2;
               norm2_right <= win2_13_right2 - win6_8_right2;
               norm3_right <= win3_13_right2 - win6_8_right2;
               norm4_right <= win4_13_right2 - win6_8_right2;
               norm5_right <= win5_13_right2 - win6_8_right2;
               norm6_right <= win6_13_right2 - win6_8_right2;
               norm7_right <= win7_13_right2 - win6_8_right2;
               norm8_right <= win8_13_right2 - win6_8_right2;
               norm9_right <= win9_13_right2 - win6_8_right2;
               norm10_right <= win10_13_right2 - win6_8_right2;
               norm11_right <= win11_13_right2 - win6_8_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==4)
        begin
           if(count_cols==1)
            begin
              norm1_right <= win1_4_right2 - win6_9_right2;
              norm2_right <= win2_4_right2 - win6_9_right2;
              norm3_right <= win3_4_right2 - win6_9_right2;
              norm4_right <= win4_4_right2 - win6_9_right2;
              norm5_right <= win5_4_right2 - win6_9_right2;
              norm6_right <= win6_4_right2 - win6_9_right2;
              norm7_right <= win7_4_right2 - win6_9_right2;
              norm8_right <= win8_4_right2 - win6_9_right2;
              norm9_right <= win9_4_right2 - win6_9_right2;
              norm10_right <= win10_4_right2 - win6_9_right2;
              norm11_right <= win11_4_right2 - win6_9_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_5_right2 - win6_9_right2;
               norm2_right <= win2_5_right2 - win6_9_right2;
               norm3_right <= win3_5_right2 - win6_9_right2;
               norm4_right <= win4_5_right2 - win6_9_right2;
               norm5_right <= win5_5_right2 - win6_9_right2;
               norm6_right <= win6_5_right2 - win6_9_right2;
               norm7_right <= win7_5_right2 - win6_9_right2;
               norm8_right <= win8_5_right2 - win6_9_right2;
               norm9_right <= win9_5_right2 - win6_9_right2;
               norm10_right <= win10_5_right2 - win6_9_right2;
               norm11_right <= win11_5_right2 - win6_9_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_6_right2 - win6_9_right2;
               norm2_right <= win2_6_right2 - win6_9_right2;
               norm3_right <= win3_6_right2 - win6_9_right2;
               norm4_right <= win4_6_right2 - win6_9_right2;
               norm5_right <= win5_6_right2 - win6_9_right2;
               norm6_right <= win6_6_right2 - win6_9_right2;
               norm7_right <= win7_6_right2 - win6_9_right2;
               norm8_right <= win8_6_right2 - win6_9_right2;
               norm9_right <= win9_6_right2 - win6_9_right2;
               norm10_right <= win10_6_right2 - win6_9_right2;
               norm11_right <= win11_6_right2 - win6_9_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_7_right2 - win6_9_right2;
               norm2_right <= win2_7_right2 - win6_9_right2;
               norm3_right <= win3_7_right2 - win6_9_right2;
               norm4_right <= win4_7_right2 - win6_9_right2;
               norm5_right <= win5_7_right2 - win6_9_right2;
               norm6_right <= win6_7_right2 - win6_9_right2;
               norm7_right <= win7_7_right2 - win6_9_right2;
               norm8_right <= win8_7_right2 - win6_9_right2;
               norm9_right <= win9_7_right2 - win6_9_right2;
               norm10_right <= win10_7_right2 - win6_9_right2;
               norm11_right <= win11_7_right2 - win6_9_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_8_right2 - win6_9_right2;
               norm2_right <= win2_8_right2 - win6_9_right2;
               norm3_right <= win3_8_right2 - win6_9_right2;
               norm4_right <= win4_8_right2 - win6_9_right2;
               norm5_right <= win5_8_right2 - win6_9_right2;
               norm6_right <= win6_8_right2 - win6_9_right2;
               norm7_right <= win7_8_right2 - win6_9_right2;
               norm8_right <= win8_8_right2 - win6_9_right2;
               norm9_right <= win9_8_right2 - win6_9_right2;
               norm10_right <= win10_8_right2 - win6_9_right2;
               norm11_right <= win11_8_right2 - win6_9_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_9_right2 - win6_9_right2;
               norm2_right <= win2_9_right2 - win6_9_right2;
               norm3_right <= win3_9_right2 - win6_9_right2;
               norm4_right <= win4_9_right2 - win6_9_right2;
               norm5_right <= win5_9_right2 - win6_9_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_9_right2 - win6_9_right2;
               norm8_right <= win8_9_right2 - win6_9_right2;
               norm9_right <= win9_9_right2 - win6_9_right2;
               norm10_right <= win10_9_right2 - win6_9_right2;
               norm11_right <= win11_9_right2 - win6_9_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_10_right2 - win6_9_right2;
               norm2_right <= win2_10_right2 - win6_9_right2;
               norm3_right <= win3_10_right2 - win6_9_right2;
               norm4_right <= win4_10_right2 - win6_9_right2;
               norm5_right <= win5_10_right2 - win6_9_right2;
               norm6_right <= win6_10_right2 - win6_9_right2;
               norm7_right <= win7_10_right2 - win6_9_right2;
               norm8_right <= win8_10_right2 - win6_9_right2;
               norm9_right <= win9_10_right2 - win6_9_right2;
               norm10_right <= win10_10_right2 - win6_9_right2;
               norm11_right <= win11_10_right2 - win6_9_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_11_right2 - win6_9_right2;
               norm2_right <= win2_11_right2 - win6_9_right2;
               norm3_right <= win3_11_right2 - win6_9_right2;
               norm4_right <= win4_11_right2 - win6_9_right2;
               norm5_right <= win5_11_right2 - win6_9_right2;
               norm6_right <= win6_11_right2 - win6_9_right2;
               norm7_right <= win7_11_right2 - win6_9_right2;
               norm8_right <= win8_11_right2 - win6_9_right2;
               norm9_right <= win9_11_right2 - win6_9_right2;
               norm10_right <= win10_11_right2 - win6_9_right2;
               norm11_right <= win11_11_right2 - win6_9_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_12_right2 - win6_9_right2;
               norm2_right <= win2_12_right2 - win6_9_right2;
               norm3_right <= win3_12_right2 - win6_9_right2;
               norm4_right <= win4_12_right2 - win6_9_right2;
               norm5_right <= win5_12_right2 - win6_9_right2;
               norm6_right <= win6_12_right2 - win6_9_right2;
               norm7_right <= win7_12_right2 - win6_9_right2;
               norm8_right <= win8_12_right2 - win6_9_right2;
               norm9_right <= win9_12_right2 - win6_9_right2;
               norm10_right <= win10_12_right2 - win6_9_right2;
               norm11_right <= win11_12_right2 - win6_9_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_13_right2 - win6_9_right2;
               norm2_right <= win2_13_right2 - win6_9_right2;
               norm3_right <= win3_13_right2 - win6_9_right2;
               norm4_right <= win4_13_right2 - win6_9_right2;
               norm5_right <= win5_13_right2 - win6_9_right2;
               norm6_right <= win6_13_right2 - win6_9_right2;
               norm7_right <= win7_13_right2 - win6_9_right2;
               norm8_right <= win8_13_right2 - win6_9_right2;
               norm9_right <= win9_13_right2 - win6_9_right2;
               norm10_right <= win10_13_right2 - win6_9_right2;
               norm11_right <= win11_13_right2 - win6_9_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_14_right2 - win6_9_right2;
               norm2_right <= win2_14_right2 - win6_9_right2;
               norm3_right <= win3_14_right2 - win6_9_right2;
               norm4_right <= win4_14_right2 - win6_9_right2;
               norm5_right <= win5_14_right2 - win6_9_right2;
               norm6_right <= win6_14_right2 - win6_9_right2;
               norm7_right <= win7_14_right2 - win6_9_right2;
               norm8_right <= win8_14_right2 - win6_9_right2;
               norm9_right <= win9_14_right2 - win6_9_right2;
               norm10_right <= win10_14_right2 - win6_9_right2;
               norm11_right <= win11_14_right2 - win6_9_right2;
             end
           else        
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==5)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_5_right2 - win6_10_right2;
              norm2_right <= win2_5_right2 - win6_10_right2;
              norm3_right <= win3_5_right2 - win6_10_right2;
              norm4_right <= win4_5_right2 - win6_10_right2;
              norm5_right <= win5_5_right2 - win6_10_right2;
              norm6_right <= win6_5_right2 - win6_10_right2;
              norm7_right <= win7_5_right2 - win6_10_right2;
              norm8_right <= win8_5_right2 - win6_10_right2;
              norm9_right <= win9_5_right2 - win6_10_right2;
              norm10_right <= win10_5_right2 - win6_10_right2;
              norm11_right <= win11_5_right2 - win6_10_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_6_right2 - win6_10_right2;
               norm2_right <= win2_6_right2 - win6_10_right2;
               norm3_right <= win3_6_right2 - win6_10_right2;
               norm4_right <= win4_6_right2 - win6_10_right2;
               norm5_right <= win5_6_right2 - win6_10_right2;
               norm6_right <= win6_6_right2 - win6_10_right2;
               norm7_right <= win7_6_right2 - win6_10_right2;
               norm8_right <= win8_6_right2 - win6_10_right2;
               norm9_right <= win9_6_right2 - win6_10_right2;
               norm10_right <= win10_6_right2 - win6_10_right2;
               norm11_right <= win11_6_right2 - win6_10_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_7_right2 - win6_10_right2;
               norm2_right <= win2_7_right2 - win6_10_right2;
               norm3_right <= win3_7_right2 - win6_10_right2;
               norm4_right <= win4_7_right2 - win6_10_right2;
               norm5_right <= win5_7_right2 - win6_10_right2;
               norm6_right <= win6_7_right2 - win6_10_right2;
               norm7_right <= win7_7_right2 - win6_10_right2;
               norm8_right <= win8_7_right2 - win6_10_right2;
               norm9_right <= win9_7_right2 - win6_10_right2;
               norm10_right <= win10_7_right2 - win6_10_right2;
               norm11_right <= win11_7_right2 - win6_10_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_8_right2 - win6_10_right2;
               norm2_right <= win2_8_right2 - win6_10_right2;
               norm3_right <= win3_8_right2 - win6_10_right2;
               norm4_right <= win4_8_right2 - win6_10_right2;
               norm5_right <= win5_8_right2 - win6_10_right2;
               norm6_right <= win6_8_right2 - win6_10_right2;
               norm7_right <= win7_8_right2 - win6_10_right2;
               norm8_right <= win8_8_right2 - win6_10_right2;
               norm9_right <= win9_8_right2 - win6_10_right2;
               norm10_right <= win10_8_right2 - win6_10_right2;
               norm11_right <= win11_8_right2 - win6_10_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_9_right2 - win6_10_right2;
               norm2_right <= win2_9_right2 - win6_10_right2;
               norm3_right <= win3_9_right2 - win6_10_right2;
               norm4_right <= win4_9_right2 - win6_10_right2;
               norm5_right <= win5_9_right2 - win6_10_right2;
               norm6_right <= win6_9_right2 - win6_10_right2;
               norm7_right <= win7_9_right2 - win6_10_right2;
               norm8_right <= win8_9_right2 - win6_10_right2;
               norm9_right <= win9_9_right2 - win6_10_right2;
               norm10_right <= win10_9_right2 - win6_10_right2;
               norm11_right <= win11_9_right2 - win6_10_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_10_right2 - win6_10_right2;
               norm2_right <= win2_10_right2 - win6_10_right2;
               norm3_right <= win3_10_right2 - win6_10_right2;
               norm4_right <= win4_10_right2 - win6_10_right2;
               norm5_right <= win5_10_right2 - win6_10_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_10_right2 - win6_10_right2;
               norm8_right <= win8_10_right2 - win6_10_right2;
               norm9_right <= win9_10_right2 - win6_10_right2;
               norm10_right <= win10_10_right2 - win6_10_right2;
               norm11_right <= win11_10_right2 - win6_10_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_11_right2 - win6_10_right2;
               norm2_right <= win2_11_right2 - win6_10_right2;
               norm3_right <= win3_11_right2 - win6_10_right2;
               norm4_right <= win4_11_right2 - win6_10_right2;
               norm5_right <= win5_11_right2 - win6_10_right2;
               norm6_right <= win6_11_right2 - win6_10_right2;
               norm7_right <= win7_11_right2 - win6_10_right2;
               norm8_right <= win8_11_right2 - win6_10_right2;
               norm9_right <= win9_11_right2 - win6_10_right2;
               norm10_right <= win10_11_right2 - win6_10_right2;
               norm11_right <= win11_11_right2 - win6_10_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_12_right2 - win6_10_right2;
               norm2_right <= win2_12_right2 - win6_10_right2;
               norm3_right <= win3_12_right2 - win6_10_right2;
               norm4_right <= win4_12_right2 - win6_10_right2;
               norm5_right <= win5_12_right2 - win6_10_right2;
               norm6_right <= win6_12_right2 - win6_10_right2;
               norm7_right <= win7_12_right2 - win6_10_right2;
               norm8_right <= win8_12_right2 - win6_10_right2;
               norm9_right <= win9_12_right2 - win6_10_right2;
               norm10_right <= win10_12_right2 - win6_10_right2;
               norm11_right <= win11_12_right2 - win6_10_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_13_right2 - win6_10_right2;
               norm2_right <= win2_13_right2 - win6_10_right2;
               norm3_right <= win3_13_right2 - win6_10_right2;
               norm4_right <= win4_13_right2 - win6_10_right2;
               norm5_right <= win5_13_right2 - win6_10_right2;
               norm6_right <= win6_13_right2 - win6_10_right2;
               norm7_right <= win7_13_right2 - win6_10_right2;
               norm8_right <= win8_13_right2 - win6_10_right2;
               norm9_right <= win9_13_right2 - win6_10_right2;
               norm10_right <= win10_13_right2 - win6_10_right2;
               norm11_right <= win11_13_right2 - win6_10_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_14_right2 - win6_10_right2;
               norm2_right <= win2_14_right2 - win6_10_right2;
               norm3_right <= win3_14_right2 - win6_10_right2;
               norm4_right <= win4_14_right2 - win6_10_right2;
               norm5_right <= win5_14_right2 - win6_10_right2;
               norm6_right <= win6_14_right2 - win6_10_right2;
               norm7_right <= win7_14_right2 - win6_10_right2;
               norm8_right <= win8_14_right2 - win6_10_right2;
               norm9_right <= win9_14_right2 - win6_10_right2;
               norm10_right <= win10_14_right2 - win6_10_right2;
               norm11_right <= win11_14_right2 - win6_10_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_15_right2 - win6_10_right2;
               norm2_right <= win2_15_right2 - win6_10_right2;
               norm3_right <= win3_15_right2 - win6_10_right2;
               norm4_right <= win4_15_right2 - win6_10_right2;
               norm5_right <= win5_15_right2 - win6_10_right2;
               norm6_right <= win6_15_right2 - win6_10_right2;
               norm7_right <= win7_15_right2 - win6_10_right2;
               norm8_right <= win8_15_right2 - win6_10_right2;
               norm9_right <= win9_15_right2 - win6_10_right2;
               norm10_right <= win10_15_right2 - win6_10_right2;
               norm11_right <= win11_15_right2 - win6_10_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==6)
        begin
           if(count_cols==1)
            begin
              norm1_right <= win1_6_right2 - win6_11_right2;
              norm2_right <= win2_6_right2 - win6_11_right2;
              norm3_right <= win3_6_right2 - win6_11_right2;
              norm4_right <= win4_6_right2 - win6_11_right2;
              norm5_right <= win5_6_right2 - win6_11_right2;
              norm6_right <= win6_6_right2 - win6_11_right2;
              norm7_right <= win7_6_right2 - win6_11_right2;
              norm8_right <= win8_6_right2 - win6_11_right2;
              norm9_right <= win9_6_right2 - win6_11_right2;
              norm10_right <= win10_6_right2 - win6_11_right2;
              norm11_right <= win11_6_right2 - win6_11_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_7_right2 - win6_11_right2;
               norm2_right <= win2_7_right2 - win6_11_right2;
               norm3_right <= win3_7_right2 - win6_11_right2;
               norm4_right <= win4_7_right2 - win6_11_right2;
               norm5_right <= win5_7_right2 - win6_11_right2;
               norm6_right <= win6_7_right2 - win6_11_right2;
               norm7_right <= win7_7_right2 - win6_11_right2;
               norm8_right <= win8_7_right2 - win6_11_right2;
               norm9_right <= win9_7_right2 - win6_11_right2;
               norm10_right <= win10_7_right2 - win6_11_right2;
               norm11_right <= win11_7_right2 - win6_11_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_8_right2 - win6_11_right2;
               norm2_right <= win2_8_right2 - win6_11_right2;
               norm3_right <= win3_8_right2 - win6_11_right2;
               norm4_right <= win4_8_right2 - win6_11_right2;
               norm5_right <= win5_8_right2 - win6_11_right2;
               norm6_right <= win6_8_right2 - win6_11_right2;
               norm7_right <= win7_8_right2 - win6_11_right2;
               norm8_right <= win8_8_right2 - win6_11_right2;
               norm9_right <= win9_8_right2 - win6_11_right2;
               norm10_right <= win10_8_right2 - win6_11_right2;
               norm11_right <= win11_8_right2 - win6_11_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_9_right2 - win6_11_right2;
               norm2_right <= win2_9_right2 - win6_11_right2;
               norm3_right <= win3_9_right2 - win6_11_right2;
               norm4_right <= win4_9_right2 - win6_11_right2;
               norm5_right <= win5_9_right2 - win6_11_right2;
               norm6_right <= win6_9_right2 - win6_11_right2;
               norm7_right <= win7_9_right2 - win6_11_right2;
               norm8_right <= win8_9_right2 - win6_11_right2;
               norm9_right <= win9_9_right2 - win6_11_right2;
               norm10_right <= win10_9_right2 - win6_11_right2;
               norm11_right <= win11_9_right2 - win6_11_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_10_right2 - win6_11_right2;
               norm2_right <= win2_10_right2 - win6_11_right2;
               norm3_right <= win3_10_right2 - win6_11_right2;
               norm4_right <= win4_10_right2 - win6_11_right2;
               norm5_right <= win5_10_right2 - win6_11_right2;
               norm6_right <= win6_10_right2 - win6_11_right2;
               norm7_right <= win7_10_right2 - win6_11_right2;
               norm8_right <= win8_10_right2 - win6_11_right2;
               norm9_right <= win9_10_right2 - win6_11_right2;
               norm10_right <= win10_10_right2 - win6_11_right2;
               norm11_right <= win11_10_right2 - win6_11_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_11_right2 - win6_11_right2;
               norm2_right <= win2_11_right2 - win6_11_right2;
               norm3_right <= win3_11_right2 - win6_11_right2;
               norm4_right <= win4_11_right2 - win6_11_right2;
               norm5_right <= win5_11_right2 - win6_11_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_11_right2 - win6_11_right2;
               norm8_right <= win8_11_right2 - win6_11_right2;
               norm9_right <= win9_11_right2 - win6_11_right2;
               norm10_right <= win10_11_right2 - win6_11_right2;
               norm11_right <= win11_11_right2 - win6_11_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_12_right2 - win6_11_right2;
               norm2_right <= win2_12_right2 - win6_11_right2;
               norm3_right <= win3_12_right2 - win6_11_right2;
               norm4_right <= win4_12_right2 - win6_11_right2;
               norm5_right <= win5_12_right2 - win6_11_right2;
               norm6_right <= win6_12_right2 - win6_11_right2;
               norm7_right <= win7_12_right2 - win6_11_right2;
               norm8_right <= win8_12_right2 - win6_11_right2;
               norm9_right <= win9_12_right2 - win6_11_right2;
               norm10_right <= win10_12_right2 - win6_11_right2;
               norm11_right <= win11_12_right2 - win6_11_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_13_right2 - win6_11_right2;
               norm2_right <= win2_13_right2 - win6_11_right2;
               norm3_right <= win3_13_right2 - win6_11_right2;
               norm4_right <= win4_13_right2 - win6_11_right2;
               norm5_right <= win5_13_right2 - win6_11_right2;
               norm6_right <= win6_13_right2 - win6_11_right2;
               norm7_right <= win7_13_right2 - win6_11_right2;
               norm8_right <= win8_13_right2 - win6_11_right2;
               norm9_right <= win9_13_right2 - win6_11_right2;
               norm10_right <= win10_13_right2 - win6_11_right2;
               norm11_right <= win11_13_right2 - win6_11_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_14_right2 - win6_11_right2;
               norm2_right <= win2_14_right2 - win6_11_right2;
               norm3_right <= win3_14_right2 - win6_11_right2;
               norm4_right <= win4_14_right2 - win6_11_right2;
               norm5_right <= win5_14_right2 - win6_11_right2;
               norm6_right <= win6_14_right2 - win6_11_right2;
               norm7_right <= win7_14_right2 - win6_11_right2;
               norm8_right <= win8_14_right2 - win6_11_right2;
               norm9_right <= win9_14_right2 - win6_11_right2;
               norm10_right <= win10_14_right2 - win6_11_right2;
               norm11_right <= win11_14_right2 - win6_11_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_15_right2 - win6_11_right2;
               norm2_right <= win2_15_right2 - win6_11_right2;
               norm3_right <= win3_15_right2 - win6_11_right2;
               norm4_right <= win4_15_right2 - win6_11_right2;
               norm5_right <= win5_15_right2 - win6_11_right2;
               norm6_right <= win6_15_right2 - win6_11_right2;
               norm7_right <= win7_15_right2 - win6_11_right2;
               norm8_right <= win8_15_right2 - win6_11_right2;
               norm9_right <= win9_15_right2 - win6_11_right2;
               norm10_right <= win10_15_right2 - win6_11_right2;
               norm11_right <= win11_15_right2 - win6_11_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_16_right2 - win6_11_right2;
               norm2_right <= win2_16_right2 - win6_11_right2;
               norm3_right <= win3_16_right2 - win6_11_right2;
               norm4_right <= win4_16_right2 - win6_11_right2;
               norm5_right <= win5_16_right2 - win6_11_right2;
               norm6_right <= win6_16_right2 - win6_11_right2;
               norm7_right <= win7_16_right2 - win6_11_right2;
               norm8_right <= win8_16_right2 - win6_11_right2;
               norm9_right <= win9_16_right2 - win6_11_right2;
               norm10_right <= win10_16_right2 - win6_11_right2;
               norm11_right <= win11_16_right2 - win6_11_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==7)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_7_right2 - win6_12_right2;
              norm2_right <= win2_7_right2 - win6_12_right2;
              norm3_right <= win3_7_right2 - win6_12_right2;
              norm4_right <= win4_7_right2 - win6_12_right2;
              norm5_right <= win5_7_right2 - win6_12_right2;
              norm6_right <= win6_7_right2 - win6_12_right2;
              norm7_right <= win7_7_right2 - win6_12_right2;
              norm8_right <= win8_7_right2 - win6_12_right2;
              norm9_right <= win9_7_right2 - win6_12_right2;
              norm10_right <= win10_7_right2 - win6_12_right2;
              norm11_right <= win11_7_right2 - win6_12_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_8_right2 - win6_12_right2;
               norm2_right <= win2_8_right2 - win6_12_right2;
               norm3_right <= win3_8_right2 - win6_12_right2;
               norm4_right <= win4_8_right2 - win6_12_right2;
               norm5_right <= win5_8_right2 - win6_12_right2;
               norm6_right <= win6_8_right2 - win6_12_right2;
               norm7_right <= win7_8_right2 - win6_12_right2;
               norm8_right <= win8_8_right2 - win6_12_right2;
               norm9_right <= win9_8_right2 - win6_12_right2;
               norm10_right <= win10_8_right2 - win6_12_right2;
               norm11_right <= win11_8_right2 - win6_12_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_9_right2 - win6_12_right2;
               norm2_right <= win2_9_right2 - win6_12_right2;
               norm3_right <= win3_9_right2 - win6_12_right2;
               norm4_right <= win4_9_right2 - win6_12_right2;
               norm5_right <= win5_9_right2 - win6_12_right2;
               norm6_right <= win6_9_right2 - win6_12_right2;
               norm7_right <= win7_9_right2 - win6_12_right2;
               norm8_right <= win8_9_right2 - win6_12_right2;
               norm9_right <= win9_9_right2 - win6_12_right2;
               norm10_right <= win10_9_right2 - win6_12_right2;
               norm11_right <= win11_9_right2 - win6_12_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_10_right2 - win6_12_right2;
               norm2_right <= win2_10_right2 - win6_12_right2;
               norm3_right <= win3_10_right2 - win6_12_right2;
               norm4_right <= win4_10_right2 - win6_12_right2;
               norm5_right <= win5_10_right2 - win6_12_right2;
               norm6_right <= win6_10_right2 - win6_12_right2;
               norm7_right <= win7_10_right2 - win6_12_right2;
               norm8_right <= win8_10_right2 - win6_12_right2;
               norm9_right <= win9_10_right2 - win6_12_right2;
               norm10_right <= win10_10_right2 - win6_12_right2;
               norm11_right <= win11_10_right2 - win6_12_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_11_right2 - win6_12_right2;
               norm2_right <= win2_11_right2 - win6_12_right2;
               norm3_right <= win3_11_right2 - win6_12_right2;
               norm4_right <= win4_11_right2 - win6_12_right2;
               norm5_right <= win5_11_right2 - win6_12_right2;
               norm6_right <= win6_11_right2 - win6_12_right2;
               norm7_right <= win7_11_right2 - win6_12_right2;
               norm8_right <= win8_11_right2 - win6_12_right2;
               norm9_right <= win9_11_right2 - win6_12_right2;
               norm10_right <= win10_11_right2 - win6_12_right2;
               norm11_right <= win11_11_right2 - win6_12_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_12_right2 - win6_12_right2;
               norm2_right <= win2_12_right2 - win6_12_right2;
               norm3_right <= win3_12_right2 - win6_12_right2;
               norm4_right <= win4_12_right2 - win6_12_right2;
               norm5_right <= win5_12_right2 - win6_12_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_12_right2 - win6_12_right2;
               norm8_right <= win8_12_right2 - win6_12_right2;
               norm9_right <= win9_12_right2 - win6_12_right2;
               norm10_right <= win10_12_right2 - win6_12_right2;
               norm11_right <= win11_12_right2 - win6_12_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_13_right2 - win6_12_right2;
               norm2_right <= win2_13_right2 - win6_12_right2;
               norm3_right <= win3_13_right2 - win6_12_right2;
               norm4_right <= win4_13_right2 - win6_12_right2;
               norm5_right <= win5_13_right2 - win6_12_right2;
               norm6_right <= win6_13_right2 - win6_12_right2;
               norm7_right <= win7_13_right2 - win6_12_right2;
               norm8_right <= win8_13_right2 - win6_12_right2;
               norm9_right <= win9_13_right2 - win6_12_right2;
               norm10_right <= win10_13_right2 - win6_12_right2;
               norm11_right <= win11_13_right2 - win6_12_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_14_right2 - win6_12_right2;
               norm2_right <= win2_14_right2 - win6_12_right2;
               norm3_right <= win3_14_right2 - win6_12_right2;
               norm4_right <= win4_14_right2 - win6_12_right2;
               norm5_right <= win5_14_right2 - win6_12_right2;
               norm6_right <= win6_14_right2 - win6_12_right2;
               norm7_right <= win7_14_right2 - win6_12_right2;
               norm8_right <= win8_14_right2 - win6_12_right2;
               norm9_right <= win9_14_right2 - win6_12_right2;
               norm10_right <= win10_14_right2 - win6_12_right2;
               norm11_right <= win11_14_right2 - win6_12_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_15_right2 - win6_12_right2;
               norm2_right <= win2_15_right2 - win6_12_right2;
               norm3_right <= win3_15_right2 - win6_12_right2;
               norm4_right <= win4_15_right2 - win6_12_right2;
               norm5_right <= win5_15_right2 - win6_12_right2;
               norm6_right <= win6_15_right2 - win6_12_right2;
               norm7_right <= win7_15_right2 - win6_12_right2;
               norm8_right <= win8_15_right2 - win6_12_right2;
               norm9_right <= win9_15_right2 - win6_12_right2;
               norm10_right <= win10_15_right2 - win6_12_right2;
               norm11_right <= win11_15_right2 - win6_12_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_16_right2 - win6_12_right2;
               norm2_right <= win2_16_right2 - win6_12_right2;
               norm3_right <= win3_16_right2 - win6_12_right2;
               norm4_right <= win4_16_right2 - win6_12_right2;
               norm5_right <= win5_16_right2 - win6_12_right2;
               norm6_right <= win6_16_right2 - win6_12_right2;
               norm7_right <= win7_16_right2 - win6_12_right2;
               norm8_right <= win8_16_right2 - win6_12_right2;
               norm9_right <= win9_16_right2 - win6_12_right2;
               norm10_right <= win10_16_right2 - win6_12_right2;
               norm11_right <= win11_16_right2 - win6_12_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_17_right2 - win6_12_right2;
               norm2_right <= win2_17_right2 - win6_12_right2;
               norm3_right <= win3_17_right2 - win6_12_right2;
               norm4_right <= win4_17_right2 - win6_12_right2;
               norm5_right <= win5_17_right2 - win6_12_right2;
               norm6_right <= win6_17_right2 - win6_12_right2;
               norm7_right <= win7_17_right2 - win6_12_right2;
               norm8_right <= win8_17_right2 - win6_12_right2;
               norm9_right <= win9_17_right2 - win6_12_right2;
               norm10_right <= win10_17_right2 - win6_12_right2;
               norm11_right <= win11_17_right2 - win6_12_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==8)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_8_right2 - win6_13_right2;
              norm2_right <= win2_8_right2 - win6_13_right2;
              norm3_right <= win3_8_right2 - win6_13_right2;
              norm4_right <= win4_8_right2 - win6_13_right2;
              norm5_right <= win5_8_right2 - win6_13_right2;
              norm6_right <= win6_8_right2 - win6_13_right2;
              norm7_right <= win7_8_right2 - win6_13_right2;
              norm8_right <= win8_8_right2 - win6_13_right2;
              norm9_right <= win9_8_right2 - win6_13_right2;
              norm10_right <= win10_8_right2 - win6_13_right2;
              norm11_right <= win11_8_right2 - win6_13_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_9_right2 - win6_13_right2;
               norm2_right <= win2_9_right2 - win6_13_right2;
               norm3_right <= win3_9_right2 - win6_13_right2;
               norm4_right <= win4_9_right2 - win6_13_right2;
               norm5_right <= win5_9_right2 - win6_13_right2;
               norm6_right <= win6_9_right2 - win6_13_right2;
               norm7_right <= win7_9_right2 - win6_13_right2;
               norm8_right <= win8_9_right2 - win6_13_right2;
               norm9_right <= win9_9_right2 - win6_13_right2;
               norm10_right <= win10_9_right2 - win6_13_right2;
               norm11_right <= win11_9_right2 - win6_13_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_10_right2 - win6_13_right2;
               norm2_right <= win2_10_right2 - win6_13_right2;
               norm3_right <= win3_10_right2 - win6_13_right2;
               norm4_right <= win4_10_right2 - win6_13_right2;
               norm5_right <= win5_10_right2 - win6_13_right2;
               norm6_right <= win6_10_right2 - win6_13_right2;
               norm7_right <= win7_10_right2 - win6_13_right2;
               norm8_right <= win8_10_right2 - win6_13_right2;
               norm9_right <= win9_10_right2 - win6_13_right2;
               norm10_right <= win10_10_right2 - win6_13_right2;
               norm11_right <= win11_10_right2 - win6_13_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_11_right2 - win6_13_right2;
               norm2_right <= win2_11_right2 - win6_13_right2;
               norm3_right <= win3_11_right2 - win6_13_right2;
               norm4_right <= win4_11_right2 - win6_13_right2;
               norm5_right <= win5_11_right2 - win6_13_right2;
               norm6_right <= win6_11_right2 - win6_13_right2;
               norm7_right <= win7_11_right2 - win6_13_right2;
               norm8_right <= win8_11_right2 - win6_13_right2;
               norm9_right <= win9_11_right2 - win6_13_right2;
               norm10_right <= win10_11_right2 - win6_13_right2;
               norm11_right <= win11_11_right2 - win6_13_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_12_right2 - win6_13_right2;
               norm2_right <= win2_12_right2 - win6_13_right2;
               norm3_right <= win3_12_right2 - win6_13_right2;
               norm4_right <= win4_12_right2 - win6_13_right2;
               norm5_right <= win5_12_right2 - win6_13_right2;
               norm6_right <= win6_12_right2 - win6_13_right2;
               norm7_right <= win7_12_right2 - win6_13_right2;
               norm8_right <= win8_12_right2 - win6_13_right2;
               norm9_right <= win9_12_right2 - win6_13_right2;
               norm10_right <= win10_12_right2 - win6_13_right2;
               norm11_right <= win11_12_right2 - win6_13_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_13_right2 - win6_13_right2;
               norm2_right <= win2_13_right2 - win6_13_right2;
               norm3_right <= win3_13_right2 - win6_13_right2;
               norm4_right <= win4_13_right2 - win6_13_right2;
               norm5_right <= win5_13_right2 - win6_13_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_13_right2 - win6_13_right2;
               norm8_right <= win8_13_right2 - win6_13_right2;
               norm9_right <= win9_13_right2 - win6_13_right2;
               norm10_right <= win10_13_right2 - win6_13_right2;
               norm11_right <= win11_13_right2 - win6_13_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_14_right2 - win6_13_right2;
               norm2_right <= win2_14_right2 - win6_13_right2;
               norm3_right <= win3_14_right2 - win6_13_right2;
               norm4_right <= win4_14_right2 - win6_13_right2;
               norm5_right <= win5_14_right2 - win6_13_right2;
               norm6_right <= win6_14_right2 - win6_13_right2;
               norm7_right <= win7_14_right2 - win6_13_right2;
               norm8_right <= win8_14_right2 - win6_13_right2;
               norm9_right <= win9_14_right2 - win6_13_right2;
               norm10_right <= win10_14_right2 - win6_13_right2;
               norm11_right <= win11_14_right2 - win6_13_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_15_right2 - win6_13_right2;
               norm2_right <= win2_15_right2 - win6_13_right2;
               norm3_right <= win3_15_right2 - win6_13_right2;
               norm4_right <= win4_15_right2 - win6_13_right2;
               norm5_right <= win5_15_right2 - win6_13_right2;
               norm6_right <= win6_15_right2 - win6_13_right2;
               norm7_right <= win7_15_right2 - win6_13_right2;
               norm8_right <= win8_15_right2 - win6_13_right2;
               norm9_right <= win9_15_right2 - win6_13_right2;
               norm10_right <= win10_15_right2 - win6_13_right2;
               norm11_right <= win11_15_right2 - win6_13_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_16_right2 - win6_13_right2;
               norm2_right <= win2_16_right2 - win6_13_right2;
               norm3_right <= win3_16_right2 - win6_13_right2;
               norm4_right <= win4_16_right2 - win6_13_right2;
               norm5_right <= win5_16_right2 - win6_13_right2;
               norm6_right <= win6_16_right2 - win6_13_right2;
               norm7_right <= win7_16_right2 - win6_13_right2;
               norm8_right <= win8_16_right2 - win6_13_right2;
               norm9_right <= win9_16_right2 - win6_13_right2;
               norm10_right <= win10_16_right2 - win6_13_right2;
               norm11_right <= win11_16_right2 - win6_13_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_17_right2 - win6_13_right2;
               norm2_right <= win2_17_right2 - win6_13_right2;
               norm3_right <= win3_17_right2 - win6_13_right2;
               norm4_right <= win4_17_right2 - win6_13_right2;
               norm5_right <= win5_17_right2 - win6_13_right2;
               norm6_right <= win6_17_right2 - win6_13_right2;
               norm7_right <= win7_17_right2 - win6_13_right2;
               norm8_right <= win8_17_right2 - win6_13_right2;
               norm9_right <= win9_17_right2 - win6_13_right2;
               norm10_right <= win10_17_right2 - win6_13_right2;
               norm11_right <= win11_17_right2 - win6_13_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_18_right2 - win6_13_right2;
               norm2_right <= win2_18_right2 - win6_13_right2;
               norm3_right <= win3_18_right2 - win6_13_right2;
               norm4_right <= win4_18_right2 - win6_13_right2;
               norm5_right <= win5_18_right2 - win6_13_right2;
               norm6_right <= win6_18_right2 - win6_13_right2;
               norm7_right <= win7_18_right2 - win6_13_right2;
               norm8_right <= win8_18_right2 - win6_13_right2;
               norm9_right <= win9_18_right2 - win6_13_right2;
               norm10_right <= win10_18_right2 - win6_13_right2;
               norm11_right <= win11_18_right2 - win6_13_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==9)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_9_right2 - win6_14_right2;
              norm2_right <= win2_9_right2 - win6_14_right2;
              norm3_right <= win3_9_right2 - win6_14_right2;
              norm4_right <= win4_9_right2 - win6_14_right2;
              norm5_right <= win5_9_right2 - win6_14_right2;
              norm6_right <= win6_9_right2 - win6_14_right2;
              norm7_right <= win7_9_right2 - win6_14_right2;
              norm8_right <= win8_9_right2 - win6_14_right2;
              norm9_right <= win9_9_right2 - win6_14_right2;
              norm10_right <= win10_9_right2 - win6_14_right2;
              norm11_right <= win11_9_right2 - win6_14_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_10_right2 - win6_14_right2;
               norm2_right <= win2_10_right2 - win6_14_right2;
               norm3_right <= win3_10_right2 - win6_14_right2;
               norm4_right <= win4_10_right2 - win6_14_right2;
               norm5_right <= win5_10_right2 - win6_14_right2;
               norm6_right <= win6_10_right2 - win6_14_right2;
               norm7_right <= win7_10_right2 - win6_14_right2;
               norm8_right <= win8_10_right2 - win6_14_right2;
               norm9_right <= win9_10_right2 - win6_14_right2;
               norm10_right <= win10_10_right2 - win6_14_right2;
               norm11_right <= win11_10_right2 - win6_14_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_11_right2 - win6_14_right2;
               norm2_right <= win2_11_right2 - win6_14_right2;
               norm3_right <= win3_11_right2 - win6_14_right2;
               norm4_right <= win4_11_right2 - win6_14_right2;
               norm5_right <= win5_11_right2 - win6_14_right2;
               norm6_right <= win6_11_right2 - win6_14_right2;
               norm7_right <= win7_11_right2 - win6_14_right2;
               norm8_right <= win8_11_right2 - win6_14_right2;
               norm9_right <= win9_11_right2 - win6_14_right2;
               norm10_right <= win10_11_right2 - win6_14_right2;
               norm11_right <= win11_11_right2 - win6_14_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_12_right2 - win6_14_right2;
               norm2_right <= win2_12_right2 - win6_14_right2;
               norm3_right <= win3_12_right2 - win6_14_right2;
               norm4_right <= win4_12_right2 - win6_14_right2;
               norm5_right <= win5_12_right2 - win6_14_right2;
               norm6_right <= win6_12_right2 - win6_14_right2;
               norm7_right <= win7_12_right2 - win6_14_right2;
               norm8_right <= win8_12_right2 - win6_14_right2;
               norm9_right <= win9_12_right2 - win6_14_right2;
               norm10_right <= win10_12_right2 - win6_14_right2;
               norm11_right <= win11_12_right2 - win6_14_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_13_right2 - win6_14_right2;
               norm2_right <= win2_13_right2 - win6_14_right2;
               norm3_right <= win3_13_right2 - win6_14_right2;
               norm4_right <= win4_13_right2 - win6_14_right2;
               norm5_right <= win5_13_right2 - win6_14_right2;
               norm6_right <= win6_13_right2 - win6_14_right2;
               norm7_right <= win7_13_right2 - win6_14_right2;
               norm8_right <= win8_13_right2 - win6_14_right2;
               norm9_right <= win9_13_right2 - win6_14_right2;
               norm10_right <= win10_13_right2 - win6_14_right2;
               norm11_right <= win11_13_right2 - win6_14_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_14_right2 - win6_14_right2;
               norm2_right <= win2_14_right2 - win6_14_right2;
               norm3_right <= win3_14_right2 - win6_14_right2;
               norm4_right <= win4_14_right2 - win6_14_right2;
               norm5_right <= win5_14_right2 - win6_14_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_14_right2 - win6_14_right2;
               norm8_right <= win8_14_right2 - win6_14_right2;
               norm9_right <= win9_14_right2 - win6_14_right2;
               norm10_right <= win10_14_right2 - win6_14_right2;
               norm11_right <= win11_14_right2 - win6_14_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_15_right2 - win6_14_right2;
               norm2_right <= win2_15_right2 - win6_14_right2;
               norm3_right <= win3_15_right2 - win6_14_right2;
               norm4_right <= win4_15_right2 - win6_14_right2;
               norm5_right <= win5_15_right2 - win6_14_right2;
               norm6_right <= win6_15_right2 - win6_14_right2;
               norm7_right <= win7_15_right2 - win6_14_right2;
               norm8_right <= win8_15_right2 - win6_14_right2;
               norm9_right <= win9_15_right2 - win6_14_right2;
               norm10_right <= win10_15_right2 - win6_14_right2;
               norm11_right <= win11_15_right2 - win6_14_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_16_right2 - win6_14_right2;
               norm2_right <= win2_16_right2 - win6_14_right2;
               norm3_right <= win3_16_right2 - win6_14_right2;
               norm4_right <= win4_16_right2 - win6_14_right2;
               norm5_right <= win5_16_right2 - win6_14_right2;
               norm6_right <= win6_16_right2 - win6_14_right2;
               norm7_right <= win7_16_right2 - win6_14_right2;
               norm8_right <= win8_16_right2 - win6_14_right2;
               norm9_right <= win9_16_right2 - win6_14_right2;
               norm10_right <= win10_16_right2 - win6_14_right2;
               norm11_right <= win11_16_right2 - win6_14_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_17_right2 - win6_14_right2;
               norm2_right <= win2_17_right2 - win6_14_right2;
               norm3_right <= win3_17_right2 - win6_14_right2;
               norm4_right <= win4_17_right2 - win6_14_right2;
               norm5_right <= win5_17_right2 - win6_14_right2;
               norm6_right <= win6_17_right2 - win6_14_right2;
               norm7_right <= win7_17_right2 - win6_14_right2;
               norm8_right <= win8_17_right2 - win6_14_right2;
               norm9_right <= win9_17_right2 - win6_14_right2;
               norm10_right <= win10_17_right2 - win6_14_right2;
               norm11_right <= win11_17_right2 - win6_14_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_18_right2 - win6_14_right2;
               norm2_right <= win2_18_right2 - win6_14_right2;
               norm3_right <= win3_18_right2 - win6_14_right2;
               norm4_right <= win4_18_right2 - win6_14_right2;
               norm5_right <= win5_18_right2 - win6_14_right2;
               norm6_right <= win6_18_right2 - win6_14_right2;
               norm7_right <= win7_18_right2 - win6_14_right2;
               norm8_right <= win8_18_right2 - win6_14_right2;
               norm9_right <= win9_18_right2 - win6_14_right2;
               norm10_right <= win10_18_right2 - win6_14_right2;
               norm11_right <= win11_18_right2 - win6_14_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_19_right2 - win6_14_right2;
               norm2_right <= win2_19_right2 - win6_14_right2;
               norm3_right <= win3_19_right2 - win6_14_right2;
               norm4_right <= win4_19_right2 - win6_14_right2;
               norm5_right <= win5_19_right2 - win6_14_right2;
               norm6_right <= win6_19_right2 - win6_14_right2;
               norm7_right <= win7_19_right2 - win6_14_right2;
               norm8_right <= win8_19_right2 - win6_14_right2;
               norm9_right <= win9_19_right2 - win6_14_right2;
               norm10_right <= win10_19_right2 - win6_14_right2;
               norm11_right <= win11_19_right2 - win6_14_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==10)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_10_right2 - win6_15_right2;
              norm2_right <= win2_10_right2 - win6_15_right2;
              norm3_right <= win3_10_right2 - win6_15_right2;
              norm4_right <= win4_10_right2 - win6_15_right2;
              norm5_right <= win5_10_right2 - win6_15_right2;
              norm6_right <= win6_10_right2 - win6_15_right2;
              norm7_right <= win7_10_right2 - win6_15_right2;
              norm8_right <= win8_10_right2 - win6_15_right2;
              norm9_right <= win9_10_right2 - win6_15_right2;
              norm10_right <= win10_10_right2 - win6_15_right2;
              norm11_right <= win11_10_right2 - win6_15_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_11_right2 - win6_15_right2;
               norm2_right <= win2_11_right2 - win6_15_right2;
               norm3_right <= win3_11_right2 - win6_15_right2;
               norm4_right <= win4_11_right2 - win6_15_right2;
               norm5_right <= win5_11_right2 - win6_15_right2;
               norm6_right <= win6_11_right2 - win6_15_right2;
               norm7_right <= win7_11_right2 - win6_15_right2;
               norm8_right <= win8_11_right2 - win6_15_right2;
               norm9_right <= win9_11_right2 - win6_15_right2;
               norm10_right <= win10_11_right2 - win6_15_right2;
               norm11_right <= win11_11_right2 - win6_15_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_12_right2 - win6_15_right2;
               norm2_right <= win2_12_right2 - win6_15_right2;
               norm3_right <= win3_12_right2 - win6_15_right2;
               norm4_right <= win4_12_right2 - win6_15_right2;
               norm5_right <= win5_12_right2 - win6_15_right2;
               norm6_right <= win6_12_right2 - win6_15_right2;
               norm7_right <= win7_12_right2 - win6_15_right2;
               norm8_right <= win8_12_right2 - win6_15_right2;
               norm9_right <= win9_12_right2 - win6_15_right2;
               norm10_right <= win10_12_right2 - win6_15_right2;
               norm11_right <= win11_12_right2 - win6_15_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_13_right2 - win6_15_right2;
               norm2_right <= win2_13_right2 - win6_15_right2;
               norm3_right <= win3_13_right2 - win6_15_right2;
               norm4_right <= win4_13_right2 - win6_15_right2;
               norm5_right <= win5_13_right2 - win6_15_right2;
               norm6_right <= win6_13_right2 - win6_15_right2;
               norm7_right <= win7_13_right2 - win6_15_right2;
               norm8_right <= win8_13_right2 - win6_15_right2;
               norm9_right <= win9_13_right2 - win6_15_right2;
               norm10_right <= win10_13_right2 - win6_15_right2;
               norm11_right <= win11_13_right2 - win6_15_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_14_right2 - win6_15_right2;
               norm2_right <= win2_14_right2 - win6_15_right2;
               norm3_right <= win3_14_right2 - win6_15_right2;
               norm4_right <= win4_14_right2 - win6_15_right2;
               norm5_right <= win5_14_right2 - win6_15_right2;
               norm6_right <= win6_14_right2 - win6_15_right2;
               norm7_right <= win7_14_right2 - win6_15_right2;
               norm8_right <= win8_14_right2 - win6_15_right2;
               norm9_right <= win9_14_right2 - win6_15_right2;
               norm10_right <= win10_14_right2 - win6_15_right2;
               norm11_right <= win11_14_right2 - win6_15_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_15_right2 - win6_15_right2;
               norm2_right <= win2_15_right2 - win6_15_right2;
               norm3_right <= win3_15_right2 - win6_15_right2;
               norm4_right <= win4_15_right2 - win6_15_right2;
               norm5_right <= win5_15_right2 - win6_15_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_15_right2 - win6_15_right2;
               norm8_right <= win8_15_right2 - win6_15_right2;
               norm9_right <= win9_15_right2 - win6_15_right2;
               norm10_right <= win10_15_right2 - win6_15_right2;
               norm11_right <= win11_15_right2 - win6_15_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_16_right2 - win6_15_right2;
               norm2_right <= win2_16_right2 - win6_15_right2;
               norm3_right <= win3_16_right2 - win6_15_right2;
               norm4_right <= win4_16_right2 - win6_15_right2;
               norm5_right <= win5_16_right2 - win6_15_right2;
               norm6_right <= win6_16_right2 - win6_15_right2;
               norm7_right <= win7_16_right2 - win6_15_right2;
               norm8_right <= win8_16_right2 - win6_15_right2;
               norm9_right <= win9_16_right2 - win6_15_right2;
               norm10_right <= win10_16_right2 - win6_15_right2;
               norm11_right <= win11_16_right2 - win6_15_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_17_right2 - win6_15_right2;
               norm2_right <= win2_17_right2 - win6_15_right2;
               norm3_right <= win3_17_right2 - win6_15_right2;
               norm4_right <= win4_17_right2 - win6_15_right2;
               norm5_right <= win5_17_right2 - win6_15_right2;
               norm6_right <= win6_17_right2 - win6_15_right2;
               norm7_right <= win7_17_right2 - win6_15_right2;
               norm8_right <= win8_17_right2 - win6_15_right2;
               norm9_right <= win9_17_right2 - win6_15_right2;
               norm10_right <= win10_17_right2 - win6_15_right2;
               norm11_right <= win11_17_right2 - win6_15_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_18_right2 - win6_15_right2;
               norm2_right <= win2_18_right2 - win6_15_right2;
               norm3_right <= win3_18_right2 - win6_15_right2;
               norm4_right <= win4_18_right2 - win6_15_right2;
               norm5_right <= win5_18_right2 - win6_15_right2;
               norm6_right <= win6_18_right2 - win6_15_right2;
               norm7_right <= win7_18_right2 - win6_15_right2;
               norm8_right <= win8_18_right2 - win6_15_right2;
               norm9_right <= win9_18_right2 - win6_15_right2;
               norm10_right <= win10_18_right2 - win6_15_right2;
               norm11_right <= win11_18_right2 - win6_15_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_19_right2 - win6_15_right2;
               norm2_right <= win2_19_right2 - win6_15_right2;
               norm3_right <= win3_19_right2 - win6_15_right2;
               norm4_right <= win4_19_right2 - win6_15_right2;
               norm5_right <= win5_19_right2 - win6_15_right2;
               norm6_right <= win6_19_right2 - win6_15_right2;
               norm7_right <= win7_19_right2 - win6_15_right2;
               norm8_right <= win8_19_right2 - win6_15_right2;
               norm9_right <= win9_19_right2 - win6_15_right2;
               norm10_right <= win10_19_right2 - win6_15_right2;
               norm11_right <= win11_19_right2 - win6_15_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_20_right2 - win6_15_right2;
               norm2_right <= win2_20_right2 - win6_15_right2;
               norm3_right <= win3_20_right2 - win6_15_right2;
               norm4_right <= win4_20_right2 - win6_15_right2;
               norm5_right <= win5_20_right2 - win6_15_right2;
               norm6_right <= win6_20_right2 - win6_15_right2;
               norm7_right <= win7_20_right2 - win6_15_right2;
               norm8_right <= win8_20_right2 - win6_15_right2;
               norm9_right <= win9_20_right2 - win6_15_right2;
               norm10_right <= win10_20_right2 - win6_15_right2;
               norm11_right <= win11_20_right2 - win6_15_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
      else if(count_windows==11)
        begin
          if(count_cols==1)
            begin
              norm1_right <= win1_11_right2 - win6_16_right2;
              norm2_right <= win2_11_right2 - win6_16_right2;
              norm3_right <= win3_11_right2 - win6_16_right2;
              norm4_right <= win4_11_right2 - win6_16_right2;
              norm5_right <= win5_11_right2 - win6_16_right2;
              norm6_right <= win6_11_right2 - win6_16_right2;
              norm7_right <= win7_11_right2 - win6_16_right2;
              norm8_right <= win8_11_right2 - win6_16_right2;
              norm9_right <= win9_11_right2 - win6_16_right2;
              norm10_right <= win10_11_right2 - win6_16_right2;
              norm11_right <= win11_11_right2 - win6_16_right2;
            end
           else if(count_cols==2)
             begin
               norm1_right <= win1_12_right2 - win6_16_right2;
               norm2_right <= win2_12_right2 - win6_16_right2;
               norm3_right <= win3_12_right2 - win6_16_right2;
               norm4_right <= win4_12_right2 - win6_16_right2;
               norm5_right <= win5_12_right2 - win6_16_right2;
               norm6_right <= win6_12_right2 - win6_16_right2;
               norm7_right <= win7_12_right2 - win6_16_right2;
               norm8_right <= win8_12_right2 - win6_16_right2;
               norm9_right <= win9_12_right2 - win6_16_right2;
               norm10_right <= win10_12_right2 - win6_16_right2;
               norm11_right <= win11_12_right2 - win6_16_right2;
             end
           else if(count_cols==3)
             begin
               norm1_right <= win1_13_right2 - win6_16_right2;
               norm2_right <= win2_13_right2 - win6_16_right2;
               norm3_right <= win3_13_right2 - win6_16_right2;
               norm4_right <= win4_13_right2 - win6_16_right2;
               norm5_right <= win5_13_right2 - win6_16_right2;
               norm6_right <= win6_13_right2 - win6_16_right2;
               norm7_right <= win7_13_right2 - win6_16_right2;
               norm8_right <= win8_13_right2 - win6_16_right2;
               norm9_right <= win9_13_right2 - win6_16_right2;
               norm10_right <= win10_13_right2 - win6_16_right2;
               norm11_right <= win11_13_right2 - win6_16_right2;
             end
           else if(count_cols==4)
             begin
               norm1_right <= win1_14_right2 - win6_16_right2;
               norm2_right <= win2_14_right2 - win6_16_right2;
               norm3_right <= win3_14_right2 - win6_16_right2;
               norm4_right <= win4_14_right2 - win6_16_right2;
               norm5_right <= win5_14_right2 - win6_16_right2;
               norm6_right <= win6_14_right2 - win6_16_right2;
               norm7_right <= win7_14_right2 - win6_16_right2;
               norm8_right <= win8_14_right2 - win6_16_right2;
               norm9_right <= win9_14_right2 - win6_16_right2;
               norm10_right <= win10_14_right2 - win6_16_right2;
               norm11_right <= win11_14_right2 - win6_16_right2;
             end
           else if(count_cols==5)
             begin
               norm1_right <= win1_15_right2 - win6_16_right2;
               norm2_right <= win2_15_right2 - win6_16_right2;
               norm3_right <= win3_15_right2 - win6_16_right2;
               norm4_right <= win4_15_right2 - win6_16_right2;
               norm5_right <= win5_15_right2 - win6_16_right2;
               norm6_right <= win6_15_right2 - win6_16_right2;
               norm7_right <= win7_15_right2 - win6_16_right2;
               norm8_right <= win8_15_right2 - win6_16_right2;
               norm9_right <= win9_15_right2 - win6_16_right2;
               norm10_right <= win10_15_right2 - win6_16_right2;
               norm11_right <= win11_15_right2 - win6_16_right2;
             end
           else if(count_cols==6)
             begin
               norm1_right <= win1_16_right2 - win6_16_right2;
               norm2_right <= win2_16_right2 - win6_16_right2;
               norm3_right <= win3_16_right2 - win6_16_right2;
               norm4_right <= win4_16_right2 - win6_16_right2;
               norm5_right <= win5_16_right2 - win6_16_right2;
               norm6_right <= 9'd0;
               norm7_right <= win7_16_right2 - win6_16_right2;
               norm8_right <= win8_16_right2 - win6_16_right2;
               norm9_right <= win9_16_right2 - win6_16_right2;
               norm10_right <= win10_16_right2 - win6_16_right2;
               norm11_right <= win11_16_right2 - win6_16_right2;
             end
           else if(count_cols==7)
             begin
               norm1_right <= win1_17_right2 - win6_16_right2;
               norm2_right <= win2_17_right2 - win6_16_right2;
               norm3_right <= win3_17_right2 - win6_16_right2;
               norm4_right <= win4_17_right2 - win6_16_right2;
               norm5_right <= win5_17_right2 - win6_16_right2;
               norm6_right <= win6_17_right2 - win6_16_right2;
               norm7_right <= win7_17_right2 - win6_16_right2;
               norm8_right <= win8_17_right2 - win6_16_right2;
               norm9_right <= win9_17_right2 - win6_16_right2;
               norm10_right <= win10_17_right2 - win6_16_right2;
               norm11_right <= win11_17_right2 - win6_16_right2;
             end
           else if(count_cols==8)
             begin
               norm1_right <= win1_18_right2 - win6_16_right2;
               norm2_right <= win2_18_right2 - win6_16_right2;
               norm3_right <= win3_18_right2 - win6_16_right2;
               norm4_right <= win4_18_right2 - win6_16_right2;
               norm5_right <= win5_18_right2 - win6_16_right2;
               norm6_right <= win6_18_right2 - win6_16_right2;
               norm7_right <= win7_18_right2 - win6_16_right2;
               norm8_right <= win8_18_right2 - win6_16_right2;
               norm9_right <= win9_18_right2 - win6_16_right2;
               norm10_right <= win10_18_right2 - win6_16_right2;
               norm11_right <= win11_18_right2 - win6_16_right2;
             end
           else if(count_cols==9)
             begin
               norm1_right <= win1_19_right2 - win6_16_right2;
               norm2_right <= win2_19_right2 - win6_16_right2;
               norm3_right <= win3_19_right2 - win6_16_right2;
               norm4_right <= win4_19_right2 - win6_16_right2;
               norm5_right <= win5_19_right2 - win6_16_right2;
               norm6_right <= win6_19_right2 - win6_16_right2;
               norm7_right <= win7_19_right2 - win6_16_right2;
               norm8_right <= win8_19_right2 - win6_16_right2;
               norm9_right <= win9_19_right2 - win6_16_right2;
               norm10_right <= win10_19_right2 - win6_16_right2;
               norm11_right <= win11_19_right2 - win6_16_right2;
             end
           else if(count_cols==10)
             begin
               norm1_right <= win1_20_right2 - win6_16_right2;
               norm2_right <= win2_20_right2 - win6_16_right2;
               norm3_right <= win3_20_right2 - win6_16_right2;
               norm4_right <= win4_20_right2 - win6_16_right2;
               norm5_right <= win5_20_right2 - win6_16_right2;
               norm6_right <= win6_20_right2 - win6_16_right2;
               norm7_right <= win7_20_right2 - win6_16_right2;
               norm8_right <= win8_20_right2 - win6_16_right2;
               norm9_right <= win9_20_right2 - win6_16_right2;
               norm10_right <= win10_20_right2 - win6_16_right2;
               norm11_right <= win11_20_right2 - win6_16_right2;
             end
           else if(count_cols==11)
             begin
               norm1_right <= win1_21_right2 - win6_16_right2;
               norm2_right <= win2_21_right2 - win6_16_right2;
               norm3_right <= win3_21_right2 - win6_16_right2;
               norm4_right <= win4_21_right2 - win6_16_right2;
               norm5_right <= win5_21_right2 - win6_16_right2;
               norm6_right <= win6_21_right2 - win6_16_right2;
               norm7_right <= win7_21_right2 - win6_16_right2;
               norm8_right <= win8_21_right2 - win6_16_right2;
               norm9_right <= win9_21_right2 - win6_16_right2;
               norm10_right <= win10_21_right2 - win6_16_right2;
               norm11_right <= win11_21_right2 - win6_16_right2;
             end
           else
             begin
               norm1_right <= 9'd0;
               norm2_right <= 9'd0;
               norm3_right <= 9'd0;
               norm4_right <= 9'd0;
               norm5_right <= 9'd0;
               norm6_right <= 9'd0;
               norm7_right <= 9'd0;
               norm8_right <= 9'd0;
               norm9_right <= 9'd0;
               norm10_right <= 9'd0;
               norm11_right <= 9'd0;
             end
        end
    end
end    
          

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      sum_tp7 <= 11'd0;
      sum_tp8 <= 11'd0;
      sum_tp9 <= 11'd0;
    end
  else if(start==1)
    begin
      sum_tp7 <= 11'd0;
      sum_tp8 <= 11'd0;
      sum_tp9 <= 11'd0;
	end
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    sum_tp7 <= sum_tp1 + sum_tp2;
	    sum_tp8 <= sum_tp3 + sum_tp4;
	    sum_tp9 <= sum_tp5 + sum_tp6;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    sum_tp7 <= sum_tp1 + sum_tp2;
	    sum_tp8 <= sum_tp3 + sum_tp4;
	    sum_tp9 <= sum_tp5 + sum_tp6;
	  end	    
  else
    begin
	    sum_tp7 <= 11'd0;
      sum_tp8 <= 11'd0;
      sum_tp9 <= 11'd0;
	end
end	
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      count_cols_late1 <= 4'd0;
      count_cols_late2 <= 4'd0;
      count_cols_late3 <= 4'd0;
      count_cols_late4 <= 4'd0;
      count_cols_late5 <= 4'd0;
      count_windows_late1 <= 4'd0;
      count_windows_late2 <= 4'd0;
      count_windows_late3 <= 4'd0;
      count_windows_late4 <= 4'd0;
      count_windows_late5 <= 4'd0;
    end
  else
    begin
      count_cols_late1 <= count_cols;
      count_cols_late2 <= count_cols_late1;
      count_cols_late3 <= count_cols_late2;
      count_cols_late4 <= count_cols_late3;
      count_cols_late5 <= count_cols_late4;
      count_windows_late1 <= count_windows;
      count_windows_late2 <= count_windows_late1;
      count_windows_late3 <= count_windows_late2;
      count_windows_late4 <= count_windows_late3;
      count_windows_late5 <= count_windows_late4;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w1 <= 12'd0;
  else if(start==1)
    max_sum_w1 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==1 && sum>max_sum_w1)
	      max_sum_w1 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==1 && sum>max_sum_w1)
	      max_sum_w1 <= sum;
	  end
  else
    max_sum_w1 <= 12'd0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w2 <= 12'd0;
  else if(start==1)
    max_sum_w2 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==2 && sum>max_sum_w2)
	      max_sum_w2 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==2 && sum>max_sum_w2)
	      max_sum_w2 <= sum;
	  end 
  else
    max_sum_w2 <= 12'd0;
end	
	
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w3 <= 12'd0;
  else if(start==1)
    max_sum_w3 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==3 && sum>max_sum_w3)
	      max_sum_w3 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==3 && sum>max_sum_w3)
	      max_sum_w3 <= sum;
	  end
  else
    max_sum_w3 <= 12'd0;
end	
    
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w4 <= 12'd0;
  else if(start==1)
    max_sum_w4 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==4 && sum>max_sum_w4)
	      max_sum_w4 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==4 && sum>max_sum_w4)
	      max_sum_w4 <= sum;
	  end
  else
    max_sum_w4 <= 12'd0;
end	    

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w5 <= 12'd0;
  else if(start==1)
    max_sum_w5 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==5 && sum>max_sum_w5)
	      max_sum_w5 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==5 && sum>max_sum_w5)
	       max_sum_w5 <= sum;
	  end
  else
    max_sum_w5 <= 12'd0;
end	 

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w6 <= 12'd0;
  else if(start==1)
    max_sum_w6 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==6 && sum>max_sum_w6)
	      max_sum_w6 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==6 && sum>max_sum_w6)
	      max_sum_w6 <= sum;
	  end
  else
    max_sum_w6 <= 12'd0;
end	               

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w7 <= 12'd0;
  else if(start==1)
    max_sum_w7 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==7 && sum>max_sum_w7)
	      max_sum_w7 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==7 && sum>max_sum_w7)
	      max_sum_w7 <= sum;
	  end
  else
    max_sum_w7 <= 12'd0;
end	             
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w8 <= 12'd0;
  else if(start==1)
    max_sum_w8 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==8 && sum>max_sum_w8)
	      max_sum_w8 <= sum;
   	end
  else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
    begin
	    if(count_windows_late2==8 && sum>max_sum_w8)
	      max_sum_w8 <= sum;
   	end
  else
    max_sum_w8 <= 12'd0;
end	

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w9 <= 12'd0;
  else if(start==1)
    max_sum_w9 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==9 && sum>max_sum_w9)
	      max_sum_w9 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==9 && sum>max_sum_w9)
	      max_sum_w9 <= sum;
	  end
  else
    max_sum_w9 <= 12'd0;
end 

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w10 <= 12'd0;
  else if(start==1)
    max_sum_w10 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==10 && sum>max_sum_w10)
	      max_sum_w10 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==10 && sum>max_sum_w10)
	      max_sum_w10 <= sum;
	  end
  else
    max_sum_w10 <= 12'd0;
end 

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    max_sum_w11 <= 12'd0;
  else if(start==1)
    max_sum_w11 <= 12'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
	    if(count_windows_late2==11 && sum>max_sum_w11)
	      max_sum_w11 <= sum;
	  end
	else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
	  begin
	    if(count_windows_late2==11 && sum>max_sum_w11)
	      max_sum_w11 <= sum;
	  end
  else
    max_sum_w11 <= 12'd0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestdist <= 12'd0;
  else if(start==1)
    bestdist <= 12'd4095;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
      if(count_cols_late3==11)
        begin
          if(count_windows_late3==1 && bestdist>max_sum_w1)
            bestdist <= max_sum_w1;
          else if(count_windows_late3==2 && bestdist>max_sum_w2)
            bestdist <= max_sum_w2;
          else if(count_windows_late3==3 && bestdist>max_sum_w3)
            bestdist <= max_sum_w3;
          else if(count_windows_late3==4 && bestdist>max_sum_w4)
            bestdist <= max_sum_w4;
          else if(count_windows_late3==5 && bestdist>max_sum_w5)
            bestdist <= max_sum_w5;
          else if(count_windows_late3==6 && bestdist>max_sum_w6)
            bestdist <= max_sum_w6;
          else if(count_windows_late3==7 && bestdist>max_sum_w7)
            bestdist <= max_sum_w7;
          else if(count_windows_late3==8 && bestdist>max_sum_w8)
            bestdist <= max_sum_w8;
          else if(count_windows_late3==9 && bestdist>max_sum_w9)
            bestdist <= max_sum_w9;
          else if(count_windows_late3==10 && bestdist>max_sum_w10)
            bestdist <= max_sum_w10;
          else if(count_windows_late3==11 && bestdist>max_sum_w11)
            bestdist <= max_sum_w11;
        end
    end
  else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
    begin
      if(count_cols_late3==11)
        begin
          if(count_windows_late3==1 && bestdist>max_sum_w1)
            bestdist <= max_sum_w1;
          else if(count_windows_late3==2 && bestdist>max_sum_w2)
            bestdist <= max_sum_w2;
          else if(count_windows_late3==3 && bestdist>max_sum_w3)
            bestdist <= max_sum_w3;
          else if(count_windows_late3==4 && bestdist>max_sum_w4)
            bestdist <= max_sum_w4;
          else if(count_windows_late3==5 && bestdist>max_sum_w5)
            bestdist <= max_sum_w5;
          else if(count_windows_late3==6 && bestdist>max_sum_w6)
            bestdist <= max_sum_w6;
          else if(count_windows_late3==7 && bestdist>max_sum_w7)
            bestdist <= max_sum_w7;
          else if(count_windows_late3==8 && bestdist>max_sum_w8)
            bestdist <= max_sum_w8;
          else if(count_windows_late3==9 && bestdist>max_sum_w9)
            bestdist <= max_sum_w9;
          else if(count_windows_late3==10 && bestdist>max_sum_w10)
            bestdist <= max_sum_w10;
          else if(count_windows_late3==11 && bestdist>max_sum_w11)
            bestdist <= max_sum_w11;
        end
    end
  else
    bestdist <= 12'd4095;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestincR <= 4'd0;
  else if(start==1)
    bestincR <= 4'd0;
  else if(XY_left1==XY_in_left && XY_right1==XY_in_right && XYOXYO_tc_tp5[23:22]==2'b01)
    begin
      if(count_cols_late3==11)
        begin
          if(count_windows_late3==1 && bestdist>max_sum_w1)
            bestincR <= 4'd1;
          else if(count_windows_late3==2 && bestdist>max_sum_w2)
            bestincR <= 4'd2;
          else if(count_windows_late3==3 && bestdist>max_sum_w3)
            bestincR <= 4'd3;
          else if(count_windows_late3==4 && bestdist>max_sum_w4)
            bestincR <= 4'd4;
          else if(count_windows_late3==5 && bestdist>max_sum_w5)
            bestincR <= 4'd5;
          else if(count_windows_late3==6 && bestdist>max_sum_w6)
            bestincR <= 4'd6;
          else if(count_windows_late3==7 && bestdist>max_sum_w7)
            bestincR <= 4'd7;
          else if(count_windows_late3==8 && bestdist>max_sum_w8)
            bestincR <= 4'd8;
          else if(count_windows_late3==9 && bestdist>max_sum_w9)
            bestincR <= 4'd9;
          else if(count_windows_late3==10 && bestdist>max_sum_w10)
            bestincR <= 4'd10;
          else if(count_windows_late3==11 && bestdist>max_sum_w11)
            bestincR <= 4'd11; 
        end
    end
  else if(XY_left2==scaledXY_left && XY_right2==scaledXY_right && XYOXYO_tc_tp5[23:22]==2'b10)
    begin
      if(count_cols_late3==11)
        begin
          if(count_windows_late3==1 && bestdist>max_sum_w1)
            bestincR <= 4'd1;
          else if(count_windows_late3==2 && bestdist>max_sum_w2)
            bestincR <= 4'd2;
          else if(count_windows_late3==3 && bestdist>max_sum_w3)
            bestincR <= 4'd3;
          else if(count_windows_late3==4 && bestdist>max_sum_w4)
            bestincR <= 4'd4;
          else if(count_windows_late3==5 && bestdist>max_sum_w5)
            bestincR <= 4'd5;
          else if(count_windows_late3==6 && bestdist>max_sum_w6)
            bestincR <= 4'd6;
          else if(count_windows_late3==7 && bestdist>max_sum_w7)
            bestincR <= 4'd7;
          else if(count_windows_late3==8 && bestdist>max_sum_w8)
            bestincR <= 4'd8;
          else if(count_windows_late3==9 && bestdist>max_sum_w9)
            bestincR <= 4'd9;
          else if(count_windows_late3==10 && bestdist>max_sum_w10)
            bestincR <= 4'd10;
          else if(count_windows_late3==11 && bestdist>max_sum_w11)
            bestincR <= 4'd11; 
        end
    end
  else
    bestincR <= 4'd0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      dist1 <= 12'd0;
      dist2 <= 12'd0;
      dist3 <= 12'd0;
    end
  else if(start==1)
    begin
      dist1 <= 12'd0;
      dist2 <= 12'd0;
      dist3 <= 12'd0;
    end
  else if(count_windows_late4==11 && count_cols_late4==11)
    begin
      if(bestincR==2)
        begin
          dist1 <= max_sum_w1;
          dist2 <= max_sum_w2;
          dist3 <= max_sum_w3;
        end
      else if(bestincR==3)
        begin
          dist1 <= max_sum_w2;
          dist2 <= max_sum_w3;
          dist3 <= max_sum_w4;
        end
      else if(bestincR==4)
        begin
          dist1 <= max_sum_w3;
          dist2 <= max_sum_w4;
          dist3 <= max_sum_w5;
        end
      else if(bestincR==5)
        begin
          dist1 <= max_sum_w4;
          dist2 <= max_sum_w5;
          dist3 <= max_sum_w6;
        end
      else if(bestincR==6)
        begin
          dist1 <= max_sum_w5;
          dist2 <= max_sum_w6;
          dist3 <= max_sum_w7;
        end
      else if(bestincR==7)
        begin
          dist1 <= max_sum_w6;
          dist2 <= max_sum_w7;
          dist3 <= max_sum_w8;
        end
      else if(bestincR==8)
        begin
          dist1 <= max_sum_w7;
          dist2 <= max_sum_w8;
          dist3 <= max_sum_w9;
        end
      else if(bestincR==9)
        begin
          dist1 <= max_sum_w8;
          dist2 <= max_sum_w9;
          dist3 <= max_sum_w10;
        end
      else if(bestincR==10)
        begin
          dist1 <= max_sum_w9;
          dist2 <= max_sum_w10;
          dist3 <= max_sum_w11;
        end
    end
  else
    begin
      dist1 <= 12'd0;
      dist2 <= 12'd0;
      dist3 <= 12'd0;
    end
end              

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_dR <= 1'b0;
  else if(start==1)
    en_dR <= 1'b0;
  else if(count_cols_late4==11 && count_windows_late4==11)
    begin
      if(bestincR>1 && bestincR<11)
        en_dR <= 1'b1;
      else
        en_dR <= 1'b0;
    end
  else
    en_dR <= 1'b0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_arith <= 6'd0;
  else if(start==1)
    count_arith <= 6'd0;
  else if(en_dR==1)
    begin
      if(count_arith<41)
        count_arith <= count_arith + 1'b1;
    end
  else
    count_arith <= 6'd0;
end    


div2 dR1(.aclr(aclr),
         .clken(en_dR),
         .clock(clk),
         .denom(denom),
         .numer(numer),
         .quotient(deltaR),
         .remain());
         
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    deltaR_bestuR <= 13'd0;
  else if(deltaR[24]==1 && deltaR[12]==1)
    deltaR_bestuR <= {1'b1,deltaR[11:0]};
  else if(deltaR[24]==0 && deltaR[12]==0)
    deltaR_bestuR <= {1'b0,deltaR[11:0]};
  else
    deltaR_bestuR <= 13'd0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_bestuR <= 1'b0;
  else if(start==1)
    en_bestuR <= 1'b0;
  else if(en_dR==1 && count_arith>14)
    begin
      if(deltaR[24]==1 && deltaR[12]==1)
        en_bestuR <= 1'b1;
      else if(deltaR[24]==0 && deltaR[12]==0)
        en_bestuR <= 1'b1;
      else
        en_bestuR <= 1'b0;
    end
  else
    en_bestuR <= 1'b0;
end    

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestuR_tp1 <= 23'd0;
  else if(start==1)
    bestuR_tp1 <= 23'd0;
  else if(en_bestuR==1)
    begin
      if(count_arith==16)
        begin
          if(bestincR==2)
            bestuR_tp1 <= a + deltaR_bestuR;
          else if(bestincR==3)
            bestuR_tp1 <= b + deltaR_bestuR;
          else if(bestincR==4)
            bestuR_tp1 <= c + deltaR_bestuR;
          else if(bestincR==5)
            bestuR_tp1 <= d + deltaR_bestuR;
          else if(bestincR==6)
            bestuR_tp1 <= X_right_bestuR + deltaR_bestuR;
          else if(bestincR==7)
            bestuR_tp1 <= e + deltaR_bestuR;
          else if(bestincR==8)
            bestuR_tp1 <= f + deltaR_bestuR;
          else if(bestincR==9)
            bestuR_tp1 <= g + deltaR_bestuR;
          else if(bestincR==10)
            bestuR_tp1 <= h + deltaR_bestuR;
        end
    end
  else
    bestuR_tp1 <= 23'd0;
end     

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_mul10 <= 1'b0;
  else 
    en_mul10 <= en_bestuR;
end    

mul10 m5(.clock(clk),
         .aclr(aclr),
         .clken(en_mul10),
         .dataa(bestuR_tp2),
         .result(bestuR_tp3));

always@(posedge clk or  negedge rst_n)
begin
  if(!rst_n)
    begin
      bestuR_tp4 <= 22'd0;
      bestuR_tp5 <= 22'd0;
      bestuR_tp6 <= 22'd0;
      bestuR_tp7 <= 22'd0;
      bestuR_tp8 <= 22'd0;
    end
  else if(start==1)
    begin
      bestuR_tp4 <= 22'd0;
      bestuR_tp5 <= 22'd0;
      bestuR_tp6 <= 22'd0;
      bestuR_tp7 <= 22'd0;
      bestuR_tp8 <= 22'd0;
    end
  else
    begin
      bestuR_tp4 <= bestuR_tp2;
      bestuR_tp5 <= bestuR_tp4;
      bestuR_tp6 <= bestuR_tp5;
      bestuR_tp7 <= bestuR_tp6;
      bestuR_tp8 <= bestuR_tp7;
    end
end    
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    disparity <= 23'd0;
  else if(start==1)
    disparity <= 23'd0;
  else if(en_bestuR==1)
    begin
      if(count_arith==22)
        disparity <= {XYOXYO_tc_tp5[43:34],12'd0} - bestuR;
    end
  else
    disparity <= 23'd0;
end  

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_depth <= 1'b0;
  else if(start==1)
    en_depth <= 1'b0;
  else if(en_bestuR==1)
    begin
      if(count_arith==23)
        begin
          if(disparity[22]==0 && disparity<maxD)
            en_depth <= 1'b1;
          else
            en_depth <= 1'b0;
        end
    end
  else
    en_depth <= 1'b0;
end

div3 ddep (.aclr(aclr),
           .clken(en_depth),
           .clock(clk),
           .denom(disparity_depth),
           .numer(mbf_depth),
           .quotient(depth),
           .remain());   
           
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_out_tp <= 15'd0;
  else if(start==1)
    addr_out_tp <= 15'd0;
  else if(en_depth==1 && count_arith==40)
    addr_out_tp <= addr_out_tp + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    depth_out <= 33'd0;
  else if(start==1)
    depth_out <= 33'd0;
  else if(en_depth==1 && count_arith==40)
    depth_out <= depth;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestuR_out <= 22'd0;
  else if(start==1)
    bestuR_out <= 22'd0;
  else if(en_depth==1 && count_arith==40)
    bestuR_out <= bestuR;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    XYOXYO_out <= 44'd0;
  else if(start==1)
    XYOXYO_out <= 44'd0;
  else if(en_depth==1 && count_arith==40)
    XYOXYO_out <= XYOXYO_tc_tp5;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestdist_out <= 12'd0;
  else if(start==1)
    bestdist_out <= 12'd0;
  else if(en_depth==1 && count_arith==40)
    bestdist_out <= bestdist;
end               

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    endl <= 1'b0;
  else if(start==1)
    endl <= 1'b0;
  else if(endl_tp3==1 && XYOXYO[33:24]==XYOXYO_tc[33:24] && XYOXYO[21:12]<XYOXYO_tc[21:12] && XYOXYO[23:22]==2'b01)
    endl <= 1'b1;
  else if(endl_tp8==1 && scaledY_left==scaledXY_left[9:0])
    begin
      if(scaledX_left<scaledXY_left[19:10] || scaledX_right<scaledXY_right[19:10])
        endl <= 1'b1;
      else if(scaledX_left==scaledXY_left[19:10] && scaledX_right==scaledXY_right[19:10])
        endl <= 1'b1;
      else
        endl <= 1'b0;
    end
  else if(count_cols_late5==10 && count_windows_late5==11)
    begin
      if(bestincR==1 || bestincR==11)
        endl <= 1'b1;
    end
  else if(count_cols_late5==11 && count_windows_late5==11)
    begin
      if(count_arith==15)
        begin
          if(deltaR[24]==1 && deltaR[12]==0)
            endl <= 1'b1;
          else if(deltaR[24]==0 && deltaR[12]==1)
            endl <= 1'b1;
        end
      else if(count_arith==23 && en_bestuR==1)
        begin
          if(disparity[22]==1 || disparity>=maxD)
            endl <= 1'b1;
        end
      else if(count_arith==40 && en_depth==1)
        endl <= 1'b1;
      else
        endl <= 1'b0;
    end
  else
    endl <= 1'b0;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      endl_tp1 <= 1'b0;
      endl_tp2 <= 1'b0;
      endl_tp3 <= 1'b0;
      endl_tp4 <= 1'b0;
      endl_tp5 <= 1'b0;
      endl_tp6 <= 1'b0;
      endl_tp7 <= 1'b0;
      endl_tp8 <= 1'b0;
    end
  else if(start==1)
    begin
      endl_tp1 <= 1'b0;
      endl_tp2 <= 1'b0;
      endl_tp3 <= 1'b0;
      endl_tp4 <= 1'b0;
      endl_tp5 <= 1'b0;
      endl_tp6 <= 1'b0;
      endl_tp7 <= 1'b0;
      endl_tp8 <= 1'b0;
    end
  else
    begin
      endl_tp1 <= endl;
      endl_tp2 <= endl_tp1;
      endl_tp3 <= endl_tp2;
      endl_tp4 <= endl_tp3;
      endl_tp5 <= endl_tp4;
      endl_tp6 <= endl_tp5;
      endl_tp7 <= endl_tp6;
      endl_tp8 <= endl_tp7;    
    end
end
  
    
    
endmodule