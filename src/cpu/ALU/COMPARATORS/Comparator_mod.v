/* 
Módulo que junta todos os 3 comparadores feitos
em um único módulo 
*/
module Comparator (
  input wire A_S, B_S, COUT, // Bit de sinal de A e B, e o bit COUT
  input wire [31:0] S, // Valor da subtração A - B
  output wire EQ, LU, LS // Saídas das comparações
);
  
  // Utilização dos módulos previamente criados
  ComparatorEQ E0 (.S(S), .EQ(EQ));
  ComparatorLTUnsigned CU0 (.COUT(COUT), .EQ(EQ), .R(LU));
  ComparatorLTSigned CS0 (.A_S(A_S), .B_S(B_S), .S_S(S[31]), .EQ(EQ), .R(LS));

endmodule
