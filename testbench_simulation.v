`timescale 1ns / 1ps

module testbench_simulation;

    reg clk;  // Cambiado de input a reg
    wire [31:0] pc_out;  // Cambiado a wire, ya que son salidas
    wire [31:0] ins_memory_out;
    wire [31:0] alures_1;
    wire [31:0] data_ram;
	 wire [31:0] out_rs1;
	 wire [31:0] out_rs2;
	 wire [2:0] dmctrl;
	 wire dmwr;
	 wire [31:0] registro;
	 wire [31:0] read_muestra;
	 wire [8:0] address_of_ram;
	 wire clk_ram;
	 wire ruwr;
	 wire [4:0] out_rd;
	 wire [1:0] rudatawrsrc;
	 wire next_pc;
	 wire [31:0] imm_32;
	 wire [3:0] aluop;

    monocicle uut(
        .clk(clk),
		  .clk50(0),
//        .sel(3'b0),
        .address_register(5'b1111),
        .pc_out(pc_out),
        .ins_memory_out(ins_memory_out),
        .alures_1(alures_1),
        .data_ram(data_ram),
		.out_rs1(out_rs1),
		.out_rs2(out_rs2),
		.dmctrl(dmctrl),
		.dmwr(dmwr),
		.registro(registro),
		.read_muestra(read_muestra),
		.address_of_ram(address_of_ram),
		.clk_ram(clk_ram),
		.ruwr_2(ruwr),
		.out_rd(out_rd),
		.rudatawrsrc(rudatawrsrc),
		.next_pcrc(next_pc),
		.imm_32(imm_32),
		.aluop(aluop)
    );

    initial begin
			
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $monitor("At time %0t:pc = %b, instruction = %b, AluRes = %b, imm_32 = %b, AluOp = %b, registro = %b, data_ram = %b",
                 $time,pc_out,ins_memory_out, alures_1, imm_32,aluop, registro ,data_ram);
        #500;
        $finish;
    end
    
endmodule
