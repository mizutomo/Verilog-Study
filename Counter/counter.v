`timescale 1ns / 1ns

module Counter(reset, clk, count);
  input clk;
  input reset;
  output [31:0] count;

  reg [31:0] count;

  initial
    count = 0;

  always @(posedge clk)
    if (reset)
      count <= 0;
    else
      count <= count + 1;

endmodule

