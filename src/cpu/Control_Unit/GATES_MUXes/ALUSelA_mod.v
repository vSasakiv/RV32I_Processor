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
code = 10'b1000000000, gera sinal: x // Instrução tipo I (CSR)

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
    1000000000  1 (A&~B&~C&~D&~E&~F&~G&~H&~I&~J) 
Função = (~A&~B&~C&~D&~E&~F&~G&~H&~I&J)|(~A&~B&~C&~D&~E&~F&G&~H&~I&~J) | (A&~B&~C&~D&~E&~F&~G&~H&~I&~J) */
module ALUSelA (code, alu_sel_a);
input [9:0] code;
output alu_sel_a;

    // Assign com expressão derivada da função
    assign alu_sel_a = (~code[9] & ~code[8] & ~code[7] & ~code[6] & ~code[5] & ~code[4] & ~code[3] & ~code[2] & ~code[1] & code[0]) | (~code[9] & ~code[8] & ~code[7] & ~code[6] & ~code[5] & ~code[4] & code[3] & ~code[2] & ~code[1] & ~code[0]) | (code[9] & ~code[8] & ~code[7] & ~code[6] & ~code[5] & ~code[4] & ~code[3] & ~code[2] & ~code[1] & ~code[0]) ;

endmodule