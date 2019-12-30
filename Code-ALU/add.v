module add_1(
  input wire a, 
  input wire b, 
  input wire c, 

  output wire s, 
  output wire c_out 
  );

  assign s = a^b^c;
	assign c_out = (a&b)|(a&c)|(b&c);

endmodule

module add_2(
  input wire[1:0] a,
  input wire[1:0] b,
  input wire c_in,

  output wire[1:0] s,
  output wire c_out
);

  add_1 a0(a[0], b[0], c_in, s[0], c_tmp);
  add_1 a1(a[1], b[1], c_tmp, s[1], c_out);
endmodule

module add_4(
  input wire[3:0] a,
  input wire[3:0] b,
  input wire c_in,

  output wire[3:0] s,
  output wire c_out
);

  add_2 a0(a[1:0], b[1:0], c_in, s[1:0], c_tmp);
  add_2 a1(a[3:2], b[3:2], c_tmp, s[3:2], c_out);
endmodule

module add_8(
  input wire[7:0] a,
  input wire[7:0] b,
  input wire c_in,

  output wire[7:0] s,
  output wire c_out
);

  add_4 a0(a[3:0], b[3:0], c_in, s[3:0], c_tmp);
  add_4 a1(a[7:4], b[7:4], c_tmp, s[7:4], c_out);
endmodule

module add_16(
  input wire[15:0] a,
  input wire[15:0] b,
  input wire c_in,

  output wire[15:0] s,
  output wire c_out
);

  add_8 a0(a[7:0], b[7:0], c_in, s[7:0], c_tmp);
  add_8 a1(a[15:8], b[15:8], c_tmp, s[15:8], c_out);
endmodule

module add(
  input wire clk,

  input wire[31:0] a,
  input wire[31:0] b,
  input wire c_in,

  output wire[31:0] s,
  output wire c_out
);

  add_16 a0(a[15:0], b[15:0], 1'b0, s[15:0], c_tmp);
  add_16 a1(a[31:16], b[31:16], c_tmp, s[31:16], c_out);

endmodule