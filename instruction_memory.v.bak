module instruction_memory (
    input [31:0] pc,               // PC (24 bits efectivos como dirección de memoria)
    output reg [31:0] instruction   // Instrucción de 32 bits
);

    reg [31:0] memory [0:511];

    initial begin
        // Cargar instrucciones desde el archivo 'instructions.mem'
        $readmemh("instructions.mem", memory);
    end

    // Asignación de la instrucción según la dirección del PC
    always @(*) begin
        if (pc[23:2] < 512) begin
            instruction = memory[pc[23:2]]; // Asegúrate de que la dirección sea válida
        end else begin
            instruction = 32'b0; // Asigna 0 si la dirección está fuera de rango
        end
    end

endmodule

