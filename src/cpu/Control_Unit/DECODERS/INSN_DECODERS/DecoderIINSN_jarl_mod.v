/* 
Módulo para decodificação de instruções do tipo I JARL de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderIINSN_jarl (
  input wire [31:0] INSN , // instrução de 32 bits
  input wire CLK, // sinal de Clock  
  output wire addr_sel, pc_next_sel, pc_alu_sel,sub_sra,
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);

  assign addr_sel = 0; // o endereço de memória deve continuar recebendo o pc

  assign sub_sra = 0; // como haverá uma soma, devemos setar sub_sra com 0.
  assign pc_next_sel = 1; // O PC continua deve receber o valor provindo da alu
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign rd_clk = CLK; // O rd_clk é igual ao CLK do processador, que ao subir grava o valor.
  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.

endmodule