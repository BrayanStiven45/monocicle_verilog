module immediate_generator(
  input [24:0] immediate,
  input [2:0] immsrc,
  output [31:0] out
);
  wire [24:0] tipo_i;
  wire [11:0] apo_tipo_i;
  wire [31:0] out_i;
  
  wire [24:0] tipo_s;
  wire [11:0] apo_tipo_s;
  wire [31:0] out_s;
  
  wire [24:0] tipo_u;
  wire [31:0] out_u;
  
  wire [24:0] tipo_b;
  wire [12:0] apo_tipo_b;
  wire [31:0] out_b;
  
  wire [24:0] tipo_j;
  wire [20:0] apo_tipo_j;
  wire [31:0] out_j;

  // Instancia del demux_3
  demux_3 #(
    .Bits(32),
    .Default(0)
  ) demux_3_io (
    .in(immediate),
    .sel(immsrc),
    .out_0(tipo_i),
    .out_1(tipo_s),
    .out_2(tipo_u),
    .out_5(tipo_b),
    .out_6(tipo_j)
  );
  
  // Para tipo I
  assign apo_tipo_i = tipo_i[24:13];
  
  signEx #(
    .Bits_in(12),
    .Bits_out(32)
  ) 
  signEx_io_i (
    .in(apo_tipo_i),
    .out(out_i)
  );
  
  // Para tipo S
  assign apo_tipo_s[4:0] = tipo_s[4:0];
  assign apo_tipo_s[11:5] = tipo_s[24:18];
  
  signEx #(
    .Bits_in(12),
    .Bits_out(32)
  ) 
  signEx_io_s (
    .in(apo_tipo_s),
    .out(out_s)
  );
  
  // Para tipo U
  assign out_u[31:12] = tipo_u[24:5];
  assign out_u[11:0] = 12'b0;
  
  // Para tipo B
  assign apo_tipo_b[0] = 1'b0;
  assign apo_tipo_b[4:1] = tipo_b[4:1];
  assign apo_tipo_b[10:5] = tipo_b[23:18];
  assign apo_tipo_b[11] = tipo_b[0];
  assign apo_tipo_b[12] = tipo_b[24];
  
  signEx #(
    .Bits_in(13),
    .Bits_out(32)
  ) 
  signEx_io_b (
    .in(apo_tipo_b),
    .out(out_b)
  );
  
  // Para tipo J
  assign apo_tipo_j[0] = 1'b0;
  assign apo_tipo_j[10:1] = tipo_j[23:14];
  assign apo_tipo_j[11] = tipo_j[13];
  assign apo_tipo_j[19:12] = tipo_j[12:5];
  assign apo_tipo_j[20] = tipo_j[24];
  
  signEx #(
    .Bits_in(21),
    .Bits_out(32)
  ) 
  signEx_io_j (
    .in(apo_tipo_j),
    .out(out_j)
  );
  
  mux_3 #(
    .Bits(32)
  )
  mux_3_io(
    .sel(immsrc),
    .in_0(out_i),
    .in_1(out_s),
    .in_2(out_u),
    .in_3(32'b1),
    .in_4(32'b1),
    .in_5(out_b),
    .in_6(out_j),
    .in_7(32'b1),
    .out(out)
  );
  

endmodule


module demux_3 #(

  parameter Bits = 2,
  parameter Default = 0
)
  (
    input [24:0] in,
    input [2:0] sel,
    output [Bits-1:0] out_0,
    output [Bits-1:0] out_1,
    output [Bits-1:0] out_2,
    output [Bits-1:0] out_3,
    output [Bits-1:0] out_4,
    output [Bits-1:0] out_5,
    output [Bits-1:0] out_6,
    output [Bits-1:0] out_7
  );
  
  assign out_0 = (sel == 3'h0)? in : Default;
  assign out_1 = (sel == 3'h1)? in : Default;
  assign out_2 = (sel == 3'h2)? in : Default;
  assign out_3 = (sel == 3'h3)? in : Default;
  assign out_4 = (sel == 3'h4)? in : Default;
  assign out_5 = (sel == 3'h5)? in : Default;
  assign out_6 = (sel == 3'h6)? in : Default;
  assign out_7 = (sel == 3'h7)? in : Default;
endmodule


module signEx #(
  parameter Bits_in = 1,
  parameter Bits_out = 2
)
  (
    input [Bits_in-1:0] in,
    output [Bits_out-1:0] out
  );
    
  assign out = {{Bits_out-Bits_in{in[Bits_in - 1]}},in};
endmodule
  
  

module mux_3 #(
  parameter Bits = 2
)
  (
    input [Bits-1:0] in_0,
    input [Bits-1:0] in_1,
    input [Bits-1:0] in_2,
    input [Bits-1:0] in_3,
    input [Bits-1:0] in_4,
    input [Bits-1:0] in_5,
    input [Bits-1:0] in_6,
    input [Bits-1:0] in_7,
    input [2:0] sel,
    output reg [Bits-1:0] out
  );
  
  always @ (*) begin
    case (sel)
      3'h0: out = in_0;
      3'h1: out = in_1;
      3'h2: out = in_2;
      3'h3: out = in_3;
      3'h4: out = in_4;
      3'h5: out = in_5;
      3'h6: out = in_6;
      3'h7: out = in_7;
      default:
        out = 'h0;
    endcase
  end
endmodule
