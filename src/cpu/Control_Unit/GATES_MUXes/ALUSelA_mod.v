/* Módulo responsável por gerar o sinal alu_sel_a a partir do código code
code = 10'b0000000001, gera sinal: 1 // Instrução tipo J 
code = 10'b0000000010, gera sinal: 0 // Instrução tipo I (Jarl)
code = 10'b0000000100, gera sinal: x // Instrução tipo U (LUI)
code = 10'b0000001000, gera sinal: 1 // Instrução tipo U (AUIPC)
code = 10'b0000010000, gera sinal: 0 // Instrução tipo B
code = 10'b0000100000, gera sinal: 0 // Instrução tipo R
code = 10'b0001000000, gera sinal: 0 // Instrução tipo S
code = 10'b0010000000, gera sinal: 0 // Instrução tipo I (ALU)
code = 10'b0100000000, gera sinal: 0 // Instrução tipo I (LOAD)

* code = 10'b1000000000, gera sinal: 1 ou 0 // Instrução tipo I (CSR)
Para o último code, referente as instruções CSR, o valor de alu_sel_a deve ser 0 caso a instrução seja um ecall e 1 caso seja um ebreak

Tabela verdade do circuito (função em mintermos com A sendo msb e J lsb):

    0000000001  1 (~A&~B&~C&~D&~E&~F&~G&~H&~I&J)
    0000000010  0 
    0000000100  x 
    0000001000  1 (~A&~B&~C&~D&~E&~F&G&~H&~I&~J)
    0000010000  0
    0000100000  0
    0001000000  0
    0010000000  0
    0100000000  0 

    * 1000000000  0 ou 1

Função = (~A&~B&~C&~D&~E&~F&~G&~H&~I&J)|(~A&~B&~C&~D&~E&~F&G&~H&~I&~J) */
module ALUSelA (code, alu_sel_a, insn);
input [9:0] code;
input [31:0] insn;
output alu_sel_a;
wire W1;

    // Assign com expressão derivada da função
    assign W1 = (~code[9] & ~code[8] & ~code[7] & ~code[6] & ~code[5] & ~code[4] & ~code[3] & ~code[2] & ~code[1] & code[0]) | (~code[9] & ~code[8] & ~code[7] & ~code[6] & ~code[5] & ~code[4] & code[3] & ~code[2] & ~code[1] & ~code[0]) ;
    
    /* Se a função acima de devolveu 1, apenas passar o sinal
    Caso contrário, devolver 0 para todos os codes != 1000000000 e 1 somente quando o bit 20 de insn for 1 (diferenciador entre ecall e ebreak) */
    assign alu_sel_a = W1 | (code[9] & insn[20]);

endmodule