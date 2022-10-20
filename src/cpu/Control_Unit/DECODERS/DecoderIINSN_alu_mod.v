/* 
Módulo para decodificação de instruções do tipo I com instruções da alu de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderIINSN_alu (
  input wire [31:0] INSN , // instrução de 32 bits
  input wire CLK, // sinal de Clock  
  output wire addr_sel, pc_next_sel, pc_alu_sel,sub_sra,
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  wire [2:0] func3;
  assign func3 = INSN[14:12]; // net func3 para auxiliar na legibilidade do código


  assign addr_sel = 0; // o endereço de memória deve continuar recebendo o pc

  assign sub_sra = (~func3[2] & func3[1]) | (func3[2] & ~func3[1] & func3[0] & INSN[30]);
  // a subtração deve existir nos casos que precisamos de funções
  // de comparação, como slti e sltiu, e no shift direito quando 
  // o segundo bit mais significativo for 1
  
  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign rd_clk = CLK; // O rd_clk é igual ao CLK do processador, que ao subir grava o valor.
  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.

endmodule