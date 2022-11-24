`timescale 1ns / 100ps
/* 
Testbench para o comparador de desigualdade menor que, roda para todos as possíveis
combinações de A e B, sendo A e B números signed em complemento de 2 
de 8 bits, já que executar este programa
para todas as combinações A e B de 32 bits é inviável
 */
module ComparatorLTSigned_TB ();
reg signed [31:0] A, B; // A, B
wire [31:0] S; // subtração A - B
reg correct; // Valor correto
wire EQ, COUT, LESS; // Valores entregues por módulos, igualdade, Carry out e Resultado
integer i, j, errors; // Contadores

task Check;
    input xpectLESS;
    if (LESS != xpectLESS) begin 
        $display ("Error A: %32b, B: %32B, COUT: %b, xpect: %b, EQ: %b", A, B, COUT, xpectLESS, EQ);
        errors = errors + 1;
    end
endtask

// Unidade em teste: comparador de igualdade
ComparatorLTSigned UUT (.A_S(A[31]), .B_S(B[31]), .S_S(S[31]), .EQ(EQ), .R(LESS));
// Utilização do módulo de soma para obter a subtração
Adder32b A1 (.A(A), .B(B), .S(S), .SUB(1), .COUT(COUT));
// utilização do módulo de comparação igual para obter a igualdade.
ComparatorEQ E1 (.S(S), .EQ(EQ));
initial begin
    errors = 0;
  
    for (i = -128; i < 128; i = i + 1) begin
      for (j = -128; j < 128; j = j + 1) begin
        A = i;
        B = j;
        correct = A < B;
        #1
        Check (correct);
      end
    end
    $display ("Finished, got %2d errors", errors);
    $stop;
end

endmodule