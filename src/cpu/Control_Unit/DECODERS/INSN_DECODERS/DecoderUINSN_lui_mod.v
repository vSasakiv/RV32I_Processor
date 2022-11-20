/* 
Módulo para decodificação de instruções do tipo U lui de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderUINSN_lui (
  input wire [31:0] insn , // instrução de 32 bits
  input wire clk, // sinal de Clock
  output wire addr_sel, pc_next_sel, pc_alu_sel, sub_sra,
  // controle de adição/subtração, controle de escolha de endereço, program counter, e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);

  assign sub_sra = 1'bx; // não importa pois não é realizada operação aritmética
  assign addr_sel = 0; // O endereço da memória continua sendo o program counter

  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.
  assign rd_clk = clk; // O rd_clk é igual ao clk do processador, que ao subir grava o valor.

endmodule