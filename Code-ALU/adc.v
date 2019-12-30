module adc_1(
  input wire a, 
  input wire b, 
  input wire c, 

  output wire s, 
  output wire c_out //čżä˝
  );

  assign s = a^b^c;
	assign c_out = (a&b)|(a&c)|(b&c);

endmodule

module adc_2(
  input wire[1:0] a,
  input wire[1:0] b,
  input wire c_in,

  output wire[1:0] s,
  output wire c_out
);

  adc_1 a0(a[0], b[0], c_in, s[0], c_tmp);
  adc_1 a1(a[1], b[1], c_tmp, s[1], c_out);
endmodule

module adc_4(
  input wire[3:0] a,
  input wire[3:0] b,
  input wire c_in,

  output wire[3:0] s,
  output wire c_out
);

  adc_2 a0(a[1:0], b[1:0], c_in, s[1:0], c_tmp);
  adc_2 a1(a[3:2], b[3:2], c_tmp, s[3:2], c_out);
endmodule

module adc_8(
  input wire[7:0] a,
  input wire[7:0] b,
  input wire c_in,

  output wire[7:0] s,
  output wire c_out
);

  adc_4 a0(a[3:0], b[3:0], c_in, s[3:0], c_tmp);
  adc_4 a1(a[7:4], b[7:4], c_tmp, s[7:4], c_out);
endmodule

module adc_16(
  input wire[15:0] a,
  input wire[15:0] b,
  input wire c_in,

  output wire[15:0] s,
  output wire c_out
);

  adc_8 a0(a[7:0], b[7:0], c_in, s[7:0], c_tmp);
  adc_8 a1(a[15:8], b[15:8], c_tmp, s[15:8], c_out);
endmodule

module adc(
  input wire clk,

  input wire[31:0] a,
  input wire[31:0] b,
  input wire c_in,

  output wire[31:0] s,
  output wire c_out
);

  adc_16 a0(a[15:0], b[15:0], c_in, s[15:0], c_tmp);
  adc_16 a1(a[31:16], b[31:16], c_tmp, s[31:16], c_out);

endmodule