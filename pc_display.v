module pc_display (
    input wire [31:0] pc,  // Entrada del valor del PC de 32 bits
    input wire sel,        // Selector: 0 para los 16 bits menos significativos, 1 para los más significativos
    output wire [6:0] seg_display0,  // Segmentos para display 0
    output wire [6:0] seg_display1,  // Segmentos para display 1
    output wire [6:0] seg_display2,  // Segmentos para display 2
    output wire [6:0] seg_display3  // Segmentos para display 3
);
    wire [15:0] selected_bits;  // 16 bits seleccionados del PC
    wire [3:0] hex_digit0, hex_digit1, hex_digit2, hex_digit3;

    // MUX: selecciona los bits dependiendo del valor de 'sel'
    assign selected_bits = (sel == 1'b0) ? pc[15:0] : pc[31:16];

    // Extracción de los 4 bits para cada display (hexadecimal)
    assign hex_digit0 = selected_bits[15:12];  // Dígito más significativo
    assign hex_digit1 = selected_bits[11:8];   // Segundo dígito
    assign hex_digit2 = selected_bits[7:4];    // Tercer dígito
    assign hex_digit3 = selected_bits[3:0];    // Cuarto dígito

    // Conversión de los dígitos hexadecimales a 7 segmentos
    hex_to_7seg display0 (
        .hex_digit(hex_digit0),
        .seg(seg_display0)  // Conectar al primer display
    );
    
    hex_to_7seg display1 (
        .hex_digit(hex_digit1),
        .seg(seg_display1)  // Conectar al segundo display
    );
    
    hex_to_7seg display2 (
        .hex_digit(hex_digit2),
        .seg(seg_display2)  // Conectar al tercer display
    );
    
    hex_to_7seg display3 (
        .hex_digit(hex_digit3),
        .seg(seg_display3)  // Conectar al cuarto display
    );
    
endmodule
