`timescale 1ns / 100ps
/* Testbench para o módulo "gate" do sinal FUNC3.
Testa, para cada valor possível de CODE, se o valor recebido é igual ao valor de FUNC esperado. 
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module Func3Mux_TB ();
reg [2:0] INSN, correctFUNC;
reg [9:0] CODE;
wire [2:0] FUNC3;
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [2:0] xpectFUNC;
    if (FUNC3 !== xpectFUNC) begin 
        $display ("Error INSN: %3b,, CODE: %10b expected %3b, got FUNC: %3b", INSN, CODE, xpectFUNC, FUNC3);
        errors = errors + 1;
    end
endtask

// módulo testado
Func3Mux UUT (.INSN(INSN), .CODE(CODE), .FUNC3(FUNC3));

// Atribui todos os valores possíveis ao CODE, especifica o resultado correto e verifica se o módulo funciona para esse valor.
initial begin 
    errors = 0;
    INSN = 3'bxxx; // Valor arbitrário 
    
    // J
    correctFUNC = 000;
    CODE = 10'b0000000001;
    #10
    Check (correctFUNC);

    // I JARL
    correctFUNC = 000;
    CODE = 10'b0000000010;
    #10
    Check (correctFUNC);

    //  U LUI
    correctFUNC = INSN;
    CODE = 10'b0000000100;
    #10
    Check (correctFUNC);

    //  U AUIPC
    correctFUNC = 000;
    CODE = 10'b0000001000;
    #10
    Check (correctFUNC);

    //  B
    correctFUNC = 000;
    CODE = 10'b0000010000;
    #10
    Check (correctFUNC);

    //  R
    correctFUNC = INSN;
    CODE = 10'b0000100000;
    #10
    Check (correctFUNC);

    //  S
    correctFUNC = 000;
    CODE = 10'b0001000000;
    #10
    Check (correctFUNC);

    //  I ALU
    correctFUNC = INSN;
    CODE = 10'b0010000000;
    #10
    Check (correctFUNC);

    //  I LOAD
    correctFUNC = 000;
    CODE = 10'b0100000000;
    #10
    Check (correctFUNC);

    //  I CSR
    correctFUNC = INSN;
    CODE = 10'b1000000000;
    #10
    Check (correctFUNC);

    $display ("Finished, got %2d errors", errors);
end

endmodule