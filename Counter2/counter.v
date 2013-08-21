module counter(CLK, RST_X, COUNTON, CNT4);
input wire CLK, RST_X, COUNTON;
output reg [3:0] CNT4;

always @(posedge CLK or negedge RST_X) begin
  if (!RST_X)
    CNT4 <= 0;
  else
    if (COUNTON) begin
      if (CNT4 == 11)
        CNT4 <= 0;
      else
        CNT4 <= CNT4 + 1;
    end
end

endmodule

