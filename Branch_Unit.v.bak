module CompSigned #(
    parameter Bits = 32
)
(
    input [(Bits -1):0] a,
    input [(Bits -1):0] b,
    output gt,  // greater than
    output eq,  // equal
    output lt   // less than
);
    assign gt = $signed(a) > $signed(b);
    assign eq = $signed(a) == $signed(b);
    assign lt = $signed(a) < $signed(b);
endmodule


module CompUnsigned #(
    parameter Bits = 32
)
(
    input [(Bits -1):0] a,
    input [(Bits -1):0] b,
    output gt,  // greater than
    output eq,  // equal
    output lt   // less than
);
    assign gt = a > b;
    assign eq = a == b;
    assign lt = a < b;
endmodule


module Mux_32x1
(
    input [4:0] sel,
    input in_0,
    input in_1,
    input in_2,
    input in_3,
    input in_4,
    input in_5,
    input in_6,
    input in_7,
    input in_8,
    input in_9,
    input in_10,
    input in_11,
    input in_12,
    input in_13,
    input in_14,
    input in_15,
    input in_16,
    input in_17,
    input in_18,
    input in_19,
    input in_20,
    input in_21,
    input in_22,
    input in_23,
    input in_24,
    input in_25,
    input in_26,
    input in_27,
    input in_28,
    input in_29,
    input in_30,
    input in_31,
    output reg out
);
    always @ (*) begin
        case (sel)
            5'h0: out = in_0;
            5'h1: out = in_1;
            5'h2: out = in_2;
            5'h3: out = in_3;
            5'h4: out = in_4;
            5'h5: out = in_5;
            5'h6: out = in_6;
            5'h7: out = in_7;
            5'h8: out = in_8;
            5'h9: out = in_9;
            5'ha: out = in_10;
            5'hb: out = in_11;
            5'hc: out = in_12;
            5'hd: out = in_13;
            5'he: out = in_14;
            5'hf: out = in_15;
            5'h10: out = in_16;
            5'h11: out = in_17;
            5'h12: out = in_18;
            5'h13: out = in_19;
            5'h14: out = in_20;
            5'h15: out = in_21;
            5'h16: out = in_22;
            5'h17: out = in_23;
            5'h18: out = in_24;
            5'h19: out = in_25;
            5'h1a: out = in_26;
            5'h1b: out = in_27;
            5'h1c: out = in_28;
            5'h1d: out = in_29;
            5'h1e: out = in_30;
            5'h1f: out = in_31;
            default:
                out = 1'b0;
        endcase
    end
endmodule


module Branch_Unit (
  input [31:0] RS1,
  input [31:0] RS2,
  input [4:0] BrOP,
  output NextPCSrc
);
  wire BEQ;
  wire BNE;
  wire BLT;
  wire BGE;
  wire BLTU;
  wire BGEU;
  wire s0;
  wire s1;
  wire s2;
  wire s3;
  wire s4;

  // BEQ
  CompSigned #(
    .Bits(32)
  ) CompSigned_BEQ (
    .a( RS1 ),
    .b( RS2 ),
    .eq ( BEQ )
  );

  // BNE
  CompSigned #(
    .Bits(32)
  ) CompSigned_BNE (
    .a( RS1 ),
    .b( RS2 ),
    .eq ( s0 )
  );

  // BLT
  CompSigned #(
    .Bits(32)
  ) CompSigned_BLT (
    .a( RS1 ),
    .b( RS2 ),
    .lt ( BLT )
  );

  // BGE
  CompSigned #(
    .Bits(32)
  ) CompSigned_BGE (
    .a( RS1 ),
    .b( RS2 ),
    .gt ( s1 ),
    .eq ( s2 )
  );

  // BLTU
  CompUnsigned #(
    .Bits(32)
  ) CompUnsigned_BLTU (
    .a( RS1 ),
    .b( RS2 ),
    .lt ( BLTU )
  );

  // BGEU
  CompUnsigned #(
    .Bits(32)
  ) CompUnsigned_BGEU (
    .a( RS1 ),
    .b( RS2 ),
    .gt ( s3 ),
    .eq ( s4 )
  );

  assign BNE = ~s0;
  assign BGE = (s1 | s2);
  assign BGEU = (s3 | s4);

  // Selección de la condición para el salto
  Mux_32x1 Mux_32x1_Select (
    .sel( BrOP ),
    .in_0( 1'b0 ),
    .in_1( 1'b0 ),
    .in_2( 1'b0 ),
    .in_3( 1'b0 ),
    .in_4( 1'b0 ),
    .in_5( 1'b0 ),
    .in_6( 1'b0 ),
    .in_7( 1'b0 ),
    .in_8( BEQ ),
    .in_9( BNE ),
    .in_10( 1'b0 ),
    .in_11( 1'b0 ),
    .in_12( BLT ),
    .in_13( BGE ),
    .in_14( BLTU ),
    .in_15( BGEU ),
    .in_16( 1'b1 ),
    .in_17( 1'b1 ),
    .in_18( 1'b1 ),
    .in_19( 1'b1 ),
    .in_20( 1'b1 ),
    .in_21( 1'b1 ),
    .in_22( 1'b1 ),
    .in_23( 1'b1 ),
    .in_24( 1'b1 ),
    .in_25( 1'b1 ),
    .in_26( 1'b1 ),
    .in_27( 1'b1 ),
    .in_28( 1'b1 ),
    .in_29( 1'b1 ),
    .in_30( 1'b1 ),
    .in_31( 1'b1 ),
    .out( NextPCSrc )
  );
endmodule
