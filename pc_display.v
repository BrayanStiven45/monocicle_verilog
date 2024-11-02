module pc_display (
    input wire [31:0] pc,  // Entrada del valor del PC de 32 bits
    input wire [2:0] sel,        // Selector: 0 para los 16 bits menos significativos, 1 para los más significativos
	 input wire [31:0] register, // Registro a mostrar
	 input wire [31:0] instruction,
    output wire [6:0] seg_display0,  // Segmentos para display 0
    output wire [6:0] seg_display1,  // Segmentos para display 1
    output wire [6:0] seg_display2,  // Segmentos para display 2
    output wire [6:0] seg_display3  // Segmentos para display 3
);
    reg [15:0] selected_bits;  // seleccionar 16 bits para mostrar en el display
    reg [3:0] hex_digit0, hex_digit1, hex_digit2, hex_digit3;
	 
	 always @(*) begin
		case (sel)
			3'b000: selected_bits = pc[15:0]; // se muestran los bits menos significativos del pc
			3'b001: selected_bits = pc[31:16]; // se muestran los bits mas significativos del pc
			3'b010: selected_bits = register[15:0]; // se muestran los bits menos significativos del registro
			3'b011: selected_bits = register[31:16]; // se muestran los bits mas significativos del registro
			3'b100: selected_bits = instruction[15:0]; // se muestran los bits menos significativos del registro
			3'b101: selected_bits = instruction[31:16]; // se muestran los bits mas significativos del registro
			default: selected_bits = 16'b0;
		endcase;
		// Extracción de los 4 bits para cada display (hexadecimal)
		hex_digit0 = selected_bits[15:12];  // Dígito más significativo
		hex_digit1 = selected_bits[11:8];   // Segundo dígito
		hex_digit2 = selected_bits[7:4];    // Tercer dígito
		hex_digit3 = selected_bits[3:0];    // Cuarto dígito
		
	 end
   
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
