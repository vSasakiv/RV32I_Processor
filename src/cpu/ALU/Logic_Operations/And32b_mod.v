/* Módulo AND de 32 bits.
Faz um bitwise AND entre dois valores de 32 bits, A e B.
Resultado vai para saída And. */
module And32b (
    input [31:0] A, B,
    output [31:0] And
);
    assign And = A & B;

endmodule 