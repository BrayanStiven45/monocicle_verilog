module vga(
	input clock,                 // 50 MHz clock on de1-soc
	input [31:0] instruction,
	input [31:0] pc,
	input [6:0] opcode,
	input [4:0] rd,
	input [2:0] funct3,
	input [4:0] rs1,
	input [4:0] rs2,
	input [6:0] funct7,
	input [31:0] register, // Registro a mostrar
	input [31:0] rd_out,
	input [31:0] rs1_out,
	input [31:0] rs2_out,
	input ruwr,
	input [31:0] immediate,
	
	output reg [4:0] register_select, // para seleccinar los registros a mostrar
	output [7:0] vga_red,    // VGA outputs
	output [7:0] vga_green,
	output [7:0] vga_blue,
	output vga_hsync,
	output vga_vsync,
	output vga_clock
);
// x and y coordinates (not used in this example)
wire [9:0] x;
wire [9:0] y;
wire videoOn;
// Creates an instance of a vga controller.
vga_controller pt(
	.clk_50MHz(clock),  
	.video_on(videoOn), 
	.hsync(vga_hsync), 
	.vsync(vga_vsync), 
	.clk(vga_clock),
	.x(x), .y(y)
);

wire [7:0] d;
wire [10:0] romA;
wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;
wire [6:0] char_ram;

