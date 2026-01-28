//?????fully pipeline?? 2x128
module Searchbyband_v2_hc18(clk,rst_n,start,fx,num_left,num_right,num_left_L1,num_right_L1,XYO_left,XYO_right,descriptor1_left,descriptor2_left,descriptor1_right,descriptor2_right,
                    addr_b_XYO_left,addr_b_XYO_right,addr_b1_descriptor_left,addr_b2_descriptor_left,addr_b1_descriptor_right,
                    addr_b2_descriptor_right,XYOXYO,bestdist,addr_out,wren,num_matches,start_SAD);
input clk;
input rst_n;
input start;
input [8:0] fx; 
input [14:0] num_left;
input [14:0] num_right;
input [13:0] num_left_L1;
input [13:0] num_right_L1;
input [21:0] XYO_left;
input [21:0] XYO_right;
input [127:0] descriptor1_left;
input [127:0] descriptor2_left;
input [127:0] descriptor1_right;
input [127:0] descriptor2_right;
output [13:0] addr_b_XYO_left;
output [13:0] addr_b_XYO_right;
output [14:0] addr_b1_descriptor_left;
output [14:0] addr_b2_descriptor_left;
output [14:0] addr_b1_descriptor_right;
output [14:0] addr_b2_descriptor_right;
output [43:0] XYOXYO;
output [8:0] bestdist;
output [14:0] addr_out;
output wren;
output [14:0] num_matches;
output start_SAD;

reg [13:0] addr_b_XYO_left;
reg [13:0] addr_b_XYO_right;
reg [13:0] addr_b_XYO_left_tp1;
reg [13:0] addr_b_XYO_left_tp2;
reg [13:0] addr_b_XYO_left_tp3;
reg [13:0] addr_b_XYO_right_tp1;
reg [13:0] addr_b_XYO_right_tp2;
reg [13:0] addr_b_XYO_right_tp3;

reg [14:0] addr_b1_descriptor_left;
reg [14:0] addr_b2_descriptor_left;
reg [14:0] addr_b1_descriptor_right;
reg [14:0] addr_b2_descriptor_right;

reg flag;
reg flag_tp1;
reg flag_tp2;
reg flag_tp3;
reg flag_tp4;
reg flag_tp5;
reg flag_tp6;

wire endl;
reg endl_tp1;
reg endl_tp2;
reg endl_tp3;
reg endl_tp4;
reg endl_tp5;
reg endl_tp6;
reg endl_tp7;
reg endl_tp8;
reg endl_tp9;

reg [21:0] XYO_left_tp1;
reg [21:0] XYO_left_tp2;
reg [21:0] XYO_left_tp3;
reg [21:0] XYO_left_tp4;
reg [21:0] XYO_left_tp5;
reg [21:0] XYO_left_tp6;
reg [21:0] XYO_left_tp7;
reg [21:0] XYO_right_tp1;
reg [21:0] XYO_right_tp2;
reg [21:0] XYO_right_tp3;
reg [21:0] XYO_right_tp4;
reg [21:0] XYO_right_tp5;
reg [21:0] XYO_right_tp6;
reg [21:0] XYO_right_tp7;


wire [9:0] X_left;
wire [9:0] Y_left;
wire [9:0] X_right;
wire [9:0] Y_right;
wire [9:0] temp1_1;
wire [9:0] temp1_2;
wire [9:0] temp2_1;
wire [9:0] temp2_2;
wire [10:0] temp3;

reg [127:0] dist_temp1;
reg [127:0] dist_temp2;

wire [1:0] dist_temp101;
wire [1:0] dist_temp102;
wire [1:0] dist_temp103;
wire [1:0] dist_temp104;
wire [1:0] dist_temp105;
wire [1:0] dist_temp106;
wire [1:0] dist_temp107;
wire [1:0] dist_temp108;
wire [1:0] dist_temp109;
wire [1:0] dist_temp110;
wire [1:0] dist_temp111;
wire [1:0] dist_temp112;
wire [1:0] dist_temp113;
wire [1:0] dist_temp114;
wire [1:0] dist_temp115;
wire [1:0] dist_temp116;
wire [1:0] dist_temp117;
wire [1:0] dist_temp118;
wire [1:0] dist_temp119;
wire [1:0] dist_temp120;
wire [1:0] dist_temp121;
wire [1:0] dist_temp122;
wire [1:0] dist_temp123;
wire [1:0] dist_temp124;
wire [1:0] dist_temp125;
wire [1:0] dist_temp126;
wire [1:0] dist_temp127;
wire [1:0] dist_temp128;
wire [1:0] dist_temp129;
wire [1:0] dist_temp130;
wire [1:0] dist_temp131;
wire [1:0] dist_temp132;
wire [1:0] dist_temp133;
wire [1:0] dist_temp134;
wire [1:0] dist_temp135;
wire [1:0] dist_temp136;
wire [1:0] dist_temp137;
wire [1:0] dist_temp138;
wire [1:0] dist_temp139;
wire [1:0] dist_temp140;
wire [1:0] dist_temp141;
wire [1:0] dist_temp142;
wire [1:0] dist_temp143;
wire [1:0] dist_temp144;
wire [1:0] dist_temp145;
wire [1:0] dist_temp146;
wire [1:0] dist_temp147;
wire [1:0] dist_temp148;
wire [1:0] dist_temp149;
wire [1:0] dist_temp150;
wire [1:0] dist_temp151;
wire [1:0] dist_temp152;
wire [1:0] dist_temp153;
wire [1:0] dist_temp154;
wire [1:0] dist_temp155;
wire [1:0] dist_temp156;
wire [1:0] dist_temp157;
wire [1:0] dist_temp158;
wire [1:0] dist_temp159;
wire [1:0] dist_temp160;
wire [1:0] dist_temp161;
wire [1:0] dist_temp162;
wire [1:0] dist_temp163;
wire [1:0] dist_temp164;

