`timescale 1ns / 100ps
/* Testbench para o módulo XOR de 32bits
Para todos dois números entre 0 e 255, faz um bitwise XOR deles e compara o resultado com a saída X do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module Xor32b_TB ();
reg [31:0] A, B, correctXor;
wire [31:0] Xor;
integer errors, i, j;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [31:0] xpectXor;
    if (Xor != xpectXor) begin 
        $display ("Error A: %32b, B: %32b, expected %32b, got X: %32b", A, B, xpectXor, Xor);
        errors = errors + 1;
    end
endtask

// módulo testado
Xor32b UUT (.A(A), .B(B), .Xor(Xor));


initial begin
    errors = 0;
    
    // Laços for que passam por todas as somas possíveis entre os números de 0 a 255
    for (i = 0; i < 256; i = i + 1)
        for (j = 0; j < 256; j = j + 1) begin
            A = i;
            B = j;
            correctXor = A ^ B;
            #10
            Check (correctXor);
        end
    $display ("Finished, got %2d errors", errors);
end

endmodule