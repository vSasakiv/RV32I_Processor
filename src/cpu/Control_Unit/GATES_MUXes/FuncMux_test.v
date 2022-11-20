`timescale 1ns / 100ps
/* Testbench para o módulo "gate" do sinal func.
Testa, para cada valor possível de code, se o valor recebido é igual ao valor de FUNC esperado. 
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module funcMux_TB ();
reg [2:0] insn, correctFUNC;
reg [9:0] code;
wire [2:0] func;
integer errors;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [2:0] xpectFUNC;
    if (func !== xpectFUNC) begin 
        $display ("Error insn: %3b,, code: %10b expected %3b, got FUNC: %3b", insn, code, xpectFUNC, func);
        errors = errors + 1;
    end
endtask

// módulo testado
funcMux UUT (.insn(insn), .code(code), .func(func));

// Atribui todos os valores possíveis ao code, especifica o resultado correto e verifica se o módulo funciona para esse valor.
initial begin 
    errors = 0;
    insn = 3'bxxx; // Valor arbitrário 
    
    // J
    correctFUNC = 000;
    code = 10'b0000000001;
    #10
    Check (correctFUNC);

    // I JARL
    correctFUNC = 000;
    code = 10'b0000000010;
    #10
    Check (correctFUNC);

    //  U LUI
    correctFUNC = insn;
    code = 10'b0000000100;
    #10
    Check (correctFUNC);

    //  U AUIPC
    correctFUNC = 000;
    code = 10'b0000001000;
    #10
    Check (correctFUNC);

    //  B
    correctFUNC = 000;
    code = 10'b0000010000;
    #10
    Check (correctFUNC);

    //  R
    correctFUNC = insn;
    code = 10'b0000100000;
    #10
    Check (correctFUNC);

    //  S
    correctFUNC = 000;
    code = 10'b0001000000;
    #10
    Check (correctFUNC);

    //  I ALU
    correctFUNC = insn;
    code = 10'b0010000000;
    #10
    Check (correctFUNC);

    //  I LOAD
    correctFUNC = 000;
    code = 10'b0100000000;
    #10
    Check (correctFUNC);

    //  I CSR
    correctFUNC = insn;
    code = 10'b1000000000;
    #10
    Check (correctFUNC);

    $display ("Finished, got %2d errors", errors);
end

endmodule