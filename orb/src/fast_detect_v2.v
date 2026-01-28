module fast_detect_v2(clk,rst_n,start,din,addr_b,dout,num_fast,m10,m01,m10_op,m01_op,start_gb,wren,addr_out);
  input clk;
  input rst_n;
  input start;
  input din;
  output addr_b;
  //output X_out,Y_out;
  output dout;
  output num_fast;
  output m10;
  output m01;
  output m10_op;
  output m01_op;
  output start_gb;
  output wren;
  output addr_out;
  
  
  parameter threshold=70,width_ext=678,height_ext=518,border=19;
  
  wire [7:0] m10_op;
  wire [7:0] m01_op;
  
  assign m10_op={m10[20],m10[6:0]};
  assign m01_op={m01[20],m01[6:0]};
  wire [7:0] din;
  reg [18:0] addr_b;
  reg en;
  reg [9:0] X,Y;
  reg [9:0] X_tp_1,Y_tp_1;
  reg [9:0] X_tp_2,Y_tp_2;
  reg [9:0] X_tp_3,Y_tp_3;
  reg [9:0] X_tp_4,Y_tp_4;
  reg [19:0] dout;
  reg [19:0] dout_tp_1;
  reg [13:0] num_fast;
  wire [13:0] addr_out;
  reg signed [20:0] m10;
  reg signed [20:0] m01;
  reg signed [13:0] m10_15,m10_14,m10_13,m10_12,m10_11,m10_10,m10_9,m10_8,m10_7,m10_6,m10_5,m10_4,m10_3,m10_2,m10_1;
  reg signed [13:0] m01_15,m01_14,m01_13,m01_12,m01_11,m01_10,m01_9,m01_8,m01_7,m01_6,m01_5,m01_4,m01_3,m01_2,m01_1;
  
  wire signed [17:0]  m10_15x15,m10_14x14,m10_13x13,m10_12x12,m10_11x11,m10_10x10,m10_9x9,m10_7x7,m10_6x6,m10_5x5,m10_3x3,m10_1x1,
                      m01_15x15,m01_14x14,m01_13x13,m01_12x12,m01_11x11,m01_10x10,m01_9x9,m01_7x7,m01_6x6,m01_5x5,m01_3x3,m01_1x1;
  wire signed [14:0] m10_2x2,m01_2x2;
  wire signed [15:0] m10_4x4,m01_4x4;
  wire signed [16:0] m10_8x8,m01_8x8;
  
  wire signed [14:0] m10_3x3_tp1;
  wire signed [15:0] m10_5x5_tp1;
  wire signed [15:0] m10_6x6_tp1;
  wire signed [14:0] m10_6x6_tp2;
  wire signed [15:0] m10_7x7_tp1;
  wire signed [14:0] m10_7x7_tp2;
  wire signed [16:0] m10_9x9_tp1;
  wire signed [16:0] m10_10x10_tp1;
  wire signed [14:0] m10_10x10_tp2;
  wire signed [16:0] m10_11x11_tp1;
  wire signed [14:0] m10_11x11_tp2;
  wire signed [16:0] m10_12x12_tp1;
  wire signed [15:0] m10_12x12_tp2;
  wire signed [16:0] m10_13x13_tp1;
  wire signed [15:0] m10_13x13_tp2;
  wire signed [16:0] m10_14x14_tp1;
  wire signed [15:0] m10_14x14_tp2;
  wire signed [14:0] m10_14x14_tp3;
  wire signed [16:0] m10_15x15_tp1;
  wire signed [15:0] m10_15x15_tp2;
  wire signed [14:0] m10_15x15_tp3;
  wire signed [17:0] m10_15x15_tp4;
  wire signed [15:0] m10_15x15_tp5;
  
  
  assign m10_3x3_tp1 = {m10_3,1'b0};
  assign m10_5x5_tp1 = {m10_5,2'b00};
  assign m10_6x6_tp1 = {m10_6,2'b00};
  assign m10_6x6_tp2 = {m10_6,1'b0};
  assign m10_7x7_tp1 = {m10_7,2'b00};
  assign m10_7x7_tp2 = {m10_7,1'b0};
  assign m10_9x9_tp1 = {m10_9,3'b000};
  assign m10_10x10_tp1 = {m10_10,3'b000};
  assign m10_10x10_tp2 = {m10_10,1'b0};
  assign m10_11x11_tp1 = {m10_11,3'b000};
  assign m10_11x11_tp2 = {m10_11,1'b0};
  assign m10_12x12_tp1 = {m10_12,3'b000};
  assign m10_12x12_tp2 = {m10_12,2'b00};
  assign m10_13x13_tp1 = {m10_13,3'b000};
  assign m10_13x13_tp2 = {m10_13,2'b00};
  assign m10_14x14_tp1 = {m10_14,3'b000};
  assign m10_14x14_tp2 = {m10_14,2'b00};
  assign m10_14x14_tp3 = {m10_14,1'b0};
  assign m10_15x15_tp1 = {m10_15,3'b000};
  assign m10_15x15_tp2 = {m10_15,2'b00};
  
assign m10_15x15_tp3 = {m10_15,1'b0};
  
assign m10_15x15_tp4 = m10_15x15_tp1 +  m10_15x15_tp2;
  
assign m10_15x15_tp5 = m10_15x15_tp3 + m10_15;
                      
  assign m10_1x1  =  m10_1;
  assign m10_2x2  = {m10_2,1'b0};
  assign m10_3x3  = m10_3x3_tp1 + m10_3;
  assign m10_4x4  = {m10_4,2'b00};
  assign m10_5x5  = m10_5x5_tp1 + m10_5;
  assign m10_6x6  = m10_6x6_tp1 + m10_6x6_tp2;
  assign m10_7x7  = m10_7x7_tp1 + m10_7x7_tp2 + m10_7;
  assign m10_8x8  = {m10_8,3'b000};
  assign m10_9x9  = m10_9x9_tp1 + m10_9;
  assign m10_10x10 = m10_10x10_tp1 + m10_10x10_tp2;
  assign m10_11x11 = m10_11x11_tp1 + m10_11x11_tp2 + m10_11;
  assign m10_12x12 = m10_12x12_tp1 + m10_12x12_tp2;
  assign m10_13x13 = m10_13x13_tp1 + m10_13x13_tp2 + m10_13;
  assign m10_14x14 = m10_14x14_tp1 + m10_14x14_tp2 + m10_14x14_tp3;
  assign m10_15x15 = m10_15x15_tp4 + m10_15x15_tp5;
  
  
  wire signed [14:0] m01_3x3_tp1;
  wire signed [15:0] m01_5x5_tp1;
  wire signed [15:0] m01_6x6_tp1;
  wire signed [14:0] m01_6x6_tp2;
  wire signed [15:0] m01_7x7_tp1;
  wire signed [14:0] m01_7x7_tp2;
  wire signed [16:0] m01_9x9_tp1;
  wire signed [16:0] m01_10x10_tp1;
  wire signed [14:0] m01_10x10_tp2;
  wire signed [16:0] m01_11x11_tp1;
  wire signed [14:0] m01_11x11_tp2;
  wire signed [16:0] m01_12x12_tp1;
  wire signed [15:0] m01_12x12_tp2;
  wire signed [16:0] m01_13x13_tp1;
  wire signed [15:0] m01_13x13_tp2;
  wire signed [16:0] m01_14x14_tp1;
  wire signed [15:0] m01_14x14_tp2;
  wire signed [14:0] m01_14x14_tp3;
  wire signed [16:0] m01_15x15_tp1;
  wire signed [15:0] m01_15x15_tp2;
  wire signed [14:0] m01_15x15_tp3;
  wire signed [17:0] m01_15x15_tp4;
  wire signed [15:0] m01_15x15_tp5;
  
  
  assign m01_3x3_tp1 = {m01_3,1'b0};
  assign m01_5x5_tp1 = {m01_5,2'b00};
  assign m01_6x6_tp1 = {m01_6,2'b00};
  assign m01_6x6_tp2 = {m01_6,1'b0};
  assign m01_7x7_tp1 = {m01_7,2'b00};
  assign m01_7x7_tp2 = {m01_7,1'b0};
  assign m01_9x9_tp1 = {m01_9,3'b000};
  assign m01_10x10_tp1 = {m01_10,3'b000};
  assign m01_10x10_tp2 = {m01_10,1'b0};
  assign m01_11x11_tp1 = {m01_11,3'b000};
  assign m01_11x11_tp2 = {m01_11,1'b0};
  assign m01_12x12_tp1 = {m01_12,3'b000};
  assign m01_12x12_tp2 = {m01_12,2'b00};
  assign m01_13x13_tp1 = {m01_13,3'b000};
  assign m01_13x13_tp2 = {m01_13,2'b00};
  assign m01_14x14_tp1 = {m01_14,3'b000};
  assign m01_14x14_tp2 = {m01_14,2'b00};
  assign m01_14x14_tp3 = {m01_14,1'b0};
  assign m01_15x15_tp1 = {m01_15,3'b000};
  assign m01_15x15_tp2 = {m01_15,2'b00};
  
assign m01_15x15_tp3 = {m01_15,1'b0};
  
assign m01_15x15_tp4 = m01_15x15_tp1 +  m01_15x15_tp2;
  
assign m01_15x15_tp5 = m01_15x15_tp3 + m01_15;
  
  assign m01_1x1  =  m01_1;
  assign m01_2x2  = {m01_2,1'b0};
  assign m01_3x3  = m01_3x3_tp1 + m01_3;
  assign m01_4x4  = {m01_4,2'b00};
  assign m01_5x5  = m01_5x5_tp1 + m01_5;
  assign m01_6x6  = m01_6x6_tp1 + m01_6x6_tp2;
  assign m01_7x7  = m01_7x7_tp1 + m01_7x7_tp2 + m01_7;
  assign m01_8x8  = {m01_8,3'b000};
  assign m01_9x9  = m01_9x9_tp1 + m01_9;
  assign m01_10x10 = m01_10x10_tp1 + m01_10x10_tp2;
  assign m01_11x11 = m01_11x11_tp1 + m01_11x11_tp2 + m01_11;
  assign m01_12x12 = m01_12x12_tp1 + m01_12x12_tp2;
  assign m01_13x13 = m01_13x13_tp1 + m01_13x13_tp2 + m01_13;
  assign m01_14x14 = m01_14x14_tp1 + m01_14x14_tp2 + m01_14x14_tp3;
  assign m01_15x15 = m01_15x15_tp4 + m01_15x15_tp5;
  
  reg  signed [17:0] m10_101;
  reg  signed [17:0] m10_102;
  reg  signed [17:0] m10_103;
  reg  signed [17:0] m10_104;
  reg  signed [17:0] m10_105;
  reg  signed [17:0] m10_106;
  reg  signed [17:0] m10_107;
  reg  signed [17:0] m10_108 ;
  wire signed [18:0] m10_201;
  wire signed [18:0] m10_202;
  wire signed [18:0] m10_203;
  wire signed [18:0] m10_204;
  reg signed [19:0] m10_301;
  reg signed [19:0] m10_302;
  
  
  
  
  
  
  
  
  
  
  assign m10_201 = m10_101 + m10_102;
  assign m10_202 = m10_103 + m10_104;
  assign m10_203 = m10_105 + m10_106;
  assign m10_204 = m10_107 + m10_108;
  
 
  
  reg  signed [17:0] m01_101;
  reg  signed [17:0] m01_102;
  reg  signed [17:0] m01_103;
  reg  signed [17:0] m01_104;
  reg  signed [17:0] m01_105;
  reg  signed [17:0] m01_106;
  reg  signed [17:0] m01_107;
  reg  signed [17:0] m01_108 ;
  wire signed [18:0] m01_201;
  wire signed [18:0] m01_202;
  wire signed [18:0] m01_203;
  wire signed [18:0] m01_204;
  reg signed [19:0] m01_301;
  reg signed [19:0] m01_302;
  
 
 
 
 
 
 
 
 
  
  assign m01_201 = m01_101 + m01_102;
  assign m01_202 = m01_103 + m01_104;
  assign m01_203 = m01_105 + m01_106;
  assign m01_204 = m01_107 + m01_108;
  
  
  
  
  
  reg [9:0] count;
  reg [9:0] count_tp_1;
  reg [9:0] count_tp_2;
  reg fast;
  reg fast_tp_1;
  reg fast_tp_2;
  reg sel;
  reg sel_tp_1;
  reg sel_tp_2;
  reg start_gb;
  reg [1:0] count_start_gb;
  reg wren;
  
  
  wire [7:0] taps1,taps2,taps3,taps4,taps5,taps6,taps7,taps8,taps9,taps10,taps11,taps12,taps13,taps14,taps15,taps16
         ,taps17,taps18,taps19,taps20,taps21,taps22,taps23,taps24,taps25,taps26,taps27,taps28,taps29,taps30,taps31;
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
             
      
  
  wire [7:0] a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16;
  wire b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16;
  reg [3:0] c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16;
  wire d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16;
  wire fast_or_not;
  
  assign addr_out = (num_fast>0)? num_fast-1'b1 : 14'd0;
  
  wire [8:0] m10_15_101 ;
  wire [8:0] m10_15_102 ;
  wire [8:0] m10_15_103 ;
  wire [8:0] m10_15_104 ;
  wire [8:0] m10_15_105 ;
  wire [8:0] m10_15_106 ;
  wire [8:0] m10_15_107 ;
  wire [8:0] m10_15_108 ;
  wire [9:0] m10_15_201 ;
  wire [9:0] m10_15_202 ;
  wire [9:0] m10_15_203 ;
  wire [9:0] m10_15_204 ;
  reg  [10:0]   m10_15_301; 
  reg  [10:0]   m10_15_302; 
  reg  [10:0]   m10_15_501;
  reg  [10:0]   m10_15_502;
  
   assign m10_15_101 = win16_31 + win15_31;
   assign m10_15_102 = win14_31 + win13_31;
   assign m10_15_103 = win17_31 + win18_31;
   assign m10_15_104 = win19_31;
   assign m10_15_105 =  win16_1 + win15_1;
   assign m10_15_106 =  win14_1 + win13_1;
   assign m10_15_107 =  win17_1 + win18_1;
   assign m10_15_108 =  win19_1;
   
   assign m10_15_201 = m10_15_101 + m10_15_102;
   assign m10_15_202 = m10_15_103 + m10_15_104;
   assign m10_15_203 = m10_15_105 + m10_15_106;
   assign m10_15_204 = m10_15_107 + m10_15_108;
   
   
   
   
   
   wire [8:0] m10_14_101    ;
   wire [8:0] m10_14_102    ;
   wire [8:0] m10_14_103    ;
   wire [8:0] m10_14_104    ;
   wire [8:0] m10_14_105    ;
   wire [8:0] m10_14_106    ;
   wire [8:0] m10_14_107    ;
   wire [8:0] m10_14_108    ;
   wire [8:0] m10_14_109    ;
   wire [8:0] m10_14_110    ;
   wire [8:0] m10_14_111    ;
   wire [8:0] m10_14_112    ;
   wire [8:0] m10_14_113    ;
   wire [8:0] m10_14_114    ;
   wire [9:0] m10_14_201   ;
   wire [9:0] m10_14_202   ;
   wire [9:0] m10_14_203   ;
   wire [9:0] m10_14_204   ;
   wire [9:0] m10_14_205   ;
   wire [9:0] m10_14_206   ;
   wire [9:0] m10_14_207   ;
   wire [9:0] m10_14_208   ;
   reg  [10:0] m10_14_301  ;
   reg  [10:0] m10_14_302  ;
   reg  [10:0] m10_14_303  ;
   reg  [10:0] m10_14_304  ;
   wire [11:0] m10_14_401  ;
   wire [11:0] m10_14_402  ;
   reg  [11:0] m10_14_501;
   reg  [11:0] m10_14_502;
   
   assign m10_14_101 = win16_30 + win15_30;
   assign m10_14_102 = win14_30 + win13_30;
   assign m10_14_103 = win12_30 + win11_30;
   assign m10_14_104 = win10_30 + win17_30;
   assign m10_14_105 = win18_30 + win19_30;
   assign m10_14_106 = win20_30 + win21_30;
   assign m10_14_107 = win22_30;
   assign m10_14_108 = win16_2 + win15_2 ;
   assign m10_14_109 = win14_2 + win13_2 ;
   assign m10_14_110 = win12_2 + win11_2 ;
   assign m10_14_111 = win10_2 + win17_2 ;
   assign m10_14_112 = win18_2 + win19_2 ;
   assign m10_14_113 = win20_2 + win21_2 ;
   assign m10_14_114 = win22_2 ;
  
  
   assign m10_14_201 = m10_14_101 + m10_14_102;
   assign m10_14_202 = m10_14_103 + m10_14_104;
   assign m10_14_203 = m10_14_105 + m10_14_106;
   assign m10_14_204 = m10_14_107;
   assign m10_14_205 = m10_14_108 + m10_14_109;
   assign m10_14_206 = m10_14_110 + m10_14_111;
   assign m10_14_207 = m10_14_112 + m10_14_113;
   assign m10_14_208 = m10_14_114;
   
   
   
   
   
   
   assign m10_14_401 = m10_14_301 + m10_14_302;
   assign m10_14_402 = m10_14_303 + m10_14_304;
   
   
  wire [8:0]  m10_13_101   ;
  wire [8:0]  m10_13_102   ;
  wire [8:0]  m10_13_103   ;
  wire [8:0]  m10_13_104   ;
  wire [8:0]  m10_13_105   ;
  wire [8:0]  m10_13_106   ;
  wire [8:0]  m10_13_107   ;
  wire [8:0]  m10_13_108   ;
  wire [8:0]  m10_13_109   ;
  wire [8:0]  m10_13_110   ;
  wire [8:0]  m10_13_111   ;
  wire [8:0]  m10_13_112   ;
  wire [8:0]  m10_13_113   ;
  wire [8:0]  m10_13_114   ;
  wire [8:0]  m10_13_115   ;
  wire [8:0]  m10_13_116   ;
  wire [8:0]  m10_13_117   ;
  wire [8:0]  m10_13_118   ;
  wire [9:0]  m10_13_201   ;
  wire [9:0]  m10_13_202   ;
  wire [9:0]  m10_13_203   ;
  wire [9:0]  m10_13_204   ;
  wire [9:0]  m10_13_205   ;
  wire [9:0]  m10_13_206   ;
  wire [9:0]  m10_13_207   ;
  wire [9:0]  m10_13_208   ;
  wire [9:0]  m10_13_209   ;
  wire [9:0]  m10_13_210   ;
  reg  [10:0] m10_13_301   ;
  reg  [10:0] m10_13_302   ;
  reg  [10:0] m10_13_303   ;
  reg  [10:0] m10_13_304   ;
  reg  [10:0] m10_13_305   ;
  reg  [10:0] m10_13_306   ;
  wire [11:0] m10_13_401   ;
  wire [11:0] m10_13_402   ;
  wire [11:0] m10_13_403   ;
  wire [11:0] m10_13_404   ;
  reg  [12:0] m10_13_501   ;
  reg  [12:0] m10_13_502   ;
  
  
   assign m10_13_101  =  win16_29 + win15_29   ;
   assign m10_13_102  =  win14_29 + win13_29   ;
   assign m10_13_103  =  win12_29 + win11_29   ;
   assign m10_13_104  =  win10_29 + win9_29    ;
   assign m10_13_105  =  win8_29 + win17_29    ;
   assign m10_13_106  =  win18_29 + win19_29   ;
   assign m10_13_107  =  win20_29 + win21_29   ;
   assign m10_13_108  =  win22_29 + win23_29   ;
   assign m10_13_109  =  win24_29              ;
   assign m10_13_110  =  win16_3 + win15_3     ;
   assign m10_13_111  =  win14_3 + win13_3     ;
   assign m10_13_112  =  win12_3 + win11_3     ;
   assign m10_13_113  =  win10_3 + win9_3      ;
   assign m10_13_114  =  win8_3 + win17_3      ;
   assign m10_13_115  =  win18_3 + win19_3     ;
   assign m10_13_116  =  win20_3 + win21_3     ;
   assign m10_13_117  =   win22_3 + win23_3     ;
   assign m10_13_118  =   win24_3               ;
  
  assign m10_13_201 = m10_13_101 + m10_13_102;
  assign m10_13_202 = m10_13_103 + m10_13_104;
  assign m10_13_203 = m10_13_105 + m10_13_106;
  assign m10_13_204 = m10_13_107 +  m10_13_108;      
  assign m10_13_205 = m10_13_109;
  assign m10_13_206 = m10_13_110 + m10_13_111;
  assign m10_13_207 = m10_13_112 + m10_13_113;
  assign m10_13_208 = m10_13_114 + m10_13_115;
  assign m10_13_209 = m10_13_116 + m10_13_117;
  assign m10_13_210 = m10_13_118 ;
  
  
  
  
  
  
  
  
  assign m10_13_401 = m10_13_301 + m10_13_302;
  assign m10_13_402 = m10_13_303;       
  assign m10_13_403 = m10_13_304 + m10_13_305;
  assign m10_13_404 = m10_13_306;
  
  
  
  
  wire [8:0] m10_12_101  ;
  wire [8:0] m10_12_102  ;
  wire [8:0] m10_12_103  ;
  wire [8:0] m10_12_104  ;
  wire [8:0] m10_12_105  ;
  wire [8:0] m10_12_106  ;
  wire [8:0] m10_12_107  ;
  wire [8:0] m10_12_108  ;
  wire [8:0] m10_12_109  ;
  wire [8:0] m10_12_110  ;
  wire [8:0] m10_12_111  ;
  wire [8:0] m10_12_112  ;
  wire [8:0] m10_12_113  ;
  wire [8:0] m10_12_114  ;
  wire [8:0] m10_12_115  ;
  wire [8:0] m10_12_116  ;
  wire [8:0] m10_12_117  ;
  wire [8:0] m10_12_118  ;
  wire [8:0] m10_12_119  ;
  wire [8:0] m10_12_120  ;
  wire [9:0] m10_12_201  ;
  wire [9:0] m10_12_202  ;
  wire [9:0] m10_12_203  ;
  wire [9:0] m10_12_204  ;
  wire [9:0] m10_12_205  ;
  wire [9:0] m10_12_206  ;
  wire [9:0] m10_12_207  ;
  wire [9:0] m10_12_208  ;
  wire [9:0] m10_12_209  ;
  wire [9:0] m10_12_210  ;
  reg  [10:0] m10_12_301 ;
  reg  [10:0] m10_12_302 ;
  reg  [10:0] m10_12_303 ;
  reg  [10:0] m10_12_304 ;
  reg  [10:0] m10_12_305 ;
  reg  [10:0] m10_12_306 ;
  wire [11:0] m10_12_401 ;
  wire [11:0] m10_12_402 ;
  wire [11:0] m10_12_403 ;
  wire [11:0] m10_12_404 ;
  reg  [12:0] m10_12_501 ;
  reg  [12:0] m10_12_502 ;
  
  
  
  
  
  assign m10_12_101  = win16_28 + win15_28      ;
  assign m10_12_102  = win14_28 + win13_28      ;
  assign m10_12_103  = win12_28 + win11_28      ;
  assign m10_12_104  = win10_28 + win9_28       ;
  assign m10_12_105  = win8_28 + win7_28        ;
  assign m10_12_106  = win17_28 + win18_28      ;
  assign m10_12_107  = win19_28 + win20_28      ;
  assign m10_12_108  = win21_28 + win22_28      ;
  assign m10_12_109  = win23_28 + win24_28      ;
  assign m10_12_110  = win25_28                 ;
  assign m10_12_111  = win16_4 + win15_4        ;
  assign m10_12_112  = win14_4 + win13_4        ;
  assign m10_12_113  = win12_4 + win11_4        ;
  assign m10_12_114  = win10_4 + win9_4         ;
  assign m10_12_115  = win8_4 + win7_4          ;
  assign m10_12_116  = win17_4 + win18_4        ;
  assign m10_12_117  = win19_4 + win20_4        ;
  assign m10_12_118  = win21_4 + win22_4        ;
  assign m10_12_119  = win23_4 + win24_4        ;
  assign m10_12_120  = win25_4                  ;
  
  assign m10_12_201 = m10_12_101 + m10_12_102;
  assign m10_12_202 = m10_12_103 + m10_12_104;
  assign m10_12_203 = m10_12_105 + m10_12_106;
  assign m10_12_204 = m10_12_107 + m10_12_108;
  assign m10_12_205 = m10_12_109 + m10_12_110;       
  assign m10_12_206 = m10_12_111 + m10_12_112;
  assign m10_12_207 = m10_12_113 + m10_12_114;
  assign m10_12_208 = m10_12_115 + m10_12_116;
  assign m10_12_209 = m10_12_117 + m10_12_118;
  assign m10_12_210 = m10_12_119 + m10_12_120 ;
  
  
  
  
  
  
  
  
  assign m10_12_401 = m10_12_301 + m10_12_302;
  assign m10_12_402 = m10_12_303;       
  assign m10_12_403 = m10_12_304 + m10_12_305;
  assign m10_12_404 = m10_12_306;
  
  
  
  
  
  
  wire [8:0] m10_11_101    ;
  wire [8:0] m10_11_102    ;
  wire [8:0] m10_11_103    ;
  wire [8:0] m10_11_104    ;
  wire [8:0] m10_11_105    ;
  wire [8:0] m10_11_106    ;
  wire [8:0] m10_11_107    ;
  wire [8:0] m10_11_108    ;
  wire [8:0] m10_11_109    ;
  wire [8:0] m10_11_110    ;
  wire [8:0] m10_11_111    ;
  wire [8:0] m10_11_112    ;
  wire [8:0] m10_11_113    ;
  wire [8:0] m10_11_114    ;
  wire [8:0] m10_11_115    ;
  wire [8:0] m10_11_116    ;
  wire [8:0] m10_11_117    ;
  wire [8:0] m10_11_118    ;
  wire [8:0] m10_11_119    ;
  wire [8:0] m10_11_120    ;
  wire [8:0] m10_11_121    ;
  wire [8:0] m10_11_122    ;
  wire [9:0] m10_11_201    ;
  wire [9:0] m10_11_202    ;
  wire [9:0] m10_11_203    ;
  wire [9:0] m10_11_204    ;
  wire [9:0] m10_11_205    ;
  wire [9:0] m10_11_206    ;
  wire [9:0] m10_11_207    ;
  wire [9:0] m10_11_208    ;
  wire [9:0] m10_11_209    ;
  wire [9:0] m10_11_210    ;
  wire [9:0] m10_11_211    ;
  wire [9:0] m10_11_212    ;
  reg  [10:0] m10_11_301   ;
  reg  [10:0] m10_11_302   ;
  reg  [10:0] m10_11_303   ;
  reg  [10:0] m10_11_304   ;
  reg  [10:0] m10_11_305   ;
  reg  [10:0] m10_11_306   ;
  wire [11:0] m10_11_401   ;
  wire [11:0] m10_11_402   ;
  wire [11:0] m10_11_403   ;
  wire [11:0] m10_11_404   ;
  reg  [12:0] m10_11_501   ;
  reg  [12:0] m10_11_502   ;
  
  
  
  
  
  assign m10_11_101  = win16_27 + win15_27  ;
  assign m10_11_102  = win14_27 + win13_27  ;
  assign m10_11_103  = win12_27 + win11_27  ;
  assign m10_11_104  = win10_27 + win9_27   ;
  assign m10_11_105  = win8_27 + win7_27    ;
  assign m10_11_106  = win6_27 + win17_27   ;
  assign m10_11_107  = win18_27 + win19_27  ;
  assign m10_11_108  = win20_27 + win21_27  ;
  assign m10_11_109  = win22_27 + win23_27  ;
  assign m10_11_110  = win24_27 + win25_27  ;
  assign m10_11_111  = win26_27             ;
  assign m10_11_112  = win16_5 + win15_5    ;
  assign m10_11_113  = win14_5 + win13_5    ;
  assign m10_11_114  = win12_5 + win11_5    ;
  assign m10_11_115  = win10_5 + win9_5     ;
  assign m10_11_116  = win8_5 + win7_5      ;
  assign m10_11_117  = win6_5 + win17_5     ;
  assign m10_11_118  = win18_5 + win19_5    ;
  assign m10_11_119  = win20_5 + win21_5    ;
  assign m10_11_120  = win22_5 + win23_5    ;
  assign m10_11_121  = win24_5 + win25_5    ;
  assign m10_11_122  = win26_5              ;
   
  assign m10_11_201 = m10_11_101 + m10_11_102; 
  assign m10_11_202 = m10_11_103 + m10_11_104; 
  assign m10_11_203 = m10_11_105 + m10_11_106; 
  assign m10_11_204 = m10_11_107 + m10_11_108; 
  assign m10_11_205 = m10_11_109 + m10_11_110;   
  assign m10_11_206 = m10_11_111 ;
  assign m10_11_207 = m10_11_112 + m10_11_113; 
  assign m10_11_208 = m10_11_114 + m10_11_115; 
  assign m10_11_209 = m10_11_116 + m10_11_117; 
  assign m10_11_210 = m10_11_118 + m10_11_119 ; 
  assign m10_11_211 = m10_11_120 + m10_11_121; 
  assign m10_11_212 = m10_11_122;  
  
   
   
        
   
   
  
  
  assign m10_11_401 = m10_11_301 + m10_11_302;
  assign m10_11_402 = m10_11_303;       
  assign m10_11_403 = m10_11_304 + m10_11_305;
  assign m10_11_404 = m10_11_306;
  
  
  
  
  
  
  
  
  wire [8:0] m10_10_101    ;
  wire [8:0] m10_10_102    ;
  wire [8:0] m10_10_103    ;
  wire [8:0] m10_10_104    ;
  wire [8:0] m10_10_105    ;
  wire [8:0] m10_10_106    ;
  wire [8:0] m10_10_107    ;
  wire [8:0] m10_10_108    ;
  wire [8:0] m10_10_109    ;
  wire [8:0] m10_10_110    ;
  wire [8:0] m10_10_111    ;
  wire [8:0] m10_10_112    ;
  wire [8:0] m10_10_113    ;
  wire [8:0] m10_10_114    ;
  wire [8:0] m10_10_115    ;
  wire [8:0] m10_10_116    ;
  wire [8:0] m10_10_117    ;
  wire [8:0] m10_10_118    ;
  wire [8:0] m10_10_119    ;
  wire [8:0] m10_10_120    ;
  wire [8:0] m10_10_121    ;
  wire [8:0] m10_10_122    ;
  wire [8:0] m10_10_123    ;
  wire [8:0] m10_10_124    ;
  wire [9:0] m10_10_201    ;
  wire [9:0] m10_10_202    ;
  wire [9:0] m10_10_203    ;
  wire [9:0] m10_10_204    ;
  wire [9:0] m10_10_205    ;
  wire [9:0] m10_10_206    ;
  wire [9:0] m10_10_207    ;
  wire [9:0] m10_10_208    ;
  wire [9:0] m10_10_209    ;
  wire [9:0] m10_10_210    ;
  wire [9:0] m10_10_211    ;
  wire [9:0] m10_10_212    ;
  reg  [10:0] m10_10_301   ;
  reg  [10:0] m10_10_302   ;
  reg  [10:0] m10_10_303   ;
  reg  [10:0] m10_10_304   ;
  reg  [10:0] m10_10_305   ;
  reg  [10:0] m10_10_306   ;
  wire [11:0] m10_10_401   ;
  wire [11:0] m10_10_402   ;
  wire [11:0] m10_10_403   ;
  wire [11:0] m10_10_404   ;
  reg  [12:0] m10_10_501   ;
  reg  [12:0] m10_10_502   ;
  
  
  
  
  
  
  
  

  assign m10_10_101  = win16_26 + win15_26    ;
  assign m10_10_102  = win14_26 + win13_26    ;
  assign m10_10_103  = win12_26 + win11_26    ;
  assign m10_10_104  = win10_26 + win9_26     ;
  assign m10_10_105  = win8_26 + win7_26      ;
  assign m10_10_106  = win6_26 + win5_26      ;
  assign m10_10_107  = win17_26 + win18_26    ;
  assign m10_10_108  = win19_26 + win20_26    ;
  assign m10_10_109  = win21_26 + win22_26    ;
  assign m10_10_110  = win23_26 + win24_26    ;
  assign m10_10_111  = win25_26 + win26_26    ;
  assign m10_10_112  = win27_26               ;
  assign m10_10_113  = win16_6 + win15_6      ;
  assign m10_10_114  = win14_6 + win13_6      ;
  assign m10_10_115  = win12_6 + win11_6      ;
  assign m10_10_116  = win10_6 + win9_6       ;
  assign m10_10_117  = win8_6 + win7_6        ;
  assign m10_10_118  = win6_6 + win5_6        ;
  assign m10_10_119  = win17_6 + win18_6      ;
  assign m10_10_120  = win19_6 + win20_6      ;
  assign m10_10_121  = win21_6 + win22_6      ;
  assign m10_10_122  = win23_6 + win24_6      ;
  assign m10_10_123  = win25_6 + win26_6      ;
  assign m10_10_124  = win27_6                ;
  
  assign m10_10_201 = m10_10_101 + m10_10_102; 
  assign m10_10_202 = m10_10_103 + m10_10_104; 
  assign m10_10_203 = m10_10_105 + m10_10_106; 
  assign m10_10_204 = m10_10_107 + m10_10_108; 
  assign m10_10_205 = m10_10_109 + m10_10_110;   
  assign m10_10_206 = m10_10_111 + m10_10_112;      
  assign m10_10_207 = m10_10_113 + m10_10_114; 
  assign m10_10_208 = m10_10_115 + m10_10_116; 
  assign m10_10_209 = m10_10_117 + m10_10_118; 
  assign m10_10_210 = m10_10_119 + m10_10_120 ; 
  assign m10_10_211 = m10_10_121 + m10_10_122; 
  assign m10_10_212 = m10_10_123 + m10_10_124; 

  
  
  assign m10_10_401 = m10_10_301 + m10_10_302;
  assign m10_10_402 = m10_10_303;       
  assign m10_10_403 = m10_10_304 + m10_10_305;
  assign m10_10_404 = m10_10_306;
  
   
   
   
   
   
   
   wire [8:0] m10_9_101    ;
   wire [8:0] m10_9_102    ;
   wire [8:0] m10_9_103    ;
   wire [8:0] m10_9_104    ;
   wire [8:0] m10_9_105    ;
   wire [8:0] m10_9_106    ;
   wire [8:0] m10_9_107    ;
   wire [8:0] m10_9_108    ;
   wire [8:0] m10_9_109    ;
   wire [8:0] m10_9_110    ;
   wire [8:0] m10_9_111    ;
   wire [8:0] m10_9_112    ;
   wire [8:0] m10_9_113    ;
   wire [8:0] m10_9_114    ;
   wire [8:0] m10_9_115    ;
   wire [8:0] m10_9_116    ;
   wire [8:0] m10_9_117    ;
   wire [8:0] m10_9_118    ;
   wire [8:0] m10_9_119    ;
   wire [8:0] m10_9_120    ;
   wire [8:0] m10_9_121    ;
   wire [8:0] m10_9_122    ;
   wire [8:0] m10_9_123    ;
   wire [8:0] m10_9_124    ;
   wire [8:0] m10_9_125    ;
   wire [8:0] m10_9_126    ;
   wire [9:0] m10_9_201    ;
   wire [9:0] m10_9_202    ;
   wire [9:0] m10_9_203    ;
   wire [9:0] m10_9_204    ;
   wire [9:0] m10_9_205    ;
   wire [9:0] m10_9_206    ;
   wire [9:0] m10_9_207    ;
   wire [9:0] m10_9_208    ;
   wire [9:0] m10_9_209    ;
   wire [9:0] m10_9_210    ;
   wire [9:0] m10_9_211    ;
   wire [9:0] m10_9_212    ;
   wire [9:0] m10_9_213    ;
   wire [9:0] m10_9_214    ;
   reg  [10:0] m10_9_301   ;
   reg  [10:0] m10_9_302   ;
   reg  [10:0] m10_9_303   ;
   reg  [10:0] m10_9_304   ;
   reg  [10:0] m10_9_305   ;
   reg  [10:0] m10_9_306   ;
   reg  [10:0] m10_9_307   ;
   reg  [10:0] m10_9_308   ;
   wire [11:0] m10_9_401   ;
   wire [11:0] m10_9_402   ;
   wire [11:0] m10_9_403   ;
   wire [11:0] m10_9_404   ;
   reg  [12:0] m10_9_501   ;
   reg  [12:0] m10_9_502   ;
  
   
   
   
   
   
   
   
   
   


   assign m10_9_101  = win16_25 + win15_25     ;
   assign m10_9_102  = win14_25 + win13_25     ;
   assign m10_9_103  = win12_25 + win11_25     ;
   assign m10_9_104  = win10_25 + win9_25      ;
   assign m10_9_105  = win8_25 + win7_25       ;
   assign m10_9_106  = win6_25 + win5_25       ;
   assign m10_9_107  = win4_25 + win17_25      ;
   assign m10_9_108  = win18_25 + win19_25     ;
   assign m10_9_109  = win20_25 + win21_25     ;
   assign m10_9_110  = win22_25 + win23_25     ;
   assign m10_9_111  = win24_25 + win25_25     ;
   assign m10_9_112  = win26_25 + win27_25     ;
   assign m10_9_113  = win28_25                ;
   assign m10_9_114  = win16_7 + win15_7       ;
   assign m10_9_115  = win14_7 + win13_7       ;
   assign m10_9_116  = win12_7 + win11_7       ;
   assign m10_9_117  = win10_7 + win9_7        ;
   assign m10_9_118  = win8_7 + win7_7         ;
   assign m10_9_119  = win6_7 + win5_7         ;
   assign m10_9_120  = win4_7 + win17_7        ;
   assign m10_9_121  = win18_7 + win19_7       ;
   assign m10_9_122  = win20_7 + win21_7       ;
   assign m10_9_123  = win22_7 + win23_7       ;
   assign m10_9_124  = win24_7 + win25_7       ;
   assign m10_9_125  = win26_7 + win27_7       ;
   assign m10_9_126  = win28_7                 ;
   
   assign m10_9_201 = m10_9_101 + m10_9_102; 
   assign m10_9_202 = m10_9_103 + m10_9_104; 
   assign m10_9_203 = m10_9_105 + m10_9_106; 
   assign m10_9_204 = m10_9_107 + m10_9_108; 
   assign m10_9_205 = m10_9_109 + m10_9_110;  
   assign m10_9_206 = m10_9_111 + m10_9_112;  
   assign m10_9_207 = m10_9_113 ; 
   assign m10_9_208 = m10_9_114 + m10_9_115; 
   assign m10_9_209 = m10_9_116 + m10_9_117; 
   assign m10_9_210 = m10_9_118 + m10_9_119 ; 
   assign m10_9_211 = m10_9_120 + m10_9_121; 
   assign m10_9_212 = m10_9_122 + m10_9_123; 
   assign m10_9_213 = m10_9_124 + m10_9_125; 
   assign m10_9_214 = m10_9_126; 
   
    
  
    
  
  
  
  
  
  
  assign m10_9_401 = m10_9_301 + m10_9_302;
  assign m10_9_402 = m10_9_303 + m10_9_304;     
  assign m10_9_403 = m10_9_305 + m10_9_306;
  assign m10_9_404 = m10_9_307 + m10_9_308;
  
  
  
 
  
  wire [8:0] m10_8_101  ;
  wire [8:0] m10_8_102  ;
  wire [8:0] m10_8_103  ;
  wire [8:0] m10_8_104  ;
  wire [8:0] m10_8_105  ;
  wire [8:0] m10_8_106  ;
  wire [8:0] m10_8_107  ;
  wire [8:0] m10_8_108  ;
  wire [8:0] m10_8_109  ;
  wire [8:0] m10_8_110  ;
  wire [8:0] m10_8_111  ;
  wire [8:0] m10_8_112  ;
  wire [8:0] m10_8_113  ;
  wire [8:0] m10_8_114  ;
  wire [8:0] m10_8_115  ;
  wire [8:0] m10_8_116  ;
  wire [8:0] m10_8_117  ;
  wire [8:0] m10_8_118  ;
  wire [8:0] m10_8_119  ;
  wire [8:0] m10_8_120  ;
  wire [8:0] m10_8_121  ;
  wire [8:0] m10_8_122  ;
  wire [8:0] m10_8_123  ;
  wire [8:0] m10_8_124  ;
  wire [8:0] m10_8_125  ;
  wire [8:0] m10_8_126  ;
  wire [8:0] m10_8_127  ;
  wire [8:0] m10_8_128  ;
  wire [9:0] m10_8_201  ;
  wire [9:0] m10_8_202  ;
  wire [9:0] m10_8_203  ;
  wire [9:0] m10_8_204  ;
  wire [9:0] m10_8_205  ;
  wire [9:0] m10_8_206  ;
  wire [9:0] m10_8_207  ;
  wire [9:0] m10_8_208  ;
  wire [9:0] m10_8_209  ;
  wire [9:0] m10_8_210  ;
  wire [9:0] m10_8_211  ;
  wire [9:0] m10_8_212  ;
  wire [9:0] m10_8_213  ;
  wire [9:0] m10_8_214  ;
  reg  [10:0] m10_8_301 ;
  reg  [10:0] m10_8_302 ;
  reg  [10:0] m10_8_303 ;
  reg  [10:0] m10_8_304 ;
  reg  [10:0] m10_8_305 ;
  reg  [10:0] m10_8_306 ;
  reg  [10:0] m10_8_307 ;
  reg  [10:0] m10_8_308 ;
  wire [11:0] m10_8_401 ;
  wire [11:0] m10_8_402 ;
  wire [11:0] m10_8_403 ;
  wire [11:0] m10_8_404 ;
  reg  [12:0] m10_8_501 ;
  reg  [12:0] m10_8_502 ;
  
  
  
  


   assign m10_8_101  = win16_24 + win15_24  ;
   assign m10_8_102  = win14_24 + win13_24  ;
   assign m10_8_103  = win12_24 + win11_24  ;
   assign m10_8_104  = win10_24 + win9_24   ;
   assign m10_8_105  = win8_24 + win7_24    ;
   assign m10_8_106  = win6_24 + win5_24    ;
   assign m10_8_107  = win4_24 + win3_24    ;
   assign m10_8_108  = win17_24 + win18_24  ;
   assign m10_8_109  = win19_24 + win20_24  ;
   assign m10_8_110  = win21_24 + win22_24  ;
   assign m10_8_111  = win23_24 + win24_24  ;
   assign m10_8_112  = win25_24 + win26_24  ;
   assign m10_8_113  = win27_24 + win28_24  ;
   assign m10_8_114  = win29_24             ;
   assign m10_8_115  = win16_8 + win15_8    ;
   assign m10_8_116  = win14_8 + win13_8    ;
   assign m10_8_117  = win12_8 + win11_8    ;
   assign m10_8_118  = win10_8 + win9_8     ;
   assign m10_8_119  = win8_8 + win7_8      ;
   assign m10_8_120  = win6_8 + win5_8      ;
   assign m10_8_121  = win4_8 + win3_8      ;
   assign m10_8_122  = win17_8 + win18_8    ;
   assign m10_8_123  = win19_8 + win20_8    ;
   assign m10_8_124  = win21_8 + win22_8    ;
   assign m10_8_125  = win23_8 + win24_8    ;
   assign m10_8_126  = win25_8 + win26_8    ;
   assign m10_8_127  = win27_8 + win28_8             ;
   assign m10_8_128  = win29_8 ; 
   
   assign m10_8_201 = m10_8_101 + m10_8_102; 
   assign m10_8_202 = m10_8_103 + m10_8_104; 
   assign m10_8_203 = m10_8_105 + m10_8_106; 
   assign m10_8_204 = m10_8_107 + m10_8_108; 
   assign m10_8_205 = m10_8_109 + m10_8_110;  
   assign m10_8_206 = m10_8_111 + m10_8_112;  
   assign m10_8_207 = m10_8_113 + m10_8_114;    
   assign m10_8_208 = m10_8_115 + m10_8_116; 
   assign m10_8_209 = m10_8_117 + m10_8_118; 
   assign m10_8_210 = m10_8_119 + m10_8_120 ; 
   assign m10_8_211 = m10_8_121 + m10_8_122; 
   assign m10_8_212 = m10_8_123 + m10_8_124; 
   assign m10_8_213 = m10_8_125 + m10_8_126; 
   assign m10_8_214 = m10_8_127 + m10_8_128;
   
     
   
     
  
   
  
  
  
  
  assign m10_8_401 = m10_8_301 + m10_8_302;
  assign m10_8_402 = m10_8_303 + m10_8_304;     
  assign m10_8_403 = m10_8_305 + m10_8_306;
  assign m10_8_404 = m10_8_307 + m10_8_308;
  
  
  
  
  
  wire [8:0] m10_7_101  ;
  wire [8:0] m10_7_102  ;
  wire [8:0] m10_7_103  ;
  wire [8:0] m10_7_104  ;
  wire [8:0] m10_7_105  ;
  wire [8:0] m10_7_106  ;
  wire [8:0] m10_7_107  ;
  wire [8:0] m10_7_108  ;
  wire [8:0] m10_7_109  ;
  wire [8:0] m10_7_110  ;
  wire [8:0] m10_7_111  ;
  wire [8:0] m10_7_112  ;
  wire [8:0] m10_7_113  ;
  wire [8:0] m10_7_114  ;
  wire [8:0] m10_7_115  ;
  wire [8:0] m10_7_116  ;
  wire [8:0] m10_7_117  ;
  wire [8:0] m10_7_118  ;
  wire [8:0] m10_7_119  ;
  wire [8:0] m10_7_120  ;
  wire [8:0] m10_7_121  ;
  wire [8:0] m10_7_122  ;
  wire [8:0] m10_7_123  ;
  wire [8:0] m10_7_124  ;
  wire [8:0] m10_7_125  ;
  wire [8:0] m10_7_126  ;
  wire [8:0] m10_7_127  ;
  wire [8:0] m10_7_128  ;
  wire [9:0] m10_7_201  ;
  wire [9:0] m10_7_202  ;
  wire [9:0] m10_7_203  ;
  wire [9:0] m10_7_204  ;
  wire [9:0] m10_7_205  ;
  wire [9:0] m10_7_206  ;
  wire [9:0] m10_7_207  ;
  wire [9:0] m10_7_208  ;
  wire [9:0] m10_7_209  ;
  wire [9:0] m10_7_210  ;
  wire [9:0] m10_7_211  ;
  wire [9:0] m10_7_212  ;
  wire [9:0] m10_7_213  ;
  wire [9:0] m10_7_214  ;
  reg  [10:0] m10_7_301 ;
  reg  [10:0] m10_7_302 ;
  reg  [10:0] m10_7_303 ;
  reg  [10:0] m10_7_304 ;
  reg  [10:0] m10_7_305 ;
  reg  [10:0] m10_7_306 ;
  reg  [10:0] m10_7_307 ;
  reg  [10:0] m10_7_308 ;
  wire [11:0] m10_7_401 ;
  wire [11:0] m10_7_402 ;
  wire [11:0] m10_7_403 ;
  wire [11:0] m10_7_404 ;
  reg  [12:0] m10_7_501 ;
  reg  [12:0] m10_7_502 ;
 
  assign m10_7_101  = win16_23 + win15_23  ;
  assign m10_7_102  = win14_23 + win13_23  ; 
  assign m10_7_103  = win12_23 + win11_23  ; 
  assign m10_7_104  = win10_23 + win9_23   ; 
  assign m10_7_105  = win8_23 + win7_23    ; 
  assign m10_7_106  = win6_23 + win5_23    ; 
  assign m10_7_107  = win4_23 + win3_23    ; 
  assign m10_7_108  = win17_23 + win18_23  ; 
  assign m10_7_109  = win19_23 + win20_23  ; 
  assign m10_7_110  = win21_23 + win22_23  ; 
  assign m10_7_111  = win23_23 + win24_23  ; 
  assign m10_7_112  = win25_23 + win26_23  ; 
  assign m10_7_113  = win27_23 + win28_23  ; 
  assign m10_7_114  = win29_23             ; 
  assign m10_7_115  = win16_9 + win15_9    ; 
  assign m10_7_116  = win14_9 + win13_9    ; 
  assign m10_7_117  = win12_9 + win11_9    ; 
  assign m10_7_118  = win10_9 + win9_9    ; 
  assign m10_7_119  = win8_9 + win7_9      ; 
  assign m10_7_120  = win6_9 + win5_9      ; 
  assign m10_7_121  = win4_9 + win3_9      ; 
  assign m10_7_122  = win17_9 + win18_9    ;
  assign m10_7_123  = win19_9 + win20_9    ;
  assign m10_7_124  = win21_9 + win22_9    ;
  assign m10_7_125  = win23_9 + win24_9    ;
  assign m10_7_126  = win25_9 + win26_9    ;
  assign m10_7_127  = win27_9 + win28_9             ;
  assign m10_7_128  = win29_9 ; 
  
   assign m10_7_201 = m10_7_101 + m10_7_102; 
   assign m10_7_202 = m10_7_103 + m10_7_104; 
   assign m10_7_203 = m10_7_105 + m10_7_106; 
   assign m10_7_204 = m10_7_107 + m10_7_108; 
   assign m10_7_205 = m10_7_109 + m10_7_110;  
   assign m10_7_206 = m10_7_111 + m10_7_112;  
   assign m10_7_207 = m10_7_113 + m10_7_114;    
   assign m10_7_208 = m10_7_115 + m10_7_116; 
   assign m10_7_209 = m10_7_117 + m10_7_118; 
   assign m10_7_210 = m10_7_119 + m10_7_120 ; 
   assign m10_7_211 = m10_7_121 + m10_7_122; 
   assign m10_7_212 = m10_7_123 + m10_7_124; 
   assign m10_7_213 = m10_7_125 + m10_7_126; 
   assign m10_7_214 = m10_7_127 + m10_7_128;
   
     
   
     
  
   
  
  
  
  
  assign m10_7_401 = m10_7_301 + m10_7_302;
  assign m10_7_402 = m10_7_303 + m10_7_304;     
  assign m10_7_403 = m10_7_305 + m10_7_306;
  assign m10_7_404 = m10_7_307 + m10_7_308;
  
 
             
  
  
  
  
  wire [8:0] m10_6_101     ;
  wire [8:0] m10_6_102     ;
  wire [8:0] m10_6_103     ;
  wire [8:0] m10_6_104     ;
  wire [8:0] m10_6_105     ;
  wire [8:0] m10_6_106     ;
  wire [8:0] m10_6_107     ;
  wire [8:0] m10_6_108     ;
  wire [8:0] m10_6_109     ;
  wire [8:0] m10_6_110     ;
  wire [8:0] m10_6_111     ;
  wire [8:0] m10_6_112     ;
  wire [8:0] m10_6_113     ;
  wire [8:0] m10_6_114     ;
  wire [8:0] m10_6_115     ;
  wire [8:0] m10_6_116     ;
  wire [8:0] m10_6_117     ;
  wire [8:0] m10_6_118     ;
  wire [8:0] m10_6_119     ;
  wire [8:0] m10_6_120     ;
  wire [8:0] m10_6_121     ;
  wire [8:0] m10_6_122     ;
  wire [8:0] m10_6_123     ;
  wire [8:0] m10_6_124     ;
  wire [8:0] m10_6_125     ;
  wire [8:0] m10_6_126     ;
  wire [8:0] m10_6_127     ;
  wire [8:0] m10_6_128     ;
  wire [8:0] m10_6_129     ;
  wire [8:0] m10_6_130     ;
  wire [9:0] m10_6_201     ;
  wire [9:0] m10_6_202     ;
  wire [9:0] m10_6_203     ;
  wire [9:0] m10_6_204     ;
  wire [9:0] m10_6_205     ;
  wire [9:0] m10_6_206     ;
  wire [9:0] m10_6_207     ;
  wire [9:0] m10_6_208     ;
  wire [9:0] m10_6_209     ;
  wire [9:0] m10_6_210     ;
  wire [9:0] m10_6_211     ;
  wire [9:0] m10_6_212     ;
  wire [9:0] m10_6_213     ;
  wire [9:0] m10_6_214     ;
  wire [9:0] m10_6_215     ;
  wire [9:0] m10_6_216     ;
  reg  [10:0] m10_6_301    ;
  reg  [10:0] m10_6_302    ;
  reg  [10:0] m10_6_303    ;
  reg  [10:0] m10_6_304    ;
  reg  [10:0] m10_6_305    ;
  reg  [10:0] m10_6_306    ;
  reg  [10:0] m10_6_307    ;
  reg  [10:0] m10_6_308    ;
  wire [11:0] m10_6_401    ;
  wire [11:0] m10_6_402    ;
  wire [11:0] m10_6_403    ;
  wire [11:0] m10_6_404    ;
  reg  [12:0] m10_6_501    ;
  reg  [12:0] m10_6_502    ;
  
  
  
  
  
  assign m10_6_101  = win16_22 + win15_22   ;
  assign m10_6_102  = win14_22 + win13_22   ;
  assign m10_6_103  = win12_22 + win11_22   ;
  assign m10_6_104  = win10_22 + win9_22    ;
  assign m10_6_105  = win8_22 + win7_22     ;
  assign m10_6_106  = win6_22 + win5_22     ;
  assign m10_6_107  = win4_22 + win3_22     ;
  assign m10_6_108  = win2_22 + win17_22    ;
  assign m10_6_109  = win18_22 + win19_22   ;
  assign m10_6_110  = win20_22 + win21_22   ;
  assign m10_6_111  = win22_22 + win23_22   ;
  assign m10_6_112  = win24_22 + win25_22   ;
  assign m10_6_113  = win26_22 + win27_22   ;
  assign m10_6_114  = win28_22 + win29_22   ;
  assign m10_6_115  = win30_22              ;
  assign m10_6_116  = win16_10 + win15_10   ;
  assign m10_6_117  = win14_10 + win13_10   ;
  assign m10_6_118  = win12_10 + win11_10   ;
  assign m10_6_119  = win10_10 + win9_10    ;
  assign m10_6_120  = win8_10 + win7_10     ;
  assign m10_6_121  = win6_10 + win5_10     ;
  assign m10_6_122  = win4_10 + win3_10     ;
  assign m10_6_123  = win2_10 + win17_10    ;
  assign m10_6_124  = win18_10 + win19_10   ;
  assign m10_6_125  = win20_10 + win21_10   ;
  assign m10_6_126  = win22_10 + win23_10   ;
  assign m10_6_127  = win24_10 + win25_10   ;
  assign m10_6_128  = win26_10 + win27_10   ;
  assign m10_6_129  = win28_10 + win29_10   ;
  assign m10_6_130  = win30_10              ;
   
   assign m10_6_201 = m10_6_101 + m10_6_102; 
   assign m10_6_202 = m10_6_103 + m10_6_104; 
   assign m10_6_203 = m10_6_105 + m10_6_106; 
   assign m10_6_204 = m10_6_107 + m10_6_108; 
   assign m10_6_205 = m10_6_109 + m10_6_110;  
   assign m10_6_206 = m10_6_111 + m10_6_112;  
   assign m10_6_207 = m10_6_113 + m10_6_114;    
   assign m10_6_208 = m10_6_115 ; 
   assign m10_6_209 = m10_6_116 + m10_6_117; 
   assign m10_6_210 = m10_6_118 + m10_6_119 ; 
   assign m10_6_211 = m10_6_120 + m10_6_121; 
   assign m10_6_212 = m10_6_122 + m10_6_123; 
   assign m10_6_213 = m10_6_124 + m10_6_125; 
   assign m10_6_214 = m10_6_126 + m10_6_127;
   assign m10_6_215 = m10_6_128 + m10_6_129;
   assign m10_6_216 = m10_6_130 ;
  
  
   
  assign m10_6_401 = m10_6_301 + m10_6_302;
  assign m10_6_402 = m10_6_303 + m10_6_304;     
  assign m10_6_403 = m10_6_305 + m10_6_306;
  assign m10_6_404 = m10_6_307 + m10_6_308;
  
  
                                     
  
  
  
  wire [8:0] m10_5_101     ;
  wire [8:0] m10_5_102     ;
  wire [8:0] m10_5_103     ;
  wire [8:0] m10_5_104     ;
  wire [8:0] m10_5_105     ;
  wire [8:0] m10_5_106     ;
  wire [8:0] m10_5_107     ;
  wire [8:0] m10_5_108     ;
  wire [8:0] m10_5_109     ;
  wire [8:0] m10_5_110     ;
  wire [8:0] m10_5_111     ;
  wire [8:0] m10_5_112     ;
  wire [8:0] m10_5_113     ;
  wire [8:0] m10_5_114     ;
  wire [8:0] m10_5_115     ;
  wire [8:0] m10_5_116     ;
  wire [8:0] m10_5_117     ;
  wire [8:0] m10_5_118     ;
  wire [8:0] m10_5_119     ;
  wire [8:0] m10_5_120     ;
  wire [8:0] m10_5_121     ;
  wire [8:0] m10_5_122     ;
  wire [8:0] m10_5_123     ;
  wire [8:0] m10_5_124     ;
  wire [8:0] m10_5_125     ;
  wire [8:0] m10_5_126     ;
  wire [8:0] m10_5_127     ;
  wire [8:0] m10_5_128     ;
  wire [8:0] m10_5_129     ;
  wire [8:0] m10_5_130     ;
  wire [9:0] m10_5_201     ;
  wire [9:0] m10_5_202     ;
  wire [9:0] m10_5_203     ;
  wire [9:0] m10_5_204     ;
  wire [9:0] m10_5_205     ;
  wire [9:0] m10_5_206     ;
  wire [9:0] m10_5_207     ;
  wire [9:0] m10_5_208     ;
  wire [9:0] m10_5_209     ;
  wire [9:0] m10_5_210     ;
  wire [9:0] m10_5_211     ;
  wire [9:0] m10_5_212     ;
  wire [9:0] m10_5_213     ;
  wire [9:0] m10_5_214     ;
  wire [9:0] m10_5_215     ;
  wire [9:0] m10_5_216     ;
  reg  [10:0] m10_5_301    ;
  reg  [10:0] m10_5_302    ;
  reg  [10:0] m10_5_303    ;
  reg  [10:0] m10_5_304    ; 
  reg  [10:0] m10_5_305    ; 
  reg  [10:0] m10_5_306    ; 
  reg  [10:0] m10_5_307    ;
  reg  [10:0] m10_5_308    ;
  wire [11:0] m10_5_401    ;
  wire [11:0] m10_5_402    ;
  wire [11:0] m10_5_403    ;
  wire [11:0] m10_5_404    ;
  reg  [12:0] m10_5_501    ;
  reg  [12:0] m10_5_502    ;
  
  
  
  
  
  assign m10_5_101  = win16_21 + win15_21   ;
  assign m10_5_102  = win14_21 + win13_21   ;
  assign m10_5_103  = win12_21 + win11_21   ;
  assign m10_5_104  = win10_21 + win9_21    ;
  assign m10_5_105  = win8_21 + win7_21     ;
  assign m10_5_106  = win6_21 + win5_21     ;
  assign m10_5_107  = win4_21 + win3_21     ;
  assign m10_5_108  = win2_21 + win17_21    ;
  assign m10_5_109  = win18_21 + win19_21   ;
  assign m10_5_110  = win20_21 + win21_21   ;
  assign m10_5_111  = win22_21 + win23_21   ;
  assign m10_5_112  = win24_21 + win25_21   ;
  assign m10_5_113  = win26_21 + win27_21   ;
  assign m10_5_114  = win28_21 + win29_21   ;
  assign m10_5_115  = win30_21              ;
  assign m10_5_116  = win16_11 + win15_11   ;
  assign m10_5_117  = win14_11 + win13_11   ;
  assign m10_5_118  = win12_11 + win11_11   ;
  assign m10_5_119  = win10_11 + win9_11    ;
  assign m10_5_120  = win8_11 + win7_11     ;
  assign m10_5_121  = win6_11 + win5_11     ;
  assign m10_5_122  = win4_11 + win3_11     ;
  assign m10_5_123  = win2_11 + win17_11    ;
  assign m10_5_124  = win18_11 + win19_11   ;
  assign m10_5_125  = win20_11 + win21_11   ;
  assign m10_5_126  = win22_11 + win23_11   ;
  assign m10_5_127  = win24_11 + win25_11   ;
  assign m10_5_128  = win26_11 + win27_11   ;
  assign m10_5_129  = win28_11 + win29_11   ;
  assign m10_5_130  = win30_11              ;
   
   assign m10_5_201 = m10_5_101 + m10_5_102; 
   assign m10_5_202 = m10_5_103 + m10_5_104; 
   assign m10_5_203 = m10_5_105 + m10_5_106; 
   assign m10_5_204 = m10_5_107 + m10_5_108; 
   assign m10_5_205 = m10_5_109 + m10_5_110;  
   assign m10_5_206 = m10_5_111 + m10_5_112;  
   assign m10_5_207 = m10_5_113 + m10_5_114;    
   assign m10_5_208 = m10_5_115 ;     
   assign m10_5_209 = m10_5_116 + m10_5_117; 
   assign m10_5_210 = m10_5_118 + m10_5_119 ; 
   assign m10_5_211 = m10_5_120 + m10_5_121; 
   assign m10_5_212 = m10_5_122 + m10_5_123; 
   assign m10_5_213 = m10_5_124 + m10_5_125; 
   assign m10_5_214 = m10_5_126 + m10_5_127;
   assign m10_5_215 = m10_5_128 + m10_5_129;
   assign m10_5_216 = m10_5_130 ;     
                                      
  
                                      
  assign m10_5_401 = m10_5_301 + m10_5_302;
  assign m10_5_402 = m10_5_303 + m10_5_304;     
  assign m10_5_403 = m10_5_305 + m10_5_306;
  assign m10_5_404 = m10_5_307 + m10_5_308;
  
  
                                     
  
  
  
  wire [8:0] m10_4_101     ;
  wire [8:0] m10_4_102     ;
  wire [8:0] m10_4_103     ;
  wire [8:0] m10_4_104     ;
  wire [8:0] m10_4_105     ;
  wire [8:0] m10_4_106     ;
  wire [8:0] m10_4_107     ;
  wire [8:0] m10_4_108     ;
  wire [8:0] m10_4_109     ;
  wire [8:0] m10_4_110     ;
  wire [8:0] m10_4_111     ;
  wire [8:0] m10_4_112     ;
  wire [8:0] m10_4_113     ;
  wire [8:0] m10_4_114     ;
  wire [8:0] m10_4_115     ;
  wire [8:0] m10_4_116     ;
  wire [8:0] m10_4_117     ;
  wire [8:0] m10_4_118     ;
  wire [8:0] m10_4_119     ;
  wire [8:0] m10_4_120     ;
  wire [8:0] m10_4_121     ;
  wire [8:0] m10_4_122     ;
  wire [8:0] m10_4_123     ;
  wire [8:0] m10_4_124     ;
  wire [8:0] m10_4_125     ;
  wire [8:0] m10_4_126     ;
  wire [8:0] m10_4_127     ;
  wire [8:0] m10_4_128     ;
  wire [8:0] m10_4_129     ;
  wire [8:0] m10_4_130     ;
  wire [9:0] m10_4_201     ;
  wire [9:0] m10_4_202     ;
  wire [9:0] m10_4_203     ;
  wire [9:0] m10_4_204     ;
  wire [9:0] m10_4_205     ;
  wire [9:0] m10_4_206     ;
  wire [9:0] m10_4_207     ;
  wire [9:0] m10_4_208     ;
  wire [9:0] m10_4_209     ;
  wire [9:0] m10_4_210     ;
  wire [9:0] m10_4_211     ;
  wire [9:0] m10_4_212     ;
  wire [9:0] m10_4_213     ;
  wire [9:0] m10_4_214     ;
  wire [9:0] m10_4_215     ;
  wire [9:0] m10_4_216     ;
  reg  [10:0] m10_4_301    ;
  reg  [10:0] m10_4_302    ;
  reg  [10:0] m10_4_303    ;
  reg  [10:0] m10_4_304    ; 
  reg  [10:0] m10_4_305    ; 
  reg  [10:0] m10_4_306    ; 
  reg  [10:0] m10_4_307    ;
  reg  [10:0] m10_4_308    ;
  wire [11:0] m10_4_401    ;
  wire [11:0] m10_4_402    ;
  wire [11:0] m10_4_403    ;
  wire [11:0] m10_4_404    ;
  reg  [12:0] m10_4_501    ;
  reg  [12:0] m10_4_502    ;
  
  
  
  
  
  assign m10_4_101  = win16_20 + win15_20   ;
  assign m10_4_102  = win14_20 + win13_20   ;
  assign m10_4_103  = win12_20 + win11_20   ;
  assign m10_4_104  = win10_20 + win9_20    ;
  assign m10_4_105  = win8_20 + win7_20     ;
  assign m10_4_106  = win6_20 + win5_20     ;
  assign m10_4_107  = win4_20 + win3_20     ;
  assign m10_4_108  = win2_20 + win17_20    ;
  assign m10_4_109  = win18_20 + win19_20   ;
  assign m10_4_110  = win20_20 + win21_20   ;
  assign m10_4_111  = win22_20 + win23_20   ;
  assign m10_4_112  = win24_20 + win25_20   ;
  assign m10_4_113  = win26_20 + win27_20   ;
  assign m10_4_114  = win28_20 + win29_20   ;
  assign m10_4_115  = win30_20              ;
  assign m10_4_116  = win16_12 + win15_12   ;
  assign m10_4_117  = win14_12 + win13_12   ;
  assign m10_4_118  = win12_12 + win11_12   ;
  assign m10_4_119  = win10_12 + win9_12    ;
  assign m10_4_120  = win8_12 + win7_12     ;
  assign m10_4_121  = win6_12 + win5_12     ;
  assign m10_4_122  = win4_12 + win3_12     ;
  assign m10_4_123  = win2_12 + win17_12    ;
  assign m10_4_124  = win18_12 + win19_12   ;
  assign m10_4_125  = win20_12 + win21_12   ;
  assign m10_4_126  = win22_12 + win23_12   ;
  assign m10_4_127  = win24_12 + win25_12   ;
  assign m10_4_128  = win26_12 + win27_12   ;
  assign m10_4_129  = win28_12 + win29_12   ;
  assign m10_4_130  = win30_12              ;
   
   assign m10_4_201 = m10_4_101 + m10_4_102; 
   assign m10_4_202 = m10_4_103 + m10_4_104; 
   assign m10_4_203 = m10_4_105 + m10_4_106; 
   assign m10_4_204 = m10_4_107 + m10_4_108; 
   assign m10_4_205 = m10_4_109 + m10_4_110;  
   assign m10_4_206 = m10_4_111 + m10_4_112;  
   assign m10_4_207 = m10_4_113 + m10_4_114;    
   assign m10_4_208 = m10_4_115 ;     
   assign m10_4_209 = m10_4_116 + m10_4_117; 
   assign m10_4_210 = m10_4_118 + m10_4_119 ; 
   assign m10_4_211 = m10_4_120 + m10_4_121; 
   assign m10_4_212 = m10_4_122 + m10_4_123; 
   assign m10_4_213 = m10_4_124 + m10_4_125; 
   assign m10_4_214 = m10_4_126 + m10_4_127;
   assign m10_4_215 = m10_4_128 + m10_4_129;
   assign m10_4_216 = m10_4_130 ;     
                                      
     
   
   
     
   
   
   
   
                                      
  assign m10_4_401 = m10_4_301 + m10_4_302;
  assign m10_4_402 = m10_4_303 + m10_4_304;     
  assign m10_4_403 = m10_4_305 + m10_4_306;
  assign m10_4_404 = m10_4_307 + m10_4_308;
  
  
                                     
  
  
  
  wire [8:0] m10_3_101     ;
  wire [8:0] m10_3_102     ;
  wire [8:0] m10_3_103     ;
  wire [8:0] m10_3_104     ;
  wire [8:0] m10_3_105     ;
  wire [8:0] m10_3_106     ;
  wire [8:0] m10_3_107     ;
  wire [8:0] m10_3_108     ;
  wire [8:0] m10_3_109     ;
  wire [8:0] m10_3_110     ;
  wire [8:0] m10_3_111     ;
  wire [8:0] m10_3_112     ;
  wire [8:0] m10_3_113     ;
  wire [8:0] m10_3_114     ;
  wire [8:0] m10_3_115     ;
  wire [8:0] m10_3_116     ;
  wire [8:0] m10_3_117     ;
  wire [8:0] m10_3_118     ;
  wire [8:0] m10_3_119     ;
  wire [8:0] m10_3_120     ;
  wire [8:0] m10_3_121     ;
  wire [8:0] m10_3_122     ;
  wire [8:0] m10_3_123     ;
  wire [8:0] m10_3_124     ;
  wire [8:0] m10_3_125     ;
  wire [8:0] m10_3_126     ;
  wire [8:0] m10_3_127     ;
  wire [8:0] m10_3_128     ;
  wire [8:0] m10_3_129     ;
  wire [8:0] m10_3_130     ;
  wire [8:0] m10_3_131     ;
  wire [8:0] m10_3_132     ;
  wire [9:0] m10_3_201     ;
  wire [9:0] m10_3_202     ;
  wire [9:0] m10_3_203     ;
  wire [9:0] m10_3_204     ;
  wire [9:0] m10_3_205     ;
  wire [9:0] m10_3_206     ;
  wire [9:0] m10_3_207     ;
  wire [9:0] m10_3_208     ;
  wire [9:0] m10_3_209     ;
  wire [9:0] m10_3_210     ;
  wire [9:0] m10_3_211     ;
  wire [9:0] m10_3_212     ;
  wire [9:0] m10_3_213     ;
  wire [9:0] m10_3_214     ;
  wire [9:0] m10_3_215     ;
  wire [9:0] m10_3_216     ;
  reg  [10:0] m10_3_301    ;
  reg  [10:0] m10_3_302    ;
  reg  [10:0] m10_3_303    ;
  reg  [10:0] m10_3_304    ; 
  reg  [10:0] m10_3_305    ; 
  reg  [10:0] m10_3_306    ; 
  reg  [10:0] m10_3_307    ;
  reg  [10:0] m10_3_308    ;
  wire [11:0] m10_3_401    ;
  wire [11:0] m10_3_402    ;
  wire [11:0] m10_3_403    ;
  wire [11:0] m10_3_404    ;
  reg  [12:0] m10_3_501    ;
  reg  [12:0] m10_3_502    ;
  
  
 
  assign m10_3_101  = win16_19 + win15_19  ;
  assign m10_3_102  = win14_19 + win13_19  ;
  assign m10_3_103  = win12_19 + win11_19  ;
  assign m10_3_104  = win10_19 + win9_19   ;
  assign m10_3_105  = win8_19 + win7_19    ;
  assign m10_3_106  = win6_19 + win5_19    ;
  assign m10_3_107  = win4_19 + win3_19    ;
  assign m10_3_108  = win2_19 + win1_19    ;
  assign m10_3_109  = win17_19 + win18_19  ;
  assign m10_3_110  = win19_19 + win20_19  ;
  assign m10_3_111  = win21_19 + win22_19  ;
  assign m10_3_112  = win23_19 + win24_19  ;
  assign m10_3_113  = win25_19 + win26_19  ;
  assign m10_3_114  = win27_19 + win28_19  ;
  assign m10_3_115  = win29_19 + win30_19  ;
  assign m10_3_116  = win31_19             ;
  assign m10_3_117  = win16_13 + win15_13  ;
  assign m10_3_118  = win14_13 + win13_13  ;
  assign m10_3_119  = win12_13 + win11_13  ;
  assign m10_3_120  = win10_13 + win9_13   ;
  assign m10_3_121  = win8_13 + win7_13    ;
  assign m10_3_122  = win6_13 + win5_13    ;
  assign m10_3_123  = win4_13 + win3_13    ;
  assign m10_3_124  = win2_13 + win1_13    ;
  assign m10_3_125  = win17_13 + win18_13  ;
  assign m10_3_126  = win19_13 + win20_13  ;
  assign m10_3_127  = win21_13 + win22_13  ;
  assign m10_3_128  = win23_13 + win24_13  ;
  assign m10_3_129  = win25_13 + win26_13  ;
  assign m10_3_130  = win27_13 + win28_13  ;
  assign m10_3_131  = win29_13 + win30_13  ;
  assign m10_3_132  = win31_13             ;
  
  assign m10_3_201 = m10_3_101 + m10_3_102; 
  assign m10_3_202 = m10_3_103 + m10_3_104; 
  assign m10_3_203 = m10_3_105 + m10_3_106; 
  assign m10_3_204 = m10_3_107 + m10_3_108; 
  assign m10_3_205 = m10_3_109 + m10_3_110; 
  assign m10_3_206 = m10_3_111 + m10_3_112; 
  assign m10_3_207 = m10_3_113 + m10_3_114; 
  assign m10_3_208 = m10_3_115 + m10_3_116;    
  assign m10_3_209 = m10_3_117 + m10_3_118; 
  assign m10_3_210 = m10_3_119 + m10_3_120 ;
  assign m10_3_211 = m10_3_121 + m10_3_122; 
  assign m10_3_212 = m10_3_123 + m10_3_124; 
  assign m10_3_213 = m10_3_125 + m10_3_126; 
  assign m10_3_214 = m10_3_127 + m10_3_128;
  assign m10_3_215 = m10_3_129 + m10_3_130;
  assign m10_3_216 = m10_3_131 + m10_3_132; 

      
   
    
      
   
   
   
   

   assign m10_3_401 = m10_3_301 + m10_3_302;   
   assign m10_3_402 = m10_3_303 + m10_3_304;  
   assign m10_3_403 = m10_3_305 + m10_3_306;
   assign m10_3_404 = m10_3_307 + m10_3_308;
              
   
                                    
   
   
  wire [8:0] m10_2_101     ;
  wire [8:0] m10_2_102     ;
  wire [8:0] m10_2_103     ;
  wire [8:0] m10_2_104     ;
  wire [8:0] m10_2_105     ;
  wire [8:0] m10_2_106     ;
  wire [8:0] m10_2_107     ;
  wire [8:0] m10_2_108     ;
  wire [8:0] m10_2_109     ;
  wire [8:0] m10_2_110     ;
  wire [8:0] m10_2_111     ;
  wire [8:0] m10_2_112     ;
  wire [8:0] m10_2_113     ;
  wire [8:0] m10_2_114     ;
  wire [8:0] m10_2_115     ;
  wire [8:0] m10_2_116     ;
  wire [8:0] m10_2_117     ;
  wire [8:0] m10_2_118     ;
  wire [8:0] m10_2_119     ;
  wire [8:0] m10_2_120     ;
  wire [8:0] m10_2_121     ;
  wire [8:0] m10_2_122     ;
  wire [8:0] m10_2_123     ;
  wire [8:0] m10_2_124     ;
  wire [8:0] m10_2_125     ;
  wire [8:0] m10_2_126     ;
  wire [8:0] m10_2_127     ;
  wire [8:0] m10_2_128     ;
  wire [8:0] m10_2_129     ;
  wire [8:0] m10_2_130     ;
  wire [8:0] m10_2_131     ;
  wire [8:0] m10_2_132     ;
  wire [9:0] m10_2_201     ;
  wire [9:0] m10_2_202     ;
  wire [9:0] m10_2_203     ;
  wire [9:0] m10_2_204     ;
  wire [9:0] m10_2_205     ;
  wire [9:0] m10_2_206     ;
  wire [9:0] m10_2_207     ;
  wire [9:0] m10_2_208     ;
  wire [9:0] m10_2_209     ;
  wire [9:0] m10_2_210     ;
  wire [9:0] m10_2_211     ;
  wire [9:0] m10_2_212     ;
  wire [9:0] m10_2_213     ;
  wire [9:0] m10_2_214     ;
  wire [9:0] m10_2_215     ;
  wire [9:0] m10_2_216     ;
  reg  [10:0] m10_2_301    ;
  reg  [10:0] m10_2_302    ;
  reg  [10:0] m10_2_303    ;
  reg  [10:0] m10_2_304    ; 
  reg  [10:0] m10_2_305    ; 
  reg  [10:0] m10_2_306    ; 
  reg  [10:0] m10_2_307    ;
  reg  [10:0] m10_2_308    ;
  wire [11:0] m10_2_401    ;
  wire [11:0] m10_2_402    ;
  wire [11:0] m10_2_403    ;
  wire [11:0] m10_2_404    ;
  reg  [12:0] m10_2_501    ;
  reg  [12:0] m10_2_502    ;
  
  
 
  assign m10_2_101  = win16_18 + win15_18  ;
  assign m10_2_102  = win14_18 + win13_18  ;
  assign m10_2_103  = win12_18 + win11_18  ;
  assign m10_2_104  = win10_18 + win9_18   ;
  assign m10_2_105  = win8_18 + win7_18    ;
  assign m10_2_106  = win6_18 + win5_18    ;
  assign m10_2_107  = win4_18 + win3_18    ;
  assign m10_2_108  = win2_18 + win1_18    ;
  assign m10_2_109  = win17_18 + win18_18  ;
  assign m10_2_110  = win19_18 + win20_18  ;
  assign m10_2_111  = win21_18 + win22_18  ;
  assign m10_2_112  = win23_18 + win24_18  ;
  assign m10_2_113  = win25_18 + win26_18  ;
  assign m10_2_114  = win27_18 + win28_18  ;
  assign m10_2_115  = win29_18 + win30_18  ;
  assign m10_2_116  = win31_18             ;
  assign m10_2_117  = win16_14 + win15_14  ;
  assign m10_2_118  = win14_14 + win13_14  ;
  assign m10_2_119  = win12_14 + win11_14  ;
  assign m10_2_120  = win10_14 + win9_14   ;
  assign m10_2_121  = win8_14 + win7_14    ;
  assign m10_2_122  = win6_14 + win5_14    ;
  assign m10_2_123  = win4_14 + win3_14    ;
  assign m10_2_124  = win2_14 + win1_14    ;
  assign m10_2_125  = win17_14 + win18_14  ;
  assign m10_2_126  = win19_14 + win20_14  ;
  assign m10_2_127  = win21_14 + win22_14  ;
  assign m10_2_128  = win23_14 + win24_14  ;
  assign m10_2_129  = win25_14 + win26_14  ;
  assign m10_2_130  = win27_14 + win28_14  ;
  assign m10_2_131  = win29_14 + win30_14  ;
  assign m10_2_132  = win31_14             ;
             
  assign m10_2_201 = m10_2_101 + m10_2_102; 
  assign m10_2_202 = m10_2_103 + m10_2_104; 
  assign m10_2_203 = m10_2_105 + m10_2_106; 
  assign m10_2_204 = m10_2_107 + m10_2_108; 
  assign m10_2_205 = m10_2_109 + m10_2_110; 
  assign m10_2_206 = m10_2_111 + m10_2_112; 
  assign m10_2_207 = m10_2_113 + m10_2_114; 
  assign m10_2_208 = m10_2_115 + m10_2_116;    
  assign m10_2_209 = m10_2_117 + m10_2_118; 
  assign m10_2_210 = m10_2_119 + m10_2_120 ;
  assign m10_2_211 = m10_2_121 + m10_2_122; 
  assign m10_2_212 = m10_2_123 + m10_2_124; 
  assign m10_2_213 = m10_2_125 + m10_2_126; 
  assign m10_2_214 = m10_2_127 + m10_2_128;
  assign m10_2_215 = m10_2_129 + m10_2_130;
  assign m10_2_216 = m10_2_131 + m10_2_132; 

     
   
   
     
   
   
   
   

   assign m10_2_401 = m10_2_301 + m10_2_302;   
   assign m10_2_402 = m10_2_303 + m10_2_304;  
   assign m10_2_403 = m10_2_305 + m10_2_306;
   assign m10_2_404 = m10_2_307 + m10_2_308;
              
  
                                    
   
   
  wire [8:0] m10_1_101     ;
  wire [8:0] m10_1_102     ;
  wire [8:0] m10_1_103     ;
  wire [8:0] m10_1_104     ;
  wire [8:0] m10_1_105     ;
  wire [8:0] m10_1_106     ;
  wire [8:0] m10_1_107     ;
  wire [8:0] m10_1_108     ;
  wire [8:0] m10_1_109     ;
  wire [8:0] m10_1_110     ;
  wire [8:0] m10_1_111     ;
  wire [8:0] m10_1_112     ;
  wire [8:0] m10_1_113     ;
  wire [8:0] m10_1_114     ;
  wire [8:0] m10_1_115     ;
  wire [8:0] m10_1_116     ;
  wire [8:0] m10_1_117     ;
  wire [8:0] m10_1_118     ;
  wire [8:0] m10_1_119     ;
  wire [8:0] m10_1_120     ;
  wire [8:0] m10_1_121     ;
  wire [8:0] m10_1_122     ;
  wire [8:0] m10_1_123     ;
  wire [8:0] m10_1_124     ;
  wire [8:0] m10_1_125     ;
  wire [8:0] m10_1_126     ;
  wire [8:0] m10_1_127     ;
  wire [8:0] m10_1_128     ;
  wire [8:0] m10_1_129     ;
  wire [8:0] m10_1_130     ;
  wire [8:0] m10_1_131     ;
  wire [8:0] m10_1_132     ;
  wire [9:0] m10_1_201     ;
  wire [9:0] m10_1_202     ;
  wire [9:0] m10_1_203     ;
  wire [9:0] m10_1_204     ;
  wire [9:0] m10_1_205     ;
  wire [9:0] m10_1_206     ;
  wire [9:0] m10_1_207     ;
  wire [9:0] m10_1_208     ;
  wire [9:0] m10_1_209     ;
  wire [9:0] m10_1_210     ;
  wire [9:0] m10_1_211     ;
  wire [9:0] m10_1_212     ;
  wire [9:0] m10_1_213     ;
  wire [9:0] m10_1_214     ;
  wire [9:0] m10_1_215     ;
  wire [9:0] m10_1_216     ;
  reg  [10:0] m10_1_301    ;
  reg  [10:0] m10_1_302    ;
  reg  [10:0] m10_1_303    ;
  reg  [10:0] m10_1_304    ; 
  reg  [10:0] m10_1_305    ; 
  reg  [10:0] m10_1_306    ; 
  reg  [10:0] m10_1_307    ;
  reg  [10:0] m10_1_308    ;
  wire [11:0] m10_1_401    ;
  wire [11:0] m10_1_402    ;
  wire [11:0] m10_1_403    ;
  wire [11:0] m10_1_404    ;
  reg  [12:0] m10_1_501    ;
  reg  [12:0] m10_1_502    ;
  
  
 
  assign m10_1_101  = win16_17 + win15_17  ;
  assign m10_1_102  = win14_17 + win13_17  ;
  assign m10_1_103  = win12_17 + win11_17  ;
  assign m10_1_104  = win10_17 + win9_17   ;
  assign m10_1_105  = win8_17 + win7_17    ;
  assign m10_1_106  = win6_17 + win5_17    ;
  assign m10_1_107  = win4_17 + win3_17    ;
  assign m10_1_108  = win2_17 + win1_17    ;
  assign m10_1_109  = win17_17 + win18_17  ;
  assign m10_1_110  = win19_17 + win20_17  ;
  assign m10_1_111  = win21_17 + win22_17  ;
  assign m10_1_112  = win23_17 + win24_17  ;
  assign m10_1_113  = win25_17 + win26_17  ;
  assign m10_1_114  = win27_17 + win28_17  ;
  assign m10_1_115  = win29_17 + win30_17  ;
  assign m10_1_116  = win31_17             ;
  assign m10_1_117  = win16_15 + win15_15  ;
  assign m10_1_118  = win14_15 + win13_15  ;
  assign m10_1_119  = win12_15 + win11_15  ;
  assign m10_1_120  = win10_15 + win9_15   ;
  assign m10_1_121  = win8_15 + win7_15    ;
  assign m10_1_122  = win6_15 + win5_15    ;
  assign m10_1_123  = win4_15 + win3_15    ;
  assign m10_1_124  = win2_15 + win1_15    ;
  assign m10_1_125  = win17_15 + win18_15  ;
  assign m10_1_126  = win19_15 + win20_15  ;
  assign m10_1_127  = win21_15 + win22_15  ;
  assign m10_1_128  = win23_15 + win24_15  ;
  assign m10_1_129  = win25_15 + win26_15  ;
  assign m10_1_130  = win27_15 + win28_15  ;
  assign m10_1_131  = win29_15 + win30_15  ;
  assign m10_1_132  = win31_15             ;
  
  assign m10_1_201 = m10_1_101 + m10_1_102; 
  assign m10_1_202 = m10_1_103 + m10_1_104; 
  assign m10_1_203 = m10_1_105 + m10_1_106; 
  assign m10_1_204 = m10_1_107 + m10_1_108; 
  assign m10_1_205 = m10_1_109 + m10_1_110; 
  assign m10_1_206 = m10_1_111 + m10_1_112; 
  assign m10_1_207 = m10_1_113 + m10_1_114; 
  assign m10_1_208 = m10_1_115 + m10_1_116;    
  assign m10_1_209 = m10_1_117 + m10_1_118; 
  assign m10_1_210 = m10_1_119 + m10_1_120 ;
  assign m10_1_211 = m10_1_121 + m10_1_122; 
  assign m10_1_212 = m10_1_123 + m10_1_124; 
  assign m10_1_213 = m10_1_125 + m10_1_126; 
  assign m10_1_214 = m10_1_127 + m10_1_128;
  assign m10_1_215 = m10_1_129 + m10_1_130;
  assign m10_1_216 = m10_1_131 + m10_1_132; 

      
   
    
      
   
   
   
   

   assign m10_1_401 = m10_1_301 + m10_1_302;   
   assign m10_1_402 = m10_1_303 + m10_1_304;  
   assign m10_1_403 = m10_1_305 + m10_1_306;
   assign m10_1_404 = m10_1_307 + m10_1_308;
              
   
                                    
   
   
   wire [8:0] m01_1_101     ;
   wire [8:0] m01_1_102     ;
   wire [8:0] m01_1_103     ;
   wire [8:0] m01_1_104     ;
   wire [8:0] m01_1_105     ;
   wire [8:0] m01_1_106     ;
   wire [8:0] m01_1_107     ;
   wire [8:0] m01_1_108     ;
   wire [8:0] m01_1_109     ;
   wire [8:0] m01_1_110     ;
   wire [8:0] m01_1_111     ;
   wire [8:0] m01_1_112     ;
   wire [8:0] m01_1_113     ;
   wire [8:0] m01_1_114     ;
   wire [8:0] m01_1_115     ;
   wire [8:0] m01_1_116     ;
   wire [8:0] m01_1_117     ;
   wire [8:0] m01_1_118     ;
   wire [8:0] m01_1_119     ;
   wire [8:0] m01_1_120     ;
   wire [8:0] m01_1_121     ;
   wire [8:0] m01_1_122     ;
   wire [8:0] m01_1_123     ;
   wire [8:0] m01_1_124     ;
   wire [8:0] m01_1_125     ;
   wire [8:0] m01_1_126     ;
   wire [8:0] m01_1_127     ;
   wire [8:0] m01_1_128     ;
   wire [8:0] m01_1_129     ;
   wire [8:0] m01_1_130     ;
   wire [8:0] m01_1_131     ;
   wire [8:0] m01_1_132     ;
   wire [9:0] m01_1_201     ;
   wire [9:0] m01_1_202     ;
   wire [9:0] m01_1_203     ;
   wire [9:0] m01_1_204     ;
   wire [9:0] m01_1_205     ;
   wire [9:0] m01_1_206     ;
   wire [9:0] m01_1_207     ;
   wire [9:0] m01_1_208     ;
   wire [9:0] m01_1_209     ;
   wire [9:0] m01_1_210     ;
   wire [9:0] m01_1_211     ;
   wire [9:0] m01_1_212     ;
   wire [9:0] m01_1_213     ;
   wire [9:0] m01_1_214     ;
   wire [9:0] m01_1_215     ;
   wire [9:0] m01_1_216     ;
   reg  [10:0] m01_1_301    ;
   reg  [10:0] m01_1_302    ;
   reg  [10:0] m01_1_303    ;
   reg  [10:0] m01_1_304    ; 
   reg  [10:0] m01_1_305    ; 
   reg  [10:0] m01_1_306    ; 
   reg  [10:0] m01_1_307    ;
   reg  [10:0] m01_1_308    ;
   wire [11:0] m01_1_401    ;
   wire [11:0] m01_1_402    ;
   wire [11:0] m01_1_403    ;
   wire [11:0] m01_1_404    ;
   reg  [12:0] m01_1_501    ;
   reg  [12:0] m01_1_502    ;
   
   
   
   assign m01_1_101  = win15_1 + win15_2  ;
   assign m01_1_102  = win15_3 + win15_4  ;
   assign m01_1_103  = win15_5 + win15_6  ;
   assign m01_1_104  = win15_7 + win15_8   ;
   assign m01_1_105  = win15_9 + win15_10    ;
   assign m01_1_106  = win15_11 + win15_12    ;
   assign m01_1_107  = win15_13 + win15_14    ;
   assign m01_1_108  = win15_15 + win15_16    ;
   assign m01_1_109  = win15_17 + win15_18  ;
   assign m01_1_110  = win15_19 + win15_20  ;
   assign m01_1_111  = win15_21 + win15_22  ;
   assign m01_1_112  = win15_23 + win15_24  ;
   assign m01_1_113  = win15_25 + win15_26  ;
   assign m01_1_114  = win15_27 + win15_28  ;
   assign m01_1_115  = win15_29 + win15_30  ;
   assign m01_1_116  = win15_31             ;
   assign m01_1_117  = win17_1  + win17_2   ;
   assign m01_1_118  = win17_3  + win17_4   ;
   assign m01_1_119  = win17_5  + win17_6   ;
   assign m01_1_120  = win17_7  + win17_8    ;
   assign m01_1_121  = win17_9  + win17_10    ;
   assign m01_1_122  = win17_11 + win17_12    ;
   assign m01_1_123  = win17_13 + win17_14    ;
   assign m01_1_124  = win17_15 + win17_16    ;
   assign m01_1_125  = win17_17 + win17_18  ;
   assign m01_1_126  = win17_19 + win17_20  ;
   assign m01_1_127  = win17_21 + win17_22  ;
   assign m01_1_128  = win17_23 + win17_24  ;
   assign m01_1_129  = win17_25 + win17_26  ;
   assign m01_1_130  = win17_27 + win17_28  ;
   assign m01_1_131  = win17_29 + win17_30  ;
   assign m01_1_132  = win17_31             ;
   
   assign m01_1_201 = m01_1_101 + m01_1_102; 
   assign m01_1_202 = m01_1_103 + m01_1_104; 
   assign m01_1_203 = m01_1_105 + m01_1_106; 
   assign m01_1_204 = m01_1_107 + m01_1_108; 
   assign m01_1_205 = m01_1_109 + m01_1_110; 
   assign m01_1_206 = m01_1_111 + m01_1_112; 
   assign m01_1_207 = m01_1_113 + m01_1_114; 
   assign m01_1_208 = m01_1_115 + m01_1_116;   
   assign m01_1_209 = m01_1_117 + m01_1_118; 
   assign m01_1_210 = m01_1_119 + m01_1_120 ;
   assign m01_1_211 = m01_1_121 + m01_1_122; 
   assign m01_1_212 = m01_1_123 + m01_1_124; 
   assign m01_1_213 = m01_1_125 + m01_1_126; 
   assign m01_1_214 = m01_1_127 + m01_1_128;
   assign m01_1_215 = m01_1_129 + m01_1_130;
   assign m01_1_216 = m01_1_131 + m01_1_132; 
   
    
    
    
    
    
    
    
    
   
    assign m01_1_401 = m01_1_301 + m01_1_302;  
    assign m01_1_402 = m01_1_303 + m01_1_304;  
    assign m01_1_403 = m01_1_305 + m01_1_306;
    assign m01_1_404 = m01_1_307 + m01_1_308;
              
                                 
   
  
    wire [8:0] m01_2_101     ;
    wire [8:0] m01_2_102     ;
    wire [8:0] m01_2_103     ;
    wire [8:0] m01_2_104     ;
    wire [8:0] m01_2_105     ;
    wire [8:0] m01_2_106     ;
    wire [8:0] m01_2_107     ;
    wire [8:0] m01_2_108     ;
    wire [8:0] m01_2_109     ;
    wire [8:0] m01_2_110     ;
    wire [8:0] m01_2_111     ;
    wire [8:0] m01_2_112     ;
    wire [8:0] m01_2_113     ;
    wire [8:0] m01_2_114     ;
    wire [8:0] m01_2_115     ;
    wire [8:0] m01_2_116     ;
    wire [8:0] m01_2_117     ;
    wire [8:0] m01_2_118     ;
    wire [8:0] m01_2_119     ;
    wire [8:0] m01_2_120     ;
    wire [8:0] m01_2_121     ;
    wire [8:0] m01_2_122     ;
    wire [8:0] m01_2_123     ;
    wire [8:0] m01_2_124     ;
    wire [8:0] m01_2_125     ;
    wire [8:0] m01_2_126     ;
    wire [8:0] m01_2_127     ;
    wire [8:0] m01_2_128     ;
    wire [8:0] m01_2_129     ;
    wire [8:0] m01_2_130     ;
    wire [8:0] m01_2_131     ;
    wire [8:0] m01_2_132     ;
    wire [9:0] m01_2_201     ;
    wire [9:0] m01_2_202     ;
    wire [9:0] m01_2_203     ;
    wire [9:0] m01_2_204     ;
    wire [9:0] m01_2_205     ;
    wire [9:0] m01_2_206     ;
    wire [9:0] m01_2_207     ;
    wire [9:0] m01_2_208     ;
    wire [9:0] m01_2_209     ;
    wire [9:0] m01_2_210     ;
    wire [9:0] m01_2_211     ;
    wire [9:0] m01_2_212     ;
    wire [9:0] m01_2_213     ;
    wire [9:0] m01_2_214     ;
    wire [9:0] m01_2_215     ;
    wire [9:0] m01_2_216     ;
    reg  [10:0] m01_2_301    ;
    reg  [10:0] m01_2_302    ;
    reg  [10:0] m01_2_303    ;
    reg  [10:0] m01_2_304    ; 
    reg  [10:0] m01_2_305    ; 
    reg  [10:0] m01_2_306    ; 
    reg  [10:0] m01_2_307    ;
    reg  [10:0] m01_2_308    ;
    wire [11:0] m01_2_401    ;
    wire [11:0] m01_2_402    ;
    wire [11:0] m01_2_403    ;
    wire [11:0] m01_2_404    ;
    reg  [12:0] m01_2_501    ;
    reg  [12:0] m01_2_502    ;
    
    
    
    assign m01_2_101  = win14_1 + win14_2  ;
    assign m01_2_102  = win14_3 + win14_4  ;
    assign m01_2_103  = win14_5 + win14_6  ;
    assign m01_2_104  = win14_7 + win14_8   ;
    assign m01_2_105  = win14_9 + win14_10    ;
    assign m01_2_106  = win14_11 + win14_12    ;
    assign m01_2_107  = win14_13 + win14_14    ;
    assign m01_2_108  = win14_15 + win14_16    ;
    assign m01_2_109  = win14_17 + win14_18  ;
    assign m01_2_110  = win14_19 + win14_20  ;
    assign m01_2_111  = win14_21 + win14_22  ;
    assign m01_2_112  = win14_23 + win14_24  ;
    assign m01_2_113  = win14_25 + win14_26  ;
    assign m01_2_114  = win14_27 + win14_28  ;
    assign m01_2_115  = win14_29 + win14_30  ;
    assign m01_2_116  = win14_31             ;
    assign m01_2_117  = win18_1  + win18_2   ;
    assign m01_2_118  = win18_3  + win18_4   ;
    assign m01_2_119  = win18_5  + win18_6   ;
    assign m01_2_120  = win18_7  + win18_8    ;
    assign m01_2_121  = win18_9  + win18_10    ;
    assign m01_2_122  = win18_11 + win18_12    ;
    assign m01_2_123  = win18_13 + win18_14    ;
    assign m01_2_124  = win18_15 + win18_16    ;
    assign m01_2_125  = win18_17 + win18_18  ;
    assign m01_2_126  = win18_19 + win18_20  ;
    assign m01_2_127  = win18_21 + win18_22  ;
    assign m01_2_128  = win18_23 + win18_24  ;
    assign m01_2_129  = win18_25 + win18_26  ;
    assign m01_2_130  = win18_27 + win18_28  ;
    assign m01_2_131  = win18_29 + win18_30  ;
    assign m01_2_132  = win18_31             ;
               
    assign m01_2_201 = m01_2_101 + m01_2_102; 
    assign m01_2_202 = m01_2_103 + m01_2_104; 
    assign m01_2_203 = m01_2_105 + m01_2_106; 
    assign m01_2_204 = m01_2_107 + m01_2_108; 
    assign m01_2_205 = m01_2_109 + m01_2_110; 
    assign m01_2_206 = m01_2_111 + m01_2_112; 
    assign m01_2_207 = m01_2_113 + m01_2_114; 
    assign m01_2_208 = m01_2_115 + m01_2_116;  
    assign m01_2_209 = m01_2_117 + m01_2_118; 
    assign m01_2_210 = m01_2_119 + m01_2_120 ;
    assign m01_2_211 = m01_2_121 + m01_2_122; 
    assign m01_2_212 = m01_2_123 + m01_2_124; 
    assign m01_2_213 = m01_2_125 + m01_2_126; 
    assign m01_2_214 = m01_2_127 + m01_2_128;
    assign m01_2_215 = m01_2_129 + m01_2_130;
    assign m01_2_216 = m01_2_131 + m01_2_132; 
    
     
     
     
     
     
     
     
     
    
     assign m01_2_401 = m01_2_301 + m01_2_302; 
     assign m01_2_402 = m01_2_303 + m01_2_304; 
     assign m01_2_403 = m01_2_305 + m01_2_306;
     assign m01_2_404 = m01_2_307 + m01_2_308;
                
    
                                      
     
  
    wire [8:0] m01_3_101     ;
    wire [8:0] m01_3_102     ;
    wire [8:0] m01_3_103     ;
    wire [8:0] m01_3_104     ;
    wire [8:0] m01_3_105     ;
    wire [8:0] m01_3_106     ;
    wire [8:0] m01_3_107     ;
    wire [8:0] m01_3_108     ;
    wire [8:0] m01_3_109     ;
    wire [8:0] m01_3_110     ;
    wire [8:0] m01_3_111     ;
    wire [8:0] m01_3_112     ;
    wire [8:0] m01_3_113     ;
    wire [8:0] m01_3_114     ;
    wire [8:0] m01_3_115     ;
    wire [8:0] m01_3_116     ;
    wire [8:0] m01_3_117     ;
    wire [8:0] m01_3_118     ;
    wire [8:0] m01_3_119     ;
    wire [8:0] m01_3_120     ;
    wire [8:0] m01_3_121     ;
    wire [8:0] m01_3_122     ;
    wire [8:0] m01_3_123     ;
    wire [8:0] m01_3_124     ;
    wire [8:0] m01_3_125     ;
    wire [8:0] m01_3_126     ;
    wire [8:0] m01_3_127     ;
    wire [8:0] m01_3_128     ;
    wire [8:0] m01_3_129     ;
    wire [8:0] m01_3_130     ;
    wire [8:0] m01_3_131     ;
    wire [8:0] m01_3_132     ;
    wire [9:0] m01_3_201     ;
    wire [9:0] m01_3_202     ;
    wire [9:0] m01_3_203     ;
    wire [9:0] m01_3_204     ;
    wire [9:0] m01_3_205     ;
    wire [9:0] m01_3_206     ;
    wire [9:0] m01_3_207     ;
    wire [9:0] m01_3_208     ;
    wire [9:0] m01_3_209     ;
    wire [9:0] m01_3_210     ;
    wire [9:0] m01_3_211     ;
    wire [9:0] m01_3_212     ;
    wire [9:0] m01_3_213     ;
    wire [9:0] m01_3_214     ;
    wire [9:0] m01_3_215     ;
    wire [9:0] m01_3_216     ;
    reg  [10:0] m01_3_301    ;
    reg  [10:0] m01_3_302    ;
    reg  [10:0] m01_3_303    ;
    reg  [10:0] m01_3_304    ; 
    reg  [10:0] m01_3_305    ; 
    reg  [10:0] m01_3_306    ; 
    reg  [10:0] m01_3_307    ;
    reg  [10:0] m01_3_308    ;
    wire [11:0] m01_3_401    ;
    wire [11:0] m01_3_402    ;
    wire [11:0] m01_3_403    ;
    wire [11:0] m01_3_404    ;
    reg  [12:0] m01_3_501    ;
    reg  [12:0] m01_3_502    ;
    
    
    
    assign m01_3_101  = win13_1 + win13_2  ;
    assign m01_3_102  = win13_3 + win13_4  ;
    assign m01_3_103  = win13_5 + win13_6  ;
    assign m01_3_104  = win13_7 + win13_8   ;
    assign m01_3_105  = win13_9  + win13_10    ;
    assign m01_3_106  = win13_11 + win13_12    ;
    assign m01_3_107  = win13_13 + win13_14    ;
    assign m01_3_108  = win13_15 + win13_16    ;
    assign m01_3_109  = win13_17 + win13_18  ;
    assign m01_3_110  = win13_19 + win13_20  ;
    assign m01_3_111  = win13_21 + win13_22  ;
    assign m01_3_112  = win13_23 + win13_24  ;
    assign m01_3_113  = win13_25 + win13_26  ;
    assign m01_3_114  = win13_27 + win13_28  ;
    assign m01_3_115  = win13_29 + win13_30  ;
    assign m01_3_116  = win13_31             ;
    assign m01_3_117  = win19_1  + win19_2   ;
    assign m01_3_118  = win19_3  + win19_4   ;
    assign m01_3_119  = win19_5  + win19_6   ;
    assign m01_3_120  = win19_7  + win19_8    ;
    assign m01_3_121  = win19_9  + win19_10    ;
    assign m01_3_122  = win19_11 + win19_12    ;
    assign m01_3_123  = win19_13 + win19_14    ;
    assign m01_3_124  = win19_15 + win19_16    ;
    assign m01_3_125  = win19_17 + win19_18  ;
    assign m01_3_126  = win19_19 + win19_20  ;
    assign m01_3_127  = win19_21 + win19_22  ;
    assign m01_3_128  = win19_23 + win19_24  ;
    assign m01_3_129  = win19_25 + win19_26  ;
    assign m01_3_130  = win19_27 + win19_28  ;
    assign m01_3_131  = win19_29 + win19_30  ;
    assign m01_3_132  = win19_31             ;
               
    assign m01_3_201 = m01_3_101 + m01_3_102; 
    assign m01_3_202 = m01_3_103 + m01_3_104; 
    assign m01_3_203 = m01_3_105 + m01_3_106; 
    assign m01_3_204 = m01_3_107 + m01_3_108; 
    assign m01_3_205 = m01_3_109 + m01_3_110; 
    assign m01_3_206 = m01_3_111 + m01_3_112; 
    assign m01_3_207 = m01_3_113 + m01_3_114; 
    assign m01_3_208 = m01_3_115 + m01_3_116;  
    assign m01_3_209 = m01_3_117 + m01_3_118; 
    assign m01_3_210 = m01_3_119 + m01_3_120 ;
    assign m01_3_211 = m01_3_121 + m01_3_122; 
    assign m01_3_212 = m01_3_123 + m01_3_124; 
    assign m01_3_213 = m01_3_125 + m01_3_126; 
    assign m01_3_214 = m01_3_127 + m01_3_128;
    assign m01_3_215 = m01_3_129 + m01_3_130;
    assign m01_3_216 = m01_3_131 + m01_3_132; 
    
     
     
     
     
     
     
     
     
    
     assign m01_3_401 = m01_3_301 + m01_3_302; 
     assign m01_3_402 = m01_3_303 + m01_3_304; 
     assign m01_3_403 = m01_3_305 + m01_3_306;
     assign m01_3_404 = m01_3_307 + m01_3_308;
                
     
  
  
  
  
  
  wire [8:0] m01_4_101     ;
  wire [8:0] m01_4_102     ;
  wire [8:0] m01_4_103     ;
  wire [8:0] m01_4_104     ;
  wire [8:0] m01_4_105     ;
  wire [8:0] m01_4_106     ;
  wire [8:0] m01_4_107     ;
  wire [8:0] m01_4_108     ;
  wire [8:0] m01_4_109     ;
  wire [8:0] m01_4_110     ;
  wire [8:0] m01_4_111     ;
  wire [8:0] m01_4_112     ;
  wire [8:0] m01_4_113     ;
  wire [8:0] m01_4_114     ;
  wire [8:0] m01_4_115     ;
  wire [8:0] m01_4_116     ;
  wire [8:0] m01_4_117     ;
  wire [8:0] m01_4_118     ;
  wire [8:0] m01_4_119     ;
  wire [8:0] m01_4_120     ;
  wire [8:0] m01_4_121     ;
  wire [8:0] m01_4_122     ;
  wire [8:0] m01_4_123     ;
  wire [8:0] m01_4_124     ;
  wire [8:0] m01_4_125     ;
  wire [8:0] m01_4_126     ;
  wire [8:0] m01_4_127     ;
  wire [8:0] m01_4_128     ;
  wire [8:0] m01_4_129     ;
  wire [8:0] m01_4_130     ;
  wire [9:0] m01_4_201     ;
  wire [9:0] m01_4_202     ;
  wire [9:0] m01_4_203     ;
  wire [9:0] m01_4_204     ;
  wire [9:0] m01_4_205     ;
  wire [9:0] m01_4_206     ;
  wire [9:0] m01_4_207     ;
  wire [9:0] m01_4_208     ;
  wire [9:0] m01_4_209     ;
  wire [9:0] m01_4_210     ;
  wire [9:0] m01_4_211     ;
  wire [9:0] m01_4_212     ;
  wire [9:0] m01_4_213     ;
  wire [9:0] m01_4_214     ;
  wire [9:0] m01_4_215     ;
  wire [9:0] m01_4_216     ;
  reg  [10:0] m01_4_301    ;
  reg  [10:0] m01_4_302    ;
  reg  [10:0] m01_4_303    ;
  reg  [10:0] m01_4_304    ; 
  reg  [10:0] m01_4_305    ; 
  reg  [10:0] m01_4_306    ; 
  reg  [10:0] m01_4_307    ;
  reg  [10:0] m01_4_308    ;
  wire [11:0] m01_4_401    ;
  wire [11:0] m01_4_402    ;
  wire [11:0] m01_4_403    ;
  wire [11:0] m01_4_404    ;
  reg  [12:0] m01_4_501    ;
  reg  [12:0] m01_4_502    ;
  
  
  
  
  
  assign m01_4_101  = win12_2 + win12_3   ;
  assign m01_4_102  = win12_4 + win12_5   ;
  assign m01_4_103  = win12_6 + win12_7   ;
  assign m01_4_104  = win12_8 + win12_9    ;
  assign m01_4_105  = win12_10 + win12_11     ;
  assign m01_4_106  = win12_12 + win12_13     ;
  assign m01_4_107  = win12_14 + win12_15     ;
  assign m01_4_108  = win12_16 + win12_17    ;
  assign m01_4_109  = win12_18 + win12_19   ;
  assign m01_4_110  = win12_20 + win12_21   ;
  assign m01_4_111  = win12_22 + win12_23   ;
  assign m01_4_112  = win12_24 + win12_25   ;
  assign m01_4_113  = win12_26 + win12_27   ;
  assign m01_4_114  = win12_28 + win12_29   ;
  assign m01_4_115  = win12_30              ;
  assign m01_4_116  = win20_2  + win20_3   ;
  assign m01_4_117  = win20_4  + win20_5   ;
  assign m01_4_118  = win20_6  + win20_7   ;
  assign m01_4_119  = win20_8  + win20_9    ;
  assign m01_4_120  = win20_10 + win20_11     ;
  assign m01_4_121  = win20_12 + win20_13     ;
  assign m01_4_122  = win20_14 + win20_15     ;
  assign m01_4_123  = win20_16 + win20_17    ;
  assign m01_4_124  = win20_18 + win20_19   ;
  assign m01_4_125  = win20_20 + win20_21   ;
  assign m01_4_126  = win20_22 + win20_23   ;
  assign m01_4_127  = win20_24 + win20_25   ;
  assign m01_4_128  = win20_26 + win20_27   ;
  assign m01_4_129  = win20_28 + win20_29   ;
  assign m01_4_130  = win20_30              ;
   
   assign m01_4_201 = m01_4_101 + m01_4_102; 
   assign m01_4_202 = m01_4_103 + m01_4_104; 
   assign m01_4_203 = m01_4_105 + m01_4_106; 
   assign m01_4_204 = m01_4_107 + m01_4_108; 
   assign m01_4_205 = m01_4_109 + m01_4_110;  
   assign m01_4_206 = m01_4_111 + m01_4_112;  
   assign m01_4_207 = m01_4_113 + m01_4_114;    
   assign m01_4_208 = m01_4_115 ;   
   assign m01_4_209 = m01_4_116 + m01_4_117; 
   assign m01_4_210 = m01_4_118 + m01_4_119 ; 
   assign m01_4_211 = m01_4_120 + m01_4_121; 
   assign m01_4_212 = m01_4_122 + m01_4_123; 
   assign m01_4_213 = m01_4_124 + m01_4_125; 
   assign m01_4_214 = m01_4_126 + m01_4_127;
   assign m01_4_215 = m01_4_128 + m01_4_129;
   assign m01_4_216 = m01_4_130 ;     
                                      
     
  
   
     
  
  
  
  
                                      
  assign m01_4_401 = m01_4_301 + m01_4_302;
  assign m01_4_402 = m01_4_303 + m01_4_304;     
  assign m01_4_403 = m01_4_305 + m01_4_306;
  assign m01_4_404 = m01_4_307 + m01_4_308;
                             
 
                                   
  
  
  
  wire [8:0] m01_5_101     ;
  wire [8:0] m01_5_102     ;
  wire [8:0] m01_5_103     ;
  wire [8:0] m01_5_104     ;
  wire [8:0] m01_5_105     ;
  wire [8:0] m01_5_106     ;
  wire [8:0] m01_5_107     ;
  wire [8:0] m01_5_108     ;
  wire [8:0] m01_5_109     ;
  wire [8:0] m01_5_110     ;
  wire [8:0] m01_5_111     ;
  wire [8:0] m01_5_112     ;
  wire [8:0] m01_5_113     ;
  wire [8:0] m01_5_114     ;
  wire [8:0] m01_5_115     ;
  wire [8:0] m01_5_116     ;
  wire [8:0] m01_5_117     ;
  wire [8:0] m01_5_118     ;
  wire [8:0] m01_5_119     ;
  wire [8:0] m01_5_120     ;
  wire [8:0] m01_5_121     ;
  wire [8:0] m01_5_122     ;
  wire [8:0] m01_5_123     ;
  wire [8:0] m01_5_124     ;
  wire [8:0] m01_5_125     ;
  wire [8:0] m01_5_126     ;
  wire [8:0] m01_5_127     ;
  wire [8:0] m01_5_128     ;
  wire [8:0] m01_5_129     ;
  wire [8:0] m01_5_130     ;
  wire [9:0] m01_5_201     ;
  wire [9:0] m01_5_202     ;
  wire [9:0] m01_5_203     ;
  wire [9:0] m01_5_204     ;
  wire [9:0] m01_5_205     ;
  wire [9:0] m01_5_206     ;
  wire [9:0] m01_5_207     ;
  wire [9:0] m01_5_208     ;
  wire [9:0] m01_5_209     ;
  wire [9:0] m01_5_210     ;
  wire [9:0] m01_5_211     ;
  wire [9:0] m01_5_212     ;
  wire [9:0] m01_5_213     ;
  wire [9:0] m01_5_214     ;
  wire [9:0] m01_5_215     ;
  wire [9:0] m01_5_216     ;
  reg  [10:0] m01_5_301    ;
  reg  [10:0] m01_5_302    ;
  reg  [10:0] m01_5_303    ;
  reg  [10:0] m01_5_304    ; 
  reg  [10:0] m01_5_305    ; 
  reg  [10:0] m01_5_306    ; 
  reg  [10:0] m01_5_307    ;
  reg  [10:0] m01_5_308    ;
  wire [11:0] m01_5_401    ;
  wire [11:0] m01_5_402    ;
  wire [11:0] m01_5_403    ;
  wire [11:0] m01_5_404    ;
  reg  [12:0] m01_5_501    ;
  reg  [12:0] m01_5_502    ;
  
  
  
  
  
  assign m01_5_101  = win11_2 + win11_3   ;
  assign m01_5_102  = win11_4 + win11_5   ;
  assign m01_5_103  = win11_6 + win11_7   ;
  assign m01_5_104  = win11_8 + win11_9    ;
  assign m01_5_105  = win11_10 + win11_11     ;
  assign m01_5_106  = win11_12 + win11_13     ;
  assign m01_5_107  = win11_14 + win11_15     ;
  assign m01_5_108  = win11_16 + win11_17    ;
  assign m01_5_109  = win11_18 + win11_19   ;
  assign m01_5_110  = win11_20 + win11_21   ;
  assign m01_5_111  = win11_22 + win11_23   ;
  assign m01_5_112  = win11_24 + win11_25   ;
  assign m01_5_113  = win11_26 + win11_27   ;
  assign m01_5_114  = win11_28 + win11_29   ;
  assign m01_5_115  = win11_30              ;
  assign m01_5_116  = win21_2  + win21_3   ;
  assign m01_5_117  = win21_4  + win21_5   ;
  assign m01_5_118  = win21_6  + win21_7   ;
  assign m01_5_119  = win21_8  + win21_9    ;
  assign m01_5_120  = win21_10 + win21_11     ;
  assign m01_5_121  = win21_12 + win21_13     ;
  assign m01_5_122  = win21_14 + win21_15     ;
  assign m01_5_123  = win21_16 + win21_17    ;
  assign m01_5_124  = win21_18 + win21_19   ;
  assign m01_5_125  = win21_20 + win21_21   ;
  assign m01_5_126  = win21_22 + win21_23   ;
  assign m01_5_127  = win21_24 + win21_25   ;
  assign m01_5_128  = win21_26 + win21_27   ;
  assign m01_5_129  = win21_28 + win21_29   ;
  assign m01_5_130  = win21_30              ;
   
   assign m01_5_201 = m01_5_101 + m01_5_102; 
   assign m01_5_202 = m01_5_103 + m01_5_104; 
   assign m01_5_203 = m01_5_105 + m01_5_106; 
   assign m01_5_204 = m01_5_107 + m01_5_108; 
   assign m01_5_205 = m01_5_109 + m01_5_110;  
   assign m01_5_206 = m01_5_111 + m01_5_112;  
   assign m01_5_207 = m01_5_113 + m01_5_114;    
   assign m01_5_208 = m01_5_115 ;     
   assign m01_5_209 = m01_5_116 + m01_5_117; 
   assign m01_5_210 = m01_5_118 + m01_5_119 ; 
   assign m01_5_211 = m01_5_120 + m01_5_121; 
   assign m01_5_212 = m01_5_122 + m01_5_123; 
   assign m01_5_213 = m01_5_124 + m01_5_125; 
   assign m01_5_214 = m01_5_126 + m01_5_127;
   assign m01_5_215 = m01_5_128 + m01_5_129;
   assign m01_5_216 = m01_5_130 ;     
                                    
      
   
    
      
   
   
   
   
                                      
  assign m01_5_401 = m01_5_301 + m01_5_302;
  assign m01_5_402 = m01_5_303 + m01_5_304;     
  assign m01_5_403 = m01_5_305 + m01_5_306;
  assign m01_5_404 = m01_5_307 + m01_5_308;
                             
  
                                   
 
  
  
  wire [8:0] m01_6_101     ;
  wire [8:0] m01_6_102     ;
  wire [8:0] m01_6_103     ;
  wire [8:0] m01_6_104     ;
  wire [8:0] m01_6_105     ;
  wire [8:0] m01_6_106     ;
  wire [8:0] m01_6_107     ;
  wire [8:0] m01_6_108     ;
  wire [8:0] m01_6_109     ;
  wire [8:0] m01_6_110     ;
  wire [8:0] m01_6_111     ;
  wire [8:0] m01_6_112     ;
  wire [8:0] m01_6_113     ;
  wire [8:0] m01_6_114     ;
  wire [8:0] m01_6_115     ;
  wire [8:0] m01_6_116     ;
  wire [8:0] m01_6_117     ;
  wire [8:0] m01_6_118     ;
  wire [8:0] m01_6_119     ;
  wire [8:0] m01_6_120     ;
  wire [8:0] m01_6_121     ;
  wire [8:0] m01_6_122     ;
  wire [8:0] m01_6_123     ;
  wire [8:0] m01_6_124     ;
  wire [8:0] m01_6_125     ;
  wire [8:0] m01_6_126     ;
  wire [8:0] m01_6_127     ;
  wire [8:0] m01_6_128     ;
  wire [8:0] m01_6_129     ;
  wire [8:0] m01_6_130     ;
  wire [9:0] m01_6_201     ;
  wire [9:0] m01_6_202     ;
  wire [9:0] m01_6_203     ;
  wire [9:0] m01_6_204     ;
  wire [9:0] m01_6_205     ;
  wire [9:0] m01_6_206     ;
  wire [9:0] m01_6_207     ;
  wire [9:0] m01_6_208     ;
  wire [9:0] m01_6_209     ;
  wire [9:0] m01_6_210     ;
  wire [9:0] m01_6_211     ;
  wire [9:0] m01_6_212     ;
  wire [9:0] m01_6_213     ;
  wire [9:0] m01_6_214     ;
  wire [9:0] m01_6_215     ;
  wire [9:0] m01_6_216     ;
  reg  [10:0] m01_6_301    ;
  reg  [10:0] m01_6_302    ;
  reg  [10:0] m01_6_303    ;
  reg  [10:0] m01_6_304    ; 
  reg  [10:0] m01_6_305    ; 
  reg  [10:0] m01_6_306    ; 
  reg  [10:0] m01_6_307    ;
  reg  [10:0] m01_6_308    ;
  wire [11:0] m01_6_401    ;
  wire [11:0] m01_6_402    ;
  wire [11:0] m01_6_403    ;
  wire [11:0] m01_6_404    ;
  reg  [12:0] m01_6_501    ;
  reg  [12:0] m01_6_502    ;
  
  
  
  
  
  assign m01_6_101  = win10_2 + win10_3   ;
  assign m01_6_102  = win10_4 + win10_5   ;
  assign m01_6_103  = win10_6 + win10_7   ;
  assign m01_6_104  = win10_8 + win10_9    ;
  assign m01_6_105  = win10_10 + win10_11     ;
  assign m01_6_106  = win10_12 + win10_13     ;
  assign m01_6_107  = win10_14 + win10_15     ;
  assign m01_6_108  = win10_16 + win10_17    ;
  assign m01_6_109  = win10_18 + win10_19   ;
  assign m01_6_110  = win10_20 + win10_21   ;
  assign m01_6_111  = win10_22 + win10_23   ;
  assign m01_6_112  = win10_24 + win10_25   ;
  assign m01_6_113  = win10_26 + win10_27   ;
  assign m01_6_114  = win10_28 + win10_29   ;
  assign m01_6_115  = win10_30              ;
  assign m01_6_116  = win22_2  + win22_3   ;
  assign m01_6_117  = win22_4  + win22_5   ;
  assign m01_6_118  = win22_6  + win22_7   ;
  assign m01_6_119  = win22_8  + win22_9    ;
  assign m01_6_120  = win22_10 + win22_11     ;
  assign m01_6_121  = win22_12 + win22_13     ;
  assign m01_6_122  = win22_14 + win22_15     ;
  assign m01_6_123  = win22_16 + win22_17    ;
  assign m01_6_124  = win22_18 + win22_19   ;
  assign m01_6_125  = win22_20 + win22_21   ;
  assign m01_6_126  = win22_22 + win22_23   ;
  assign m01_6_127  = win22_24 + win22_25   ;
  assign m01_6_128  = win22_26 + win22_27   ;
  assign m01_6_129  = win22_28 + win22_29   ;
  assign m01_6_130  = win22_30              ;
   
   assign m01_6_201 = m01_6_101 + m01_6_102; 
   assign m01_6_202 = m01_6_103 + m01_6_104; 
   assign m01_6_203 = m01_6_105 + m01_6_106; 
   assign m01_6_204 = m01_6_107 + m01_6_108; 
   assign m01_6_205 = m01_6_109 + m01_6_110;  
   assign m01_6_206 = m01_6_111 + m01_6_112;  
   assign m01_6_207 = m01_6_113 + m01_6_114;    
   assign m01_6_208 = m01_6_115 ;     
   assign m01_6_209 = m01_6_116 + m01_6_117; 
   assign m01_6_210 = m01_6_118 + m01_6_119 ; 
   assign m01_6_211 = m01_6_120 + m01_6_121; 
   assign m01_6_212 = m01_6_122 + m01_6_123; 
   assign m01_6_213 = m01_6_124 + m01_6_125; 
   assign m01_6_214 = m01_6_126 + m01_6_127;
   assign m01_6_215 = m01_6_128 + m01_6_129;
   assign m01_6_216 = m01_6_130 ;     
                                    
      
   
    
      
   
   
   
   
                                      
  assign m01_6_401 = m01_6_301 + m01_6_302;
  assign m01_6_402 = m01_6_303 + m01_6_304;     
  assign m01_6_403 = m01_6_305 + m01_6_306;
  assign m01_6_404 = m01_6_307 + m01_6_308;
                             
 
  
  
  
  wire [8:0] m01_7_101  ;
  wire [8:0] m01_7_102  ;
  wire [8:0] m01_7_103  ;
  wire [8:0] m01_7_104  ;
  wire [8:0] m01_7_105  ;
  wire [8:0] m01_7_106  ;
  wire [8:0] m01_7_107  ;
  wire [8:0] m01_7_108  ;
  wire [8:0] m01_7_109  ;
  wire [8:0] m01_7_110  ;
  wire [8:0] m01_7_111  ;
  wire [8:0] m01_7_112  ;
  wire [8:0] m01_7_113  ;
  wire [8:0] m01_7_114  ;
  wire [8:0] m01_7_115  ;
  wire [8:0] m01_7_116  ;
  wire [8:0] m01_7_117  ;
  wire [8:0] m01_7_118  ;
  wire [8:0] m01_7_119  ;
  wire [8:0] m01_7_120  ;
  wire [8:0] m01_7_121  ;
  wire [8:0] m01_7_122  ;
  wire [8:0] m01_7_123  ;
  wire [8:0] m01_7_124  ;
  wire [8:0] m01_7_125  ;
  wire [8:0] m01_7_126  ;
  wire [8:0] m01_7_127  ;
  wire [8:0] m01_7_128  ;
  wire [9:0] m01_7_201  ;
  wire [9:0] m01_7_202  ;
  wire [9:0] m01_7_203  ;
  wire [9:0] m01_7_204  ;
  wire [9:0] m01_7_205  ;
  wire [9:0] m01_7_206  ;
  wire [9:0] m01_7_207  ;
  wire [9:0] m01_7_208  ;
  wire [9:0] m01_7_209  ;
  wire [9:0] m01_7_210  ;
  wire [9:0] m01_7_211  ;
  wire [9:0] m01_7_212  ;
  wire [9:0] m01_7_213  ;
  wire [9:0] m01_7_214  ;
  reg  [10:0] m01_7_301 ;
  reg  [10:0] m01_7_302 ;
  reg  [10:0] m01_7_303 ;
  reg  [10:0] m01_7_304 ;
  reg  [10:0] m01_7_305 ;
  reg  [10:0] m01_7_306 ;
  reg  [10:0] m01_7_307 ;
  reg  [10:0] m01_7_308 ;
  wire [11:0] m01_7_401 ;
  wire [11:0] m01_7_402 ;
  wire [11:0] m01_7_403 ;
  wire [11:0] m01_7_404 ;
  reg  [12:0] m01_7_501 ;
  reg  [12:0] m01_7_502 ;
  
  assign m01_7_101  = win9_3 + win9_4  ;
  assign m01_7_102  = win9_5 + win9_6  ; 
  assign m01_7_103  = win9_7 + win9_8  ; 
  assign m01_7_104  = win9_9 + win9_10   ; 
  assign m01_7_105  = win9_11 + win9_12    ; 
  assign m01_7_106  = win9_13 + win9_14    ; 
  assign m01_7_107  = win9_15 + win9_16    ; 
  assign m01_7_108  = win9_17 + win9_18  ; 
  assign m01_7_109  = win9_19 + win9_20  ; 
  assign m01_7_110  = win9_21 + win9_22  ; 
  assign m01_7_111  = win9_23 + win9_24  ; 
  assign m01_7_112  = win9_25 + win9_26  ; 
  assign m01_7_113  = win9_27 + win9_28  ; 
  assign m01_7_114  = win9_29             ; 
  assign m01_7_115  = win23_3  + win23_4     ; 
  assign m01_7_116  = win23_5  + win23_6     ; 
  assign m01_7_117  = win23_7  + win23_8     ; 
  assign m01_7_118  = win23_9  + win23_10    ; 
  assign m01_7_119  = win23_11 + win23_12       ; 
  assign m01_7_120  = win23_13 + win23_14       ; 
  assign m01_7_121  = win23_15 + win23_16       ; 
  assign m01_7_122  = win23_17 + win23_18     ;
  assign m01_7_123  = win23_19 + win23_20     ;
  assign m01_7_124  = win23_21 + win23_22     ;
  assign m01_7_125  = win23_23 + win23_24     ;
  assign m01_7_126  = win23_25 + win23_26     ;
  assign m01_7_127  = win23_27 + win23_28              ;
  assign m01_7_128  = win23_29 ; 
  
   assign m01_7_201 = m01_7_101 + m01_7_102; 
   assign m01_7_202 = m01_7_103 + m01_7_104; 
   assign m01_7_203 = m01_7_105 + m01_7_106; 
   assign m01_7_204 = m01_7_107 + m01_7_108; 
   assign m01_7_205 = m01_7_109 + m01_7_110;  
   assign m01_7_206 = m01_7_111 + m01_7_112;  
   assign m01_7_207 = m01_7_113 + m01_7_114;    
   assign m01_7_208 = m01_7_115 + m01_7_116; 
   assign m01_7_209 = m01_7_117 + m01_7_118; 
   assign m01_7_210 = m01_7_119 + m01_7_120 ; 
   assign m01_7_211 = m01_7_121 + m01_7_122; 
   assign m01_7_212 = m01_7_123 + m01_7_124; 
   assign m01_7_213 = m01_7_125 + m01_7_126; 
   assign m01_7_214 = m01_7_127 + m01_7_128;
   
   
  
   
  
  
  
  
  
  
  assign m01_7_401 = m01_7_301 + m01_7_302;
  assign m01_7_402 = m01_7_303 + m01_7_304;     
  assign m01_7_403 = m01_7_305 + m01_7_306;
  assign m01_7_404 = m01_7_307 + m01_7_308;
  
 
  
  
  
  
  wire [8:0] m01_8_101  ;
  wire [8:0] m01_8_102  ;
  wire [8:0] m01_8_103  ;
  wire [8:0] m01_8_104  ;
  wire [8:0] m01_8_105  ;
  wire [8:0] m01_8_106  ;
  wire [8:0] m01_8_107  ;
  wire [8:0] m01_8_108  ;
  wire [8:0] m01_8_109  ;
  wire [8:0] m01_8_110  ;
  wire [8:0] m01_8_111  ;
  wire [8:0] m01_8_112  ;
  wire [8:0] m01_8_113  ;
  wire [8:0] m01_8_114  ;
  wire [8:0] m01_8_115  ;
  wire [8:0] m01_8_116  ;
  wire [8:0] m01_8_117  ;
  wire [8:0] m01_8_118  ;
  wire [8:0] m01_8_119  ;
  wire [8:0] m01_8_120  ;
  wire [8:0] m01_8_121  ;
  wire [8:0] m01_8_122  ;
  wire [8:0] m01_8_123  ;
  wire [8:0] m01_8_124  ;
  wire [8:0] m01_8_125  ;
  wire [8:0] m01_8_126  ;
  wire [8:0] m01_8_127  ;
  wire [8:0] m01_8_128  ;
  wire [9:0] m01_8_201  ;
  wire [9:0] m01_8_202  ;
  wire [9:0] m01_8_203  ;
  wire [9:0] m01_8_204  ;
  wire [9:0] m01_8_205  ;
  wire [9:0] m01_8_206  ;
  wire [9:0] m01_8_207  ;
  wire [9:0] m01_8_208  ;
  wire [9:0] m01_8_209  ;
  wire [9:0] m01_8_210  ;
  wire [9:0] m01_8_211  ;
  wire [9:0] m01_8_212  ;
  wire [9:0] m01_8_213  ;
  wire [9:0] m01_8_214  ;
  reg  [10:0] m01_8_301 ;
  reg  [10:0] m01_8_302 ;
  reg  [10:0] m01_8_303 ;
  reg  [10:0] m01_8_304 ;
  reg  [10:0] m01_8_305 ;
  reg  [10:0] m01_8_306 ;
  reg  [10:0] m01_8_307 ;
  reg  [10:0] m01_8_308 ;
  wire [11:0] m01_8_401 ;
  wire [11:0] m01_8_402 ;
  wire [11:0] m01_8_403 ;
  wire [11:0] m01_8_404 ;
  reg  [12:0] m01_8_501 ;
  reg  [12:0] m01_8_502 ;
  
  assign m01_8_101  = win8_3 + win8_4  ;
  assign m01_8_102  = win8_5 + win8_6  ; 
  assign m01_8_103  = win8_7 + win8_8  ; 
  assign m01_8_104  = win8_9 + win8_10   ; 
  assign m01_8_105  = win8_11 + win8_12    ;
  assign m01_8_106  = win8_13 + win8_14    ;
  assign m01_8_107  = win8_15 + win8_16    ;
  assign m01_8_108  = win8_17 + win8_18  ; 
  assign m01_8_109  = win8_19 + win8_20  ; 
  assign m01_8_110  = win8_21 + win8_22  ; 
  assign m01_8_111  = win8_23 + win8_24  ; 
  assign m01_8_112  = win8_25 + win8_26  ; 
  assign m01_8_113  = win8_27 + win8_28  ; 
  assign m01_8_114  = win8_29             ; 
  assign m01_8_115  = win24_3  + win24_4  ;  
  assign m01_8_116  = win24_5  + win24_6  ;  
  assign m01_8_117  = win24_7  + win24_8   ; 
  assign m01_8_118  = win24_9  + win24_10  ; 
  assign m01_8_119  = win24_11 + win24_12  ; 
  assign m01_8_120  = win24_13 + win24_14  ; 
  assign m01_8_121  = win24_15 + win24_16  ; 
  assign m01_8_122  = win24_17 + win24_18  ; 
  assign m01_8_123  = win24_19 + win24_20  ; 
  assign m01_8_124  = win24_21 + win24_22   ;
  assign m01_8_125  = win24_23 + win24_24   ;
  assign m01_8_126  = win24_25 + win24_26  ; 
  assign m01_8_127  = win24_27 + win24_28  ; 
  assign m01_8_128  = win24_29 ; 
  
   assign m01_8_201 = m01_8_101 + m01_8_102;
   assign m01_8_202 = m01_8_103 + m01_8_104;
   assign m01_8_203 = m01_8_105 + m01_8_106;
   assign m01_8_204 = m01_8_107 + m01_8_108;
   assign m01_8_205 = m01_8_109 + m01_8_110;
   assign m01_8_206 = m01_8_111 + m01_8_112;
   assign m01_8_207 = m01_8_113 + m01_8_114;
   assign m01_8_208 = m01_8_115 + m01_8_116;
   assign m01_8_209 = m01_8_117 + m01_8_118;
   assign m01_8_210 = m01_8_119 + m01_8_120 ;
   assign m01_8_211 = m01_8_121 + m01_8_122;
   assign m01_8_212 = m01_8_123 + m01_8_124;
   assign m01_8_213 = m01_8_125 + m01_8_126;
   assign m01_8_214 = m01_8_127 + m01_8_128;
   
  
  
  
  
  
  
  
  
  
  assign m01_8_401 = m01_8_301 + m01_8_302;
  assign m01_8_402 = m01_8_303 + m01_8_304; 
  assign m01_8_403 = m01_8_305 + m01_8_306;
  assign m01_8_404 = m01_8_307 + m01_8_308;
  
 
 
  
   wire [8:0] m01_9_101    ;
   wire [8:0] m01_9_102    ;
   wire [8:0] m01_9_103    ;
   wire [8:0] m01_9_104    ;
   wire [8:0] m01_9_105    ;
   wire [8:0] m01_9_106    ;
   wire [8:0] m01_9_107    ;
   wire [8:0] m01_9_108    ;
   wire [8:0] m01_9_109    ;
   wire [8:0] m01_9_110    ;
   wire [8:0] m01_9_111    ;
   wire [8:0] m01_9_112    ;
   wire [8:0] m01_9_113    ;
   wire [8:0] m01_9_114    ;
   wire [8:0] m01_9_115    ;
   wire [8:0] m01_9_116    ;
   wire [8:0] m01_9_117    ;
   wire [8:0] m01_9_118    ;
   wire [8:0] m01_9_119    ;
   wire [8:0] m01_9_120    ;
   wire [8:0] m01_9_121    ;
   wire [8:0] m01_9_122    ;
   wire [8:0] m01_9_123    ;
   wire [8:0] m01_9_124    ;
   wire [8:0] m01_9_125    ;
   wire [8:0] m01_9_126    ;
   wire [9:0] m01_9_201    ;
   wire [9:0] m01_9_202    ;
   wire [9:0] m01_9_203    ;
   wire [9:0] m01_9_204    ;
   wire [9:0] m01_9_205    ;
   wire [9:0] m01_9_206    ;
   wire [9:0] m01_9_207    ;
   wire [9:0] m01_9_208    ;
   wire [9:0] m01_9_209    ;
   wire [9:0] m01_9_210    ;
   wire [9:0] m01_9_211    ;
   wire [9:0] m01_9_212    ;
   wire [9:0] m01_9_213    ;
   wire [9:0] m01_9_214    ;
   reg  [10:0] m01_9_301   ;
   reg  [10:0] m01_9_302   ;
   reg  [10:0] m01_9_303   ;
   reg  [10:0] m01_9_304   ;
   reg  [10:0] m01_9_305   ;
   reg  [10:0] m01_9_306   ;
   reg  [10:0] m01_9_307   ;
   reg  [10:0] m01_9_308   ;
   wire [11:0] m01_9_401   ;
   wire [11:0] m01_9_402   ;
   wire [11:0] m01_9_403   ;
   wire [11:0] m01_9_404   ;
   reg  [12:0] m01_9_501   ;
   reg  [12:0] m01_9_502   ;

   
  
   assign m01_9_101  = win7_4 + win7_5     ;
   assign m01_9_102  = win7_6 + win7_7     ;
   assign m01_9_103  = win7_8 + win7_9     ;
   assign m01_9_104  = win7_10 + win7_11      ;
   assign m01_9_105  = win7_12 + win7_13       ;
   assign m01_9_106  = win7_14 + win7_15       ;
   assign m01_9_107  = win7_16 + win7_17      ;
   assign m01_9_108  = win7_18 + win7_19     ;
   assign m01_9_109  = win7_20 + win7_21     ;
   assign m01_9_110  = win7_22 + win7_23     ;
   assign m01_9_111  = win7_24 + win7_25     ;
   assign m01_9_112  = win7_26 + win7_27     ;
   assign m01_9_113  = win7_28                ;
   assign m01_9_114  = win25_4  + win25_5       ;
   assign m01_9_115  = win25_6  + win25_7        ;
   assign m01_9_116  = win25_8  + win25_9       ;
   assign m01_9_117  = win25_10 + win25_11        ;
   assign m01_9_118  = win25_12 + win25_13         ;
   assign m01_9_119  = win25_14 + win25_15         ;
   assign m01_9_120  = win25_16 + win25_17        ;
   assign m01_9_121  = win25_18 + win25_19       ;
   assign m01_9_122  = win25_20 + win25_21       ;
   assign m01_9_123  = win25_22 + win25_23       ;
   assign m01_9_124  = win25_24 + win25_25       ;
   assign m01_9_125  = win25_26 + win25_27       ;
   assign m01_9_126  = win25_28                 ;
   
   assign m01_9_201 = m01_9_101 + m01_9_102; 
   assign m01_9_202 = m01_9_103 + m01_9_104; 
   assign m01_9_203 = m01_9_105 + m01_9_106; 
   assign m01_9_204 = m01_9_107 + m01_9_108; 
   assign m01_9_205 = m01_9_109 + m01_9_110;  
   assign m01_9_206 = m01_9_111 + m01_9_112;  
   assign m01_9_207 = m01_9_113 ;  
   assign m01_9_208 = m01_9_114 + m01_9_115; 
   assign m01_9_209 = m01_9_116 + m01_9_117; 
   assign m01_9_210 = m01_9_118 + m01_9_119 ; 
   assign m01_9_211 = m01_9_120 + m01_9_121; 
   assign m01_9_212 = m01_9_122 + m01_9_123; 
   assign m01_9_213 = m01_9_124 + m01_9_125; 
   assign m01_9_214 = m01_9_126; 
   
  
  
  
  
  
  
  
  
  
  assign m01_9_401 = m01_9_301 + m01_9_302;
  assign m01_9_402 = m01_9_303 + m01_9_304;     
  assign m01_9_403 = m01_9_305 + m01_9_306;
  assign m01_9_404 = m01_9_307 + m01_9_308;
  
  
  
  
  
  
  wire [8:0] m01_10_101    ;
  wire [8:0] m01_10_102    ;
  wire [8:0] m01_10_103    ;
  wire [8:0] m01_10_104    ;
  wire [8:0] m01_10_105    ;
  wire [8:0] m01_10_106    ;
  wire [8:0] m01_10_107    ;
  wire [8:0] m01_10_108    ;
  wire [8:0] m01_10_109    ;
  wire [8:0] m01_10_110    ;
  wire [8:0] m01_10_111    ;
  wire [8:0] m01_10_112    ;
  wire [8:0] m01_10_113    ;
  wire [8:0] m01_10_114    ;
  wire [8:0] m01_10_115    ;
  wire [8:0] m01_10_116    ;
  wire [8:0] m01_10_117    ;
  wire [8:0] m01_10_118    ;
  wire [8:0] m01_10_119    ;
  wire [8:0] m01_10_120    ;
  wire [8:0] m01_10_121    ;
  wire [8:0] m01_10_122    ;
  wire [8:0] m01_10_123    ;
  wire [8:0] m01_10_124    ;
  wire [9:0] m01_10_201    ;
  wire [9:0] m01_10_202    ;
  wire [9:0] m01_10_203    ;
  wire [9:0] m01_10_204    ;
  wire [9:0] m01_10_205    ;
  wire [9:0] m01_10_206    ;
  wire [9:0] m01_10_207    ;
  wire [9:0] m01_10_208    ;
  wire [9:0] m01_10_209    ;
  wire [9:0] m01_10_210    ;
  wire [9:0] m01_10_211    ;
  wire [9:0] m01_10_212    ;
  reg  [10:0] m01_10_301   ;
  reg  [10:0] m01_10_302   ;
  reg  [10:0] m01_10_303   ;
  reg  [10:0] m01_10_304   ;
  reg  [10:0] m01_10_305   ;
  reg  [10:0] m01_10_306   ;
  wire [11:0] m01_10_401   ;
  wire [11:0] m01_10_402   ;
  wire [11:0] m01_10_403   ;
  wire [11:0] m01_10_404   ;
  reg  [12:0] m01_10_501   ;
  reg  [12:0] m01_10_502   ;
  
  
  
  
  
  
  
  
  
  assign m01_10_101  = win6_5 + win6_6        ;
  assign m01_10_102  = win6_7 + win6_8        ;
  assign m01_10_103  = win6_9 + win6_10        ;
  assign m01_10_104  = win6_11 + win6_12      ;
  assign m01_10_105  = win6_13 + win6_14      ;
  assign m01_10_106  = win6_15 + win6_16      ;
  assign m01_10_107  = win6_17 + win6_18      ;
  assign m01_10_108  = win6_19 + win6_20      ;
  assign m01_10_109  = win6_21 + win6_22      ;
  assign m01_10_110  = win6_23 + win6_24      ;
  assign m01_10_111  = win6_25 + win6_26      ;
  assign m01_10_112  = win6_27       ;      
  assign m01_10_113  = win26_5  + win26_6      ;
  assign m01_10_114  = win26_7  + win26_8      ;
  assign m01_10_115  = win26_9  + win26_10     ;
  assign m01_10_116  = win26_11 + win26_12    ;
  assign m01_10_117  = win26_13 + win26_14    ;
  assign m01_10_118  = win26_15 + win26_16    ;
  assign m01_10_119  = win26_17 + win26_18    ;
  assign m01_10_120  = win26_19 + win26_20    ;
  assign m01_10_121  = win26_21 + win26_22    ;
  assign m01_10_122  = win26_23 + win26_24    ;
  assign m01_10_123  = win26_25 + win26_26    ;
  assign m01_10_124  = win26_27    ;
          
  
  assign m01_10_201 = m01_10_101 + m01_10_102; 
  assign m01_10_202 = m01_10_103 + m01_10_104; 
  assign m01_10_203 = m01_10_105 + m01_10_106; 
  assign m01_10_204 = m01_10_107 + m01_10_108; 
  assign m01_10_205 = m01_10_109 + m01_10_110;   
  assign m01_10_206 = m01_10_111 + m01_10_112;    
  assign m01_10_207 = m01_10_113 + m01_10_114; 
  assign m01_10_208 = m01_10_115 + m01_10_116; 
  assign m01_10_209 = m01_10_117 + m01_10_118; 
  assign m01_10_210 = m01_10_119 + m01_10_120 ; 
  assign m01_10_211 = m01_10_121 + m01_10_122; 
  assign m01_10_212 = m01_10_123 + m01_10_124; 
                       
    
  
    
  
  
  
                            
  assign m01_10_401 = m01_10_301 + m01_10_302;
  assign m01_10_402 = m01_10_303;     
  assign m01_10_403 = m01_10_304 + m01_10_305;
  assign m01_10_404 = m01_10_306;
  
 
   
  
  
  
   wire [8:0] m01_11_101    ;
   wire [8:0] m01_11_102    ;
   wire [8:0] m01_11_103    ;
   wire [8:0] m01_11_104    ;
   wire [8:0] m01_11_105    ;
   wire [8:0] m01_11_106    ;
   wire [8:0] m01_11_107    ;
   wire [8:0] m01_11_108    ;
   wire [8:0] m01_11_109    ;
   wire [8:0] m01_11_110    ;
   wire [8:0] m01_11_111    ;
   wire [8:0] m01_11_112    ;
   wire [8:0] m01_11_113    ;
   wire [8:0] m01_11_114    ;
   wire [8:0] m01_11_115    ;
   wire [8:0] m01_11_116    ;
   wire [8:0] m01_11_117    ;
   wire [8:0] m01_11_118    ;
   wire [8:0] m01_11_119    ;
   wire [8:0] m01_11_120    ;
   wire [8:0] m01_11_121    ;
   wire [8:0] m01_11_122    ;
   wire [9:0] m01_11_201    ;
   wire [9:0] m01_11_202    ;
   wire [9:0] m01_11_203    ;
   wire [9:0] m01_11_204    ;
   wire [9:0] m01_11_205    ;
   wire [9:0] m01_11_206    ;
   wire [9:0] m01_11_207    ;
   wire [9:0] m01_11_208    ;
   wire [9:0] m01_11_209    ;
   wire [9:0] m01_11_210    ;
   wire [9:0] m01_11_211    ;
   wire [9:0] m01_11_212    ;
   reg  [10:0] m01_11_301   ;
   reg  [10:0] m01_11_302   ;
   reg  [10:0] m01_11_303   ;
   reg  [10:0] m01_11_304   ;
   reg  [10:0] m01_11_305   ;
   reg  [10:0] m01_11_306   ;
   wire [11:0] m01_11_401   ;
   wire [11:0] m01_11_402   ;
   wire [11:0] m01_11_403   ;
   wire [11:0] m01_11_404   ;
   reg  [12:0] m01_11_501   ;
   reg  [12:0] m01_11_502   ;
   
   
   
   
   
   assign m01_11_101  = win5_6 + win5_7  ;
   assign m01_11_102  = win5_8 + win5_9  ;
   assign m01_11_103  = win5_10 + win5_11  ;
   assign m01_11_104  = win5_12 + win5_13   ;
   assign m01_11_105  = win5_14 + win5_15    ;
   assign m01_11_106  = win5_16 + win5_17   ;
   assign m01_11_107  = win5_18 + win5_19  ;
   assign m01_11_108  = win5_20 + win5_21  ;
   assign m01_11_109  = win5_22 + win5_23  ;
   assign m01_11_110  = win5_24 + win5_25  ;
   assign m01_11_111  = win5_26             ;
   assign m01_11_112  = win27_6  + win27_7    ;
   assign m01_11_113  = win27_8  + win27_9    ;
   assign m01_11_114  = win27_10 + win27_11    ;
   assign m01_11_115  = win27_12 + win27_13     ;
   assign m01_11_116  = win27_14 + win27_15      ;
   assign m01_11_117  = win27_16 + win27_17     ;
   assign m01_11_118  = win27_18 + win27_19    ;
   assign m01_11_119  = win27_20 + win27_21    ;
   assign m01_11_120  = win27_22 + win27_23    ;
   assign m01_11_121  = win27_24 + win27_25    ;
   assign m01_11_122  = win27_26              ;
    
   assign m01_11_201 = m01_11_101 + m01_11_102; 
   assign m01_11_202 = m01_11_103 + m01_11_104; 
   assign m01_11_203 = m01_11_105 + m01_11_106; 
   assign m01_11_204 = m01_11_107 + m01_11_108; 
   assign m01_11_205 = m01_11_109 + m01_11_110;   
   assign m01_11_206 = m01_11_111 ;  
   assign m01_11_207 = m01_11_112 + m01_11_113; 
   assign m01_11_208 = m01_11_114 + m01_11_115; 
   assign m01_11_209 = m01_11_116 + m01_11_117; 
   assign m01_11_210 = m01_11_118 + m01_11_119 ; 
   assign m01_11_211 = m01_11_120 + m01_11_121; 
   assign m01_11_212 = m01_11_122;  
   
   
   
     
   
   
   
        
   assign m01_11_401 = m01_11_301 + m01_11_302;
   assign m01_11_402 = m01_11_303;     
   assign m01_11_403 = m01_11_304 + m01_11_305;
   assign m01_11_404 = m01_11_306;   
           
   
           
   
  
  
  wire [8:0] m01_12_101;
  wire [8:0] m01_12_102;
  wire [8:0] m01_12_103;
  wire [8:0] m01_12_104;
  wire [8:0] m01_12_105;
  wire [8:0] m01_12_106;
  wire [8:0] m01_12_107;
  wire [8:0] m01_12_108;
  wire [8:0] m01_12_109;
  wire [8:0] m01_12_110;
  wire [8:0] m01_12_111;
  wire [8:0] m01_12_112;
  wire [8:0] m01_12_113;
  wire [8:0] m01_12_114;
  wire [8:0] m01_12_115;
  wire [8:0] m01_12_116;
  wire [8:0] m01_12_117;
  wire [8:0] m01_12_118;
  wire [8:0] m01_12_119;
  wire [8:0] m01_12_120;
  wire [9:0] m01_12_201;
  wire [9:0] m01_12_202;
  wire [9:0] m01_12_203;
  wire [9:0] m01_12_204;
  wire [9:0] m01_12_205;
  wire [9:0] m01_12_206;
  wire [9:0] m01_12_207;
  wire [9:0] m01_12_208;
  wire [9:0] m01_12_209;
  wire [9:0] m01_12_210;
  reg  [10:0] m01_12_301;
  reg  [10:0] m01_12_302;
  reg  [10:0] m01_12_303;
  reg  [10:0] m01_12_304;
  reg  [10:0] m01_12_305;
  reg  [10:0] m01_12_306;
  wire [11:0] m01_12_401;
  wire [11:0] m01_12_402;
  wire [11:0] m01_12_403;
  wire [11:0] m01_12_404;
  reg  [12:0] m01_12_501;
  reg  [12:0] m01_12_502;
  
  
  
  
  
  assign m01_12_101  = win4_7 + win4_8      ;
  assign m01_12_102  = win4_9 + win4_10      ;
  assign m01_12_103  = win4_11 + win4_12      ;
  assign m01_12_104  = win4_13 + win4_14       ;
  assign m01_12_105  = win4_15 + win4_16        ;
  assign m01_12_106  = win4_17 + win4_18      ;
  assign m01_12_107  = win4_19 + win4_20      ;
  assign m01_12_108  = win4_21 + win4_22      ;
  assign m01_12_109  = win4_23 + win4_24      ;
  assign m01_12_110  = win4_25                 ;
  assign m01_12_111  = win28_7  + win28_8         ;
  assign m01_12_112  = win28_9  + win28_10        ;
  assign m01_12_113  = win28_11 + win28_12        ;
  assign m01_12_114  = win28_13 + win28_14         ;
  assign m01_12_115  = win28_15 + win28_16          ;
  assign m01_12_116  = win28_17 + win28_18        ;
  assign m01_12_117  = win28_19 + win28_20        ;
  assign m01_12_118  = win28_21 + win28_22        ;
  assign m01_12_119  = win28_23 + win28_24        ;
  assign m01_12_120  = win28_25                  ;
  
  assign m01_12_201 = m01_12_101 + m01_12_102;
  assign m01_12_202 = m01_12_103 + m01_12_104;
  assign m01_12_203 = m01_12_105 + m01_12_106;
  assign m01_12_204 = m01_12_107 + m01_12_108;
  assign m01_12_205 = m01_12_109 + m01_12_110;       
  assign m01_12_206 = m01_12_111 + m01_12_112;
  assign m01_12_207 = m01_12_113 + m01_12_114;
  assign m01_12_208 = m01_12_115 + m01_12_116;
  assign m01_12_209 = m01_12_117 + m01_12_118;
  assign m01_12_210 = m01_12_119 + m01_12_120 ;
  
 
 
 
 
 
 
  
  assign m01_12_401 = m01_12_301 + m01_12_302;
  assign m01_12_402 = m01_12_303;    
  assign m01_12_403 = m01_12_304 + m01_12_305;
  assign m01_12_404 = m01_12_306;   
         
 
          
 
  
  wire [8:0]  m01_13_101   ;
  wire [8:0]  m01_13_102   ;
  wire [8:0]  m01_13_103   ;
  wire [8:0]  m01_13_104   ;
  wire [8:0]  m01_13_105   ;
  wire [8:0]  m01_13_106   ;
  wire [8:0]  m01_13_107   ;
  wire [8:0]  m01_13_108   ;
  wire [8:0]  m01_13_109   ;
  wire [8:0]  m01_13_110   ;
  wire [8:0]  m01_13_111   ;
  wire [8:0]  m01_13_112   ;
  wire [8:0]  m01_13_113   ;
  wire [8:0]  m01_13_114   ;
  wire [8:0]  m01_13_115   ;
  wire [8:0]  m01_13_116   ;
  wire [8:0]  m01_13_117   ;
  wire [8:0]  m01_13_118   ;
  wire [9:0]  m01_13_201   ;
  wire [9:0]  m01_13_202   ;
  wire [9:0]  m01_13_203   ;
  wire [9:0]  m01_13_204   ;
  wire [9:0]  m01_13_205   ;
  wire [9:0]  m01_13_206   ;
  wire [9:0]  m01_13_207   ;
  wire [9:0]  m01_13_208   ;
  wire [9:0]  m01_13_209   ;
  wire [9:0]  m01_13_210   ;
  reg  [10:0] m01_13_301   ;
  reg  [10:0] m01_13_302   ;
  reg  [10:0] m01_13_303   ;
  reg  [10:0] m01_13_304   ;
  reg  [10:0] m01_13_305   ;
  reg  [10:0] m01_13_306   ;
  wire [11:0] m01_13_401   ;
  wire [11:0] m01_13_402   ;
  wire [11:0] m01_13_403   ;
  wire [11:0] m01_13_404   ;
  reg  [12:0] m01_13_501   ;
  reg  [12:0] m01_13_502   ;
  
  
   assign m01_13_101  =  win3_8 + win3_9   ;
   assign m01_13_102  =  win3_10 + win3_11   ;
   assign m01_13_103  =  win3_12 + win3_13   ;
   assign m01_13_104  =  win3_14 + win3_15    ;
   assign m01_13_105  =  win3_16 + win3_17    ;
   assign m01_13_106  =  win3_18 + win3_19   ;
   assign m01_13_107  =  win3_20 + win3_21   ;
   assign m01_13_108  =  win3_22 + win3_23   ;
   assign m01_13_109  =  win3_24              ;
   assign m01_13_110  =  win29_8  + win29_9      ;
   assign m01_13_111  =  win29_10 + win29_11    ;
   assign m01_13_112  =  win29_12 + win29_13    ;
   assign m01_13_113  =  win29_14 + win29_15     ;
   assign m01_13_114  =  win29_16 + win29_17     ;
   assign m01_13_115  =  win29_18 + win29_19    ;
   assign m01_13_116  =  win29_20 + win29_21    ;
   assign m01_13_117  =  win29_22 + win29_23    ;
   assign m01_13_118  =  win29_24               ;
           
  assign m01_13_201 = m01_13_101 + m01_13_102;
  assign m01_13_202 = m01_13_103 + m01_13_104;
  assign m01_13_203 = m01_13_105 + m01_13_106;
  assign m01_13_204 = m01_13_107 + m01_13_108;   
  assign m01_13_205 = m01_13_109;   
  assign m01_13_206 = m01_13_110 + m01_13_111;
  assign m01_13_207 = m01_13_112 + m01_13_113;
  assign m01_13_208 = m01_13_114 + m01_13_115;
  assign m01_13_209 = m01_13_116 + m01_13_117;
  assign m01_13_210 = m01_13_118 ;  
         
 
 
 
 
 
 
         
  assign m01_13_401 = m01_13_301 + m01_13_302;
  assign m01_13_402 = m01_13_303;     
  assign m01_13_403 = m01_13_304 + m01_13_305;
  assign m01_13_404 = m01_13_306;   
          
 
          
  
  
  
  wire [8:0] m01_14_101    ;
  wire [8:0] m01_14_102    ;
  wire [8:0] m01_14_103    ;
  wire [8:0] m01_14_104    ;
  wire [8:0] m01_14_105    ;
  wire [8:0] m01_14_106    ;
  wire [8:0] m01_14_107    ;
  wire [8:0] m01_14_108    ;
  wire [8:0] m01_14_109    ;
  wire [8:0] m01_14_110    ;
  wire [8:0] m01_14_111    ;
  wire [8:0] m01_14_112    ;
  wire [8:0] m01_14_113    ;
  wire [8:0] m01_14_114    ;
  wire [9:0] m01_14_201   ;
  wire [9:0] m01_14_202   ;
  wire [9:0] m01_14_203   ;
  wire [9:0] m01_14_204   ;
  wire [9:0] m01_14_205   ;
  wire [9:0] m01_14_206   ;
  wire [9:0] m01_14_207   ;
  wire [9:0] m01_14_208   ;
  reg  [10:0] m01_14_301  ;
  reg  [10:0] m01_14_302  ;
  reg  [10:0] m01_14_303  ;
  reg  [10:0] m01_14_304  ;
  wire [11:0] m01_14_401  ;
  wire [11:0] m01_14_402  ;
  reg  [11:0] m01_14_501;
  reg  [11:0] m01_14_502;
  
  
  
  
  
  
  
  
  assign m01_14_101 = win2_10 + win2_11;
  assign m01_14_102 = win2_12 + win2_13;
  assign m01_14_103 = win2_14 + win2_15;
  assign m01_14_104 = win2_16 + win2_17;
  assign m01_14_105 = win2_18 + win2_19;
  assign m01_14_106 = win2_20 + win2_21;
  assign m01_14_107 = win2_22;
  assign m01_14_108 = win30_10 + win30_11 ;
  assign m01_14_109 = win30_12 + win30_13 ;
  assign m01_14_110 = win30_14 + win30_15 ;
  assign m01_14_111 = win30_16 + win30_17 ;
  assign m01_14_112 = win30_18 + win30_19 ;
  assign m01_14_113 = win30_20 + win30_21 ;
  assign m01_14_114 = win30_22 ;
  
  
  assign m01_14_201 = m01_14_101 + m01_14_102;
  assign m01_14_202 = m01_14_103 + m01_14_104;
  assign m01_14_203 = m01_14_105 + m01_14_106;
  assign m01_14_204 = m01_14_107;   
  assign m01_14_205 = m01_14_108 + m01_14_109;
  assign m01_14_206 = m01_14_110 + m01_14_111;
  assign m01_14_207 = m01_14_112 + m01_14_113;
  assign m01_14_208 = m01_14_114;   
          
  
  
  
  
          
  assign m01_14_401 = m01_14_301 + m01_14_302;
  assign m01_14_402 = m01_14_303 + m01_14_304;
          
  
  
   wire [8:0] m01_15_101 ;
   wire [8:0] m01_15_102 ;
   wire [8:0] m01_15_103 ;
   wire [8:0] m01_15_104 ;
   wire [8:0] m01_15_105 ;
   wire [8:0] m01_15_106 ;
   wire [8:0] m01_15_107 ;
   wire [8:0] m01_15_108 ;
   wire [9:0] m01_15_201 ;
   wire [9:0] m01_15_202 ;
   wire [9:0] m01_15_203 ;
   wire [9:0] m01_15_204 ;
   reg  [10:0]   m01_15_301; 
   reg  [10:0]   m01_15_302; 
   reg  [10:0]   m01_15_501;
   reg  [10:0]   m01_15_502;
              
              
              
              
    
    assign m01_15_101 = win1_13 + win1_14;
    assign m01_15_102 = win1_15 + win1_16;
    assign m01_15_103 = win1_17 + win1_18;
    assign m01_15_104 = win1_19;
    assign m01_15_105 =  win31_13 + win31_14;
    assign m01_15_106 =  win31_15 + win31_16;
    assign m01_15_107 =  win31_17 + win31_18;
    assign m01_15_108 =  win31_19;
    
    assign m01_15_201 = m01_15_101 + m01_15_102;
    assign m01_15_202 = m01_15_103 + m01_15_104;
    assign m01_15_203 = m01_15_105 + m01_15_106;
    assign m01_15_204 = m01_15_107 + m01_15_108;
            
    
    
    
    
    always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        begin
          m10_15_301<= 11'd0;
          m10_15_302<= 11'd0;
          m10_14_301<= 11'd0;
          m10_14_302<= 11'd0;
          m10_14_303<= 11'd0;
          m10_14_304<= 11'd0;
          m10_13_301<= 11'd0;
          m10_13_302<= 11'd0;
          m10_13_303<= 11'd0;
          m10_13_304<= 11'd0;
          m10_13_305<= 11'd0;
          m10_13_306<= 11'd0;
          m10_12_301<= 11'd0;
          m10_12_302<= 11'd0;
          m10_12_303<= 11'd0;
          m10_12_304<= 11'd0;
          m10_12_305<= 11'd0;
          m10_12_306<= 11'd0;
          m10_11_301<= 11'd0;
          m10_11_302<= 11'd0;
          m10_11_303<= 11'd0;
          m10_11_304<= 11'd0;
          m10_11_305<= 11'd0;
          m10_11_306<= 11'd0;
          m10_10_301<= 11'd0;
          m10_10_302<= 11'd0;
          m10_10_303<= 11'd0;
          m10_10_304<= 11'd0;
          m10_10_305<= 11'd0;
          m10_10_306<= 11'd0;
          m10_9_301 <= 11'd0;
          m10_9_302 <= 11'd0;
          m10_9_303 <= 11'd0;
          m10_9_304 <= 11'd0;
          m10_9_305 <= 11'd0;
          m10_9_306 <= 11'd0;
          m10_9_307 <= 11'd0;
          m10_9_308 <= 11'd0;
          m10_8_301 <= 11'd0;
          m10_8_302 <= 11'd0;
          m10_8_303 <= 11'd0;
          m10_8_304 <= 11'd0;
          m10_8_305 <= 11'd0;
          m10_8_306 <= 11'd0;
          m10_8_307 <= 11'd0;
          m10_8_308 <= 11'd0;
          m10_7_301 <= 11'd0;
          m10_7_302 <= 11'd0;
          m10_7_303 <= 11'd0;
          m10_7_304 <= 11'd0;
          m10_7_305 <= 11'd0;
          m10_7_306 <= 11'd0;
          m10_7_307 <= 11'd0;
          m10_7_308 <= 11'd0;
          m10_6_301 <= 11'd0;
          m10_6_302 <= 11'd0;
          m10_6_303 <= 11'd0;
          m10_6_304 <= 11'd0;
          m10_6_305 <= 11'd0;
          m10_6_306 <= 11'd0;
          m10_6_307 <= 11'd0;
          m10_6_308 <= 11'd0;
          m10_5_301 <= 11'd0;
          m10_5_302 <= 11'd0;
          m10_5_303 <= 11'd0;
          m10_5_304 <= 11'd0;
          m10_5_305 <= 11'd0;
          m10_5_306 <= 11'd0;
          m10_5_307 <= 11'd0;
          m10_5_308 <= 11'd0;
          m10_4_301 <= 11'd0;
          m10_4_302 <= 11'd0;
          m10_4_303 <= 11'd0;
          m10_4_304 <= 11'd0;
          m10_4_305 <= 11'd0;
          m10_4_306 <= 11'd0;
          m10_4_307 <= 11'd0;
          m10_4_308 <= 11'd0;
          m10_3_301 <= 11'd0;
          m10_3_302 <= 11'd0;
          m10_3_303 <= 11'd0;
          m10_3_304 <= 11'd0;
          m10_3_305 <= 11'd0;
          m10_3_306 <= 11'd0;
          m10_3_307 <= 11'd0;
          m10_3_308 <= 11'd0;
          m10_2_301 <= 11'd0;
          m10_2_302 <= 11'd0;
          m10_2_303 <= 11'd0;
          m10_2_304 <= 11'd0;
          m10_2_305 <= 11'd0;
          m10_2_306 <= 11'd0;
          m10_2_307 <= 11'd0;
          m10_2_308 <= 11'd0;
          m10_1_301 <= 11'd0;
          m10_1_302 <= 11'd0;
          m10_1_303 <= 11'd0;
          m10_1_304 <= 11'd0;
          m10_1_305 <= 11'd0;
          m10_1_306 <= 11'd0;
          m10_1_307 <= 11'd0;
          m10_1_308 <= 11'd0;
          m01_15_301<= 11'd0;
          m01_15_302<= 11'd0;
          m01_14_301<= 11'd0;
          m01_14_302<= 11'd0;
          m01_14_303<= 11'd0;
          m01_14_304<= 11'd0;
          m01_13_301<= 11'd0;
          m01_13_302<= 11'd0;
          m01_13_303<= 11'd0;
          m01_13_304<= 11'd0;
          m01_13_305<= 11'd0;
          m01_13_306<= 11'd0;
          m01_12_301<= 11'd0;
          m01_12_302<= 11'd0;
          m01_12_303<= 11'd0;
          m01_12_304<= 11'd0;
          m01_12_305<= 11'd0;
          m01_12_306<= 11'd0;
          m01_11_301<= 11'd0;
          m01_11_302<= 11'd0;
          m01_11_303<= 11'd0;
          m01_11_304<= 11'd0;
          m01_11_305<= 11'd0;
          m01_11_306<= 11'd0;
          m01_10_301<= 11'd0;
          m01_10_302<= 11'd0;
          m01_10_303<= 11'd0;
          m01_10_304<= 11'd0;
          m01_10_305<= 11'd0;
          m01_10_306<= 11'd0;
          m01_9_301 <= 11'd0;
          m01_9_302 <= 11'd0;
          m01_9_303 <= 11'd0;
          m01_9_304 <= 11'd0;
          m01_9_305 <= 11'd0;
          m01_9_306 <= 11'd0;
          m01_9_307 <= 11'd0;
          m01_9_308 <= 11'd0;
          m01_8_301 <= 11'd0;
          m01_8_302 <= 11'd0;
          m01_8_303 <= 11'd0;
          m01_8_304 <= 11'd0;
          m01_8_305 <= 11'd0;
          m01_8_306 <= 11'd0;
          m01_8_307 <= 11'd0;
          m01_8_308 <= 11'd0;
          m01_7_301 <= 11'd0;
          m01_7_302 <= 11'd0;
          m01_7_303 <= 11'd0;
          m01_7_304 <= 11'd0;
          m01_7_305 <= 11'd0;
          m01_7_306 <= 11'd0;
          m01_7_307 <= 11'd0;
          m01_7_308 <= 11'd0;
          m01_6_301 <= 11'd0;
          m01_6_302 <= 11'd0;
          m01_6_303 <= 11'd0;
          m01_6_304 <= 11'd0;
          m01_6_305 <= 11'd0;
          m01_6_306 <= 11'd0;
          m01_6_307 <= 11'd0;
          m01_6_308 <= 11'd0;
          m01_5_301 <= 11'd0;
          m01_5_302 <= 11'd0;
          m01_5_303 <= 11'd0;
          m01_5_304 <= 11'd0;
          m01_5_305 <= 11'd0;
          m01_5_306 <= 11'd0;
          m01_5_307 <= 11'd0;
          m01_5_308 <= 11'd0;
          m01_4_301 <= 11'd0;
          m01_4_302 <= 11'd0;
          m01_4_303 <= 11'd0;
          m01_4_304 <= 11'd0;
          m01_4_305 <= 11'd0;
          m01_4_306 <= 11'd0;
          m01_4_307 <= 11'd0;
          m01_4_308 <= 11'd0;
          m01_3_301 <= 11'd0;
          m01_3_302 <= 11'd0;
          m01_3_303 <= 11'd0;
          m01_3_304 <= 11'd0;
          m01_3_305 <= 11'd0;
          m01_3_306 <= 11'd0;
          m01_3_307 <= 11'd0;
          m01_3_308 <= 11'd0;
          m01_2_301 <= 11'd0;
          m01_2_302 <= 11'd0;
          m01_2_303 <= 11'd0;
          m01_2_304 <= 11'd0;
          m01_2_305 <= 11'd0;
          m01_2_306 <= 11'd0;
          m01_2_307 <= 11'd0;
          m01_2_308 <= 11'd0;
          m01_1_301 <= 11'd0;
          m01_1_302 <= 11'd0;
          m01_1_303 <= 11'd0;
          m01_1_304 <= 11'd0;
          m01_1_305 <= 11'd0;
          m01_1_306 <= 11'd0;
          m01_1_307 <= 11'd0;
          m01_1_308 <= 11'd0;
        end
      else
        begin
          m10_15_301 <=  m10_15_201 + m10_15_202;
          m10_15_302 <=  m10_15_203 + m10_15_204;
          m10_14_301 <= m10_14_201 + m10_14_202;
          m10_14_302 <= m10_14_203 + m10_14_204;
          m10_14_303 <= m10_14_205 + m10_14_206;
          m10_14_304 <= m10_14_207 + m10_14_208;
          m10_13_301 <= m10_13_201 + m10_13_202;
          m10_13_302 <= m10_13_203 + m10_13_204;
          m10_13_303 <= m10_13_205 ;      
          m10_13_304 <= m10_13_206 + m10_13_207;
          m10_13_305 <= m10_13_208 + m10_13_209;
          m10_13_306 <= m10_13_210;
          m10_12_301 <= m10_12_201 + m10_12_202;
          m10_12_302 <= m10_12_203 + m10_12_204;
          m10_12_303 <= m10_12_205 ;      
          m10_12_304 <= m10_12_206 + m10_12_207;
          m10_12_305 <= m10_12_208 + m10_12_209;
          m10_12_306 <= m10_12_210;
          m10_11_301 <= m10_11_201 + m10_11_202;
          m10_11_302 <= m10_11_203 + m10_11_204;
          m10_11_303 <= m10_11_205 + m10_11_206;
          m10_11_304 <= m10_11_207 + m10_11_208;
          m10_11_305 <= m10_11_209 + m10_11_210;
          m10_11_306 <= m10_11_211 + m10_11_212;
          m10_10_301 <= m10_10_201 + m10_10_202;   
          m10_10_302 <= m10_10_203 + m10_10_204; 
          m10_10_303 <= m10_10_205 + m10_10_206;   
          m10_10_304 <= m10_10_207 + m10_10_208; 
          m10_10_305 <= m10_10_209 + m10_10_210; 
          m10_10_306 <= m10_10_211 + m10_10_212;
          m10_9_301 <= m10_9_201 + m10_9_202; 
          m10_9_302 <= m10_9_203 + m10_9_204; 
          m10_9_303 <= m10_9_205 + m10_9_206; 
          m10_9_304 <= m10_9_207 ; 
          m10_9_305 <= m10_9_208 + m10_9_209; 
          m10_9_306 <= m10_9_210 + m10_9_211;
          m10_9_307 <= m10_9_212 + m10_9_213;
          m10_9_308 <= m10_9_214 ;
          m10_8_301 <= m10_8_201 + m10_8_202;
          m10_8_302 <= m10_8_203 + m10_8_204;
          m10_8_303 <= m10_8_205 + m10_8_206;
          m10_8_304 <= m10_8_207 ;     
          m10_8_305 <= m10_8_208 + m10_8_209;
          m10_8_306 <= m10_8_210 + m10_8_211;
          m10_8_307 <= m10_8_212 + m10_8_213;
          m10_8_308 <= m10_8_214 ;
          m10_7_301 <= m10_7_201 + m10_7_202;
          m10_7_302 <= m10_7_203 + m10_7_204;
          m10_7_303 <= m10_7_205 + m10_7_206;
          m10_7_304 <= m10_7_207 ;     
          m10_7_305 <= m10_7_208 + m10_7_209;
          m10_7_306 <= m10_7_210 + m10_7_211;
          m10_7_307 <= m10_7_212 + m10_7_213;
          m10_7_308 <= m10_7_214 ;
          m10_6_301 <= m10_6_201 + m10_6_202;     
          m10_6_302 <= m10_6_203 + m10_6_204; 
          m10_6_303 <= m10_6_205 + m10_6_206;   
          m10_6_304 <= m10_6_207 + m10_6_208  ;   
          m10_6_305 <= m10_6_209 + m10_6_210; 
          m10_6_306 <= m10_6_211 + m10_6_212;
          m10_6_307 <= m10_6_213 + m10_6_214;
          m10_6_308 <= m10_6_215 + m10_6_216;
          m10_5_301 <= m10_5_201 + m10_5_202;     
          m10_5_302 <= m10_5_203 + m10_5_204; 
          m10_5_303 <= m10_5_205 + m10_5_206;   
          m10_5_304 <= m10_5_207 + m10_5_208    ; 
          m10_5_305 <= m10_5_209 + m10_5_210; 
          m10_5_306 <= m10_5_211 + m10_5_212;
          m10_5_307 <= m10_5_213 + m10_5_214;
          m10_5_308 <= m10_5_215 + m10_5_216;
          m10_4_301 <= m10_4_201 + m10_4_202;   
          m10_4_302 <= m10_4_203 + m10_4_204; 
          m10_4_303 <= m10_4_205 + m10_4_206;   
          m10_4_304 <= m10_4_207 + m10_4_208   ;
          m10_4_305 <= m10_4_209 + m10_4_210; 
          m10_4_306 <= m10_4_211 + m10_4_212;
          m10_4_307 <= m10_4_213 + m10_4_214;
          m10_4_308 <= m10_4_215 + m10_4_216;
          m10_3_301 <= m10_3_201 + m10_3_202;  
          m10_3_302 <= m10_3_203 + m10_3_204; 
          m10_3_303 <= m10_3_205 + m10_3_206;  
          m10_3_304 <= m10_3_207 + m10_3_208  ;
          m10_3_305 <= m10_3_209 + m10_3_210; 
          m10_3_306 <= m10_3_211 + m10_3_212;
          m10_3_307 <= m10_3_213 + m10_3_214;
          m10_3_308 <= m10_3_215 + m10_3_216; 
          m10_2_301 <= m10_2_201 + m10_2_202;   
          m10_2_302 <= m10_2_203 + m10_2_204; 
          m10_2_303 <= m10_2_205 + m10_2_206;   
          m10_2_304 <= m10_2_207 + m10_2_208   ;
          m10_2_305 <= m10_2_209 + m10_2_210; 
          m10_2_306 <= m10_2_211 + m10_2_212;
          m10_2_307 <= m10_2_213 + m10_2_214;
          m10_2_308 <= m10_2_215 + m10_2_216; 
          m10_1_301 <= m10_1_201 + m10_1_202;  
          m10_1_302 <= m10_1_203 + m10_1_204; 
          m10_1_303 <= m10_1_205 + m10_1_206;  
          m10_1_304 <= m10_1_207 + m10_1_208  ;
          m10_1_305 <= m10_1_209 + m10_1_210; 
          m10_1_306 <= m10_1_211 + m10_1_212;
          m10_1_307 <= m10_1_213 + m10_1_214;
          m10_1_308 <= m10_1_215 + m10_1_216;          
          m01_15_301 <=  m01_15_201 + m01_15_202;
          m01_15_302 <=  m01_15_203 + m01_15_204;
          m01_14_301 <= m01_14_201 + m01_14_202;
          m01_14_302 <= m01_14_203 + m01_14_204;
          m01_14_303 <= m01_14_205 + m01_14_206;
          m01_14_304 <= m01_14_207 + m01_14_208;
          m01_13_301 <= m01_13_201 + m01_13_202;
          m01_13_302 <= m01_13_203 + m01_13_204;
          m01_13_303 <= m01_13_205 ;      
          m01_13_304 <= m01_13_206 + m01_13_207;
          m01_13_305 <= m01_13_208 + m01_13_209;
          m01_13_306 <= m01_13_210;
          m01_12_301 <= m01_12_201 + m01_12_202;
          m01_12_302 <= m01_12_203 + m01_12_204;
          m01_12_303 <= m01_12_205 ;      
          m01_12_304 <= m01_12_206 + m01_12_207;
          m01_12_305 <= m01_12_208 + m01_12_209;
          m01_12_306 <= m01_12_210;
          m01_11_301 <= m01_11_201 + m01_11_202;
          m01_11_302 <= m01_11_203 + m01_11_204;
          m01_11_303 <= m01_11_205 + m01_11_206;
          m01_11_304 <= m01_11_207 + m01_11_208;
          m01_11_305 <= m01_11_209 + m01_11_210;
          m01_11_306 <= m01_11_211 + m01_11_212;
          m01_10_301 <= m01_10_201 + m01_10_202;   
          m01_10_302 <= m01_10_203 + m01_10_204; 
          m01_10_303 <= m01_10_205 + m01_10_206;   
          m01_10_304 <= m01_10_207 + m01_10_208; 
          m01_10_305 <= m01_10_209 + m01_10_210; 
          m01_10_306 <= m01_10_211 + m01_10_212;
          m01_9_301 <= m01_9_201 + m01_9_202; 
          m01_9_302 <= m01_9_203 + m01_9_204; 
          m01_9_303 <= m01_9_205 + m01_9_206; 
          m01_9_304 <= m01_9_207 ; 
          m01_9_305 <= m01_9_208 + m01_9_209; 
          m01_9_306 <= m01_9_210 + m01_9_211;
          m01_9_307 <= m01_9_212 + m01_9_213;
          m01_9_308 <= m01_9_214 ;
          m01_8_301 <= m01_8_201 + m01_8_202;
          m01_8_302 <= m01_8_203 + m01_8_204;
          m01_8_303 <= m01_8_205 + m01_8_206;
          m01_8_304 <= m01_8_207 ;     
          m01_8_305 <= m01_8_208 + m01_8_209;
          m01_8_306 <= m01_8_210 + m01_8_211;
          m01_8_307 <= m01_8_212 + m01_8_213;
          m01_8_308 <= m01_8_214 ;
          m01_7_301 <= m01_7_201 + m01_7_202;
          m01_7_302 <= m01_7_203 + m01_7_204;
          m01_7_303 <= m01_7_205 + m01_7_206;
          m01_7_304 <= m01_7_207 ;     
          m01_7_305 <= m01_7_208 + m01_7_209;
          m01_7_306 <= m01_7_210 + m01_7_211;
          m01_7_307 <= m01_7_212 + m01_7_213;
          m01_7_308 <= m01_7_214 ;
          m01_6_301 <= m01_6_201 + m01_6_202;     
          m01_6_302 <= m01_6_203 + m01_6_204; 
          m01_6_303 <= m01_6_205 + m01_6_206;   
          m01_6_304 <= m01_6_207 + m01_6_208  ;   
          m01_6_305 <= m01_6_209 + m01_6_210; 
          m01_6_306 <= m01_6_211 + m01_6_212;
          m01_6_307 <= m01_6_213 + m01_6_214;
          m01_6_308 <= m01_6_215 + m01_6_216;
          m01_5_301 <= m01_5_201 + m01_5_202;     
          m01_5_302 <= m01_5_203 + m01_5_204; 
          m01_5_303 <= m01_5_205 + m01_5_206;   
          m01_5_304 <= m01_5_207 + m01_5_208    ; 
          m01_5_305 <= m01_5_209 + m01_5_210; 
          m01_5_306 <= m01_5_211 + m01_5_212;
          m01_5_307 <= m01_5_213 + m01_5_214;
          m01_5_308 <= m01_5_215 + m01_5_216;
          m01_4_301 <= m01_4_201 + m01_4_202;   
          m01_4_302 <= m01_4_203 + m01_4_204; 
          m01_4_303 <= m01_4_205 + m01_4_206;   
          m01_4_304 <= m01_4_207 + m01_4_208   ;
          m01_4_305 <= m01_4_209 + m01_4_210; 
          m01_4_306 <= m01_4_211 + m01_4_212;
          m01_4_307 <= m01_4_213 + m01_4_214;
          m01_4_308 <= m01_4_215 + m01_4_216;
          m01_3_301 <= m01_3_201 + m01_3_202;  
          m01_3_302 <= m01_3_203 + m01_3_204; 
          m01_3_303 <= m01_3_205 + m01_3_206;  
          m01_3_304 <= m01_3_207 + m01_3_208  ;
          m01_3_305 <= m01_3_209 + m01_3_210; 
          m01_3_306 <= m01_3_211 + m01_3_212;
          m01_3_307 <= m01_3_213 + m01_3_214;
          m01_3_308 <= m01_3_215 + m01_3_216; 
          m01_2_301 <= m01_2_201 + m01_2_202;   
          m01_2_302 <= m01_2_203 + m01_2_204; 
          m01_2_303 <= m01_2_205 + m01_2_206;   
          m01_2_304 <= m01_2_207 + m01_2_208   ;
          m01_2_305 <= m01_2_209 + m01_2_210; 
          m01_2_306 <= m01_2_211 + m01_2_212;
          m01_2_307 <= m01_2_213 + m01_2_214;
          m01_2_308 <= m01_2_215 + m01_2_216; 
          m01_1_301 <= m01_1_201 + m01_1_202;  
          m01_1_302 <= m01_1_203 + m01_1_204; 
          m01_1_303 <= m01_1_205 + m01_1_206;  
          m01_1_304 <= m01_1_207 + m01_1_208  ;
          m01_1_305 <= m01_1_209 + m01_1_210; 
          m01_1_306 <= m01_1_211 + m01_1_212;
          m01_1_307 <= m01_1_213 + m01_1_214;
          m01_1_308 <= m01_1_215 + m01_1_216; 
        end
    end
    
          
          
              
    
      always@(posedge clk or negedge rst_n)   
begin
  if(!rst_n)
    begin
      fast <= 1'b0;
      //m10_temp <= 21'b000000000000000000000;
      //m01_temp <= 21'b000000000000000000000;
    end
  else if(count_tp_2>=35 && count_tp_2<=674 && sel_tp_2==0)
    begin
      fast <= fast_or_not;
      //m10_temp <= m10_15 + m10_14 + m10_13 + m10_12 + m10_11 + m10_10 + m10_9 + m10_8 + m10_7 + m10_6 + m10_5 + m10_4 + m10_3 + m10_2 + m10_1;
      //m01_temp <= m01_15 + m01_14 + m01_13 + m01_12 + m01_11 + m01_10 + m01_9 + m01_8 + m01_7 + m01_6 + m01_5 + m01_4 + m01_3 + m01_2 + m01_1;
    end
  else if(count_tp_2>674)
    begin
      fast <= 1'b0; 
     //m10_temp <= 21'b000000000000000000000;
     //m01_temp <= 21'b000000000000000000000;
   end   
end

 always@(posedge clk or negedge rst_n)   
begin
  if(!rst_n) 
    begin
      fast_tp_1 <= 1'b0;  
      fast_tp_2 <= 1'b0;
      dout <= 20'd0; 
    end     
  else
    begin 
      fast_tp_1 <= fast;
      fast_tp_2 <= fast_tp_1;
      dout <= dout_tp_1;
    end
end

 always@(posedge clk or negedge rst_n)   
begin
  if(!rst_n)
    begin
       m10_15 <= 14'd0;
       m10_14 <= 14'd0;
       m10_13 <= 14'd0;
       m10_12 <= 14'd0;
       m10_11 <= 14'd0;
       m10_10 <= 14'd0;
       m10_9  <= 14'd0;
       m10_8  <= 14'd0;
       m10_7  <= 14'd0;
       m10_6  <= 14'd0;
       m10_5  <= 14'd0;
       m10_4  <= 14'd0;
       m10_3  <= 14'd0;
       m10_2  <= 14'd0;
       m10_1  <= 14'd0;
       m01_15 <= 14'd0;
       m01_14 <= 14'd0;
       m01_13 <= 14'd0;
       m01_12 <= 14'd0;
       m01_11 <= 14'd0;
       m01_10 <= 14'd0;
       m01_9  <= 14'd0;
       m01_8  <= 14'd0;
       m01_7  <= 14'd0;
       m01_6  <= 14'd0;
       m01_5  <= 14'd0;
       m01_4  <= 14'd0;
       m01_3  <= 14'd0;
       m01_2  <= 14'd0;
       m01_1  <= 14'd0;
    end
  else 
    begin
      m10_15 <= m10_15_501 - m10_15_502;
      m10_14 <= m10_14_501 - m10_14_502;
      m10_13 <= m10_13_501 - m10_13_502;
      m10_12 <= m10_12_501 - m10_12_502;
      m10_11 <= m10_11_501 - m10_11_502;
      m10_10 <= m10_10_501 - m10_10_502;
      m10_9 <= m10_9_501 - m10_9_502;
      m10_8 <= m10_8_501 - m10_8_502;
      m10_7 <= m10_7_501 - m10_7_502;
      m10_6 <= m10_6_501 - m10_6_502;
      m10_5 <= m10_5_501 - m10_5_502;
      m10_4 <= m10_4_501 - m10_4_502;
      m10_3 <= m10_3_501 - m10_3_502;
      m10_2 <= m10_2_501 - m10_2_502;
      m10_1 <= m10_1_501 - m10_1_502;
      m01_15 <= m01_15_501 - m01_15_502;
      m01_14 <= m01_14_501 - m01_14_502;
      m01_13 <= m01_13_501 - m01_13_502;
      m01_12 <= m01_12_501 - m01_12_502;
      m01_11 <= m01_11_501 - m01_11_502;
      m01_10 <= m01_10_501 - m01_10_502;
      m01_9 <= m01_9_501 - m01_9_502;
      m01_8 <= m01_8_501 - m01_8_502;
      m01_7 <= m01_7_501 - m01_7_502;
      m01_6 <= m01_6_501 - m01_6_502;
      m01_5 <= m01_5_501 - m01_5_502;
      m01_4 <= m01_4_501 - m01_4_502;
      m01_3 <= m01_3_501 - m01_3_502;
      m01_2 <= m01_2_501 - m01_2_502;
      m01_1 <= m01_1_501 - m01_1_502;      
    end
end

always@(posedge clk or negedge rst_n)   
begin
  if(!rst_n)
    begin
      m10_101 <= 18'd0;
      m10_102 <= 18'd0;
      m10_103 <= 18'd0;
      m10_104 <= 18'd0;
      m10_105 <= 18'd0;
      m10_106 <= 18'd0;
      m10_107 <= 18'd0;     
      m10_108 <= 18'd0;
      m01_101 <= 18'd0;
      m01_102 <= 18'd0;
      m01_103 <= 18'd0;
      m01_104 <= 18'd0;
      m01_105 <= 18'd0;
      m01_106 <= 18'd0;
      m01_107 <= 18'd0;
      m01_108 <= 18'd0;
    end
  else
    begin
      m10_101 <= m10_1x1 + m10_2x2;
      m10_102 <= m10_3x3 + m10_4x4;
      m10_103 <= m10_5x5 + m10_6x6;
      m10_104 <= m10_7x7 + m10_8x8;
      m10_105 <= m10_9x9 + m10_10x10;
      m10_106 <= m10_11x11 + m10_12x12;
      m10_107 <= m10_13x13 + m10_14x14;
      m10_108 <= m10_15x15;
      m01_101 <= m01_1x1 + m01_2x2;
      m01_102 <= m01_3x3 + m01_4x4;
      m01_103 <= m01_5x5 + m01_6x6;
      m01_104 <= m01_7x7 + m01_8x8;
      m01_105 <= m01_9x9 + m01_10x10;
      m01_106 <= m01_11x11 + m01_12x12;
      m01_107 <= m01_13x13 + m01_14x14;
      m01_108 <= m01_15x15;
    end
end

    always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        begin
          m10_15_501 <= 11'd0;
          m10_15_502 <= 11'd0;
          m10_14_501 <= 12'd0;
          m10_14_502 <= 12'd0;
          m10_13_501 <= 13'd0;
          m10_13_502 <= 13'd0;
          m10_12_501 <= 13'd0;
          m10_12_502 <= 13'd0;
          m10_11_501 <= 13'd0;
          m10_11_502 <= 13'd0;
          m10_10_501 <= 13'd0;
          m10_10_502 <= 13'd0;
          m10_9_501  <= 13'd0;
          m10_9_502  <= 13'd0;
          m10_8_501  <= 13'd0;
          m10_8_502  <= 13'd0;
          m10_7_501  <= 13'd0;
          m10_7_502  <= 13'd0;
          m10_6_501  <= 13'd0;
          m10_6_502  <= 13'd0;
          m10_5_501  <= 13'd0;
          m10_5_502  <= 13'd0;
          m10_4_501  <= 13'd0;
          m10_4_502  <= 13'd0;
          m10_3_501  <= 13'd0;
          m10_3_502  <= 13'd0;
          m10_2_501  <= 13'd0;
          m10_2_502  <= 13'd0;
          m10_1_501  <= 13'd0;
          m10_1_502  <= 13'd0;
          m01_15_501 <= 11'd0;
          m01_15_502 <= 11'd0;
          m01_14_501 <= 12'd0;
          m01_14_502 <= 12'd0;
          m01_13_501 <= 13'd0;
          m01_13_502 <= 13'd0;
          m01_12_501 <= 13'd0;
          m01_12_502 <= 13'd0;
          m01_11_501 <= 13'd0;
          m01_11_502 <= 13'd0;
          m01_10_501 <= 13'd0;
          m01_10_502 <= 13'd0;
          m01_9_501  <= 13'd0;
          m01_9_502  <= 13'd0;
          m01_8_501  <= 13'd0;
          m01_8_502  <= 13'd0;
          m01_7_501  <= 13'd0;
          m01_7_502  <= 13'd0;
          m01_6_501  <= 13'd0;
          m01_6_502  <= 13'd0;
          m01_5_501  <= 13'd0;
          m01_5_502  <= 13'd0;
          m01_4_501  <= 13'd0;
          m01_4_502  <= 13'd0;
          m01_3_501  <= 13'd0;
          m01_3_502  <= 13'd0;
          m01_2_501  <= 13'd0;
          m01_2_502  <= 13'd0;
          m01_1_501  <= 13'd0;
          m01_1_502  <= 13'd0;
        end
      else
        begin
          m10_15_501 <= m10_15_301;
          m10_15_502 <= m10_15_302;
          m10_14_501 <= m10_14_401;
          m10_14_502 <= m10_14_402;
          m10_13_501 <= m10_13_401 + m10_13_402;
          m10_13_502 <= m10_13_403 + m10_13_404;
          m10_12_501 <= m10_12_401 + m10_12_402;
          m10_12_502 <= m10_12_403 + m10_12_404;
          m10_11_501 <= m10_11_401 + m10_11_402;
          m10_11_502 <= m10_11_403 + m10_11_404;
          m10_10_501 <= m10_10_401 + m10_10_402;
          m10_10_502 <= m10_10_403 + m10_10_404;
          m10_9_501 <= m10_9_401 + m10_9_402;
          m10_9_502 <= m10_9_403 + m10_9_404;
          m10_8_501 <= m10_8_401 + m10_8_402;
          m10_8_502 <= m10_8_403 + m10_8_404;
          m10_7_501 <= m10_7_401 + m10_7_402;
          m10_7_502 <= m10_7_403 + m10_7_404;
          m10_6_501 <= m10_6_401 + m10_6_402;
          m10_6_502 <= m10_6_403 + m10_6_404;
          m10_5_501 <= m10_5_401 + m10_5_402;
          m10_5_502 <= m10_5_403 + m10_5_404;
          m10_4_501 <= m10_4_401 + m10_4_402;
          m10_4_502 <= m10_4_403 + m10_4_404;
          m10_3_501 <= m10_3_401 + m10_3_402;
          m10_3_502 <= m10_3_403 + m10_3_404;
          m10_2_501 <= m10_2_401 + m10_2_402;
          m10_2_502 <= m10_2_403 + m10_2_404;
          m10_1_501 <= m10_1_401 + m10_1_402;
          m10_1_502 <= m10_1_403 + m10_1_404;
          m01_15_501 <= m01_15_301;
          m01_15_502 <= m01_15_302;
          m01_14_501 <= m01_14_401;
          m01_14_502 <= m01_14_402;
          m01_13_501 <= m01_13_401 + m01_13_402;
          m01_13_502 <= m01_13_403 + m01_13_404;
          m01_12_501 <= m01_12_401 + m01_12_402;
          m01_12_502 <= m01_12_403 + m01_12_404;
          m01_11_501 <= m01_11_401 + m01_11_402;
          m01_11_502 <= m01_11_403 + m01_11_404;
          m01_10_501 <= m01_10_401 + m01_10_402;
          m01_10_502 <= m01_10_403 + m01_10_404;
          m01_9_501 <= m01_9_401 + m01_9_402;
          m01_9_502 <= m01_9_403 + m01_9_404;
          m01_8_501 <= m01_8_401 + m01_8_402;
          m01_8_502 <= m01_8_403 + m01_8_404;
          m01_7_501 <= m01_7_401 + m01_7_402;
          m01_7_502 <= m01_7_403 + m01_7_404;
          m01_6_501 <= m01_6_401 + m01_6_402;
          m01_6_502 <= m01_6_403 + m01_6_404;
          m01_5_501 <= m01_5_401 + m01_5_402;
          m01_5_502 <= m01_5_403 + m01_5_404;
          m01_4_501 <= m01_4_401 + m01_4_402;
          m01_4_502 <= m01_4_403 + m01_4_404;
          m01_3_501 <= m01_3_401 + m01_3_402;
          m01_3_502 <= m01_3_403 + m01_3_404;
          m01_2_501 <= m01_2_401 + m01_2_402;
          m01_2_502 <= m01_2_403 + m01_2_404;
          m01_1_501 <= m01_1_401 + m01_1_402;
          m01_1_502 <= m01_1_403 + m01_1_404;
        end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        begin
          m10_301 <= 20'd0;
          m10_302 <= 20'd0;
          m01_301 <= 20'd0;
          m01_302 <= 20'd0;
        end
      else
        begin
           m10_301 <= m10_201 + m10_202;
           m10_302 <= m10_203 + m10_204;
           m01_301 <= m01_201 + m01_202;
           m01_302 <= m01_203 + m01_204;
         end
    end
          
        
          

   // assign m10_15 = 15*(win16_31 + win15_31 + win14_31 + win13_31 + win17_31 + win18_31 + win19_31 - win16_1 - win15_1 - win14_1 
  //                      - win13_1 - win17_1 - win18_1 - win19_1);
                         
 //   assign m10_14 = 14*(win16_30 + win15_30 + win14_30 + win13_30 + win12_30 + win11_30 + win10_30 + win17_30 + win18_30 + win19_30 
 //                       + win20_30 + win21_30 + win22_30 - win16_2 - win15_2 - win14_2 - win13_2 - win12_2 - win11_2 - win10_2 - win17_2
  //                      - win18_2 - win19_2 - win20_2 - win21_2 - win22_2); 
 //   assign m10_13 = 13*(win16_29 + win15_29 + win14_29 + win13_29 + win12_29 + win11_29 + win10_29 + win9_29 + win8_29 + win17_29 
 //                       + win18_29 + win19_29 + win20_29 + win21_29 + win22_29 + win23_29 + win24_29 - win16_3 - win15_3 - win14_3 
//                        - win13_3 - win12_3 - win11_3 - win10_3 - win9_3 - win8_3 - win17_3 - win18_3 - win19_3 - win20_3 - win21_3 
 //                       - win22_3 - win23_3 - win24_3);
 //   assign m10_12 = 12*(win16_28 + win15_28 + win14_28 + win13_28 + win12_28 + win11_28 + win10_28 + win9_28 + win8_28 + win7_28 
                    
//    + win17_28 + win18_28 + win19_28 + win20_28 + win21_28 + win22_28 + win23_28 + win24_28 + win25_28 - win16_4
                  
 //     - win15_4 - win14_4 - win13_4 - win12_4 - win11_4 - win10_4 - win9_4 - win8_4 - win7_4 - win17_4 - win18_4 
                  
 //     - win19_4 - win20_4 - win21_4 - win22_4 - win23_4 - win24_4 - win25_4);
 //   assign m10_11 = 11*(win16_27 + win15_27 + win14_27 + win13_27 + win12_27 + win11_27 + win10_27 + win9_27 + win8_27 + win7_27 + win6_27 
                    
 //   + win17_27 + win18_27 + win19_27 + win20_27 + win21_27 + win22_27 + win23_27 + win24_27 + win25_27 + win26_27 
                    
 //   - win16_5 - win15_5 - win14_5 - win13_5 - win12_5 - win11_5 - win10_5 - win9_5 - win8_5 - win7_5 - win6_5 
                    
 //   - win17_5 - win18_5 - win19_5 - win20_5 - win21_5 - win22_5 - win23_5 - win24_5 - win25_5 - win26_5); 
 //   assign m10_10 = 
//10*(win16_26 + win15_26 + win14_26 + win13_26 + win12_26 + win11_26 + win10_26 + win9_26 + win8_26 + win7_26 + win6_26
                  
//      + win5_26 + win17_26 + win18_26 + win19_26 + win20_26 + win21_26 + win22_26 + win23_26 + win24_26 + win25_26 
//                  
 //     + win26_26 + win27_26 - win16_6 - win15_6 - win14_6 - win13_6 - win12_6 - win11_6 - win10_6 - win9_6 - win8_6 
                  
 //     - win7_6 - win6_6 - win5_6 - win17_6 - win18_6 - win19_6 - win20_6 - win21_6 - win22_6 - win23_6 - win24_6 - win25_6
                 
  //     - win26_6 - win27_6);
  //  assign m10_9  =  9*(win16_25 + win15_25 + win14_25 + win13_25 + win12_25 + win11_25 + win10_25 + win9_25 + win8_25 + win7_25 + win6_25
                  
 //     + win5_25 + win4_25 + win17_25 + win18_25 + win19_25 + win20_25 + win21_25 + win22_25 + win23_25 + win24_25 
                  
 //     + win25_25 + win26_25 + win27_25 + win28_25 - win16_7 - win15_7 - win14_7 - win13_7 - win12_7 - win11_7 - win10_7 
                  
  //    - win9_7 - win8_7 - win7_7 - win6_7 - win5_7 - win4_7 - win17_7 - win18_7 - win19_7 - win20_7 - win21_7 - win22_7 
                  
 //     - win23_7 - win24_7 - win25_7 - win26_7 - win27_7 - win28_7);
  //  assign m10_8  =  8*(win16_24 + win15_24 + win14_24 + win13_24 + win12_24 + win11_24 + win10_24 + win9_24 + win8_24 + win7_24 + win6_24
                  
  //    + win5_24 + win4_24 + win3_24 + win17_24 + win18_24 + win19_24 + win20_24 + win21_24 + win22_24 + win23_24 + win24_24 
                  
  //    + win25_24 + win26_24 + win27_24 + win28_24 + win29_24 - win16_8 - win15_8 - win14_8 - win13_8 - win12_8 - win11_8 
                  
   //   - win10_8 - win9_8 - win8_8 - win7_8 - win6_8 - win5_8 - win4_8 - win3_8 - win17_8 - win18_8 - win19_8 - win20_8 
                  
   //   - win21_8 - win22_8 - win23_8 - win24_8 - win25_8 - win26_8 - win27_8 - win28_8 - win29_8);
  //  assign m10_7  =  7*(win16_23 + win15_23 + win14_23 + win13_23 + win12_23 + win11_23 + win10_23 + win9_23 + win8_23 + win7_23 + win6_23
                  
  //    + win5_23 + win4_23 + win3_23 + win17_23 + win18_23 + win19_23 + win20_23 + win21_23 + win22_23 + win23_23 + win24_23 
                  
  //    + win25_23 + win26_23 + win27_23 + win28_23 + win29_23 - win16_9 - win15_9 - win14_9 - win13_9 - win12_9 - win11_9 
                  
  //    - win10_9 - win9_9 - win8_9 - win7_9 - win6_9 - win5_9 - win4_9 - win3_9 - win17_9 - win18_9 - win19_9 - win20_9 
                  
   //   - win21_9 - win22_9 - win23_9 - win24_9 - win25_9 - win26_9 - win27_9 - win28_9 - win29_9);
  //  assign m10_6  =  6*(win16_22 + win15_22 + win14_22 + win13_22 + win12_22 + win11_22 + win10_22 + win9_22 + win8_22 + win7_22 + win6_22
                  
   //   + win5_22 + win4_22 + win3_22 + win2_22 + win17_22 + win18_22 + win19_22 + win20_22 + win21_22 + win22_22 + win23_22 + win24_22 
                  
   //   + win25_22 + win26_22 + win27_22 + win28_22 + win29_22 + win30_22 - win16_10 - win15_10 - win14_10 - win13_10 - win12_10
                 
    //   - win11_10 - win10_10 - win9_10 - win8_10 - win7_10 - win6_10 - win5_10 - win4_10 - win3_10 - win2_10 - win17_10 - win18_10
               
     //    - win19_10 - win20_10 - win21_10 - win22_10 - win23_10 - win24_10 - win25_10 - win26_10 - win27_10 - win28_10 - win29_10
               
 //        - win30_10);
 //   assign m10_5  =  5*(win16_21 + win15_21 + win14_21 + win13_21 + win12_21 + win11_21 + win10_21 + win9_21 + win8_21 + win7_21 + win6_21
                  
 //     + win5_21 + win4_21 + win3_21 + win2_21 + win17_21 + win18_21 + win19_21 + win20_21 + win21_21 + win22_21 + win23_21 + win24_21 
                  
 //    + win25_21 + win26_21 + win27_21 + win28_21 + win29_21 + win30_21 - win16_11 - win15_11 - win14_11 - win13_11 - win12_11
                 
  //     - win11_11 - win10_11 - win9_11 - win8_11 - win7_11 - win6_11 - win5_11 - win4_11 - win3_11 - win2_11 - win17_11 - win18_11
               
  //       - win19_11 - win20_11 - win21_11 - win22_11 - win23_11 - win24_11 - win25_11 - win26_11 - win27_11 - win28_11 - win29_11
               
  //       - win30_11);
 //   assign m10_4  =  4*(win16_20 + win15_20 + win14_20 + win13_20 + win12_20 + win11_20 + win10_20 + win9_20 + win8_20 + win7_20 + win6_20
                  
 //     + win5_20 + win4_20 + win3_20 + win2_20 + win17_20 + win18_20 + win19_20 + win20_20 + win21_20 + win22_20 + win23_20 + win24_20 
                  
 //     + win25_20 + win26_20 + win27_20 + win28_20 + win29_20 + win30_20 - win16_12 - win15_12 - win14_12 - win13_12 - win12_12
                 
  //     - win11_12 - win10_12 - win9_12 - win8_12 - win7_12 - win6_12 - win5_12 - win4_12 - win3_12 - win2_12 - win17_12 - win18_12
               
    //     - win19_12 - win20_12 - win21_12 - win22_12 - win23_12 - win24_12 - win25_12 - win26_12 - win27_12 - win28_12 - win29_12
               
    //     - win30_12);
  //  assign m10_3  =  3*(win16_19 + win15_19 + win14_19 + win13_19 + win12_19 + win11_19 + win10_19 + win9_19 + win8_19 + win7_19 + win6_19
                  
  //    + win5_19 + win4_19 + win3_19 + win2_19 + win1_19 + win17_19 + win18_19 + win19_19 + win20_19 + win21_19 + win22_19 + win23_19 
                  
    //  + win24_19 + win25_19 + win26_19 + win27_19 + win28_19 + win29_19 + win30_19 + win31_19 - win16_13 - win15_13 - win14_13 
                  
   //   - win13_13 - win12_13 - win11_13 - win10_13 - win9_13 - win8_13 - win7_13 - win6_13 - win5_13 - win4_13 - win3_13 - win2_13
                
    //    - win1_13 - win17_13 - win18_13 - win19_13 - win20_13 - win21_13 - win22_13 - win23_13 - win24_13 - win25_13 - win26_13 
                
   //     - win27_13 - win28_13 - win29_13 - win30_13 - win31_13);
//    assign m10_2  =  2*(win16_18 + win15_18 + win14_18 + win13_18 + win12_18 + win11_18 + win10_18 + win9_18 + win8_18 + win7_18 + win6_18
                  
   //   + win5_18 + win4_18 + win3_18 + win2_18 + win1_18 + win17_18 + win18_18 + win19_18 + win20_18 + win21_18 + win22_18 + win23_18 
                  
   //   + win24_18 + win25_18 + win26_18 + win27_18 + win28_18 + win29_18 + win30_18 + win31_18 - win16_14 - win15_14 - win14_14 
                  
   //   - win13_14 - win12_14 - win11_14 - win10_14 - win9_14 - win8_14 - win7_14 - win6_14 - win5_14 - win4_14 - win3_14 - win2_14
                
    //    - win1_14 - win17_14 - win18_14 - win19_14 - win20_14 - win21_14 - win22_14 - win23_14 - win24_14 - win25_14 - win26_14 
                
     //   - win27_14 - win28_14 - win29_14 - win30_14 - win31_14);
 //   assign m10_1  =  1*(win16_17 + win15_17 + win14_17 + win13_17 + win12_17 + win11_17 + win10_17 + win9_17 + win8_17 + win7_17 + win6_17
                  
  //    + win5_17 + win4_17 + win3_17 + win2_17 + win1_17 + win17_17 + win18_17 + win19_17 + win20_17 + win21_17 + win22_17 + win23_17 
                  
   //   + win24_17 + win25_17 + win26_17 + win27_17 + win28_17 + win29_17 + win30_17 + win31_17 - win16_15 - win15_15 - win14_15 
                  
   //   - win13_15 - win12_15 - win11_15 - win10_15 - win9_15 - win8_15 - win7_15 - win6_15 - win5_15 - win4_15 - win3_15 - win2_15
                
    //    - win1_15 - win17_15 - win18_15 - win19_15 - win20_15 - win21_15 - win22_15 - win23_15 - win24_15 - win25_15 - win26_15 
                
     //   - win27_15 - win28_15 - win29_15 - win30_15 - win31_15);       
 
 //  assign m01_1  =  1*(win15_1 + win15_2 + win15_3 + win15_4 + win15_5 + win15_6 + win15_7 + win15_8 + win15_9 + win15_10 + win15_11 + win15_12 
 
       //                + win15_13 + win15_14 + win15_15 + win15_16 + win15_17 + win15_18 + win15_19 + win15_20 + win15_21 + win15_22 + win15_23
 
      //                 + win15_24 + win15_25 + win15_26 + win15_27 + win15_28 + win15_29 + win15_30 + win15_31 - win17_1 - win17_2 - win17_3 - win17_4 
 
       //                - win17_5 - win17_6 - win17_7 - win17_8 - win17_9 - win17_10 - win17_11 - win17_12 - win17_13 - win17_14 - win17_15 - win17_16 
 
        //               - win17_17 - win17_18 - win17_19 - win17_20 - win17_21 - win17_22 - win17_23 - win17_24 - win17_25 - win17_26 - win17_27 - win17_28
 
       //                - win17_29 - win17_30 - win17_31);
 
//   assign m01_2  =  2*(win14_1 + win14_2 + win14_3 + win14_4 + win14_5 + win14_6 + win14_7 + win14_8 + win14_9 + win14_10 + win14_11 + win14_12 
 //
     //                  + win14_13 + win14_14 + win14_15 + win14_16 + win14_17 + win14_18 + win14_19 + win14_20 + win14_21 + win14_22 + win14_23
 //
        //               + win14_24 + win14_25 + win14_26 + win14_27 + win14_28 + win14_29 + win14_30 + win14_31 - win18_1 - win18_2 - win18_3 - win18_4 
 //
             //          - win18_5 - win18_6 - win18_7 - win18_8 - win18_9 - win18_10 - win18_11 - win18_12 - win18_13 - win18_14 - win18_15 - win18_16 
 
           //            - win18_17 - win18_18 - win18_19 - win18_20 - win18_21 - win18_22 - win18_23 - win18_24 - win18_25 - win18_26 - win18_27 - win18_28
 
            //           - win18_29 - win18_30 - win18_31);
 
 //  assign m01_3  =  3*(win13_1 + win13_2 + win13_3 + win13_4 + win13_5 + win13_6 + win13_7 + win13_8 + win13_9 + win13_10 + win13_11 + win13_12 
 
     //                  + win13_13 + win13_14 + win13_15 + win13_16 + win13_17 + win13_18 + win13_19 + win13_20 + win13_21 + win13_22 + win13_23
 
         //              + win13_24 + win13_25 + win13_26 + win13_27 + win13_28 + win13_29 + win13_30 + win13_31 - win19_1 - win19_2 - win19_3 - win19_4 
 
          //             - win19_5 - win19_6 - win19_7 - win19_8 - win19_9 - win19_10 - win19_11 - win19_12 - win19_13 - win19_14 - win19_15 - win19_16 
 
             //          - win19_17 - win19_18 - win19_19 - win19_20 - win19_21 - win19_22 - win19_23 - win19_24 - win19_25 - win19_26 - win19_27 - win19_28
 
            //           - win19_29 - win19_30 - win19_31);
 
//   assign m01_4  =  4*(win12_2 + win12_3 + win12_4 + win12_5 + win12_6 + win12_7 + win12_8 + win12_9 + win12_10 + win12_11 + win12_12 
 
        //               + win12_13 + win12_14 + win12_15 + win12_16 + win12_17 + win12_18 + win12_19 + win12_20 + win12_21 + win12_22 + win12_23
 
         //              + win12_24 + win12_25 + win12_26 + win12_27 + win12_28 + win12_29 + win12_30 - win20_2 - win20_3 - win20_4 
 
          //             - win20_5 - win20_6 - win20_7 - win20_8 - win20_9 - win20_10 - win20_11 - win20_12 - win20_13 - win20_14 - win20_15 - win20_16 
 
              //         - win20_17 - win20_18 - win20_19 - win20_20 - win20_21 - win20_22 - win20_23 - win20_24 - win20_25 - win20_26 - win20_27 - win20_28
 
                  //     - win20_29 - win20_30);
 
 //  assign m01_5  =  5*(win11_2 + win11_3 + win11_4 + win11_5 + win11_6 + win11_7 + win11_8 + win11_9 + win11_10 + win11_11 + win11_12 
 
   //                    + win11_13 + win11_14 + win11_15 + win11_16 + win11_17 + win11_18 + win11_19 + win11_20 + win11_21 + win11_22 + win11_23
 
     //                  + win11_24 + win11_25 + win11_26 + win11_27 + win11_28 + win11_29 + win11_30 - win21_2 - win21_3 - win21_4 
 
        //               - win21_5 - win21_6 - win21_7 - win21_8 - win21_9 - win21_10 - win21_11 - win21_12 - win21_13 - win21_14 - win21_15 - win21_16 
 
          //             - win21_17 - win21_18 - win21_19 - win21_20 - win21_21 - win21_22 - win21_23 - win21_24 - win21_25 - win21_26 - win21_27 - win21_28
 
             //          - win21_29 - win21_30);
 
//   assign m01_6  =  6*(win10_2 + win10_3 + win10_4 + win10_5 + win10_6 + win10_7 + win10_8 + win10_9 + win10_10 + win10_11 + win10_12 
 
          //             + win10_13 + win10_14 + win10_15 + win10_16 + win10_17 + win10_18 + win10_19 + win10_20 + win10_21 + win10_22 + win10_23
 
         //              + win10_24 + win10_25 + win10_26 + win10_27 + win10_28 + win10_29 + win10_30 - win22_2 - win22_3 - win22_4 
 
          //             - win22_5 - win22_6 - win22_7 - win22_8 - win22_9 - win22_10 - win22_11 - win22_12 - win22_13 - win22_14 - win22_15 - win22_16 
 
           //            - win22_17 - win22_18 - win22_19 - win22_20 - win22_21 - win22_22 - win22_23 - win22_24 - win22_25 - win22_26 - win22_27 - win22_28
 
              //         - win22_29 - win22_30);
 
//   assign m01_7  =  7*(win9_3 + win9_4 + win9_5 + win9_6 + win9_7 + win9_8 + win9_9 + win9_10 + win9_11 + win9_12 
 
       //                + win9_13 + win9_14 + win9_15 + win9_16 + win9_17 + win9_18 + win9_19 + win9_20 + win9_21 + win9_22 + win9_23
 
        //               + win9_24 + win9_25 + win9_26 + win9_27 + win9_28 + win9_29 - win23_3 - win23_4 
 
         //              - win23_5 - win23_6 - win23_7 - win23_8 - win23_9 - win23_10 - win23_11 - win23_12 - win23_13 - win23_14 - win23_15 - win23_16 
 
          //             - win23_17 - win23_18 - win23_19 - win23_20 - win23_21 - win23_22 - win23_23 - win23_24 - win23_25 - win23_26 - win23_27 - win23_28
 
           //            - win23_29);
 
//   assign m01_8  =  8*(win8_3 + win8_4 + win8_5 + win8_6 + win8_7 + win8_8 + win8_9 + win8_10 + win8_11 + win8_12 
 
         //              + win8_13 + win8_14 + win8_15 + win8_16 + win8_17 + win8_18 + win8_19 + win8_20 + win8_21 + win8_22 + win8_23
 
         //              + win8_24 + win8_25 + win8_26 + win8_27 + win8_28 + win8_29 - win24_3 - win24_4 
 
           //            - win24_5 - win24_6 - win24_7 - win24_8 - win24_9 - win24_10 - win24_11 - win24_12 - win24_13 - win24_14 - win24_15 - win24_16 
 
         //              - win24_17 - win24_18 - win24_19 - win24_20 - win24_21 - win24_22 - win24_23 - win24_24 - win24_25 - win24_26 - win24_27 - win24_28
 
         //              - win24_29);
 
//   assign m01_9  =  9*(win7_4 + win7_5 + win7_6 + win7_7 + win7_8 + win7_9 + win7_10 + win7_11 + win7_12 
 
       //                + win7_13 + win7_14 + win7_15 + win7_16 + win7_17 + win7_18 + win7_19 + win7_20 + win7_21 + win7_22 + win7_23
 
        //               + win7_24 + win7_25 + win7_26 + win7_27 + win7_28 - win25_4 
 
         //              - win25_5 - win25_6 - win25_7 - win25_8 - win25_9 - win25_10 - win25_11 - win25_12 - win25_13 - win25_14 - win25_15 - win25_16 
 
          //             - win25_17 - win25_18 - win25_19 - win25_20 - win25_21 - win25_22 - win25_23 - win25_24 - win25_25 - win25_26 - win25_27 - win25_28);
 
 //  assign m01_10 = 10*(win6_5 + win6_6 + win6_7 + win6_8 + win6_9 + win6_10 + win6_11 + win6_12 
 
       //                + win6_13 + win6_14 + win6_15 + win6_16 + win6_17 + win6_18 + win6_19 + win6_20 + win6_21 + win6_22 + win6_23
 
         //              + win6_24 + win6_25 + win6_26 + win6_27 - win26_5 - win26_6 - win26_7 - win26_8 - win26_9 - win26_10 - win26_11 - win26_12 - win26_13 
 
            //           - win26_14 - win26_15 - win26_16 - win26_17 - win26_18 - win26_19 - win26_20 - win26_21 - win26_22 - win26_23 - win26_24 - win26_25 
 
              //         - win26_26 - win26_27);
 
 //  assign m01_11 = 11*(win5_6 + win5_7 + win5_8 + win5_9 + win5_10 + win5_11 + win5_12 + win5_13 + win5_14 + win5_15 + win5_16 + win5_17 + win5_18 + win5_19
 
       //                + win5_20 + win5_21 + win5_22 + win5_23 + win5_24 + win5_25 + win5_26 - win27_6 - win27_7 - win27_8 - win27_9 - win27_10 - win27_11 
 
        //               - win27_12 - win27_13 - win27_14 - win27_15 - win27_16 - win27_17 - win27_18 - win27_19 - win27_20 - win27_21 - win27_22 - win27_23 
 
          //             - win27_24 - win27_25 - win27_26);
 
 //  assign m01_12 = 12*(win4_7 + win4_8 + win4_9 + win4_10 + win4_11 + win4_12 + win4_13 + win4_14 + win4_15 + win4_16 + win4_17 + win4_18 + win4_19
 
         //              + win4_20 + win4_21 + win4_22 + win4_23 + win4_24 + win4_25 - win28_7 - win28_8 - win28_9 - win28_10 - win28_11 
 
          //             - win28_12 - win28_13 - win28_14 - win28_15 - win28_16 - win28_17 - win28_18 - win28_19 - win28_20 - win28_21 - win28_22 - win28_23 
 
           //            - win28_24 - win28_25);
 
 //  assign m01_13 = 13*(win3_8 + win3_9 + win3_10 + win3_11 + win3_12 + win3_13 + win3_14 + win3_15 + win3_16 + win3_17 + win3_18 + win3_19
 
   //                    + win3_20 + win3_21 + win3_22 + win3_23 + win3_24 - win29_8 - win29_9 - win29_10 - win29_11 
 
  //                     - win29_12 - win29_13 - win29_14 - win29_15 - win29_16 - win29_17 - win29_18 - win29_19 - win29_20 - win29_21 - win29_22 - win29_23 
 
    //                   - win29_24);
 
//   assign m01_14 = 14*(win2_10 + win2_11 + win2_12 + win2_13 + win2_14 + win2_15 + win2_16 + win2_17 + win2_18 + win2_19
 
     //                  + win2_20 + win2_21 + win2_22 - win30_10 - win30_11 - win30_12 - win30_13 - win30_14 - win30_15 - win30_16 - win30_17 - win30_18 - win30_19
 
       //                - win30_20 - win30_21 - win30_22);
 
 //  assign m01_15 = 15*(win1_13 + win1_14 + win1_15 + win1_16 + win1_17 + win1_18 + win1_19 - win31_13 - win31_14 - win31_15 - win31_16 - win31_17 - win31_18 - win31_19); 
 
                       
 
                                         
 
                            
   
  assign a1 = (win16_16>win13_15) ? (win16_16-win13_15):(win13_15-win16_16);
  assign a2 = (win16_16>win13_16) ? (win16_16-win13_16):(win13_16-win16_16);
  assign a3 = (win16_16>win13_17) ? (win16_16-win13_17):(win13_17-win16_16);
  assign a4 = (win16_16>win14_18) ? (win16_16-win14_18):(win14_18-win16_16);
  assign a5 = (win16_16>win15_19) ? (win16_16-win15_19):(win15_19-win16_16);
  assign a6 = (win16_16>win16_19) ? (win16_16-win16_19):(win16_19-win16_16);
  assign a7 = (win16_16>win17_19) ? (win16_16-win17_19):(win17_19-win16_16);
  assign a8 = (win16_16>win18_18) ? (win16_16-win18_18):(win18_18-win16_16);
  assign a9 = (win16_16>win19_17) ? (win16_16-win19_17):(win19_17-win16_16);
  assign a10 = (win16_16>win19_16) ? (win16_16-win19_16):(win19_16-win16_16);
  assign a11 = (win16_16>win19_15) ? (win16_16-win19_15):(win19_15-win16_16);
  assign a12 = (win16_16>win18_14) ? (win16_16-win18_14):(win18_14-win16_16);
  assign a13 = (win16_16>win17_13) ? (win16_16-win17_13):(win17_13-win16_16);
  assign a14 = (win16_16>win16_13) ? (win16_16-win16_13):(win16_13-win16_16);
  assign a15 = (win16_16>win15_13) ? (win16_16-win15_13):(win15_13-win16_16);
  assign a16 = (win16_16>win14_14) ? (win16_16-win14_14):(win14_14-win16_16);
  
  
  
  
  
  
  
  
  
  
  
  
  
  assign b1 = (a1>threshold);
  assign b2 = (a2>threshold);
  assign b3 = (a3>threshold);
  assign b4 = (a4>threshold);
  assign b5 = (a5>threshold);
  assign b6 = (a6>threshold);
  assign b7 = (a7>threshold);
  assign b8 = (a8>threshold);
  assign b9 = (a9>threshold);
  assign b10 = (a10>threshold);
  assign b11 = (a11>threshold);
  assign b12 = (a12>threshold);
  assign b13 = (a13>threshold);
  assign b14 = (a14>threshold);
  assign b15 = (a15>threshold);
  assign b16 = (a16>threshold);
  
  reg  [1:0] c1_tp1;
  reg  [1:0] c1_tp2;
  reg  [1:0] c1_tp3;
  reg  [1:0] c1_tp4;
  reg  [1:0] c1_tp5;
  reg  [1:0] c1_tp6;
  wire  [2:0] c1_tp7;
  wire  [2:0] c1_tp8;
  wire  [2:0] c1_tp9;
   
  reg  [1:0] c2_tp1;
  reg  [1:0] c2_tp2;
  reg  [1:0] c2_tp3;
  reg  [1:0] c2_tp4;
  reg  [1:0] c2_tp5;
  reg  [1:0] c2_tp6;
  wire  [2:0] c2_tp7;
  wire  [2:0] c2_tp8;
  wire  [2:0] c2_tp9;
   
  reg  [1:0] c3_tp1;
  reg  [1:0] c3_tp2;
  reg  [1:0] c3_tp3;
  reg  [1:0] c3_tp4;
  reg  [1:0] c3_tp5;
  reg  [1:0] c3_tp6;
  wire  [2:0] c3_tp7;
  wire  [2:0] c3_tp8;
  wire  [2:0] c3_tp9;
   
  reg  [1:0] c4_tp1;
  reg  [1:0] c4_tp2;
  reg  [1:0] c4_tp3;
  reg  [1:0] c4_tp4;
  reg  [1:0] c4_tp5;
  reg  [1:0] c4_tp6;
  wire  [2:0] c4_tp7;
  wire  [2:0] c4_tp8;
  wire  [2:0] c4_tp9;
   
  reg  [1:0] c5_tp1;
  reg  [1:0] c5_tp2;
  reg  [1:0] c5_tp3;
  reg  [1:0] c5_tp4;
  reg  [1:0] c5_tp5;
  reg  [1:0] c5_tp6;
  wire  [2:0] c5_tp7;
  wire  [2:0] c5_tp8;
  wire  [2:0] c5_tp9; 
   
  reg  [1:0] c6_tp1;
  reg  [1:0] c6_tp2;
  reg  [1:0] c6_tp3;
  reg  [1:0] c6_tp4;
  reg  [1:0] c6_tp5;
  reg  [1:0] c6_tp6;
  wire  [2:0] c6_tp7;
  wire  [2:0] c6_tp8;
  wire  [2:0] c6_tp9;
  
  reg  [1:0] c7_tp1;
  reg  [1:0] c7_tp2;
  reg  [1:0] c7_tp3;
  reg  [1:0] c7_tp4;
  reg  [1:0] c7_tp5;
  reg  [1:0] c7_tp6;
  wire  [2:0] c7_tp7;
  wire  [2:0] c7_tp8;
  wire  [2:0] c7_tp9;
   
  reg  [1:0] c8_tp1;
  reg  [1:0] c8_tp2;
  reg  [1:0] c8_tp3;
  reg  [1:0] c8_tp4;
  reg  [1:0] c8_tp5;
  reg  [1:0] c8_tp6;
  wire  [2:0] c8_tp7;
  wire  [2:0] c8_tp8;
  wire  [2:0] c8_tp9;
  
  reg  [1:0] c9_tp1;
  reg  [1:0] c9_tp2;
  reg  [1:0] c9_tp3;
  reg  [1:0] c9_tp4;
  reg  [1:0] c9_tp5;
  reg  [1:0] c9_tp6;
  wire  [2:0] c9_tp7;
  wire  [2:0] c9_tp8;
  wire  [2:0] c9_tp9;
  
  reg  [1:0] c10_tp1;
  reg  [1:0] c10_tp2;
  reg  [1:0] c10_tp3;
  reg  [1:0] c10_tp4;
  reg  [1:0] c10_tp5;
  reg  [1:0] c10_tp6;
  wire  [2:0] c10_tp7;
  wire  [2:0] c10_tp8;
  wire  [2:0] c10_tp9;
  
  reg  [1:0] c11_tp1;
  reg  [1:0] c11_tp2;
  reg  [1:0] c11_tp3;
  reg  [1:0] c11_tp4;
  reg  [1:0] c11_tp5;
  reg  [1:0] c11_tp6;
  wire  [2:0] c11_tp7;
  wire  [2:0] c11_tp8;
  wire  [2:0] c11_tp9;
  
  reg  [1:0] c12_tp1;
  reg  [1:0] c12_tp2;
  reg  [1:0] c12_tp3;
  reg  [1:0] c12_tp4;
  reg  [1:0] c12_tp5;
  reg  [1:0] c12_tp6;
  wire  [2:0] c12_tp7;
  wire  [2:0] c12_tp8;
  wire  [2:0] c12_tp9;
  
  reg  [1:0] c13_tp1;
  reg  [1:0] c13_tp2;
  reg  [1:0] c13_tp3;
  reg  [1:0] c13_tp4;
  reg  [1:0] c13_tp5;
  reg  [1:0] c13_tp6;
  wire  [2:0] c13_tp7;
  wire  [2:0] c13_tp8;
  wire  [2:0] c13_tp9;
  
  reg  [1:0] c14_tp1;
  reg  [1:0] c14_tp2;
  reg  [1:0] c14_tp3;
  reg  [1:0] c14_tp4;
  reg  [1:0] c14_tp5;
  reg  [1:0] c14_tp6;
  wire  [2:0] c14_tp7;
  wire  [2:0] c14_tp8;
  wire  [2:0] c14_tp9;
  
  reg  [1:0] c15_tp1;
  reg  [1:0] c15_tp2;
  reg  [1:0] c15_tp3;
  reg  [1:0] c15_tp4;
  reg  [1:0] c15_tp5;
  reg  [1:0] c15_tp6;
  wire  [2:0] c15_tp7;
  wire  [2:0] c15_tp8;
  wire  [2:0] c15_tp9;
   
  reg  [1:0] c16_tp1;
  reg  [1:0] c16_tp2;
  reg  [1:0] c16_tp3;
  reg  [1:0] c16_tp4;
  reg  [1:0] c16_tp5;
  reg  [1:0] c16_tp6;
  wire  [2:0] c16_tp7;
  wire  [2:0] c16_tp8;
  wire  [2:0] c16_tp9;
  
assign c1_tp7 = c1_tp1 + c1_tp2;
assign c1_tp8 = c1_tp3 + c1_tp4;
assign c1_tp9 = c1_tp5 + c1_tp6;
assign c2_tp7 = c2_tp1 + c2_tp2;
assign c2_tp8 = c2_tp3 + c2_tp4;
assign c2_tp9 = c2_tp5 + c2_tp6;
assign c3_tp7 = c3_tp1 + c3_tp2;
assign c3_tp8 = c3_tp3 + c3_tp4;
assign c3_tp9 = c3_tp5 + c3_tp6;
assign c4_tp7 = c4_tp1 + c4_tp2;
assign c4_tp8 = c4_tp3 + c4_tp4;
assign c4_tp9 = c4_tp5 + c4_tp6;
assign c5_tp7 = c5_tp1 + c5_tp2;
assign c5_tp8 = c5_tp3 + c5_tp4;
assign c5_tp9 = c5_tp5 + c5_tp6;
assign c6_tp7 = c6_tp1 + c6_tp2;
assign c6_tp8 = c6_tp3 + c6_tp4;
assign c6_tp9 = c6_tp5 + c6_tp6;
assign c7_tp7 = c7_tp1 + c7_tp2;
assign c7_tp8 = c7_tp3 + c7_tp4;
assign c7_tp9 = c7_tp5 + c7_tp6;
assign c8_tp7 = c8_tp1 + c8_tp2;
assign c8_tp8 = c8_tp3 + c8_tp4;
assign c8_tp9 = c8_tp5 + c8_tp6;
assign c9_tp7 = c9_tp1 + c9_tp2;
assign c9_tp8 = c9_tp3 + c9_tp4;
assign c9_tp9 = c9_tp5 + c9_tp6;
assign c10_tp7 = c10_tp1 + c10_tp2;
assign c10_tp8 = c10_tp3 + c10_tp4;
assign c10_tp9 = c10_tp5 + c10_tp6;
assign c11_tp7 = c11_tp1 + c11_tp2;
assign c11_tp8 = c11_tp3 + c11_tp4;
assign c11_tp9 = c11_tp5 + c11_tp6;
assign c12_tp7 = c12_tp1 + c12_tp2;
assign c12_tp8 = c12_tp3 + c12_tp4;
assign c12_tp9 = c12_tp5 + c12_tp6;
assign c13_tp7 = c13_tp1 + c13_tp2;
assign c13_tp8 = c13_tp3 + c13_tp4;
assign c13_tp9 = c13_tp5 + c13_tp6;
assign c14_tp7 = c14_tp1 + c14_tp2;
assign c14_tp8 = c14_tp3 + c14_tp4;
assign c14_tp9 = c14_tp5 + c14_tp6;
assign c15_tp7 = c15_tp1 + c15_tp2;
assign c15_tp8 = c15_tp3 + c15_tp4;
assign c15_tp9 = c15_tp5 + c15_tp6;
assign c16_tp7 = c16_tp1 + c16_tp2;
assign c16_tp8 = c16_tp3 + c16_tp4;
assign c16_tp9 = c16_tp5 + c16_tp6;          
  
   
  

  
  assign d1 = (c1==12) ? 1'b1:1'b0;
  assign d2 = (c2==12) ? 1'b1:1'b0;
  assign d3 = (c3==12) ? 1'b1:1'b0;
  assign d4 = (c4==12) ? 1'b1:1'b0;
  assign d5 = (c5==12) ? 1'b1:1'b0;
  assign d6 = (c6==12) ? 1'b1:1'b0;
  assign d7 = (c7==12) ? 1'b1:1'b0;
  assign d8 = (c8==12) ? 1'b1:1'b0;
  assign d9 = (c9==12) ? 1'b1:1'b0;
  assign d10 = (c10==12) ? 1'b1:1'b0;
  assign d11 = (c11==12) ? 1'b1:1'b0;
  assign d12 = (c12==12) ? 1'b1:1'b0;
  assign d13 = (c13==12) ? 1'b1:1'b0;
  assign d14 = (c14==12) ? 1'b1:1'b0;
  assign d15 = (c15==12) ? 1'b1:1'b0;
  assign d16 = (c16==12) ? 1'b1:1'b0;
  
  assign fast_or_not = d1||d2||d3||d4||d5||d6||d7||d8||d9||d10||d11||d12||d13||d14||d15||d16;
  
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        c1  <= 4'd0;
        c2  <= 4'd0;
        c3  <= 4'd0;
        c4  <= 4'd0;
        c5  <= 4'd0;
        c6  <= 4'd0;
        c7  <= 4'd0;
        c8  <= 4'd0;
        c9  <= 4'd0;
        c10 <= 4'd0;
        c11 <= 4'd0;
        c12 <= 4'd0;
        c13 <= 4'd0;
        c14 <= 4'd0;
        c15 <= 4'd0;
        c16 <= 4'd0;
      end
    else
      begin
        c1 <= c1_tp7 + c1_tp8 + c1_tp9;
        c2 <= c2_tp7 + c2_tp8 + c2_tp9;
        c3 <= c3_tp7 + c3_tp8 + c3_tp9;
        c4 <= c4_tp7 + c4_tp8 + c4_tp9;
        c5 <= c5_tp7 + c5_tp8 + c5_tp9;
        c6 <= c6_tp7 + c6_tp8 + c6_tp9;
        c7 <= c7_tp7 + c7_tp8 + c7_tp9;
        c8 <= c8_tp7 + c8_tp8 + c8_tp9;
        c9 <= c9_tp7 + c9_tp8 + c9_tp9;
        c10 <= c10_tp7 + c10_tp8 + c10_tp9;
        c11 <= c11_tp7 + c11_tp8 + c11_tp9;
        c12 <= c12_tp7 + c12_tp8 + c12_tp9;
        c13 <= c13_tp7 + c13_tp8 + c13_tp9;
        c14 <= c14_tp7 + c14_tp8 + c14_tp9;
        c15 <= c15_tp7 + c15_tp8 + c15_tp9;
        c16 <= c16_tp7 + c16_tp8 + c16_tp9;
      end
    end 
    
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      begin
        c1_tp1  <= 2'd0;
        c1_tp2  <= 2'd0;
        c1_tp3  <= 2'd0;
        c1_tp4  <= 2'd0;
        c1_tp5  <= 2'd0;
        c1_tp6  <= 2'd0;           
        c2_tp1  <= 2'd0;
        c2_tp2  <= 2'd0;
        c2_tp3  <= 2'd0;
        c2_tp4  <= 2'd0;
        c2_tp5  <= 2'd0;
        c2_tp6  <= 2'd0;           
        c3_tp1  <= 2'd0;
        c3_tp2  <= 2'd0;
        c3_tp3  <= 2'd0;
        c3_tp4  <= 2'd0;
        c3_tp5  <= 2'd0;
        c3_tp6  <= 2'd0;             
        c4_tp1  <= 2'd0;
        c4_tp2  <= 2'd0;
        c4_tp3  <= 2'd0;
        c4_tp4  <= 2'd0;
        c4_tp5  <= 2'd0;
        c4_tp6  <= 2'd0;           
        c5_tp1  <= 2'd0;
        c5_tp2  <= 2'd0;
        c5_tp3  <= 2'd0;
        c5_tp4  <= 2'd0;
        c5_tp5  <= 2'd0;
        c5_tp6  <= 2'd0;                    
        c6_tp1  <= 2'd0;
        c6_tp2  <= 2'd0;
        c6_tp3  <= 2'd0;
        c6_tp4  <= 2'd0;
        c6_tp5  <= 2'd0;
        c6_tp6  <= 2'd0;              
        c7_tp1  <= 2'd0;
        c7_tp2  <= 2'd0;
        c7_tp3  <= 2'd0;
        c7_tp4  <= 2'd0;
        c7_tp5  <= 2'd0;
        c7_tp6  <= 2'd0;      
        c8_tp1  <= 2'd0;
        c8_tp2  <= 2'd0;
        c8_tp3  <= 2'd0;
        c8_tp4  <= 2'd0;
        c8_tp5  <= 2'd0;
        c8_tp6  <= 2'd0;     
        c9_tp1  <= 2'd0;
        c9_tp2  <= 2'd0;
        c9_tp3  <= 2'd0;
        c9_tp4  <= 2'd0;
        c9_tp5  <= 2'd0;
        c9_tp6  <= 2'd0;         
        c10_tp1 <= 2'd0;
        c10_tp2 <= 2'd0;
        c10_tp3 <= 2'd0;
        c10_tp4 <= 2'd0;
        c10_tp5 <= 2'd0;
        c10_tp6 <= 2'd0;            
        c11_tp1 <= 2'd0;
        c11_tp2 <= 2'd0;
        c11_tp3 <= 2'd0;
        c11_tp4 <= 2'd0;
        c11_tp5 <= 2'd0;
        c11_tp6 <= 2'd0;             
        c12_tp1 <= 2'd0;
        c12_tp2 <= 2'd0;
        c12_tp3 <= 2'd0;
        c12_tp4 <= 2'd0;
        c12_tp5 <= 2'd0;
        c12_tp6 <= 2'd0;              
        c13_tp1 <= 2'd0;
        c13_tp2 <= 2'd0;
        c13_tp3 <= 2'd0;
        c13_tp4 <= 2'd0;
        c13_tp5 <= 2'd0;
        c13_tp6 <= 2'd0;             
        c14_tp1 <= 2'd0;
        c14_tp2 <= 2'd0;
        c14_tp3 <= 2'd0;
        c14_tp4 <= 2'd0;
        c14_tp5 <= 2'd0;
        c14_tp6 <= 2'd0;            
        c15_tp1 <= 2'd0;
        c15_tp2 <= 2'd0;
        c15_tp3 <= 2'd0;
        c15_tp4 <= 2'd0;
        c15_tp5 <= 2'd0;
        c15_tp6 <= 2'd0;            
        c16_tp1 <= 2'd0;
        c16_tp2 <= 2'd0;
        c16_tp3 <= 2'd0;
        c16_tp4 <= 2'd0;
        c16_tp5 <= 2'd0;
        c16_tp6 <= 2'd0;
      end
    else
      begin
        c1_tp1 <= b1 + b2;
        c1_tp2 <= b3 + b4;
        c1_tp3 <= b5 + b6;
        c1_tp4 <= b7 + b8;
        c1_tp5 <= b9 + b10;
        c1_tp6 <= b11 + b12;            
        c2_tp1 <= b2 + b3;
        c2_tp2 <= b4 + b5;
        c2_tp3 <= b6 + b7;
        c2_tp4 <= b8 + b9;
        c2_tp5 <= b10 + b11;
        c2_tp6 <= b12 + b13;             
        c3_tp1 <= b3 + b4;
        c3_tp2 <= b5 + b6;
        c3_tp3 <= b7 + b8;
        c3_tp4 <= b9 + b10;
        c3_tp5 <= b11 + b12;
        c3_tp6 <= b13 + b14;             
        c4_tp1 <= b4 + b5;
        c4_tp2 <= b6 + b7;
        c4_tp3 <= b8 + b9;
        c4_tp4 <= b10 + b11;
        c4_tp5 <= b12 + b13;
        c4_tp6 <= b14 + b15;            
        c5_tp1 <= b5 + b6;
        c5_tp2 <= b7 + b8;
        c5_tp3 <= b9 + b10;
        c5_tp4 <= b11 + b12;
        c5_tp5 <= b13 + b14;
        c5_tp6 <= b15 + b16;                     
        c6_tp1 <= b6 + b7;
        c6_tp2 <= b8 + b9;
        c6_tp3 <= b10 + b11;
        c6_tp4 <= b12 + b13;
        c6_tp5 <= b14 + b15;
        c6_tp6 <= b16 + b1;               
        c7_tp1 <= b7 + b8;
        c7_tp2 <= b9 + b10;
        c7_tp3 <= b11 + b12;
        c7_tp4 <= b13 + b14;
        c7_tp5 <= b15 + b16;
        c7_tp6 <= b1 + b2;             
        c8_tp1 <= b8 + b9;
        c8_tp2 <= b10 + b11;
        c8_tp3 <= b12 + b13;
        c8_tp4 <= b14 + b15;
        c8_tp5 <= b16 + b1;
        c8_tp6 <= b2 + b3;              
        c9_tp1 <= b9 + b10;
        c9_tp2 <= b11 + b12;
        c9_tp3 <= b13 + b14;
        c9_tp4 <= b15 + b16;
        c9_tp5 <= b1 + b2;
        c9_tp6 <= b3 + b4;              
        c10_tp1 <= b10 + b11;
        c10_tp2 <= b12 + b13;
        c10_tp3 <= b14 + b15;
        c10_tp4 <= b16 + b1;
        c10_tp5 <= b2 + b3;
        c10_tp6 <= b4 + b5;             
        c11_tp1 <= b11 + b12;
        c11_tp2 <= b13 + b14;
        c11_tp3 <= b15 + b16;
        c11_tp4 <= b1 + b2;
        c11_tp5 <= b3 + b4;
        c11_tp6 <= b5 + b6;             
        c12_tp1 <= b12 + b13;
        c12_tp2 <= b14 + b15;
        c12_tp3 <= b16 + b1;
        c12_tp4 <= b2 + b3;
        c12_tp5 <= b4 + b5;
        c12_tp6 <= b6 + b7;              
        c13_tp1 <= b13 + b14;
        c13_tp2 <= b15 + b16;
        c13_tp3 <= b1 + b2;
        c13_tp4 <= b3 + b4;
        c13_tp5 <= b5 + b6;
        c13_tp6 <= b7 + b8;              
        c14_tp1 <= b14 + b15;
        c14_tp2 <= b16 + b1;
        c14_tp3 <= b2 + b3;
        c14_tp4 <= b4 + b5;
        c14_tp5 <= b6 + b7;
        c14_tp6 <= b8 + b9;            
        c15_tp1 <= b15 + b16;
        c15_tp2 <= b1 + b2;
        c15_tp3 <= b3 + b4;
        c15_tp4 <= b5 + b6;
        c15_tp5 <= b7 + b8;
        c15_tp6 <= b9 + b10;          
        c16_tp1 <= b16 + b1;
        c16_tp2 <= b2 + b3;
        c16_tp3 <= b4 + b5;
        c16_tp4 <= b6 + b7;
        c16_tp5 <= b8 + b9;
        c16_tp6 <= b10 + b11;
      end
  end  
        
      
     
  
  line_buffer_31 lb(.shiftin(din),
                   .clock(clk),
                   .clken(en),
                   .taps30x(taps31),
                   .taps29x(taps30),
                   .taps28x(taps29),
                   .taps27x(taps28),
                   .taps26x(taps27),
                   .taps25x(taps26),
                   .taps24x(taps25),
                   .taps23x(taps24),
                   .taps22x(taps23),
                   .taps21x(taps22),
                   .taps20x(taps21),
                   .taps19x(taps20),
                   .taps18x(taps19),
                   .taps17x(taps18),
                   .taps16x(taps17),
                   .taps15x(taps16),
                   .taps14x(taps15),
                   .taps13x(taps14),
                   .taps12x(taps13),
                   .taps11x(taps12),
                   .taps10x(taps11),
                   .taps9x(taps10),
                   .taps8x(taps9),
                   .taps7x(taps8),
                   .taps6x(taps7),
                   .taps5x(taps6),
                   .taps4x(taps5),
                   .taps3x(taps4),
                   .taps2x(taps3),
                   .taps1x(taps2),
                   .taps0x(taps1),
                   .shiftout());
                   
                   
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    en <= 1'b0;
  else if(start==1'b1)
    en <= 1'b1;
end
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_b <= 19'b0000000000000000000;
  else if(start==1'b1)
    addr_b <= 19'd2712;//10848 row:16
  else if(addr_b<351203)
    addr_b <= addr_b + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count <= 10'b0000000000;
  else if(start==1'b1)
    count <= 10'b0000000000;
  else if(addr_b>=23732)
    begin
      if(count<=677)
          count <= count + 1'b1;
      else
          count <= 10'd1;
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
  else if(addr_b>=23732)//15595 
    begin
      win31_31 <= taps1;
      win30_31 <= taps2;
      win29_31 <= taps3;
      win28_31 <= taps4;
      win27_31 <= taps5;
      win26_31 <= taps6;
      win25_31 <= taps7;
      win24_31 <= taps8;
      win23_31 <= taps9;
      win22_31 <= taps10;
      win21_31 <= taps11;
      win20_31 <= taps12;
      win19_31 <= taps13;
      win18_31 <= taps14;
      win17_31 <= taps15;
      win16_31 <= taps16;
      win15_31 <= taps17;
      win14_31 <= taps18;
      win13_31 <= taps19;
      win12_31 <= taps20;
      win11_31 <= taps21;
      win10_31 <= taps22;
      win9_31 <= taps23;
      win8_31 <= taps24;
      win7_31 <= taps25;
      win6_31 <= taps26;
      win5_31 <= taps27;
      win4_31 <= taps28;
      win3_31 <= taps29;
      win2_31 <= taps30;
      win1_31 <= taps31;
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
  else 
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
    sel <= 1'b0;
  else if(start==1'b1)
    sel <= 1'b0;
  else if(Y==498 && X==657)
    sel <= 1'b1;
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
  else if(count>35 && count<=674)
    begin
      if(sel==0)
        X <= count - 5'd16;
    end
  else if(count==35 && Y<498)
    begin
      X <= 10'd19;
      Y <= Y + 1'b1;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    count_start_gb <= 2'b00;
  else if(start==1'b1)
    count_start_gb <= 2'b00;
  else if(X_tp_4==658 && Y_tp_4==498 && count_start_gb< 2)
    count_start_gb <= count_start_gb + 1'b1;
end
  
always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      start_gb <= 1'b0;
      wren <= 1'b0;
    end
  else if(start==1'b1)
    begin
      start_gb <= 1'b0;
      wren <= 1'b1;
    end
  //else if(X_tp_4==658 && Y_tp_4==498)
  else if(X_tp_1==658 && Y_tp_1==498)
    begin
      wren <= 1'b0;
      if(count_start_gb!=2)
        start_gb <= 1'b1;
      else
        start_gb <= 1'b0;
    end
end

    
         
//always@(posedge clk or negedge rst_n)   
//begin
//  if(!rst_n)
//    begin
//      fast <= 1'b0;
//      m10_temp <= 21'b000000000000000000000;
//      m01_temp <= 21'b000000000000000000000;
//    end
//  else if(count>=35 && count<=width_ext-border+15 && sel==0)
//    begin
//      fast <= fast_or_not;
//      m10_temp <= m10_15 + m10_14 + m10_13 + m10_12 + m10_11 + m10_10 + m10_9 + m10_8 + m10_7 + m10_6 + m10_5 + m10_4 + m10_3 + m10_2 + m10_1;
//      m01_temp <= m01_15 + m01_14 + m01_13 + m01_12 + m01_11 + m01_10 + m01_9 + m01_8 + m01_7 + m01_6 + m01_5 + m01_4 + m01_3 + m01_2 + m01_1;
//    end
//  else if(count>width_ext-border+15)
////    begin
//     fast <= 0; 
//      m10_temp <= 21'b000000000000000000000;
 //     m01_temp <= 21'b000000000000000000000;
//    end   
//end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      dout_tp_1 <= 20'd0;
    end
  else if(fast_tp_1==1'b1)
    begin
      dout_tp_1[19:10] <= X_tp_3;
      dout_tp_1[9:0] <= Y_tp_3;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      X_tp_1 <= 10'd0;
      Y_tp_1 <= 10'd0;
      X_tp_2 <= 10'd0;
      Y_tp_2 <= 10'd0;
      X_tp_3 <= 10'd0;
      Y_tp_3 <= 10'd0;
      X_tp_4 <= 10'd0;
      Y_tp_4 <= 10'd0;
      count_tp_1 <= 10'd0;
      count_tp_2 <= 10'd0;
      sel_tp_1 <= 1'b0;
      sel_tp_2 <= 1'b0;
    end
  else 
    begin
      X_tp_1 <= X;
      Y_tp_1 <= Y;
      X_tp_2 <= X_tp_1;
      Y_tp_2 <= Y_tp_1;
      X_tp_3 <= X_tp_2;
      Y_tp_3 <= Y_tp_2;
      X_tp_4 <= X_tp_3;
      Y_tp_4 <= Y_tp_3;
      count_tp_1 <= count;
      count_tp_2 <= count_tp_1;
      sel_tp_1 <= sel;
      sel_tp_2 <= sel_tp_1;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      m10 <= 21'b000000000000000000000;
      m01 <= 21'b000000000000000000000;
    end
  else if(fast_tp_2==1'b1)
    begin
      m10 <= m10_301 + m10_302;
      m01 <= m01_301 + m01_302;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
      num_fast <= 14'd0;
  else if(start==1'b1)
      num_fast <= 14'd0;
  else if(fast_tp_2==1'b1)
      num_fast <= num_fast + 1'b1;
end

endmodule

