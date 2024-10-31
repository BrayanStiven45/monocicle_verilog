module monocicle (
    input clk,
	 input sel,         // Selector para mostrar los 16 bits más o menos significativos del PC
    output [6:0] seg0, // Salida del primer display de 7 segmentos
    output [6:0] seg1, // Salida del segundo display de 7 segmentos
    output [6:0] seg2, // Salida del tercer display de 7 segmentos
    output [6:0] seg3 // Salida del cuarto display de 7 segmentos
);
	wire [31:0] pc;
	wire [31:0] suma;
	wire [31:0] next_pc;     
	wire [31:0] instruction;
	wire [6:0] opcode;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [24:0] immediate;
	wire AluaSrc;
	wire Ruwr;
	wire [2:0] immsrc;
	wire AlubSrc;
	wire [3:0] AluOp;
	wire [4:0] BrOp;
	wire DMWr;
	wire [2:0] DMCTrl;
	wire [1:0] RuDataWrSrc;
	wire [31:0] imm_gen32;
	wire [31:0] ru1;
	wire [31:0] ru2;
	wire [31:0] dataWR;
	wire [31:0] A;
	wire [31:0] B;
	wire NextPCSrc;
	wire [31:0] AluRes;
	wire [31:0] read_data;

    PC p(
        .clk(clk),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Instancia del sumador
    PCAdder adder(
        .pc_in(pc),          // Entrada del valor actual del PC
        .pc_out(suma)    // Salida del PC incrementado en 4
    );
	 
	 pc_display display_pc (
        .pc(pc),            // Pasamos el valor del PC al display
        .sel(sel),          // Pasamos el selector
        .seg_display0(seg0), // Conectamos las salidas a los displays
        .seg_display1(seg1),
        .seg_display2(seg2),
        .seg_display3(seg3)
    );

	 instruction_memory ins_mem(
			.pc(pc),
			.instruction(instruction)
	 );
	 
	 instruction_decoder insdec(
			.in(instruction),
			.opcode(opcode),
			.funct3(funct3),
			.funct7(funct7),
			.rs1(rs1),
			.rs2(rs2),
			.rd(rd),
			.immediate(immediate)
	 );
	 
	 Control_Unit con_unit(
			.opcode(opcode),
			.funct3(funct3),
			.funct7(funct7),
			.AluaSrc(AluaSrc),
			.Ruwr(Ruwr),
			.immsrc(immsrc),
			.AlubSrc(AlubSrc),
			.AluOp(AluOp),
			.BrOp(BrOp),
			.DMWr(DMWr),
			.DMCTrl(DMCTrl),
			.RuDataWrSrc(RuDataWrSrc)
	 );
	 
	 immediate_generator imm_gen(
			.immediate(immediate),
			.immsrc(immsrc),
			.out(imm_gen32)
	 );
	 
	 memory_register mem_reg(
			.clk(clk),              
			.regWrite(Ruwr),         
			.rs1(rs1),      
			.rs2(rs2),      
			.rd(rd),        
			.writeData(dataWR), 
			.readData1(ru1), 
			.readData2(ru2)
	 );
	 
	 mux_1 muxAluA(
			.in_0(ru1),
			.in_1(pc),
			.sel(AluaSrc),
			.out(A)
	 );
	 
	 mux_1 muxAluB(
			.in_0(ru2),
			.in_1(immediate),
			.sel(AlubSrc),
			.out(B)
	 );
	 
	 ALU alu(
			.A(A),
			.B(B),
			.ALUOp(AluOp),
			.ALURes(AluRes)
	 );
	 
	 Branch_Unit Branch_U(
			.RS1(ru1),
			.RS2(ru2),
			.BrOP(BrOp),
			.NextPCSrc(NextPCSrc)
	 );
	 
	 mux_1 muxBran(
			.in_0(suma),
			.in_1(AluRes),
			.sel(NextPCSrc),
			.out(next_pc)
	 );
	 
	 DataMemory_2 DataMem(
			.address(AluRes),
			.DataWr(ru2),
			.DMWr(DMWr),
			.DMCtrl(DMCTrl),
			.DataRd(read_data),
			.clk(clk)
	 );
	 
	 mux_2 muxWrite(
			.in_0(AluRes),
			.in_1(read_data),
			.in_2(suma),
			.sel(RuDataWrSrc),
			.out(dataWR)
	 );

endmodule
