module DataMemory (
    input clk,
    input [31:0] address,
    input [31:0] DataWr,
    input DMWr,      // 1: write, 0: read
    input [2:0] DMCtrl,
    output reg [31:0] DataRd
);
	reg [31:0] data_read;
    reg [31:0] data_write;
    reg [7:0] memory [0:255];  // Memoria de 256 palabras de 8 bits (para almacenamiento byte a byte)

    always @(posedge clk) begin
        if (DMWr) begin
            // Escritura en la memoria según el control de tamaño DMCtrl
            case (DMCtrl)
                3'b000: data_write = {24'b0, DataWr[7:0]};     // Byte
                3'b001: data_write = {16'b0, DataWr[15:0]};    // Half-word
                3'b010: data_write = DataWr;                   // Word completo
                default: data_write = 32'b0;                   // No escribe nada si DMCtrl es inválido
            endcase
            {memory[address+3], memory[address+2], memory[address+1], memory[address]} = data_write;
        end
    end

    // Lógica combinacional para lectura de datos
    always @(*) begin
        // Leer los datos de memoria en función del tamaño especificado por DMCtrl
        data_read = {memory[address+3], memory[address+2], memory[address+1], memory[address]};

        case (DMCtrl)
            3'b000: DataRd = {{24{data_read[7]}}, data_read[7:0]};   // Byte con signo
            3'b001: DataRd = {{16{data_read[15]}}, data_read[15:0]}; // Half-word con signo
            3'b010: DataRd = data_read;                              // Word completo
            3'b100: DataRd = {24'b0, data_read[7:0]};                // Byte sin signo
            3'b101: DataRd = {16'b0, data_read[15:0]};               // Half-word sin signo
            default: DataRd = 32'b0;                                 // Valor por defecto si DMCtrl es inválido
        endcase
    end
endmodule
