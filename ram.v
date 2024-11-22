module ram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5
)(
    input wire clk,
    input wire [ADDR_WIDTH-1:0] address,
    input wire [ADDR_WIDTH-1:0] address_2,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire write_enable,
    output wire [DATA_WIDTH-1:0] data_out,
    output wire [DATA_WIDTH-1:0] data_out_2
);

    reg [DATA_WIDTH-1:0] memory [0:2**ADDR_WIDTH-1];

    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] = data_in;
        end
    end

    assign data_out = memory[address];
    assign data_out_2 = memory[address_2];

endmodule