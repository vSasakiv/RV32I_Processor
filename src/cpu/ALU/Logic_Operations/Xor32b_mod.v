/* Módulo XOR de 32 bits.
Faz um bitwise XOR entre dois valores de 32 bits, A e B.
Resultado vai para saída X. */
module Xor32b (
    input [31:0] A, B,
    output [31:0] X
);
    assign X = A ^ B;

endmodule 