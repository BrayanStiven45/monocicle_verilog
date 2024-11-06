module immediate_generator(
  input [24:0] immediate,
  input [2:0] immsrc,
  output [31:0] out
);

  reg [31:0] out_apo;
	
  always @(*) begin
		case(immsrc)
			// para un immsrc igual a 0 deja pasar el imediato de una instruccion tipo i
			3'd0: out_apo = {{20{immediate[24]}},immediate[24:13]};
			// para un immsrc igual a 1 deja pasar el imediato de una instruccion tipo s
			3'd1: out_apo = {{20{immediate[24]}},immediate[24:18],immediate[4:0]};
			// para un immsrc igual a 2 deja pasar el imediato de una instruccion tipo u
			3'd2: out_apo = {immediate[24:5],12'b0};
			// para un immsrc igual a 5 deja pasar el imediato de una instruccion tipo b
			3'd5: out_apo = {{19{immediate[24]}},immediate[24],immediate[0], immediate[23:18], immediate[4:1], 1'b0};
			// para un immsrc igual a 6 deja pasar el imediato de una instruccion tipo j
			3'd6: out_apo = {{11{immediate[24]}},immediate[24], immediate[12:5], immediate[13], immediate[23:14], 1'b0};
			default: out_apo = 32'b1;
		endcase
	end
	
	assign out = out_apo;
  
endmodule
