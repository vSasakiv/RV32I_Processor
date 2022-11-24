`timescale 1ns / 100ps
/* Testbench para o módulo do somador parcial de 1 bit.
Faz todas as combinações de somas possíves com números de 1 bit e verifica se a soma S, o propagate P, e o generate G, são iguais aos da saída do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros 
Ao final, mostra a quantidade total de erros obtidos */
module PartialFullAdder1b_TB ();
reg A, B, CIN, correctS, correctP, correctG;
wire S, P, G;
integer errors, i , j;

/* task que verifica se a saída do módulo é igual ao valor esperado */
task Check; 
    input xpectS, xpectP, xpectG;
    begin 
        if (S != xpectS) begin 
            $display ("Error A: %b, B: %b, expected %b, got S: %b", A, B, xpectS, S);
            errors = errors + 1;
        end
        if (P != xpectP) begin 
            $display ("Error A: %b, B: %b, expected %b, got P: %b", A, B, xpectP, P);
            errors = errors + 1;
        end
        if (G != xpectG) begin 
            $display ("Error A: %b, B: %b, expected %b, got G: %b", A, B, xpectG, G);
            errors = errors + 1;
        end
    end
endtask

// módulo testado
PartialFullAdder1b UUT (.A(A), .B(B), .CIN(CIN), .S(S), .P(P), .G(G));

initial begin
    errors = 0;
    CIN = 1; //Parâmetro para teste: 0 para fazer A + B com carry in igual a 0, 1 para fazer o mesmo com carry igual a 1
   
    /* Laços for que passam por todas combinações possíveis de soma com números de 1bit */
    for (i = 0; i < 2; i = i + 1)
        for (j = 0; j < 2; j = j + 1) begin
            A = i;
            B = j;
            correctS = A + B + CIN; //Soma
            correctP = A | B; //Propagate
            correctG = A & B; //Generate
            #10
            $display ("A: %b, B: %b, CIN: %b correctS: %b, correctP: %b, correctG: %b ", A, B, CIN, correctS, correctP, correctG);
            Check (correctS, correctP, correctG);
        end
    $display ("Finished, got %2d errors", errors);
end 

endmodule 