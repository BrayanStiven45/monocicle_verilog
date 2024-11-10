module instruction_memory (
    input [31:0] pc,               // PC (24 bits efectivos como dirección de memoria)
    output [31:0] instruction   // Instrucción de 32 bits
);

    reg [31:0] memory [0:511];

    // Inicialización de la memoria con instrucciones
    initial
	 begin
			 $readmemh("instructions.mem", memory);
			 // Se pone todas las instrucciones quemadas directamente 
			 // solo para el testbech en modelsim
//		  memory[0]  = 32'hfe010113;
//        memory[1]  = 32'h00112e23;
//        memory[2]  = 32'h00812c23;
//        memory[3]  = 32'h02010413;
//        memory[4]  = 32'h02d00793;
//        memory[5]  = 32'hfef42623;
//        memory[6]  = 32'h01700793;
//        memory[7]  = 32'hfef42423;
//        memory[8]  = 32'hfe842583;
//        memory[9]  = 32'hfec42503;
//        memory[10] = 32'h00000097;
//        memory[11] = 32'h024080e7;
//        memory[12] = 32'hfea42223;
//        memory[13] = 32'h00000793;
//        memory[14] = 32'h00078513;
//        memory[15] = 32'h01c12083;
//        memory[16] = 32'h01812403;
//        memory[17] = 32'h02010113;
//        memory[18] = 32'h00008067;
//        memory[19] = 32'hfe010113;
//        memory[20] = 32'h00112e23;
//        memory[21] = 32'h00812c23;
//        memory[22] = 32'h02010413;
//        memory[23] = 32'hfea42623;
//        memory[24] = 32'hfeb42423;
//        memory[25] = 32'hfec42703;
//        memory[26] = 32'hfe842783;
//        memory[27] = 32'h00f707b3;
//        memory[28] = 32'h00078513;
//        memory[29] = 32'h01c12083;
//        memory[30] = 32'h01812403;
//        memory[31] = 32'h02010113;
//        memory[32] = 32'h00008067;
		
	 end
		
	 assign instruction = (pc[23:2] < 512) ? memory[pc[23:2]] : 32'b0;

endmodule
