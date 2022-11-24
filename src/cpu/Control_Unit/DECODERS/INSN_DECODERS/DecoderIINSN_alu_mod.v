/* 
Módulo para decodificação de instruções do tipo I com instruções da alu de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderIINSN_alu (
  input wire [31:0] insn, // instrução de 32 bits
  input wire clk, // sinal de Clock  
  output wire sub_sra
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
);
  wire [2:0] func;
  assign func = insn[14:12]; // net func para auxiliar na legibilidade do código

  assign sub_sra = (~func[2] & func[1]) | (func[2] & ~func[1] & func[0] & insn[30]);
  // a subtração deve existir nos casos que precisamos de funções
  // de comparação, como slti e sltiu, e no shift direito quando 
  // o segundo bit mais significativo for 1

endmodule