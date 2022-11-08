/* Módulo responsável por gerar o sinal alu_sel_B a partir do código CODE
Code = 10'b0000000001, gera sinal: 1 // Instrução tipo J 
Code = 10'b0000000010, gera sinal: 1 // Instrução tipo I (Jarl)
Code = 10'b0000000100, gera sinal: x // Instrução tipo U (LUI)
Code = 10'b0000001000, gera sinal: 1 // Instrução tipo U (AUIPC)
Code = 10'b0000010000, gera sinal: 0 // Instrução tipo B
Code = 10'b0000100000, gera sinal: 0 // Instrução tipo R
Code = 10'b0001000000, gera sinal: 1 // Instrução tipo S
Code = 10'b0010000000, gera sinal: 1 // Instrução tipo I (ALU)
Code = 10'b0100000000, gera sinal: 1 // Instrução tipo I (LOAD)
Code = 10'b1000000000, gera sinal: x // Instrução tipo I (CSR)

Tabela verdade do circuito (função em maxtermos com A sendo msb e J lsb):

    0000000001  1 
    0000000010  1 
    0000000100  x 
    0000001000  1 
    0000010000  0 (A|B|C|D|E|~F|G|H|I|J)
    0000100000  0 (A|B|C|D|~E|F|G|H|I|J)
    0001000000  1
    0010000000  1
    0100000000  1 
    1000000000  x
Função = (A|B|C|D|~E|F|G|H|I|J) & (A|B|C|D|E|~F|G|H|I|J)
*/
module ALUSelB (CODE, alu_sel_B);
input [9:0] CODE;
output alu_sel_B;

    // Assign com expressão derivada da função
    assign alu_sel_B = (CODE[9]|CODE[8]|CODE[7]|CODE[6]|CODE[5]|~CODE[4]|CODE[3]|CODE[2]|CODE[1]|CODE[0]) & (CODE[9]|CODE[8]|CODE[7]|CODE[6]|~CODE[5]|CODE[4]|CODE[3]|CODE[2]|CODE[1]|CODE[0]);

endmodule
