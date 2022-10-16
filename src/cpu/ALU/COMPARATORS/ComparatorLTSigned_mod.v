/* 
Módulo para realização de comparação entre dois números
signed A e B, devolvendo R = 1, caso A < B,
dados os bits de sinal de A e B e da subtração,
além do sinal de Igualdade
 */
module ComparatorLTSigned (
  input wire A_S, B_S, S_S, EQ, // Entradas de sinal e igualdade
  output wire R // Saída
);

  assign R = (A_S & ~B_S) | (~EQ & S_S) & (~B_S | A_S); // Expressão lógica derivada de tabela verdade
  
endmodule