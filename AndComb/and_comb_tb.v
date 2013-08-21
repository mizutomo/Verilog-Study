`timescale 1ns / 1ns

module and_comb_tb;
reg SA, SB;
wire SY;

and_comb and_comb(.A(SA), .B(SB), .Y(SY));

initial begin
       SA = 0; SB = 0;
  #100 SA = 1; SB = 0;
  #100 SA = 0; SB = 1;
  #100 SA = 1; SB = 1;
  #100 $finish;
end

initial begin
  #50  $display("A=%b B=%b Y=%b", SA, SB, SY);
  #100 $display("A=%b B=%b Y=%b", SA, SB, SY);
  #100 $display("A=%b B=%b Y=%b", SA, SB, SY);
  #100 $display("A=%b B=%b Y=%b", SA, SB, SY);
end

endmodule
