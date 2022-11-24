`timescale 1ns / 100ps
/* Testbench para o módulo AND de 32bits
Para todos dois números entre 0 e 255, faz um bitwise AND deles e compara o resultado com a saída And do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module And32b_TB ();
reg [31:0] A, B, correctAnd;
wire [31:0] And;
integer errors, i, j;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [31:0] xpectAnd;
    if (And != xpectAnd) begin 
        $display ("Error A: %32b, B: %32b, expected %32b, got And: %32b", A, B, xpectAnd, And);
        errors = errors + 1;
    end
endtask

// módulo testado
And32b UUT (.A(A), .B(B), .And(And));


initial begin
    errors = 0;
    
    // Laços for que passam por todas as somas possíveis entre os números de 0 a 255
    for (i = 0; i < 256; i = i + 1)
        for (j = 0; j < 256; j = j + 1) begin
            A = i;
            B = j;
            correctAnd = A & B;
            #10
            Check (correctAnd);
        end
    $display ("Finished, got %2d errors", errors);
end

endmodule