`timescale 1ns / 1ns

module addex_tb;

parameter STEP   = 100;
parameter STROBE = 10;
parameter PATNUM = 8;

reg  [7:0] mem1 [0:PATNUM-1];
reg  [3:0] mem2 [0:PATNUM-1];
reg  [3:0] a, b;
wire [3:0] q;
integer i, j;

addex addex(.A(a), .B(b[2:0]), .Q(q));

initial begin
  $readmemh("input.txt", mem1);
  for (i=0; i<PATNUM; i=i+1) begin
    {a, b} = mem1[i];
    #STEP;
  end
  $finish;
end

initial begin
  $readmemh("expect.txt", mem2);
  for (j=0; j<PATNUM; j=j+1) begin
    #(STEP-STROBE) if (mem2[j] !== q) begin
      $display("Mismatch Error!");
      $display("q=%h expect=%h", q, mem2[j]);
    end
    #STROBE;
  end
end

endmodule
