/* --- Begin Copyright Block -----[ do not move or remove ]------ */
/*                                                                */
/* Copyright (c) 2009, Cadence Design Systems, Inc.               */
/* All rights reserved. This model library is intended for use    */
/* with products only from Cadence Design Systems, Inc.           */
/* The use or sharing of any models from this library or any of   */
/* its modified/extended form is strictly prohibited with any     */
/* non-Cadence products.                                          */
/*                                                                */
/* --- End Copyright Block -------------------------------------- */
`timescale 1ns/1ps
`define Nbits 12
`define M_TWO_PI 6.283185307179586
//`include "constants.vams"
//`include "disciplines.vams"

module top ();

   wreal AIN, AOUT, VDD, VSS;
   wire [`Nbits-1:0] DOUT;
   wrealADC I_ACD (DOUT,AIN,CK,VDD,VSS);
   wrealDAC I_DAC (AOUT,DOUT,CK,VDD,VSS);

   real r_ain, r_vdd, r_vss;                 // input voltage
   real Freq=600e+3,Phase=0;   // sinusoid params
   reg 	clk;

   initial begin
      $dumpfile("adc_dac.vcd");
      $dumpvars();
   end

   initial begin
      clk = 0;
      r_vdd = 3.3;
      r_vss = 0.0;
      r_ain=0.1;         // out=0.1 for DC op point
      repeat (10) #10 r_ain=r_ain+0.348;  // increasing ramp
      repeat (10) #10 r_ain=r_ain-0.339;   // falling ramp
      #30 while ($realtime*1e-9 < 6e-6) begin
                                // generate ramped sine input
	 #2 Freq=Freq*1.0007;        // gradual freq increase
	 Phase=Phase+2e-9*Freq;        // integrate freq to get phase
	 if (Phase>1) Phase=Phase-1; // wraparound per cycle
	 r_ain=1.8*(1+$sin(`M_TWO_PI*Phase));
         // sinusoidal waveform shape
      end
      #200 $finish;                 // done with test
   end

   always #2 clk = ~clk;

   assign AIN = r_ain;
   assign CK = clk;
   assign VDD = r_vdd;
   assign VSS = r_vss;

endmodule


module wrealADC (DOUT,AIN,CK,VDD,VSS);
   output [`Nbits-1:0] DOUT;
   input 	       CK;
   input 	       AIN,VDD,VSS;
   wreal               AIN,VDD,VSS;
   parameter 	       Td=1e-9;
   real 	       PerBit, VL, VH;
   integer 	       Dval;
   always begin	         // get dV per bit wrt supply
      PerBit = (VDD-VSS) / ((1<<`Nbits)-1);
      VL = VSS;
      VH = VDD;
      @(VDD,VSS);	         // update if supply changes
   end
   always @(CK) begin
      if (AIN<VL) Dval = 'b0;
      else if (AIN>VH) Dval = {`Nbits{1'b1}};
      else Dval = (AIN-VSS)/PerBit;
   end
   assign #(Td/1e-9) DOUT = Dval;
endmodule // wrealADC

module wrealDAC (AOUT,DIN,CK,VDD,VSS);
   input [`Nbits-1:0] DIN;
   input 	      CK,VDD,VSS;
   output 	      AOUT;
   wreal              AOUT,VDD,VSS;
   parameter 	      real Td=1e-9;
   real 	      PerBit,Aval;
   always begin 	   // get dV per bit wrt supply
      PerBit = (VDD-VSS) / ((1<<`Nbits)-1);
      @(VDD,VSS);	   // update if supply changes
   end
   always @(CK)  Aval <= VSS + PerBit*DIN;
   assign  #(Td/1e-9) AOUT = Aval;
endmodule // wrealDAC

