`timescale 1ns / 100ps
/* Testbench para o módulo que gera o sinal rd_sel.
Para cada valor que CODE pode assumir, verifica se o sinal recebido do módulo é igual ao esperado.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module RdSel_TB ();
reg [9:0] CODE;
reg [1:0] correctRD;
wire [1:0] RD_SEL;
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [1:0] xpectRd;
    if (RD_SEL != xpectRd) begin 
        $display ("Error Code: %10b, expected %2b, got rd: %2b", CODE, xpectRd, RD_SEL);
        errors = errors + 1;
    end
endtask

// módulo testado
RdSel UUT (.CODE(CODE), .rd_sel(RD_SEL));

// Atribui todos os valores que CODE pode assumir, especifica o resultado correto em correctRD e verifica se o módulo funciona para esse valor.
initial begin
    errors = 0;

    // J
    correctRD = 2'b11;
    CODE = 10'b0000000001;
    #10
    Check (correctRD);

    // I JARL
    correctRD = 2'b11;
    CODE = 10'b0000000010;
    #10
    Check (correctRD);

    //  U LUI
    correctRD = 2'b01;
    CODE = 10'b0000000100;
    #10
    Check (correctRD);

    //  U AUIPC
    correctRD = 2'b10;
    CODE = 10'b0000001000;
    #10
    Check (correctRD);

    //  B
    correctRD = 2'bxx;
    CODE = 10'b0000010000;
    #10
    Check (correctRD);

    //  R
    correctRD = 2'b10;
    CODE = 10'b0000100000;
    #10
    Check (correctRD);

    //  S
    correctRD = 2'bxx;
    CODE = 10'b0001000000;
    #10
    Check (correctRD);

    //  I ALU
    correctRD = 2'b10;
    CODE = 10'b0010000000;
    #10
    Check (correctRD);

    //  I LOAD
    correctRD = 2'b00;
    CODE = 10'b0100000000;
    #10
    Check (correctRD);

    //  I CSR
    correctRD = 2'bxx;
    CODE = 10'b1000000000;
    #10
    Check (correctRD);

    $display ("Finished, got %2d errors", errors);
end
endmodule