module Branch_Unit (
  input [31:0] RS1,
  input [31:0] RS2,
  input [4:0] BrOP,
  output NextPCSrc
);
  reg out_wire;
  
  always @(*) begin
    if (BrOP[4:3] == 2'b0)
      out_wire = 1'b0;
    else if(BrOP[4] == 1'b1)
      out_wire = 1'b1;
    else
      case (BrOP)
        // BEQ: igual a
        5'b01000: out_wire = ($signed(RS1) == $signed(RS2));
        
        // BNE: no igual a
        5'b01001: out_wire = ($signed(RS1) != $signed(RS2));
        
        // BLT: menor que, con signo
        5'b01100: out_wire = ($signed(RS1) < $signed(RS2));
        
        // BGE: mayor o igual, con signo
        5'b01101: out_wire = ($signed(RS1) >= $signed(RS2));
        
        // BLTU: menor que, sin signo
        5'b01110: out_wire = (RS1 < RS2);
        
        // BGEU: mayor o igual, sin signo
        5'b01111: out_wire = (RS1 >= RS2);
        
        default: out_wire = 1'b0;
      endcase
  end
  
  assign NextPCSrc = out_wire;
  
endmodule
