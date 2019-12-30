`include "define.v"

module isnot(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(*) begin
    d <= ~a;
    cout <= 0;
  end

endmodule