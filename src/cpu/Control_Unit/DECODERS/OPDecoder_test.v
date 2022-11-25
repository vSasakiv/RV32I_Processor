`timescale 1ns / 100ps
/* Testbench para o módulo decodificador do OPCODE da instrução insn.
Testa, para cada valor de OPCODE que INSN pode ter, se o valor gerado pelo decodificador é igual ao esperado. 
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module OPDecoder_TB ();
reg [31:0] insn; // Instrução recebida, com OPCODE nos 7 LSB
reg [9:0] correctCODE;
wire [9:0] code; // Palavra gerada pelo decodificador
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [9:0] xpectCODE;
    begin 
    if (code !== xpectCODE) begin 
        $display ("Error insn: %7b, expected %10b, got code: %10b", insn, xpectCODE, code);
        errors = errors + 1;
    end
    end
endtask

// módulo testado
OPDecoder UUT (.insn(insn), .code(code));

// Atribui todos os valores possíveis de OPCODE ao insn, especifica o resultado correto e verifica se o módulo funciona para esse valor.
initial begin 
    errors = 0;
    
    insn = 7'b1101111; // J
    correctCODE = 10'b0000000001;
    #10
    Check (correctCODE);

    insn = 7'b1100111; // I JARL
    correctCODE = 10'b0000000010;
    #10
    Check (correctCODE);

    insn = 7'b0110111; //  U LUI
    correctCODE = 10'b0000000100;
    #10
    Check (correctCODE);

    insn = 7'b0010111; //  U AUIPC
    correctCODE = 10'b0000001000;
    #10
    Check (correctCODE);

    insn = 7'b1100011; //  B
    correctCODE = 10'b0000010000;
    #10
    Check (correctCODE);

    insn = 7'b0110011; //  R
    correctCODE = 10'b0000100000;
    #10
    Check (correctCODE);

    insn = 7'b0100011; //  S
    correctCODE = 10'b0001000000;
    #10
    Check (correctCODE);

    insn = 7'b0010011; //  I ALU
    correctCODE = 10'b0010000000;
    #10
    Check (correctCODE);

    insn = 7'b0000011; //  I LOAD
    correctCODE = 10'b0100000000;
    #10
    Check (correctCODE);

    insn = 7'b1110011; //  I CSR
    correctCODE = 10'b1000000000;
    #10
    Check (correctCODE);

    $display ("Finished, got %2d errors", errors);
end

endmodule