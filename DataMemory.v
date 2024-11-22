module DataMemory (
    input clk,
    input [31:0] address,
    input [31:0] DataWr,
    input DMWr,      // 1: write, 0: read
    input [2:0] DMCtrl,
    output reg [31:0] DataRd,

    input [31:0] address_2,
    output reg [31:0] DataRd_2,
);
	wire [31:0] data_read;

    wire [31:0] data_read_2;
    wire [10:0] addr_2;

    reg [31:0] data_write;
    wire [10:0] addr = address[10:0] >> 2;
    wire [10:0] addr_2 = address_2[10:0] >> 2;
    // reg [7:0] memory [0:8191];  // Memoria de 256 palabras de 8 bits (para almacenamiento byte a byte)
    ram #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(11)
    ) memory_0 (
        .clk(clk),
        .address(addr),
        .data_in(data_write[7:0]),
        .write_enable(DMWr),
        .data_out(data_read[7:0]),
        .address_2(addr_2),
        .data_out_2(data_read_2[7:0])
    );

    ram #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(11)
    ) memory_1 (
        .clk(clk),
        .address(addr),
        .data_in(data_write[15:8]),
        .write_enable(DMWr),
        .data_out(data_read[15:8]),
        .address_2(addr_2),
        .data_out_2(data_read_2[15:8])
    );

    ram #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(11)
    ) memory_2 (
        .clk(clk),
        .address(addr),
        .data_in(data_write[23:16]),
        .write_enable(DMWr),
        .data_out(data_read[23:16]),
        .address_2(addr_2),
        .data_out_2(data_read_2[23:16])
    );

    ram #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(11)
    ) memory_3 (
        .clk(clk),
        .address(addr),
        .data_in(data_write[31:24]),
        .write_enable(DMWr),
        .data_out(data_read[31:24]),
        .address_2(addr_2),
        .data_out_2(data_read_2[31:24])
    );

    always @(*) begin
        // if (DMWr) begin
            // Escritura en la memoria según el control de tamaño DMCtrl
            case (DMCtrl)
                3'b000: data_write = {24'b0, DataWr[7:0]};     // Byte
                3'b001: data_write = {16'b0, DataWr[15:0]};    // Half-word
                3'b010: data_write = DataWr;                   // Word completo
                default: data_write = 32'b0;                   // No escribe nada si DMCtrl es inválido
            endcase
            // {memory[address+3], memory[address+2], memory[address+1], memory[address]} = data_write;
        // end
    end

    // Lógica combinacional para lectura de datos
    always @(*) begin

        case (DMCtrl)
            3'b000: DataRd = {{24{data_read[7]}}, data_read[7:0]};   // Byte con signo
            3'b001: DataRd = {{16{data_read[15]}}, data_read[15:0]}; // Half-word con signo
            3'b010: DataRd = data_read;                              // Word completo
            3'b100: DataRd = {24'b0, data_read[7:0]};                // Byte sin signo
            3'b101: DataRd = {16'b0, data_read[15:0]};               // Half-word sin signo
            default: DataRd = 32'b0;                                 // Valor por defecto si DMCtrl es inválido
        endcase
    end

    assign DataRd_2 = data_read_2;
endmodule
