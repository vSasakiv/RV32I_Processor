/* 
Módulo para decodificação de instruções do tipo I para load de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderIINSN_load (
  input wire [31:0] INSN , // instrução de 32 bits
  input wire CLK, // sinal de Clock  
  output wire sub_sra, addr_sel, pc_next_sel, pc_alu_sel,
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  
  assign sub_sra = 1'b0; // Deve ser zero, já que queremos soma sempre.

  assign addr_sel = ~CLK; // O endereço de memória deve iniciar com o resultado da alu,
  // e em seguida deve retornar para o pc, para prosseguir o programa, o que alinha com
  // o clock do processador

  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign rd_clk = CLK; // O rd_clk é igual ao CLK do processador, que ao subir grava o valor.
  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.

endmodule