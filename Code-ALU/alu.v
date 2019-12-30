`include "define.v"
`include "add.v"
`include "sub.v"
`include "or.v"
`include "and.v"
`include "adc.v"
`include "sbb.v"
`include "not.v"
`include "print.v"
`include "out.v"


module alu(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,
  input wire[`SELECT_WIDTH] s,

  output wire[`WIDTH] d,
  output wire cout
);

  wire[`WIDTH] output_d0, output_d1, output_d2, output_d3, output_d4, output_d5, output_d6, output_d7; 
  wire output_cout0, output_cout1, output_cout2, output_cout3, output_cout4, output_cout5, output_cout6, output_cout7;

  add add0(clk, a, w, cin, output_d0, output_cout0);
  sub sub0(clk, a, w, cin, output_d1, output_cout1);
  isor or1(clk, a, w, cin, output_d2, output_cout2);
  isand and1(clk, a, w, cin, output_d3, output_cout3);
  adc adc1(clk, a, w, cin, output_d4, output_cout4);
  sbb sbb1(clk, a, w, cin, output_d5, output_cout5);
  isnot not1(clk, a, w, cin, output_d6, output_cout6);
  print print1(clk, a, w, cin, output_d7, output_cout7);
  out out1(clk, 
          output_cout0, output_cout1, output_cout2, output_cout3, 
          output_cout4, output_cout5, output_cout6, output_cout7,
          output_d0, output_d1, output_d2, output_d3, 
          output_d4, output_d5, output_d6, output_d7, 
          s, d, cout);

endmodule // alu