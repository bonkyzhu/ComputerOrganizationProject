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