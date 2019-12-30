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