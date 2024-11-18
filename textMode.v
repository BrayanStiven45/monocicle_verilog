module textMode(
	input hsync, // sincronismo horizontal
	input vsync, // sincronismo vertical
	input [6:0] char, // caracter que se mostrara en la vga
	input [2:0] col, // columna donde se graficara el caracter dependiendo del cuadro de 8X16 pixeles
	input [3:0] row, // columna donde se graficara el caracter dependiendo del cuadro de 8X16 pixeles
	input [7:0] RomD, // salida de la ram de caracteres para identificar que registro va en la posicion segun row y del cuadro de 8X16
	input von, // para identificar si esta en zona de la pantalla donde se puede mostrar los caracteres
	
	output hsyncOut, // salida del sincronismo horizontal
	output vsyncOut, // salida del sincronismo vertical
	// la direccion del registro que se pintara en la pantalla, 
	//depende de la fila en la que se encuentra, del caracter y del cuadro de 8X16
	// RomA
	output [10:0] RomA, 
	output [7:0] R, // valor de la intenciadad para el color rojo
	output [7:0] G, // valor de la intenciadad para el color verde
	output [7:0] B // valor de la intenciadad para el color azul
	
);
	
	assign RomA = {char, row};
	// para seleccionar el color segun el valor del caracter, 
	// si es 1 muestra el color 0x66FF66, y 0x111111 para lo contrario
	// el valor se muestra segun la columna en la que se encuentra posicionado la vga
	reg select_color;
	reg [7:0] red;
	reg [7:0] green;
	reg [7:0] blue;
	parameter color_char = 24'h66FF66;
	parameter color_background = 24'h111111;
	parameter color_display_no_visible = 24'h000000;
	
	always @(*) begin
		select_color = RomD[7 - col];
	end
	
	always @(*) begin
		if(von) begin
			red = (select_color) ? 8'h66 : 8'h11;
			green = (select_color) ? 8'hff : 8'h11;
			blue = (select_color) ? 8'h66 : 8'h11;
		end else begin
			red = 8'h0;
			green = 8'h0;
			blue = 8'h0;
		end
	end
	
	assign R = red;
	assign G = green;
	assign B = blue;
	
endmodule