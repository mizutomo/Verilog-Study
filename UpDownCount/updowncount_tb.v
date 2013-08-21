`timescale 1ns / 1ns

module updowncount_tb;

parameter CYCLE = 100;
parameter HALF_CYCLE = 50;
parameter DELAY = 10;
parameter STROBE = 90;

reg RST_X, CLK, UP;
wire [3:0] CNT4;

updowncount updowncount(.CK(CLK), .RES(RST_X), .UP(UP), .Q(CNT4));

always begin
              CLK = 1'b1;
  #HALF_CYCLE CLK = 1'b0;
  #HALF_CYCLE;
end

task reset_counter;
begin
         RST_X = 0;
  #CYCLE RST_X = 1;
  #CYCLE RST_X = 0;
end
endtask

task count_updown;
input dir;
begin
  UP = dir;
  #(CYCLE*20);
end
endtask

initial begin
  RST_X = 1'b0;
  UP    = 1'b0;
  #DELAY;
  reset_counter;
  count_updown(1'b1);
  reset_counter;
  count_updown(1'b0);
  $finish;
end

endmodule
