module DataMemory (
    input [31:0] address,
    input [31:0] write_data,
    input mem_write,      // 1: write, 0: read
    input [2:0] size,     
    output reg [31:0] read_data
);
    reg [7:0] memory [0:2047];  // Memoria de 512 palabras de 8 bits (para almacenamiento byte a byte)

    always @(*) begin
        if (mem_write) begin
            case (size)
                3'b000: memory[address] = write_data[7:0];  // Bit con signo
                3'b001: {memory[address+1], memory[address]} = write_data[15:0];  // Half-word con signo
                3'b010: {memory[address+3], memory[address+2], memory[address+1], memory[address]} = write_data;  // Word
                default: ; // No hacer nada en caso de valor no válido
            endcase
	read_data <= 32'b0;
        end else begin
            case (size)
                3'b000: read_data = {{24{memory[address][7]}}, memory[address]};  // Bit con signo
                3'b001: read_data = {{16{memory[address+1][7]}}, memory[address+1], memory[address]};//Half-word con signo
                3'b010: read_data = {memory[address+3], memory[address+2], memory[address+1], memory[address]};  // Word
                3'b100: read_data = {24'b0, memory[address]};  // Bit sin signo
                3'b101: read_data = {16'b0, memory[address+1], memory[address]};  // Half-word sin signo
                default: read_data = 32'b0;  // Retornar 0 si el valor de size es inválido
            endcase
        end
    end
endmodule
