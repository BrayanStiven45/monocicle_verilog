module mux_1 (
    input wire [31:0] in_0,  // Primera entrada de 32 bits
    input wire [31:0] in_1,  // Segunda entrada de 32 bits
    input wire sel,           // Señal de selección
    output wire [31:0] out    // Salida de 32 bits
);

    assign out = (sel) ? in_1 : in_0;  // Selecciona in_1 si sel es 1, de lo contrario selecciona in_0

endmodule
