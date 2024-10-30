module mux_2 (
    input wire [31:0] in_0,  // Primera entrada de 32 bits
    input wire [31:0] in_1,  // Segunda entrada de 32 bits
    input wire [31:0] in_2,  // Tercera entrada de 32 bits
    input wire [1:0] sel,     // Señal de selección (2 bits)
    output reg [31:0] out     // Salida de 32 bits
);

    always @(*) begin
        case (sel)
            2'b00: out = in_0;  // Selecciona in_0
            2'b01: out = in_1;  // Selecciona in_1
            2'b10: out = in_2;  // Selecciona in_2
            default: out = 32'b0; // Valor predeterminado
        endcase
    end

endmodule
