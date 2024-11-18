module divisor_25Mhz_a_1Hz (
    input wire clk_in,    // Reloj de entrada de 50 MHz
	 input wire activar,
    output reg clk_out    // Reloj de salida de 1 Hz
);

    // Número de ciclos para 1 segundo a 50 MHz
    parameter DIVISOR = 25000000;

    // Contador de 26 bits (suficiente para contar hasta 50 millones)
    reg [25:0] counter = 0;

    always @(posedge clk_in) begin
		 if (activar) begin
				if (counter == (DIVISOR - 1)) begin
					 clk_out <= ~clk_out; // Cambia el estado del reloj de salida
					 counter <= 0;       // Reinicia el contador
				end else begin
					 counter <= counter + 1; // Incrementa el contador
				end
		 end else begin
			clk_out <= 1'b0;
		 end
    end
endmodule
