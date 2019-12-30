`include "define.v"

module isor(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(*) begin
    d <= a | w;
    cout <= 0;
  end

endmodule