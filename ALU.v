module ALU (
  input [31:0] A,
  input [31:0] B,
  input [3:0] ALUOp,
  output reg [31:0] ALURes
);
  always @(*) begin
    case (ALUOp)
      4'b0000: ALURes = A + B;          // ADD
      4'b0001: ALURes = A - B;          // SUB
      4'b0010: ALURes = (A < B) ? 32'd1 : 32'd0;  // SLT
      4'b0011: ALURes = (A < B) ? 32'd1 : 32'd0;  // SLTU
      4'b0100: ALURes = A << B[4:0];    // SLL
      4'b0101: ALURes = A >> B[4:0];    // SRL
      4'b0110: ALURes = $signed(A) >>> B[4:0]; // SRA
      4'b0111: ALURes = A ^ B;          // XOR
      4'b1000: ALURes = A | B;          // OR
      4'b1001: ALURes = A & B;          // AND
      default: ALURes = B;          // Valor por defecto
    endcase
  end
endmodule
