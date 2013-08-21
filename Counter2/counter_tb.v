`timescale 1ns / 100ps

module counter_tb;

parameter DELAY = 10;
parameter STROBE = 90;

reg RST_X, COUNTON;
wire [3:0] CNT4;
integer I, J;
integer fd;
reg [1:0] mem [0:39];

`include "common_clk.h"

counter counter(.CLK(CLK), .RST_X(RST_X), .COUNTON(COUNTON), .CNT4(CNT4));

initial begin
  RST_X   = 1'b1;
  COUNTON = 1'b0;
end

initial begin
  $readmemb("input.txt", mem);
  #DELAY;
  for (J=0; J<40; J=J+1) begin
    {RST_X, COUNTON} = mem[J];
    #CYCLE;
  end
end

initial begin
  fd = $fopen("output.txt");
  #STROBE
  for (I=0; I<40; I=I+1) begin
    $fdisplay(fd, "TIME=%t", $time, " RST_X=%b", RST_X, " COUNTON=%b", COUNTON, " CNT4=%h", CNT4);
    #CYCLE;
  end
  $fclose(fd);
  $finish;
end

endmodule
