/* 
Módulo para decodificação de instruções do tipo S (store) seguindo o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderSINSN (
  input wire [31:0] insn , // instrução de 32 bits
  input wire clk, // sinal de Clock  
  output wire addr_sel, pc_next_sel, pc_alu_sel,sub_sra,
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);

  assign addr_sel = ~clk; // o endereço de memória deve receber o resultado da alu inicialmente, entretanto em seguida deve voltar para o pc, oque coincide com o sinal de clock invertido do processador

  assign sub_sra = 0; // como haverá soma, sempre será 0
  
  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign rd_clk = 0; // como o rd não é utilizado, deve ser deixado em 0 para evitar problemas de gravação
  assign mem_clk = clk; // Deve ter rising edge quando o addr_sel tem falling edge, coincidindo com o sinal de clock.

endmodule