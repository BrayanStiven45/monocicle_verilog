module memory_register (
    input wire clk,              // Reloj para escribir en registros
    input wire regWrite,         // Señal para habilitar la escritura en los registros
    input wire [4:0] rs1,       // Entrada de 32 bits para seleccionar registro fuente 1
    input wire [4:0] rs2,       // Entrada de 32 bits para seleccionar registro fuente 2
    input wire [4:0] rd,        // Entrada de 32 bits para seleccionar registro destino
    input wire [31:0] writeData, // Datos para escribir en el registro destino
    output wire [31:0] readData1, // Salida de los datos leídos del registro fuente 1
    output wire [31:0] readData2,  // Salida de los datos leídos del registro fuente 2
	 
	 //Para mostrar en la fpga
	 input wire [4:0] displaySelect, // Entrada de seleccion par seleccionar el registro que se quiere mostrar en el display de fpga
	 output wire [31:0] displayData // Salida del registro que se quiere mostrar en la fpga
);

    // Definir los 32 registros de 32 bits
    reg [31:0] registers [0:31];

    // Leer los registros correspondientes
    assign readData1 = registers[rs1];
    assign readData2 = registers[rs2];
	 
	 assign displayData = registers[displaySelect];

    // Escritura en el registro rd cuando regWrite está activo
    always @(posedge clk) begin
        if (regWrite && rd != 5'b00000) begin
            registers[rd] <= writeData;
        end
    end
	 

endmodule
