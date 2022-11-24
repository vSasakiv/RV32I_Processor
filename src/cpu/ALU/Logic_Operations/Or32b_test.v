`timescale 1ns / 100ps
/* Testbench para o módulo OR de 32bits
Para todos dois números entre 0 e 255, faz um bitwise OR deles e compara o resultado com a saída O do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module Or32b_TB ();
reg [31:0] A, B, correctO;
wire [31:0] O;
integer errors, i, j;

// task que verifica se a saída do módulo é igual ao valor esperado
task Check;
    input [31:0] xpectO;
    if (O != xpectO) begin 
        $display ("Error A: %32b, B: %32b, expected %32b, got O: %32b", A, B, xpectO, O);
        errors = errors + 1;
    end
endtask

// módulo testado
Or32b UUT (.A(A), .B(B), .O(O));

initial begin
    errors = 0;

    // Laços for que passam por todas as somas possíveis entre os números de 0 a 255
    for (i = 0; i < 256; i = i + 1)
        for (j = 0; j < 256; j = j + 1) begin
            A = i;
            B = j;
            correctO = A | B;
            #10
            Check (correctO);
        end
    $display ("Finished, got %2d errors", errors);
end

endmodule