module textMode(
	input hsync, // sincronismo horizontal
	input vsync, // sincronismo vertical
	input [6:0] char, // caracter que se mostrara en la vga
	input [2:0] col, // columna donde se graficara el caracter dependiendo del cuadro de 8X16 pixeles
	input [3:0] row, // columna donde se graficara el caracter dependiendo del cuadro de 8X16 pixeles
	input [7:0] RomD, // salida de la ram de caracteres para identificar que registro va en la posicion segun row y del cuadro de 8X16
	input von, // para identificar si esta en zona de la pantalla donde se puede mostrar los caracteres
	
	output hsyncOut, // salida del sincronismo horizontal
	output vsyncOut, // salida del sincronismo vertical
	// la direccion del registro que se pintara en la pantalla, 
	//depende de la fila en la que se encuentra, del caracter y del cuadro de 8X16
	// RomA
	output [10:0] RomA, 
	output [7:0] R, // valor de la intenciadad para el color rojo
	output [7:0] G, // valor de la intenciadad para el color verde
	output [7:0] B // valor de la intenciadad para el color azul
	
);
	
	assign RomA = {char, row};
	// para seleccionar el color segun el valor del caracter, 
	// si es 1 muestra el color 0x66FF66, y 0x111111 para lo contrario
	// el valor se muestra segun la columna en la que se encuentra posicionado la vga
	reg select_color;
	reg [7:0] red;
	reg [7:0] green;
	reg [7:0] blue;
	parameter color_char = 24'h66FF66;
	parameter color_background = 24'h111111;
	parameter color_display_no_visible = 24'h000000;
	
	always @(*) begin
		select_color = RomD[7 - col];
	end
	
	always @(*) begin
		if(von) begin
			red = (select_color) ? 8'h66 : 8'h11;
			green = (select_color) ? 8'hff : 8'h11;
			blue = (select_color) ? 8'h66 : 8'h11;
		end else begin
			red = 8'h0;
			green = 8'h0;
			blue = 8'h0;
		end
	end
	
	assign R = red;
	assign G = green;
	assign B = blue;
	
endmodule
	

	


module color(
  input clock,                 // 50 MHz clock on de1-soc
  input sw0,                   // reset switch
  input sw1,                   // set a green background
  input sw2,                   // set a blue background
  input sw3,                   // set a red background
  output reg [7:0] vga_red,    // VGA outputs
  output reg [7:0] vga_green,
  output reg [7:0] vga_blue,
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
    .reset(sw0), 
    .video_on(videoOn), 
    .hsync(vga_hsync), 
    .vsync(vga_vsync), 
    .clk(vga_clock),
    .x(x), .y(y)
  );

  // Assigns some "functionality" to the switches to change the display color
  always @*
    if (~videoOn)
      {vga_red, vga_green, vga_blue} = 8'h0;
    else if(sw1 == 1'b1)
      {vga_red, vga_green, vga_blue} = {8'h0, 8'hff, 8'h0};
    else if(sw2 == 1'b1)
      {vga_red, vga_green, vga_blue} = {8'h0, 8'h0, 8'hff};
    else if(sw3 == 1'b1)
      {vga_red, vga_green, vga_blue} = {8'hff, 8'h0, 8'h0};
    else
      {vga_red, vga_green, vga_blue} = {8'hff, 8'hff, 8'h0};
endmodule

/**
 *  Generates a 25MHz clock (clock25) from a 50 MHz reference clock
 */
module clock50_25(clock50, reset, clock25);
  input clock50;
  input reset;
  output clock25;

  reg [1:0] state;
  always @(posedge clock50)
    if (reset) state <= 0;
    else state <= state + 2'b1;

  assign clock25 = (state == 2'b0 || state == 2'b10) ? 1'b1 : 1'b0;
endmodule

module vga_controller(
  input clk_50MHz,   // Assumes de1-soc
  input reset,        // system reset
  output video_on,    // ON while pixel counts for x and y and within display area
  output hsync,       // horizontal sync
  output vsync,       // vertical sync
  output clk,         // the 25MHz pixel/second rate signal, pixel tick
  output [9:0] x,     // pixel count/position of pixel x, max 0-799
  output [9:0] y      // pixel count/position of pixel y, max 0-524
  );
  
  // Based on VGA standards found at vesa.org for 640x480 resolution
  // Total horizontal width of screen = 800 pixels, partitioned  into sections
  parameter HD = 640;             // horizontal display area width in pixels
  parameter HF = 48;              // horizontal front porch width in pixels
  parameter HB = 16;              // horizontal back porch width in pixels
  parameter HR = 96;              // horizontal retrace width in pixels
  parameter HMAX = HD+HF+HB+HR-1; // max value of horizontal counter = 799
  // Total vertical length of screen = 525 pixels, partitioned into sections
  parameter VD = 480;             // vertical display area length in pixels 
  parameter VF = 10;              // vertical front porch length in pixels  
  parameter VB = 33;              // vertical back porch length in pixels   
  parameter VR = 2;               // vertical retrace length in pixels  
  parameter VMAX = VD+VF+VB+VR-1; // max value of vertical counter = 524   

  wire w_25MHz;
  clock50_25 c(.clock50(clk_50MHz), .reset(reset), .clock25(w_25MHz));
  
  // Counter Registers, two each for buffering to avoid glitches
  reg [9:0] h_count_reg, h_count_next;
  reg [9:0] v_count_reg, v_count_next;
  
  // Output Buffers
  reg v_sync_reg, h_sync_reg;
  wire v_sync_next, h_sync_next;
  
  // Register Control
  always @(posedge clk_50MHz or posedge reset)
    if(reset) begin
      v_count_reg <= 0;
      h_count_reg <= 0;
      v_sync_reg  <= 1'b0;
      h_sync_reg  <= 1'b0;
    end
    else begin
      v_count_reg <= v_count_next;
      h_count_reg <= h_count_next;
      v_sync_reg  <= v_sync_next;
      h_sync_reg  <= h_sync_next;
    end
  //Logic for horizontal counter
  always @(posedge w_25MHz or posedge reset)      // pixel tick
    if(reset)
      h_count_next = 0;
    else
      if(h_count_reg == HMAX)                 // end of horizontal scan
        h_count_next = 0;
      else
        h_count_next = h_count_reg + 10'd1;         

  // Logic for vertical counter
  always @(posedge w_25MHz or posedge reset)
    if(reset)
      v_count_next = 0;
    else
      if(h_count_reg == HMAX)                 // end of horizontal scan
        if((v_count_reg == VMAX))           // end of vertical scan
          v_count_next = 0;
        else
          v_count_next = v_count_reg + 10'd1;
      
  // h_sync_next asserted within the horizontal retrace area
  assign h_sync_next = (h_count_reg >= (HD+HB) && h_count_reg <= (HD+HB+HR-1));
  
  // v_sync_next asserted within the vertical retrace area
  assign v_sync_next = (v_count_reg >= (VD+VB) && v_count_reg <= (VD+VB+VR-1));
  
  // Video ON/OFF - only ON while pixel counts are within the display area
  assign video_on = (h_count_reg < HD) && (v_count_reg < VD); // 0-639 and 0-479 respectively
          
  // Outputs
  assign hsync  = h_sync_reg;
  assign vsync  = v_sync_reg;
  assign x      = h_count_reg;
  assign y      = v_count_reg;
  assign clk    = w_25MHz;
endmodule
