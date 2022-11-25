`timescale 1 ns / 100 ps
/* Testbench para o módulo responsável por decodificar o imediato de uma instrução. 
Para opcodes e instruções escolhidas aleatoriamente, exibe o imediato obtido através do "$monitor" para verificação. */
module immxTB ();
    wire [31:0] imm; // Imediato gerado
    reg [31:0] insn; // Instrução
    reg [6:0] opcodes [0:8]; // Array com todos os opcodes de instruções que possuem campo para um imediato

    integer i;
    
    // Módulo testado
    immx UUT (.insn(insn), .imm(imm));

    initial begin
        opcodes[0] = 7'b0110111; // U - LUI
        opcodes[1] = 7'b0010111; // U - AUIPC
        opcodes[2] = 7'b1101111; // J 
        opcodes[3] = 7'b1100111; // I - JARL
        opcodes[4] = 7'b0010011; // I - ALU
        opcodes[5] = 7'b0000011; // I - LOAD
        opcodes[6] = 7'b1100011; // B
        opcodes[7] = 7'b0100011; // S
        opcodes[8] = 7'b1110011; // CSR
        $monitor("insn : %b opcode: %b imm : %b", insn, insn[6:0], imm);
        for (i = 0; i < 50; i = i + 1) begin
            insn = $urandom;
            insn[6:0] = opcodes[$urandom%9];
            #10;
        end
        $display("Finished");
        $stop;
    end
    

endmodule