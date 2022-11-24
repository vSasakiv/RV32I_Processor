/* 
Módulo responsável por verificar a igualdade entre duas entradas,
dada o resultado da subtração (S) entre as duas
*/
module ComparatorEQ (
  input wire [31:0] S, // Subtração de A por B
  output wire EQ // Saída resultado
);
  
  assign EQ = ~(|S); // NOR de 32 entradas, realizada com cada um dos bits
// Caso um único bit seja 1, a saída já será 0.

endmodule 