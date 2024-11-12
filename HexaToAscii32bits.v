// Para selecionar que caracter se debe convertir en asccii
// para mostrar el valor con la siguiente extructura xx-xx-xx
// si el valor por ejemplo es 30-2E-32-76, me convertira cada valor a 
// su representacion ascii para que me muestre en pantalla de la misma forma
module HexaToAscii32bits (
	input [31:0] in,
	input [3:0] col,
	output [6:0] out
);
	
	reg [7:0] char;
	reg [7:0] show_line;
	reg [7:0] char_out;
	
	always @(*) begin
		// con col se selecciona el caracter a mostrar segun la columna 
		case (col)
			4'd0: char = in[31:28];
			4'd1: char = in[27:24];
			4'd2: char = 8'h2D; // valor que representa el caracter "-"
			4'd3: char = in[23:20];
			4'd4: char = in[19:16];
			4'd5: char = 8'h2D; // valor que representa el caracter "-"
			4'd6: char = in[15:12];
			4'd7: char = in[11:8];
			4'd8: char = 8'h2D; // valor que representa el caracter "-"
			4'd9: char = in[7:4];
			4'd10: char = in[3:0];
			default: char = 8'b0;
		endcase
	end
	
	always @(*) begin
		if(char == 8'h2D) begin
			char_out = char; // para mostrar "-" en cada dos caracteres
		end else begin
			if(char >= 8'd10) begin
			// si el caracter es mayor o igual a 10 los valores corresponden
			// a "A", "B", ... , "F" y si sumamos el valor correspondeiente en 
			// decimal a esos valores a 55 nos dara el valor correspondiente en 
			// codigo ascii asi por ejemplo A en hexadecimal es 10 y si le sumamos
			// 55 este sera igual a 65 que corresponde al caracter A en ascii
				char_out = char + 8'd55;  
			end else begin
				char_out = char + 8'd48;
			end
		end
	end
			
	assign out = char_out[6:0];
			
	
	
endmodule