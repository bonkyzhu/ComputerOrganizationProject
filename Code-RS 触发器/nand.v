module isnand(
  input wire a,
  input wire b,

  output reg c
);

  always @(*) begin
    c <= ~(a | b);
  end

endmodule