textMode text(
		.hsync(1'b0),
		.vsync(1'b0),
		.char(char),
		.col(x[2:0]),
		.row(y[3:0]),
		.RomD(d),
		.von(videoOn),
//		.hsyncOut(hsync),
//		.vsyncOut(vsync),
		.RomA(romA),
		.R(red),
		.G(green),
		.B(blue)
	);
	
	assign vga_red = red;
	assign vga_green = green;
	assign vga_blue = blue;
	
	FontRom font(
		.addr(romA),
		.d(d)
	);
	
	wire [11:0] addrScreen;
	wire [6:0] colHexaToAscii;
	wire [6:0] char_ins;
	wire [6:0] char_pc;
	wire [6:0] char_op_0;
	wire [6:0] char_op_1;
	wire [6:0] char_rd;
	wire [6:0] char_fun3;
	wire [6:0] char_rs1;
	wire [6:0] char_rs2;
	wire [6:0] char_fun7;
	wire [6:0] char_fun7_decimal;
	wire [6:0] char_register;
	reg [6:0] char;
	wire [6:0] char_rd_decimal; // la posicion en la que se guarda un valor en la memoria de registros
	wire [6:0] char_rd_out;
	wire [6:0] char_rs1_out;
	wire [6:0] char_rs2_out;
	wire [6:0] char_ruwr;
	wire [6:0] char_imm; // para mostrar el inmediato

	wire [3:0] col_ins; // para seleccionar el caracter que se va a proyectar de la instruccion
	wire [3:0] col_pc;// para seleccionar el caracter que se va a proyectar del pc
	wire [6:0] col_op_0;
	wire [6:0] col_op_1;	// para seleccionar el caracter que se va a proyectar del opcode
	wire [4:0] col_rd;
	wire [2:0] col_fun3;
	wire [4:0] col_rs1;
	wire [4:0] col_rs2;
	wire [6:0] col_fun7;
	wire col_fun7_decimal;
	wire col_rd_decimal;
	reg [3:0] col_register;
	wire [3:0] col_ruwr;
	wire [3:0] col_rd_out;
	wire [3:0] col_rs1_out;
	wire [3:0] col_rs2_out;
	wire [3:0] col_imm; // para seleccionar el caracter que se va a proyectar del inmediato
	
	assign addrScreen[6:0] = x[9:3];
	assign addrScreen[11:7] = y[8:4];
	assign colHexaToAscii = x[9:3]; 	// Para saber en que posicion en X empieza un caracter
	
	// Seleccionar el caracter que se quiere mostrar segun la posicion de X
	
	
	
	// // Para mostrar la primera columna de los registros
	// assign register_select_1 = y[8:4];
	// assign col_register_1 = colHexaToAscii[3:0] - 4'd11; 

	// // Para mostrar la Segunda columna de los registros
	// assign register_select_2 = y[8:4] + 5'd11;
	// assign col_register_2 = colHexaToAscii[3:0] - 4'd1; 
	
	// // Para mostrar la tercera columna de los registros
	// assign register_select_3 = y[8:4] + 5'd22;
	// assign col_register_3 = colHexaToAscii[3:0] - 4'd8; 

	always @(*) begin
		if( x >= 10'd11 && x <= 10'd21) begin
			register_select = y[8:4];
			col_register = colHexaToAscii[3:0] - 4'd11;
		end else if (x >= 10'd22 && x <= 10'd32) begin
			register_select = y[8:4] + 5'd11;
			col_register = colHexaToAscii[3:0] - 4'd1;
		end else if (x >= 10'd56 && x <= 10'd66) begin
			register_select = y[8:4] + 5'd22;
			col_register = colHexaToAscii[3:0] - 4'd8;
		end else begin
			register_select = 5'b0;
		end
	end

	assign col_ins = colHexaToAscii[3:0] - 4'd1; 
	assign col_pc = colHexaToAscii[3:0] - 4'd12;
	assign col_rd = colHexaToAscii[4:0] - 5'd2;
	assign col_fun3 = colHexaToAscii[2:0] - 3'd6;
	assign col_rs1 = colHexaToAscii[4:0] - 5'd24;
	assign col_rs2 = colHexaToAscii[4:0] - 5'd18;
	assign col_fun7 = colHexaToAscii[6:0] - 7'd18;
	assign col_op_0 = colHexaToAscii[6:0] - 7'd40;
	assign col_op_1 = colHexaToAscii[6:0] - 7'd11;
	assign col_fun7_decimal = colHexaToAscii[0] - 7'd1;
	assign col_rd_decimal = colHexaToAscii[0] - 7'd1;
	assign col_ruwr = colHexaToAscii[0];
	assign col_rd_out = colHexaToAscii[3:0] - 4'd11;
	assign col_rs1_out = colHexaToAscii[3:0] - 4'd1;
	assign col_rs2_out = colHexaToAscii[3:0] - 4'd7;
	assign col_imm = colHexaToAscii[3:0];
//	
	ScreenRam screen(
		.addr(addrScreen),
		.d(char_ram)
	);

	HexaToAscii32bits ascii_imm(
		.in(immediate),
		.col(col_imm),
		.out(char_imm)
	);
	
	HexaToAscii32bits ascii_rd_out(
		.in(rd_out),
		.col(col_rd_out),
		.out(char_rd_out)
	);

	HexaToAscii32bits ascii_rs1_out(
		.in(rs1_out),
		.col(col_rs1_out),
		.out(char_rs1_out)
	);

	HexaToAscii32bits ascii_rs2_out(
		.in(rs2_out),
		.col(col_rs2_out),
		.out(char_rs2_out)
	);		
	
	HexaToAscii32bits ascii_ins(
		.in(instruction),
		.col(col_ins),
		.out(char_ins)
	);
	
	HexaToAscii32bits ascii_pc(
		.in(pc),
		.col(col_pc),
		.out(char_pc)
	);
	
	HexaToAscii32bits ascii_register(
		.in(register),
		.col(col_register),
		.out(char_register)
	);

	binaryToAscii #(
		.size(1)
	) ascii_op_0(
		.in(ruwr),
		.col(col_ruwr),
		.out(char_ruwr)
	);
	
	binaryToAscii #(
		.size(7)
	) ascii_op_0(
		.in(opcode),
		.col(col_op_0),
		.out(char_op_0)
	);
	
	binaryToAscii #(
		.size(7)
	) ascii_op_1(
		.in(opcode),
		.col(col_op_1),
		.out(char_op_1)
	);
	
	binaryToAscii #(
		.size(5)
	) ascii_rd(
		.in(rd),
		.col(col_rd),
		.out(char_rd)
	);
	
	binaryToAscii #(
		.size(3)
	) ascii_fun3(
		.in(funct3),
		.col(col_fun3),
		.out(char_fun3)
	);
	
	binaryToAscii #(
		.size(5)
	) ascii_rs1(
		.in(rs1),
		.col(col_rs1),
		.out(char_rs1)
	);
	
	binaryToAscii #(
		.size(5)
	) ascii_rs2(
		.in(rs2),
		.col(col_rs2),
		.out(char_rs2)
	);
	
	binaryToAscii #(
		.size(7)
	) ascii_fun7(
		.in(funct7),
		.col(col_fun7),
		.out(char_fun7)
	);

	decimalToAscii  #(
		.size_binary(3),
		.size_decimal(1)
	)ascii_funct3_decimal(
		.in(funct3),
		.col(1'b0),
		.out(char_fun3_decimal)
	);

	decimalToAscii #(
		.size_binary(7),
		.size_decimal(2)
	)ascii_funct7_decimal(
		.in(funct7),
		.col(col_fun7_decimal),
		.out(char_fun7_decimal)
	);
	

	decimalToAscii#(
		.size_binary(5),
		.size_decimal(2)
	)ascii_rd_decimal(
		.in(rd),
		.col(col_rd_decimal),
		.out(char_rd_decimal)
	);

	always @(*) begin
		if (addrScreen >= 12'd1569 && addrScreen <= 12'd1579) begin
			char = char_ins;
		end else if (addrScreen >= 12'd1548 && addrScreen <= 12'd1558) begin
			char = char_pc;
		end else if (addrScreen >= 12'd1832 && addrScreen <= 12'd1838) begin
			char = char_op_0;
		end else if (addrScreen >= 12'd1931 && addrScreen <= 12'd1937) begin
			char = char_op_1;
		end else if (addrScreen >= 12'd1826 && addrScreen <= 12'd1830) begin
			char = char_rd;
		end else if (addrScreen >= 12'd1822 && addrScreen <= 12'd1824) begin
			char = char_fun3;
		end else if (addrScreen >= 12'd1816 && addrScreen <= 12'd1820) begin
			char = char_rs1;
		end else if (addrScreen >= 12'd1810 && addrScreen <= 12'd1814) begin
			char = char_rs2;
		end else if (addrScreen >= 12'd1802 && addrScreen <= 12'd1808) begin
			char = char_fun7;
		end else if (((x[9:3] >= 7'd11 && x[9:3] <= 7'd21)) && y[8:4] <= 5'd10) begin
			char = char_register;
		end else if (((x[9:3] >= 7'd22 && x[9:3] <= 7'd32)) && y[8:4] <= 5'd10) begin
			char = char_register;
		end else if (((x[9:3] >= 7'd56 && x[9:3] <= 7'd66)) && y[8:4] <= 5'd9) begin
			char = char_register;
		end else if (addrScreen == 12'd1948 ) begin
			char = char_fun3_decimal;
		end else if (addrScreen == 12'd1959 || addrScreen == 12'd1960) begin
			char = char_fun7_decimal;
		end else if (addrScreen == 12'd2054 || addrScreen == 12'd2054) begin
			char = char_rd_decimal; 
		end else if (addrScreen == 12'd1850) begin
			char = char_ruwr;
		end else if (addrScreen >= 12'd2059 && addrScreen <= 12'd2069) begin
			char = char_rd_out;	
		end else if (addrScreen >= 12'd2081 && addrScreen <= 12'd2091) begin
			char = char_rs1_out;
		end else if (addrScreen >= 12'd2103 && addrScreen <= 12'd2113) begin
			char = char_rs2_out;
		end else if (addrScreen >= 12'd2193 && addrScreen <= 12'd2203) begin
			char = char_imm;
		end else begin
			char = char_ram;
		end
	end
endmodule


