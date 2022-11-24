/* Módulo "gate" responsável por gerar o sinal func 
Força a saída ser 000 caso code seja um entre: 0000000001, 0000000010, 0000001000, 0000010000, 0001000000, 0100000000.
Caso contrário, apenas transmite direto o sinal recebido da instrução insn */
module funcMux (
    code, insn, func
);
    input [2:0] insn; // Instrução
    input [9:0] code; // Código gerado pelo OPDecoder
    output [2:0] func; // Sinal func gerado

    and U0 (func[0], insn[0], ~code[0], ~code[1], ~code[3], ~code[6], ~code[8], ~code[4]);
    and U1 (func[1], insn[1], ~code[0], ~code[1], ~code[3], ~code[6], ~code[8], ~code[4]);
    and U2 (func[2], insn[2], ~code[0], ~code[1], ~code[3], ~code[6], ~code[8], ~code[4]);

endmodule