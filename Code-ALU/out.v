`include "define.v"

module out(
  input wire clk,
  input wire output_cout0,
  input wire output_cout1,
  input wire output_cout2,
  input wire output_cout3,
  input wire output_cout4,
  input wire output_cout5,
  input wire output_cout6,
  input wire output_cout7,
  input wire[`WIDTH] output_d0,
  input wire[`WIDTH] output_d1,
  input wire[`WIDTH] output_d2,
  input wire[`WIDTH] output_d3,
  input wire[`WIDTH] output_d4,
  input wire[`WIDTH] output_d5,
  input wire[`WIDTH] output_d6,
  input wire[`WIDTH] output_d7,

  input wire[`SELECT_WIDTH] s,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(posedge clk) begin
    case (s)
      `ADD: begin
        d <= output_d0;
        cout <= output_cout0;
      end
      `SUB: begin
        d <= output_d1;
        cout <= output_cout1;
      end
      `OR: begin
        d <= output_d2;
        cout <= output_cout2;
      end
      `AND: begin
        d <= output_d3;
        cout <= output_cout3;
      end
      `ADC: begin
        d <= output_d4;
        cout <= output_cout4;
      end
      `SBB: begin
        d <= output_d5;
        cout <= output_cout5;
      end
      `NOT: begin
        d <= output_d6;
        cout <= output_cout6;
      end
      `PRINT: begin
        d <= output_d7;
        cout <= output_cout7;
      end
      default: begin
      end
    endcase
  end
endmodule