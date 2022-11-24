/* 
Módulo para decodificação de instruções do tipo R de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderRINSN (
  input wire [31:0] insn, // instrução de 32 bits
  input wire clk, // sinal de Clock
  output wire sub_sra
  // controle de adição/subtração, controle de escolha de endereço, program counter, e entrada da ALU do program counter
);

  assign sub_sra = ((~insn[14]) & insn[13]) | insn[30]; // Está codificada no segundo
  // bit mais signifcativo da instrução, e também deverá ser 1 caso a instrução 
  // necessite de uma comparação

endmodule