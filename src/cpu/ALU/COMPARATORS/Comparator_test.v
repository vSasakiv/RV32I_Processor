`timescale 1ns / 100ps
/* 
Testbench para o comparador, que devolve igualdades
signed e unsigned, que roda para todos as possíveis
combinações de A e B, sendo A e B números signed em complemento de 2 
de 8 bits, já que executar este programa
para todas as combinações A e B de 32 bits é inviável
*/
module Comparator_TB ();
reg [31:0] A, B; // A, B
reg signed [31:0] As, Bs; // A e B signed
wire [31:0] S; // Subtração A - B
reg correct_u, correct_s, correct_eq; // Valor correto
wire EQ, COUT, LS, LU; // Valores entregues por módulos, igualdade, Carry out e Resultado
integer i, j, errors; // Contadores

task Check_u;
  input expect_lu;
  if (expect_lu != LU) begin
    $display("unsigned: A: %32b, B: %32b, expect: %b", A, B, LU);
  end
endtask
task Check_s; 
  input expect_ls;
  if (expect_ls != LS) begin
    $display("signed: A: %32b, B: %32b, expect: %b", A, B, LS);
  end
endtask
task Check_eq;
  input expect_eq;
  if (expect_eq != EQ) begin
    $display("equality: A: %32b, B: %32b, expect: %b", A, B, EQ);
  end
endtask

// Unidade em test: comparador completo
Comparator UUT (.A_S(A[31]), .B_S(B[31]), .S(S), .COUT(COUT), .EQ(EQ), .LS(LS), .LU(LU));
// Utilização do módulo de soma para obter a subtração
Adder32b A1 (.A(A), .B(B), .S(S), .SUB(1), .COUT(COUT));

initial begin
    errors = 0;
  
    for (i = -128; i < 128; i = i + 1) begin
      for (j = -128; j < 128; j = j + 1) begin
        A = i;
        B = j;
        As = i;
        Bs = j;
        correct_u = A < B;
        correct_s = As < Bs;
        correct_eq = A == B;
        #1
        Check_u (correct_u);
        Check_s (correct_s);
        Check_eq(correct_eq);
      end
    end
    $display ("Finished, got %2d errors", errors);
    $stop;
end

endmodule