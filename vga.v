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
  
  output [4:0] register_select, // para seleccinar el registro a mostrar
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
	wire [3:0] col_ins; // para seleccionar el caracter que se va a proyectar de la instruccion
	wire [3:0] col_pc;// para seleccionar el caracter que se va a proyectar del pc
	wire [6:0] char_ins;
	wire [6:0] char_pc;
	wire [6:0] char_op_0;
	wire [6:0] char_op_1;
	wire [6:0] char_rd;
	wire [6:0] char_fun3;
	wire [6:0] char_rs1;
	wire [6:0] char_rs2;
	wire [6:0] char_fun7;
	wire [6:0] char_register;
	reg [6:0] char;
	wire [6:0] col_op_0;
	wire [6:0] col_op_1;	// para seleccionar el caracter que se va a proyectar del opcode
	
	wire [4:0] col_rd;
	wire [2:0] col_fun3;
	wire [4:0] col_rs1;
	wire [4:0] col_rs2;
	wire [6:0] col_fun7;
	wire [3:0] col_register;
	
	assign addrScreen[6:0] = x[9:3];
	assign addrScreen[11:7] = y[8:4];
	assign colHexaToAscii = x[9:3]; 	// Para saber en que posicion en X empieza un caracter
	
	// Seleccionar el caracter que se quiere mostrar segun la posicion de X
	assign col_ins = colHexaToAscii[3:0] - 4'd1; 
	assign col_pc = colHexaToAscii[3:0] - 4'd12;
	
	
	assign register_select = y[8:4];
	assign col_register = colHexaToAscii[3:0] - 4'd11;
	
	
	assign col_rd = colHexaToAscii[4:0] - 5'd2;
	assign col_fun3 = colHexaToAscii[2:0] - 3'd6;
	assign col_rs1 = colHexaToAscii[4:0] - 5'd24;
	assign col_rs2 = colHexaToAscii[4:0] - 5'd18;
	assign col_fun7 = colHexaToAscii[6:0] - 7'd18;
	assign col_op_0 = colHexaToAscii[6:0] - 7'd40;
	assign col_op_1 = colHexaToAscii[6:0] - 7'd11;
	
//	
	ScreenRam screen(
		.addr(addrScreen),
		.d(char_ram)
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
//		end else if (((x[9:3] >= 7'd11 && x[9:3] <= 7'd21) || (x[9:3] >= 7'd33 && x[9:3] <= 7'd43)) && y[8:4] <= 5'd10) begin
//			char = char_register;
//		end else if ((x[9:3] >= 7'd55 && x[9:3] <= 7'd65) && y[8:4] <= 5'd9) begin
//			char = char_register;
		end else begin
			char = char_ram;
		end
	end
endmodule


