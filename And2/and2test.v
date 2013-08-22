module AND2TEST;

reg a_in, b_in;
wire real out;
wire real a, b;

AND2 bbb (a, b, out);

initial begin
  $dumpfile("and2test.vcd");
  $dumpvars(0, AND2TEST);
  $monitor ("%t: a = %f, b = %f, out = %f", $time, a, b, out);

      a_in = 0; b_in = 0;
  #10 a_in = 1;
  #10 a_in = 0; b_in = 1;
  #10 a_in = 1;
  #10 a_in = 0; b_in = 0;
  #10 $finish;
end

assign a = a_in;
assign b = b_in;

endmodule
