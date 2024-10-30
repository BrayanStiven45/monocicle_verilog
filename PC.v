module PC (
  input clk,
  input [31:0] next_pc,
  output reg [31:0] pc
);

  initial begin
    pc = 32'b0;
  end

  always @(posedge clk) begin
    pc <= next_pc;  // Actualiza el PC con el valor del siguiente PC en cada flanco de reloj
  end

endmodule
