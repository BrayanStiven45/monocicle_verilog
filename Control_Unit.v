module Control_Unit (
  input [6:0] opcode,
  input [2:0] funct3,
  input [6:0] funct7,
  output AluaSrc, 
  output Ruwr,
  output [2:0] immsrc,
  output AlubSrc,
  output [3:0] AluOp,
  output [4:0] BrOp,
  output DMWr,
  output [2:0] DMCTrl,
  output [1:0] RuDataWrSrc
);
  
  Aluasrc alua(
    .in(opcode),
    .out(AluaSrc)
  );
  
  Ruwr ruwr(
    .in(opcode),
    .out(Ruwr)
  );
  
  immsrc imsrc(
    .in(opcode),
    .out(immsrc)
  );
  
  Alubsrc alubsrc(
    .in(opcode),
    .out(AlubSrc)
  );
  
  AluOp aluop(
    .in(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .out(AluOp)
  );
  
  Brop brop(
    .in(opcode),
    .funct3(funct3),
    .out(BrOp)
  );
  
  DMWr dmwr(
    .in(opcode),
    .out(DMWr)
  );
  
  DMCTrl dmctrl(
    .in(opcode),
    .funct3(funct3),
    .out(DMCTrl)
  );
  
  RuDataWrSrc rudata(
    .in(opcode),
    .out(RuDataWrSrc)
  );
endmodule
  

module Aluasrc (
  input [6:0] in,
  output out
);
  wire and_1;
  wire and_2;
  wire and_3;
  
  assign and_1 = in[0] & in[1] & in[2] & (~ in[3]) & in[4] & (~ in[5]) & (~ in[6]);
  
  assign and_2 = in[0] & in[1] & (~ in[2]) & (~ in[3]) & (~ in[4]) & in[5] & in[6];
  
  assign and_3 = in[0] & in[1] & in[2] & in[3] & (~ in[4]) & in[5] & in[6];
  
  assign out = and_1 | and_2 | and_3;
  
endmodule


module Ruwr (
  input [6:0] in,
  output out
);
  
  wire and_1;
  wire and_2;
  wire and_3;
  
  assign and_1 = in[0] & in[1] & ~in[2] & ~in[3] & ~in[5] & ~in[6];
  
  assign and_2 = in[0] & in[1] & ~in[3] & in[4] & ~in[6];
  
  assign and_3 = in[0] & in[1] & in[2] & ~in[4] & in[5] & in[6];
  
  assign out = and_1 | and_2 | and_3;
  
endmodule
  

module immsrc (
  input [6:0] in,
  output [2:0] out
);
  
  wire xnor_1;
  wire s1;
  wire and_1;
  wire and_2;
  wire s2;
  wire s3;
  
  assign xnor_1 = in[2] ~^ in[3];
  
  assign s1 = in[0] & in[1] & xnor_1 & ~in[4] & in[5] & in[6];
  
  assign and_1 = in[0] & in[1] & in[2] & ~in[3] & in[4] & ~in[6];
  
  assign and_2 = in[0] & in[1] & in[2] & in[3] & ~in[4] & in[5] & in[6];
  
  assign s2 = and_1 | and_2;
  
  assign s3 = in[0] & in[1] & ~in[2] & ~in[3] & ~in[4] & in[5];
  
  assign out[0] = s3;
  assign out[1] = s2;
  assign out[2] = s1;
  
  
endmodule
    
    
module Alubsrc (
  input [6:0] in,
  output out
);
  
  assign out = ~in[0] | ~in[1] | in[2] | in[3] | ~in[4] | ~in[5] | in[6];
  
endmodule
    
    
    
module AluOp (
  input [6:0] in,
  input [2:0] funct3,
  input [6:0] funct7,
  output [3:0] out
);
  reg [3:0] out_apo;
  wire s1;
  wire and_1;
  wire and_2;
  wire and_3;
  wire s2;
  wire [1:0] sel;
  wire [3:0] fun3_0;
  wire [3:0] fun3_7;
  
  assign s1 = in[0] & in[1] & ~in[2] & ~in[3] & in[4] & ~in[6];
  
  assign and_1 = in[0] & in[1] & ~in[2] & ~in[3] & in[4] & in[5] & ~in[6];
  
  assign and_2 = funct3[0] & ~funct3[1] & funct3[2] & in[0] & in[1] & ~in[2] & ~in[3] & in[4] & ~in[5] & ~in[6];
  
  assign and_3 = in[0] & in[1] & in[2] & ~in[3] & in[4] & in[5] & ~in[6];
  
  assign s2 = and_1 | and_2 | and_3;
  
  assign sel[0] = s2;
  assign sel[1] = s1;
  
  assign fun3_0[2:0] = funct3;
  assign fun3_0[3] = 1'b0;
  
  assign fun3_7[2:0] = funct3;
  assign fun3_7[3] = funct7[5];
  
  always @ (*) begin
		case (sel)
				3'b0: out_apo = 4'b0;
				// es para la instruccion U-Lui que deja pasar el valor en la Alu si realizar ninguna operacion dentro de la alu
				3'b001: out_apo = in[4:1]; 
				3'b010: out_apo = fun3_0;
				3'b011: out_apo = fun3_7;
				default:
					 out_apo = 4'b0;
		endcase
	end
	assign out = out_apo;
  
endmodule

module Brop (
  input [6:0] in,
  input [2:0] funct3,
  output [4:0] out
);

  reg [4:0] out_apo;
  wire or_1;
  wire s1;
  wire s2;
  wire [1:0] sel;
  wire [4:0] fun3_1;
  
  assign or_1 = in[2] | ~in[3];
  
  assign s1 = in[0] & in[1] & or_1 & ~in[4] & in[5] & in[6];
  
  assign s2 = in[0] & in[1] & ~in[2] & ~in[3] & ~in[4] & in[5] & in[6];
  
  assign sel[0] = s2;
  assign sel[1] = s1;
  
  assign fun3_1[4:3] = 2'b01; 
  assign fun3_1[2:0] = funct3;
  
  always @ (*) begin
        case (sel)
            3'b00: out_apo = 5'b0;
            3'b01: out_apo = 5'b0;
            3'b10: out_apo = 5'b10000;
            3'b11: out_apo = fun3_1;
            default:
                out_apo = 5'b0;
        endcase
    end
	assign out = out_apo;
  
endmodule
  
  
module DMWr (
  input [6:0] in,
  output out
);
  
  assign out = in[0] & in[1] & ~in[2] & ~in[3] & ~in[4] & in[5] & ~in[6];
  
endmodule


module DMCTrl (
  input [6:0] in,
  input [2:0] funct3,
  output [2:0] out
);
  wire s;
  reg [2:0] out_apo;
  
  assign s = in[0] & in[1] & ~in[2] & ~in[3] & ~in[4] & ~in[6];
  
  always @ (*) begin
        case (s)
				// No importa el valor del de la posicion 0 de sel
            1'b0: out_apo = 3'b011;
            1'b1: out_apo = funct3;
            default:
                out_apo = 3'b0;
        endcase
    end
	 assign out = out_apo;
  
  
endmodule


module RuDataWrSrc (
  input [6:0] in,
  output [1:0] out
);
  wire s1;
  wire s2;
  
  assign s1 = in[0] & in[1] & in[2] & ~in[4] & in[5] & in[6];
  
  assign s2 = in[0] & in[1] & ~in[2] & ~in[3] & ~in[4] & ~in[5] & ~in[6];
  
  assign out[0] = s2;
  assign out[1] = s1;
    
endmodule
