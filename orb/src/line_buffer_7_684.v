module line_buffer_7_684(din,taps1,taps2,taps3,taps4,taps5,taps6,taps7,clk,rst_n,en);
  input din;
  input clk;
  input rst_n;
  input en;
  output taps1,taps2,taps3,taps4,taps5,taps6,taps7;
  
  wire [7:0] din;
  wire [7:0] taps1,taps2,taps3,taps4,taps5,taps6,taps7;

  
  
  
  line_buffer #(684) lb1(.clk(clk),
                  .rst_n(rst_n),
                  .din(din),
                  .dout(taps1),
                  .en(en));
                  
                  
  line_buffer #(684) lb2(.clk(clk),
                  .rst_n(rst_n),
                  .din(taps1),
                  .dout(taps2),
                  .en(en));
                  
  line_buffer #(684) lb3(.clk(clk),
                  .rst_n(rst_n),
                  .din(taps2),
                  .dout(taps3),
                  .en(en));
                  
  line_buffer #(684) lb4(.clk(clk),
                  .rst_n(rst_n),
                  .din(taps3),
                  .dout(taps4),
                  .en(en));
                  
  line_buffer #(684) lb5(.clk(clk),
                  .rst_n(rst_n),
                  .din(taps4),
                  .dout(taps5),
                  .en(en));
                  
                  
  line_buffer #(684) lb6(.clk(clk),
                  .rst_n(rst_n),
                  .din(taps5),
                  .dout(taps6),
                  .en(en));
                  
  line_buffer #(684) lb7(.clk(clk),
                  .rst_n(rst_n),
                  .din(taps6),
                  .dout(taps7),
                  .en(en));
                  
endmodule


