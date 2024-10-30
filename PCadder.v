module PCAdder (
    input wire [31:0] pc_in,   // Entrada del valor actual del PC
    output wire [31:0] pc_out  // Salida del PC incrementado en 4
);

    // Sumar 4 al valor actual del PC
    assign pc_out = pc_in + 32'd4;

endmodule