wire [1:0] dist_temp201;
wire [1:0] dist_temp202;
wire [1:0] dist_temp203;
wire [1:0] dist_temp204;
wire [1:0] dist_temp205;
wire [1:0] dist_temp206;
wire [1:0] dist_temp207;
wire [1:0] dist_temp208;
wire [1:0] dist_temp209;
wire [1:0] dist_temp210;
wire [1:0] dist_temp211;
wire [1:0] dist_temp212;
wire [1:0] dist_temp213;
wire [1:0] dist_temp214;
wire [1:0] dist_temp215;
wire [1:0] dist_temp216;
wire [1:0] dist_temp217;
wire [1:0] dist_temp218;
wire [1:0] dist_temp219;
wire [1:0] dist_temp220;
wire [1:0] dist_temp221;
wire [1:0] dist_temp222;
wire [1:0] dist_temp223;
wire [1:0] dist_temp224;
wire [1:0] dist_temp225;
wire [1:0] dist_temp226;
wire [1:0] dist_temp227;
wire [1:0] dist_temp228;
wire [1:0] dist_temp229;
wire [1:0] dist_temp230;
wire [1:0] dist_temp231;
wire [1:0] dist_temp232;
wire [1:0] dist_temp233;
wire [1:0] dist_temp234;
wire [1:0] dist_temp235;
wire [1:0] dist_temp236;
wire [1:0] dist_temp237;
wire [1:0] dist_temp238;
wire [1:0] dist_temp239;
wire [1:0] dist_temp240;
wire [1:0] dist_temp241;
wire [1:0] dist_temp242;
wire [1:0] dist_temp243;
wire [1:0] dist_temp244;
wire [1:0] dist_temp245;
wire [1:0] dist_temp246;
wire [1:0] dist_temp247;
wire [1:0] dist_temp248;
wire [1:0] dist_temp249;
wire [1:0] dist_temp250;
wire [1:0] dist_temp251;
wire [1:0] dist_temp252;
wire [1:0] dist_temp253;
wire [1:0] dist_temp254;
wire [1:0] dist_temp255;
wire [1:0] dist_temp256;
wire [1:0] dist_temp257;
wire [1:0] dist_temp258;
wire [1:0] dist_temp259;
wire [1:0] dist_temp260;
wire [1:0] dist_temp261;
wire [1:0] dist_temp262;
wire [1:0] dist_temp263;
wire [1:0] dist_temp264;

wire [2:0] dist_temp301;
wire [2:0] dist_temp302;
wire [2:0] dist_temp303;
wire [2:0] dist_temp304;
wire [2:0] dist_temp305;
wire [2:0] dist_temp306;
wire [2:0] dist_temp307;
wire [2:0] dist_temp308;
wire [2:0] dist_temp309;
wire [2:0] dist_temp310;
wire [2:0] dist_temp311;
wire [2:0] dist_temp312;
wire [2:0] dist_temp313;
wire [2:0] dist_temp314;
wire [2:0] dist_temp315;
wire [2:0] dist_temp316;
wire [2:0] dist_temp317;
wire [2:0] dist_temp318;
wire [2:0] dist_temp319;
wire [2:0] dist_temp320;
wire [2:0] dist_temp321;
wire [2:0] dist_temp322;
wire [2:0] dist_temp323;
wire [2:0] dist_temp324;
wire [2:0] dist_temp325;
wire [2:0] dist_temp326;
wire [2:0] dist_temp327;
wire [2:0] dist_temp328;
wire [2:0] dist_temp329;
wire [2:0] dist_temp330;
wire [2:0] dist_temp331;
wire [2:0] dist_temp332;
wire [2:0] dist_temp333;
wire [2:0] dist_temp334;
wire [2:0] dist_temp335;
wire [2:0] dist_temp336;
wire [2:0] dist_temp337;
wire [2:0] dist_temp338;
wire [2:0] dist_temp339;
wire [2:0] dist_temp340;
wire [2:0] dist_temp341;
wire [2:0] dist_temp342;
wire [2:0] dist_temp343;
wire [2:0] dist_temp344;
wire [2:0] dist_temp345;
wire [2:0] dist_temp346;
wire [2:0] dist_temp347;
wire [2:0] dist_temp348;
wire [2:0] dist_temp349;
wire [2:0] dist_temp350;
wire [2:0] dist_temp351;
wire [2:0] dist_temp352;
wire [2:0] dist_temp353;
wire [2:0] dist_temp354;
wire [2:0] dist_temp355;
wire [2:0] dist_temp356;
wire [2:0] dist_temp357;
wire [2:0] dist_temp358;
wire [2:0] dist_temp359;
wire [2:0] dist_temp360;
wire [2:0] dist_temp361;
wire [2:0] dist_temp362;
wire [2:0] dist_temp363;
wire [2:0] dist_temp364;

