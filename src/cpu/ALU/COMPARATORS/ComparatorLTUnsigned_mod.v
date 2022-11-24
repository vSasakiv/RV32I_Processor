/* 
Módulo para realização de comparação entre dois números
unsigned A e B, devolvendo R = 1 caso A < B,
dados o Carry out da soma pelo complemento de dois
do segundo (subtração) e a igualdade.
 */
module ComparatorLTUnsigned (
  input wire COUT, EQ, // Entradas COUT e igualdade
  output wire R // Saída
);

  assign R = ~(COUT | EQ); // Expressão lógica derivada de tabela verdade
  
endmodule