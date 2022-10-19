/* 
Módulo para decodificação de instruções do tipo R de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderRINSN (
  input wire [31:0] INSN , // instrução de 32 bits
  input wire CLK, // sinal de Clock
  output wire sub_sra, addr_sel, pc_next_sel, pc_alu_sel,
  // controle de adição/subtração, controle de escolha de endereço, program counter, e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  wire [2:0] func3;
  assign func3 = INSN[14:12];
  assign sub_sra = (~func3[2] & func3[1]) | INSN[30]; // Está codificada no segundo
  // bit mais signifcativo da instrução, e também deverá ser 1 caso a instrução 
  // necessite de uma comparação
  assign addr_sel = 0; // O endereço da memória continua sendo o program counter

  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.
  assign rd_clk = CLK; // O rd_clk é igual ao CLK do processador, que ao subir grava o valor.

endmodule