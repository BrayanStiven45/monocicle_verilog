module decimalToAscii #(
    parameter size_binary = 4,
    parameter size_decimal = 8,
)
(
    input [(size_binary - 1):0] in,
    input [(size_decimal - 1):0] col,
    output reg [7:0] out
);

    reg [7:0] ascii [(size_decimal-1):0]; // es el arreglo que guardo los valores ascii de cada digito del decimal
    reg [3:0] decimal [(size_decimal-1):0]; // es el arreglo que guardo los valores decimales de cada digito del decimal
    reg [(size_binary - 1):0] in_apo;

    initial begin
        // se inicializa el vector ascii con espacios
        for(int i = 0; i < size_decimal; i = i + 1) begin
            ascii[i] = 8'h20;
            decimal[i] = 4'd0;
        end
    end

    always @(*) begin
        
        // Se toma cada digito del decimal 
        in_apo = in;
        for(int i = 0; i < size_decimal; i = i + 1) begin
            ascii[i] = (in_apo % 10) + 8'd48;
            in_apo = in_apo / 10;
        end

        // se convierte el valor decimal a ascii
    end

    always @(*) begin
        out = ascii[col];
    end
endmodule