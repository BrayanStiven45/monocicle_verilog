module memory_register (
    input wire clk,              // Reloj para escribir en registros
    input wire regWrite,         // Señal para habilitar la escritura en los registros
    input wire [4:0] rs1,        // Entrada de 5 bits para seleccionar registro fuente 1
    input wire [4:0] rs2,        // Entrada de 5 bits para seleccionar registro fuente 2
    input wire [4:0] rd,         // Entrada de 5 bits para seleccionar registro destino
    input wire [31:0] writeData, // Datos para escribir en el registro destino
    output wire [31:0] readData1, // Salida de los datos leídos del registro fuente 1
    output wire [31:0] readData2, // Salida de los datos leídos del registro fuente 2
	 
    //Para mostrar en la FPGA
    input wire [4:0] displaySelect, // Entrada de seleccion para mostrar en el display de la FPGA
    output wire [31:0] displayData // Salida del registro para mostrar en la FPGA
);

    // Definir los 32 registros de 32 bits
    reg [31:0] registers [0:31];

    // Inicializar todos los registros a 0 al inicio
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
		  registers[2] = 32'd64;
    end

    // Leer los registros correspondientes
    assign readData1 = registers[rs1];
    assign readData2 = registers[rs2];
	 
    assign displayData = registers[displaySelect];

    // Escritura en el registro rd cuando regWrite está activo
    always @(posedge clk) begin
        if (regWrite && rd != 5'b00000) begin
            registers[rd] <= writeData;
        end
        registers[0] <= 32'b0; // Forzar el registro x0 a 0 en cada ciclo
    end

endmodule
