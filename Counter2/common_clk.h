parameter CYCLE = 100;
parameter HALF_CYCLE = 50;
reg CLK;

always begin
              CLK = 1'b1;
  #HALF_CYCLE CLK = 1'b0;
  #HALF_CYCLE;
end
