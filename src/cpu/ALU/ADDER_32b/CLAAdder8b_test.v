`timescale 1ns / 100ps

/* Testbench que testa o módulo do somador Carry Look-Ahead de 8 bits.
Faz todas as somas possíves com os números de 0 a 255 e verifica se a soma S e o carry out COUT são iguais aos da saída do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros 
Ao final, mostra a quantidade total de erros obtidos */
module CLAAdder8b_TB ();
reg [7:0] A, B, correctS;
reg [8:0] Sum; // Variável responsável por armazenar a soma A + B 
reg CIN, correctCOUT;
wire COUT;
wire [7:0] S;
integer errors, i , j;

// task que verifica se a saída do módulo é igual ao valor esperado 
task Check;
    input [7:0] xpectS;
    input xpectCOUT;
    begin
    if (S != xpectS) begin 
        $display ("Error A: %8b, B: %8b, expected %8b, got S: %8b", A, B, xpectS, S);
        errors = errors + 1;
    end
    if (COUT != xpectCOUT) begin 
        $display ("Error A: %8b, B: %8b, expected %b, got COUT: %b", A, B, xpectCOUT, COUT);
        errors = errors + 1;
    end
    end
endtask

// módulo testado
CLAAdder8b UUT (.A(A), .B(B), .CIN(CIN), .S(S), .COUT(COUT));

initial begin 
    errors = 0;
    CIN = 1; // Parâmetro para teste: 0 para fazer A + B com carry in igual a 0; 1 para fazer o mesmo com carry igual a 1

    // Laços for que passam por todas as somas possíveis entre os números de 0 a 255 
    for (i = 0; i < 256; i = i + 1)
        for (j = 0; j < 256; j = j + 1) begin
            A = i;
            B = j;
            Sum = A + B + CIN;
            correctS = Sum[7:0]; 
            correctCOUT = S[8]; // posição do carry out
            #10;
            Check (correctS, correctCOUT);
        end
    $display ("Finished, got %2d errors", errors);
end


endmodule