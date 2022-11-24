`timescale  1ns / 100ps
/* Testbench para o módulo da Unidade Lógica Aritmética - ALU
Para dois números de 32 bits, A e B (parâmetros arbitrários), performa todas as operações lógicas e aritméticas,
passando por todos os valores de FUNC, tanto para sub_sra = 0 ou sub_sra = 1.
Caso algum resultado seja diferente do esperado ("xpect"), mostra os valores obtidos na saída e aumenta a contagem de erros.  
Ao final, mostra a quantidade total de erros obtidos */
module ALU_TB ();
reg [31:0] A, B; // Entradas A e B da ALU unsigned
reg signed [31:0] As, Bs; // Entradas A e B signed
reg [2:0] FUNC; // Selector de função
reg sub_sra; // Seletor de subtração ou shift aritmético
reg [31:0] correct; // reg para expressar o valor correto
reg correctEQ, correctLU, correctLS; // expressa os valores corretos para as comparações
wire [31:0] S; // net que contém o resultado entregue pela ALU
wire EQ, LU, LS; // nets que contém os sinais de comparação
integer errors, i, j; // contadores e variáveis de suporte

// Task para conferir se os valores estão realmente corretos
// retornando feedback útil
task Check;
    input [31:0] xpectS;
    input xpectEQ, xpectLU, xpectLS;
    begin 
        if (S != xpectS) begin 
            $display ("Error A: %32b, B: %32b, expected %32b, got S: %32b, FUNC: %3b", A, B, xpectS, S, FUNC);
            errors = errors + 1; 
            end
        if (EQ != xpectEQ) begin 
            $display ("Error A: %32b, B: %32b, expectedEQ %b, got EQ: %b", A, B, xpectEQ, EQ);
            errors = errors + 1; 
        end
        if (LU != xpectLU) begin 
            $display ("Error A: %32b, B: %32b, expectedLU %b, got LU: %b", A, B, xpectLU, LU);
            errors = errors + 1; 
        end
        if (LS != xpectLS) begin 
            $display ("Error A: %32b, B: %32b, expectedLS %b, got LS: %b", A, B, xpectLS, LS);
            errors = errors + 1; 
        end
    end 
endtask

// Unidade em teste: ALU
ALU UUT (.A(A), .B(B), .FUNC(FUNC), .sub_sra(sub_sra), .S(S), .EQ(EQ), .LU(LU), .LS(LS));

initial begin
errors = 0;
A = {2'b11, 30'b0}; // entradas arbitrárias de teste, já que todos os módulos já foram
                    // previamente testados com rigor, basta verificar se o seletor funciona
B = {20'b11111111111111111111, 12'b0}; 
As = A;
Bs = B;

for (i = 0; i < 8; i = i + 1) begin
  // percorremos todos os valores de FUNC e testamos se os valores estão realmente corretos
  FUNC = i;
  case (FUNC)
    3'b000: correct = A - B;
    3'b001: correct = A << B[4:0];
    3'b010: correct = A < B;
    3'b011: correct = As < Bs;
    3'b100: correct = A ^ B;
    3'b101: correct = A >>> B[4:0];
    3'b110: correct = A | B;
    3'b111: correct = A & B;
  endcase
  correctEQ = A == B;
  correctLS = As < Bs;
  correctLU = A < B;
  #10
  Check(correct, correctEQ, correctLU, correctLS);
end
// ativamos o sub_sra e testamos novamente todos os valores de FUNC
sub_sra = 1;
for (i = 0; i < 8; i = i + 1) begin
  FUNC = i;
  case (FUNC)
    3'b000: correct = A - B;
    3'b001: correct = A << B[4:0];
    3'b010: correct = A < B;
    3'b011: correct = As < Bs;
    3'b100: correct = A ^ B;
    3'b101: correct = A >>> B[4:0];
    3'b110: correct = A | B;
    3'b111: correct = A & B;
  endcase
  correctEQ = A == B;
  correctLS = As < Bs;
  correctLU = A < B;
  #10
  Check(correct, correctEQ, correctLU, correctLS);
end
$display("Finished. Got %d errors", errors);
$stop;
end
endmodule