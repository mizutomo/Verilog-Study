module encode(DIN, DOUT);
input wire [7:0] DIN;
output wire [2:0] DOUT;

function [2:0] enc;
  input [7:0] a;
  case (a)
    128: enc = 7;
     64: enc = 6;
     32: enc = 5;
     16: enc = 4;
      8: enc = 3;
      4: enc = 2;
      2: enc = 1;
      1: enc = 0;
  endcase
endfunction

assign DOUT = enc(DIN);

endmodule

