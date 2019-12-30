./Code-ALU/adc.v
```verilog
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
```
./Code-ALU/add.v
```verilog
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
```
./Code-ALU/alu.v
```verilog
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
```
./Code-ALU/alu_tb.v
```verilog
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
```
./Code-ALU/and.v
```verilog
`include "define.v"

module isand(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(*) begin
    d <= a & w;
    cout <= 0;
  end

endmodule
```
./Code-ALU/define.v
```verilog
//指令
`define ADD 3'b000
`define SUB 3'b001
`define OR 3'b010
`define AND 3'b011
`define ADC 3'b100
`define SBB 3'b101
`define NOT 3'b110
`define PRINT 3'b111

//参数
`define WIDTH 31:0
`define SELECT_WIDTH 2:0
`define RstEnable 1'b1	//复位有效
`define RstDisable 1'b0	//复位无效	
```
./Code-ALU/not.v
```verilog
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
```
./Code-ALU/or.v
```verilog
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
```
./Code-ALU/out.v
```verilog
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
```
./Code-ALU/print.v
```verilog
`include "define.v"

module print(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(*) begin
    d <= a;
    cout <= 0;
  end

endmodule
```
./Code-ALU/sbb.v
```verilog
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
```
./Code-ALU/sub.v
```verilog
`include "define.v"

module sub(
  input wire clk,

  input wire[`WIDTH] a,
  input wire[`WIDTH] w,
  input wire cin,

  output reg[`WIDTH] d,
  output reg cout
);

  always @(*) begin
    d <= a - w;
    cout <= 0;
  end

endmodule
```
./Code-RS 触发器/nand.v
```verilog
module isnand(
  input wire a,
  input wire b,

  output reg c
);

  always @(*) begin
    c <= ~(a | b);
  end

endmodule
```
./Code-RS 触发器/rs.v
```verilog
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
```
./Code-RS 触发器/rs_tb.v
```verilog
`timescale 1ns/1ps
`include "rs.v"

module rs_tb();

  reg     CLOCK_50;

  reg s;
  reg r;
  wire q;
  wire qb;

  integer high = 1'b1; 
  integer low = 1'b0; 
       
  initial @(posedge CLOCK_50) begin
    #10 s <= low; r <= high; 
    #10 s <= low; r <= low; 
    #10 s <= high; r <= low; 
    #10 s <= high; r <= high; 

    #10 s <= low; r <= high; 
    #10 s <= low; r <= low; 
    #10 s <= high; r <= low; 
    #10 s <= high; r <= high; 

    #10 s <= low; r <= high; 
    #10 s <= high; r <= high; 

    #10 s <= low; r <= low; 
    #10 s <= low; r <= low; 
  end
  
  initial begin

    $dumpfile("test.vcd");
    $dumpvars(0, rs_tb);

    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin
    #130 $stop;
  end
       
  rs rs0(
    CLOCK_50, s, r, q, qb
  );
endmodule
```
./Code-SUB指令/defines.v
```verilog
//全局
`define RstEnable 1'b1	//复位有效
`define RstDisable 1'b0	//复位无效	
`define ZeroWord 32'h00000000	//32位的数值0
`define WriteEnable 1'b1	//使能写
`define WriteDisable 1'b0	//禁止写
`define ReadEnable 1'b1	//使能读
`define ReadDisable 1'b0	//禁止读
`define AluOpBus 7:0	//译码输出运算子类型的长度
`define AluSelBus 2:0	//译码输出运算类型的长度	
`define InstValid 1'b0	//指令有效
`define InstInvalid 1'b1	//指令无效
`define Stop 1'b1	
`define NoStop 1'b0
`define InDelaySlot 1'b1
`define NotInDelaySlot 1'b0
`define Branch 1'b1
`define NotBranch 1'b0
`define InterruptAssert 1'b1
`define InterruptNotAssert 1'b0
`define TrapAssert 1'b1
`define TrapNotAssert 1'b0
`define True_v 1'b1	//逻辑"真"
`define False_v 1'b0	//逻辑"假"
`define ChipEnable 1'b1	//芯片使能
`define ChipDisable 1'b0	//芯片禁止


//指令
//`define EXE_ORI 6'b001101	//指令 ori 的指令码
`define EXE_SUBU  6'b100011
`define EXE_NOP 6'b000000	
`define EXE_SPECIAL_INST 6'b000000


//AluOp
// `define EXE_OR_OP   8'b00100101
// `define EXE_ORI_OP  8'b01011010
`define EXE_SUBU_OP  8'b00010001


`define EXE_NOP_OP    8'b00000000

//AluSel
// `define EXE_RES_LOGIC 3'b001
`define EXE_RES_ARITHMETIC 3'b100
`define EXE_RES_NOP 3'b000


//指令存储器inst_rom
`define InstAddrBus 31:0	//ROM的地址总线宽度
`define InstBus 31:0	//ROM的数据总线宽度
`define InstMemNum 131071	//ROM实际大小
`define InstMemNumLog2 17	//ROM实际使用的地址总线


//通用寄存器regfile
`define RegAddrBus 4:0	//寄存器地址线宽度
`define RegBus 31:0	//寄存器数据宽度
`define RegWidth 32	//寄存器的宽度
`define DoubleRegWidth 64	
`define DoubleRegBus 63:0
`define RegNum 32
`define RegNumLog2 5	//寻址寄存器位数
`define NOPRegAddr 5'b00000
```
./Code-SUB指令/ex.v
```verilog
`include "defines.v"

module ex(

	input wire										rst,
	
	//送到执行阶段的信息
	input wire[`AluOpBus]         aluop_i,
	input wire[`AluSelBus]        alusel_i,
	input wire[`RegBus]           reg1_i,
	input wire[`RegBus]           reg2_i,
	input wire[`RegAddrBus]       wd_i,
	input wire                    wreg_i,

	
	output reg[`RegAddrBus]       wd_o,
	output reg                    wreg_o,
	output reg[`RegBus]						wdata_o
	
);

  //保存逻辑运算的结果
  reg[`RegBus] arithmeticout;

  //依据 aluop_i 指示的运算子类型进行运算(这里只实现了SUBU)
  always @ (*) begin
    if(rst == `RstEnable) begin
      arithmeticout <= `ZeroWord;
    end else begin
      case (aluop_i)
        `EXE_SUBU_OP:	begin
          //进行减法运算
          arithmeticout <= reg1_i - reg2_i;
        end
        default:	begin
          arithmeticout <= `ZeroWord;
        end
      endcase
    end    //if
  end      //always

  //依据 alusel_i，选择一个运算结果作为最终结果（这里只有算术运算）
  always @ (*) begin
    wd_o <= wd_i;	 	 	
    wreg_o <= wreg_i;
    case ( alusel_i ) 
      `EXE_RES_ARITHMETIC:	begin
        //把逻辑运算结果输出
        wdata_o <= arithmeticout;
      end
      default:	begin
        wdata_o <= `ZeroWord;
      end
    endcase
  end	
endmodule
```
./Code-SUB指令/ex_mem.v
```verilog
`include "defines.v"

module ex_mem(

	input	wire										clk,
	input wire										rst,
	
	
	//来自执行阶段的信息	
	input wire[`RegAddrBus]       ex_wd,
	input wire                    ex_wreg,
	input wire[`RegBus]					 ex_wdata, 	
	
	//送到访存阶段的信息
	output reg[`RegAddrBus]      mem_wd,
	output reg                   mem_wreg,
	output reg[`RegBus]					 mem_wdata
	
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			mem_wd <= `NOPRegAddr;
			mem_wreg <= `WriteDisable;
		  mem_wdata <= `ZeroWord;	
		end else begin
			mem_wd <= ex_wd;
			mem_wreg <= ex_wreg;
			mem_wdata <= ex_wdata;			
		end    //if
	end      //always
			

endmodule
```
./Code-SUB指令/id.v
```verilog
`include "defines.v"

module id(

	input wire										rst,
	input wire[`InstAddrBus]			pc_i,
	input wire[`InstBus]          inst_i,

	input wire[`RegBus]           reg1_data_i,
	input wire[`RegBus]           reg2_data_i,

	//送到regfile的信息
	output reg                    reg1_read_o,
	output reg                    reg2_read_o,     
	output reg[`RegAddrBus]       reg1_addr_o,
	output reg[`RegAddrBus]       reg2_addr_o, 	      
	
	//送到执行阶段的信息
	output reg[`AluOpBus]         aluop_o,
	output reg[`AluSelBus]        alusel_o,
	output reg[`RegBus]           reg1_o,
	output reg[`RegBus]           reg2_o,
	output reg[`RegAddrBus]       wd_o,
	output reg                    wreg_o
);

  //R型： 31~26:  opcode，和 function 一起决定指令
  //     25~21:   rs，源寄存器1
  //     20~16:   rt，源寄存器2
  //     15~11:   rd，目的寄存器
  //     10~6 :   sa，移位操作中指定移位长度（这里没用）
  //     5~0  :   function，（比如SUB和SUBU的opcode相同，func不同）
  wire[5:0] op = inst_i[31:26];
  wire[4:0] op2 = inst_i[10:6];
  wire[5:0] op3 = inst_i[5:0];
  wire[4:0] op4 = inst_i[20:16];

  //保存立即数
  reg[`RegBus]	imm;

  //指示指令是否有效 
  reg instvalid;

  //进行指令的译码
  always @ (*) begin	
    if (rst == `RstEnable) begin
      //置位操作
      aluop_o <= `EXE_NOP_OP;
      alusel_o <= `EXE_RES_NOP;
      wd_o <= `NOPRegAddr;
      wreg_o <= `WriteDisable;
      instvalid <= `InstValid;
      reg1_read_o <= 1'b0;
      reg2_read_o <= 1'b0;
      reg1_addr_o <= `NOPRegAddr;
      reg2_addr_o <= `NOPRegAddr;
      imm <= 32'h0;			
    end else begin
      //相当于初始化
      aluop_o <= `EXE_NOP_OP;
      alusel_o <= `EXE_RES_NOP;
      wd_o <= inst_i[15:11];
      wreg_o <= `WriteDisable;
      instvalid <= `InstInvalid;	   
      reg1_read_o <= 1'b0;
      reg2_read_o <= 1'b0;
      reg1_addr_o <= inst_i[25:21];
      reg2_addr_o <= inst_i[20:16];		
      imm <= `ZeroWord;			
      case (op3)
        `EXE_SUBU: begin	//根据 op 的值判斯是否是 ori 指令
          //需要写入目的寄存器，所以为WriteEnable
          wreg_o <= `WriteEnable;		
          //子类型为SUBU，运算类型为算术运算
          aluop_o <= `EXE_SUBU_OP;
          alusel_o <= `EXE_RES_ARITHMETIC;
          //需要从端口1和2读，所以为1
          reg1_read_o <= 1'b1;	
          reg2_read_o <= 1'b1;
          instvalid <= `InstValid;	   
        end 							 
        default:	begin
        end
      endcase		  //case op			
    end       //if
  end         //always

  //确定源操作数1，reg1_read_o 用于判断比特串是寄存器地址还是立即数
  always @ (*) begin
    if(rst == `RstEnable) begin
      reg1_o <= `ZeroWord;
    end else if(reg1_read_o == 1'b1) begin
      reg1_o <= reg1_data_i;
    end else if(reg1_read_o == 1'b0) begin
      reg1_o <= imm;
    end else begin
      reg1_o <= `ZeroWord;
    end
  end

  //确定源操作数2
  always @ (*) begin
    if(rst == `RstEnable) begin
      reg2_o <= `ZeroWord;
    end else if(reg2_read_o == 1'b1) begin
      reg2_o <= reg2_data_i;
    end else if(reg2_read_o == 1'b0) begin
      reg2_o <= imm;
    end else begin
      reg2_o <= `ZeroWord;
    end
  end

endmodule
```
./Code-SUB指令/id_ex.v
```verilog
`include "defines.v"

module id_ex(

	input	wire										clk,
	input wire										rst,

	
	//从译码阶段传递的信息
	input wire[`AluOpBus]         id_aluop,
	input wire[`AluSelBus]        id_alusel,
	input wire[`RegBus]           id_reg1,
	input wire[`RegBus]           id_reg2,
	input wire[`RegAddrBus]       id_wd,
	input wire                    id_wreg,	
	
	//传递到执行阶段的信息
	output reg[`AluOpBus]         ex_aluop,
	output reg[`AluSelBus]        ex_alusel,
	output reg[`RegBus]           ex_reg1,
	output reg[`RegBus]           ex_reg2,
	output reg[`RegAddrBus]       ex_wd,
	output reg                    ex_wreg
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ex_aluop <= `EXE_NOP_OP;
			ex_alusel <= `EXE_RES_NOP;
			ex_reg1 <= `ZeroWord;
			ex_reg2 <= `ZeroWord;
			ex_wd <= `NOPRegAddr;
			ex_wreg <= `WriteDisable;
		end else begin		
			ex_aluop <= id_aluop;
			ex_alusel <= id_alusel;
			ex_reg1 <= id_reg1;
			ex_reg2 <= id_reg2;
			ex_wd <= id_wd;
			ex_wreg <= id_wreg;		
		end
	end
	
endmodule
```
./Code-SUB指令/if_id.v
```verilog
`include "defines.v"

module if_id(

	input	wire										clk,
	input wire										rst,
	

	input wire[`InstAddrBus]			if_pc,
	input wire[`InstBus]          if_inst,
	output reg[`InstAddrBus]      id_pc,
	output reg[`InstBus]          id_inst  
	
);

  always @ (posedge clk) begin
    if (rst == `RstEnable) begin
      id_pc <= `ZeroWord;	//复位的时候pc为0
      id_inst <= `ZeroWord;	//复位的时候指令也为0,实际就是空指令
    end else begin
      id_pc <= if_pc;	//其余时刻向下传递取指阶段的值
      id_inst <= if_inst;
    end
  end
endmodule
```
./Code-SUB指令/inst_rom.v
```verilog
`include "defines.v"

module inst_rom(

//	input	wire										clk,
	input wire                    ce,
	input wire[`InstAddrBus]			addr,
	output reg[`InstBus]					inst
	
);

	reg[`InstBus]  inst_mem[0:`InstMemNum-1];

	initial $readmemh ( "inst_rom.data", inst_mem );

	always @ (*) begin
		if (ce == `ChipDisable) begin
			inst <= `ZeroWord;
	  end else begin
		  inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
		end
	end

endmodule
```
./Code-SUB指令/mem.v
```verilog
`include "defines.v"

module mem(

	input wire										rst,
	
	//来自执行阶段的信息	
	input wire[`RegAddrBus]       wd_i,
	input wire                    wreg_i,
	input wire[`RegBus]					  wdata_i,
	
	//送到回写阶段的信息
	output reg[`RegAddrBus]      wd_o,
	output reg                   wreg_o,
	output reg[`RegBus]					 wdata_o
	
);

	
	always @ (*) begin
		if(rst == `RstEnable) begin
			wd_o <= `NOPRegAddr;
			wreg_o <= `WriteDisable;
		  wdata_o <= `ZeroWord;
		end else begin
		  wd_o <= wd_i;
			wreg_o <= wreg_i;
			wdata_o <= wdata_i;
		end    //if
	end      //always
			

endmodule
```
./Code-SUB指令/mem_wb.v
```verilog
`include "defines.v"

module mem_wb(

	input	wire										clk,
	input wire										rst,
	

	//来自访存阶段的信息	
	input wire[`RegAddrBus]       mem_wd,
	input wire                    mem_wreg,
	input wire[`RegBus]					 mem_wdata,

	//送到回写阶段的信息
	output reg[`RegAddrBus]      wb_wd,
	output reg                   wb_wreg,
	output reg[`RegBus]					 wb_wdata	       
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;	
		end else begin
			wb_wd <= mem_wd;
			wb_wreg <= mem_wreg;
			wb_wdata <= mem_wdata;
		end    //if
	end      //always
			

endmodule
```
./Code-SUB指令/openmips.v
```verilog
`include "defines.v"
`include "pc_reg.v"
`include "if_id.v"
`include "id.v"
`include "id_ex.v"
`include "ex.v"
`include "ex_mem.v"
`include "mem.v"
`include "mem_wb.v"
`include "reg_file.v"

module openmips(

	input	wire										clk,
	input wire										rst,
	
 
	input wire[`RegBus]           rom_data_i,
	output wire[`RegBus]           rom_addr_o,
	output wire                    rom_ce_o
	
);

	wire[`InstAddrBus] pc;
	wire[`InstAddrBus] id_pc_i;
	wire[`InstBus] id_inst_i;
	
	//连接译码阶段ID模块的输出与ID/EX模块的输入
	wire[`AluOpBus] id_aluop_o;
	wire[`AluSelBus] id_alusel_o;
	wire[`RegBus] id_reg1_o;
	wire[`RegBus] id_reg2_o;
	wire id_wreg_o;
	wire[`RegAddrBus] id_wd_o;
	
	//连接ID/EX模块的输出与执行阶段EX模块的输入
	wire[`AluOpBus] ex_aluop_i;
	wire[`AluSelBus] ex_alusel_i;
	wire[`RegBus] ex_reg1_i;
	wire[`RegBus] ex_reg2_i;
	wire ex_wreg_i;
	wire[`RegAddrBus] ex_wd_i;
	
	//连接执行阶段EX模块的输出与EX/MEM模块的输入
	wire ex_wreg_o;
	wire[`RegAddrBus] ex_wd_o;
	wire[`RegBus] ex_wdata_o;

	//连接EX/MEM模块的输出与访存阶段MEM模块的输入
	wire mem_wreg_i;
	wire[`RegAddrBus] mem_wd_i;
	wire[`RegBus] mem_wdata_i;

	//连接访存阶段MEM模块的输出与MEM/WB模块的输入
	wire mem_wreg_o;
	wire[`RegAddrBus] mem_wd_o;
	wire[`RegBus] mem_wdata_o;
	
	//连接MEM/WB模块的输出与回写阶段的输入	
	wire wb_wreg_i;
	wire[`RegAddrBus] wb_wd_i;
	wire[`RegBus] wb_wdata_i;
	
	//连接译码阶段ID模块与通用寄存器Regfile模块
  wire reg1_read;
  wire reg2_read;
  wire[`RegBus] reg1_data;
  wire[`RegBus] reg2_data;
  wire[`RegAddrBus] reg1_addr;
  wire[`RegAddrBus] reg2_addr;
  
  //pc_reg例化
	pc_reg pc_reg0(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.ce(rom_ce_o)	
			
	);
	
  assign rom_addr_o = pc;

  //IF/ID模块例化
	if_id if_id0(
		.clk(clk),
		.rst(rst),
		.if_pc(pc),
		.if_inst(rom_data_i),
		.id_pc(id_pc_i),
		.id_inst(id_inst_i)      	
	);
	
	//译码阶段ID模块
	id id0(
		.rst(rst),
		.pc_i(id_pc_i),
		.inst_i(id_inst_i),

		.reg1_data_i(reg1_data),
		.reg2_data_i(reg2_data),

		//送到regfile的信息
		.reg1_read_o(reg1_read),
		.reg2_read_o(reg2_read), 	  

		.reg1_addr_o(reg1_addr),
		.reg2_addr_o(reg2_addr), 
	  
		//送到ID/EX模块的信息
		.aluop_o(id_aluop_o),
		.alusel_o(id_alusel_o),
		.reg1_o(id_reg1_o),
		.reg2_o(id_reg2_o),
		.wd_o(id_wd_o),
		.wreg_o(id_wreg_o)
	);

  //通用寄存器Regfile例化
	regfile regfile1(
		.clk (clk),
		.rst (rst),
		.we	(wb_wreg_i),
		.waddr (wb_wd_i),
		.wdata (wb_wdata_i),
		.re1 (reg1_read),
		.raddr1 (reg1_addr),
		.rdata1 (reg1_data),
		.re2 (reg2_read),
		.raddr2 (reg2_addr),
		.rdata2 (reg2_data)
	);

	//ID/EX模块
	id_ex id_ex0(
		.clk(clk),
		.rst(rst),
		
		//从译码阶段ID模块传递的信息
		.id_aluop(id_aluop_o),
		.id_alusel(id_alusel_o),
		.id_reg1(id_reg1_o),
		.id_reg2(id_reg2_o),
		.id_wd(id_wd_o),
		.id_wreg(id_wreg_o),
	
		//传递到执行阶段EX模块的信息
		.ex_aluop(ex_aluop_i),
		.ex_alusel(ex_alusel_i),
		.ex_reg1(ex_reg1_i),
		.ex_reg2(ex_reg2_i),
		.ex_wd(ex_wd_i),
		.ex_wreg(ex_wreg_i)
	);		
	
	//EX模块
	ex ex0(
		.rst(rst),
	
		//送到执行阶段EX模块的信息
		.aluop_i(ex_aluop_i),
		.alusel_i(ex_alusel_i),
		.reg1_i(ex_reg1_i),
		.reg2_i(ex_reg2_i),
		.wd_i(ex_wd_i),
		.wreg_i(ex_wreg_i),
	  
	  //EX模块的输出到EX/MEM模块信息
		.wd_o(ex_wd_o),
		.wreg_o(ex_wreg_o),
		.wdata_o(ex_wdata_o)
		
	);

  //EX/MEM模块
  ex_mem ex_mem0(
		.clk(clk),
		.rst(rst),
	  
		//来自执行阶段EX模块的信息	
		.ex_wd(ex_wd_o),
		.ex_wreg(ex_wreg_o),
		.ex_wdata(ex_wdata_o),
	

		//送到访存阶段MEM模块的信息
		.mem_wd(mem_wd_i),
		.mem_wreg(mem_wreg_i),
		.mem_wdata(mem_wdata_i)

						       	
	);
	
  //MEM模块例化
	mem mem0(
		.rst(rst),
	
		//来自EX/MEM模块的信息	
		.wd_i(mem_wd_i),
		.wreg_i(mem_wreg_i),
		.wdata_i(mem_wdata_i),
	  
		//送到MEM/WB模块的信息
		.wd_o(mem_wd_o),
		.wreg_o(mem_wreg_o),
		.wdata_o(mem_wdata_o)
	);

  //MEM/WB模块
	mem_wb mem_wb0(
		.clk(clk),
		.rst(rst),

		//来自访存阶段MEM模块的信息	
		.mem_wd(mem_wd_o),
		.mem_wreg(mem_wreg_o),
		.mem_wdata(mem_wdata_o),
	
		//送到回写阶段的信息
		.wb_wd(wb_wd_i),
		.wb_wreg(wb_wreg_i),
		.wb_wdata(wb_wdata_i)
									       	
	);

endmodule
```
./Code-SUB指令/openmips_min_sopc_tb.v
```verilog
`include "defines.v"
`include "openmips_mini_sopc.v"
`timescale 1ns/1ps

module openmips_min_sopc_tb();

  reg     CLOCK_50;
  reg     rst;
  
       
  initial begin

    $dumpfile("test.vcd");
    $dumpvars(0, openmips_min_sopc_tb);

    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin

    rst = `RstEnable;
    #195 rst= `RstDisable;
    #1000 $stop;
  end
       
  openmips_min_sopc openmips_min_sopc0(
		.clk(CLOCK_50),
		.rst(rst)	
	);

endmodule
```
./Code-SUB指令/openmips_mini_sopc.v
```verilog
`include "defines.v"
`include "openmips.v"
`include "inst_rom.v"

module openmips_min_sopc(

	input	wire										clk,
	input wire										rst
	
);

  //连接指令存储器
  wire[`InstAddrBus] inst_addr;
  wire[`InstBus] inst;
  wire rom_ce;
 

 openmips openmips0(
		.clk(clk),
		.rst(rst),
	
		.rom_addr_o(inst_addr),
		.rom_data_i(inst),
		.rom_ce_o(rom_ce)
	);
	
	inst_rom inst_rom0(
		.addr(inst_addr),
		.inst(inst),
		.ce(rom_ce)	
	);


endmodule
```
./Code-SUB指令/pc_reg.v
```verilog
`include "defines.v"

module pc_reg(

	input	wire										clk,
	input wire										rst,
	
	output reg[`InstAddrBus]			pc,
	output reg                    ce
	
);

  always @ (posedge clk) begin
    if (ce == `ChipDisable) begin
      pc <= 32'h00000000;
    end else begin	
      pc <= pc + 4'h4;
    end
  end

  always @ (posedge clk) begin
    if (rst == `RstEnable) begin
      ce <= `ChipDisable;
    end else begin
      ce <= `ChipEnable;
    end
  end
endmodule
```
./Code-SUB指令/reg_file.v
```verilog
`include "defines.v"

module regfile(

	input	wire										clk,
	input wire										rst,
	
	//写端口
	input wire										we,
	input wire[`RegAddrBus]				waddr,
	input wire[`RegBus]						wdata,
	
	//读端口1
	input wire										re1,
	input wire[`RegAddrBus]			  raddr1,
	output reg[`RegBus]           rdata1,
	
	//读端口2
	input wire										re2,
	input wire[`RegAddrBus]			  raddr2,
	output reg[`RegBus]           rdata2
	
);

	reg[`RegBus]  regs[0:`RegNum-1];

  always @ (posedge clk) begin
    regs[1] = 32'h11111111;
    regs[2] = 32'h10001000;
    regs[4] = 32'h00100010;
    regs[6] = 32'h01001000;
    regs[8] = 32'h11101110;
    regs[10] = 32'h10101010;
    regs[12] = 32'h01101110;
    regs[14] = 32'h11000110;
    regs[16] = 32'h10100000;
    regs[18] = 32'h00000fff;
    regs[20] = 32'h0fffffff;
  end

	always @ (posedge clk) begin
		if (rst == `RstDisable) begin
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	always @ (*) begin
		if(rst == `RstEnable) begin
			  rdata1 <= `ZeroWord;
	  end else if(raddr1 == `RegNumLog2'h0) begin
	  		rdata1 <= `ZeroWord;
	  end else if((raddr1 == waddr) && (we == `WriteEnable) 
	  	            && (re1 == `ReadEnable)) begin
	  	  rdata1 <= wdata;
	  end else if(re1 == `ReadEnable) begin
	      rdata1 <= regs[raddr1];
	  end else begin
	      rdata1 <= `ZeroWord;
	  end
	end

	always @ (*) begin
		if(rst == `RstEnable) begin
			  rdata2 <= `ZeroWord;
	  end else if(raddr2 == `RegNumLog2'h0) begin
	  		rdata2 <= `ZeroWord;
	  end else if((raddr2 == waddr) && (we == `WriteEnable) 
	  	            && (re2 == `ReadEnable)) begin
	  	  rdata2 <= wdata;
	  end else if(re2 == `ReadEnable) begin
	      rdata2 <= regs[raddr2];
	  end else begin
	      rdata2 <= `ZeroWord;
	  end
	end

endmodule
```
