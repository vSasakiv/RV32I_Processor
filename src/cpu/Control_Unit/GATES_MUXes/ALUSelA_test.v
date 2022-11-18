`timescale 1ns / 100ps
/* Testbench para o módulo que gera o sinal alu_sel_B.
Para cada valor que CODE pode assumir, verifica se o sinal recebido do módulo é igual ao esperado.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module ALUSelA_TB ();
reg [9:0] CODE;
reg correctASel;
wire alu_sel_A;
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input xpectASel;
    if (alu_sel_A != xpectASel) begin 
        $display ("Error Code: %10b, expected %b, got rd: %b", CODE, xpectASel, alu_sel_A);
        errors = errors + 1;
    end
endtask

// módulo testado
ALUSelA UUT (.CODE(CODE), .alu_sel_A(alu_sel_A));

// Atribui todos os valores que CODE pode assumir, especifica o resultado correto em correctAsel e verifica se o módulo funciona para esse valor.
initial begin
    errors = 0;

    // J
    correctASel = 1;
    CODE = 10'b0000000001;
    #10
    Check (correctASel);

    // I JARL
    correctASel = 0;
    CODE = 10'b0000000010;
    #10
    Check (correctASel);

    //  U LUI
    correctASel = 1'bx;
    CODE = 10'b0000000100;
    #10
    Check (correctASel);

    //  U AUIPC
    correctASel = 1;
    CODE = 10'b0000001000;
    #10
    Check (correctASel);

    //  B
    correctASel = 0;
    CODE = 10'b0000010000;
    #10
    Check (correctASel);

    //  R
    correctASel = 0;
    CODE = 10'b0000100000;
    #10
    Check (correctASel);

    //  S
    correctASel = 0;
    CODE = 10'b0001000000;
    #10
    Check (correctASel);

    //  I ALU
    correctASel = 0;
    CODE = 10'b0010000000;
    #10
    Check (correctASel);

    //  I LOAD
    correctASel = 0;
    CODE = 10'b0100000000;
    #10
    Check (correctASel);

    //  I CSR
    correctASel = 1'bx;
    CODE = 10'b1000000000;
    #10
    Check (correctASel);

    $display ("Finished, got %2d errors", errors);
end
endmodule