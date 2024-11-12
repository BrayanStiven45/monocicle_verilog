module vgaController(
	input clk50,
	input [31:0] instruction,
	input [31:0] pc,
	
	output hsync_Out,
	output vsync_Out,
	output [7:0] R,
	output [7:0] G,
	output [7:0] B,
	output clk_25
);
	wire clk25;
	wire hsync;
	wire vsync;
	wire von;
	wire [9:0] x;
	wire [8:0] y;
	wire [10:0] romA;
	wire [7:0] d;
	// Valor para selecionar que caracter se dibujara en la pantalla
	// segun la posicion en la que se quiere dibujar
	wire [11:0] addrScreen;
	wire [7:0] char_ram;
	// este registro es para poder selecionar del convertidor de
	// hexadecimal a ascii, el caracter a dibujar en la pantalla
	// segun sea la posicion proporcionada por addScreen
	wire [6:0] colHexaToAscii;
	wire [6:0] char_inst;
	wire [6:0] char_pc;
	reg [6:0] char;
	
	
	// divisor de frecuencia de 50Mhz a 25Mhz
	clk50_25 clock_25(
		.clk50(clk50),
		.clk25(clk25)
	);
	
	sync syn(
		.clk_25(clk25),
		.hSync(hsync),
		.vSync(vsync),
		.video_on(von),
		.x(x),
		.y(y)
	);
	
	textMode text(
		.hsync(hsync),
		.vsync(vsync),
		.char(char),
		.col(x[2:0]),
		.row(y[3:0]),
		.RomD(d),
		.von(von),
		.hsyncOut(hsync_Out),
		.vsyncOut(vsync_Out),
		.RomA(romA),
		.R(R),
		.G(G),
		.B(B)
	);
	
	FontRom font(
		.addr(romA),
		.d(d)
	);
	
	assign addrScreen = {y[8:4] ,x[9:3]};
	assign colHexaToAscii = x[9:3];
	
	ScreenRam screen(
		.addr(addrScreen),
		.d(char_ram)
	);
	
	// Convertir la instruccion actual a ascci
	// las instrucciones se empiezan a dibujar en la pocision (33,12)
	// por lo que colHexaToAscii = 33, se le resta uno para que empieze a contar
	// desde 0 ya que si no empezaria a contar desde 1 ya que se toman los 4 mas menos significativos.
	HexaToAscii32bits ascii_instruction(
		.in(instruction),
		.col(colHexaToAscii - 7'd1),
		.out(char_inst)
	);
	
	// Convertir el pc actual a ascci
	// las instrucciones se empiezan a dibujar en la pocision (12,12)
	// por lo que colHexaToAscii = 12, se le resta 12 para que empieze a contar
	// desde 0 ya que si no empezaria a contar desde 12 ya que se toman los 4 mas menos significativos.
	HexaToAscii32bits ascii_pc(
		.in(pc),
		.col(colHexaToAscii - 7'd12),
		.out(char_pc)
	);
	
	always @(*) begin
		if(addrScreen >= 12'd1569 && addrScreen <= 12'd1580) begin
			char = char_inst;
		end else 
			if(addrScreen >= 12'd1548 && addrScreen <= 12'd1559) begin
				char = char_pc;
		end else begin
			char = char_ram;
		end
	end
	
	assign clk_25 = clk25;

endmodule

module clk50_25(
  input clk50,
  output clk25
);

  reg [1:0] state;
  always @(posedge clk50) begin
    state <= state + 2'b1;
	end

  assign clk25 = (state == 2'b0 || state == 2'b10) ? 1'b1 : 1'b0;
endmodule