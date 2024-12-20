module binaryToAscii
#(
    parameter size = 2
)
(	
	input [(size-1):0] in, // Valor a convertir a ascii
	input [(size-1):0] col, // Valor que me selecciona que bit de la entrada in se quiere mostrar
   output [6:0] out // Salida en valor ascii del bit que se quiere mostrar de in selecionado con col
);

	wire [6:0] suma_ascii; // valor que toma el bit y lo suma al decimal 48 para que quede convertido en ascii
	wire [6:0] ascii; // Valor del bit que se desea mostrar en tamaño de 7 bits para poder realizar la suma
	
	assign ascii = {6'b0, in[(size-1)-col]}; // Convierto el bit a un valor de 7 bits para poder realizar la suma
	assign suma_ascii = ascii + 7'd48; // le suma el valor en decimal 48 para poder obtener el caracter ascii "1" ó "0"
	
	assign out = suma_ascii;
endmodule