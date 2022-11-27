/* Módulo para decodificação de instruções do tipo I com instruções da ALU de acordo com
o ISA do risc-v. O módulo recebe a instrução e retorna todas as saídas relevantes a serem enviadas ao circuito
*/
module DecoderIINSN_alu (
  input wire [31:0] insn, // instrução de 32 bits
  output wire sub_sra // controle de adição/subtração e de logical/arithmetic shift
);
  wire [2:0] func;  // net func para auxiliar na legibilidade do código
  assign func = insn[14:12];

  assign sub_sra = (~func[2] & func[1]) | (func[2] & ~func[1] & func[0] & insn[30]);
  // a subtração deve existir nos casos em que precisamos de funções de comparação, como slti e sltiu, e no shift right quando o segundo bit mais significativo for 1

endmodule