`timescale  1ns / 100ps

/* Testbench para o módulo do somador de 32 bits Adder32B.
Performa todas as somas com os números de 0 a 255 e compara os resultados da soma S e do COUT com os obtidos no módulo.
Caso algum resultado seja diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem de erros.  
Ao final, mostra a quantidade total de erros obtidos */
module Adder32b_TB ();
reg [31:0] A, B, correctS;
reg [32:0] Sum; // Variável responsável por armazenar a soma A + B ou A + (-B)
reg SUB, correctCOUT;
wire [31:0] S;
wire COUT;
integer i, j, errors; 

// task que verifica se a saída do módulo é igual ao valor esperado*/
task Check; 
    input [31:0] xpectS;
    input xpectCOUT; 
    begin 
        if (S != xpectS) begin 
            $display ("Error A: %32b, B: %32b, expected %32b, got S: %32b", A, B, xpectS, S);
            errors = errors + 1;
        end
        if (COUT != xpectCOUT) begin
             $display ("Error A: %32b, B: %32b, expected %b, got COUT: %b", A, B, xpectCOUT, COUT);
            errors = errors + 1;
        end
    end
endtask

// módulo testado
Adder32b UUT (.A(A), .B(B), .SUB(SUB), .S(S), .COUT(COUT));

initial begin
    errors = 0;
    SUB = 1; //Parâmetro para teste: 0 para fazer A + B, 1 para A + (-B)

    // Laços for que passam por todas as somas possíveis entre os números de 0 a 255
    for (i = 0; i < 256; i = i + 1)
        for (j = 0; j < 256; j = j + 1) begin
            A = i;
            B = j;
            if (SUB == 0)
                Sum = A + B;
            else 
                Sum = A + (B ^ {(32){1'b1}}) + 1;  // Caso SUB = 1, faz o 2's complement em B
            correctS = Sum[31:0];
            correctCOUT = Sum[32]; // posição do carry out
            #10
            Check (correctS, correctCOUT);
        end
    $display ("Finished, got %2d errors", errors);
end

endmodule