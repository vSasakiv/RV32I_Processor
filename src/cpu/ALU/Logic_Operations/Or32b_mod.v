/* Módulo OR de 32 bits.
Faz um bitwise OR entre dois valores de 32 bits, A e B.
Resultado vai para saída O. */
module Or32b (
    input [31:0] A, B,
    output [31:0] O
);
    assign O = A | B;

endmodule