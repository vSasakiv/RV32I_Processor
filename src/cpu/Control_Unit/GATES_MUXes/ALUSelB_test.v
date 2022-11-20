`timescale 1ns / 100ps
/* Testbench para o módulo que gera o sinal alu_sel_b.
Para cada valor que code pode assumir, verifica se o sinal recebido do módulo é igual ao esperado.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module ALUSelB_TB ();
reg [9:0] code;
reg correctBSel;
wire alu_sel_b;
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input xpectBSel;
    if (alu_sel_b != xpectBSel) begin 
        $display ("Error code: %10b, expected %b, got rd: %b", code, xpectBSel, alu_sel_b);
        errors = errors + 1;
    end
endtask

// módulo testado
ALUSelB UUT (.code(code), .alu_sel_b(alu_sel_b));

// Atribui todos os valores que code pode assumir, especifica o resultado correto em correctBsel e verifica se o módulo funciona para esse valor.
initial begin
    errors = 0;

    // J
    correctBSel = 1;
    code = 10'b0000000001;
    #10
    Check (correctBSel);

    // I JARL
    correctBSel = 1;
    code = 10'b0000000010;
    #10
    Check (correctBSel);

    //  U LUI
    correctBSel = 1'bx;
    code = 10'b0000000100;
    #10
    Check (correctBSel);

    //  U AUIPC
    correctBSel = 1;
    code = 10'b0000001000;
    #10
    Check (correctBSel);

    //  B
    correctBSel = 0;
    code = 10'b0000010000;
    #10
    Check (correctBSel);

    //  R
    correctBSel = 0;
    code = 10'b0000100000;
    #10
    Check (correctBSel);

    //  S
    correctBSel = 1;
    code = 10'b0001000000;
    #10
    Check (correctBSel);

    //  I ALU
    correctBSel = 1;
    code = 10'b0010000000;
    #10
    Check (correctBSel);

    //  I LOAD
    correctBSel = 1;
    code = 10'b0100000000;
    #10
    Check (correctBSel);

    //  I CSR
    correctBSel = 1'bx;
    code = 10'b1000000000;
    #10
    Check (correctBSel);

    $display ("Finished, got %2d errors", errors);
end
endmodule