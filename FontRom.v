module FontRom(
	input [10:0] addr,
	output [7:0] d
);
	reg [7:0] rom [0:2047];
	
	initial begin
		$readmemh("charRom.mem", rom);
	end
	
	assign d = rom[addr];

endmodule