/* 
Módulo da Unidade Lógica Aritmética (ALU) do processador
Este módulo contém uma conglomeração de todos os módulos
de circuitos combinatórios aritméticos e comparadores
*/
module ALU (
  input wire [31:0] A, B, // Entradas A e B da ALU, sendo A o primeiro operando e B o segundo
  input wire [2:0] func, // Entrada seletora de func proveniente da C.U.
  input wire sub_sra, // Entrada que ativa / desativa subtração e shift aritmético
  output reg [31:0] alu_val, // Saída, que é selecionada pela entrada func
  output wire EQ, LU, LS // Saídas de comparador, são sempre expostas para a C.U.
);
  
  wire [31:0] ADD, bXOR, bAND, bOR, SR, SL; // Guardam valores de possíveis operações que podem ser selecionados pelo func
  wire COUT; // Fio que contém o carry out da soma / subtração
  
  Adder32b A0 (.A(A), .B(B), .S(ADD), .SUB(sub_sra), .COUT(COUT)); // Módulo de soma
  And32b bAND0 (.A(A), .B(B), .And(bAND)); // Módulo and bitwise
  Or32b bOR0 (.A(A), .B(B), .O(bOR)); // Módulo or bitwise
  Xor32b bXOR0 (.A(A), .B(B), .Xor(bXOR)); // Módulo xor bitwise
  LeftLShifter LeftS0 (.A(A), .B(B), .S(SL)); // Módulo barrel left shifter
  RightShifter RightS0 (.A(A), .B(B), .SRA(sub_sra), .Shifted(SR)); // Módulo barrel right shifter
  Comparator C0 (.A_S(A[31]), .B_S(B[31]), .S(ADD), .COUT(COUT), .EQ(EQ), .LS(LS), .LU(LU));
  // módulo comparadores (só funciona quando sub_sra = 1)

  // Bloco always para síntese de multiplexador para selecionar as saídas
  always @(*) begin
    // Case baseado nas instruções presentes na ISA, para poupar o máximo da C.U.
    case (func)
      3'b000: alu_val = ADD;
      3'b001: alu_val = SL;
      3'b010: alu_val = LS;
      3'b011: alu_val = LU;
      3'b100: alu_val = bXOR;
      3'b101: alu_val = SR;
      3'b110: alu_val = bOR;
      3'b111: alu_val = bAND;
    endcase
  end

endmodule
