module addex(A, B, Q);
input wire [3:0] A;
input wire [2:0] B;
output wire [3:0] Q;

wire [4:0] temp_sum;

assign temp_sum = A + B;
assign Q = (temp_sum[4] == 1'b1)? 4'hf : temp_sum[3:0];
endmodule