reg [3:0] dist_temp401;
reg [3:0] dist_temp402;
reg [3:0] dist_temp403;
reg [3:0] dist_temp404;
reg [3:0] dist_temp405;
reg [3:0] dist_temp406;
reg [3:0] dist_temp407;
reg [3:0] dist_temp408;
reg [3:0] dist_temp409;
reg [3:0] dist_temp410;
reg [3:0] dist_temp411;
reg [3:0] dist_temp412;
reg [3:0] dist_temp413;
reg [3:0] dist_temp414;
reg [3:0] dist_temp415;
reg [3:0] dist_temp416;
reg [3:0] dist_temp417;
reg [3:0] dist_temp418;
reg [3:0] dist_temp419;
reg [3:0] dist_temp420;
reg [3:0] dist_temp421;
reg [3:0] dist_temp422;
reg [3:0] dist_temp423;
reg [3:0] dist_temp424;
reg [3:0] dist_temp425;
reg [3:0] dist_temp426;
reg [3:0] dist_temp427;
reg [3:0] dist_temp428;
reg [3:0] dist_temp429;
reg [3:0] dist_temp430;
reg [3:0] dist_temp431;
reg [3:0] dist_temp432;


wire [4:0] dist_temp501;
wire [4:0] dist_temp502;
wire [4:0] dist_temp503;
wire [4:0] dist_temp504;
wire [4:0] dist_temp505;
wire [4:0] dist_temp506;
wire [4:0] dist_temp507;
wire [4:0] dist_temp508;
wire [4:0] dist_temp509;
wire [4:0] dist_temp510;
wire [4:0] dist_temp511;
wire [4:0] dist_temp512;
wire [4:0] dist_temp513;
wire [4:0] dist_temp514;
wire [4:0] dist_temp515;
wire [4:0] dist_temp516;



wire [5:0] dist_temp601;
wire [5:0] dist_temp602;
wire [5:0] dist_temp603;
wire [5:0] dist_temp604;
wire [5:0] dist_temp605;
wire [5:0] dist_temp606;
wire [5:0] dist_temp607;
wire [5:0] dist_temp608;




reg [6:0] dist_temp701;
reg [6:0] dist_temp702;
reg [6:0] dist_temp703;
reg [6:0] dist_temp704;







wire [7:0] total_dist_temp1;
wire [7:0] total_dist_temp2;
wire [8:0] total_dist;
reg [8:0] best_dist_temp;
wire endl_a;
reg [8:0] bestdist;
reg [43:0] XYOXYO_temp;
reg [43:0] XYOXYO;
reg [14:0] addr_out_tp;
wire [14:0] addr_out;
reg end_search;
reg wren;
reg [14:0] num_matches;
reg start_SAD;
reg [1:0] count_start_SAD;





