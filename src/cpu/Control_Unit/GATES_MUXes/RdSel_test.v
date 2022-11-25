`timescale 1ns / 100ps
/* Testbench para o módulo que gera o sinal rd_sel.
Para cada valor que code pode assumir, verifica se o sinal recebido do módulo é igual ao esperado.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module RdSel_TB ();
reg [9:0] code;
reg [1:0] correctRD;
wire [1:0] rd_sel;
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [1:0] xpectRd;
    if (rd_sel != xpectRd) begin 
        $display ("Error code: %10b, expected %2b, got rd: %2b", code, xpectRd, rd_sel);
        errors = errors + 1;
    end
endtask

// módulo testado
RdSel UUT (.code(code), .rd_sel(rd_sel));

// Atribui todos os valores que code pode assumir, especifica o resultado correto em correctRD e verifica se o módulo funciona para esse valor.
initial begin
    errors = 0;

    // J
    correctRD = 2'b11;
    code = 10'b0000000001;
    #10
    Check (correctRD);

    // I JARL
    correctRD = 2'b11;
    code = 10'b0000000010;
    #10
    Check (correctRD);

    //  U LUI
    correctRD = 2'b01;
    code = 10'b0000000100;
    #10
    Check (correctRD);

    //  U AUIPC
    correctRD = 2'b10;
    code = 10'b0000001000;
    #10
    Check (correctRD);

    //  B
    correctRD = 2'bxx;
    code = 10'b0000010000;
    #10
    Check (correctRD);

    //  R
    correctRD = 2'b10;
    code = 10'b0000100000;
    #10
    Check (correctRD);

    //  S
    correctRD = 2'bxx;
    code = 10'b0001000000;
    #10
    Check (correctRD);

    //  I ALU
    correctRD = 2'b10;
    code = 10'b0010000000;
    #10
    Check (correctRD);

    //  I LOAD
    correctRD = 2'b00;
    code = 10'b0100000000;
    #10
    Check (correctRD);

    //  I CSR
    correctRD = 2'bxx;
    code = 10'b1000000000;
    #10
    Check (correctRD);

    $display ("Finished, got %2d errors", errors);
end
endmodule