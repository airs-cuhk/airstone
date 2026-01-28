module mux_2_1_17bits(sel,din_1,din_2,dout);
  input sel;
  input din_1,din_2;
  output dout;
  
  wire [16:0] din_1;
  wire [16:0] din_2;
  reg [16:0] dout;
  
  always@(din_1 or din_2 or sel)
  begin
    case(sel)
      1'b0: dout = din_1;
      1'b1: dout = din_2;
      default:dout = 17'b00000000000000000;
    endcase
  end
  
endmodule 
