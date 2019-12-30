`include "define.v"

module sbb(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(*) begin
    d <= a - w - cin;
    cout <= 0;
  end

endmodule