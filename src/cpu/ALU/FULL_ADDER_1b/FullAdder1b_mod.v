/* Módulo do somador completo de 1 bit.
Recebe A, B, e um carry in CIN e faz a saída S ser a soma A + B + Cin, sendo COUT o carry out dela.*/
module FullAdder1b (
    input A, B, CIN,
    output S, COUT
);
wire W1, W2, W3;

    xor U1 (W1, A, B);
    xor U2 (S, W1, CIN);
    and U3 (W2, A, B);
    and U4 (W3, W1, CIN);
    or U5 (COUT, W2, W3);

endmodule