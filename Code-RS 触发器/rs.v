`include "nand.v"

module rs(
  input wire clk,

  input wire r,
  input wire s,

  output wire q,
  output wire qb
);

  isnand sd1(s, clk, sd);
  isnand rd1(r, clk, rd);
  isnand g1(sd, q, qb);
  isnand g2(rd, qb, q);

endmodule