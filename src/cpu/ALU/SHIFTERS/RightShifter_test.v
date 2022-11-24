`timescale 1ns / 100ps
/* Testbench para o módulo de Right Logical/Arithmetic Shift
Shifta um valor A para direita B = i vezes, com i = {0, 1, ... , 32}, e compara o resultado com a saida do módulo.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module RightShifter_TB ();
reg signed [31:0] A, B, correct;
wire signed [31:0] C;
integer errors, i;
reg S; 

// task que verifica se a saída do módulo é igual ao valor esperado 
task Check;
    input [31:0] xpect;
    if (C != xpect) begin
        $display ("Error A: %32b, B: %5b, got %32b", A, B, C);
        errors = errors + 1;
    end
endtask

// módulo testado
RightShifter UUT (.A(A), .B(B), .SRA(S), .Shifted(C));

initial begin
    errors = 0;
    S = 1'b0; // Parâmetro, 0 se é logical shift, 1 se é arithmetic shift
    A = {1'b1, 31'b0}; // Parâmetro, valor que será shiftado para a direita

    // Laços for que passa por todos os valores de i em que é necessário dar shift 
    for (i = 0; i < 32; i = i +1) begin
        B = i;
        if (S == 0)
            correct = A >> i;
        else 
            correct = A >>> i;
        #10 
        $display ("A: %32b, B: %5b", A, B);
        $display ("correct: %32b, C: %32b", correct, C);
        Check (correct);
    end
    $display ("Finished, got %2d errors", errors);
end

endmodule