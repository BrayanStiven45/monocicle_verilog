module instruction_decoder (
  input [31:0] in,
  output [6:0] opcode,
  output [2:0] funct3,
  output [6:0] funct7,
  output [4:0] rs1,
  output [4:0] rs2,
  output [4:0] rd,
  output [24:0] immediate
);
  
  assign opcode = in[6:0];
  assign funct3 = in[14:12];
  assign funct7 = in[31:25];
  assign rs1 = in[19:15];
  assign rs2 = in[24:20];
  assign rd = in[11:7];
  assign immediate = in[31:7];
  
endmodule