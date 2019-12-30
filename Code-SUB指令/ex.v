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