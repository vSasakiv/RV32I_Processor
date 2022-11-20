/* Módulo responsável por decodificar o OPCODE contido nos 7 LSB da instrução INSN.
Para cada OPCODE, faz a saída ser um código binário, conforme a seguir:
            OPCODE: 1101111 --> Code = 10'b0000000001; // Instrução tipo J 
            OPCODE: 1100111 --> Code = 10'b0000000010; // Instrução tipo I (Jarl)
            OPCODE: 0110111 --> Code = 10'b0000000100; // Instrução tipo U (LUI)
            OPCODE: 0010111 --> Code = 10'b0000001000; // Instrução tipo U (AUIPC)
            OPCODE: 1100011 --> Code = 10'b0000010000; // Instrução tipo B
            OPCODE: 0110011 --> Code = 10'b0000100000; // Instrução tipo R
            OPCODE: 0100011 --> Code = 10'b0001000000; // Instrução tipo S
            OPCODE: 0010011 --> Code = 10'b0010000000; // Instrução tipo I (ALU)
            OPCODE: 0000011 --> Code = 10'b0100000000; // Instrução tipo I (LOAD)
            OPCODE: 1110011 --> code = 10'b1000000000; // Instrução tipo I (CSR)

O "algoritmo" de decodificação é descrito abaixo:
    cada saída de Code é gerada por uma porta AND.
    O processo foi feito identificando os OPCODE em grupos com certos padrões. 
    Quando um OPCODE é identificado em um grupo, todos os AND de saída dos OPCODE do outro grupo recebem 0, e portanto geram 0.
    Ao final, sobrará somente um grupo com um OPCODE, o qual gerará o sinal 1 (com os demais gerando 0).

    1. Primeiramente, os OPCODE são separados em dois grupos: os que o AND dos 3 LSB resulta em 1 e o que resultada em 0 (Unidade U0).
    Grupo 1 (resulta em 1): 1101111, 1100111, 0110111 e 0010111.
    Grupo 2 (resulta em 0): 1100011, 0110011, 0100011, 0010011, 0000011 e 1110011.

    2. Após isso, eles são separados em outros dois grupos: os que o XOR entre os bit 6,5 e 3 de INSN resultam em 1 e os que resultam em 0 (Unidade U1).
    Grupo 1 (resulta em 1): 1101111, 0110111, 0110011, 0100011.
    Grupo 2 (resulta em 0): 1100111, 0010111, 1100011, 0010011, 0000011, 1110011.

    3. Seguindo, são separados em mais dois grupos: os que o AND entre os bits 6 e 5 de INSN resultam em 1 e os que resulta em 0 (Unidade U2);
    Grupo 1 (resulta em 1): 1101111, 1100111, 1100011, 1110011,
    Grupo 2 (resulta em 0): 0110111, 0110011, 0100011, 0010111, 0010011, 0000011.

    4. Por fim, separados nos grupos: os que o bit 4 de INSN é 1 e os que é 0.
    Grupo 1 (é 1): 1110011, 0110111, 0110011, 0010111, 0010011.
    Grupo 2 (é 0): 1101111, 1100111, 1100011, 0100011, 0000011.

    Exemplo:
    OPCODE: 1110011 - Instrução tipo I (CSR)
    1. Entra no grupo 2. Grupo atual: 1100011, 0110011, 0100011, 0010011, 0000011 e 1110011.
    2. Se enquadra no grupo 2. Grupo atual: 1100011,  0010011, 0000011, 1110011.
    3. Se enquadra no grupo 1. Grupo atual:  1100011, 1110011.
    4. Se enquadra no grupo 1. Grupo atual: 1110011.
    Assim, como toda vez que um opcode "entra em grupo" os AND de saída dos OPCODE de outros grupos geram 0, temos que o único que gerará 1 será o AND de saída do OPCODE da instrução tipo I (CSR).
*/
module OPDecoder (
    input [31:0] insn,
    output [9:0] code
);
wire WU0, WU1, WU2;

    // AND de saída de cada instrução. gera 1 somente se o OPCODE de insn for o da respectiva instrução.
    and A0 (code[0], WU0, WU1, ~insn[4]); // 1101111 J
    and A1 (code[1], WU0, ~WU1, ~insn[4]); // 1100111 I JARL
    and A2 (code[2], WU0, WU1, insn[4]); // 0110111 U LUI 
    and A3 (code[3], WU0, ~WU1, insn[4]); // 0010111 U AUIPC
    and A4 (code[4], ~WU0, ~WU1, ~insn[4], WU2); // 1100011 B
    and A5 (code[5], ~WU0, WU1, insn[4]); // 0110011 R
    and A6 (code[6], ~WU0, WU1, ~insn[4]); // 0100011 S
    and A7 (code[7], ~WU0, ~WU1, insn[4], ~WU2); // 0010011 I ALU
    and A8 (code[8], ~WU0, ~WU1, ~insn[4], ~WU2); // 0000011 I LOAD
    and A9 (code[9], ~WU0, ~WU1, insn[4], WU2); // 1110011 I CSR

    //Unidade 0. AND dos 3 LSB de insn
    and U0 (WU0, insn[0], insn[1], insn[2]);

    //Unidade 1. Xor dos bits 6,5 e 3 do insn
    xor U1 (WU1, insn[6], insn[5], insn[3]);

    //Unidade 2. And dos bits 6 e 5 do insn
    and U2 (WU2, insn[6], insn[5]);

endmodule
            