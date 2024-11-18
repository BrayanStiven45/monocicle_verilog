/**
 *  Generates a 25MHz clock (clock25) from a 50 MHz reference clock
 */
module clock50_25(clock50, clock25);
  input clock50;
  output clock25;

  reg [1:0] state;
  always @(posedge clock50)
     state <= state + 2'b1;

  assign clock25 = (state == 2'b0 || state == 2'b10) ? 1'b1 : 1'b0;
endmodule

module vga_controller(
  input clk_50MHz,   // Assumes de1-soc
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
  clock50_25 c(.clock50(clk_50MHz), .clock25(w_25MHz));
  
  // Counter Registers, two each for buffering to avoid glitches
  reg [9:0] h_count_reg, h_count_next;
  reg [9:0] v_count_reg, v_count_next;
  
  // Output Buffers
  reg v_sync_reg, h_sync_reg;
  wire v_sync_next, h_sync_next;
  
  // Register Control
  always @(posedge clk_50MHz)
	begin
      v_count_reg <= v_count_next;
      h_count_reg <= h_count_next;
      v_sync_reg  <= v_sync_next;
      h_sync_reg  <= h_sync_next;
    end
  //Logic for horizontal counter
  always @(posedge w_25MHz)      // pixel tick
      if(h_count_reg == HMAX)                 // end of horizontal scan
        h_count_next = 0;
      else
        h_count_next = h_count_reg + 10'd1;         

  // Logic for vertical counter
  always @(posedge w_25MHz)
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