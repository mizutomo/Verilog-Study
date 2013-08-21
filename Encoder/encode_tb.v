`timescale 1ns / 1ns

module encode_tb;
reg [7:0] SDIN;
wire [2:0] SDOUT;
parameter STEP =100;
integer I;

encode encode(.DIN(SDIN), .DOUT(SDOUT));

initial begin
  for (I=0; I<8; I=I+1) begin
    SDIN = 8'h00;
    SDIN[I] = 1'b1;
    #STEP;
  end
  $finish;
end

endmodule
