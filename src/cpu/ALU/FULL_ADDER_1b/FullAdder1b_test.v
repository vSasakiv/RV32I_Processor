`timescale 1ns / 100ps

/* Testbench que testa o módulo do somador completo de 1 bit.
Faz todas as combinações de somas possíves com números de 1 bit e verifica se a soma S e o carry out COUT são iguais aos da saída do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem de erros.
Ao final, mostra a quantidade total de erros obtidos */
module FullAdder1b_tb ();
reg A, B, CIN, correctCOUT, correctS;
reg [1:0] Sum;
wire COUT, S;
integer i, j, errors; 

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input xpectCOUT, xpectS;

    begin
    if (S != xpectS) begin 
        $display ("Error A: %b, B: %b, expected %b, got S: %b", A, B, xpectS, S);
        errors = errors + 1;
    end
    if (COUT != xpectCOUT) begin 
        $display ("Error A: %b, B: %b, expected %b, got COUT: %b", A, B, xpectCOUT, S);
        errors = errors + 1;
    end
end
endtask

// módulo testado
FullAdder1b UUT (.A(A), .B(B), .CIN(CIN), .S(S), .COUT(COUT));


initial begin
    errors = 0;
    CIN = 1; // Parâmetro para teste: 0 para fazer A + B com carry in igual a 0, 1 para fazer o mesmo com carry igual a 1

    // Laços for que passam por todas combinações possíveis de soma com números de 1bit
    for (i = 0; i < 2; i = i + 1)
        for (j = 0; j < 2; j = j + 1) begin
            A = i;
            B = j;
            Sum = A + B + CIN;
            correctS = Sum[0];
            correctCOUT = Sum[1]; // posição do carry out
            #10
            $display ("A: %b, B: %b, CIN: %b correct S: %b, correct COUT: %b", A, B, CIN, correctS, correctCOUT);
            Check (correctCOUT, correctS);
        end
    $display ("Finished, got %2d errors", errors);
end

endmodule