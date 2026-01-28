module mux_2_1_b(sel,din_1,din_2,dout);
  input sel;
  input din_1,din_2;
  output dout;
  
  wire [13:0] din_1;
  wire [13:0] din_2;
  reg [13:0] dout;
  
  always@(din_1 or din_2 or sel)
  begin
    case(sel)
      1'b0: dout = din_1;
      1'b1: dout = din_2;
      default:dout = 14'd0;
    endcase
  end
  
endmodule 
