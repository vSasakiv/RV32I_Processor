/* Módulo "gate responsável por gerar o sinal FUNC3 
Força a saída ser 000 caso CODE seja um entre: 0000000001, 0000000010, 0000001000, 0000010000, 0001000000, 0100000000.
Caso contrário, apenas transmite direto o sinal recebido da instrução INSN */
module Func3Mux (
    CODE, INSN, FUNC3
);
    input [2:0] INSN;
    input [9:0] CODE;
    output [2:0] FUNC3;

    and U0 (FUNC3[0], INSN[0], ~CODE[0], ~CODE[1], ~CODE[3], ~CODE[6], ~CODE[8], ~CODE[4]);
    and U1 (FUNC3[1], INSN[1], ~CODE[0], ~CODE[1], ~CODE[3], ~CODE[6], ~CODE[8], ~CODE[4]);
    and U2 (FUNC3[2], INSN[2], ~CODE[0], ~CODE[1], ~CODE[3], ~CODE[6], ~CODE[8], ~CODE[4]);

endmodule