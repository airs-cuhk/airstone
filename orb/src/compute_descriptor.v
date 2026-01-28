module compute_descriptor(start,clk,rst_n,din,addr_corner,addr_b,total,XY_in,sc_in,addr_mod1,addr_mod2,mod1,mod2,dout,addr_out,end_cd,wren);
  input start;
  input clk;
  input rst_n;
  input din;
  input total;
  input XY_in;
  input sc_in;
  input mod1,mod2;
  output addr_b;
  output addr_corner;
  output addr_mod1,addr_mod2;
  output dout;
  output addr_out;
  output end_cd;
  output wren;
  parameter width_ext=678,height_ext=518,border=3;
  
  wire [7:0] din;
  wire [13:0] total;
  wire [19:0] XY_in;
  wire [25:0] sc_in;
  wire [9:0] mod1,mod2;
  reg [13:0] addr_corner;
  reg [18:0] addr_b;
  reg [8:0] addr_mod1,addr_mod2;
  reg [7:0] dout;
  wire [18:0] addr_out;
  reg [18:0] addr_out_temp;
  
  
  
  wire [17:0] data_mid_temp;
  wire [18:0] addr_mid;
  wire [7:0] data_mid;
  reg [9:0] count;
  reg [9:0] count_2;
 
  reg [9:0] X_mid,Y_mid;
  reg [9:0] X,Y;
  wire [19:0] XY;
  wire signed [12:0] sin;
  wire signed [12:0] cos;
  wire signed [4:0] mod1_X,mod1_Y;
  wire signed [4:0] mod2_X,mod2_Y;
  wire signed [17:0] X1_temp,Y1_temp,X2_temp,Y2_temp;
  wire signed [17:0] X1_temp_tp1,X1_temp_tp2,Y1_temp_tp1,Y1_temp_tp2,X2_temp_tp1,X2_temp_tp2,Y2_temp_tp1,Y2_temp_tp2;
  reg signed [4:0] X1,Y1,X2,Y2;
  reg signed [4:0] X1_tp,Y1_tp,X2_tp,Y2_tp;
  reg [7:0] data_1,data_2;
  reg [7:0] data_1_00,data_1_01,data_1_10,data_1_11;
  reg [7:0] data_2_00,data_2_01,data_2_10,data_2_11;
  reg [3:0] count_bit;
  reg bit0,bit1,bit2,bit3,bit4,bit5,bit6,bit7;
  reg [5:0] flag;
  reg end_cd;
  reg wren;
  wire [18:0] totalx32;
  
 
  
  reg [2:0] num;
  reg en;
  reg en_XY_mid;
  reg en_2;
  reg en_XY;
  reg sel;
  reg sel_2;
  wire aclr;
  wire clken_mul;
  
  wire [7:0] taps1,taps2,taps3,taps4,taps5,taps6,taps7;
  wire [7:0] taps_1,taps_2,taps_3,taps_4,taps_5,taps_6,taps_7,taps_8,taps_9,taps_10,taps_11,taps_12,taps_13,taps_14,taps_15,taps_16
         ,taps_17,taps_18,taps_19,taps_20,taps_21,taps_22,taps_23,taps_24,taps_25,taps_26,taps_27,taps_28,taps_29,taps_30,taps_31;
  reg [7:0] win77,win76,win75,win74,win73,win72,win71;
  reg [7:0] win67,win66,win65,win64,win63,win62,win61;
  reg [7:0] win57,win56,win55,win54,win53,win52,win51;
  reg [7:0] win47,win46,win45,win44,win43,win42,win41;
  reg [7:0] win37,win36,win35,win34,win33,win32,win31;
  reg [7:0] win27,win26,win25,win24,win23,win22,win21;
  reg [7:0] win17,win16,win15,win14,win13,win12,win11;
  
  reg [7:0] win31_31,win31_30,win31_29,win31_28,win31_27,win31_26,win31_25,win31_24,win31_23,win31_22,win31_21,win31_20,
            win31_19,win31_18,win31_17,win31_16,win31_15,win31_14,win31_13,win31_12,win31_11,win31_10,win31_9,win31_8,
            win31_7,win31_6,win31_5,win31_4,win31_3,win31_2,win31_1;
  reg [7:0] win30_31,win30_30,win30_29,win30_28,win30_27,win30_26,win30_25,win30_24,win30_23,win30_22,win30_21,win30_20,
            win30_19,win30_18,win30_17,win30_16,win30_15,win30_14,win30_13,win30_12,win30_11,win30_10,win30_9,win30_8,
            win30_7,win30_6,win30_5,win30_4,win30_3,win30_2,win30_1; 
  reg [7:0] win29_31,win29_30,win29_29,win29_28,win29_27,win29_26,win29_25,win29_24,win29_23,win29_22,win29_21,win29_20,
            win29_19,win29_18,win29_17,win29_16,win29_15,win29_14,win29_13,win29_12,win29_11,win29_10,win29_9,win29_8,
            win29_7,win29_6,win29_5,win29_4,win29_3,win29_2,win29_1;
  reg [7:0] win28_31,win28_30,win28_29,win28_28,win28_27,win28_26,win28_25,win28_24,win28_23,win28_22,win28_21,win28_20,
            win28_19,win28_18,win28_17,win28_16,win28_15,win28_14,win28_13,win28_12,win28_11,win28_10,win28_9,win28_8,
            win28_7,win28_6,win28_5,win28_4,win28_3,win28_2,win28_1;
  reg [7:0] win27_31,win27_30,win27_29,win27_28,win27_27,win27_26,win27_25,win27_24,win27_23,win27_22,win27_21,win27_20,
            win27_19,win27_18,win27_17,win27_16,win27_15,win27_14,win27_13,win27_12,win27_11,win27_10,win27_9,win27_8,
            win27_7,win27_6,win27_5,win27_4,win27_3,win27_2,win27_1;
  reg [7:0] win26_31,win26_30,win26_29,win26_28,win26_27,win26_26,win26_25,win26_24,win26_23,win26_22,win26_21,win26_20,
            win26_19,win26_18,win26_17,win26_16,win26_15,win26_14,win26_13,win26_12,win26_11,win26_10,win26_9,win26_8,
            win26_7,win26_6,win26_5,win26_4,win26_3,win26_2,win26_1;
  reg [7:0] win25_31,win25_30,win25_29,win25_28,win25_27,win25_26,win25_25,win25_24,win25_23,win25_22,win25_21,win25_20,
            win25_19,win25_18,win25_17,win25_16,win25_15,win25_14,win25_13,win25_12,win25_11,win25_10,win25_9,win25_8,
            win25_7,win25_6,win25_5,win25_4,win25_3,win25_2,win25_1;  
  reg [7:0] win24_31,win24_30,win24_29,win24_28,win24_27,win24_26,win24_25,win24_24,win24_23,win24_22,win24_21,win24_20,
            win24_19,win24_18,win24_17,win24_16,win24_15,win24_14,win24_13,win24_12,win24_11,win24_10,win24_9,win24_8,
            win24_7,win24_6,win24_5,win24_4,win24_3,win24_2,win24_1;
  reg [7:0] win23_31,win23_30,win23_29,win23_28,win23_27,win23_26,win23_25,win23_24,win23_23,win23_22,win23_21,win23_20,
            win23_19,win23_18,win23_17,win23_16,win23_15,win23_14,win23_13,win23_12,win23_11,win23_10,win23_9,win23_8,
            win23_7,win23_6,win23_5,win23_4,win23_3,win23_2,win23_1;
  reg [7:0] win22_31,win22_30,win22_29,win22_28,win22_27,win22_26,win22_25,win22_24,win22_23,win22_22,win22_21,win22_20,
            win22_19,win22_18,win22_17,win22_16,win22_15,win22_14,win22_13,win22_12,win22_11,win22_10,win22_9,win22_8,
            win22_7,win22_6,win22_5,win22_4,win22_3,win22_2,win22_1;
  reg [7:0] win21_31,win21_30,win21_29,win21_28,win21_27,win21_26,win21_25,win21_24,win21_23,win21_22,win21_21,win21_20,
            win21_19,win21_18,win21_17,win21_16,win21_15,win21_14,win21_13,win21_12,win21_11,win21_10,win21_9,win21_8,
            win21_7,win21_6,win21_5,win21_4,win21_3,win21_2,win21_1;
  reg [7:0] win20_31,win20_30,win20_29,win20_28,win20_27,win20_26,win20_25,win20_24,win20_23,win20_22,win20_21,win20_20,
            win20_19,win20_18,win20_17,win20_16,win20_15,win20_14,win20_13,win20_12,win20_11,win20_10,win20_9,win20_8,
            win20_7,win20_6,win20_5,win20_4,win20_3,win20_2,win20_1;
  reg [7:0] win19_31,win19_30,win19_29,win19_28,win19_27,win19_26,win19_25,win19_24,win19_23,win19_22,win19_21,win19_20,
            win19_19,win19_18,win19_17,win19_16,win19_15,win19_14,win19_13,win19_12,win19_11,win19_10,win19_9,win19_8,
            win19_7,win19_6,win19_5,win19_4,win19_3,win19_2,win19_1;
  reg [7:0] win18_31,win18_30,win18_29,win18_28,win18_27,win18_26,win18_25,win18_24,win18_23,win18_22,win18_21,win18_20,
            win18_19,win18_18,win18_17,win18_16,win18_15,win18_14,win18_13,win18_12,win18_11,win18_10,win18_9,win18_8,
            win18_7,win18_6,win18_5,win18_4,win18_3,win18_2,win18_1;
  reg [7:0] win17_31,win17_30,win17_29,win17_28,win17_27,win17_26,win17_25,win17_24,win17_23,win17_22,win17_21,win17_20,
            win17_19,win17_18,win17_17,win17_16,win17_15,win17_14,win17_13,win17_12,win17_11,win17_10,win17_9,win17_8,
            win17_7,win17_6,win17_5,win17_4,win17_3,win17_2,win17_1;
  reg [7:0] win16_31,win16_30,win16_29,win16_28,win16_27,win16_26,win16_25,win16_24,win16_23,win16_22,win16_21,win16_20,
            win16_19,win16_18,win16_17,win16_16,win16_15,win16_14,win16_13,win16_12,win16_11,win16_10,win16_9,win16_8,
            win16_7,win16_6,win16_5,win16_4,win16_3,win16_2,win16_1;
  reg [7:0] win15_31,win15_30,win15_29,win15_28,win15_27,win15_26,win15_25,win15_24,win15_23,win15_22,win15_21,win15_20,
            win15_19,win15_18,win15_17,win15_16,win15_15,win15_14,win15_13,win15_12,win15_11,win15_10,win15_9,win15_8,
            win15_7,win15_6,win15_5,win15_4,win15_3,win15_2,win15_1;  
  reg [7:0] win14_31,win14_30,win14_29,win14_28,win14_27,win14_26,win14_25,win14_24,win14_23,win14_22,win14_21,win14_20,
            win14_19,win14_18,win14_17,win14_16,win14_15,win14_14,win14_13,win14_12,win14_11,win14_10,win14_9,win14_8,
            win14_7,win14_6,win14_5,win14_4,win14_3,win14_2,win14_1;
  reg [7:0] win13_31,win13_30,win13_29,win13_28,win13_27,win13_26,win13_25,win13_24,win13_23,win13_22,win13_21,win13_20,
            win13_19,win13_18,win13_17,win13_16,win13_15,win13_14,win13_13,win13_12,win13_11,win13_10,win13_9,win13_8,
            win13_7,win13_6,win13_5,win13_4,win13_3,win13_2,win13_1;
  reg [7:0] win12_31,win12_30,win12_29,win12_28,win12_27,win12_26,win12_25,win12_24,win12_23,win12_22,win12_21,win12_20,
            win12_19,win12_18,win12_17,win12_16,win12_15,win12_14,win12_13,win12_12,win12_11,win12_10,win12_9,win12_8,
            win12_7,win12_6,win12_5,win12_4,win12_3,win12_2,win12_1;
  reg [7:0] win11_31,win11_30,win11_29,win11_28,win11_27,win11_26,win11_25,win11_24,win11_23,win11_22,win11_21,win11_20,
            win11_19,win11_18,win11_17,win11_16,win11_15,win11_14,win11_13,win11_12,win11_11,win11_10,win11_9,win11_8,
            win11_7,win11_6,win11_5,win11_4,win11_3,win11_2,win11_1;
  reg [7:0] win10_31,win10_30,win10_29,win10_28,win10_27,win10_26,win10_25,win10_24,win10_23,win10_22,win10_21,win10_20,
            win10_19,win10_18,win10_17,win10_16,win10_15,win10_14,win10_13,win10_12,win10_11,win10_10,win10_9,win10_8,
            win10_7,win10_6,win10_5,win10_4,win10_3,win10_2,win10_1;
  reg [7:0] win9_31,win9_30,win9_29,win9_28,win9_27,win9_26,win9_25,win9_24,win9_23,win9_22,win9_21,win9_20,
            win9_19,win9_18,win9_17,win9_16,win9_15,win9_14,win9_13,win9_12,win9_11,win9_10,win9_9,win9_8,
            win9_7,win9_6,win9_5,win9_4,win9_3,win9_2,win9_1;  
  reg [7:0] win8_31,win8_30,win8_29,win8_28,win8_27,win8_26,win8_25,win8_24,win8_23,win8_22,win8_21,win8_20,
            win8_19,win8_18,win8_17,win8_16,win8_15,win8_14,win8_13,win8_12,win8_11,win8_10,win8_9,win8_8,
            win8_7,win8_6,win8_5,win8_4,win8_3,win8_2,win8_1;
  reg [7:0] win7_31,win7_30,win7_29,win7_28,win7_27,win7_26,win7_25,win7_24,win7_23,win7_22,win7_21,win7_20,
            win7_19,win7_18,win7_17,win7_16,win7_15,win7_14,win7_13,win7_12,win7_11,win7_10,win7_9,win7_8,
            win7_7,win7_6,win7_5,win7_4,win7_3,win7_2,win7_1;
  reg [7:0] win6_31,win6_30,win6_29,win6_28,win6_27,win6_26,win6_25,win6_24,win6_23,win6_22,win6_21,win6_20,
            win6_19,win6_18,win6_17,win6_16,win6_15,win6_14,win6_13,win6_12,win6_11,win6_10,win6_9,win6_8,
            win6_7,win6_6,win6_5,win6_4,win6_3,win6_2,win6_1;
  reg [7:0] win5_31,win5_30,win5_29,win5_28,win5_27,win5_26,win5_25,win5_24,win5_23,win5_22,win5_21,win5_20,
            win5_19,win5_18,win5_17,win5_16,win5_15,win5_14,win5_13,win5_12,win5_11,win5_10,win5_9,win5_8,
            win5_7,win5_6,win5_5,win5_4,win5_3,win5_2,win5_1; 
  reg [7:0] win4_31,win4_30,win4_29,win4_28,win4_27,win4_26,win4_25,win4_24,win4_23,win4_22,win4_21,win4_20,
            win4_19,win4_18,win4_17,win4_16,win4_15,win4_14,win4_13,win4_12,win4_11,win4_10,win4_9,win4_8,
            win4_7,win4_6,win4_5,win4_4,win4_3,win4_2,win4_1;
  reg [7:0] win3_31,win3_30,win3_29,win3_28,win3_27,win3_26,win3_25,win3_24,win3_23,win3_22,win3_21,win3_20,
            win3_19,win3_18,win3_17,win3_16,win3_15,win3_14,win3_13,win3_12,win3_11,win3_10,win3_9,win3_8,
            win3_7,win3_6,win3_5,win3_4,win3_3,win3_2,win3_1;
  reg [7:0] win2_31,win2_30,win2_29,win2_28,win2_27,win2_26,win2_25,win2_24,win2_23,win2_22,win2_21,win2_20,
            win2_19,win2_18,win2_17,win2_16,win2_15,win2_14,win2_13,win2_12,win2_11,win2_10,win2_9,win2_8,
            win2_7,win2_6,win2_5,win2_4,win2_3,win2_2,win2_1;
  reg [7:0] win1_31,win1_30,win1_29,win1_28,win1_27,win1_26,win1_25,win1_24,win1_23,win1_22,win1_21,win1_20,
            win1_19,win1_18,win1_17,win1_16,win1_15,win1_14,win1_13,win1_12,win1_11,win1_10,win1_9,win1_8,
            win1_7,win1_6,win1_5,win1_4,win1_3,win1_2,win1_1;  
  
  wire	[9:0]	win11x4;
  wire	[10:0]	win12x8;
  wire	[11:0]	win13x16;
  wire	[8:0]	win13x2;
  wire	[11:0]	win14x16;
  wire	[11:0]	win15x16;
  wire	[8:0]	win15x2;
  wire	[10:0]	win16x8;
  wire 	[9:0]	win17x4;
  
  wire	[10:0]	win21x8;
  wire	[11:0]	win22x16;
  wire	[11:0]	win23x16;
  wire	[10:0]	win23x8;
  wire	[8:0]	win23x2;
  wire	[12:0]	win24x32;
  wire	[9:0]	win24x4;
  wire	[11:0]	win25x16;
  wire	[10:0]	win25x8;
  wire	[8:0]	win25x2;
  wire	[11:0]	win26x16;
  wire	[10:0]	win27x8;
  
  wire	[11:0]	win31x16;
  wire	[8:0]	win31x2;
  wire	[11:0]	win32x16;
  wire	[10:0]	win32x8;
  wire	[8:0]	win32x2;
  wire	[12:0]	win33x32;
  wire	[9:0]	win33x4;
  wire	[12:0]	win34x32;
  wire	[10:0]	win34x8;
  wire	[8:0]	win34x2;
  wire	[12:0]	win35x32;
  wire	[9:0]	win35x4;
  wire	[11:0]	win36x16;
  wire	[10:0]	win36x8;
  wire	[8:0]	win36x2;
  wire	[11:0]	win37x16;
  wire	[8:0]	win37x2;
 
  wire	[11:0]	win41x16;
  wire	[12:0]	win42x32;
  wire	[9:0]	win42x4;
  wire	[12:0]	win43x32;
  wire	[10:0]	win43x8;
  wire	[8:0]	win43x2;
  wire	[12:0]	win44x32;
  wire	[11:0]	win44x16;
  wire	[12:0]	win45x32;
  wire	[10:0]	win45x8;
  wire	[8:0]	win45x2;
  wire	[12:0]	win46x32;
  wire	[9:0]	win46x4;
  wire	[11:0]	win47x16;
  
  wire	[11:0]	win51x16;
  wire	[8:0]	win51x2;
  wire	[11:0]	win52x16;
  wire	[10:0]	win52x8;
  wire	[8:0]	win52x2;
  wire	[12:0]	win53x32;
  wire	[9:0]	win53x4;
  wire	[12:0]	win54x32;
  wire	[10:0]	win54x8;
  wire	[8:0]	win54x2;
  wire	[12:0]	win55x32;
  wire	[9:0]	win55x4;
  wire	[11:0]	win56x16;
  wire	[10:0]	win56x8;
  wire	[8:0]	win56x2;
  wire	[11:0]	win57x16;
  wire	[8:0]	win57x2;
  
  wire	[10:0]	win61x8;
  wire	[11:0]	win62x16;
  wire	[11:0]	win63x16;
  wire	[10:0]	win63x8;
  wire	[8:0]	win63x2;
  wire	[12:0]	win64x32;
  wire	[9:0]	win64x4;
  wire	[11:0]	win65x16;
  wire	[10:0]	win65x8;
  wire	[8:0]	win65x2;
  wire	[11:0]	win66x16;
  wire	[10:0]	win67x8;
  
  wire	[9:0]	win71x4;
  wire	[10:0]	win72x8;
  wire	[11:0]	win73x16;
  wire	[8:0]	win73x2;
  wire	[11:0]	win74x16;
  wire	[11:0]	win75x16;
  wire	[8:0]	win75x2;
  wire	[10:0]	win76x8;
  wire 	[9:0]	win77x4;
  
  
  
  assign    win11x4 = {win11,2'b0};
  assign	win12x8 = {win12,3'b0};
  assign	win13x16 = {win13,4'b0};		//the LSB for the 2's of win13_2n
  assign	win13x2 = {win13,1'b0};
  assign    win14x16 = {win14, 4'b0};
  assign	win15x16 = {win15,4'b0};		//the LSB for the 2's 
  assign	win15x2 = {win15,1'b0};
  assign	win16x8 = {win16,3'b0};
  assign	win17x4 = {win17, 2'b0};
  
  assign	win21x8 = {win21,3'b0};
  assign    win22x16 = {win22, 4'b0};
  assign    win23x16 = {win23, 4'b0};
  assign	win23x8 = {win23,3'b0};
  assign	win23x2 = {win23,1'b0};
  assign    win24x32 = {win24, 5'b0};          //the LSB
  assign    win24x4 = {win24, 2'b0};
  assign    win25x16 = {win25, 4'b0};
  assign	win25x8 = {win25,3'b0};
  assign	win25x2 = {win25,1'b0};
  assign    win26x16 = {win26, 4'b0};
  assign	win27x8 = {win27,3'b0};
  
  assign	win31x16 = {win31,4'b0};		//the LSB for the 2's 
  assign	win31x2 = {win31,1'b0};
  assign    win32x16 = {win32, 4'b0};
  assign	win32x8 = {win32,3'b0};
  assign	win32x2 = {win32,1'b0};
  assign    win33x32 = {win33, 5'b0};
  assign    win33x4 = {win33, 2'b0};
  assign    win34x32 = {win34, 5'b0};
  assign    win34x8 = {win34, 3'b0};
  assign    win34x2 = {win34, 1'b0};
  assign    win35x32 = {win35, 5'd0};
  assign    win35x4 = {win35, 2'b0};
  assign    win36x16 = {win36, 4'b0};
  assign	win36x8 = {win36,3'b0};
  assign	win36x2 = {win36,1'b0};
  assign	win37x16 = {win37,4'b0};		//the LSB for the 2's 
  assign	win37x2 = {win37,1'b0};
  
  assign    win41x16 = {win41, 4'b0};
  assign    win42x32 = {win42, 5'b0};          //the LSB
  assign    win42x4 = {win42, 2'b0};
  assign    win43x32 = {win43, 5'b0};
  assign    win43x8 = {win43, 3'b0};
  assign    win43x2 = {win43, 1'b0};
  assign    win44x32 = {win44, 5'b0};
  assign    win44x16 = {win44, 4'b0};
  assign    win45x32 = {win45, 5'b0};
  assign    win45x8 = {win45, 3'b0};
  assign    win45x2 = {win45, 1'b0};
  assign    win46x32 = {win46, 5'b0};          //the LSB
  assign    win46x4 = {win46, 2'b0};
  assign    win47x16 = {win47, 4'b0};
  
  assign	win51x16 = {win51,4'b0};		//the LSB for the 2's 
  assign	win51x2 =  {win51,1'b0};
  assign    win52x16 = {win52, 4'b0};
  assign	win52x8 =  {win52,3'b0};
  assign	win52x2 =  {win52,1'b0};
  assign    win53x32 = {win53, 5'b0};
  assign    win53x4 =  {win53, 2'b0};
  assign    win54x32 = {win54, 5'b0};
  assign    win54x8 =  {win54, 3'b0};
  assign    win54x2 =  {win54, 1'b0};
  assign    win55x32 = {win55, 5'b0};
  assign    win55x4 =  {win55, 2'b0};
  assign    win56x16 = {win56, 4'b0};
  assign	win56x8 =  {win56,3'b0};
  assign	win56x2 =  {win56,1'b0};
  assign	win57x16 = {win57,4'b0};		//the LSB for the 2's 
  assign	win57x2 =  {win57,1'b0};

  
  assign	win61x8 =  {win61,3'b0};
  assign    win62x16 = {win62, 4'b0};
  assign    win63x16 = {win63, 4'b0};
  assign	win63x8 =  {win63,3'b0};
  assign	win63x2 =  {win63,1'b0};
  assign    win64x32 = {win64, 5'b0};          //the LSB
  assign    win64x4 =  {win64, 2'b0};
  assign    win65x16 = {win65, 4'b0};
  assign	win65x8 =  {win65,3'b0};
  assign	win65x2 =  {win65,1'b0};
  assign    win66x16 = {win66, 4'b0};
  assign	win67x8 =  {win67,3'b0};
  
  assign	win71x4 =  {win71,2'b0};
  assign	win72x8 =  {win72,3'b0};
  assign	win73x16 = {win73,4'b0};		//the LSB for the 2's of win13_2n
  assign	win73x2 =  {win73,1'b0};
  assign    win74x16 = {win74, 4'b0};
  assign	win75x16 = {win75,4'b0};		//the LSB for the 2's 
  assign	win75x2 =  {win75,1'b0};
  assign	win76x8 =  {win76,3'b0};
  assign	win77x4 =  {win77, 2'b0};  
  
  
  wire  [13:0]  add_tmp_101;
  wire  [13:0]  add_tmp_102;
  wire  [13:0]  add_tmp_103;
  wire  [13:0]  add_tmp_104;
  wire  [13:0]  add_tmp_105;
  wire  [13:0]  add_tmp_106;
  wire  [13:0]  add_tmp_107;
  wire  [13:0]  add_tmp_108;
  wire  [13:0]  add_tmp_109;
  wire  [13:0]  add_tmp_110;
  wire  [13:0]  add_tmp_111;
  wire  [13:0]  add_tmp_112;
  wire  [13:0]  add_tmp_113;
  wire  [13:0]  add_tmp_114;
  wire  [13:0]  add_tmp_115;
  wire  [13:0]  add_tmp_116;
  wire  [13:0]  add_tmp_117;
  wire  [13:0]  add_tmp_118;
  wire  [13:0]  add_tmp_119;
  wire  [13:0]  add_tmp_120;
  wire  [13:0]  add_tmp_121;
  wire  [13:0]  add_tmp_122;
  wire  [13:0]  add_tmp_123;
  wire  [13:0]  add_tmp_124;
  wire  [13:0]  add_tmp_125;
  wire  [13:0]  add_tmp_126;
  wire  [13:0]  add_tmp_127;
  wire  [13:0]  add_tmp_128;
  wire  [13:0]  add_tmp_129;
  wire  [13:0]  add_tmp_130;
  wire  [13:0]  add_tmp_131;
  wire  [13:0]  add_tmp_132;
  wire  [13:0]  add_tmp_133;
  wire  [13:0]  add_tmp_134;
  wire  [13:0]  add_tmp_135;
  wire  [13:0]  add_tmp_136;
  wire  [13:0]  add_tmp_137;
  wire  [13:0]  add_tmp_138;
  wire  [13:0]  add_tmp_139;
  wire  [13:0]  add_tmp_140;
  wire  [13:0]  add_tmp_141;
  wire  [13:0]  add_tmp_142;
  wire  [13:0]  add_tmp_143;
  wire  [13:0]  add_tmp_144;
  wire  [13:0]  add_tmp_145;
  wire  [13:0]  add_tmp_146;
  wire  [13:0]  add_tmp_147;
  wire  [13:0]  add_tmp_148;
  wire  [13:0]  add_tmp_149;
  wire  [13:0]  add_tmp_150;
  wire  [13:0]  add_tmp_151;
  wire  [13:0]  add_tmp_152;
  wire  [13:0]  add_tmp_153;
  wire  [13:0]  add_tmp_154;
  wire  [13:0]  add_tmp_155;
  wire  [13:0]  add_tmp_156;
  wire  [13:0]  add_tmp_157;
 
  
  assign    add_tmp_101  =   win11  + win11x4       ;
  assign    add_tmp_102  =   win12 + win12x8        ;
  assign    add_tmp_103  =   win13x16 - win13x2    ;
  assign    add_tmp_104  =   win14x16 + win16x8    ;
  assign    add_tmp_105  =   win15x16 - win15x2     ;
  assign    add_tmp_106  =   win16 + win17x4          ;
  assign    add_tmp_107  =   win17 + win21x8        ;
  assign    add_tmp_108  =   win21 + win22x16        ;
  assign    add_tmp_109  =   win22 + win23x16     ;
  assign    add_tmp_110  =   win23x8 + win23x2     ;
  assign    add_tmp_111  =   win24x32 - win24x4    ;
  assign    add_tmp_112  =   win24 + win25x16        ;
  assign    add_tmp_113  =   win25x8 + win25x2     ;
  assign    add_tmp_114  =   win26x16 + win26       ;
  assign    add_tmp_115  =   win27x8 + win27        ;
  assign    add_tmp_116  =   win31x16 - win31x2    ;
  assign    add_tmp_117  =   win32x16 + win32x8      ;
  assign    add_tmp_118  =   win32x2 + win33x32       ;
  assign    add_tmp_119  =   win33x4 + win33     ;
  assign    add_tmp_120  =   win34x32 + win34x8      ;
  assign    add_tmp_121  =   win34x2 + win35x32       ;
  assign    add_tmp_122  =   win35x4 + win35    ;
  assign    add_tmp_123  =   win36x16 + win36x8      ;
  assign    add_tmp_124  =   win36x2 + win41x16    ;
  assign    add_tmp_125  =   win37x16 - win37x2    ;
  assign    add_tmp_126  =   win42x32 - win42x4    ;
  assign    add_tmp_127  =   win42 + win43x32        ;
  assign    add_tmp_128  =   win43x8 + win43x2     ;
  assign    add_tmp_129  =   win44x32 + win44x16    ;
  assign    add_tmp_130  =   win45x32 + win45x8      ;
  assign    add_tmp_131  =   win45x2 + win46    ;
  assign    add_tmp_132  =   win46x32 - win46x4       ;
  assign    add_tmp_133  =   win47x16 + win52x16    ;
  assign    add_tmp_134  =   win51x16 - win51x2     ;
  assign    add_tmp_135  =   win52x8 + win52x2     ;
  assign    add_tmp_136  =   win53x32 + win53x4        ;
  assign    add_tmp_137  =   win53 + win54x32     ;
  assign    add_tmp_138  =   win54x8 + win54x2     ;
  assign    add_tmp_139  =   win55x32 + win55x4        ;
  assign    add_tmp_140  =   win55 + win56x16     ;
  assign    add_tmp_141  =   win56x8 + win56x2     ;
  assign    add_tmp_142  =   win57x16 - win57x2    ;
  assign    add_tmp_143  =   win61 + win61x8        ;
  assign    add_tmp_144  =   win62 + win62x16       ;
  assign    add_tmp_145  =   win63x16 + win63x8      ;
  assign    add_tmp_146  =   win63x2 + win64    ;
  assign    add_tmp_147  =   win64x32 - win64x4       ;
  assign    add_tmp_148  =   win65x16 + win65x8      ;
  assign    add_tmp_149  =   win65x2 + win66x16    ;
  assign    add_tmp_150  =   win66 + win67x8        ;
  assign    add_tmp_151  =   win67 + win71x4          ;
  assign    add_tmp_152  =   win71 + win72x8        ;
  assign    add_tmp_153  =   win72 + win74x16     ;
  assign    add_tmp_154  =   win73x16 - win73x2    ;
  assign    add_tmp_155  =   win75x16 - win75x2    ;
  assign    add_tmp_156  =   win76x8 + win76        ;
  assign    add_tmp_157  =   win77 + win77x4        ;

  wire  [14:0]  add_tmp_201;
  wire  [14:0]  add_tmp_202;
  wire  [14:0]  add_tmp_203;
  wire  [14:0]  add_tmp_204;
  wire  [14:0]  add_tmp_205;
  wire  [14:0]  add_tmp_206;
  wire  [14:0]  add_tmp_207;
  wire  [14:0]  add_tmp_208;
  wire  [14:0]  add_tmp_209;
  wire  [14:0]  add_tmp_210;
  wire  [14:0]  add_tmp_211;
  wire  [14:0]  add_tmp_212;
  wire  [14:0]  add_tmp_213;
  wire  [14:0]  add_tmp_214;
  wire  [14:0]  add_tmp_215;
  wire  [14:0]  add_tmp_216;
  wire  [14:0]  add_tmp_217;
  wire  [14:0]  add_tmp_218;
  wire  [14:0]  add_tmp_219;
  wire  [14:0]  add_tmp_220;
  wire  [14:0]  add_tmp_221;
  wire  [14:0]  add_tmp_222;
  wire  [14:0]  add_tmp_223;
  wire  [14:0]  add_tmp_224;
  wire  [14:0]  add_tmp_225;
  wire  [14:0]  add_tmp_226;
  wire  [14:0]  add_tmp_227;
  wire  [14:0]  add_tmp_228;
  wire  [14:0]  add_tmp_229;
  
  assign    add_tmp_201  =   add_tmp_101  + add_tmp_102       ;
  assign    add_tmp_202  =   add_tmp_103  + add_tmp_104       ;
  assign    add_tmp_203  =   add_tmp_105  + add_tmp_106       ;
  assign    add_tmp_204  =   add_tmp_107  + add_tmp_108       ;
  assign    add_tmp_205  =   add_tmp_109  + add_tmp_110       ;
  assign    add_tmp_206  =   add_tmp_111  + add_tmp_112       ;
  assign    add_tmp_207  =   add_tmp_113  + add_tmp_114       ;
  assign    add_tmp_208  =   add_tmp_115  + add_tmp_116       ;
  assign    add_tmp_209  =   add_tmp_117  + add_tmp_118       ;
  assign    add_tmp_210  =   add_tmp_119  + add_tmp_120       ;
  assign    add_tmp_211  =   add_tmp_121  + add_tmp_122       ;
  assign    add_tmp_212  =   add_tmp_123  + add_tmp_124       ;
  assign    add_tmp_213  =   add_tmp_125  + add_tmp_126       ;
  assign    add_tmp_214  =   add_tmp_127  + add_tmp_128       ;
  assign    add_tmp_215  =   add_tmp_129  + add_tmp_130       ;
  assign    add_tmp_216  =   add_tmp_131  + add_tmp_132       ;
  assign    add_tmp_217  =   add_tmp_133  + add_tmp_134       ;
  assign    add_tmp_218  =   add_tmp_135  + add_tmp_136       ;
  assign    add_tmp_219  =   add_tmp_137  + add_tmp_138       ;
  assign    add_tmp_220  =   add_tmp_139  + add_tmp_140       ;
  assign    add_tmp_221  =   add_tmp_141  + add_tmp_142       ;
  assign    add_tmp_222  =   add_tmp_143  + add_tmp_144       ;
  assign    add_tmp_223  =   add_tmp_145  + add_tmp_146       ;
  assign    add_tmp_224  =   add_tmp_147  + add_tmp_148       ;
  assign    add_tmp_225  =   add_tmp_149  + add_tmp_150       ;
  assign    add_tmp_226  =   add_tmp_151  + add_tmp_152       ;
  assign    add_tmp_227  =   add_tmp_153  + add_tmp_154       ;
  assign    add_tmp_228  =   add_tmp_155  + add_tmp_156       ;
  assign    add_tmp_229  =   add_tmp_157      ;

  wire  [15:0]  add_tmp_301;
  wire  [15:0]  add_tmp_302;
  wire  [15:0]  add_tmp_303;
  wire  [15:0]  add_tmp_304;
  wire  [15:0]  add_tmp_305;
  wire  [15:0]  add_tmp_306;
  wire  [15:0]  add_tmp_307;
  wire  [15:0]  add_tmp_308;
  wire  [15:0]  add_tmp_309;
  wire  [15:0]  add_tmp_310;
  wire  [15:0]  add_tmp_311;
  wire  [15:0]  add_tmp_312;
  wire  [15:0]  add_tmp_313;
  wire  [15:0]  add_tmp_314;
  wire  [15:0]  add_tmp_315;
 
  assign    add_tmp_301  =   add_tmp_201  + add_tmp_202       ;
  assign    add_tmp_302  =   add_tmp_203  + add_tmp_204       ;
  assign    add_tmp_303  =   add_tmp_205  + add_tmp_206       ;
  assign    add_tmp_304  =   add_tmp_207  + add_tmp_208       ;
  assign    add_tmp_305  =   add_tmp_209  + add_tmp_210       ;
  assign    add_tmp_306  =   add_tmp_211  + add_tmp_212       ;
  assign    add_tmp_307  =   add_tmp_213  + add_tmp_214       ;
  assign    add_tmp_308  =   add_tmp_215  + add_tmp_216       ;
  assign    add_tmp_309  =   add_tmp_217  + add_tmp_218       ;
  assign    add_tmp_310  =   add_tmp_219  + add_tmp_220       ;
  assign    add_tmp_311  =   add_tmp_221  + add_tmp_222       ;
  assign    add_tmp_312  =   add_tmp_223  + add_tmp_224       ;
  assign    add_tmp_313  =   add_tmp_225  + add_tmp_226       ;
  assign    add_tmp_314  =   add_tmp_227  + add_tmp_228       ;
  assign    add_tmp_315  =   add_tmp_229        ;
 
  reg  [16:0]  add_tmp_401;
  reg  [16:0]  add_tmp_402;
  reg  [16:0]  add_tmp_403;
  reg  [16:0]  add_tmp_404;
  reg  [16:0]  add_tmp_405;
  reg  [16:0]  add_tmp_406;
  reg  [16:0]  add_tmp_407;
  reg  [16:0]  add_tmp_408;
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
    add_tmp_401 <=  17'd0 ;
    add_tmp_402 <=  17'd0 ;
    add_tmp_403 <=  17'd0 ;
    add_tmp_404 <=  17'd0 ;
    add_tmp_405 <=  17'd0 ;
    add_tmp_406 <=  17'd0 ;
    add_tmp_407 <=  17'd0 ;
    add_tmp_408 <=  17'd0 ;
    end
    else  if(X_mid<=674 && Y_mid<=514)     
     begin
         add_tmp_401 <= add_tmp_301  + add_tmp_302  ;
         add_tmp_402 <= add_tmp_303  + add_tmp_304  ;
         add_tmp_403 <= add_tmp_305  + add_tmp_306  ;
         add_tmp_404 <= add_tmp_307  + add_tmp_308  ;
         add_tmp_405 <= add_tmp_309  + add_tmp_310  ;
         add_tmp_406 <= add_tmp_311  + add_tmp_312  ;
         add_tmp_407 <= add_tmp_313  + add_tmp_314  ;
         add_tmp_408 <= add_tmp_315       ;  
    end
  end
  
 // assign    add_tmp_401  =   add_tmp_301  + add_tmp_302       ;
  //assign    add_tmp_402  =   add_tmp_303  + add_tmp_304       ;
  //assign    add_tmp_403  =   add_tmp_305  + add_tmp_306       ;
 // assign    add_tmp_404  =   add_tmp_307  + add_tmp_308       ;
 // assign    add_tmp_405  =   add_tmp_309  + add_tmp_310       ;
 // assign    add_tmp_406  =   add_tmp_311  + add_tmp_312       ;
 // assign    add_tmp_407  =   add_tmp_313  + add_tmp_314       ;
  //assign    add_tmp_408  =   add_tmp_315       ;  
  
  wire  [17:0]  add_tmp_501;
  wire  [17:0]  add_tmp_502;
  wire  [17:0]  add_tmp_503;
  wire  [17:0]  add_tmp_504;

  assign    add_tmp_501  =   add_tmp_401  + add_tmp_402       ;
  assign    add_tmp_502  =   add_tmp_403  + add_tmp_404       ;
  assign    add_tmp_503  =   add_tmp_405  + add_tmp_406       ;
  assign    add_tmp_504  =   add_tmp_407  + add_tmp_408       ;
  
  wire  [17:0]  add_tmp_601;
  wire  [17:0]  add_tmp_602;  
 
  assign    add_tmp_601  =   add_tmp_501  + add_tmp_502       ;
  assign    add_tmp_602  =   add_tmp_503  + add_tmp_504       ;
 
  
  assign data_mid_temp = add_tmp_601 + add_tmp_602;
  assign data_mid = data_mid_temp[17:10];   
  
 // assign data_mid_temp = 5*win11 + 9*win12 + 14*win13 + 16*win14 + 14*win15 + 9*win16 + 5*win17 +
 //                        9*win21 + 17*win22 + 26*win23 + 29*win24 + 26*win25 + 17*win26 + 9*win27 +
  //                       14*win31 + 26*win32 + 37*win33 + 42*win34 + 37*win35 + 26*win36 + 14*win37 +
  //                       16*win41 + 29*win42 + 42*win43 + 48*win44 + 42*win45 + 29*win46 + 16*win47 +
  //                       14*win51 + 26*win52 + 37*win53 + 42*win54 + 37*win55 + 26*win56 + 14*win57 +
   //                      9*win61 + 17*win62 + 26*win63 + 29*win64 + 26*win65 + 17*win66 + 9*win67 +
    //                     5*win71 + 9*win72 + 14*win73 + 16*win74 + 14*win75 + 9*win76 + 5*win77;
  wire [9:0] addr_mid_tp1;
  wire [9:0] addr_mid_tp2;
  wire [18:0] addr_mid_tp3;
  wire [16:0] addr_mid_tp4;
  wire [14:0] addr_mid_tp5;
  wire [18:0] addr_mid_tp6;
  wire [15:0] addr_mid_tp7;
  wire [18:0] addr_mid_tp8;
  
  assign addr_mid_tp1 = Y_mid - 2'd3;
  assign addr_mid_tp2 = X_mid - 2'd3;
  assign addr_mid_tp3 = {addr_mid_tp1,9'd0};
  assign addr_mid_tp4 = {addr_mid_tp1,7'd0};
  assign addr_mid_tp5 = {addr_mid_tp1,5'd0};
  assign addr_mid_tp6 = addr_mid_tp3 + addr_mid_tp4;
  assign addr_mid_tp7 = addr_mid_tp5 + addr_mid_tp2;
  assign addr_mid_tp8 = addr_mid_tp6 + addr_mid_tp7;
  
  assign addr_mid = (Y_mid>2)? addr_mid_tp8 : 19'd0;                   
  assign XY = {X,Y}; 
  
  assign sin = sc_in[25:13];
  assign cos = sc_in[12:0];
  assign mod1_X = mod1[9:5];
  assign mod1_Y = mod1[4:0];
  assign mod2_X = mod2[9:5];
  assign mod2_Y = mod2[4:0];
  
  assign addr_out = (addr_out_temp>0)?  addr_out_temp - 1'b1 : 19'd0;
  
  assign aclr = ~rst_n;
  assign clken_mm = (XY==XY_in)? 1'b1 : 1'b0;
  
  assign totalx32 = {total,5'd0};
  
                     
  line_buffer_7     lb(.shiftin(din),
                       .clock(clk),                        
                       .clken(en),
                       .taps0x(taps1),
                       .taps1x(taps2),
                       .taps2x(taps3),
                       .taps3x(taps4),
                       .taps4x(taps5),
                       .taps5x(taps6),
                       .taps6x(taps7),
                       .shiftout());
                       
  line_buffer_31_672 lb2(.shiftin(data_mid),
                         .clock(clk),
                         .clken(en_2),                                                     
                         .taps0x(taps_1),
                         .taps1x(taps_2),
                         .taps2x(taps_3),
                         .taps3x(taps_4),
                         .taps4x(taps_5),
                         .taps5x(taps_6),
                         .taps6x(taps_7),
                         .taps7x(taps_8),
                         .taps8x(taps_9),
                         .taps9x(taps_10),
                         .taps10x(taps_11),
                         .taps11x(taps_12),
                         .taps12x(taps_13),
                         .taps13x(taps_14),
                         .taps14x(taps_15),
                         .taps15x(taps_16),
                         .taps16x(taps_17),
                         .taps17x(taps_18),
                         .taps18x(taps_19),
                         .taps19x(taps_20),
                         .taps20x(taps_21),
                         .taps21x(taps_22),
                         .taps22x(taps_23),
                         .taps23x(taps_24),
                         .taps24x(taps_25),
                         .taps25x(taps_26),
                         .taps26x(taps_27),
                         .taps27x(taps_28),
                         .taps28x(taps_29),
                         .taps29x(taps_30),
                         .taps30x(taps_31),
                         .shiftout());
                       
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      num <= 3'd0;
    else if(start==1'b1)
      num <= 3'd0;
    else
      begin
        if(flag==32)
          num <= 3'd4;
        else
          begin
            if(num<6)
              num <= num + 1'b1;
            else if(num==6)
              num <= 3'd0;
          end
      end  
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_corner <= 14'd0;
    else if(start==1'b1)
      addr_corner <= 14'd0;
    else if(flag==32 && count_bit==1'b1 && addr_corner<total-1'b1)
      addr_corner <= addr_corner + 1'b1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      wren <= 1'b0;
    else if(start==1'b1)
      wren <= 1'b1;
    else if(flag==32 && count_bit==1'b1 && addr_corner==total-1'b1)
      wren <= 1'b0;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      end_cd <= 1'd0;
    else if(start==1)
      end_cd <= 1'b0;
    else if(flag==32 && count_bit==1'b1 && addr_corner==total-1'b1)
      end_cd <= 1'd1;
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      addr_b <= 19'b0000000000000000000;
    else if(start==1'b1)
      addr_b <= 19'b0000000000000000000;
    else if(addr_b<351203)
    begin
      if(num==6 && XY!=XY_in)
        addr_b <= addr_b + 1'b1;
    end    
  end
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      en <= 1'b0;
    else if(start==1'b1)
      en <= 1'b0;
    else if(num==1)
    begin
      if(XY==XY_in)
        en <= 1'b0;
      else
        en <= 1'b1;
    end
    else if(num==2)
      en <= 1'b0;
  end
  
  
  
  
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count <= 10'b0000000000;
  else if(start==1'b1)
    count <= 10'b0000000000;
  else if(en==1'b1 && addr_b>=4746)
    begin
      if(count<=677)
          count <= count + 1'b1;
      else
          count <= 1'b1;
    end
end
      
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      win77 <= 8'b00000000;
      win67 <= 8'b00000000;
      win57 <= 8'b00000000;
      win47 <= 8'b00000000;
      win37 <= 8'b00000000;
      win27 <= 8'b00000000;
      win17 <= 8'b00000000;
    end
  else if(en==1'b1 && addr_b>=4746)//15595 
    begin
      win77 <= taps1;
      win67 <= taps2;
      win57 <= taps3;
      win47 <= taps4;
      win37 <= taps5;
      win27 <= taps6;
      win17 <= taps7;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      win76 <= 8'b00000000;
      win75 <= 8'b00000000;
      win74 <= 8'b00000000;
      win73 <= 8'b00000000;
      win72 <= 8'b00000000;
      win71 <= 8'b00000000;
      win66 <= 8'b00000000;
      win65 <= 8'b00000000;
      win64 <= 8'b00000000;
      win63 <= 8'b00000000;
      win62 <= 8'b00000000;
      win61 <= 8'b00000000;
      win56 <= 8'b00000000;
      win55 <= 8'b00000000;
      win54 <= 8'b00000000;
      win53 <= 8'b00000000;
      win52 <= 8'b00000000;
      win51 <= 8'b00000000;
      win46 <= 8'b00000000;
      win45 <= 8'b00000000;
      win44 <= 8'b00000000;
      win43 <= 8'b00000000;
      win42 <= 8'b00000000;
      win41 <= 8'b00000000;
      win36 <= 8'b00000000;
      win35 <= 8'b00000000;
      win34 <= 8'b00000000;
      win33 <= 8'b00000000;
      win32 <= 8'b00000000;
      win31 <= 8'b00000000;
      win26 <= 8'b00000000;
      win25 <= 8'b00000000;
      win24 <= 8'b00000000;
      win23 <= 8'b00000000;
      win22 <= 8'b00000000;
      win21 <= 8'b00000000;
      win16 <= 8'b00000000;
      win15 <= 8'b00000000;
      win14 <= 8'b00000000;
      win13 <= 8'b00000000;
      win12 <= 8'b00000000;
      win11 <= 8'b00000000;  
    end
  else if(en==1'b1)
    begin
      win76 <= win77;
      win75 <= win76;
      win74 <= win75;
      win73 <= win74;
      win72 <= win73;
      win71 <= win72;
      win66 <= win67;
      win65 <= win66;
      win64 <= win65;
      win63 <= win64;
      win62 <= win63;
      win61 <= win62;
      win56 <= win57;
      win55 <= win56;
      win54 <= win55;
      win53 <= win54;
      win52 <= win53;
      win51 <= win52;
      win46 <= win47;
      win45 <= win46;
      win44 <= win45;
      win43 <= win44;
      win42 <= win43;
      win41 <= win42;
      win36 <= win37;
      win35 <= win36;
      win34 <= win35;
      win33 <= win34;
      win32 <= win33;
      win31 <= win32;
      win26 <= win27;
      win25 <= win26;
      win24 <= win25;
      win23 <= win24;
      win22 <= win23;
      win21 <= win22;
      win16 <= win17;
      win15 <= win16;
      win14 <= win15;
      win13 <= win14;
      win12 <= win13;
      win11 <= win12;
  end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_XY_mid <= 1'b0;
  else 
    en_XY_mid <= en;
end
    
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    sel <= 1'b0;
  else if(start==1'b1)
    sel <= 1'b0;
  else if(Y_mid==514 && X_mid==674)
    sel <= 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      X_mid <= 10'd0;
      Y_mid <= 10'd0;
    end
  else if(start==1'b1)
    begin
      Y_mid <= 10'd2;
      X_mid <= 10'd3;
    end
  else if(en_XY_mid==1'b1)
    begin
      if(count>7 && count<=678)
        begin
          if(sel==1'b0)
             X_mid <= count - 3'd4;
        end
      else if(count==7 && Y_mid<514)
        begin
             X_mid <= 10'd3;
             Y_mid <= Y_mid + 1'b1;
        end
    end
end          
            
//always@(posedge clk or negedge rst_n)
//begin
//  if(!rst_n)
//    data_mid <= 8'b00000000;
//  else if(X_mid<=width_ext-border-1 && Y_mid<=height_ext-border-1)
//    data_mid <= data_mid_temp[17:10];
//end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_2 <= 1'b0;
  else
    begin
      if(count<7)
         en_2 <= 1'b0;
      else
         en_2 <= en_XY_mid;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      win31_31 <= 8'b00000000;
      win30_31 <= 8'b00000000;
      win29_31 <= 8'b00000000;
      win28_31 <= 8'b00000000;
      win27_31 <= 8'b00000000;
      win26_31 <= 8'b00000000;
      win25_31 <= 8'b00000000;
      win24_31 <= 8'b00000000;
      win23_31 <= 8'b00000000;
      win22_31 <= 8'b00000000;
      win21_31 <= 8'b00000000;
      win20_31 <= 8'b00000000;
      win19_31 <= 8'b00000000;
      win18_31 <= 8'b00000000;
      win17_31 <= 8'b00000000;
      win16_31 <= 8'b00000000;
      win15_31 <= 8'b00000000;
      win14_31 <= 8'b00000000;
      win13_31 <= 8'b00000000;
      win12_31 <= 8'b00000000;
      win11_31 <= 8'b00000000;
      win10_31 <= 8'b00000000;
      win9_31 <= 8'b00000000;
      win8_31 <= 8'b00000000;
      win7_31 <= 8'b00000000;
      win6_31 <= 8'b00000000;
      win5_31 <= 8'b00000000;
      win4_31 <= 8'b00000000;
      win3_31 <= 8'b00000000;
      win2_31 <= 8'b00000000;
      win1_31 <= 8'b00000000;
    end
  else if(en_2==1'b1 && addr_mid>=21504)//15595 
    begin
      win31_31 <= taps_1;
      win30_31 <= taps_2;
      win29_31 <= taps_3;
      win28_31 <= taps_4;
      win27_31 <= taps_5;
      win26_31 <= taps_6;
      win25_31 <= taps_7;
      win24_31 <= taps_8;
      win23_31 <= taps_9;
      win22_31 <= taps_10;
      win21_31 <= taps_11;
      win20_31 <= taps_12;
      win19_31 <= taps_13;
      win18_31 <= taps_14;
      win17_31 <= taps_15;
      win16_31 <= taps_16;
      win15_31 <= taps_17;
      win14_31 <= taps_18;
      win13_31 <= taps_19;
      win12_31 <= taps_20;
      win11_31 <= taps_21;
      win10_31 <= taps_22;
      win9_31 <= taps_23;
      win8_31 <= taps_24;
      win7_31 <= taps_25;
      win6_31 <= taps_26;
      win5_31 <= taps_27;
      win4_31 <= taps_28;
      win3_31 <= taps_29;
      win2_31 <= taps_30;
      win1_31 <= taps_31;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      win31_30 <= 8'b00000000;
      win31_29 <= 8'b00000000;
      win31_28 <= 8'b00000000;
      win31_27 <= 8'b00000000;
      win31_26 <= 8'b00000000;
      win31_25 <= 8'b00000000;
      win31_24 <= 8'b00000000;
      win31_23 <= 8'b00000000;
      win31_22 <= 8'b00000000;
      win31_21 <= 8'b00000000;
      win31_20 <= 8'b00000000;
      win31_19 <= 8'b00000000;
      win31_18 <= 8'b00000000;
      win31_17 <= 8'b00000000;
      win31_16 <= 8'b00000000;
      win31_15 <= 8'b00000000;
      win31_14 <= 8'b00000000;
      win31_13 <= 8'b00000000;
      win31_12 <= 8'b00000000;
      win31_11 <= 8'b00000000;
      win31_10 <= 8'b00000000;
      win31_9 <= 8'b00000000;
      win31_8 <= 8'b00000000;
      win31_7 <= 8'b00000000;
      win31_6 <= 8'b00000000;
      win31_5 <= 8'b00000000;
      win31_4 <= 8'b00000000;
      win31_3 <= 8'b00000000;
      win31_2 <= 8'b00000000;
      win31_1 <= 8'b00000000;
      win30_30 <= 8'b00000000;
      win30_29 <= 8'b00000000;
      win30_28 <= 8'b00000000;
      win30_27 <= 8'b00000000;
      win30_26 <= 8'b00000000;
      win30_25 <= 8'b00000000;
      win30_24 <= 8'b00000000;
      win30_23 <= 8'b00000000;
      win30_22 <= 8'b00000000;
      win30_21 <= 8'b00000000;
      win30_20 <= 8'b00000000;
      win30_19 <= 8'b00000000;
      win30_18 <= 8'b00000000;
      win30_17 <= 8'b00000000;
      win30_16 <= 8'b00000000;
      win30_15 <= 8'b00000000;
      win30_14 <= 8'b00000000;
      win30_13 <= 8'b00000000;
      win30_12 <= 8'b00000000;
      win30_11 <= 8'b00000000;
      win30_10 <= 8'b00000000;
      win30_9 <= 8'b00000000;
      win30_8 <= 8'b00000000;
      win30_7 <= 8'b00000000;
      win30_6 <= 8'b00000000;
      win30_5 <= 8'b00000000;
      win30_4 <= 8'b00000000;
      win30_3 <= 8'b00000000;
      win30_2 <= 8'b00000000;
      win30_1 <= 8'b00000000;
      win29_30 <= 8'b00000000;
      win29_29 <= 8'b00000000;
      win29_28 <= 8'b00000000;
      win29_27 <= 8'b00000000;
      win29_26 <= 8'b00000000;
      win29_25 <= 8'b00000000;
      win29_24 <= 8'b00000000;
      win29_23 <= 8'b00000000;
      win29_22 <= 8'b00000000;
      win29_21 <= 8'b00000000;
      win29_20 <= 8'b00000000;
      win29_19 <= 8'b00000000;
      win29_18 <= 8'b00000000;
      win29_17 <= 8'b00000000;
      win29_16 <= 8'b00000000;
      win29_15 <= 8'b00000000;
      win29_14 <= 8'b00000000;
      win29_13 <= 8'b00000000;
      win29_12 <= 8'b00000000;
      win29_11 <= 8'b00000000;
      win29_10 <= 8'b00000000;
      win29_9 <= 8'b00000000;
      win29_8 <= 8'b00000000;
      win29_7 <= 8'b00000000;
      win29_6 <= 8'b00000000;
      win29_5 <= 8'b00000000;
      win29_4 <= 8'b00000000;
      win29_3 <= 8'b00000000;
      win29_2 <= 8'b00000000;
      win29_1 <= 8'b00000000;
      win28_30 <= 8'b00000000;
      win28_29 <= 8'b00000000;
      win28_28 <= 8'b00000000;
      win28_27 <= 8'b00000000;
      win28_26 <= 8'b00000000;
      win28_25 <= 8'b00000000;
      win28_24 <= 8'b00000000;
      win28_23 <= 8'b00000000;
      win28_22 <= 8'b00000000;
      win28_21 <= 8'b00000000;
      win28_20 <= 8'b00000000;
      win28_19 <= 8'b00000000;
      win28_18 <= 8'b00000000;
      win28_17 <= 8'b00000000;
      win28_16 <= 8'b00000000;
      win28_15 <= 8'b00000000;
      win28_14 <= 8'b00000000;
      win28_13 <= 8'b00000000;
      win28_12 <= 8'b00000000;
      win28_11 <= 8'b00000000;
      win28_10 <= 8'b00000000;
      win28_9 <= 8'b00000000;
      win28_8 <= 8'b00000000;
      win28_7 <= 8'b00000000;
      win28_6 <= 8'b00000000;
      win28_5 <= 8'b00000000;
      win28_4 <= 8'b00000000;
      win28_3 <= 8'b00000000;
      win28_2 <= 8'b00000000;
      win28_1 <= 8'b00000000;
      win27_30 <= 8'b00000000;
      win27_29 <= 8'b00000000;
      win27_28 <= 8'b00000000;
      win27_27 <= 8'b00000000;
      win27_26 <= 8'b00000000;
      win27_25 <= 8'b00000000;
      win27_24 <= 8'b00000000;
      win27_23 <= 8'b00000000;
      win27_22 <= 8'b00000000;
      win27_21 <= 8'b00000000;
      win27_20 <= 8'b00000000;
      win27_19 <= 8'b00000000;
      win27_18 <= 8'b00000000;
      win27_17 <= 8'b00000000;
      win27_16 <= 8'b00000000;
      win27_15 <= 8'b00000000;
      win27_14 <= 8'b00000000;
      win27_13 <= 8'b00000000;
      win27_12 <= 8'b00000000;
      win27_11 <= 8'b00000000;
      win27_10 <= 8'b00000000;
      win27_9 <= 8'b00000000;
      win27_8 <= 8'b00000000;
      win27_7 <= 8'b00000000;
      win27_6 <= 8'b00000000;
      win27_5 <= 8'b00000000;
      win27_4 <= 8'b00000000;
      win27_3 <= 8'b00000000;
      win27_2 <= 8'b00000000;
      win27_1 <= 8'b00000000;
      win26_30 <= 8'b00000000;
      win26_29 <= 8'b00000000;
      win26_28 <= 8'b00000000;
      win26_27 <= 8'b00000000;
      win26_26 <= 8'b00000000;
      win26_25 <= 8'b00000000;
      win26_24 <= 8'b00000000;
      win26_23 <= 8'b00000000;
      win26_22 <= 8'b00000000;
      win26_21 <= 8'b00000000;
      win26_20 <= 8'b00000000;
      win26_19 <= 8'b00000000;
      win26_18 <= 8'b00000000;
      win26_17 <= 8'b00000000;
      win26_16 <= 8'b00000000;
      win26_15 <= 8'b00000000;
      win26_14 <= 8'b00000000;
      win26_13 <= 8'b00000000;
      win26_12 <= 8'b00000000;
      win26_11 <= 8'b00000000;
      win26_10 <= 8'b00000000;
      win26_9 <= 8'b00000000;
      win26_8 <= 8'b00000000;
      win26_7 <= 8'b00000000;
      win26_6 <= 8'b00000000;
      win26_5 <= 8'b00000000;
      win26_4 <= 8'b00000000;
      win26_3 <= 8'b00000000;
      win26_2 <= 8'b00000000;
      win26_1 <= 8'b00000000;
      win25_30 <= 8'b00000000;
      win25_29 <= 8'b00000000;
      win25_28 <= 8'b00000000;
      win25_27 <= 8'b00000000;
      win25_26 <= 8'b00000000;
      win25_25 <= 8'b00000000;
      win25_24 <= 8'b00000000;
      win25_23 <= 8'b00000000;
      win25_22 <= 8'b00000000;
      win25_21 <= 8'b00000000;
      win25_20 <= 8'b00000000;
      win25_19 <= 8'b00000000;
      win25_18 <= 8'b00000000;
      win25_17 <= 8'b00000000;
      win25_16 <= 8'b00000000;
      win25_15 <= 8'b00000000;
      win25_14 <= 8'b00000000;
      win25_13 <= 8'b00000000;
      win25_12 <= 8'b00000000;
      win25_11 <= 8'b00000000;
      win25_10 <= 8'b00000000;
      win25_9 <= 8'b00000000;
      win25_8 <= 8'b00000000;
      win25_7 <= 8'b00000000;
      win25_6 <= 8'b00000000;
      win25_5 <= 8'b00000000;
      win25_4 <= 8'b00000000;
      win25_3 <= 8'b00000000;
      win25_2 <= 8'b00000000;
      win25_1 <= 8'b00000000;
      win24_30 <= 8'b00000000;
      win24_29 <= 8'b00000000;
      win24_28 <= 8'b00000000;
      win24_27 <= 8'b00000000;
      win24_26 <= 8'b00000000;
      win24_25 <= 8'b00000000;
      win24_24 <= 8'b00000000;
      win24_23 <= 8'b00000000;
      win24_22 <= 8'b00000000;
      win24_21 <= 8'b00000000;
      win24_20 <= 8'b00000000;
      win24_19 <= 8'b00000000;
      win24_18 <= 8'b00000000;
      win24_17 <= 8'b00000000;
      win24_16 <= 8'b00000000;
      win24_15 <= 8'b00000000;
      win24_14 <= 8'b00000000;
      win24_13 <= 8'b00000000;
      win24_12 <= 8'b00000000;
      win24_11 <= 8'b00000000;
      win24_10 <= 8'b00000000;
      win24_9 <= 8'b00000000;
      win24_8 <= 8'b00000000;
      win24_7 <= 8'b00000000;
      win24_6 <= 8'b00000000;
      win24_5 <= 8'b00000000;
      win24_4 <= 8'b00000000;
      win24_3 <= 8'b00000000;
      win24_2 <= 8'b00000000;
      win24_1 <= 8'b00000000;
      win23_30 <= 8'b00000000;
      win23_29 <= 8'b00000000;
      win23_28 <= 8'b00000000;
      win23_27 <= 8'b00000000;
      win23_26 <= 8'b00000000;
      win23_25 <= 8'b00000000;
      win23_24 <= 8'b00000000;
      win23_23 <= 8'b00000000;
      win23_22 <= 8'b00000000;
      win23_21 <= 8'b00000000;
      win23_20 <= 8'b00000000;
      win23_19 <= 8'b00000000;
      win23_18 <= 8'b00000000;
      win23_17 <= 8'b00000000;
      win23_16 <= 8'b00000000;
      win23_15 <= 8'b00000000;
      win23_14 <= 8'b00000000;
      win23_13 <= 8'b00000000;
      win23_12 <= 8'b00000000;
      win23_11 <= 8'b00000000;
      win23_10 <= 8'b00000000;
      win23_9 <= 8'b00000000;
      win23_8 <= 8'b00000000;
      win23_7 <= 8'b00000000;
      win23_6 <= 8'b00000000;
      win23_5 <= 8'b00000000;
      win23_4 <= 8'b00000000;
      win23_3 <= 8'b00000000;
      win23_2 <= 8'b00000000;
      win23_1 <= 8'b00000000;
      win22_30 <= 8'b00000000;
      win22_29 <= 8'b00000000;
      win22_28 <= 8'b00000000;
      win22_27 <= 8'b00000000;
      win22_26 <= 8'b00000000;
      win22_25 <= 8'b00000000;
      win22_24 <= 8'b00000000;
      win22_23 <= 8'b00000000;
      win22_22 <= 8'b00000000;
      win22_21 <= 8'b00000000;
      win22_20 <= 8'b00000000;
      win22_19 <= 8'b00000000;
      win22_18 <= 8'b00000000;
      win22_17 <= 8'b00000000;
      win22_16 <= 8'b00000000;
      win22_15 <= 8'b00000000;
      win22_14 <= 8'b00000000;
      win22_13 <= 8'b00000000;
      win22_12 <= 8'b00000000;
      win22_11 <= 8'b00000000;
      win22_10 <= 8'b00000000;
      win22_9 <= 8'b00000000;
      win22_8 <= 8'b00000000;
      win22_7 <= 8'b00000000;
      win22_6 <= 8'b00000000;
      win22_5 <= 8'b00000000;
      win22_4 <= 8'b00000000;
      win22_3 <= 8'b00000000;
      win22_2 <= 8'b00000000;
      win22_1 <= 8'b00000000;
      win21_30 <= 8'b00000000;
      win21_29 <= 8'b00000000;
      win21_28 <= 8'b00000000;
      win21_27 <= 8'b00000000;
      win21_26 <= 8'b00000000;
      win21_25 <= 8'b00000000;
      win21_24 <= 8'b00000000;
      win21_23 <= 8'b00000000;
      win21_22 <= 8'b00000000;
      win21_21 <= 8'b00000000;
      win21_20 <= 8'b00000000;
      win21_19 <= 8'b00000000;
      win21_18 <= 8'b00000000;
      win21_17 <= 8'b00000000;
      win21_16 <= 8'b00000000;
      win21_15 <= 8'b00000000;
      win21_14 <= 8'b00000000;
      win21_13 <= 8'b00000000;
      win21_12 <= 8'b00000000;
      win21_11 <= 8'b00000000;
      win21_10 <= 8'b00000000;
      win21_9 <= 8'b00000000;
      win21_8 <= 8'b00000000;
      win21_7 <= 8'b00000000;
      win21_6 <= 8'b00000000;
      win21_5 <= 8'b00000000;
      win21_4 <= 8'b00000000;
      win21_3 <= 8'b00000000;
      win21_2 <= 8'b00000000;
      win21_1 <= 8'b00000000;
      win20_30 <= 8'b00000000;
      win20_29 <= 8'b00000000;
      win20_28 <= 8'b00000000;
      win20_27 <= 8'b00000000;
      win20_26 <= 8'b00000000;
      win20_25 <= 8'b00000000;
      win20_24 <= 8'b00000000;
      win20_23 <= 8'b00000000;
      win20_22 <= 8'b00000000;
      win20_21 <= 8'b00000000;
      win20_20 <= 8'b00000000;
      win20_19 <= 8'b00000000;
      win20_18 <= 8'b00000000;
      win20_17 <= 8'b00000000;
      win20_16 <= 8'b00000000;
      win20_15 <= 8'b00000000;
      win20_14 <= 8'b00000000;
      win20_13 <= 8'b00000000;
      win20_12 <= 8'b00000000;
      win20_11 <= 8'b00000000;
      win20_10 <= 8'b00000000;
      win20_9 <= 8'b00000000;
      win20_8 <= 8'b00000000;
      win20_7 <= 8'b00000000;
      win20_6 <= 8'b00000000;
      win20_5 <= 8'b00000000;
      win20_4 <= 8'b00000000;
      win20_3 <= 8'b00000000;
      win20_2 <= 8'b00000000;
      win20_1 <= 8'b00000000;
      win19_30 <= 8'b00000000;
      win19_29 <= 8'b00000000;
      win19_28 <= 8'b00000000;
      win19_27 <= 8'b00000000;
      win19_26 <= 8'b00000000;
      win19_25 <= 8'b00000000;
      win19_24 <= 8'b00000000;
      win19_23 <= 8'b00000000;
      win19_22 <= 8'b00000000;
      win19_21 <= 8'b00000000;
      win19_20 <= 8'b00000000;
      win19_19 <= 8'b00000000;
      win19_18 <= 8'b00000000;
      win19_17 <= 8'b00000000;
      win19_16 <= 8'b00000000;
      win19_15 <= 8'b00000000;
      win19_14 <= 8'b00000000;
      win19_13 <= 8'b00000000;
      win19_12 <= 8'b00000000;
      win19_11 <= 8'b00000000;
      win19_10 <= 8'b00000000;
      win19_9 <= 8'b00000000;
      win19_8 <= 8'b00000000;
      win19_7 <= 8'b00000000;
      win19_6 <= 8'b00000000;
      win19_5 <= 8'b00000000;
      win19_4 <= 8'b00000000;
      win19_3 <= 8'b00000000;
      win19_2 <= 8'b00000000;
      win19_1 <= 8'b00000000;
      win18_30 <= 8'b00000000;
      win18_29 <= 8'b00000000;
      win18_28 <= 8'b00000000;
      win18_27 <= 8'b00000000;
      win18_26 <= 8'b00000000;
      win18_25 <= 8'b00000000;
      win18_24 <= 8'b00000000;
      win18_23 <= 8'b00000000;
      win18_22 <= 8'b00000000;
      win18_21 <= 8'b00000000;
      win18_20 <= 8'b00000000;
      win18_19 <= 8'b00000000;
      win18_18 <= 8'b00000000;
      win18_17 <= 8'b00000000;
      win18_16 <= 8'b00000000;
      win18_15 <= 8'b00000000;
      win18_14 <= 8'b00000000;
      win18_13 <= 8'b00000000;
      win18_12 <= 8'b00000000;
      win18_11 <= 8'b00000000;
      win18_10 <= 8'b00000000;
      win18_9 <= 8'b00000000;
      win18_8 <= 8'b00000000;
      win18_7 <= 8'b00000000;
      win18_6 <= 8'b00000000;
      win18_5 <= 8'b00000000;
      win18_4 <= 8'b00000000;
      win18_3 <= 8'b00000000;
      win18_2 <= 8'b00000000;
      win18_1 <= 8'b00000000;
      win17_30 <= 8'b00000000;
      win17_29 <= 8'b00000000;
      win17_28 <= 8'b00000000;
      win17_27 <= 8'b00000000;
      win17_26 <= 8'b00000000;
      win17_25 <= 8'b00000000;
      win17_24 <= 8'b00000000;
      win17_23 <= 8'b00000000;
      win17_22 <= 8'b00000000;
      win17_21 <= 8'b00000000;
      win17_20 <= 8'b00000000;
      win17_19 <= 8'b00000000;
      win17_18 <= 8'b00000000;
      win17_17 <= 8'b00000000;
      win17_16 <= 8'b00000000;
      win17_15 <= 8'b00000000;
      win17_14 <= 8'b00000000;
      win17_13 <= 8'b00000000;
      win17_12 <= 8'b00000000;
      win17_11 <= 8'b00000000;
      win17_10 <= 8'b00000000;
      win17_9 <= 8'b00000000;
      win17_8 <= 8'b00000000;
      win17_7 <= 8'b00000000;
      win17_6 <= 8'b00000000;
      win17_5 <= 8'b00000000;
      win17_4 <= 8'b00000000;
      win17_3 <= 8'b00000000;
      win17_2 <= 8'b00000000;
      win17_1 <= 8'b00000000;
      win16_30 <= 8'b00000000;
      win16_29 <= 8'b00000000;
      win16_28 <= 8'b00000000;
      win16_27 <= 8'b00000000;
      win16_26 <= 8'b00000000;
      win16_25 <= 8'b00000000;
      win16_24 <= 8'b00000000;
      win16_23 <= 8'b00000000;
      win16_22 <= 8'b00000000;
      win16_21 <= 8'b00000000;
      win16_20 <= 8'b00000000;
      win16_19 <= 8'b00000000;
      win16_18 <= 8'b00000000;
      win16_17 <= 8'b00000000;
      win16_16 <= 8'b00000000;
      win16_15 <= 8'b00000000;
      win16_14 <= 8'b00000000;
      win16_13 <= 8'b00000000;
      win16_12 <= 8'b00000000;
      win16_11 <= 8'b00000000;
      win16_10 <= 8'b00000000;
      win16_9 <= 8'b00000000;
      win16_8 <= 8'b00000000;
      win16_7 <= 8'b00000000;
      win16_6 <= 8'b00000000;
      win16_5 <= 8'b00000000;
      win16_4 <= 8'b00000000;
      win16_3 <= 8'b00000000;
      win16_2 <= 8'b00000000;
      win16_1 <= 8'b00000000;
      win15_30 <= 8'b00000000;
      win15_29 <= 8'b00000000;
      win15_28 <= 8'b00000000;
      win15_27 <= 8'b00000000;
      win15_26 <= 8'b00000000;
      win15_25 <= 8'b00000000;
      win15_24 <= 8'b00000000;
      win15_23 <= 8'b00000000;
      win15_22 <= 8'b00000000;
      win15_21 <= 8'b00000000;
      win15_20 <= 8'b00000000;
      win15_19 <= 8'b00000000;
      win15_18 <= 8'b00000000;
      win15_17 <= 8'b00000000;
      win15_16 <= 8'b00000000;
      win15_15 <= 8'b00000000;
      win15_14 <= 8'b00000000;
      win15_13 <= 8'b00000000;
      win15_12 <= 8'b00000000;
      win15_11 <= 8'b00000000;
      win15_10 <= 8'b00000000;
      win15_9 <= 8'b00000000;
      win15_8 <= 8'b00000000;
      win15_7 <= 8'b00000000;
      win15_6 <= 8'b00000000;
      win15_5 <= 8'b00000000;
      win15_4 <= 8'b00000000;
      win15_3 <= 8'b00000000;
      win15_2 <= 8'b00000000;
      win15_1 <= 8'b00000000;
      win14_30 <= 8'b00000000;
      win14_29 <= 8'b00000000;
      win14_28 <= 8'b00000000;
      win14_27 <= 8'b00000000;
      win14_26 <= 8'b00000000;
      win14_25 <= 8'b00000000;
      win14_24 <= 8'b00000000;
      win14_23 <= 8'b00000000;
      win14_22 <= 8'b00000000;
      win14_21 <= 8'b00000000;
      win14_20 <= 8'b00000000;
      win14_19 <= 8'b00000000;
      win14_18 <= 8'b00000000;
      win14_17 <= 8'b00000000;
      win14_16 <= 8'b00000000;
      win14_15 <= 8'b00000000;
      win14_14 <= 8'b00000000;
      win14_13 <= 8'b00000000;
      win14_12 <= 8'b00000000;
      win14_11 <= 8'b00000000;
      win14_10 <= 8'b00000000;
      win14_9 <= 8'b00000000;
      win14_8 <= 8'b00000000;
      win14_7 <= 8'b00000000;
      win14_6 <= 8'b00000000;
      win14_5 <= 8'b00000000;
      win14_4 <= 8'b00000000;
      win14_3 <= 8'b00000000;
      win14_2 <= 8'b00000000;
      win14_1 <= 8'b00000000;
      win13_30 <= 8'b00000000;
      win13_29 <= 8'b00000000;
      win13_28 <= 8'b00000000;
      win13_27 <= 8'b00000000;
      win13_26 <= 8'b00000000;
      win13_25 <= 8'b00000000;
      win13_24 <= 8'b00000000;
      win13_23 <= 8'b00000000;
      win13_22 <= 8'b00000000;
      win13_21 <= 8'b00000000;
      win13_20 <= 8'b00000000;
      win13_19 <= 8'b00000000;
      win13_18 <= 8'b00000000;
      win13_17 <= 8'b00000000;
      win13_16 <= 8'b00000000;
      win13_15 <= 8'b00000000;
      win13_14 <= 8'b00000000;
      win13_13 <= 8'b00000000;
      win13_12 <= 8'b00000000;
      win13_11 <= 8'b00000000;
      win13_10 <= 8'b00000000;
      win13_9 <= 8'b00000000;
      win13_8 <= 8'b00000000;
      win13_7 <= 8'b00000000;
      win13_6 <= 8'b00000000;
      win13_5 <= 8'b00000000;
      win13_4 <= 8'b00000000;
      win13_3 <= 8'b00000000;
      win13_2 <= 8'b00000000;
      win13_1 <= 8'b00000000;
      win12_30 <= 8'b00000000;
      win12_29 <= 8'b00000000;
      win12_28 <= 8'b00000000;
      win12_27 <= 8'b00000000;
      win12_26 <= 8'b00000000;
      win12_25 <= 8'b00000000;
      win12_24 <= 8'b00000000;
      win12_23 <= 8'b00000000;
      win12_22 <= 8'b00000000;
      win12_21 <= 8'b00000000;
      win12_20 <= 8'b00000000;
      win12_19 <= 8'b00000000;
      win12_18 <= 8'b00000000;
      win12_17 <= 8'b00000000;
      win12_16 <= 8'b00000000;
      win12_15 <= 8'b00000000;
      win12_14 <= 8'b00000000;
      win12_13 <= 8'b00000000;
      win12_12 <= 8'b00000000;
      win12_11 <= 8'b00000000;
      win12_10 <= 8'b00000000;
      win12_9 <= 8'b00000000;
      win12_8 <= 8'b00000000;
      win12_7 <= 8'b00000000;
      win12_6 <= 8'b00000000;
      win12_5 <= 8'b00000000;
      win12_4 <= 8'b00000000;
      win12_3 <= 8'b00000000;
      win12_2 <= 8'b00000000;
      win12_1 <= 8'b00000000;
      win11_30 <= 8'b00000000;
      win11_29 <= 8'b00000000;
      win11_28 <= 8'b00000000;
      win11_27 <= 8'b00000000;
      win11_26 <= 8'b00000000;
      win11_25 <= 8'b00000000;
      win11_24 <= 8'b00000000;
      win11_23 <= 8'b00000000;
      win11_22 <= 8'b00000000;
      win11_21 <= 8'b00000000;
      win11_20 <= 8'b00000000;
      win11_19 <= 8'b00000000;
      win11_18 <= 8'b00000000;
      win11_17 <= 8'b00000000;
      win11_16 <= 8'b00000000;
      win11_15 <= 8'b00000000;
      win11_14 <= 8'b00000000;
      win11_13 <= 8'b00000000;
      win11_12 <= 8'b00000000;
      win11_11 <= 8'b00000000;
      win11_10 <= 8'b00000000;
      win11_9 <= 8'b00000000;
      win11_8 <= 8'b00000000;
      win11_7 <= 8'b00000000;
      win11_6 <= 8'b00000000;
      win11_5 <= 8'b00000000;
      win11_4 <= 8'b00000000;
      win11_3 <= 8'b00000000;
      win11_2 <= 8'b00000000;
      win11_1 <= 8'b00000000;
      win10_30 <= 8'b00000000;
      win10_29 <= 8'b00000000;
      win10_28 <= 8'b00000000;
      win10_27 <= 8'b00000000;
      win10_26 <= 8'b00000000;
      win10_25 <= 8'b00000000;
      win10_24 <= 8'b00000000;
      win10_23 <= 8'b00000000;
      win10_22 <= 8'b00000000;
      win10_21 <= 8'b00000000;
      win10_20 <= 8'b00000000;
      win10_19 <= 8'b00000000;
      win10_18 <= 8'b00000000;
      win10_17 <= 8'b00000000;
      win10_16 <= 8'b00000000;
      win10_15 <= 8'b00000000;
      win10_14 <= 8'b00000000;
      win10_13 <= 8'b00000000;
      win10_12 <= 8'b00000000;
      win10_11 <= 8'b00000000;
      win10_10 <= 8'b00000000;
      win10_9 <= 8'b00000000;
      win10_8 <= 8'b00000000;
      win10_7 <= 8'b00000000;
      win10_6 <= 8'b00000000;
      win10_5 <= 8'b00000000;
      win10_4 <= 8'b00000000;
      win10_3 <= 8'b00000000;
      win10_2 <= 8'b00000000;
      win10_1 <= 8'b00000000;
      win9_30 <= 8'b00000000;
      win9_29 <= 8'b00000000;
      win9_28 <= 8'b00000000;
      win9_27 <= 8'b00000000;
      win9_26 <= 8'b00000000;
      win9_25 <= 8'b00000000;
      win9_24 <= 8'b00000000;
      win9_23 <= 8'b00000000;
      win9_22 <= 8'b00000000;
      win9_21 <= 8'b00000000;
      win9_20 <= 8'b00000000;
      win9_19 <= 8'b00000000;
      win9_18 <= 8'b00000000;
      win9_17 <= 8'b00000000;
      win9_16 <= 8'b00000000;
      win9_15 <= 8'b00000000;
      win9_14 <= 8'b00000000;
      win9_13 <= 8'b00000000;
      win9_12 <= 8'b00000000;
      win9_11 <= 8'b00000000;
      win9_10 <= 8'b00000000;
      win9_9 <= 8'b00000000;
      win9_8 <= 8'b00000000;
      win9_7 <= 8'b00000000;
      win9_6 <= 8'b00000000;
      win9_5 <= 8'b00000000;
      win9_4 <= 8'b00000000;
      win9_3 <= 8'b00000000;
      win9_2 <= 8'b00000000;
      win9_1 <= 8'b00000000;
      win8_30 <= 8'b00000000;
      win8_29 <= 8'b00000000;
      win8_28 <= 8'b00000000;
      win8_27 <= 8'b00000000;
      win8_26 <= 8'b00000000;
      win8_25 <= 8'b00000000;
      win8_24 <= 8'b00000000;
      win8_23 <= 8'b00000000;
      win8_22 <= 8'b00000000;
      win8_21 <= 8'b00000000;
      win8_20 <= 8'b00000000;
      win8_19 <= 8'b00000000;
      win8_18 <= 8'b00000000;
      win8_17 <= 8'b00000000;
      win8_16 <= 8'b00000000;
      win8_15 <= 8'b00000000;
      win8_14 <= 8'b00000000;
      win8_13 <= 8'b00000000;
      win8_12 <= 8'b00000000;
      win8_11 <= 8'b00000000;
      win8_10 <= 8'b00000000;
      win8_9 <= 8'b00000000;
      win8_8 <= 8'b00000000;
      win8_7 <= 8'b00000000;
      win8_6 <= 8'b00000000;
      win8_5 <= 8'b00000000;
      win8_4 <= 8'b00000000;
      win8_3 <= 8'b00000000;
      win8_2 <= 8'b00000000;
      win8_1 <= 8'b00000000;
      win7_30 <= 8'b00000000;
      win7_29 <= 8'b00000000;
      win7_28 <= 8'b00000000;
      win7_27 <= 8'b00000000;
      win7_26 <= 8'b00000000;
      win7_25 <= 8'b00000000;
      win7_24 <= 8'b00000000;
      win7_23 <= 8'b00000000;
      win7_22 <= 8'b00000000;
      win7_21 <= 8'b00000000;
      win7_20 <= 8'b00000000;
      win7_19 <= 8'b00000000;
      win7_18 <= 8'b00000000;
      win7_17 <= 8'b00000000;
      win7_16 <= 8'b00000000;
      win7_15 <= 8'b00000000;
      win7_14 <= 8'b00000000;
      win7_13 <= 8'b00000000;
      win7_12 <= 8'b00000000;
      win7_11 <= 8'b00000000;
      win7_10 <= 8'b00000000;
      win7_9 <= 8'b00000000;
      win7_8 <= 8'b00000000;
      win7_7 <= 8'b00000000;
      win7_6 <= 8'b00000000;
      win7_5 <= 8'b00000000;
      win7_4 <= 8'b00000000;
      win7_3 <= 8'b00000000;
      win7_2 <= 8'b00000000;
      win7_1 <= 8'b00000000;
      win6_30 <= 8'b00000000;
      win6_29 <= 8'b00000000;
      win6_28 <= 8'b00000000;
      win6_27 <= 8'b00000000;
      win6_26 <= 8'b00000000;
      win6_25 <= 8'b00000000;
      win6_24 <= 8'b00000000;
      win6_23 <= 8'b00000000;
      win6_22 <= 8'b00000000;
      win6_21 <= 8'b00000000;
      win6_20 <= 8'b00000000;
      win6_19 <= 8'b00000000;
      win6_18 <= 8'b00000000;
      win6_17 <= 8'b00000000;
      win6_16 <= 8'b00000000;
      win6_15 <= 8'b00000000;
      win6_14 <= 8'b00000000;
      win6_13 <= 8'b00000000;
      win6_12 <= 8'b00000000;
      win6_11 <= 8'b00000000;
      win6_10 <= 8'b00000000;
      win6_9 <= 8'b00000000;
      win6_8 <= 8'b00000000;
      win6_7 <= 8'b00000000;
      win6_6 <= 8'b00000000;
      win6_5 <= 8'b00000000;
      win6_4 <= 8'b00000000;
      win6_3 <= 8'b00000000;
      win6_2 <= 8'b00000000;
      win6_1 <= 8'b00000000;
      win5_30 <= 8'b00000000;
      win5_29 <= 8'b00000000;
      win5_28 <= 8'b00000000;
      win5_27 <= 8'b00000000;
      win5_26 <= 8'b00000000;
      win5_25 <= 8'b00000000;
      win5_24 <= 8'b00000000;
      win5_23 <= 8'b00000000;
      win5_22 <= 8'b00000000;
      win5_21 <= 8'b00000000;
      win5_20 <= 8'b00000000;
      win5_19 <= 8'b00000000;
      win5_18 <= 8'b00000000;
      win5_17 <= 8'b00000000;
      win5_16 <= 8'b00000000;
      win5_15 <= 8'b00000000;
      win5_14 <= 8'b00000000;
      win5_13 <= 8'b00000000;
      win5_12 <= 8'b00000000;
      win5_11 <= 8'b00000000;
      win5_10 <= 8'b00000000;
      win5_9 <= 8'b00000000;
      win5_8 <= 8'b00000000;
      win5_7 <= 8'b00000000;
      win5_6 <= 8'b00000000;
      win5_5 <= 8'b00000000;
      win5_4 <= 8'b00000000;
      win5_3 <= 8'b00000000;
      win5_2 <= 8'b00000000;
      win5_1 <= 8'b00000000;
      win4_30 <= 8'b00000000;
      win4_29 <= 8'b00000000;
      win4_28 <= 8'b00000000;
      win4_27 <= 8'b00000000;
      win4_26 <= 8'b00000000;
      win4_25 <= 8'b00000000;
      win4_24 <= 8'b00000000;
      win4_23 <= 8'b00000000;
      win4_22 <= 8'b00000000;
      win4_21 <= 8'b00000000;
      win4_20 <= 8'b00000000;
      win4_19 <= 8'b00000000;
      win4_18 <= 8'b00000000;
      win4_17 <= 8'b00000000;
      win4_16 <= 8'b00000000;
      win4_15 <= 8'b00000000;
      win4_14 <= 8'b00000000;
      win4_13 <= 8'b00000000;
      win4_12 <= 8'b00000000;
      win4_11 <= 8'b00000000;
      win4_10 <= 8'b00000000;
      win4_9 <= 8'b00000000;
      win4_8 <= 8'b00000000;
      win4_7 <= 8'b00000000;
      win4_6 <= 8'b00000000;
      win4_5 <= 8'b00000000;
      win4_4 <= 8'b00000000;
      win4_3 <= 8'b00000000;
      win4_2 <= 8'b00000000;
      win4_1 <= 8'b00000000;
      win3_30 <= 8'b00000000;
      win3_29 <= 8'b00000000;
      win3_28 <= 8'b00000000;
      win3_27 <= 8'b00000000;
      win3_26 <= 8'b00000000;
      win3_25 <= 8'b00000000;
      win3_24 <= 8'b00000000;
      win3_23 <= 8'b00000000;
      win3_22 <= 8'b00000000;
      win3_21 <= 8'b00000000;
      win3_20 <= 8'b00000000;
      win3_19 <= 8'b00000000;
      win3_18 <= 8'b00000000;
      win3_17 <= 8'b00000000;
      win3_16 <= 8'b00000000;
      win3_15 <= 8'b00000000;
      win3_14 <= 8'b00000000;
      win3_13 <= 8'b00000000;
      win3_12 <= 8'b00000000;
      win3_11 <= 8'b00000000;
      win3_10 <= 8'b00000000;
      win3_9 <= 8'b00000000;
      win3_8 <= 8'b00000000;
      win3_7 <= 8'b00000000;
      win3_6 <= 8'b00000000;
      win3_5 <= 8'b00000000;
      win3_4 <= 8'b00000000;
      win3_3 <= 8'b00000000;
      win3_2 <= 8'b00000000;
      win3_1 <= 8'b00000000;
      win2_30 <= 8'b00000000;
      win2_29 <= 8'b00000000;
      win2_28 <= 8'b00000000;
      win2_27 <= 8'b00000000;
      win2_26 <= 8'b00000000;
      win2_25 <= 8'b00000000;
      win2_24 <= 8'b00000000;
      win2_23 <= 8'b00000000;
      win2_22 <= 8'b00000000;
      win2_21 <= 8'b00000000;
      win2_20 <= 8'b00000000;
      win2_19 <= 8'b00000000;
      win2_18 <= 8'b00000000;
      win2_17 <= 8'b00000000;
      win2_16 <= 8'b00000000;
      win2_15 <= 8'b00000000;
      win2_14 <= 8'b00000000;
      win2_13 <= 8'b00000000;
      win2_12 <= 8'b00000000;
      win2_11 <= 8'b00000000;
      win2_10 <= 8'b00000000;
      win2_9 <= 8'b00000000;
      win2_8 <= 8'b00000000;
      win2_7 <= 8'b00000000;
      win2_6 <= 8'b00000000;
      win2_5 <= 8'b00000000;
      win2_4 <= 8'b00000000;
      win2_3 <= 8'b00000000;
      win2_2 <= 8'b00000000;
      win2_1 <= 8'b00000000;
      win1_30 <= 8'b00000000;
      win1_29 <= 8'b00000000;
      win1_28 <= 8'b00000000;
      win1_27 <= 8'b00000000;
      win1_26 <= 8'b00000000;
      win1_25 <= 8'b00000000;
      win1_24 <= 8'b00000000;
      win1_23 <= 8'b00000000;
      win1_22 <= 8'b00000000;
      win1_21 <= 8'b00000000;
      win1_20 <= 8'b00000000;
      win1_19 <= 8'b00000000;
      win1_18 <= 8'b00000000;
      win1_17 <= 8'b00000000;
      win1_16 <= 8'b00000000;
      win1_15 <= 8'b00000000;
      win1_14 <= 8'b00000000;
      win1_13 <= 8'b00000000;
      win1_12 <= 8'b00000000;
      win1_11 <= 8'b00000000;
      win1_10 <= 8'b00000000;
      win1_9 <= 8'b00000000;
      win1_8 <= 8'b00000000;
      win1_7 <= 8'b00000000;
      win1_6 <= 8'b00000000;
      win1_5 <= 8'b00000000;
      win1_4 <= 8'b00000000;
      win1_3 <= 8'b00000000;
      win1_2 <= 8'b00000000;
      win1_1 <= 8'b00000000;
    end
  else if(en_2==1'b1)
    begin
      win31_30 <= win31_31;
      win31_29 <= win31_30;
      win31_28 <= win31_29;
      win31_27 <= win31_28;
      win31_26 <= win31_27;
      win31_25 <= win31_26;
      win31_24 <= win31_25;
      win31_23 <= win31_24;
      win31_22 <= win31_23;
      win31_21 <= win31_22;
      win31_20 <= win31_21;
      win31_19 <= win31_20;
      win31_18 <= win31_19;
      win31_17 <= win31_18;
      win31_16 <= win31_17;
      win31_15 <= win31_16;
      win31_14 <= win31_15;
      win31_13 <= win31_14;
      win31_12 <= win31_13;
      win31_11 <= win31_12;
      win31_10 <= win31_11;
      win31_9 <= win31_10;
      win31_8 <= win31_9;
      win31_7 <= win31_8;
      win31_6 <= win31_7;
      win31_5 <= win31_6;
      win31_4 <= win31_5;
      win31_3 <= win31_4;
      win31_2 <= win31_3;
      win31_1 <= win31_2;
      
      win30_30 <= win30_31;
      win30_29 <= win30_30;
      win30_28 <= win30_29;
      win30_27 <= win30_28;
      win30_26 <= win30_27;
      win30_25 <= win30_26;
      win30_24 <= win30_25;
      win30_23 <= win30_24;
      win30_22 <= win30_23;
      win30_21 <= win30_22;
      win30_20 <= win30_21;
      win30_19 <= win30_20;
      win30_18 <= win30_19;
      win30_17 <= win30_18;
      win30_16 <= win30_17;
      win30_15 <= win30_16;
      win30_14 <= win30_15;
      win30_13 <= win30_14;
      win30_12 <= win30_13;
      win30_11 <= win30_12;
      win30_10 <= win30_11;
      win30_9 <= win30_10;
      win30_8 <= win30_9;
      win30_7 <= win30_8;
      win30_6 <= win30_7;
      win30_5 <= win30_6;
      win30_4 <= win30_5;
      win30_3 <= win30_4;
      win30_2 <= win30_3;
      win30_1 <= win30_2;
      
      win29_30 <= win29_31;
      win29_29 <= win29_30;
      win29_28 <= win29_29;
      win29_27 <= win29_28;
      win29_26 <= win29_27;
      win29_25 <= win29_26;
      win29_24 <= win29_25;
      win29_23 <= win29_24;
      win29_22 <= win29_23;
      win29_21 <= win29_22;
      win29_20 <= win29_21;
      win29_19 <= win29_20;
      win29_18 <= win29_19;
      win29_17 <= win29_18;
      win29_16 <= win29_17;
      win29_15 <= win29_16;
      win29_14 <= win29_15;
      win29_13 <= win29_14;
      win29_12 <= win29_13;
      win29_11 <= win29_12;
      win29_10 <= win29_11;
      win29_9 <= win29_10;
      win29_8 <= win29_9;
      win29_7 <= win29_8;
      win29_6 <= win29_7;
      win29_5 <= win29_6;
      win29_4 <= win29_5;
      win29_3 <= win29_4;
      win29_2 <= win29_3;
      win29_1 <= win29_2;
      
       win28_30 <= win28_31;
      win28_29 <= win28_30;
      win28_28 <= win28_29;
      win28_27 <= win28_28;
      win28_26 <= win28_27;
      win28_25 <= win28_26;
      win28_24 <= win28_25;
      win28_23 <= win28_24;
      win28_22 <= win28_23;
      win28_21 <= win28_22;
      win28_20 <= win28_21;
      win28_19 <= win28_20;
      win28_18 <= win28_19;
      win28_17 <= win28_18;
      win28_16 <= win28_17;
      win28_15 <= win28_16;
      win28_14 <= win28_15;
      win28_13 <= win28_14;
      win28_12 <= win28_13;
      win28_11 <= win28_12;
      win28_10 <= win28_11;
      win28_9 <= win28_10;
      win28_8 <= win28_9;
      win28_7 <= win28_8;
      win28_6 <= win28_7;
      win28_5 <= win28_6;
      win28_4 <= win28_5;
      win28_3 <= win28_4;
      win28_2 <= win28_3;
      win28_1 <= win28_2;
      
      win27_30 <= win27_31;
      win27_29 <= win27_30;
      win27_28 <= win27_29;
      win27_27 <= win27_28;
      win27_26 <= win27_27;
      win27_25 <= win27_26;
      win27_24 <= win27_25;
      win27_23 <= win27_24;
      win27_22 <= win27_23;
      win27_21 <= win27_22;
      win27_20 <= win27_21;
      win27_19 <= win27_20;
      win27_18 <= win27_19;
      win27_17 <= win27_18;
      win27_16 <= win27_17;
      win27_15 <= win27_16;
      win27_14 <= win27_15;
      win27_13 <= win27_14;
      win27_12 <= win27_13;
      win27_11 <= win27_12;
      win27_10 <= win27_11;
      win27_9 <= win27_10;
      win27_8 <= win27_9;
      win27_7 <= win27_8;
      win27_6 <= win27_7;
      win27_5 <= win27_6;
      win27_4 <= win27_5;
      win27_3 <= win27_4;
      win27_2 <= win27_3;
      win27_1 <= win27_2;
      
      win26_30 <= win26_31;
      win26_29 <= win26_30;
      win26_28 <= win26_29;
      win26_27 <= win26_28;
      win26_26 <= win26_27;
      win26_25 <= win26_26;
      win26_24 <= win26_25;
      win26_23 <= win26_24;
      win26_22 <= win26_23;
      win26_21 <= win26_22;
      win26_20 <= win26_21;
      win26_19 <= win26_20;
      win26_18 <= win26_19;
      win26_17 <= win26_18;
      win26_16 <= win26_17;
      win26_15 <= win26_16;
      win26_14 <= win26_15;
      win26_13 <= win26_14;
      win26_12 <= win26_13;
      win26_11 <= win26_12;
      win26_10 <= win26_11;
      win26_9 <= win26_10;
      win26_8 <= win26_9;
      win26_7 <= win26_8;
      win26_6 <= win26_7;
      win26_5 <= win26_6;
      win26_4 <= win26_5;
      win26_3 <= win26_4;
      win26_2 <= win26_3;
      win26_1 <= win26_2;
      
      win25_30 <= win25_31;
      win25_29 <= win25_30;
      win25_28 <= win25_29;
      win25_27 <= win25_28;
      win25_26 <= win25_27;
      win25_25 <= win25_26;
      win25_24 <= win25_25;
      win25_23 <= win25_24;
      win25_22 <= win25_23;
      win25_21 <= win25_22;
      win25_20 <= win25_21;
      win25_19 <= win25_20;
      win25_18 <= win25_19;
      win25_17 <= win25_18;
      win25_16 <= win25_17;
      win25_15 <= win25_16;
      win25_14 <= win25_15;
      win25_13 <= win25_14;
      win25_12 <= win25_13;
      win25_11 <= win25_12;
      win25_10 <= win25_11;
      win25_9 <= win25_10;
      win25_8 <= win25_9;
      win25_7 <= win25_8;
      win25_6 <= win25_7;
      win25_5 <= win25_6;
      win25_4 <= win25_5;
      win25_3 <= win25_4;
      win25_2 <= win25_3;
      win25_1 <= win25_2;
      
      win24_30 <= win24_31;
      win24_29 <= win24_30;
      win24_28 <= win24_29;
      win24_27 <= win24_28;
      win24_26 <= win24_27;
      win24_25 <= win24_26;
      win24_24 <= win24_25;
      win24_23 <= win24_24;
      win24_22 <= win24_23;
      win24_21 <= win24_22;
      win24_20 <= win24_21;
      win24_19 <= win24_20;
      win24_18 <= win24_19;
      win24_17 <= win24_18;
      win24_16 <= win24_17;
      win24_15 <= win24_16;
      win24_14 <= win24_15;
      win24_13 <= win24_14;
      win24_12 <= win24_13;
      win24_11 <= win24_12;
      win24_10 <= win24_11;
      win24_9 <= win24_10;
      win24_8 <= win24_9;
      win24_7 <= win24_8;
      win24_6 <= win24_7;
      win24_5 <= win24_6;
      win24_4 <= win24_5;
      win24_3 <= win24_4;
      win24_2 <= win24_3;
      win24_1 <= win24_2;
      
      win23_30 <= win23_31;
      win23_29 <= win23_30;
      win23_28 <= win23_29;
      win23_27 <= win23_28;
      win23_26 <= win23_27;
      win23_25 <= win23_26;
      win23_24 <= win23_25;
      win23_23 <= win23_24;
      win23_22 <= win23_23;
      win23_21 <= win23_22;
      win23_20 <= win23_21;
      win23_19 <= win23_20;
      win23_18 <= win23_19;
      win23_17 <= win23_18;
      win23_16 <= win23_17;
      win23_15 <= win23_16;
      win23_14 <= win23_15;
      win23_13 <= win23_14;
      win23_12 <= win23_13;
      win23_11 <= win23_12;
      win23_10 <= win23_11;
      win23_9 <= win23_10;
      win23_8 <= win23_9;
      win23_7 <= win23_8;
      win23_6 <= win23_7;
      win23_5 <= win23_6;
      win23_4 <= win23_5;
      win23_3 <= win23_4;
      win23_2 <= win23_3;
      win23_1 <= win23_2;
      
      win22_30 <= win22_31;
      win22_29 <= win22_30;
      win22_28 <= win22_29;
      win22_27 <= win22_28;
      win22_26 <= win22_27;
      win22_25 <= win22_26;
      win22_24 <= win22_25;
      win22_23 <= win22_24;
      win22_22 <= win22_23;
      win22_21 <= win22_22;
      win22_20 <= win22_21;
      win22_19 <= win22_20;
      win22_18 <= win22_19;
      win22_17 <= win22_18;
      win22_16 <= win22_17;
      win22_15 <= win22_16;
      win22_14 <= win22_15;
      win22_13 <= win22_14;
      win22_12 <= win22_13;
      win22_11 <= win22_12;
      win22_10 <= win22_11;
      win22_9 <= win22_10;
      win22_8 <= win22_9;
      win22_7 <= win22_8;
      win22_6 <= win22_7;
      win22_5 <= win22_6;
      win22_4 <= win22_5;
      win22_3 <= win22_4;
      win22_2 <= win22_3;
      win22_1 <= win22_2;
      
      win21_30 <= win21_31;
      win21_29 <= win21_30;
      win21_28 <= win21_29;
      win21_27 <= win21_28;
      win21_26 <= win21_27;
      win21_25 <= win21_26;
      win21_24 <= win21_25;
      win21_23 <= win21_24;
      win21_22 <= win21_23;
      win21_21 <= win21_22;
      win21_20 <= win21_21;
      win21_19 <= win21_20;
      win21_18 <= win21_19;
      win21_17 <= win21_18;
      win21_16 <= win21_17;
      win21_15 <= win21_16;
      win21_14 <= win21_15;
      win21_13 <= win21_14;
      win21_12 <= win21_13;
      win21_11 <= win21_12;
      win21_10 <= win21_11;
      win21_9 <= win21_10;
      win21_8 <= win21_9;
      win21_7 <= win21_8;
      win21_6 <= win21_7;
      win21_5 <= win21_6;
      win21_4 <= win21_5;
      win21_3 <= win21_4;
      win21_2 <= win21_3;
      win21_1 <= win21_2;
      
      win20_30 <= win20_31;
      win20_29 <= win20_30;
      win20_28 <= win20_29;
      win20_27 <= win20_28;
      win20_26 <= win20_27;
      win20_25 <= win20_26;
      win20_24 <= win20_25;
      win20_23 <= win20_24;
      win20_22 <= win20_23;
      win20_21 <= win20_22;
      win20_20 <= win20_21;
      win20_19 <= win20_20;
      win20_18 <= win20_19;
      win20_17 <= win20_18;
      win20_16 <= win20_17;
      win20_15 <= win20_16;
      win20_14 <= win20_15;
      win20_13 <= win20_14;
      win20_12 <= win20_13;
      win20_11 <= win20_12;
      win20_10 <= win20_11;
      win20_9 <= win20_10;
      win20_8 <= win20_9;
      win20_7 <= win20_8;
      win20_6 <= win20_7;
      win20_5 <= win20_6;
      win20_4 <= win20_5;
      win20_3 <= win20_4;
      win20_2 <= win20_3;
      win20_1 <= win20_2;
      
      win19_30 <= win19_31;
      win19_29 <= win19_30;
      win19_28 <= win19_29;
      win19_27 <= win19_28;
      win19_26 <= win19_27;
      win19_25 <= win19_26;
      win19_24 <= win19_25;
      win19_23 <= win19_24;
      win19_22 <= win19_23;
      win19_21 <= win19_22;
      win19_20 <= win19_21;
      win19_19 <= win19_20;
      win19_18 <= win19_19;
      win19_17 <= win19_18;
      win19_16 <= win19_17;
      win19_15 <= win19_16;
      win19_14 <= win19_15;
      win19_13 <= win19_14;
      win19_12 <= win19_13;
      win19_11 <= win19_12;
      win19_10 <= win19_11;
      win19_9 <= win19_10;
      win19_8 <= win19_9;
      win19_7 <= win19_8;
      win19_6 <= win19_7;
      win19_5 <= win19_6;
      win19_4 <= win19_5;
      win19_3 <= win19_4;
      win19_2 <= win19_3;
      win19_1 <= win19_2;
      
      win18_30 <= win18_31;
      win18_29 <= win18_30;
      win18_28 <= win18_29;
      win18_27 <= win18_28;
      win18_26 <= win18_27;
      win18_25 <= win18_26;
      win18_24 <= win18_25;
      win18_23 <= win18_24;
      win18_22 <= win18_23;
      win18_21 <= win18_22;
      win18_20 <= win18_21;
      win18_19 <= win18_20;
      win18_18 <= win18_19;
      win18_17 <= win18_18;
      win18_16 <= win18_17;
      win18_15 <= win18_16;
      win18_14 <= win18_15;
      win18_13 <= win18_14;
      win18_12 <= win18_13;
      win18_11 <= win18_12;
      win18_10 <= win18_11;
      win18_9 <= win18_10;
      win18_8 <= win18_9;
      win18_7 <= win18_8;
      win18_6 <= win18_7;
      win18_5 <= win18_6;
      win18_4 <= win18_5;
      win18_3 <= win18_4;
      win18_2 <= win18_3;
      win18_1 <= win18_2;
      
      win17_30 <= win17_31;
      win17_29 <= win17_30;
      win17_28 <= win17_29;
      win17_27 <= win17_28;
      win17_26 <= win17_27;
      win17_25 <= win17_26;
      win17_24 <= win17_25;
      win17_23 <= win17_24;
      win17_22 <= win17_23;
      win17_21 <= win17_22;
      win17_20 <= win17_21;
      win17_19 <= win17_20;
      win17_18 <= win17_19;
      win17_17 <= win17_18;
      win17_16 <= win17_17;
      win17_15 <= win17_16;
      win17_14 <= win17_15;
      win17_13 <= win17_14;
      win17_12 <= win17_13;
      win17_11 <= win17_12;
      win17_10 <= win17_11;
      win17_9 <= win17_10;
      win17_8 <= win17_9;
      win17_7 <= win17_8;
      win17_6 <= win17_7;
      win17_5 <= win17_6;
      win17_4 <= win17_5;
      win17_3 <= win17_4;
      win17_2 <= win17_3;
      win17_1 <= win17_2;
      
      win16_30 <= win16_31;
      win16_29 <= win16_30;
      win16_28 <= win16_29;
      win16_27 <= win16_28;
      win16_26 <= win16_27;
      win16_25 <= win16_26;
      win16_24 <= win16_25;
      win16_23 <= win16_24;
      win16_22 <= win16_23;
      win16_21 <= win16_22;
      win16_20 <= win16_21;
      win16_19 <= win16_20;
      win16_18 <= win16_19;
      win16_17 <= win16_18;
      win16_16 <= win16_17;
      win16_15 <= win16_16;
      win16_14 <= win16_15;
      win16_13 <= win16_14;
      win16_12 <= win16_13;
      win16_11 <= win16_12;
      win16_10 <= win16_11;
      win16_9 <= win16_10;
      win16_8 <= win16_9;
      win16_7 <= win16_8;
      win16_6 <= win16_7;
      win16_5 <= win16_6;
      win16_4 <= win16_5;
      win16_3 <= win16_4;
      win16_2 <= win16_3;
      win16_1 <= win16_2;
      
      win15_30 <= win15_31;
      win15_29 <= win15_30;
      win15_28 <= win15_29;
      win15_27 <= win15_28;
      win15_26 <= win15_27;
      win15_25 <= win15_26;
      win15_24 <= win15_25;
      win15_23 <= win15_24;
      win15_22 <= win15_23;
      win15_21 <= win15_22;
      win15_20 <= win15_21;
      win15_19 <= win15_20;
      win15_18 <= win15_19;
      win15_17 <= win15_18;
      win15_16 <= win15_17;
      win15_15 <= win15_16;
      win15_14 <= win15_15;
      win15_13 <= win15_14;
      win15_12 <= win15_13;
      win15_11 <= win15_12;
      win15_10 <= win15_11;
      win15_9 <= win15_10;
      win15_8 <= win15_9;
      win15_7 <= win15_8;
      win15_6 <= win15_7;
      win15_5 <= win15_6;
      win15_4 <= win15_5;
      win15_3 <= win15_4;
      win15_2 <= win15_3;
      win15_1 <= win15_2;
      
      win14_30 <= win14_31;
      win14_29 <= win14_30;
      win14_28 <= win14_29;
      win14_27 <= win14_28;
      win14_26 <= win14_27;
      win14_25 <= win14_26;
      win14_24 <= win14_25;
      win14_23 <= win14_24;
      win14_22 <= win14_23;
      win14_21 <= win14_22;
      win14_20 <= win14_21;
      win14_19 <= win14_20;
      win14_18 <= win14_19;
      win14_17 <= win14_18;
      win14_16 <= win14_17;
      win14_15 <= win14_16;
      win14_14 <= win14_15;
      win14_13 <= win14_14;
      win14_12 <= win14_13;
      win14_11 <= win14_12;
      win14_10 <= win14_11;
      win14_9 <= win14_10;
      win14_8 <= win14_9;
      win14_7 <= win14_8;
      win14_6 <= win14_7;
      win14_5 <= win14_6;
      win14_4 <= win14_5;
      win14_3 <= win14_4;
      win14_2 <= win14_3;
      win14_1 <= win14_2;
      
      win13_30 <= win13_31;
      win13_29 <= win13_30;
      win13_28 <= win13_29;
      win13_27 <= win13_28;
      win13_26 <= win13_27;
      win13_25 <= win13_26;
      win13_24 <= win13_25;
      win13_23 <= win13_24;
      win13_22 <= win13_23;
      win13_21 <= win13_22;
      win13_20 <= win13_21;
      win13_19 <= win13_20;
      win13_18 <= win13_19;
      win13_17 <= win13_18;
      win13_16 <= win13_17;
      win13_15 <= win13_16;
      win13_14 <= win13_15;
      win13_13 <= win13_14;
      win13_12 <= win13_13;
      win13_11 <= win13_12;
      win13_10 <= win13_11;
      win13_9 <= win13_10;
      win13_8 <= win13_9;
      win13_7 <= win13_8;
      win13_6 <= win13_7;
      win13_5 <= win13_6;
      win13_4 <= win13_5;
      win13_3 <= win13_4;
      win13_2 <= win13_3;
      win13_1 <= win13_2;
      
      win12_30 <= win12_31;
      win12_29 <= win12_30;
      win12_28 <= win12_29;
      win12_27 <= win12_28;
      win12_26 <= win12_27;
      win12_25 <= win12_26;
      win12_24 <= win12_25;
      win12_23 <= win12_24;
      win12_22 <= win12_23;
      win12_21 <= win12_22;
      win12_20 <= win12_21;
      win12_19 <= win12_20;
      win12_18 <= win12_19;
      win12_17 <= win12_18;
      win12_16 <= win12_17;
      win12_15 <= win12_16;
      win12_14 <= win12_15;
      win12_13 <= win12_14;
      win12_12 <= win12_13;
      win12_11 <= win12_12;
      win12_10 <= win12_11;
      win12_9 <= win12_10;
      win12_8 <= win12_9;
      win12_7 <= win12_8;
      win12_6 <= win12_7;
      win12_5 <= win12_6;
      win12_4 <= win12_5;
      win12_3 <= win12_4;
      win12_2 <= win12_3;
      win12_1 <= win12_2;
      
      win11_30 <= win11_31;
      win11_29 <= win11_30;
      win11_28 <= win11_29;
      win11_27 <= win11_28;
      win11_26 <= win11_27;
      win11_25 <= win11_26;
      win11_24 <= win11_25;
      win11_23 <= win11_24;
      win11_22 <= win11_23;
      win11_21 <= win11_22;
      win11_20 <= win11_21;
      win11_19 <= win11_20;
      win11_18 <= win11_19;
      win11_17 <= win11_18;
      win11_16 <= win11_17;
      win11_15 <= win11_16;
      win11_14 <= win11_15;
      win11_13 <= win11_14;
      win11_12 <= win11_13;
      win11_11 <= win11_12;
      win11_10 <= win11_11;
      win11_9 <= win11_10;
      win11_8 <= win11_9;
      win11_7 <= win11_8;
      win11_6 <= win11_7;
      win11_5 <= win11_6;
      win11_4 <= win11_5;
      win11_3 <= win11_4;
      win11_2 <= win11_3;
      win11_1 <= win11_2;
      
      win10_30 <= win10_31;
      win10_29 <= win10_30;
      win10_28 <= win10_29;
      win10_27 <= win10_28;
      win10_26 <= win10_27;
      win10_25 <= win10_26;
      win10_24 <= win10_25;
      win10_23 <= win10_24;
      win10_22 <= win10_23;
      win10_21 <= win10_22;
      win10_20 <= win10_21;
      win10_19 <= win10_20;
      win10_18 <= win10_19;
      win10_17 <= win10_18;
      win10_16 <= win10_17;
      win10_15 <= win10_16;
      win10_14 <= win10_15;
      win10_13 <= win10_14;
      win10_12 <= win10_13;
      win10_11 <= win10_12;
      win10_10 <= win10_11;
      win10_9 <= win10_10;
      win10_8 <= win10_9;
      win10_7 <= win10_8;
      win10_6 <= win10_7;
      win10_5 <= win10_6;
      win10_4 <= win10_5;
      win10_3 <= win10_4;
      win10_2 <= win10_3;
      win10_1 <= win10_2;
      
      win9_30 <= win9_31;
      win9_29 <= win9_30;
      win9_28 <= win9_29;
      win9_27 <= win9_28;
      win9_26 <= win9_27;
      win9_25 <= win9_26;
      win9_24 <= win9_25;
      win9_23 <= win9_24;
      win9_22 <= win9_23;
      win9_21 <= win9_22;
      win9_20 <= win9_21;
      win9_19 <= win9_20;
      win9_18 <= win9_19;
      win9_17 <= win9_18;
      win9_16 <= win9_17;
      win9_15 <= win9_16;
      win9_14 <= win9_15;
      win9_13 <= win9_14;
      win9_12 <= win9_13;
      win9_11 <= win9_12;
      win9_10 <= win9_11;
      win9_9 <= win9_10;
      win9_8 <= win9_9;
      win9_7 <= win9_8;
      win9_6 <= win9_7;
      win9_5 <= win9_6;
      win9_4 <= win9_5;
      win9_3 <= win9_4;
      win9_2 <= win9_3;
      win9_1 <= win9_2;
      
      win8_30 <= win8_31;
      win8_29 <= win8_30;
      win8_28 <= win8_29;
      win8_27 <= win8_28;
      win8_26 <= win8_27;
      win8_25 <= win8_26;
      win8_24 <= win8_25;
      win8_23 <= win8_24;
      win8_22 <= win8_23;
      win8_21 <= win8_22;
      win8_20 <= win8_21;
      win8_19 <= win8_20;
      win8_18 <= win8_19;
      win8_17 <= win8_18;
      win8_16 <= win8_17;
      win8_15 <= win8_16;
      win8_14 <= win8_15;
      win8_13 <= win8_14;
      win8_12 <= win8_13;
      win8_11 <= win8_12;
      win8_10 <= win8_11;
      win8_9 <= win8_10;
      win8_8 <= win8_9;
      win8_7 <= win8_8;
      win8_6 <= win8_7;
      win8_5 <= win8_6;
      win8_4 <= win8_5;
      win8_3 <= win8_4;
      win8_2 <= win8_3;
      win8_1 <= win8_2;
      
      win7_30 <= win7_31;
      win7_29 <= win7_30;
      win7_28 <= win7_29;
      win7_27 <= win7_28;
      win7_26 <= win7_27;
      win7_25 <= win7_26;
      win7_24 <= win7_25;
      win7_23 <= win7_24;
      win7_22 <= win7_23;
      win7_21 <= win7_22;
      win7_20 <= win7_21;
      win7_19 <= win7_20;
      win7_18 <= win7_19;
      win7_17 <= win7_18;
      win7_16 <= win7_17;
      win7_15 <= win7_16;
      win7_14 <= win7_15;
      win7_13 <= win7_14;
      win7_12 <= win7_13;
      win7_11 <= win7_12;
      win7_10 <= win7_11;
      win7_9 <= win7_10;
      win7_8 <= win7_9;
      win7_7 <= win7_8;
      win7_6 <= win7_7;
      win7_5 <= win7_6;
      win7_4 <= win7_5;
      win7_3 <= win7_4;
      win7_2 <= win7_3;
      win7_1 <= win7_2;
      
      win6_30 <= win6_31;
      win6_29 <= win6_30;
      win6_28 <= win6_29;
      win6_27 <= win6_28;
      win6_26 <= win6_27;
      win6_25 <= win6_26;
      win6_24 <= win6_25;
      win6_23 <= win6_24;
      win6_22 <= win6_23;
      win6_21 <= win6_22;
      win6_20 <= win6_21;
      win6_19 <= win6_20;
      win6_18 <= win6_19;
      win6_17 <= win6_18;
      win6_16 <= win6_17;
      win6_15 <= win6_16;
      win6_14 <= win6_15;
      win6_13 <= win6_14;
      win6_12 <= win6_13;
      win6_11 <= win6_12;
      win6_10 <= win6_11;
      win6_9 <= win6_10;
      win6_8 <= win6_9;
      win6_7 <= win6_8;
      win6_6 <= win6_7;
      win6_5 <= win6_6;
      win6_4 <= win6_5;
      win6_3 <= win6_4;
      win6_2 <= win6_3;
      win6_1 <= win6_2;
      
      win5_30 <= win5_31;
      win5_29 <= win5_30;
      win5_28 <= win5_29;
      win5_27 <= win5_28;
      win5_26 <= win5_27;
      win5_25 <= win5_26;
      win5_24 <= win5_25;
      win5_23 <= win5_24;
      win5_22 <= win5_23;
      win5_21 <= win5_22;
      win5_20 <= win5_21;
      win5_19 <= win5_20;
      win5_18 <= win5_19;
      win5_17 <= win5_18;
      win5_16 <= win5_17;
      win5_15 <= win5_16;
      win5_14 <= win5_15;
      win5_13 <= win5_14;
      win5_12 <= win5_13;
      win5_11 <= win5_12;
      win5_10 <= win5_11;
      win5_9 <= win5_10;
      win5_8 <= win5_9;
      win5_7 <= win5_8;
      win5_6 <= win5_7;
      win5_5 <= win5_6;
      win5_4 <= win5_5;
      win5_3 <= win5_4;
      win5_2 <= win5_3;
      win5_1 <= win5_2;
      
      win4_30 <= win4_31;
      win4_29 <= win4_30;
      win4_28 <= win4_29;
      win4_27 <= win4_28;
      win4_26 <= win4_27;
      win4_25 <= win4_26;
      win4_24 <= win4_25;
      win4_23 <= win4_24;
      win4_22 <= win4_23;
      win4_21 <= win4_22;
      win4_20 <= win4_21;
      win4_19 <= win4_20;
      win4_18 <= win4_19;
      win4_17 <= win4_18;
      win4_16 <= win4_17;
      win4_15 <= win4_16;
      win4_14 <= win4_15;
      win4_13 <= win4_14;
      win4_12 <= win4_13;
      win4_11 <= win4_12;
      win4_10 <= win4_11;
      win4_9 <= win4_10;
      win4_8 <= win4_9;
      win4_7 <= win4_8;
      win4_6 <= win4_7;
      win4_5 <= win4_6;
      win4_4 <= win4_5;
      win4_3 <= win4_4;
      win4_2 <= win4_3;
      win4_1 <= win4_2;
      
      win3_30 <= win3_31;
      win3_29 <= win3_30;
      win3_28 <= win3_29;
      win3_27 <= win3_28;
      win3_26 <= win3_27;
      win3_25 <= win3_26;
      win3_24 <= win3_25;
      win3_23 <= win3_24;
      win3_22 <= win3_23;
      win3_21 <= win3_22;
      win3_20 <= win3_21;
      win3_19 <= win3_20;
      win3_18 <= win3_19;
      win3_17 <= win3_18;
      win3_16 <= win3_17;
      win3_15 <= win3_16;
      win3_14 <= win3_15;
      win3_13 <= win3_14;
      win3_12 <= win3_13;
      win3_11 <= win3_12;
      win3_10 <= win3_11;
      win3_9 <= win3_10;
      win3_8 <= win3_9;
      win3_7 <= win3_8;
      win3_6 <= win3_7;
      win3_5 <= win3_6;
      win3_4 <= win3_5;
      win3_3 <= win3_4;
      win3_2 <= win3_3;
      win3_1 <= win3_2;
      
      win2_30 <= win2_31;
      win2_29 <= win2_30;
      win2_28 <= win2_29;
      win2_27 <= win2_28;
      win2_26 <= win2_27;
      win2_25 <= win2_26;
      win2_24 <= win2_25;
      win2_23 <= win2_24;
      win2_22 <= win2_23;
      win2_21 <= win2_22;
      win2_20 <= win2_21;
      win2_19 <= win2_20;
      win2_18 <= win2_19;
      win2_17 <= win2_18;
      win2_16 <= win2_17;
      win2_15 <= win2_16;
      win2_14 <= win2_15;
      win2_13 <= win2_14;
      win2_12 <= win2_13;
      win2_11 <= win2_12;
      win2_10 <= win2_11;
      win2_9 <= win2_10;
      win2_8 <= win2_9;
      win2_7 <= win2_8;
      win2_6 <= win2_7;
      win2_5 <= win2_6;
      win2_4 <= win2_5;
      win2_3 <= win2_4;
      win2_2 <= win2_3;
      win2_1 <= win2_2;
      
      win1_30 <= win1_31;
      win1_29 <= win1_30;
      win1_28 <= win1_29;
      win1_27 <= win1_28;
      win1_26 <= win1_27;
      win1_25 <= win1_26;
      win1_24 <= win1_25;
      win1_23 <= win1_24;
      win1_22 <= win1_23;
      win1_21 <= win1_22;
      win1_20 <= win1_21;
      win1_19 <= win1_20;
      win1_18 <= win1_19;
      win1_17 <= win1_18;
      win1_16 <= win1_17;
      win1_15 <= win1_16;
      win1_14 <= win1_15;
      win1_13 <= win1_14;
      win1_12 <= win1_13;
      win1_11 <= win1_12;
      win1_10 <= win1_11;
      win1_9 <= win1_10;
      win1_8 <= win1_9;
      win1_7 <= win1_8;
      win1_6 <= win1_7;
      win1_5 <= win1_6;
      win1_4 <= win1_5;
      win1_3 <= win1_4;
      win1_2 <= win1_3;
      win1_1 <= win1_2;
      
      
      
  end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    sel_2 <= 1'b0;
  else if(start==1'b1)
    sel_2 <= 1'b0;
  else if(Y==498 && X==658)
    sel_2 <= 1'b1;
end
 
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en_XY <= 1'b0;
  else 
    en_XY <= en_2;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_2 <= 10'b0000000000;
  else if(start==1'b1)
    count_2 <= 10'b0000000000;
  else if(en_2==1'b1 && addr_mid>=21504)
    begin
      if(count_2<=671)
          count_2 <= count_2 + 1'b1;
      else
          count_2 <= 10'd1;
    end
end
   
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      X <= 10'd0;
      Y <= 10'd0;
    end
  else if(start==1'b1)
    begin
      Y <= 10'd18;
      X <= 10'd19;
    end
  else if(en_XY==1'b1)
    begin
      if(count_2>32 && count_2<=671)
        begin
          if(sel_2==1'b0)
             X <= count_2 - 4'd13;
        end
      else if(count_2==32 && Y<498)
        begin
          X <= 10'd19;
          Y <= Y + 1'b1;
        end
    end
end


    
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_mod1 <= 9'd0;   
  else if(start==1'b1)
    addr_mod1 <= 9'd0;
  else if(XY==XY_in)
  begin
    if(addr_mod1<510)
      addr_mod1 <= addr_mod1 + 2'd2;
  end
  else
    addr_mod1 <= 9'd0;
end
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_mod2 <= 9'd0;   
  else if(start==1)
    addr_mod2 <= 9'd1;
  else if(XY==XY_in)
  begin
    if(addr_mod2<511)
      addr_mod2 <= addr_mod2 + 2'd2;
  end  
  else
    addr_mod2 <= 9'd1;
end
  


//always@(posedge clk or negedge rst_n)
//begin
//  if(!rst_n)
 //   begin
//      X1_temp <= 18'd0;
//      Y1_temp <= 18'd0;
//      X2_temp <= 18'd0;
 //     Y2_temp <= 18'd0;
//    end
//  else if(XY==XY_in)
//    begin
//      X1_temp <= mod1_X*cos - mod1_Y*sin;
//     Y1_temp <= mod1_X*sin + mod1_Y*cos;
 //     X2_temp <= mod2_X*cos - mod2_Y*sin;
//      Y2_temp <= mod2_X*sin + mod2_Y*cos;
 //   end
//end

assign X1_temp = X1_temp_tp1 - X1_temp_tp2;
assign Y1_temp = Y1_temp_tp1 + Y1_temp_tp2;
assign X2_temp = X2_temp_tp1 - X2_temp_tp2;
assign Y2_temp = Y2_temp_tp1 + Y2_temp_tp2;

mul6 mm1(.aclr(aclr),
        .clken(clken_mm),
        .clock(clk),
        .dataa(mod1_X),
        .datab(cos),
        .result(X1_temp_tp1));
        
mul6 mm2(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod1_Y),
         .datab(sin),
         .result(X1_temp_tp2));
        
mul6 mm3(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod1_X),
         .datab(sin),
         .result(Y1_temp_tp1));
         
mul6 mm4(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod1_Y),
         .datab(cos),
         .result(Y1_temp_tp2));
         
mul6 mm5(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod2_X),
         .datab(cos),
         .result(X2_temp_tp1));
         
mul6 mm6(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod2_Y),
         .datab(sin),
         .result(X2_temp_tp2));
         
mul6 mm7(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod2_X),
         .datab(sin),
         .result(Y2_temp_tp1));
         
mul6 mm8(.aclr(aclr),
         .clken(clken_mm),
         .clock(clk),
         .dataa(mod2_Y),
         .datab(cos),
         .result(Y2_temp_tp2));
         
         
        

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    X1 <= 5'd0;
  else
    begin
      if(X1_temp[11]==1'b1)
        X1 <= X1_temp[16:12] + 1'b1;
      else
        X1 <= X1_temp[16:12];
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    Y1 <= 5'd0;
  else
   begin
      if(Y1_temp[11]==1'b1)
        Y1 <= Y1_temp[16:12] + 1'b1;
    else
        Y1 <= Y1_temp[16:12];
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    X2 <= 5'd0;
  else
    begin
      if(X2_temp[11]==1'b1)
        X2 <= X2_temp[16:12] + 1'b1;
      else
        X2 <= X2_temp[16:12];
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    Y2 <= 5'd0;
  else
    begin
      if(Y2_temp[11]==1'b1)
        Y2 <= Y2_temp[16:12] + 1'b1;
      else
        Y2 <= Y2_temp[16:12];
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      X1_tp <= 5'd0;
      Y1_tp <= 5'd0;
      X2_tp <= 5'd0;
      Y2_tp <= 5'd0;
    end
  else
    begin
      X1_tp <= X1;
      Y1_tp <= Y1;
      X2_tp <= X2;
      Y2_tp <= Y2;
    end
end
      
      
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    data_1_00 <= 8'd0;
  else
    begin
      case({X1[3:0],Y1[3:0]})
      8'b11111111 : data_1_00 <= win1_31;
      8'b11111110 : data_1_00 <= win2_31;
      8'b11111101 : data_1_00 <= win3_31;
      8'b11111100 : data_1_00 <= win4_31;
      8'b11111011 : data_1_00 <= win5_31;
      8'b11111010 : data_1_00 <= win6_31; 
      8'b11111001 : data_1_00 <= win7_31;
      8'b11111000 : data_1_00 <= win8_31;
      8'b11110111 : data_1_00 <= win9_31;
      8'b11110110 : data_1_00 <= win10_31;
      8'b11110101 : data_1_00 <= win11_31;
      8'b11110100 : data_1_00 <= win12_31;
      8'b11110011 : data_1_00 <= win13_31;
      8'b11110010 : data_1_00 <= win14_31;
      8'b11110001 : data_1_00 <= win15_31;
      8'b11110000 : data_1_00 <= win16_31;
      8'b11101111 : data_1_00 <= win1_30;
      8'b11101110 : data_1_00 <= win2_30;
      8'b11101101 : data_1_00 <= win3_30;
      8'b11101100 : data_1_00 <= win4_30;
      8'b11101011 : data_1_00 <= win5_30;
      8'b11101010 : data_1_00 <= win6_30; 
      8'b11101001 : data_1_00 <= win7_30;
      8'b11101000 : data_1_00 <= win8_30;
      8'b11100111 : data_1_00 <= win9_30;
      8'b11100110 : data_1_00 <= win10_30;
      8'b11100101 : data_1_00 <= win11_30;
      8'b11100100 : data_1_00 <= win12_30;
      8'b11100011 : data_1_00 <= win13_30;
      8'b11100010 : data_1_00 <= win14_30;
      8'b11100001 : data_1_00 <= win15_30;
      8'b11100000 : data_1_00 <= win16_30;
      8'b11011111 : data_1_00 <= win1_29;
      8'b11011110 : data_1_00 <= win2_29;
      8'b11011101 : data_1_00 <= win3_29;
      8'b11011100 : data_1_00 <= win4_29;
      8'b11011011 : data_1_00 <= win5_29;
      8'b11011010 : data_1_00 <= win6_29; 
      8'b11011001 : data_1_00 <= win7_29;
      8'b11011000 : data_1_00 <= win8_29;
      8'b11010111 : data_1_00 <= win9_29;
      8'b11010110 : data_1_00 <= win10_29;
      8'b11010101 : data_1_00 <= win11_29;
      8'b11010100 : data_1_00 <= win12_29;
      8'b11010011 : data_1_00 <= win13_29;
      8'b11010010 : data_1_00 <= win14_29;
      8'b11010001 : data_1_00 <= win15_29;
      8'b11010000 : data_1_00 <= win16_29;
      8'b11001111 : data_1_00 <= win1_28;
      8'b11001110 : data_1_00 <= win2_28;
      8'b11001101 : data_1_00 <= win3_28;
      8'b11001100 : data_1_00 <= win4_28;
      8'b11001011 : data_1_00 <= win5_28;
      8'b11001010 : data_1_00 <= win6_28; 
      8'b11001001 : data_1_00 <= win7_28;
      8'b11001000 : data_1_00 <= win8_28;
      8'b11000111 : data_1_00 <= win9_28;
      8'b11000110 : data_1_00 <= win10_28;
      8'b11000101 : data_1_00 <= win11_28;
      8'b11000100 : data_1_00 <= win12_28;
      8'b11000011 : data_1_00 <= win13_28;
      8'b11000010 : data_1_00 <= win14_28;
      8'b11000001 : data_1_00 <= win15_28;
      8'b11000000 : data_1_00 <= win16_28;
      8'b10111111 : data_1_00 <= win1_27;
      8'b10111110 : data_1_00 <= win2_27;
      8'b10111101 : data_1_00 <= win3_27;
      8'b10111100 : data_1_00 <= win4_27;
      8'b10111011 : data_1_00 <= win5_27;
      8'b10111010 : data_1_00 <= win6_27; 
      8'b10111001 : data_1_00 <= win7_27;
      8'b10111000 : data_1_00 <= win8_27;
      8'b10110111 : data_1_00 <= win9_27;
      8'b10110110 : data_1_00 <= win10_27;
      8'b10110101 : data_1_00 <= win11_27;
      8'b10110100 : data_1_00 <= win12_27;
      8'b10110011 : data_1_00 <= win13_27;
      8'b10110010 : data_1_00 <= win14_27;
      8'b10110001 : data_1_00 <= win15_27;
      8'b10110000 : data_1_00 <= win16_27;
      8'b10101111 : data_1_00 <= win1_26;
      8'b10101110 : data_1_00 <= win2_26;
      8'b10101101 : data_1_00 <= win3_26;
      8'b10101100 : data_1_00 <= win4_26;
      8'b10101011 : data_1_00 <= win5_26;
      8'b10101010 : data_1_00 <= win6_26; 
      8'b10101001 : data_1_00 <= win7_26;
      8'b10101000 : data_1_00 <= win8_26;
      8'b10100111 : data_1_00 <= win9_26;
      8'b10100110 : data_1_00 <= win10_26;
      8'b10100101 : data_1_00 <= win11_26;
      8'b10100100 : data_1_00 <= win12_26;
      8'b10100011 : data_1_00 <= win13_26;
      8'b10100010 : data_1_00 <= win14_26;
      8'b10100001 : data_1_00 <= win15_26;
      8'b10100000 : data_1_00 <= win16_26;
      8'b10011111 : data_1_00 <= win1_25;
      8'b10011110 : data_1_00 <= win2_25;
      8'b10011101 : data_1_00 <= win3_25;
      8'b10011100 : data_1_00 <= win4_25;
      8'b10011011 : data_1_00 <= win5_25;
      8'b10011010 : data_1_00 <= win6_25; 
      8'b10011001 : data_1_00 <= win7_25;
      8'b10011000 : data_1_00 <= win8_25;
      8'b10010111 : data_1_00 <= win9_25;
      8'b10010110 : data_1_00 <= win10_25;
      8'b10010101 : data_1_00 <= win11_25;
      8'b10010100 : data_1_00 <= win12_25;
      8'b10010011 : data_1_00 <= win13_25;
      8'b10010010 : data_1_00 <= win14_25;
      8'b10010001 : data_1_00 <= win15_25;
      8'b10010000 : data_1_00 <= win16_25;
      8'b10001111 : data_1_00 <= win1_24;
      8'b10001110 : data_1_00 <= win2_24;
      8'b10001101 : data_1_00 <= win3_24;
      8'b10001100 : data_1_00 <= win4_24;
      8'b10001011 : data_1_00 <= win5_24;
      8'b10001010 : data_1_00 <= win6_24; 
      8'b10001001 : data_1_00 <= win7_24;
      8'b10001000 : data_1_00 <= win8_24;
      8'b10000111 : data_1_00 <= win9_24;
      8'b10000110 : data_1_00 <= win10_24;
      8'b10000101 : data_1_00 <= win11_24;
      8'b10000100 : data_1_00 <= win12_24;
      8'b10000011 : data_1_00 <= win13_24;
      8'b10000010 : data_1_00 <= win14_24;
      8'b10000001 : data_1_00 <= win15_24;
      8'b10000000 : data_1_00 <= win16_24;
      8'b01111111 : data_1_00 <= win1_23;
      8'b01111110 : data_1_00 <= win2_23;
      8'b01111101 : data_1_00 <= win3_23;
      8'b01111100 : data_1_00 <= win4_23;
      8'b01111011 : data_1_00 <= win5_23;
      8'b01111010 : data_1_00 <= win6_23; 
      8'b01111001 : data_1_00 <= win7_23;
      8'b01111000 : data_1_00 <= win8_23;
      8'b01110111 : data_1_00 <= win9_23;
      8'b01110110 : data_1_00 <= win10_23;
      8'b01110101 : data_1_00 <= win11_23;
      8'b01110100 : data_1_00 <= win12_23;
      8'b01110011 : data_1_00 <= win13_23;
      8'b01110010 : data_1_00 <= win14_23;
      8'b01110001 : data_1_00 <= win15_23;
      8'b01110000 : data_1_00 <= win16_23;
      8'b01101111 : data_1_00 <= win1_22;
      8'b01101110 : data_1_00 <= win2_22;
      8'b01101101 : data_1_00 <= win3_22;
      8'b01101100 : data_1_00 <= win4_22;
      8'b01101011 : data_1_00 <= win5_22;
      8'b01101010 : data_1_00 <= win6_22; 
      8'b01101001 : data_1_00 <= win7_22;
      8'b01101000 : data_1_00 <= win8_22;
      8'b01100111 : data_1_00 <= win9_22;
      8'b01100110 : data_1_00 <= win10_22;
      8'b01100101 : data_1_00 <= win11_22;
      8'b01100100 : data_1_00 <= win12_22;
      8'b01100011 : data_1_00 <= win13_22;
      8'b01100010 : data_1_00 <= win14_22;
      8'b01100001 : data_1_00 <= win15_22;
      8'b01100000 : data_1_00 <= win16_22;
      8'b01011111 : data_1_00 <= win1_21;
      8'b01011110 : data_1_00 <= win2_21;
      8'b01011101 : data_1_00 <= win3_21;
      8'b01011100 : data_1_00 <= win4_21;
      8'b01011011 : data_1_00 <= win5_21;
      8'b01011010 : data_1_00 <= win6_21; 
      8'b01011001 : data_1_00 <= win7_21;
      8'b01011000 : data_1_00 <= win8_21;
      8'b01010111 : data_1_00 <= win9_21;
      8'b01010110 : data_1_00 <= win10_21;
      8'b01010101 : data_1_00 <= win11_21;
      8'b01010100 : data_1_00 <= win12_21;
      8'b01010011 : data_1_00 <= win13_21;
      8'b01010010 : data_1_00 <= win14_21;
      8'b01010001 : data_1_00 <= win15_21;
      8'b01010000 : data_1_00 <= win16_21;
      8'b01001111 : data_1_00 <= win1_20;
      8'b01001110 : data_1_00 <= win2_20;
      8'b01001101 : data_1_00 <= win3_20;
      8'b01001100 : data_1_00 <= win4_20;
      8'b01001011 : data_1_00 <= win5_20;
      8'b01001010 : data_1_00 <= win6_20; 
      8'b01001001 : data_1_00 <= win7_20;
      8'b01001000 : data_1_00 <= win8_20;
      8'b01000111 : data_1_00 <= win9_20;
      8'b01000110 : data_1_00 <= win10_20;
      8'b01000101 : data_1_00 <= win11_20;
      8'b01000100 : data_1_00 <= win12_20;
      8'b01000011 : data_1_00 <= win13_20;
      8'b01000010 : data_1_00 <= win14_20;
      8'b01000001 : data_1_00 <= win15_20;
      8'b01000000 : data_1_00 <= win16_20;
      8'b00111111 : data_1_00 <= win1_19;
      8'b00111110 : data_1_00 <= win2_19;
      8'b00111101 : data_1_00 <= win3_19;
      8'b00111100 : data_1_00 <= win4_19;
      8'b00111011 : data_1_00 <= win5_19;
      8'b00111010 : data_1_00 <= win6_19; 
      8'b00111001 : data_1_00 <= win7_19;
      8'b00111000 : data_1_00 <= win8_19;
      8'b00110111 : data_1_00 <= win9_19;
      8'b00110110 : data_1_00 <= win10_19;
      8'b00110101 : data_1_00 <= win11_19;
      8'b00110100 : data_1_00 <= win12_19;
      8'b00110011 : data_1_00 <= win13_19;
      8'b00110010 : data_1_00 <= win14_19;
      8'b00110001 : data_1_00 <= win15_19;
      8'b00110000 : data_1_00 <= win16_19;
      8'b00101111 : data_1_00 <= win1_18;
      8'b00101110 : data_1_00 <= win2_18;
      8'b00101101 : data_1_00 <= win3_18;
      8'b00101100 : data_1_00 <= win4_18;
      8'b00101011 : data_1_00 <= win5_18;
      8'b00101010 : data_1_00 <= win6_18; 
      8'b00101001 : data_1_00 <= win7_18;
      8'b00101000 : data_1_00 <= win8_18;
      8'b00100111 : data_1_00 <= win9_18;
      8'b00100110 : data_1_00 <= win10_18;
      8'b00100101 : data_1_00 <= win11_18;
      8'b00100100 : data_1_00 <= win12_18;
      8'b00100011 : data_1_00 <= win13_18;
      8'b00100010 : data_1_00 <= win14_18;
      8'b00100001 : data_1_00 <= win15_18;
      8'b00100000 : data_1_00 <= win16_18;
      8'b00011111 : data_1_00 <= win1_17;
      8'b00011110 : data_1_00 <= win2_17;
      8'b00011101 : data_1_00 <= win3_17;
      8'b00011100 : data_1_00 <= win4_17;
      8'b00011011 : data_1_00 <= win5_17;
      8'b00011010 : data_1_00 <= win6_17; 
      8'b00011001 : data_1_00 <= win7_17;
      8'b00011000 : data_1_00 <= win8_17;
      8'b00010111 : data_1_00 <= win9_17;
      8'b00010110 : data_1_00 <= win10_17;
      8'b00010101 : data_1_00 <= win11_17;
      8'b00010100 : data_1_00 <= win12_17;
      8'b00010011 : data_1_00 <= win13_17;
      8'b00010010 : data_1_00 <= win14_17;
      8'b00010001 : data_1_00 <= win15_17;
      8'b00010000 : data_1_00 <= win16_17;
      8'b00001111 : data_1_00 <= win1_16;
      8'b00001110 : data_1_00 <= win2_16;
      8'b00001101 : data_1_00 <= win3_16;
      8'b00001100 : data_1_00 <= win4_16;
      8'b00001011 : data_1_00 <= win5_16;
      8'b00001010 : data_1_00 <= win6_16; 
      8'b00001001 : data_1_00 <= win7_16;
      8'b00001000 : data_1_00 <= win8_16;
      8'b00000111 : data_1_00 <= win9_16;
      8'b00000110 : data_1_00 <= win10_16;
      8'b00000101 : data_1_00 <= win11_16;
      8'b00000100 : data_1_00 <= win12_16;
      8'b00000011 : data_1_00 <= win13_16;
      8'b00000010 : data_1_00 <= win14_16;
      8'b00000001 : data_1_00 <= win15_16;
      8'b00000000 : data_1_00 <= win16_16;
      endcase
    end
end


always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    data_1_01 <= 8'd0;
  else
    begin
      case({X1[3:0],Y1[3:0]})
      8'b11111111 : data_1_01 <= win17_31;    
      8'b11111110 : data_1_01 <= win18_31;
      8'b11111101 : data_1_01 <= win19_31;
      8'b11111100 : data_1_01 <= win20_31;
      8'b11111011 : data_1_01 <= win21_31;
      8'b11111010 : data_1_01 <= win22_31;
      8'b11111001 : data_1_01 <= win23_31;
      8'b11111000 : data_1_01 <= win24_31;
      8'b11110111 : data_1_01 <= win25_31;
      8'b11110110 : data_1_01 <= win26_31;
      8'b11110101 : data_1_01 <= win27_31;
      8'b11110100 : data_1_01 <= win28_31;
      8'b11110011 : data_1_01 <= win29_31;
      8'b11110010 : data_1_01 <= win30_31;
      8'b11110001 : data_1_01 <= win31_31;
      8'b11110000 : data_1_01 <= win31_31;
      8'b11101111 : data_1_01 <= win17_30;    
      8'b11101110 : data_1_01 <= win18_30;
      8'b11101101 : data_1_01 <= win19_30;
      8'b11101100 : data_1_01 <= win20_30;
      8'b11101011 : data_1_01 <= win21_30;
      8'b11101010 : data_1_01 <= win22_30;
      8'b11101001 : data_1_01 <= win23_30;
      8'b11101000 : data_1_01 <= win24_30;
      8'b11100111 : data_1_01 <= win25_30;
      8'b11100110 : data_1_01 <= win26_30;
      8'b11100101 : data_1_01 <= win27_30;
      8'b11100100 : data_1_01 <= win28_30;
      8'b11100011 : data_1_01 <= win29_30;
      8'b11100010 : data_1_01 <= win30_30;
      8'b11100001 : data_1_01 <= win31_30;
      8'b11100000 : data_1_01 <= win31_30;
      8'b11011111 : data_1_01 <= win17_29;
      8'b11011110 : data_1_01 <= win18_29;
      8'b11011101 : data_1_01 <= win19_29;
      8'b11011100 : data_1_01 <= win20_29;
      8'b11011011 : data_1_01 <= win21_29;
      8'b11011010 : data_1_01 <= win22_29;
      8'b11011001 : data_1_01 <= win23_29;
      8'b11011000 : data_1_01 <= win24_29;
      8'b11010111 : data_1_01 <= win25_29;
      8'b11010110 : data_1_01 <= win26_29;
      8'b11010101 : data_1_01 <= win27_29;
      8'b11010100 : data_1_01 <= win28_29;
      8'b11010011 : data_1_01 <= win29_29;
      8'b11010010 : data_1_01 <= win30_29;
      8'b11010001 : data_1_01 <= win31_29;
      8'b11010000 : data_1_01 <= win31_29;
      8'b11001111 : data_1_01 <= win17_28;
      8'b11001110 : data_1_01 <= win18_28;
      8'b11001101 : data_1_01 <= win19_28;
      8'b11001100 : data_1_01 <= win20_28;
      8'b11001011 : data_1_01 <= win21_28;
      8'b11001010 : data_1_01 <= win22_28;
      8'b11001001 : data_1_01 <= win23_28;
      8'b11001000 : data_1_01 <= win24_28;
      8'b11000111 : data_1_01 <= win25_28;
      8'b11000110 : data_1_01 <= win26_28;
      8'b11000101 : data_1_01 <= win27_28;
      8'b11000100 : data_1_01 <= win28_28;
      8'b11000011 : data_1_01 <= win29_28;
      8'b11000010 : data_1_01 <= win30_28;
      8'b11000001 : data_1_01 <= win31_28;
      8'b11000000 : data_1_01 <= win31_28;
      8'b10111111 : data_1_01 <= win17_27;
      8'b10111110 : data_1_01 <= win18_27;
      8'b10111101 : data_1_01 <= win19_27;
      8'b10111100 : data_1_01 <= win20_27;
      8'b10111011 : data_1_01 <= win21_27;
      8'b10111010 : data_1_01 <= win22_27;
      8'b10111001 : data_1_01 <= win23_27;
      8'b10111000 : data_1_01 <= win24_27;
      8'b10110111 : data_1_01 <= win25_27;
      8'b10110110 : data_1_01 <= win26_27;
      8'b10110101 : data_1_01 <= win27_27;
      8'b10110100 : data_1_01 <= win28_27;
      8'b10110011 : data_1_01 <= win29_27;
      8'b10110010 : data_1_01 <= win30_27;
      8'b10110001 : data_1_01 <= win31_27;
      8'b10110000 : data_1_01 <= win31_27;
      8'b10101111 : data_1_01 <= win17_26;
      8'b10101110 : data_1_01 <= win18_26;
      8'b10101101 : data_1_01 <= win19_26;
      8'b10101100 : data_1_01 <= win20_26;
      8'b10101011 : data_1_01 <= win21_26;
      8'b10101010 : data_1_01 <= win22_26;
      8'b10101001 : data_1_01 <= win23_26;
      8'b10101000 : data_1_01 <= win24_26;
      8'b10100111 : data_1_01 <= win25_26;
      8'b10100110 : data_1_01 <= win26_26;
      8'b10100101 : data_1_01 <= win27_26;
      8'b10100100 : data_1_01 <= win28_26;
      8'b10100011 : data_1_01 <= win29_26;
      8'b10100010 : data_1_01 <= win30_26;
      8'b10100001 : data_1_01 <= win31_26;
      8'b10100000 : data_1_01 <= win31_26;
      8'b10011111 : data_1_01 <= win17_25;
      8'b10011110 : data_1_01 <= win18_25;
      8'b10011101 : data_1_01 <= win19_25;
      8'b10011100 : data_1_01 <= win20_25;
      8'b10011011 : data_1_01 <= win21_25;
      8'b10011010 : data_1_01 <= win22_25;
      8'b10011001 : data_1_01 <= win23_25;
      8'b10011000 : data_1_01 <= win24_25;
      8'b10010111 : data_1_01 <= win25_25;
      8'b10010110 : data_1_01 <= win26_25;
      8'b10010101 : data_1_01 <= win27_25;
      8'b10010100 : data_1_01 <= win28_25;
      8'b10010011 : data_1_01 <= win29_25;
      8'b10010010 : data_1_01 <= win30_25;
      8'b10010001 : data_1_01 <= win31_25;
      8'b10010000 : data_1_01 <= win31_25;
      8'b10001111 : data_1_01 <= win17_24;
      8'b10001110 : data_1_01 <= win18_24;
      8'b10001101 : data_1_01 <= win19_24;
      8'b10001100 : data_1_01 <= win20_24;
      8'b10001011 : data_1_01 <= win21_24;
      8'b10001010 : data_1_01 <= win22_24;
      8'b10001001 : data_1_01 <= win23_24;
      8'b10001000 : data_1_01 <= win24_24;
      8'b10000111 : data_1_01 <= win25_24;
      8'b10000110 : data_1_01 <= win26_24;
      8'b10000101 : data_1_01 <= win27_24;
      8'b10000100 : data_1_01 <= win28_24;
      8'b10000011 : data_1_01 <= win29_24;
      8'b10000010 : data_1_01 <= win30_24;
      8'b10000001 : data_1_01 <= win31_24;
      8'b10000000 : data_1_01 <= win31_24;
      8'b01111111 : data_1_01 <= win17_23;
      8'b01111110 : data_1_01 <= win18_23;
      8'b01111101 : data_1_01 <= win19_23;
      8'b01111100 : data_1_01 <= win20_23;
      8'b01111011 : data_1_01 <= win21_23;
      8'b01111010 : data_1_01 <= win22_23;
      8'b01111001 : data_1_01 <= win23_23;
      8'b01111000 : data_1_01 <= win24_23;
      8'b01110111 : data_1_01 <= win25_23;
      8'b01110110 : data_1_01 <= win26_23;
      8'b01110101 : data_1_01 <= win27_23;
      8'b01110100 : data_1_01 <= win28_23;
      8'b01110011 : data_1_01 <= win29_23;
      8'b01110010 : data_1_01 <= win30_23;
      8'b01110001 : data_1_01 <= win31_23;
      8'b01110000 : data_1_01 <= win31_23;
      8'b01101111 : data_1_01 <= win17_22;
      8'b01101110 : data_1_01 <= win18_22;
      8'b01101101 : data_1_01 <= win19_22;
      8'b01101100 : data_1_01 <= win20_22;
      8'b01101011 : data_1_01 <= win21_22;
      8'b01101010 : data_1_01 <= win22_22;
      8'b01101001 : data_1_01 <= win23_22;
      8'b01101000 : data_1_01 <= win24_22;
      8'b01100111 : data_1_01 <= win25_22;
      8'b01100110 : data_1_01 <= win26_22;
      8'b01100101 : data_1_01 <= win27_22;
      8'b01100100 : data_1_01 <= win28_22;
      8'b01100011 : data_1_01 <= win29_22;
      8'b01100010 : data_1_01 <= win30_22;
      8'b01100001 : data_1_01 <= win31_22;
      8'b01100000 : data_1_01 <= win31_22;
      8'b01011111 : data_1_01 <= win17_21;
      8'b01011110 : data_1_01 <= win18_21;
      8'b01011101 : data_1_01 <= win19_21;
      8'b01011100 : data_1_01 <= win20_21;
      8'b01011011 : data_1_01 <= win21_21;
      8'b01011010 : data_1_01 <= win22_21;
      8'b01011001 : data_1_01 <= win23_21;
      8'b01011000 : data_1_01 <= win24_21;
      8'b01010111 : data_1_01 <= win25_21;
      8'b01010110 : data_1_01 <= win26_21;
      8'b01010101 : data_1_01 <= win27_21;
      8'b01010100 : data_1_01 <= win28_21;
      8'b01010011 : data_1_01 <= win29_21;
      8'b01010010 : data_1_01 <= win30_21;
      8'b01010001 : data_1_01 <= win31_21;
      8'b01010000 : data_1_01 <= win31_21;
      8'b01001111 : data_1_01 <= win17_20;
      8'b01001110 : data_1_01 <= win18_20;
      8'b01001101 : data_1_01 <= win19_20;
      8'b01001100 : data_1_01 <= win20_20;
      8'b01001011 : data_1_01 <= win21_20;
      8'b01001010 : data_1_01 <= win22_20;
      8'b01001001 : data_1_01 <= win23_20;
      8'b01001000 : data_1_01 <= win24_20;
      8'b01000111 : data_1_01 <= win25_20;
      8'b01000110 : data_1_01 <= win26_20;
      8'b01000101 : data_1_01 <= win27_20;
      8'b01000100 : data_1_01 <= win28_20;
      8'b01000011 : data_1_01 <= win29_20;
      8'b01000010 : data_1_01 <= win30_20;
      8'b01000001 : data_1_01 <= win31_20;
      8'b01000000 : data_1_01 <= win31_20;
      8'b00111111 : data_1_01 <= win17_19;
      8'b00111110 : data_1_01 <= win18_19;
      8'b00111101 : data_1_01 <= win19_19;
      8'b00111100 : data_1_01 <= win20_19;
      8'b00111011 : data_1_01 <= win21_19;
      8'b00111010 : data_1_01 <= win22_19;
      8'b00111001 : data_1_01 <= win23_19;
      8'b00111000 : data_1_01 <= win24_19;
      8'b00110111 : data_1_01 <= win25_19;
      8'b00110110 : data_1_01 <= win26_19;
      8'b00110101 : data_1_01 <= win27_19;
      8'b00110100 : data_1_01 <= win28_19;
      8'b00110011 : data_1_01 <= win29_19;
      8'b00110010 : data_1_01 <= win30_19;
      8'b00110001 : data_1_01 <= win31_19;
      8'b00110000 : data_1_01 <= win31_19;
      8'b00101111 : data_1_01 <= win17_18;
      8'b00101110 : data_1_01 <= win18_18;
      8'b00101101 : data_1_01 <= win19_18;
      8'b00101100 : data_1_01 <= win20_18;
      8'b00101011 : data_1_01 <= win21_18;
      8'b00101010 : data_1_01 <= win22_18;
      8'b00101001 : data_1_01 <= win23_18;
      8'b00101000 : data_1_01 <= win24_18;
      8'b00100111 : data_1_01 <= win25_18;
      8'b00100110 : data_1_01 <= win26_18;
      8'b00100101 : data_1_01 <= win27_18;
      8'b00100100 : data_1_01 <= win28_18;
      8'b00100011 : data_1_01 <= win29_18;
      8'b00100010 : data_1_01 <= win30_18;
      8'b00100001 : data_1_01 <= win31_18;
      8'b00100000 : data_1_01 <= win31_18;
      8'b00011111 : data_1_01 <= win17_17;
      8'b00011110 : data_1_01 <= win18_17;
      8'b00011101 : data_1_01 <= win19_17;
      8'b00011100 : data_1_01 <= win20_17;
      8'b00011011 : data_1_01 <= win21_17;
      8'b00011010 : data_1_01 <= win22_17;
      8'b00011001 : data_1_01 <= win23_17;
      8'b00011000 : data_1_01 <= win24_17;
      8'b00010111 : data_1_01 <= win25_17;
      8'b00010110 : data_1_01 <= win26_17;
      8'b00010101 : data_1_01 <= win27_17;
      8'b00010100 : data_1_01 <= win28_17;
      8'b00010011 : data_1_01 <= win29_17;
      8'b00010010 : data_1_01 <= win30_17;
      8'b00010001 : data_1_01 <= win31_17;
      8'b00010000 : data_1_01 <= win31_17;
      8'b00001111 : data_1_01 <= win17_16;
      8'b00001110 : data_1_01 <= win18_16;
      8'b00001101 : data_1_01 <= win19_16;
      8'b00001100 : data_1_01 <= win20_16;
      8'b00001011 : data_1_01 <= win21_16;
      8'b00001010 : data_1_01 <= win22_16;
      8'b00001001 : data_1_01 <= win23_16;
      8'b00001000 : data_1_01 <= win24_16;
      8'b00000111 : data_1_01 <= win25_16;
      8'b00000110 : data_1_01 <= win26_16;
      8'b00000101 : data_1_01 <= win27_16;
      8'b00000100 : data_1_01 <= win28_16;
      8'b00000011 : data_1_01 <= win29_16;
      8'b00000010 : data_1_01 <= win30_16;
      8'b00000001 : data_1_01 <= win31_16;
      8'b00000000 : data_1_01 <= win31_16;
      endcase
    end
end

always@(posedge clk or negedge rst_n)
begin      
  if(!rst_n)      
    data_1_10 <= 8'd0;      
  else      
    begin      
      case({X1[3:0],Y1[3:0]}) 
      8'b11111111 : data_1_10 <= win1_15;   
      8'b11111110 : data_1_10 <= win2_15;
      8'b11111101 : data_1_10 <= win3_15;
      8'b11111100 : data_1_10 <= win4_15;
      8'b11111011 : data_1_10 <= win5_15;
      8'b11111010 : data_1_10 <= win6_15; 
      8'b11111001 : data_1_10 <= win7_15;
      8'b11111000 : data_1_10 <= win8_15;
      8'b11110111 : data_1_10 <= win9_15;
      8'b11110110 : data_1_10 <= win10_15;
      8'b11110101 : data_1_10 <= win11_15;
      8'b11110100 : data_1_10 <= win12_15;
      8'b11110011 : data_1_10 <= win13_15;
      8'b11110010 : data_1_10 <= win14_15;
      8'b11110001 : data_1_10 <= win15_15;
      8'b11110000 : data_1_10 <= win16_15;
      8'b11101111 : data_1_10 <= win1_14;   
      8'b11101110 : data_1_10 <= win2_14;
      8'b11101101 : data_1_10 <= win3_14;
      8'b11101100 : data_1_10 <= win4_14;
      8'b11101011 : data_1_10 <= win5_14;
      8'b11101010 : data_1_10 <= win6_14; 
      8'b11101001 : data_1_10 <= win7_14;
      8'b11101000 : data_1_10 <= win8_14;
      8'b11100111 : data_1_10 <= win9_14;
      8'b11100110 : data_1_10 <= win10_14;
      8'b11100101 : data_1_10 <= win11_14;
      8'b11100100 : data_1_10 <= win12_14;
      8'b11100011 : data_1_10 <= win13_14;
      8'b11100010 : data_1_10 <= win14_14;
      8'b11100001 : data_1_10 <= win15_14;
      8'b11100000 : data_1_10 <= win16_14;
      8'b11011111 : data_1_10 <= win1_13; 
      8'b11011110 : data_1_10 <= win2_13;
      8'b11011101 : data_1_10 <= win3_13;
      8'b11011100 : data_1_10 <= win4_13;
      8'b11011011 : data_1_10 <= win5_13;
      8'b11011010 : data_1_10 <= win6_13; 
      8'b11011001 : data_1_10 <= win7_13;
      8'b11011000 : data_1_10 <= win8_13;
      8'b11010111 : data_1_10 <= win9_13;
      8'b11010110 : data_1_10 <= win10_13;
      8'b11010101 : data_1_10 <= win11_13;
      8'b11010100 : data_1_10 <= win12_13;
      8'b11010011 : data_1_10 <= win13_13;
      8'b11010010 : data_1_10 <= win14_13;
      8'b11010001 : data_1_10 <= win15_13;
      8'b11010000 : data_1_10 <= win16_13;
      8'b11001111 : data_1_10 <= win1_12; 
      8'b11001110 : data_1_10 <= win2_12;
      8'b11001101 : data_1_10 <= win3_12;
      8'b11001100 : data_1_10 <= win4_12;
      8'b11001011 : data_1_10 <= win5_12;
      8'b11001010 : data_1_10 <= win6_12; 
      8'b11001001 : data_1_10 <= win7_12;
      8'b11001000 : data_1_10 <= win8_12;
      8'b11000111 : data_1_10 <= win9_12;
      8'b11000110 : data_1_10 <= win10_12;
      8'b11000101 : data_1_10 <= win11_12;
      8'b11000100 : data_1_10 <= win12_12;
      8'b11000011 : data_1_10 <= win13_12;
      8'b11000010 : data_1_10 <= win14_12;
      8'b11000001 : data_1_10 <= win15_12;
      8'b11000000 : data_1_10 <= win16_12;
      8'b10111111 : data_1_10 <= win1_11; 
      8'b10111110 : data_1_10 <= win2_11;
      8'b10111101 : data_1_10 <= win3_11;
      8'b10111100 : data_1_10 <= win4_11;
      8'b10111011 : data_1_10 <= win5_11;
      8'b10111010 : data_1_10 <= win6_11; 
      8'b10111001 : data_1_10 <= win7_11;
      8'b10111000 : data_1_10 <= win8_11;
      8'b10110111 : data_1_10 <= win9_11;
      8'b10110110 : data_1_10 <= win10_11;
      8'b10110101 : data_1_10 <= win11_11;
      8'b10110100 : data_1_10 <= win12_11;
      8'b10110011 : data_1_10 <= win13_11;
      8'b10110010 : data_1_10 <= win14_11;
      8'b10110001 : data_1_10 <= win15_11;
      8'b10110000 : data_1_10 <= win16_11;
      8'b10101111 : data_1_10 <= win1_10; 
      8'b10101110 : data_1_10 <= win2_10;
      8'b10101101 : data_1_10 <= win3_10;
      8'b10101100 : data_1_10 <= win4_10;
      8'b10101011 : data_1_10 <= win5_10;
      8'b10101010 : data_1_10 <= win6_10; 
      8'b10101001 : data_1_10 <= win7_10;
      8'b10101000 : data_1_10 <= win8_10;
      8'b10100111 : data_1_10 <= win9_10;
      8'b10100110 : data_1_10 <= win10_10;
      8'b10100101 : data_1_10 <= win11_10;
      8'b10100100 : data_1_10 <= win12_10;
      8'b10100011 : data_1_10 <= win13_10;
      8'b10100010 : data_1_10 <= win14_10;
      8'b10100001 : data_1_10 <= win15_10;
      8'b10100000 : data_1_10 <= win16_10;
      8'b10011111 : data_1_10 <= win1_9; 
      8'b10011110 : data_1_10 <= win2_9;
      8'b10011101 : data_1_10 <= win3_9;
      8'b10011100 : data_1_10 <= win4_9;
      8'b10011011 : data_1_10 <= win5_9;
      8'b10011010 : data_1_10 <= win6_9; 
      8'b10011001 : data_1_10 <= win7_9;
      8'b10011000 : data_1_10 <= win8_9;
      8'b10010111 : data_1_10 <= win9_9;
      8'b10010110 : data_1_10 <= win10_9;
      8'b10010101 : data_1_10 <= win11_9;
      8'b10010100 : data_1_10 <= win12_9;
      8'b10010011 : data_1_10 <= win13_9;
      8'b10010010 : data_1_10 <= win14_9;
      8'b10010001 : data_1_10 <= win15_9;
      8'b10010000 : data_1_10 <= win16_9;
      8'b10001111 : data_1_10 <= win1_8; 
      8'b10001110 : data_1_10 <= win2_8;
      8'b10001101 : data_1_10 <= win3_8;
      8'b10001100 : data_1_10 <= win4_8;
      8'b10001011 : data_1_10 <= win5_8;
      8'b10001010 : data_1_10 <= win6_8; 
      8'b10001001 : data_1_10 <= win7_8;
      8'b10001000 : data_1_10 <= win8_8;
      8'b10000111 : data_1_10 <= win9_8;
      8'b10000110 : data_1_10 <= win10_8;
      8'b10000101 : data_1_10 <= win11_8;
      8'b10000100 : data_1_10 <= win12_8;
      8'b10000011 : data_1_10 <= win13_8;
      8'b10000010 : data_1_10 <= win14_8;
      8'b10000001 : data_1_10 <= win15_8;
      8'b10000000 : data_1_10 <= win16_8;
      8'b01111111 : data_1_10 <= win1_7; 
      8'b01111110 : data_1_10 <= win2_7;
      8'b01111101 : data_1_10 <= win3_7;
      8'b01111100 : data_1_10 <= win4_7;
      8'b01111011 : data_1_10 <= win5_7;
      8'b01111010 : data_1_10 <= win6_7; 
      8'b01111001 : data_1_10 <= win7_7;
      8'b01111000 : data_1_10 <= win8_7;
      8'b01110111 : data_1_10 <= win9_7;
      8'b01110110 : data_1_10 <= win10_7;
      8'b01110101 : data_1_10 <= win11_7;
      8'b01110100 : data_1_10 <= win12_7;
      8'b01110011 : data_1_10 <= win13_7;
      8'b01110010 : data_1_10 <= win14_7;
      8'b01110001 : data_1_10 <= win15_7;
      8'b01110000 : data_1_10 <= win16_7;
      8'b01101111 : data_1_10 <= win1_6; 
      8'b01101110 : data_1_10 <= win2_6;
      8'b01101101 : data_1_10 <= win3_6;
      8'b01101100 : data_1_10 <= win4_6;
      8'b01101011 : data_1_10 <= win5_6;
      8'b01101010 : data_1_10 <= win6_6; 
      8'b01101001 : data_1_10 <= win7_6;
      8'b01101000 : data_1_10 <= win8_6;
      8'b01100111 : data_1_10 <= win9_6;
      8'b01100110 : data_1_10 <= win10_6;
      8'b01100101 : data_1_10 <= win11_6;
      8'b01100100 : data_1_10 <= win12_6;
      8'b01100011 : data_1_10 <= win13_6;
      8'b01100010 : data_1_10 <= win14_6;
      8'b01100001 : data_1_10 <= win15_6;
      8'b01100000 : data_1_10 <= win16_6;
      8'b01011111 : data_1_10 <= win1_5; 
      8'b01011110 : data_1_10 <= win2_5;
      8'b01011101 : data_1_10 <= win3_5;
      8'b01011100 : data_1_10 <= win4_5;
      8'b01011011 : data_1_10 <= win5_5;
      8'b01011010 : data_1_10 <= win6_5; 
      8'b01011001 : data_1_10 <= win7_5;
      8'b01011000 : data_1_10 <= win8_5;
      8'b01010111 : data_1_10 <= win9_5;
      8'b01010110 : data_1_10 <= win10_5;
      8'b01010101 : data_1_10 <= win11_5;
      8'b01010100 : data_1_10 <= win12_5;
      8'b01010011 : data_1_10 <= win13_5;
      8'b01010010 : data_1_10 <= win14_5;
      8'b01010001 : data_1_10 <= win15_5;
      8'b01010000 : data_1_10 <= win16_5;
      8'b01001111 : data_1_10 <= win1_4; 
      8'b01001110 : data_1_10 <= win2_4;
      8'b01001101 : data_1_10 <= win3_4;
      8'b01001100 : data_1_10 <= win4_4;
      8'b01001011 : data_1_10 <= win5_4;
      8'b01001010 : data_1_10 <= win6_4; 
      8'b01001001 : data_1_10 <= win7_4;
      8'b01001000 : data_1_10 <= win8_4;
      8'b01000111 : data_1_10 <= win9_4;
      8'b01000110 : data_1_10 <= win10_4;
      8'b01000101 : data_1_10 <= win11_4;
      8'b01000100 : data_1_10 <= win12_4;
      8'b01000011 : data_1_10 <= win13_4;
      8'b01000010 : data_1_10 <= win14_4;
      8'b01000001 : data_1_10 <= win15_4;
      8'b01000000 : data_1_10 <= win16_4;
      8'b00111111 : data_1_10 <= win1_3; 
      8'b00111110 : data_1_10 <= win2_3;
      8'b00111101 : data_1_10 <= win3_3;
      8'b00111100 : data_1_10 <= win4_3;
      8'b00111011 : data_1_10 <= win5_3;
      8'b00111010 : data_1_10 <= win6_3; 
      8'b00111001 : data_1_10 <= win7_3;
      8'b00111000 : data_1_10 <= win8_3;
      8'b00110111 : data_1_10 <= win9_3;
      8'b00110110 : data_1_10 <= win10_3;
      8'b00110101 : data_1_10 <= win11_3;
      8'b00110100 : data_1_10 <= win12_3;
      8'b00110011 : data_1_10 <= win13_3;
      8'b00110010 : data_1_10 <= win14_3;
      8'b00110001 : data_1_10 <= win15_3;
      8'b00110000 : data_1_10 <= win16_3;
      8'b00101111 : data_1_10 <= win1_2; 
      8'b00101110 : data_1_10 <= win2_2;
      8'b00101101 : data_1_10 <= win3_2;
      8'b00101100 : data_1_10 <= win4_2;
      8'b00101011 : data_1_10 <= win5_2;
      8'b00101010 : data_1_10 <= win6_2; 
      8'b00101001 : data_1_10 <= win7_2;
      8'b00101000 : data_1_10 <= win8_2;
      8'b00100111 : data_1_10 <= win9_2;
      8'b00100110 : data_1_10 <= win10_2;
      8'b00100101 : data_1_10 <= win11_2;
      8'b00100100 : data_1_10 <= win12_2;
      8'b00100011 : data_1_10 <= win13_2;
      8'b00100010 : data_1_10 <= win14_2;
      8'b00100001 : data_1_10 <= win15_2;
      8'b00100000 : data_1_10 <= win16_2;
      8'b00011111 : data_1_10 <= win1_1; 
      8'b00011110 : data_1_10 <= win2_1;
      8'b00011101 : data_1_10 <= win3_1;
      8'b00011100 : data_1_10 <= win4_1;
      8'b00011011 : data_1_10 <= win5_1;
      8'b00011010 : data_1_10 <= win6_1; 
      8'b00011001 : data_1_10 <= win7_1;
      8'b00011000 : data_1_10 <= win8_1;
      8'b00010111 : data_1_10 <= win9_1;
      8'b00010110 : data_1_10 <= win10_1;
      8'b00010101 : data_1_10 <= win11_1;
      8'b00010100 : data_1_10 <= win12_1;
      8'b00010011 : data_1_10 <= win13_1;
      8'b00010010 : data_1_10 <= win14_1;
      8'b00010001 : data_1_10 <= win15_1;
      8'b00010000 : data_1_10 <= win16_1;
      8'b00001111 : data_1_10 <= win1_1; 
      8'b00001110 : data_1_10 <= win2_1;
      8'b00001101 : data_1_10 <= win3_1;
      8'b00001100 : data_1_10 <= win4_1;
      8'b00001011 : data_1_10 <= win5_1;
      8'b00001010 : data_1_10 <= win6_1; 
      8'b00001001 : data_1_10 <= win7_1;
      8'b00001000 : data_1_10 <= win8_1;
      8'b00000111 : data_1_10 <= win9_1;
      8'b00000110 : data_1_10 <= win10_1;
      8'b00000101 : data_1_10 <= win11_1;
      8'b00000100 : data_1_10 <= win12_1;
      8'b00000011 : data_1_10 <= win13_1;
      8'b00000010 : data_1_10 <= win14_1;
      8'b00000001 : data_1_10 <= win15_1;
      8'b00000000 : data_1_10 <= win16_1;
      endcase
    end
end

always@(posedge clk or negedge rst_n)
begin      
  if(!rst_n)      
    data_1_11 <= 8'd0;      
  else      
    begin      
      case({X1[3:0],Y1[3:0]})
      8'b11111111 : data_1_11 <= win17_15;
      8'b11111110 : data_1_11 <= win18_15;     
      8'b11111101 : data_1_11 <= win19_15;
      8'b11111100 : data_1_11 <= win20_15;
      8'b11111011 : data_1_11 <= win21_15;
      8'b11111010 : data_1_11 <= win22_15;
      8'b11111001 : data_1_11 <= win23_15;
      8'b11111000 : data_1_11 <= win24_15;
      8'b11110111 : data_1_11 <= win25_15;
      8'b11110110 : data_1_11 <= win26_15;
      8'b11110101 : data_1_11 <= win27_15;
      8'b11110100 : data_1_11 <= win28_15;
      8'b11110011 : data_1_11 <= win29_15;
      8'b11110010 : data_1_11 <= win30_15;
      8'b11110001 : data_1_11 <= win31_15;
      8'b11110000 : data_1_11 <= win31_15;
      8'b11101111 : data_1_11 <= win17_14;
      8'b11101110 : data_1_11 <= win18_14;     
      8'b11101101 : data_1_11 <= win19_14;
      8'b11101100 : data_1_11 <= win20_14;
      8'b11101011 : data_1_11 <= win21_14;
      8'b11101010 : data_1_11 <= win22_14;
      8'b11101001 : data_1_11 <= win23_14;
      8'b11101000 : data_1_11 <= win24_14;
      8'b11100111 : data_1_11 <= win25_14;
      8'b11100110 : data_1_11 <= win26_14;
      8'b11100101 : data_1_11 <= win27_14;
      8'b11100100 : data_1_11 <= win28_14;
      8'b11100011 : data_1_11 <= win29_14;
      8'b11100010 : data_1_11 <= win30_14;
      8'b11100001 : data_1_11 <= win31_14;
      8'b11100000 : data_1_11 <= win31_14;
      8'b11011111 : data_1_11 <= win17_13;
      8'b11011110 : data_1_11 <= win18_13;     
      8'b11011101 : data_1_11 <= win19_13;
      8'b11011100 : data_1_11 <= win20_13;
      8'b11011011 : data_1_11 <= win21_13;
      8'b11011010 : data_1_11 <= win22_13;
      8'b11011001 : data_1_11 <= win23_13;
      8'b11011000 : data_1_11 <= win24_13;
      8'b11010111 : data_1_11 <= win25_13;
      8'b11010110 : data_1_11 <= win26_13;
      8'b11010101 : data_1_11 <= win27_13;
      8'b11010100 : data_1_11 <= win28_13;
      8'b11010011 : data_1_11 <= win29_13;
      8'b11010010 : data_1_11 <= win30_13;
      8'b11010001 : data_1_11 <= win31_13;
      8'b11010000 : data_1_11 <= win31_13;
      8'b11001111 : data_1_11 <= win17_12;
      8'b11001110 : data_1_11 <= win18_12; 
      8'b11001101 : data_1_11 <= win19_12;
      8'b11001100 : data_1_11 <= win20_12;
      8'b11001011 : data_1_11 <= win21_12;
      8'b11001010 : data_1_11 <= win22_12;
      8'b11001001 : data_1_11 <= win23_12;
      8'b11001000 : data_1_11 <= win24_12;
      8'b11000111 : data_1_11 <= win25_12;
      8'b11000110 : data_1_11 <= win26_12;
      8'b11000101 : data_1_11 <= win27_12;
      8'b11000100 : data_1_11 <= win28_12;
      8'b11000011 : data_1_11 <= win29_12;
      8'b11000010 : data_1_11 <= win30_12;
      8'b11000001 : data_1_11 <= win31_12;
      8'b11000000 : data_1_11 <= win31_12;
      8'b10111111 : data_1_11 <= win17_11;
      8'b10111110 : data_1_11 <= win18_11; 
      8'b10111101 : data_1_11 <= win19_11;
      8'b10111100 : data_1_11 <= win20_11;
      8'b10111011 : data_1_11 <= win21_11;
      8'b10111010 : data_1_11 <= win22_11;
      8'b10111001 : data_1_11 <= win23_11;
      8'b10111000 : data_1_11 <= win24_11;
      8'b10110111 : data_1_11 <= win25_11;
      8'b10110110 : data_1_11 <= win26_11;
      8'b10110101 : data_1_11 <= win27_11;
      8'b10110100 : data_1_11 <= win28_11;
      8'b10110011 : data_1_11 <= win29_11;
      8'b10110010 : data_1_11 <= win30_11;
      8'b10110001 : data_1_11 <= win31_11;
      8'b10110000 : data_1_11 <= win31_11;
      8'b10101111 : data_1_11 <= win17_10;
      8'b10101110 : data_1_11 <= win18_10; 
      8'b10101101 : data_1_11 <= win19_10;
      8'b10101100 : data_1_11 <= win20_10;
      8'b10101011 : data_1_11 <= win21_10;
      8'b10101010 : data_1_11 <= win22_10;
      8'b10101001 : data_1_11 <= win23_10;
      8'b10101000 : data_1_11 <= win24_10;
      8'b10100111 : data_1_11 <= win25_10;
      8'b10100110 : data_1_11 <= win26_10;
      8'b10100101 : data_1_11 <= win27_10;
      8'b10100100 : data_1_11 <= win28_10;
      8'b10100011 : data_1_11 <= win29_10;
      8'b10100010 : data_1_11 <= win30_10;
      8'b10100001 : data_1_11 <= win31_10;
      8'b10100000 : data_1_11 <= win31_10;
      8'b10011111 : data_1_11 <= win17_9;
      8'b10011110 : data_1_11 <= win18_9; 
      8'b10011101 : data_1_11 <= win19_9;
      8'b10011100 : data_1_11 <= win20_9;
      8'b10011011 : data_1_11 <= win21_9;
      8'b10011010 : data_1_11 <= win22_9;
      8'b10011001 : data_1_11 <= win23_9;
      8'b10011000 : data_1_11 <= win24_9;
      8'b10010111 : data_1_11 <= win25_9;
      8'b10010110 : data_1_11 <= win26_9;
      8'b10010101 : data_1_11 <= win27_9;
      8'b10010100 : data_1_11 <= win28_9;
      8'b10010011 : data_1_11 <= win29_9;
      8'b10010010 : data_1_11 <= win30_9;
      8'b10010001 : data_1_11 <= win31_9;
      8'b10010000 : data_1_11 <= win31_9;
      8'b10001111 : data_1_11 <= win17_8;
      8'b10001110 : data_1_11 <= win18_8;
      8'b10001101 : data_1_11 <= win19_8;
      8'b10001100 : data_1_11 <= win20_8;
      8'b10001011 : data_1_11 <= win21_8;
      8'b10001010 : data_1_11 <= win22_8;
      8'b10001001 : data_1_11 <= win23_8;
      8'b10001000 : data_1_11 <= win24_8;
      8'b10000111 : data_1_11 <= win25_8;
      8'b10000110 : data_1_11 <= win26_8;
      8'b10000101 : data_1_11 <= win27_8;
      8'b10000100 : data_1_11 <= win28_8;
      8'b10000011 : data_1_11 <= win29_8;
      8'b10000010 : data_1_11 <= win30_8;
      8'b10000001 : data_1_11 <= win31_8;
      8'b10000000 : data_1_11 <= win31_8;
      8'b01111111 : data_1_11 <= win17_7;
      8'b01111110 : data_1_11 <= win18_7;
      8'b01111101 : data_1_11 <= win19_7;
      8'b01111100 : data_1_11 <= win20_7;
      8'b01111011 : data_1_11 <= win21_7;
      8'b01111010 : data_1_11 <= win22_7;
      8'b01111001 : data_1_11 <= win23_7;
      8'b01111000 : data_1_11 <= win24_7;
      8'b01110111 : data_1_11 <= win25_7;
      8'b01110110 : data_1_11 <= win26_7;
      8'b01110101 : data_1_11 <= win27_7;
      8'b01110100 : data_1_11 <= win28_7;
      8'b01110011 : data_1_11 <= win29_7;
      8'b01110010 : data_1_11 <= win30_7;
      8'b01110001 : data_1_11 <= win31_7;
      8'b01110000 : data_1_11 <= win31_7;
      8'b01101111 : data_1_11 <= win17_6;
      8'b01101110 : data_1_11 <= win18_6;
      8'b01101101 : data_1_11 <= win19_6;
      8'b01101100 : data_1_11 <= win20_6;
      8'b01101011 : data_1_11 <= win21_6;
      8'b01101010 : data_1_11 <= win22_6;
      8'b01101001 : data_1_11 <= win23_6;
      8'b01101000 : data_1_11 <= win24_6;
      8'b01100111 : data_1_11 <= win25_6;
      8'b01100110 : data_1_11 <= win26_6;
      8'b01100101 : data_1_11 <= win27_6;
      8'b01100100 : data_1_11 <= win28_6;
      8'b01100011 : data_1_11 <= win29_6;
      8'b01100010 : data_1_11 <= win30_6;
      8'b01100001 : data_1_11 <= win31_6;
      8'b01100000 : data_1_11 <= win31_6;
      8'b01011111 : data_1_11 <= win17_5;
      8'b01011110 : data_1_11 <= win18_5;
      8'b01011101 : data_1_11 <= win19_5;
      8'b01011100 : data_1_11 <= win20_5;
      8'b01011011 : data_1_11 <= win21_5;
      8'b01011010 : data_1_11 <= win22_5;
      8'b01011001 : data_1_11 <= win23_5;
      8'b01011000 : data_1_11 <= win24_5;
      8'b01010111 : data_1_11 <= win25_5;
      8'b01010110 : data_1_11 <= win26_5;
      8'b01010101 : data_1_11 <= win27_5;
      8'b01010100 : data_1_11 <= win28_5;
      8'b01010011 : data_1_11 <= win29_5;
      8'b01010010 : data_1_11 <= win30_5;
      8'b01010001 : data_1_11 <= win31_5;
      8'b01010000 : data_1_11 <= win31_5;
      8'b01001111 : data_1_11 <= win17_4;
      8'b01001110 : data_1_11 <= win18_4;
      8'b01001101 : data_1_11 <= win19_4;
      8'b01001100 : data_1_11 <= win20_4;
      8'b01001011 : data_1_11 <= win21_4;
      8'b01001010 : data_1_11 <= win22_4;
      8'b01001001 : data_1_11 <= win23_4;
      8'b01001000 : data_1_11 <= win24_4;
      8'b01000111 : data_1_11 <= win25_4;
      8'b01000110 : data_1_11 <= win26_4;
      8'b01000101 : data_1_11 <= win27_4;
      8'b01000100 : data_1_11 <= win28_4;
      8'b01000011 : data_1_11 <= win29_4;
      8'b01000010 : data_1_11 <= win30_4;
      8'b01000001 : data_1_11 <= win31_4;
      8'b01000000 : data_1_11 <= win31_4;
      8'b00111111 : data_1_11 <= win17_3;
      8'b00111110 : data_1_11 <= win18_3;
      8'b00111101 : data_1_11 <= win19_3;
      8'b00111100 : data_1_11 <= win20_3;
      8'b00111011 : data_1_11 <= win21_3;
      8'b00111010 : data_1_11 <= win22_3;
      8'b00111001 : data_1_11 <= win23_3;
      8'b00111000 : data_1_11 <= win24_3;
      8'b00110111 : data_1_11 <= win25_3;
      8'b00110110 : data_1_11 <= win26_3;
      8'b00110101 : data_1_11 <= win27_3;
      8'b00110100 : data_1_11 <= win28_3;
      8'b00110011 : data_1_11 <= win29_3;
      8'b00110010 : data_1_11 <= win30_3;
      8'b00110001 : data_1_11 <= win31_3;
      8'b00110000 : data_1_11 <= win31_3;
      8'b00101111 : data_1_11 <= win17_2;
      8'b00101110 : data_1_11 <= win18_2;
      8'b00101101 : data_1_11 <= win19_2;
      8'b00101100 : data_1_11 <= win20_2;
      8'b00101011 : data_1_11 <= win21_2;
      8'b00101010 : data_1_11 <= win22_2;
      8'b00101001 : data_1_11 <= win23_2;
      8'b00101000 : data_1_11 <= win24_2;
      8'b00100111 : data_1_11 <= win25_2;
      8'b00100110 : data_1_11 <= win26_2;
      8'b00100101 : data_1_11 <= win27_2;
      8'b00100100 : data_1_11 <= win28_2;
      8'b00100011 : data_1_11 <= win29_2;
      8'b00100010 : data_1_11 <= win30_2;
      8'b00100001 : data_1_11 <= win31_2;
      8'b00100000 : data_1_11 <= win31_2;
      8'b00011111 : data_1_11 <= win17_1;
      8'b00011110 : data_1_11 <= win18_1;
      8'b00011101 : data_1_11 <= win19_1;
      8'b00011100 : data_1_11 <= win20_1;
      8'b00011011 : data_1_11 <= win21_1;
      8'b00011010 : data_1_11 <= win22_1;
      8'b00011001 : data_1_11 <= win23_1;
      8'b00011000 : data_1_11 <= win24_1;
      8'b00010111 : data_1_11 <= win25_1;
      8'b00010110 : data_1_11 <= win26_1;
      8'b00010101 : data_1_11 <= win27_1;
      8'b00010100 : data_1_11 <= win28_1;
      8'b00010011 : data_1_11 <= win29_1;
      8'b00010010 : data_1_11 <= win30_1;
      8'b00010001 : data_1_11 <= win31_1;
      8'b00010000 : data_1_11 <= win31_1;
      8'b00001111 : data_1_11 <= win17_1;
      8'b00001110 : data_1_11 <= win18_1;
      8'b00001101 : data_1_11 <= win19_1;
      8'b00001100 : data_1_11 <= win20_1;
      8'b00001011 : data_1_11 <= win21_1;
      8'b00001010 : data_1_11 <= win22_1;
      8'b00001001 : data_1_11 <= win23_1;
      8'b00001000 : data_1_11 <= win24_1;
      8'b00000111 : data_1_11 <= win25_1;
      8'b00000110 : data_1_11 <= win26_1;
      8'b00000101 : data_1_11 <= win27_1;
      8'b00000100 : data_1_11 <= win28_1;
      8'b00000011 : data_1_11 <= win29_1;
      8'b00000010 : data_1_11 <= win30_1;
      8'b00000001 : data_1_11 <= win31_1;
      8'b00000000 : data_1_11 <= win31_1;
      endcase
    end
end
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    data_2_00 <= 8'd0;
  else
    begin
      case({X2[3:0],Y2[3:0]})
      8'b11111111 : data_2_00 <= win1_31;
      8'b11111110 : data_2_00 <= win2_31;
      8'b11111101 : data_2_00 <= win3_31;
      8'b11111100 : data_2_00 <= win4_31;
      8'b11111011 : data_2_00 <= win5_31;
      8'b11111010 : data_2_00 <= win6_31; 
      8'b11111001 : data_2_00 <= win7_31;
      8'b11111000 : data_2_00 <= win8_31;
      8'b11110111 : data_2_00 <= win9_31;
      8'b11110110 : data_2_00 <= win10_31;
      8'b11110101 : data_2_00 <= win11_31;
      8'b11110100 : data_2_00 <= win12_31;
      8'b11110011 : data_2_00 <= win13_31;
      8'b11110010 : data_2_00 <= win14_31;
      8'b11110001 : data_2_00 <= win15_31;
      8'b11110000 : data_2_00 <= win16_31;
      8'b11101111 : data_2_00 <= win1_30;
      8'b11101110 : data_2_00 <= win2_30;
      8'b11101101 : data_2_00 <= win3_30;
      8'b11101100 : data_2_00 <= win4_30;
      8'b11101011 : data_2_00 <= win5_30;
      8'b11101010 : data_2_00 <= win6_30; 
      8'b11101001 : data_2_00 <= win7_30;
      8'b11101000 : data_2_00 <= win8_30;
      8'b11100111 : data_2_00 <= win9_30;
      8'b11100110 : data_2_00 <= win10_30;
      8'b11100101 : data_2_00 <= win11_30;
      8'b11100100 : data_2_00 <= win12_30;
      8'b11100011 : data_2_00 <= win13_30;
      8'b11100010 : data_2_00 <= win14_30;
      8'b11100001 : data_2_00 <= win15_30;
      8'b11100000 : data_2_00 <= win16_30;
      8'b11011111 : data_2_00 <= win1_29;
      8'b11011110 : data_2_00 <= win2_29;
      8'b11011101 : data_2_00 <= win3_29;
      8'b11011100 : data_2_00 <= win4_29;
      8'b11011011 : data_2_00 <= win5_29;
      8'b11011010 : data_2_00 <= win6_29; 
      8'b11011001 : data_2_00 <= win7_29;
      8'b11011000 : data_2_00 <= win8_29;
      8'b11010111 : data_2_00 <= win9_29;
      8'b11010110 : data_2_00 <= win10_29;
      8'b11010101 : data_2_00 <= win11_29;
      8'b11010100 : data_2_00 <= win12_29;
      8'b11010011 : data_2_00 <= win13_29;
      8'b11010010 : data_2_00 <= win14_29;
      8'b11010001 : data_2_00 <= win15_29;
      8'b11010000 : data_2_00 <= win16_29;
      8'b11001111 : data_2_00 <= win1_28;
      8'b11001110 : data_2_00 <= win2_28;
      8'b11001101 : data_2_00 <= win3_28;
      8'b11001100 : data_2_00 <= win4_28;
      8'b11001011 : data_2_00 <= win5_28;
      8'b11001010 : data_2_00 <= win6_28; 
      8'b11001001 : data_2_00 <= win7_28;
      8'b11001000 : data_2_00 <= win8_28;
      8'b11000111 : data_2_00 <= win9_28;
      8'b11000110 : data_2_00 <= win10_28;
      8'b11000101 : data_2_00 <= win11_28;
      8'b11000100 : data_2_00 <= win12_28;
      8'b11000011 : data_2_00 <= win13_28;
      8'b11000010 : data_2_00 <= win14_28;
      8'b11000001 : data_2_00 <= win15_28;
      8'b11000000 : data_2_00 <= win16_28;
      8'b10111111 : data_2_00 <= win1_27;
      8'b10111110 : data_2_00 <= win2_27;
      8'b10111101 : data_2_00 <= win3_27;
      8'b10111100 : data_2_00 <= win4_27;
      8'b10111011 : data_2_00 <= win5_27;
      8'b10111010 : data_2_00 <= win6_27; 
      8'b10111001 : data_2_00 <= win7_27;
      8'b10111000 : data_2_00 <= win8_27;
      8'b10110111 : data_2_00 <= win9_27;
      8'b10110110 : data_2_00 <= win10_27;
      8'b10110101 : data_2_00 <= win11_27;
      8'b10110100 : data_2_00 <= win12_27;
      8'b10110011 : data_2_00 <= win13_27;
      8'b10110010 : data_2_00 <= win14_27;
      8'b10110001 : data_2_00 <= win15_27;
      8'b10110000 : data_2_00 <= win16_27;
      8'b10101111 : data_2_00 <= win1_26;
      8'b10101110 : data_2_00 <= win2_26;
      8'b10101101 : data_2_00 <= win3_26;
      8'b10101100 : data_2_00 <= win4_26;
      8'b10101011 : data_2_00 <= win5_26;
      8'b10101010 : data_2_00 <= win6_26; 
      8'b10101001 : data_2_00 <= win7_26;
      8'b10101000 : data_2_00 <= win8_26;
      8'b10100111 : data_2_00 <= win9_26;
      8'b10100110 : data_2_00 <= win10_26;
      8'b10100101 : data_2_00 <= win11_26;
      8'b10100100 : data_2_00 <= win12_26;
      8'b10100011 : data_2_00 <= win13_26;
      8'b10100010 : data_2_00 <= win14_26;
      8'b10100001 : data_2_00 <= win15_26;
      8'b10100000 : data_2_00 <= win16_26;
      8'b10011111 : data_2_00 <= win1_25;
      8'b10011110 : data_2_00 <= win2_25;
      8'b10011101 : data_2_00 <= win3_25;
      8'b10011100 : data_2_00 <= win4_25;
      8'b10011011 : data_2_00 <= win5_25;
      8'b10011010 : data_2_00 <= win6_25; 
      8'b10011001 : data_2_00 <= win7_25;
      8'b10011000 : data_2_00 <= win8_25;
      8'b10010111 : data_2_00 <= win9_25;
      8'b10010110 : data_2_00 <= win10_25;
      8'b10010101 : data_2_00 <= win11_25;
      8'b10010100 : data_2_00 <= win12_25;
      8'b10010011 : data_2_00 <= win13_25;
      8'b10010010 : data_2_00 <= win14_25;
      8'b10010001 : data_2_00 <= win15_25;
      8'b10010000 : data_2_00 <= win16_25;
      8'b10001111 : data_2_00 <= win1_24;
      8'b10001110 : data_2_00 <= win2_24;
      8'b10001101 : data_2_00 <= win3_24;
      8'b10001100 : data_2_00 <= win4_24;
      8'b10001011 : data_2_00 <= win5_24;
      8'b10001010 : data_2_00 <= win6_24; 
      8'b10001001 : data_2_00 <= win7_24;
      8'b10001000 : data_2_00 <= win8_24;
      8'b10000111 : data_2_00 <= win9_24;
      8'b10000110 : data_2_00 <= win10_24;
      8'b10000101 : data_2_00 <= win11_24;
      8'b10000100 : data_2_00 <= win12_24;
      8'b10000011 : data_2_00 <= win13_24;
      8'b10000010 : data_2_00 <= win14_24;
      8'b10000001 : data_2_00 <= win15_24;
      8'b10000000 : data_2_00 <= win16_24;
      8'b01111111 : data_2_00 <= win1_23;
      8'b01111110 : data_2_00 <= win2_23;
      8'b01111101 : data_2_00 <= win3_23;
      8'b01111100 : data_2_00 <= win4_23;
      8'b01111011 : data_2_00 <= win5_23;
      8'b01111010 : data_2_00 <= win6_23; 
      8'b01111001 : data_2_00 <= win7_23;
      8'b01111000 : data_2_00 <= win8_23;
      8'b01110111 : data_2_00 <= win9_23;
      8'b01110110 : data_2_00 <= win10_23;
      8'b01110101 : data_2_00 <= win11_23;
      8'b01110100 : data_2_00 <= win12_23;
      8'b01110011 : data_2_00 <= win13_23;
      8'b01110010 : data_2_00 <= win14_23;
      8'b01110001 : data_2_00 <= win15_23;
      8'b01110000 : data_2_00 <= win16_23;
      8'b01101111 : data_2_00 <= win1_22;
      8'b01101110 : data_2_00 <= win2_22;
      8'b01101101 : data_2_00 <= win3_22;
      8'b01101100 : data_2_00 <= win4_22;
      8'b01101011 : data_2_00 <= win5_22;
      8'b01101010 : data_2_00 <= win6_22; 
      8'b01101001 : data_2_00 <= win7_22;
      8'b01101000 : data_2_00 <= win8_22;
      8'b01100111 : data_2_00 <= win9_22;
      8'b01100110 : data_2_00 <= win10_22;
      8'b01100101 : data_2_00 <= win11_22;
      8'b01100100 : data_2_00 <= win12_22;
      8'b01100011 : data_2_00 <= win13_22;
      8'b01100010 : data_2_00 <= win14_22;
      8'b01100001 : data_2_00 <= win15_22;
      8'b01100000 : data_2_00 <= win16_22;
      8'b01011111 : data_2_00 <= win1_21;
      8'b01011110 : data_2_00 <= win2_21;
      8'b01011101 : data_2_00 <= win3_21;
      8'b01011100 : data_2_00 <= win4_21;
      8'b01011011 : data_2_00 <= win5_21;
      8'b01011010 : data_2_00 <= win6_21; 
      8'b01011001 : data_2_00 <= win7_21;
      8'b01011000 : data_2_00 <= win8_21;
      8'b01010111 : data_2_00 <= win9_21;
      8'b01010110 : data_2_00 <= win10_21;
      8'b01010101 : data_2_00 <= win11_21;
      8'b01010100 : data_2_00 <= win12_21;
      8'b01010011 : data_2_00 <= win13_21;
      8'b01010010 : data_2_00 <= win14_21;
      8'b01010001 : data_2_00 <= win15_21;
      8'b01010000 : data_2_00 <= win16_21;
      8'b01001111 : data_2_00 <= win1_20;
      8'b01001110 : data_2_00 <= win2_20;
      8'b01001101 : data_2_00 <= win3_20;
      8'b01001100 : data_2_00 <= win4_20;
      8'b01001011 : data_2_00 <= win5_20;
      8'b01001010 : data_2_00 <= win6_20; 
      8'b01001001 : data_2_00 <= win7_20;
      8'b01001000 : data_2_00 <= win8_20;
      8'b01000111 : data_2_00 <= win9_20;
      8'b01000110 : data_2_00 <= win10_20;
      8'b01000101 : data_2_00 <= win11_20;
      8'b01000100 : data_2_00 <= win12_20;
      8'b01000011 : data_2_00 <= win13_20;
      8'b01000010 : data_2_00 <= win14_20;
      8'b01000001 : data_2_00 <= win15_20;
      8'b01000000 : data_2_00 <= win16_20;
      8'b00111111 : data_2_00 <= win1_19;
      8'b00111110 : data_2_00 <= win2_19;
      8'b00111101 : data_2_00 <= win3_19;
      8'b00111100 : data_2_00 <= win4_19;
      8'b00111011 : data_2_00 <= win5_19;
      8'b00111010 : data_2_00 <= win6_19; 
      8'b00111001 : data_2_00 <= win7_19;
      8'b00111000 : data_2_00 <= win8_19;
      8'b00110111 : data_2_00 <= win9_19;
      8'b00110110 : data_2_00 <= win10_19;
      8'b00110101 : data_2_00 <= win11_19;
      8'b00110100 : data_2_00 <= win12_19;
      8'b00110011 : data_2_00 <= win13_19;
      8'b00110010 : data_2_00 <= win14_19;
      8'b00110001 : data_2_00 <= win15_19;
      8'b00110000 : data_2_00 <= win16_19;
      8'b00101111 : data_2_00 <= win1_18;
      8'b00101110 : data_2_00 <= win2_18;
      8'b00101101 : data_2_00 <= win3_18;
      8'b00101100 : data_2_00 <= win4_18;
      8'b00101011 : data_2_00 <= win5_18;
      8'b00101010 : data_2_00 <= win6_18; 
      8'b00101001 : data_2_00 <= win7_18;
      8'b00101000 : data_2_00 <= win8_18;
      8'b00100111 : data_2_00 <= win9_18;
      8'b00100110 : data_2_00 <= win10_18;
      8'b00100101 : data_2_00 <= win11_18;
      8'b00100100 : data_2_00 <= win12_18;
      8'b00100011 : data_2_00 <= win13_18;
      8'b00100010 : data_2_00 <= win14_18;
      8'b00100001 : data_2_00 <= win15_18;
      8'b00100000 : data_2_00 <= win16_18;
      8'b00011111 : data_2_00 <= win1_17;
      8'b00011110 : data_2_00 <= win2_17;
      8'b00011101 : data_2_00 <= win3_17;
      8'b00011100 : data_2_00 <= win4_17;
      8'b00011011 : data_2_00 <= win5_17;
      8'b00011010 : data_2_00 <= win6_17; 
      8'b00011001 : data_2_00 <= win7_17;
      8'b00011000 : data_2_00 <= win8_17;
      8'b00010111 : data_2_00 <= win9_17;
      8'b00010110 : data_2_00 <= win10_17;
      8'b00010101 : data_2_00 <= win11_17;
      8'b00010100 : data_2_00 <= win12_17;
      8'b00010011 : data_2_00 <= win13_17;
      8'b00010010 : data_2_00 <= win14_17;
      8'b00010001 : data_2_00 <= win15_17;
      8'b00010000 : data_2_00 <= win16_17;
      8'b00001111 : data_2_00 <= win1_16;
      8'b00001110 : data_2_00 <= win2_16;
      8'b00001101 : data_2_00 <= win3_16;
      8'b00001100 : data_2_00 <= win4_16;
      8'b00001011 : data_2_00 <= win5_16;
      8'b00001010 : data_2_00 <= win6_16; 
      8'b00001001 : data_2_00 <= win7_16;
      8'b00001000 : data_2_00 <= win8_16;
      8'b00000111 : data_2_00 <= win9_16;
      8'b00000110 : data_2_00 <= win10_16;
      8'b00000101 : data_2_00 <= win11_16;
      8'b00000100 : data_2_00 <= win12_16;
      8'b00000011 : data_2_00 <= win13_16;
      8'b00000010 : data_2_00 <= win14_16;
      8'b00000001 : data_2_00 <= win15_16;
      8'b00000000 : data_2_00 <= win16_16;
      endcase
    end
end


always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    data_2_01 <= 8'd0;
  else
    begin
      case({X2[3:0],Y2[3:0]})
      8'b11111111 : data_2_01 <= win17_31;    
      8'b11111110 : data_2_01 <= win18_31;
      8'b11111101 : data_2_01 <= win19_31;
      8'b11111100 : data_2_01 <= win20_31;
      8'b11111011 : data_2_01 <= win21_31;
      8'b11111010 : data_2_01 <= win22_31;
      8'b11111001 : data_2_01 <= win23_31;
      8'b11111000 : data_2_01 <= win24_31;
      8'b11110111 : data_2_01 <= win25_31;
      8'b11110110 : data_2_01 <= win26_31;
      8'b11110101 : data_2_01 <= win27_31;
      8'b11110100 : data_2_01 <= win28_31;
      8'b11110011 : data_2_01 <= win29_31;
      8'b11110010 : data_2_01 <= win30_31;
      8'b11110001 : data_2_01 <= win31_31;
      8'b11110000 : data_2_01 <= win31_31;
      8'b11101111 : data_2_01 <= win17_30;    
      8'b11101110 : data_2_01 <= win18_30;
      8'b11101101 : data_2_01 <= win19_30;
      8'b11101100 : data_2_01 <= win20_30;
      8'b11101011 : data_2_01 <= win21_30;
      8'b11101010 : data_2_01 <= win22_30;
      8'b11101001 : data_2_01 <= win23_30;
      8'b11101000 : data_2_01 <= win24_30;
      8'b11100111 : data_2_01 <= win25_30;
      8'b11100110 : data_2_01 <= win26_30;
      8'b11100101 : data_2_01 <= win27_30;
      8'b11100100 : data_2_01 <= win28_30;
      8'b11100011 : data_2_01 <= win29_30;
      8'b11100010 : data_2_01 <= win30_30;
      8'b11100001 : data_2_01 <= win31_30;
      8'b11100000 : data_2_01 <= win31_30;
      8'b11011111 : data_2_01 <= win17_29;
      8'b11011110 : data_2_01 <= win18_29;
      8'b11011101 : data_2_01 <= win19_29;
      8'b11011100 : data_2_01 <= win20_29;
      8'b11011011 : data_2_01 <= win21_29;
      8'b11011010 : data_2_01 <= win22_29;
      8'b11011001 : data_2_01 <= win23_29;
      8'b11011000 : data_2_01 <= win24_29;
      8'b11010111 : data_2_01 <= win25_29;
      8'b11010110 : data_2_01 <= win26_29;
      8'b11010101 : data_2_01 <= win27_29;
      8'b11010100 : data_2_01 <= win28_29;
      8'b11010011 : data_2_01 <= win29_29;
      8'b11010010 : data_2_01 <= win30_29;
      8'b11010001 : data_2_01 <= win31_29;
      8'b11010000 : data_2_01 <= win31_29;
      8'b11001111 : data_2_01 <= win17_28;
      8'b11001110 : data_2_01 <= win18_28;
      8'b11001101 : data_2_01 <= win19_28;
      8'b11001100 : data_2_01 <= win20_28;
      8'b11001011 : data_2_01 <= win21_28;
      8'b11001010 : data_2_01 <= win22_28;
      8'b11001001 : data_2_01 <= win23_28;
      8'b11001000 : data_2_01 <= win24_28;
      8'b11000111 : data_2_01 <= win25_28;
      8'b11000110 : data_2_01 <= win26_28;
      8'b11000101 : data_2_01 <= win27_28;
      8'b11000100 : data_2_01 <= win28_28;
      8'b11000011 : data_2_01 <= win29_28;
      8'b11000010 : data_2_01 <= win30_28;
      8'b11000001 : data_2_01 <= win31_28;
      8'b11000000 : data_2_01 <= win31_28;
      8'b10111111 : data_2_01 <= win17_27;
      8'b10111110 : data_2_01 <= win18_27;
      8'b10111101 : data_2_01 <= win19_27;
      8'b10111100 : data_2_01 <= win20_27;
      8'b10111011 : data_2_01 <= win21_27;
      8'b10111010 : data_2_01 <= win22_27;
      8'b10111001 : data_2_01 <= win23_27;
      8'b10111000 : data_2_01 <= win24_27;
      8'b10110111 : data_2_01 <= win25_27;
      8'b10110110 : data_2_01 <= win26_27;
      8'b10110101 : data_2_01 <= win27_27;
      8'b10110100 : data_2_01 <= win28_27;
      8'b10110011 : data_2_01 <= win29_27;
      8'b10110010 : data_2_01 <= win30_27;
      8'b10110001 : data_2_01 <= win31_27;
      8'b10110000 : data_2_01 <= win31_27;
      8'b10101111 : data_2_01 <= win17_26;
      8'b10101110 : data_2_01 <= win18_26;
      8'b10101101 : data_2_01 <= win19_26;
      8'b10101100 : data_2_01 <= win20_26;
      8'b10101011 : data_2_01 <= win21_26;
      8'b10101010 : data_2_01 <= win22_26;
      8'b10101001 : data_2_01 <= win23_26;
      8'b10101000 : data_2_01 <= win24_26;
      8'b10100111 : data_2_01 <= win25_26;
      8'b10100110 : data_2_01 <= win26_26;
      8'b10100101 : data_2_01 <= win27_26;
      8'b10100100 : data_2_01 <= win28_26;
      8'b10100011 : data_2_01 <= win29_26;
      8'b10100010 : data_2_01 <= win30_26;
      8'b10100001 : data_2_01 <= win31_26;
      8'b10100000 : data_2_01 <= win31_26;
      8'b10011111 : data_2_01 <= win17_25;
      8'b10011110 : data_2_01 <= win18_25;
      8'b10011101 : data_2_01 <= win19_25;
      8'b10011100 : data_2_01 <= win20_25;
      8'b10011011 : data_2_01 <= win21_25;
      8'b10011010 : data_2_01 <= win22_25;
      8'b10011001 : data_2_01 <= win23_25;
      8'b10011000 : data_2_01 <= win24_25;
      8'b10010111 : data_2_01 <= win25_25;
      8'b10010110 : data_2_01 <= win26_25;
      8'b10010101 : data_2_01 <= win27_25;
      8'b10010100 : data_2_01 <= win28_25;
      8'b10010011 : data_2_01 <= win29_25;
      8'b10010010 : data_2_01 <= win30_25;
      8'b10010001 : data_2_01 <= win31_25;
      8'b10010000 : data_2_01 <= win31_25;
      8'b10001111 : data_2_01 <= win17_24;
      8'b10001110 : data_2_01 <= win18_24;
      8'b10001101 : data_2_01 <= win19_24;
      8'b10001100 : data_2_01 <= win20_24;
      8'b10001011 : data_2_01 <= win21_24;
      8'b10001010 : data_2_01 <= win22_24;
      8'b10001001 : data_2_01 <= win23_24;
      8'b10001000 : data_2_01 <= win24_24;
      8'b10000111 : data_2_01 <= win25_24;
      8'b10000110 : data_2_01 <= win26_24;
      8'b10000101 : data_2_01 <= win27_24;
      8'b10000100 : data_2_01 <= win28_24;
      8'b10000011 : data_2_01 <= win29_24;
      8'b10000010 : data_2_01 <= win30_24;
      8'b10000001 : data_2_01 <= win31_24;
      8'b10000000 : data_2_01 <= win31_24;
      8'b01111111 : data_2_01 <= win17_23;
      8'b01111110 : data_2_01 <= win18_23;
      8'b01111101 : data_2_01 <= win19_23;
      8'b01111100 : data_2_01 <= win20_23;
      8'b01111011 : data_2_01 <= win21_23;
      8'b01111010 : data_2_01 <= win22_23;
      8'b01111001 : data_2_01 <= win23_23;
      8'b01111000 : data_2_01 <= win24_23;
      8'b01110111 : data_2_01 <= win25_23;
      8'b01110110 : data_2_01 <= win26_23;
      8'b01110101 : data_2_01 <= win27_23;
      8'b01110100 : data_2_01 <= win28_23;
      8'b01110011 : data_2_01 <= win29_23;
      8'b01110010 : data_2_01 <= win30_23;
      8'b01110001 : data_2_01 <= win31_23;
      8'b01110000 : data_2_01 <= win31_23;
      8'b01101111 : data_2_01 <= win17_22;
      8'b01101110 : data_2_01 <= win18_22;
      8'b01101101 : data_2_01 <= win19_22;
      8'b01101100 : data_2_01 <= win20_22;
      8'b01101011 : data_2_01 <= win21_22;
      8'b01101010 : data_2_01 <= win22_22;
      8'b01101001 : data_2_01 <= win23_22;
      8'b01101000 : data_2_01 <= win24_22;
      8'b01100111 : data_2_01 <= win25_22;
      8'b01100110 : data_2_01 <= win26_22;
      8'b01100101 : data_2_01 <= win27_22;
      8'b01100100 : data_2_01 <= win28_22;
      8'b01100011 : data_2_01 <= win29_22;
      8'b01100010 : data_2_01 <= win30_22;
      8'b01100001 : data_2_01 <= win31_22;
      8'b01100000 : data_2_01 <= win31_22;
      8'b01011111 : data_2_01 <= win17_21;
      8'b01011110 : data_2_01 <= win18_21;
      8'b01011101 : data_2_01 <= win19_21;
      8'b01011100 : data_2_01 <= win20_21;
      8'b01011011 : data_2_01 <= win21_21;
      8'b01011010 : data_2_01 <= win22_21;
      8'b01011001 : data_2_01 <= win23_21;
      8'b01011000 : data_2_01 <= win24_21;
      8'b01010111 : data_2_01 <= win25_21;
      8'b01010110 : data_2_01 <= win26_21;
      8'b01010101 : data_2_01 <= win27_21;
      8'b01010100 : data_2_01 <= win28_21;
      8'b01010011 : data_2_01 <= win29_21;
      8'b01010010 : data_2_01 <= win30_21;
      8'b01010001 : data_2_01 <= win31_21;
      8'b01010000 : data_2_01 <= win31_21;
      8'b01001111 : data_2_01 <= win17_20;
      8'b01001110 : data_2_01 <= win18_20;
      8'b01001101 : data_2_01 <= win19_20;
      8'b01001100 : data_2_01 <= win20_20;
      8'b01001011 : data_2_01 <= win21_20;
      8'b01001010 : data_2_01 <= win22_20;
      8'b01001001 : data_2_01 <= win23_20;
      8'b01001000 : data_2_01 <= win24_20;
      8'b01000111 : data_2_01 <= win25_20;
      8'b01000110 : data_2_01 <= win26_20;
      8'b01000101 : data_2_01 <= win27_20;
      8'b01000100 : data_2_01 <= win28_20;
      8'b01000011 : data_2_01 <= win29_20;
      8'b01000010 : data_2_01 <= win30_20;
      8'b01000001 : data_2_01 <= win31_20;
      8'b01000000 : data_2_01 <= win31_20;
      8'b00111111 : data_2_01 <= win17_19;
      8'b00111110 : data_2_01 <= win18_19;
      8'b00111101 : data_2_01 <= win19_19;
      8'b00111100 : data_2_01 <= win20_19;
      8'b00111011 : data_2_01 <= win21_19;
      8'b00111010 : data_2_01 <= win22_19;
      8'b00111001 : data_2_01 <= win23_19;
      8'b00111000 : data_2_01 <= win24_19;
      8'b00110111 : data_2_01 <= win25_19;
      8'b00110110 : data_2_01 <= win26_19;
      8'b00110101 : data_2_01 <= win27_19;
      8'b00110100 : data_2_01 <= win28_19;
      8'b00110011 : data_2_01 <= win29_19;
      8'b00110010 : data_2_01 <= win30_19;
      8'b00110001 : data_2_01 <= win31_19;
      8'b00110000 : data_2_01 <= win31_19;
      8'b00101111 : data_2_01 <= win17_18;
      8'b00101110 : data_2_01 <= win18_18;
      8'b00101101 : data_2_01 <= win19_18;
      8'b00101100 : data_2_01 <= win20_18;
      8'b00101011 : data_2_01 <= win21_18;
      8'b00101010 : data_2_01 <= win22_18;
      8'b00101001 : data_2_01 <= win23_18;
      8'b00101000 : data_2_01 <= win24_18;
      8'b00100111 : data_2_01 <= win25_18;
      8'b00100110 : data_2_01 <= win26_18;
      8'b00100101 : data_2_01 <= win27_18;
      8'b00100100 : data_2_01 <= win28_18;
      8'b00100011 : data_2_01 <= win29_18;
      8'b00100010 : data_2_01 <= win30_18;
      8'b00100001 : data_2_01 <= win31_18;
      8'b00100000 : data_2_01 <= win31_18;
      8'b00011111 : data_2_01 <= win17_17;
      8'b00011110 : data_2_01 <= win18_17;
      8'b00011101 : data_2_01 <= win19_17;
      8'b00011100 : data_2_01 <= win20_17;
      8'b00011011 : data_2_01 <= win21_17;
      8'b00011010 : data_2_01 <= win22_17;
      8'b00011001 : data_2_01 <= win23_17;
      8'b00011000 : data_2_01 <= win24_17;
      8'b00010111 : data_2_01 <= win25_17;
      8'b00010110 : data_2_01 <= win26_17;
      8'b00010101 : data_2_01 <= win27_17;
      8'b00010100 : data_2_01 <= win28_17;
      8'b00010011 : data_2_01 <= win29_17;
      8'b00010010 : data_2_01 <= win30_17;
      8'b00010001 : data_2_01 <= win31_17;
      8'b00010000 : data_2_01 <= win31_17;
      8'b00001111 : data_2_01 <= win17_16;
      8'b00001110 : data_2_01 <= win18_16;
      8'b00001101 : data_2_01 <= win19_16;
      8'b00001100 : data_2_01 <= win20_16;
      8'b00001011 : data_2_01 <= win21_16;
      8'b00001010 : data_2_01 <= win22_16;
      8'b00001001 : data_2_01 <= win23_16;
      8'b00001000 : data_2_01 <= win24_16;
      8'b00000111 : data_2_01 <= win25_16;
      8'b00000110 : data_2_01 <= win26_16;
      8'b00000101 : data_2_01 <= win27_16;
      8'b00000100 : data_2_01 <= win28_16;
      8'b00000011 : data_2_01 <= win29_16;
      8'b00000010 : data_2_01 <= win30_16;
      8'b00000001 : data_2_01 <= win31_16;
      8'b00000000 : data_2_01 <= win31_16;
      endcase
    end
end

always@(posedge clk or negedge rst_n)
begin      
  if(!rst_n)      
    data_2_10 <= 8'd0;      
  else      
    begin      
      case({X2[3:0],Y2[3:0]}) 
      8'b11111111 : data_2_10 <= win1_15;   
      8'b11111110 : data_2_10 <= win2_15;
      8'b11111101 : data_2_10 <= win3_15;
      8'b11111100 : data_2_10 <= win4_15;
      8'b11111011 : data_2_10 <= win5_15;
      8'b11111010 : data_2_10 <= win6_15; 
      8'b11111001 : data_2_10 <= win7_15;
      8'b11111000 : data_2_10 <= win8_15;
      8'b11110111 : data_2_10 <= win9_15;
      8'b11110110 : data_2_10 <= win10_15;
      8'b11110101 : data_2_10 <= win11_15;
      8'b11110100 : data_2_10 <= win12_15;
      8'b11110011 : data_2_10 <= win13_15;
      8'b11110010 : data_2_10 <= win14_15;
      8'b11110001 : data_2_10 <= win15_15;
      8'b11110000 : data_2_10 <= win16_15;
      8'b11101111 : data_2_10 <= win1_14;   
      8'b11101110 : data_2_10 <= win2_14;
      8'b11101101 : data_2_10 <= win3_14;
      8'b11101100 : data_2_10 <= win4_14;
      8'b11101011 : data_2_10 <= win5_14;
      8'b11101010 : data_2_10 <= win6_14; 
      8'b11101001 : data_2_10 <= win7_14;
      8'b11101000 : data_2_10 <= win8_14;
      8'b11100111 : data_2_10 <= win9_14;
      8'b11100110 : data_2_10 <= win10_14;
      8'b11100101 : data_2_10 <= win11_14;
      8'b11100100 : data_2_10 <= win12_14;
      8'b11100011 : data_2_10 <= win13_14;
      8'b11100010 : data_2_10 <= win14_14;
      8'b11100001 : data_2_10 <= win15_14;
      8'b11100000 : data_2_10 <= win16_14;
      8'b11011111 : data_2_10 <= win1_13; 
      8'b11011110 : data_2_10 <= win2_13;
      8'b11011101 : data_2_10 <= win3_13;
      8'b11011100 : data_2_10 <= win4_13;
      8'b11011011 : data_2_10 <= win5_13;
      8'b11011010 : data_2_10 <= win6_13; 
      8'b11011001 : data_2_10 <= win7_13;
      8'b11011000 : data_2_10 <= win8_13;
      8'b11010111 : data_2_10 <= win9_13;
      8'b11010110 : data_2_10 <= win10_13;
      8'b11010101 : data_2_10 <= win11_13;
      8'b11010100 : data_2_10 <= win12_13;
      8'b11010011 : data_2_10 <= win13_13;
      8'b11010010 : data_2_10 <= win14_13;
      8'b11010001 : data_2_10 <= win15_13;
      8'b11010000 : data_2_10 <= win16_13;
      8'b11001111 : data_2_10 <= win1_12; 
      8'b11001110 : data_2_10 <= win2_12;
      8'b11001101 : data_2_10 <= win3_12;
      8'b11001100 : data_2_10 <= win4_12;
      8'b11001011 : data_2_10 <= win5_12;
      8'b11001010 : data_2_10 <= win6_12; 
      8'b11001001 : data_2_10 <= win7_12;
      8'b11001000 : data_2_10 <= win8_12;
      8'b11000111 : data_2_10 <= win9_12;
      8'b11000110 : data_2_10 <= win10_12;
      8'b11000101 : data_2_10 <= win11_12;
      8'b11000100 : data_2_10 <= win12_12;
      8'b11000011 : data_2_10 <= win13_12;
      8'b11000010 : data_2_10 <= win14_12;
      8'b11000001 : data_2_10 <= win15_12;
      8'b11000000 : data_2_10 <= win16_12;
      8'b10111111 : data_2_10 <= win1_11; 
      8'b10111110 : data_2_10 <= win2_11;
      8'b10111101 : data_2_10 <= win3_11;
      8'b10111100 : data_2_10 <= win4_11;
      8'b10111011 : data_2_10 <= win5_11;
      8'b10111010 : data_2_10 <= win6_11; 
      8'b10111001 : data_2_10 <= win7_11;
      8'b10111000 : data_2_10 <= win8_11;
      8'b10110111 : data_2_10 <= win9_11;
      8'b10110110 : data_2_10 <= win10_11;
      8'b10110101 : data_2_10 <= win11_11;
      8'b10110100 : data_2_10 <= win12_11;
      8'b10110011 : data_2_10 <= win13_11;
      8'b10110010 : data_2_10 <= win14_11;
      8'b10110001 : data_2_10 <= win15_11;
      8'b10110000 : data_2_10 <= win16_11;
      8'b10101111 : data_2_10 <= win1_10; 
      8'b10101110 : data_2_10 <= win2_10;
      8'b10101101 : data_2_10 <= win3_10;
      8'b10101100 : data_2_10 <= win4_10;
      8'b10101011 : data_2_10 <= win5_10;
      8'b10101010 : data_2_10 <= win6_10; 
      8'b10101001 : data_2_10 <= win7_10;
      8'b10101000 : data_2_10 <= win8_10;
      8'b10100111 : data_2_10 <= win9_10;
      8'b10100110 : data_2_10 <= win10_10;
      8'b10100101 : data_2_10 <= win11_10;
      8'b10100100 : data_2_10 <= win12_10;
      8'b10100011 : data_2_10 <= win13_10;
      8'b10100010 : data_2_10 <= win14_10;
      8'b10100001 : data_2_10 <= win15_10;
      8'b10100000 : data_2_10 <= win16_10;
      8'b10011111 : data_2_10 <= win1_9; 
      8'b10011110 : data_2_10 <= win2_9;
      8'b10011101 : data_2_10 <= win3_9;
      8'b10011100 : data_2_10 <= win4_9;
      8'b10011011 : data_2_10 <= win5_9;
      8'b10011010 : data_2_10 <= win6_9; 
      8'b10011001 : data_2_10 <= win7_9;
      8'b10011000 : data_2_10 <= win8_9;
      8'b10010111 : data_2_10 <= win9_9;
      8'b10010110 : data_2_10 <= win10_9;
      8'b10010101 : data_2_10 <= win11_9;
      8'b10010100 : data_2_10 <= win12_9;
      8'b10010011 : data_2_10 <= win13_9;
      8'b10010010 : data_2_10 <= win14_9;
      8'b10010001 : data_2_10 <= win15_9;
      8'b10010000 : data_2_10 <= win16_9;
      8'b10001111 : data_2_10 <= win1_8; 
      8'b10001110 : data_2_10 <= win2_8;
      8'b10001101 : data_2_10 <= win3_8;
      8'b10001100 : data_2_10 <= win4_8;
      8'b10001011 : data_2_10 <= win5_8;
      8'b10001010 : data_2_10 <= win6_8; 
      8'b10001001 : data_2_10 <= win7_8;
      8'b10001000 : data_2_10 <= win8_8;
      8'b10000111 : data_2_10 <= win9_8;
      8'b10000110 : data_2_10 <= win10_8;
      8'b10000101 : data_2_10 <= win11_8;
      8'b10000100 : data_2_10 <= win12_8;
      8'b10000011 : data_2_10 <= win13_8;
      8'b10000010 : data_2_10 <= win14_8;
      8'b10000001 : data_2_10 <= win15_8;
      8'b10000000 : data_2_10 <= win16_8;
      8'b01111111 : data_2_10 <= win1_7; 
      8'b01111110 : data_2_10 <= win2_7;
      8'b01111101 : data_2_10 <= win3_7;
      8'b01111100 : data_2_10 <= win4_7;
      8'b01111011 : data_2_10 <= win5_7;
      8'b01111010 : data_2_10 <= win6_7; 
      8'b01111001 : data_2_10 <= win7_7;
      8'b01111000 : data_2_10 <= win8_7;
      8'b01110111 : data_2_10 <= win9_7;
      8'b01110110 : data_2_10 <= win10_7;
      8'b01110101 : data_2_10 <= win11_7;
      8'b01110100 : data_2_10 <= win12_7;
      8'b01110011 : data_2_10 <= win13_7;
      8'b01110010 : data_2_10 <= win14_7;
      8'b01110001 : data_2_10 <= win15_7;
      8'b01110000 : data_2_10 <= win16_7;
      8'b01101111 : data_2_10 <= win1_6; 
      8'b01101110 : data_2_10 <= win2_6;
      8'b01101101 : data_2_10 <= win3_6;
      8'b01101100 : data_2_10 <= win4_6;
      8'b01101011 : data_2_10 <= win5_6;
      8'b01101010 : data_2_10 <= win6_6; 
      8'b01101001 : data_2_10 <= win7_6;
      8'b01101000 : data_2_10 <= win8_6;
      8'b01100111 : data_2_10 <= win9_6;
      8'b01100110 : data_2_10 <= win10_6;
      8'b01100101 : data_2_10 <= win11_6;
      8'b01100100 : data_2_10 <= win12_6;
      8'b01100011 : data_2_10 <= win13_6;
      8'b01100010 : data_2_10 <= win14_6;
      8'b01100001 : data_2_10 <= win15_6;
      8'b01100000 : data_2_10 <= win16_6;
      8'b01011111 : data_2_10 <= win1_5; 
      8'b01011110 : data_2_10 <= win2_5;
      8'b01011101 : data_2_10 <= win3_5;
      8'b01011100 : data_2_10 <= win4_5;
      8'b01011011 : data_2_10 <= win5_5;
      8'b01011010 : data_2_10 <= win6_5; 
      8'b01011001 : data_2_10 <= win7_5;
      8'b01011000 : data_2_10 <= win8_5;
      8'b01010111 : data_2_10 <= win9_5;
      8'b01010110 : data_2_10 <= win10_5;
      8'b01010101 : data_2_10 <= win11_5;
      8'b01010100 : data_2_10 <= win12_5;
      8'b01010011 : data_2_10 <= win13_5;
      8'b01010010 : data_2_10 <= win14_5;
      8'b01010001 : data_2_10 <= win15_5;
      8'b01010000 : data_2_10 <= win16_5;
      8'b01001111 : data_2_10 <= win1_4; 
      8'b01001110 : data_2_10 <= win2_4;
      8'b01001101 : data_2_10 <= win3_4;
      8'b01001100 : data_2_10 <= win4_4;
      8'b01001011 : data_2_10 <= win5_4;
      8'b01001010 : data_2_10 <= win6_4; 
      8'b01001001 : data_2_10 <= win7_4;
      8'b01001000 : data_2_10 <= win8_4;
      8'b01000111 : data_2_10 <= win9_4;
      8'b01000110 : data_2_10 <= win10_4;
      8'b01000101 : data_2_10 <= win11_4;
      8'b01000100 : data_2_10 <= win12_4;
      8'b01000011 : data_2_10 <= win13_4;
      8'b01000010 : data_2_10 <= win14_4;
      8'b01000001 : data_2_10 <= win15_4;
      8'b01000000 : data_2_10 <= win16_4;
      8'b00111111 : data_2_10 <= win1_3; 
      8'b00111110 : data_2_10 <= win2_3;
      8'b00111101 : data_2_10 <= win3_3;
      8'b00111100 : data_2_10 <= win4_3;
      8'b00111011 : data_2_10 <= win5_3;
      8'b00111010 : data_2_10 <= win6_3; 
      8'b00111001 : data_2_10 <= win7_3;
      8'b00111000 : data_2_10 <= win8_3;
      8'b00110111 : data_2_10 <= win9_3;
      8'b00110110 : data_2_10 <= win10_3;
      8'b00110101 : data_2_10 <= win11_3;
      8'b00110100 : data_2_10 <= win12_3;
      8'b00110011 : data_2_10 <= win13_3;
      8'b00110010 : data_2_10 <= win14_3;
      8'b00110001 : data_2_10 <= win15_3;
      8'b00110000 : data_2_10 <= win16_3;
      8'b00101111 : data_2_10 <= win1_2; 
      8'b00101110 : data_2_10 <= win2_2;
      8'b00101101 : data_2_10 <= win3_2;
      8'b00101100 : data_2_10 <= win4_2;
      8'b00101011 : data_2_10 <= win5_2;
      8'b00101010 : data_2_10 <= win6_2; 
      8'b00101001 : data_2_10 <= win7_2;
      8'b00101000 : data_2_10 <= win8_2;
      8'b00100111 : data_2_10 <= win9_2;
      8'b00100110 : data_2_10 <= win10_2;
      8'b00100101 : data_2_10 <= win11_2;
      8'b00100100 : data_2_10 <= win12_2;
      8'b00100011 : data_2_10 <= win13_2;
      8'b00100010 : data_2_10 <= win14_2;
      8'b00100001 : data_2_10 <= win15_2;
      8'b00100000 : data_2_10 <= win16_2;
      8'b00011111 : data_2_10 <= win1_1; 
      8'b00011110 : data_2_10 <= win2_1;
      8'b00011101 : data_2_10 <= win3_1;
      8'b00011100 : data_2_10 <= win4_1;
      8'b00011011 : data_2_10 <= win5_1;
      8'b00011010 : data_2_10 <= win6_1; 
      8'b00011001 : data_2_10 <= win7_1;
      8'b00011000 : data_2_10 <= win8_1;
      8'b00010111 : data_2_10 <= win9_1;
      8'b00010110 : data_2_10 <= win10_1;
      8'b00010101 : data_2_10 <= win11_1;
      8'b00010100 : data_2_10 <= win12_1;
      8'b00010011 : data_2_10 <= win13_1;
      8'b00010010 : data_2_10 <= win14_1;
      8'b00010001 : data_2_10 <= win15_1;
      8'b00010000 : data_2_10 <= win16_1;
      8'b00001111 : data_2_10 <= win1_1; 
      8'b00001110 : data_2_10 <= win2_1;
      8'b00001101 : data_2_10 <= win3_1;
      8'b00001100 : data_2_10 <= win4_1;
      8'b00001011 : data_2_10 <= win5_1;
      8'b00001010 : data_2_10 <= win6_1; 
      8'b00001001 : data_2_10 <= win7_1;
      8'b00001000 : data_2_10 <= win8_1;
      8'b00000111 : data_2_10 <= win9_1;
      8'b00000110 : data_2_10 <= win10_1;
      8'b00000101 : data_2_10 <= win11_1;
      8'b00000100 : data_2_10 <= win12_1;
      8'b00000011 : data_2_10 <= win13_1;
      8'b00000010 : data_2_10 <= win14_1;
      8'b00000001 : data_2_10 <= win15_1;
      8'b00000000 : data_2_10 <= win16_1;
      endcase
    end
end

always@(posedge clk or negedge rst_n)
begin      
  if(!rst_n)      
    data_2_11 <= 8'd0;      
  else      
    begin      
      case({X2[3:0],Y2[3:0]})
      8'b11111111 : data_2_11 <= win17_15;
      8'b11111110 : data_2_11 <= win18_15;     
      8'b11111101 : data_2_11 <= win19_15;
      8'b11111100 : data_2_11 <= win20_15;
      8'b11111011 : data_2_11 <= win21_15;
      8'b11111010 : data_2_11 <= win22_15;
      8'b11111001 : data_2_11 <= win23_15;
      8'b11111000 : data_2_11 <= win24_15;
      8'b11110111 : data_2_11 <= win25_15;
      8'b11110110 : data_2_11 <= win26_15;
      8'b11110101 : data_2_11 <= win27_15;
      8'b11110100 : data_2_11 <= win28_15;
      8'b11110011 : data_2_11 <= win29_15;
      8'b11110010 : data_2_11 <= win30_15;
      8'b11110001 : data_2_11 <= win31_15;
      8'b11110000 : data_2_11 <= win31_15;
      8'b11101111 : data_2_11 <= win17_14;
      8'b11101110 : data_2_11 <= win18_14;     
      8'b11101101 : data_2_11 <= win19_14;
      8'b11101100 : data_2_11 <= win20_14;
      8'b11101011 : data_2_11 <= win21_14;
      8'b11101010 : data_2_11 <= win22_14;
      8'b11101001 : data_2_11 <= win23_14;
      8'b11101000 : data_2_11 <= win24_14;
      8'b11100111 : data_2_11 <= win25_14;
      8'b11100110 : data_2_11 <= win26_14;
      8'b11100101 : data_2_11 <= win27_14;
      8'b11100100 : data_2_11 <= win28_14;
      8'b11100011 : data_2_11 <= win29_14;
      8'b11100010 : data_2_11 <= win30_14;
      8'b11100001 : data_2_11 <= win31_14;
      8'b11100000 : data_2_11 <= win31_14;
      8'b11011111 : data_2_11 <= win17_13;
      8'b11011110 : data_2_11 <= win18_13;     
      8'b11011101 : data_2_11 <= win19_13;
      8'b11011100 : data_2_11 <= win20_13;
      8'b11011011 : data_2_11 <= win21_13;
      8'b11011010 : data_2_11 <= win22_13;
      8'b11011001 : data_2_11 <= win23_13;
      8'b11011000 : data_2_11 <= win24_13;
      8'b11010111 : data_2_11 <= win25_13;
      8'b11010110 : data_2_11 <= win26_13;
      8'b11010101 : data_2_11 <= win27_13;
      8'b11010100 : data_2_11 <= win28_13;
      8'b11010011 : data_2_11 <= win29_13;
      8'b11010010 : data_2_11 <= win30_13;
      8'b11010001 : data_2_11 <= win31_13;
      8'b11010000 : data_2_11 <= win31_13;
      8'b11001111 : data_2_11 <= win17_12;
      8'b11001110 : data_2_11 <= win18_12; 
      8'b11001101 : data_2_11 <= win19_12;
      8'b11001100 : data_2_11 <= win20_12;
      8'b11001011 : data_2_11 <= win21_12;
      8'b11001010 : data_2_11 <= win22_12;
      8'b11001001 : data_2_11 <= win23_12;
      8'b11001000 : data_2_11 <= win24_12;
      8'b11000111 : data_2_11 <= win25_12;
      8'b11000110 : data_2_11 <= win26_12;
      8'b11000101 : data_2_11 <= win27_12;
      8'b11000100 : data_2_11 <= win28_12;
      8'b11000011 : data_2_11 <= win29_12;
      8'b11000010 : data_2_11 <= win30_12;
      8'b11000001 : data_2_11 <= win31_12;
      8'b11000000 : data_2_11 <= win31_12;
      8'b10111111 : data_2_11 <= win17_11;
      8'b10111110 : data_2_11 <= win18_11; 
      8'b10111101 : data_2_11 <= win19_11;
      8'b10111100 : data_2_11 <= win20_11;
      8'b10111011 : data_2_11 <= win21_11;
      8'b10111010 : data_2_11 <= win22_11;
      8'b10111001 : data_2_11 <= win23_11;
      8'b10111000 : data_2_11 <= win24_11;
      8'b10110111 : data_2_11 <= win25_11;
      8'b10110110 : data_2_11 <= win26_11;
      8'b10110101 : data_2_11 <= win27_11;
      8'b10110100 : data_2_11 <= win28_11;
      8'b10110011 : data_2_11 <= win29_11;
      8'b10110010 : data_2_11 <= win30_11;
      8'b10110001 : data_2_11 <= win31_11;
      8'b10110000 : data_2_11 <= win31_11;
      8'b10101111 : data_2_11 <= win17_10;
      8'b10101110 : data_2_11 <= win18_10; 
      8'b10101101 : data_2_11 <= win19_10;
      8'b10101100 : data_2_11 <= win20_10;
      8'b10101011 : data_2_11 <= win21_10;
      8'b10101010 : data_2_11 <= win22_10;
      8'b10101001 : data_2_11 <= win23_10;
      8'b10101000 : data_2_11 <= win24_10;
      8'b10100111 : data_2_11 <= win25_10;
      8'b10100110 : data_2_11 <= win26_10;
      8'b10100101 : data_2_11 <= win27_10;
      8'b10100100 : data_2_11 <= win28_10;
      8'b10100011 : data_2_11 <= win29_10;
      8'b10100010 : data_2_11 <= win30_10;
      8'b10100001 : data_2_11 <= win31_10;
      8'b10100000 : data_2_11 <= win31_10;
      8'b10011111 : data_2_11 <= win17_9;
      8'b10011110 : data_2_11 <= win18_9; 
      8'b10011101 : data_2_11 <= win19_9;
      8'b10011100 : data_2_11 <= win20_9;
      8'b10011011 : data_2_11 <= win21_9;
      8'b10011010 : data_2_11 <= win22_9;
      8'b10011001 : data_2_11 <= win23_9;
      8'b10011000 : data_2_11 <= win24_9;
      8'b10010111 : data_2_11 <= win25_9;
      8'b10010110 : data_2_11 <= win26_9;
      8'b10010101 : data_2_11 <= win27_9;
      8'b10010100 : data_2_11 <= win28_9;
      8'b10010011 : data_2_11 <= win29_9;
      8'b10010010 : data_2_11 <= win30_9;
      8'b10010001 : data_2_11 <= win31_9;
      8'b10010000 : data_2_11 <= win31_9;
      8'b10001111 : data_2_11 <= win17_8;
      8'b10001110 : data_2_11 <= win18_8;
      8'b10001101 : data_2_11 <= win19_8;
      8'b10001100 : data_2_11 <= win20_8;
      8'b10001011 : data_2_11 <= win21_8;
      8'b10001010 : data_2_11 <= win22_8;
      8'b10001001 : data_2_11 <= win23_8;
      8'b10001000 : data_2_11 <= win24_8;
      8'b10000111 : data_2_11 <= win25_8;
      8'b10000110 : data_2_11 <= win26_8;
      8'b10000101 : data_2_11 <= win27_8;
      8'b10000100 : data_2_11 <= win28_8;
      8'b10000011 : data_2_11 <= win29_8;
      8'b10000010 : data_2_11 <= win30_8;
      8'b10000001 : data_2_11 <= win31_8;
      8'b10000000 : data_2_11 <= win31_8;
      8'b01111111 : data_2_11 <= win17_7;
      8'b01111110 : data_2_11 <= win18_7;
      8'b01111101 : data_2_11 <= win19_7;
      8'b01111100 : data_2_11 <= win20_7;
      8'b01111011 : data_2_11 <= win21_7;
      8'b01111010 : data_2_11 <= win22_7;
      8'b01111001 : data_2_11 <= win23_7;
      8'b01111000 : data_2_11 <= win24_7;
      8'b01110111 : data_2_11 <= win25_7;
      8'b01110110 : data_2_11 <= win26_7;
      8'b01110101 : data_2_11 <= win27_7;
      8'b01110100 : data_2_11 <= win28_7;
      8'b01110011 : data_2_11 <= win29_7;
      8'b01110010 : data_2_11 <= win30_7;
      8'b01110001 : data_2_11 <= win31_7;
      8'b01110000 : data_2_11 <= win31_7;
      8'b01101111 : data_2_11 <= win17_6;
      8'b01101110 : data_2_11 <= win18_6;
      8'b01101101 : data_2_11 <= win19_6;
      8'b01101100 : data_2_11 <= win20_6;
      8'b01101011 : data_2_11 <= win21_6;
      8'b01101010 : data_2_11 <= win22_6;
      8'b01101001 : data_2_11 <= win23_6;
      8'b01101000 : data_2_11 <= win24_6;
      8'b01100111 : data_2_11 <= win25_6;
      8'b01100110 : data_2_11 <= win26_6;
      8'b01100101 : data_2_11 <= win27_6;
      8'b01100100 : data_2_11 <= win28_6;
      8'b01100011 : data_2_11 <= win29_6;
      8'b01100010 : data_2_11 <= win30_6;
      8'b01100001 : data_2_11 <= win31_6;
      8'b01100000 : data_2_11 <= win31_6;
      8'b01011111 : data_2_11 <= win17_5;
      8'b01011110 : data_2_11 <= win18_5;
      8'b01011101 : data_2_11 <= win19_5;
      8'b01011100 : data_2_11 <= win20_5;
      8'b01011011 : data_2_11 <= win21_5;
      8'b01011010 : data_2_11 <= win22_5;
      8'b01011001 : data_2_11 <= win23_5;
      8'b01011000 : data_2_11 <= win24_5;
      8'b01010111 : data_2_11 <= win25_5;
      8'b01010110 : data_2_11 <= win26_5;
      8'b01010101 : data_2_11 <= win27_5;
      8'b01010100 : data_2_11 <= win28_5;
      8'b01010011 : data_2_11 <= win29_5;
      8'b01010010 : data_2_11 <= win30_5;
      8'b01010001 : data_2_11 <= win31_5;
      8'b01010000 : data_2_11 <= win31_5;
      8'b01001111 : data_2_11 <= win17_4;
      8'b01001110 : data_2_11 <= win18_4;
      8'b01001101 : data_2_11 <= win19_4;
      8'b01001100 : data_2_11 <= win20_4;
      8'b01001011 : data_2_11 <= win21_4;
      8'b01001010 : data_2_11 <= win22_4;
      8'b01001001 : data_2_11 <= win23_4;
      8'b01001000 : data_2_11 <= win24_4;
      8'b01000111 : data_2_11 <= win25_4;
      8'b01000110 : data_2_11 <= win26_4;
      8'b01000101 : data_2_11 <= win27_4;
      8'b01000100 : data_2_11 <= win28_4;
      8'b01000011 : data_2_11 <= win29_4;
      8'b01000010 : data_2_11 <= win30_4;
      8'b01000001 : data_2_11 <= win31_4;
      8'b01000000 : data_2_11 <= win31_4;
      8'b00111111 : data_2_11 <= win17_3;
      8'b00111110 : data_2_11 <= win18_3;
      8'b00111101 : data_2_11 <= win19_3;
      8'b00111100 : data_2_11 <= win20_3;
      8'b00111011 : data_2_11 <= win21_3;
      8'b00111010 : data_2_11 <= win22_3;
      8'b00111001 : data_2_11 <= win23_3;
      8'b00111000 : data_2_11 <= win24_3;
      8'b00110111 : data_2_11 <= win25_3;
      8'b00110110 : data_2_11 <= win26_3;
      8'b00110101 : data_2_11 <= win27_3;
      8'b00110100 : data_2_11 <= win28_3;
      8'b00110011 : data_2_11 <= win29_3;
      8'b00110010 : data_2_11 <= win30_3;
      8'b00110001 : data_2_11 <= win31_3;
      8'b00110000 : data_2_11 <= win31_3;
      8'b00101111 : data_2_11 <= win17_2;
      8'b00101110 : data_2_11 <= win18_2;
      8'b00101101 : data_2_11 <= win19_2;
      8'b00101100 : data_2_11 <= win20_2;
      8'b00101011 : data_2_11 <= win21_2;
      8'b00101010 : data_2_11 <= win22_2;
      8'b00101001 : data_2_11 <= win23_2;
      8'b00101000 : data_2_11 <= win24_2;
      8'b00100111 : data_2_11 <= win25_2;
      8'b00100110 : data_2_11 <= win26_2;
      8'b00100101 : data_2_11 <= win27_2;
      8'b00100100 : data_2_11 <= win28_2;
      8'b00100011 : data_2_11 <= win29_2;
      8'b00100010 : data_2_11 <= win30_2;
      8'b00100001 : data_2_11 <= win31_2;
      8'b00100000 : data_2_11 <= win31_2;
      8'b00011111 : data_2_11 <= win17_1;
      8'b00011110 : data_2_11 <= win18_1;
      8'b00011101 : data_2_11 <= win19_1;
      8'b00011100 : data_2_11 <= win20_1;
      8'b00011011 : data_2_11 <= win21_1;
      8'b00011010 : data_2_11 <= win22_1;
      8'b00011001 : data_2_11 <= win23_1;
      8'b00011000 : data_2_11 <= win24_1;
      8'b00010111 : data_2_11 <= win25_1;
      8'b00010110 : data_2_11 <= win26_1;
      8'b00010101 : data_2_11 <= win27_1;
      8'b00010100 : data_2_11 <= win28_1;
      8'b00010011 : data_2_11 <= win29_1;
      8'b00010010 : data_2_11 <= win30_1;
      8'b00010001 : data_2_11 <= win31_1;
      8'b00010000 : data_2_11 <= win31_1;
      8'b00001111 : data_2_11 <= win17_1;
      8'b00001110 : data_2_11 <= win18_1;
      8'b00001101 : data_2_11 <= win19_1;
      8'b00001100 : data_2_11 <= win20_1;
      8'b00001011 : data_2_11 <= win21_1;
      8'b00001010 : data_2_11 <= win22_1;
      8'b00001001 : data_2_11 <= win23_1;
      8'b00001000 : data_2_11 <= win24_1;
      8'b00000111 : data_2_11 <= win25_1;
      8'b00000110 : data_2_11 <= win26_1;
      8'b00000101 : data_2_11 <= win27_1;
      8'b00000100 : data_2_11 <= win28_1;
      8'b00000011 : data_2_11 <= win29_1;
      8'b00000010 : data_2_11 <= win30_1;
      8'b00000001 : data_2_11 <= win31_1;
      8'b00000000 : data_2_11 <= win31_1;      
      endcase
    end
end
always@(*)
begin  
  if(!rst_n)
    data_1 = 8'd0;
  else
    begin
      case({X1_tp[4],Y1_tp[4]})
      2'b00 : data_1 = data_1_00;
      2'b01 : data_1 = data_1_01;
      2'b10 : data_1 = data_1_10;
      2'b11 : data_1 = data_1_11;
      endcase
    end
end

always@(*)
begin  
  if(!rst_n)
    data_2 = 8'd0;
  else
    begin
      case({X2_tp[4],Y2_tp[4]})
      2'b00 : data_2 = data_2_00;
      2'b01 : data_2 = data_2_01;
      2'b10 : data_2 = data_2_10;
      2'b11 : data_2 = data_2_11;
      endcase
    end
end     
     





 
      
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_bit <= 4'd0;
  else if(start==1'b1)
    count_bit <= 4'd0;
  else
  begin
     if(XY==XY_in)
     begin
       if(addr_mod1>=12)
       begin
         if(count_bit<8)
           count_bit <= count_bit + 1'b1;
         else if(count_bit==8)
           count_bit <= 4'd1;
       end
     end
     else
       count_bit <= 4'd0;
  end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
  begin
    bit0 <= 1'b0;
    bit1 <= 1'b0;
    bit2 <= 1'b0;
    bit3 <= 1'b0;
    bit4 <= 1'b0;
    bit5 <= 1'b0;
    bit6 <= 1'b0;
    bit7 <= 1'b0;
  end
  else if(start==1'b1)
  begin  
    bit0 <= 1'b0;
    bit1 <= 1'b0;
    bit2 <= 1'b0;
    bit3 <= 1'b0;
    bit4 <= 1'b0;
    bit5 <= 1'b0;
    bit6 <= 1'b0;
    bit7 <= 1'b0;
  end
  else
  begin
    if(XY==XY_in)
      begin
        if(count_bit==0 || count_bit==8)
          bit0 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==1)
          bit1 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==2)
          bit2 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==3)
          bit3 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==4)
          bit4 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==5)
          bit5 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==6)
          bit6 <= (data_1<data_2)? 1'b1 : 1'b0 ;
        else if(count_bit==7)
          bit7 <= (data_1<data_2)? 1'b1 : 1'b0 ;
      end
    else
      begin
        bit0 <= 1'b0;
        bit1 <= 1'b0;
        bit2 <= 1'b0;
        bit3 <= 1'b0;
        bit4 <= 1'b0;
        bit5 <= 1'b0;
        bit6 <= 1'b0;
        bit7 <= 1'b0;
      end
  end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    flag <= 6'd0;
  else if(start==1'b1)
    flag <= 6'd0;
  else
    begin
      if(XY==XY_in)
        begin
          if(count_bit==8 && flag<32)
            flag <= flag + 1'b1;
        end
      else
        flag <= 6'd0;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    dout <= 8'd0;
  else if(count_bit==8 && XY==XY_in)
    dout <= {bit7,bit6,bit5,bit4,bit3,bit2,bit1,bit0};
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_out_temp <= 19'd0;
  else if(start==1'b1)
    addr_out_temp <= 19'd0;
  else
    begin
      if(XY==XY_in)
        begin
          if(count_bit==8 && addr_out_temp<totalx32)
            addr_out_temp <= addr_out_temp + 1'b1;
        end
    end
end
  
endmodule
      
      

  


     
   