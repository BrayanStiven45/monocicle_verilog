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

    monocicle uut(
        .clk(clk),
        .sel(3'b0),
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
		  .read_muestra(read_muestra)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $monitor("At time %0t: pc = %b, instruction_memory = %b,read_data = %b, AluRes = %b, data_ram = %b",
                 $time, pc_out, ins_memory_out,read_muestra, alures_1, data_ram);
        #500;  // Run simulation for 500 time units
        $finish;
    end
    
endmodule
