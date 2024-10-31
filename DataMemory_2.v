module DataMemory_2(
	input clk,
	input [31:0] address,
	input [31:0] DataWr,
	input DMWr,      // 1: write, 0: read
	input [2:0] DMCtrl,     
	output reg [31:0] DataRd
);
	wire [8:0] addr = address[10:2];
	wire [31:0] read_data;
	reg [3:0] wren;
	
	ram ram_0(
		.data(DataWr[7:0]),
		.wren(wren[0]),
		.address(addr),
		.clock(clk),
		.q(read_data[7:0])
	);
	
	ram ram_1(
		.data(DataWr[15:8]),
		.wren(wren[1]),
		.address(addr),
		.clock(clk),
		.q(read_data[15:8])
	);
	
	ram ram_2(
		.data(DataWr[23:16]),
		.wren(wren[2]),
		.address(addr),
		.clock(clk),
		.q(read_data[23:16])
	);
	
	ram ram_3(
		.data(DataWr[31:24]),
		.wren(wren[3]),
		.address(addr),
		.clock(clk),
		.q(read_data[31:24])
	);
	
	always @(*) begin
        if (DMWr) begin
				case (DMCtrl)
					 3'b000: wren = 4'b0001;  // Byte con signo (8 bits)
					 3'b001: wren = 4'b0011;  // Half-word con signo (16 bits)
					 3'b010: wren = 4'b1111;  // Word completo (32 bits)
					 default: wren = 4'b0000; // No escribe nada en la RAM
				endcase

				DataRd <= 32'b0;
				
	
        end else begin
				wren = 4'b0000;  // No escribir en la RAM
		  
				case (DMCtrl)
                3'b000: DataRd = {{24{read_data[7]}}, read_data[7:0]};  // Bit con signo
                3'b001: DataRd = {{16{read_data[15]}}, read_data[15:0]};//Half-word con signo
                3'b010: DataRd = read_data;  // Word
                3'b100: DataRd = {24'b0, read_data[7:0]};  // Bit sin signo
                3'b101: DataRd = {16'b0, read_data[15:0]};  // Half-word sin signo
                default: DataRd = 32'b0;  // Retornar 0 si el valor de size es inválido
            endcase
             
        end
    end
		
		
	 

	
endmodule
	
	