assign endl = (endl_a==1'b1)? 1'b1 : 1'b0;
assign endl_a = (addr_b_XYO_right==num_right-1)&(addr_b_XYO_right_tp1==num_right-1);

assign X_left = XYO_left[21:12];
assign Y_left = XYO_left[11:2];
assign X_right = XYO_right[21:12];
assign Y_right = XYO_right[11:2];
assign temp1_1 = Y_right + 2'd2;
assign temp1_2 = Y_right + 2'd3;
assign temp2_1 = Y_left + 2'd2;
assign temp2_2 = Y_left + 2'd3;
assign temp3 = X_right + fx;

assign dist_temp101 = dist_temp1[0] + dist_temp1[1];
assign dist_temp102 = dist_temp1[2] + dist_temp1[3];
assign dist_temp103 = dist_temp1[4] + dist_temp1[5];
assign dist_temp104 = dist_temp1[6] + dist_temp1[7];
assign dist_temp105 = dist_temp1[8] + dist_temp1[9];
assign dist_temp106 = dist_temp1[10] + dist_temp1[11];
assign dist_temp107 = dist_temp1[12] + dist_temp1[13];
assign dist_temp108 = dist_temp1[14] + dist_temp1[15];
assign dist_temp109 = dist_temp1[16] + dist_temp1[17];
assign dist_temp110 = dist_temp1[18] + dist_temp1[19];
assign dist_temp111 = dist_temp1[20] + dist_temp1[21];
assign dist_temp112 = dist_temp1[22] + dist_temp1[23];
assign dist_temp113 = dist_temp1[24] + dist_temp1[25];
assign dist_temp114 = dist_temp1[26] + dist_temp1[27];
assign dist_temp115 = dist_temp1[28] + dist_temp1[29];
assign dist_temp116 = dist_temp1[30] + dist_temp1[31];
assign dist_temp117 = dist_temp1[32] + dist_temp1[33];
assign dist_temp118 = dist_temp1[34] + dist_temp1[35];
assign dist_temp119 = dist_temp1[36] + dist_temp1[37];
assign dist_temp120 = dist_temp1[38] + dist_temp1[39];
assign dist_temp121 = dist_temp1[40] + dist_temp1[41];
assign dist_temp122 = dist_temp1[42] + dist_temp1[43];
assign dist_temp123 = dist_temp1[44] + dist_temp1[45];
assign dist_temp124 = dist_temp1[46] + dist_temp1[47];
assign dist_temp125 = dist_temp1[48] + dist_temp1[49];
assign dist_temp126 = dist_temp1[50] + dist_temp1[51];
assign dist_temp127 = dist_temp1[52] + dist_temp1[53];
assign dist_temp128 = dist_temp1[54] + dist_temp1[55];
assign dist_temp129 = dist_temp1[56] + dist_temp1[57];
assign dist_temp130 = dist_temp1[58] + dist_temp1[59];
assign dist_temp131 = dist_temp1[60] + dist_temp1[61];
assign dist_temp132 = dist_temp1[62] + dist_temp1[63];
assign dist_temp133 = dist_temp1[64] + dist_temp1[65];
assign dist_temp134 = dist_temp1[66] + dist_temp1[67];
assign dist_temp135 = dist_temp1[68] + dist_temp1[69];
assign dist_temp136 = dist_temp1[70] + dist_temp1[71];
assign dist_temp137 = dist_temp1[72] + dist_temp1[73];
assign dist_temp138 = dist_temp1[74] + dist_temp1[75];
assign dist_temp139 = dist_temp1[76] + dist_temp1[77];
assign dist_temp140 = dist_temp1[78] + dist_temp1[79];
assign dist_temp141 = dist_temp1[80] + dist_temp1[81];
assign dist_temp142 = dist_temp1[82] + dist_temp1[83];
assign dist_temp143 = dist_temp1[84] + dist_temp1[85];
assign dist_temp144 = dist_temp1[86] + dist_temp1[87];
assign dist_temp145 = dist_temp1[88] + dist_temp1[89];
assign dist_temp146 = dist_temp1[90] + dist_temp1[91];
assign dist_temp147 = dist_temp1[92] + dist_temp1[93];
assign dist_temp148 = dist_temp1[94] + dist_temp1[95];
assign dist_temp149 = dist_temp1[96] + dist_temp1[97];
assign dist_temp150 = dist_temp1[98] + dist_temp1[99];
assign dist_temp151 = dist_temp1[100] + dist_temp1[101];
assign dist_temp152 = dist_temp1[102] + dist_temp1[103];
assign dist_temp153 = dist_temp1[104] + dist_temp1[105];
assign dist_temp154 = dist_temp1[106] + dist_temp1[107];
assign dist_temp155 = dist_temp1[108] + dist_temp1[109];
assign dist_temp156 = dist_temp1[110] + dist_temp1[111];
assign dist_temp157 = dist_temp1[112] + dist_temp1[113];
assign dist_temp158 = dist_temp1[114] + dist_temp1[115];
assign dist_temp159 = dist_temp1[116] + dist_temp1[117];
assign dist_temp160 = dist_temp1[118] + dist_temp1[119];
assign dist_temp161 = dist_temp1[120] + dist_temp1[121];
assign dist_temp162 = dist_temp1[122] + dist_temp1[123];
assign dist_temp163 = dist_temp1[124] + dist_temp1[125];
assign dist_temp164 = dist_temp1[126] + dist_temp1[127];

assign dist_temp201 = dist_temp2[0] + dist_temp2[1];
assign dist_temp202 = dist_temp2[2] + dist_temp2[3];
assign dist_temp203 = dist_temp2[4] + dist_temp2[5];
assign dist_temp204 = dist_temp2[6] + dist_temp2[7];
assign dist_temp205 = dist_temp2[8] + dist_temp2[9];
assign dist_temp206 = dist_temp2[10] + dist_temp2[11];
assign dist_temp207 = dist_temp2[12] + dist_temp2[13];
assign dist_temp208 = dist_temp2[14] + dist_temp2[15];
assign dist_temp209 = dist_temp2[16] + dist_temp2[17];
assign dist_temp210 = dist_temp2[18] + dist_temp2[19];
assign dist_temp211 = dist_temp2[20] + dist_temp2[21];
assign dist_temp212 = dist_temp2[22] + dist_temp2[23];
assign dist_temp213 = dist_temp2[24] + dist_temp2[25];
assign dist_temp214 = dist_temp2[26] + dist_temp2[27];
assign dist_temp215 = dist_temp2[28] + dist_temp2[29];
assign dist_temp216 = dist_temp2[30] + dist_temp2[31];
assign dist_temp217 = dist_temp2[32] + dist_temp2[33];
assign dist_temp218 = dist_temp2[34] + dist_temp2[35];
assign dist_temp219 = dist_temp2[36] + dist_temp2[37];
assign dist_temp220 = dist_temp2[38] + dist_temp2[39];
assign dist_temp221 = dist_temp2[40] + dist_temp2[41];
assign dist_temp222 = dist_temp2[42] + dist_temp2[43];
assign dist_temp223 = dist_temp2[44] + dist_temp2[45];
assign dist_temp224 = dist_temp2[46] + dist_temp2[47];
assign dist_temp225 = dist_temp2[48] + dist_temp2[49];
assign dist_temp226 = dist_temp2[50] + dist_temp2[51];
assign dist_temp227 = dist_temp2[52] + dist_temp2[53];
assign dist_temp228 = dist_temp2[54] + dist_temp2[55];
assign dist_temp229 = dist_temp2[56] + dist_temp2[57];
assign dist_temp230 = dist_temp2[58] + dist_temp2[59];
assign dist_temp231 = dist_temp2[60] + dist_temp2[61];
assign dist_temp232 = dist_temp2[62] + dist_temp2[63];
assign dist_temp233 = dist_temp2[64] + dist_temp2[65];
assign dist_temp234 = dist_temp2[66] + dist_temp2[67];
assign dist_temp235 = dist_temp2[68] + dist_temp2[69];
assign dist_temp236 = dist_temp2[70] + dist_temp2[71];
assign dist_temp237 = dist_temp2[72] + dist_temp2[73];
assign dist_temp238 = dist_temp2[74] + dist_temp2[75];
assign dist_temp239 = dist_temp2[76] + dist_temp2[77];
assign dist_temp240 = dist_temp2[78] + dist_temp2[79];
assign dist_temp241 = dist_temp2[80] + dist_temp2[81];
assign dist_temp242 = dist_temp2[82] + dist_temp2[83];
assign dist_temp243 = dist_temp2[84] + dist_temp2[85];
assign dist_temp244 = dist_temp2[86] + dist_temp2[87];
assign dist_temp245 = dist_temp2[88] + dist_temp2[89];
assign dist_temp246 = dist_temp2[90] + dist_temp2[91];
assign dist_temp247 = dist_temp2[92] + dist_temp2[93];
assign dist_temp248 = dist_temp2[94] + dist_temp2[95];
assign dist_temp249 = dist_temp2[96] + dist_temp2[97];
assign dist_temp250 = dist_temp2[98] + dist_temp2[99];
assign dist_temp251 = dist_temp2[100] + dist_temp2[101];
assign dist_temp252 = dist_temp2[102] + dist_temp2[103];
assign dist_temp253 = dist_temp2[104] + dist_temp2[105];
assign dist_temp254 = dist_temp2[106] + dist_temp2[107];
assign dist_temp255 = dist_temp2[108] + dist_temp2[109];
assign dist_temp256 = dist_temp2[110] + dist_temp2[111];
assign dist_temp257 = dist_temp2[112] + dist_temp2[113];
assign dist_temp258 = dist_temp2[114] + dist_temp2[115];
assign dist_temp259 = dist_temp2[116] + dist_temp2[117];
assign dist_temp260 = dist_temp2[118] + dist_temp2[119];
assign dist_temp261 = dist_temp2[120] + dist_temp2[121];
assign dist_temp262 = dist_temp2[122] + dist_temp2[123];
assign dist_temp263 = dist_temp2[124] + dist_temp2[125];
assign dist_temp264 = dist_temp2[126] + dist_temp2[127];

assign dist_temp301 = dist_temp101 + dist_temp102;
assign dist_temp302 = dist_temp103 + dist_temp104;
assign dist_temp303 = dist_temp105 + dist_temp106;
assign dist_temp304 = dist_temp107 + dist_temp108;
assign dist_temp305 = dist_temp109 + dist_temp110;
assign dist_temp306 = dist_temp111 + dist_temp112;
assign dist_temp307 = dist_temp113 + dist_temp114;
assign dist_temp308 = dist_temp115 + dist_temp116;
assign dist_temp309 = dist_temp117 + dist_temp118;
assign dist_temp310 = dist_temp119 + dist_temp120;
assign dist_temp311 = dist_temp121 + dist_temp122;
assign dist_temp312 = dist_temp123 + dist_temp124;
assign dist_temp313 = dist_temp125 + dist_temp126;
assign dist_temp314 = dist_temp127 + dist_temp128;
assign dist_temp315 = dist_temp129 + dist_temp130;
assign dist_temp316 = dist_temp131 + dist_temp132;
assign dist_temp317 = dist_temp133 + dist_temp134;
assign dist_temp318 = dist_temp135 + dist_temp136;
assign dist_temp319 = dist_temp137 + dist_temp138;
assign dist_temp320 = dist_temp139 + dist_temp140;
assign dist_temp321 = dist_temp141 + dist_temp142;
assign dist_temp322 = dist_temp143 + dist_temp144;
assign dist_temp323 = dist_temp145 + dist_temp146;
assign dist_temp324 = dist_temp147 + dist_temp148;
assign dist_temp325 = dist_temp149 + dist_temp150;
assign dist_temp326 = dist_temp151 + dist_temp152;
assign dist_temp327 = dist_temp153 + dist_temp154;
assign dist_temp328 = dist_temp155 + dist_temp156;
assign dist_temp329 = dist_temp157 + dist_temp158;
assign dist_temp330 = dist_temp159 + dist_temp160;
assign dist_temp331 = dist_temp161 + dist_temp162;
assign dist_temp332 = dist_temp163 + dist_temp164;
assign dist_temp333 = dist_temp201 + dist_temp202;
assign dist_temp334 = dist_temp203 + dist_temp204;
assign dist_temp335 = dist_temp205 + dist_temp206;
assign dist_temp336 = dist_temp207 + dist_temp208;
assign dist_temp337 = dist_temp209 + dist_temp210;
assign dist_temp338 = dist_temp211 + dist_temp212;
assign dist_temp339 = dist_temp213 + dist_temp214;
assign dist_temp340 = dist_temp215 + dist_temp216;
assign dist_temp341 = dist_temp217 + dist_temp218;
assign dist_temp342 = dist_temp219 + dist_temp220;
assign dist_temp343 = dist_temp221 + dist_temp222;
assign dist_temp344 = dist_temp223 + dist_temp224;
assign dist_temp345 = dist_temp225 + dist_temp226;
assign dist_temp346 = dist_temp227 + dist_temp228;
assign dist_temp347 = dist_temp229 + dist_temp230;
assign dist_temp348 = dist_temp231 + dist_temp232;
assign dist_temp349 = dist_temp233 + dist_temp234;
assign dist_temp350 = dist_temp235 + dist_temp236;
assign dist_temp351 = dist_temp237 + dist_temp238;
assign dist_temp352 = dist_temp239 + dist_temp240;
assign dist_temp353 = dist_temp241 + dist_temp242;
assign dist_temp354 = dist_temp243 + dist_temp244;
assign dist_temp355 = dist_temp245 + dist_temp246;
assign dist_temp356 = dist_temp247 + dist_temp248;
assign dist_temp357 = dist_temp249 + dist_temp250;
assign dist_temp358 = dist_temp251 + dist_temp252;
assign dist_temp359 = dist_temp253 + dist_temp254;
assign dist_temp360 = dist_temp255 + dist_temp256;
assign dist_temp361 = dist_temp257 + dist_temp258;
assign dist_temp362 = dist_temp259 + dist_temp260;
assign dist_temp363 = dist_temp261 + dist_temp262;
assign dist_temp364 = dist_temp263 + dist_temp264;

assign dist_temp501 = dist_temp401 + dist_temp402;
assign dist_temp502 = dist_temp403 + dist_temp404;
assign dist_temp503 = dist_temp405 + dist_temp406;
assign dist_temp504 = dist_temp407 + dist_temp408;
assign dist_temp505 = dist_temp409 + dist_temp410;
assign dist_temp506 = dist_temp411 + dist_temp412;
assign dist_temp507 = dist_temp413 + dist_temp414;
assign dist_temp508 = dist_temp415 + dist_temp416;
assign dist_temp509 = dist_temp417 + dist_temp418;
assign dist_temp510 = dist_temp419 + dist_temp420;
assign dist_temp511 = dist_temp421 + dist_temp422;
assign dist_temp512 = dist_temp423 + dist_temp424;
assign dist_temp513 = dist_temp425 + dist_temp426;
assign dist_temp514 = dist_temp427 + dist_temp428;
assign dist_temp515 = dist_temp429 + dist_temp430;
assign dist_temp516 = dist_temp431 + dist_temp432;

assign dist_temp601 = dist_temp501 + dist_temp502;
assign dist_temp602 = dist_temp503 + dist_temp504;
assign dist_temp603 = dist_temp505 + dist_temp506;
assign dist_temp604 = dist_temp507 + dist_temp508;
assign dist_temp605 = dist_temp509 + dist_temp510;
assign dist_temp606 = dist_temp511 + dist_temp512;
assign dist_temp607 = dist_temp513 + dist_temp514;
assign dist_temp608 = dist_temp515 + dist_temp516;

assign total_dist_temp1 = dist_temp701 + dist_temp702;
assign total_dist_temp2 = dist_temp703 + dist_temp704;
assign total_dist = total_dist_temp1 + total_dist_temp2;


assign addr_out = (addr_out_tp>0)? addr_out_tp - 1'b1 : 15'd0;



always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      addr_b_XYO_left_tp1 <= 14'd0;
      addr_b_XYO_left_tp2 <= 14'd0;
      addr_b_XYO_left_tp3 <= 14'd0;
      flag_tp1 <= 1'd1;
      flag_tp2 <= 1'd1;
      flag_tp3 <= 1'd1;
      flag_tp4 <= 1'd1;
      flag_tp5 <= 1'd1;
      flag_tp6 <= 1'd1;
      endl_tp1 <= 1'd0;
      endl_tp2 <= 1'd0;
      endl_tp3 <= 1'd0;
      endl_tp4 <= 1'd0;
      endl_tp5 <= 1'd0;
      endl_tp6 <= 1'd0;
      endl_tp7 <= 1'd0;
      endl_tp8 <= 1'd0;
      endl_tp9 <= 1'd0;
    end
  else if(start==1)
    begin
      addr_b_XYO_left_tp1 <= 14'd0;
      addr_b_XYO_left_tp2 <= 14'd0;
      addr_b_XYO_left_tp3 <= 14'd0;
      flag_tp1 <= 1'd1;
      flag_tp2 <= 1'd1;
      flag_tp3 <= 1'd1;
      flag_tp4 <= 1'd1;
      flag_tp5 <= 1'd1;
      flag_tp6 <= 1'd1;
      endl_tp1 <= 1'd0;
      endl_tp2 <= 1'd0;
      endl_tp3 <= 1'd0;
      endl_tp4 <= 1'd0;
      endl_tp5 <= 1'd0;
      endl_tp6 <= 1'd0;
      endl_tp7 <= 1'd0;
      endl_tp8 <= 1'd0;
      endl_tp9 <= 1'd0;
    end
  else
    begin
      addr_b_XYO_left_tp1 <= addr_b_XYO_left;
      addr_b_XYO_left_tp2 <= addr_b_XYO_left_tp1;
      addr_b_XYO_left_tp3 <= addr_b_XYO_left_tp2;
      flag_tp1 <= flag;
      flag_tp2 <= flag_tp1;
      flag_tp3 <= flag_tp2;
      flag_tp4 <= flag_tp3;
      flag_tp5 <= flag_tp4;
      flag_tp6 <= flag_tp5;
      endl_tp1 <= endl;
      endl_tp2 <= endl_tp1;
      endl_tp3 <= endl_tp2;
      endl_tp4 <= endl_tp3;
      endl_tp5 <= endl_tp4;
      endl_tp6 <= endl_tp5;
      endl_tp7 <= endl_tp6;
      endl_tp8 <= endl_tp7;
      endl_tp9 <= endl_tp8;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      addr_b_XYO_right_tp1 <= 14'd0;
      addr_b_XYO_right_tp2 <= 14'd0;
      addr_b_XYO_right_tp3 <= 14'd0;
    end
  else if(start==1)
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
    begin
      XYO_left_tp1 <= 22'd0;
      XYO_left_tp2 <= 22'd0;
      XYO_left_tp3 <= 22'd0;
      XYO_left_tp4 <= 22'd0;
      XYO_left_tp5 <= 22'd0;
      XYO_left_tp6 <= 22'd0;
      XYO_left_tp7 <= 22'd0;
      XYO_right_tp1 <= 22'd0;
      XYO_right_tp2 <= 22'd0;
      XYO_right_tp3 <= 22'd0;
      XYO_right_tp4 <= 22'd0;
      XYO_right_tp5 <= 22'd0;
      XYO_right_tp6 <= 22'd0;
      XYO_right_tp7 <= 22'd0;
    end
  else if(start==1)
    begin
      XYO_left_tp1 <= 22'd0;
      XYO_left_tp2 <= 22'd0;
      XYO_left_tp3 <= 22'd0;
      XYO_left_tp4 <= 22'd0;
      XYO_left_tp5 <= 22'd0;
      XYO_left_tp6 <= 22'd0;
      XYO_left_tp7 <= 22'd0;
      XYO_right_tp1 <= 22'd0;
      XYO_right_tp2 <= 22'd0;
      XYO_right_tp3 <= 22'd0;
      XYO_right_tp4 <= 22'd0;
      XYO_right_tp5 <= 22'd0;
      XYO_right_tp6 <= 22'd0;
      XYO_right_tp7 <= 22'd0;
    end
  else
    begin
      XYO_left_tp1 <= XYO_left;
      XYO_left_tp2 <= XYO_left_tp1;
      XYO_left_tp3 <= XYO_left_tp2;
      XYO_left_tp4 <= XYO_left_tp3;
      XYO_left_tp5 <= XYO_left_tp4;
      XYO_left_tp6 <= XYO_left_tp5;
      XYO_left_tp7 <= XYO_left_tp6;
      XYO_right_tp1 <= XYO_right;
      XYO_right_tp2 <= XYO_right_tp1;
      XYO_right_tp3 <= XYO_right_tp2;
      XYO_right_tp4 <= XYO_right_tp3;
      XYO_right_tp5 <= XYO_right_tp4;
      XYO_right_tp6 <= XYO_right_tp5;
      XYO_right_tp7 <= XYO_right_tp6;
    end
end
      
            


always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_b_XYO_left <= 14'd0;
  else if(start==1)
    addr_b_XYO_left <= 14'd0;
  else if(endl==1 && addr_b_XYO_left<num_left-1)
    addr_b_XYO_left <= addr_b_XYO_left + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_b_XYO_right <= 14'd0;
  else if(start==1)
    addr_b_XYO_right <= 14'd0;
  else if(endl==1 && addr_b_XYO_left<num_left-1)
    addr_b_XYO_right <= 14'd0;
  else if(addr_b_XYO_right<num_right-1) 
    addr_b_XYO_right <= addr_b_XYO_right + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    flag <= 1'b1;
  else if(start==1)
    flag <= 1'b1;
  else 
    begin
      if(XYO_right[1:0]==2'b01)
        begin
          if(temp1_1>=Y_left && temp2_1>=Y_right && temp3>=X_left && X_left>=X_right)
            flag <= 1'b0;
          else
            flag <= 1'b1;
        end
      else if(XYO_right[1:0]==2'b10)
        begin
          if(temp1_2>=Y_left && temp2_2>=Y_right && temp3>=X_left && X_left>=X_right)
            flag <= 1'b0;
          else
            flag <= 1'b1;
        end
    end
end 



always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      addr_b1_descriptor_left <= 15'd0;
      addr_b2_descriptor_left <= 15'd0;
      addr_b1_descriptor_right <= 15'd0;
      addr_b2_descriptor_right <= 15'd0;
    end
  else if(start==1)
    begin
      addr_b1_descriptor_left <= 15'd0;
      addr_b2_descriptor_left <= 15'd0;
      addr_b1_descriptor_right <= 15'd0;
      addr_b2_descriptor_right <= 15'd0;
    end
  else if(flag==0)
    begin
      addr_b1_descriptor_left <= {addr_b_XYO_left_tp3,1'b0};
      addr_b2_descriptor_left <= {addr_b_XYO_left_tp3,1'b0} + 1'b1;
      addr_b1_descriptor_right <= {addr_b_XYO_right_tp3,1'b0};
      addr_b2_descriptor_right <= {addr_b_XYO_right_tp3,1'b0} + 1'b1;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      dist_temp1 <= 128'd0;
      dist_temp2 <= 128'd0;
    end
  else if(start==1)
    begin
      dist_temp1 <= 128'd0;
      dist_temp2 <= 128'd0;
    end
  else if(flag_tp3==0)
    begin
      dist_temp1 <= descriptor1_left ^ descriptor1_right;
      dist_temp2 <= descriptor2_left ^ descriptor2_right;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      dist_temp401 <= 4'd0;
      dist_temp402 <= 4'd0;
      dist_temp403 <= 4'd0;
      dist_temp404 <= 4'd0;
      dist_temp405 <= 4'd0;
      dist_temp406 <= 4'd0;
      dist_temp407 <= 4'd0;
      dist_temp408 <= 4'd0;
      dist_temp409 <= 4'd0;
      dist_temp410 <= 4'd0;
      dist_temp411 <= 4'd0;
      dist_temp412 <= 4'd0;
      dist_temp413 <= 4'd0;
      dist_temp414 <= 4'd0;
      dist_temp415 <= 4'd0;
      dist_temp416 <= 4'd0;
      dist_temp417 <= 4'd0;
      dist_temp418 <= 4'd0;
      dist_temp419 <= 4'd0;
      dist_temp420 <= 4'd0;
      dist_temp421 <= 4'd0;
      dist_temp422 <= 4'd0;
      dist_temp423 <= 4'd0;
      dist_temp424 <= 4'd0;
      dist_temp425 <= 4'd0;
      dist_temp426 <= 4'd0;
      dist_temp427 <= 4'd0;
      dist_temp428 <= 4'd0;
      dist_temp429 <= 4'd0;
      dist_temp430 <= 4'd0;
      dist_temp431 <= 4'd0;
      dist_temp432 <= 4'd0;
    end
  else if(start==1)
    begin
      dist_temp401 <= 4'd0;
      dist_temp402 <= 4'd0;
      dist_temp403 <= 4'd0;
      dist_temp404 <= 4'd0;
      dist_temp405 <= 4'd0;
      dist_temp406 <= 4'd0;
      dist_temp407 <= 4'd0;
      dist_temp408 <= 4'd0;
      dist_temp409 <= 4'd0;
      dist_temp410 <= 4'd0;
      dist_temp411 <= 4'd0;
      dist_temp412 <= 4'd0;
      dist_temp413 <= 4'd0;
      dist_temp414 <= 4'd0;
      dist_temp415 <= 4'd0;
      dist_temp416 <= 4'd0;
      dist_temp417 <= 4'd0;
      dist_temp418 <= 4'd0;
      dist_temp419 <= 4'd0;
      dist_temp420 <= 4'd0;
      dist_temp421 <= 4'd0;
      dist_temp422 <= 4'd0;
      dist_temp423 <= 4'd0;
      dist_temp424 <= 4'd0;
      dist_temp425 <= 4'd0;
      dist_temp426 <= 4'd0;
      dist_temp427 <= 4'd0;
      dist_temp428 <= 4'd0;
      dist_temp429 <= 4'd0;
      dist_temp430 <= 4'd0;
      dist_temp431 <= 4'd0;
      dist_temp432 <= 4'd0;
    end
  else if(flag_tp4==0)
    begin
      dist_temp401 <= dist_temp301 + dist_temp302;
      dist_temp402 <= dist_temp303 + dist_temp304;
      dist_temp403 <= dist_temp305 + dist_temp306;
      dist_temp404 <= dist_temp307 + dist_temp308;
      dist_temp405 <= dist_temp309 + dist_temp310;
      dist_temp406 <= dist_temp311 + dist_temp312;
      dist_temp407 <= dist_temp313 + dist_temp314;
      dist_temp408 <= dist_temp315 + dist_temp316;
      dist_temp409 <= dist_temp317 + dist_temp318;
      dist_temp410 <= dist_temp319 + dist_temp320;
      dist_temp411 <= dist_temp321 + dist_temp322;
      dist_temp412 <= dist_temp323 + dist_temp324;
      dist_temp413 <= dist_temp325 + dist_temp326;
      dist_temp414 <= dist_temp327 + dist_temp328;
      dist_temp415 <= dist_temp329 + dist_temp330;
      dist_temp416 <= dist_temp331 + dist_temp332;
      dist_temp417 <= dist_temp333 + dist_temp334;
      dist_temp418 <= dist_temp335 + dist_temp336;
      dist_temp419 <= dist_temp337 + dist_temp338;
      dist_temp420 <= dist_temp339 + dist_temp340;
      dist_temp421 <= dist_temp341 + dist_temp342;
      dist_temp422 <= dist_temp343 + dist_temp344;
      dist_temp423 <= dist_temp345 + dist_temp346;
      dist_temp424 <= dist_temp347 + dist_temp348;
      dist_temp425 <= dist_temp349 + dist_temp350;
      dist_temp426 <= dist_temp351 + dist_temp352;
      dist_temp427 <= dist_temp353 + dist_temp354;
      dist_temp428 <= dist_temp355 + dist_temp356;
      dist_temp429 <= dist_temp357 + dist_temp358;
      dist_temp430 <= dist_temp359 + dist_temp360;
      dist_temp431 <= dist_temp361 + dist_temp362;
      dist_temp432 <= dist_temp363 + dist_temp364;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    begin
      dist_temp701 <= 7'd0;
      dist_temp702 <= 7'd0;
      dist_temp703 <= 7'd0;
      dist_temp704 <= 7'd0;
    end
  else if(start==1)
    begin
      dist_temp701 <= 7'd0;
      dist_temp702 <= 7'd0;
      dist_temp703 <= 7'd0;
      dist_temp704 <= 7'd0;
    end
  else if(flag_tp5==0)
    begin
      dist_temp701 <= dist_temp601 + dist_temp602;
      dist_temp702 <= dist_temp603 + dist_temp604;
      dist_temp703 <= dist_temp605 + dist_temp606;
      dist_temp704 <= dist_temp607 + dist_temp608;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    best_dist_temp <= 9'd0;
  else if(start==1 || endl_tp9==1)
    best_dist_temp <= 9'd256;
  else if(flag_tp6==0)
    begin
      if(total_dist<best_dist_temp)
        best_dist_temp <= total_dist;
    end
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    bestdist <= 9'd0;
  else if(start==1)
    bestdist <= 9'd0;
  else if(endl_tp9==1 && best_dist_temp<75)
    bestdist <= best_dist_temp;
end        

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    XYOXYO_temp <= 44'd0;
  else if(start==1 || endl_tp9==1)
    XYOXYO_temp <= 44'd0;
  else if(flag_tp6==0)
    begin
      if(total_dist<best_dist_temp)
        XYOXYO_temp <= {XYO_left_tp7,XYO_right_tp7};
    end
end      

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    XYOXYO <= 44'd0;
  else if(start==1)
    XYOXYO <= 44'd0;
  else if(endl_tp9==1 && best_dist_temp<75)
    XYOXYO <= XYOXYO_temp;
end  

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    addr_out_tp <= 15'd0;
  else if(start==1)
    addr_out_tp <= 15'd0;
  else if(endl_tp9==1 && best_dist_temp<75)
    addr_out_tp <= addr_out_tp + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
  if(!rst_n)
    end_search <= 1'b0;
  else if(start==1)
    end_search <= 1'b0;
  else if(addr_b_XYO_left==num_left-1 && addr_b_XYO_right==num_right-1 && endl_tp9==1)
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

      
   
    

    
      
    
