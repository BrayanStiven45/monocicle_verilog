module ScreenRam(
	input [11:0] addr,
	output [7:0] d
);
	reg [6:0] rom [0:4000];
	
	initial begin
		$readmemh("screenRam.mem", rom);
	end
	
	assign d = rom[addr];

endmodule