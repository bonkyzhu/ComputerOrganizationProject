`include "define.v"
`include "alu.v"
`timescale 1ns/1ps

module alu_tb();

  reg     CLOCK_50;
  reg     rst;

  wire[`WIDTH] a;
  wire[`WIDTH] w;
  wire c_in;
  reg[`SELECT_WIDTH] s; 

  wire[`WIDTH] d;
  wire c_out;

  integer k = 3'b0; 

  assign a = 32'hfffffff0;
  assign w = 32'h000000f0;
  assign c_in = 1'b1;
       
  always @(posedge CLOCK_50) begin
    for (k=3'b0; k<=3'b111; k=k+3'b1)
      #50 s <= k;
  end
  
  initial begin

    $dumpfile("test.vcd");
    $dumpvars(0, alu_tb);

    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin
    #1000 $stop;
  end
       
  alu alu0(
    .clk(CLOCK_50),
    .a(a), .w(w), .cin(c_in),
    .s(s), .d(d), .cout(c_out)
  );
endmodule