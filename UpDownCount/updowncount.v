module updowncount(RES, CK, UP, Q);
input wire RES, CK, UP;
output reg [3:0] Q;

always @(posedge CK or posedge RES) begin
  if (RES == 1'b1) begin
    Q <= 0;
  end else if (UP == 1'b1) begin
    if (Q == 15)
      Q <= 0;
    else
      Q <= Q + 1;
  end else begin
    if (Q == 0)
      Q <= 15;
    else
      Q <= Q - 1;
  end
end

endmodule
