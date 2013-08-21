`timescale 1ns / 1ns

module counter_tb;
  reg clk;
  reg reset;
  wire [31:0] count;

  Counter dub(.reset(reset), .clk(clk), .count(count));

  initial clk = 0;
  always begin
    #50;
    clk = ~clk;
  end

  initial begin
    #1 $display("HDL: Starting test at t=%0t", $time, " ns");

    reset = 1;

    @(posedge clk) begin
      reset = 0;
      $display("HDL: counter=0x%x at t=%0t", count, $time, " ns");
    end

    while (count < 5) begin
      @(posedge clk)
        $display("HDL: counter=0x%x at t=%0t", count, $time, " ns");
    end

    reset = 1;
    @(posedge clk) begin
      reset = 0;
      $display("HDL: counter=0x%x at t=%0t", count, $time, " ns");
    end

    #1 $display("HDL: Finished test at t=%0t", $time, " ns");
    $finish;
  end
endmodule
