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
		// memory[0] = 32'hfe010113;
        // memory[1] = 32'h00112e23;
        // memory[2] = 32'h00812c23;
        // memory[3] = 32'h02010413;
        // memory[4] = 32'h000057b7;
        // memory[5] = 32'h00078793;
        // memory[6] = 32'hfef42623;
        // memory[7] = 32'h00a00793;
        // memory[8] = 32'hfef42423;
        // memory[9] = 32'hfe842583;
        // memory[10] = 32'hfec42503;
        // memory[11] = 32'h00000097;
        // memory[12] = 32'h030080e7;
        // memory[13] = 32'h00050713;
        // memory[14] = 32'h00058793;
        // memory[15] = 32'hfee42023;
        // memory[16] = 32'hfef42223;
        // memory[17] = 32'h00000793;
        // memory[18] = 32'h00078513;
        // memory[19] = 32'h01c12083;
        // memory[20] = 32'h01812403;
        // memory[21] = 32'h02010113;
        // memory[22] = 32'h00008067;
        // memory[23] = 32'hfc010113;
        // memory[24] = 32'h02112e23;
        // memory[25] = 32'h02812c23;
        // memory[26] = 32'h03212a23;
        // memory[27] = 32'h03312823;
        // memory[28] = 32'h04010413;
        // memory[29] = 32'hfca42623;
        // memory[30] = 32'hfcb42423;
        // memory[31] = 32'hfc842783;
        // memory[32] = 32'h00079863;
        // memory[33] = 32'hfc042c23;
        // memory[34] = 32'hfc042e23;
        // memory[35] = 32'h0940006f;
        // memory[36] = 32'hfe042623;
        // memory[37] = 32'hfe042023;
        // memory[38] = 32'hfe0405a3;
        // memory[39] = 32'hfcc42703;
        // memory[40] = 32'hfc842783;
        // memory[41] = 32'h40f707b3;
        // memory[42] = 32'hfef42223;
        // memory[43] = 32'h0340006f;
        // memory[44] = 32'hfe442783;
        // memory[45] = 32'h0207c263;
        // memory[46] = 32'hfec42783;
        // memory[47] = 32'h00178793;
        // memory[48] = 32'hfef42623;
        // memory[49] = 32'hfe442703;
        // memory[50] = 32'hfc842783;
        // memory[51] = 32'h40f707b3;
        // memory[52] = 32'hfef42223;
        // memory[53] = 32'h00c0006f;
        // memory[54] = 32'h00100793;
        // memory[55] = 32'hfef405a3;
        // memory[56] = 32'hfeb44783;
        // memory[57] = 32'h0017c793;
        // memory[58] = 32'hfff7f793;
        // memory[59] = 32'hfc0792e3;
        // memory[60] = 32'hfec42583;
        // memory[61] = 32'hfc842503;
        // memory[62] = 32'h00000097;
        // memory[63] = 32'h060080e7;
        // memory[64] = 32'h00050713;
        // memory[65] = 32'hfcc42783;
        // memory[66] = 32'h40e787b3;
        // memory[67] = 32'hfef42023;
        // memory[68] = 32'hfec42783;
        // memory[69] = 32'hfcf42c23;
        // memory[70] = 32'hfe042783;
        // memory[71] = 32'hfcf42e23;
        // memory[72] = 32'hfd842703;
        // memory[73] = 32'hfdc42783;
        // memory[74] = 32'h00070913;
        // memory[75] = 32'h00078993;
        // memory[76] = 32'h00090713;
        // memory[77] = 32'h00098793;
        // memory[78] = 32'h00070513;
        // memory[79] = 32'h00078593;
        // memory[80] = 32'h03c12083;
        // memory[81] = 32'h03812403;
        // memory[82] = 32'h03412903;
        // memory[83] = 32'h03012983;
        // memory[84] = 32'h04010113;
        // memory[85] = 32'h00008067;
        // memory[86] = 32'hfd010113;
        // memory[87] = 32'h02112623;
        // memory[88] = 32'h02812423;
        // memory[89] = 32'h03010413;
        // memory[90] = 32'hfca42e23;
        // memory[91] = 32'hfcb42c23;
        // memory[92] = 32'hfdc42783;
        // memory[93] = 32'h00078663;
        // memory[94] = 32'hfd842783;
        // memory[95] = 32'h00079663;
        // memory[96] = 32'h00000793;
        // memory[97] = 32'h0440006f;
        // memory[98] = 32'hfdc42783;
        // memory[99] = 32'hfef42623;
        // memory[100] = 32'h00100793;
        // memory[101] = 32'hfef42423;
        // memory[102] = 32'h0200006f;
        // memory[103] = 32'hfec42703;
        // memory[104] = 32'hfdc42783;
        // memory[105] = 32'h00f707b3;
        // memory[106] = 32'hfef42623;
        // memory[107] = 32'hfe842783;
        // memory[108] = 32'h00178793;
        // memory[109] = 32'hfef42423;
        // memory[110] = 32'hfd842703;
        // memory[111] = 32'hfe842783;
        // memory[112] = 32'hfce7cee3;
        // memory[113] = 32'hfec42783;
        // memory[114] = 32'h00078513;
        // memory[115] = 32'h02c12083;
        // memory[116] = 32'h02812403;
        // memory[117] = 32'h03010113;
        // memory[118] = 32'h00008067;
		
	 end
		
	 assign instruction = (pc[23:2] < 512) ? memory[pc[23:2]] : 32'b0;

endmodule
