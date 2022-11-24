/* Partial Adder, recebe dois números de 1 bit, A e B, e um carry in CIN.
Suas saídas são:
S - Soma (A ^ B ^ CIN)
P - Propagate, verifica se A e B propagam um carry. 1 caso propaga, 0 caso contrário. (A | N) 
G - Generate, verifica se A e B geram um carry. 1 caso gere, 0 caso contrário (A & B) */
module PartialFullAdder1b (
    input A, B, CIN,
    output S, P, G
);
wire W1;

    xor U1 (W1, A, B);
    xor U2 (S, W1, CIN);
    or U3 (P, A, B);
    and U4 (G, A, B);

endmodule