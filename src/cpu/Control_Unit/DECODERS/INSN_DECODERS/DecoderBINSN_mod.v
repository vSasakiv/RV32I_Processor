/* 
Módulo para decodificação de instruções do tipo B branches com instruções de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderBINSN (
  input wire [31:0] insn, // instrução de 32 bits
  input wire clk,
  input wire EQ, LS, LU, // entradas de comparação  
  output wire addr_sel, pc_next_sel, sub_sra,
  output reg pc_alu_sel,
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  wire [2:0] func;
  assign func = insn[14:12]; // net func para auxiliar na legibilidade do código

  assign addr_sel = 0; // o endereço de memória deve continuar recebendo o pc

  assign sub_sra = 1'b1; // como todas as operações de branches necessitam de comparação, e os comparadores foram feitos se aproveitando da subtração, sub_sra deverá sempre ser 1
  
  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4

  assign rd_clk = 0; // O rd_clk é igual a 0, já que não deve ocorrer nenhuma gravação em registrador
  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.

  always @(insn, EQ, LS, LU) begin
    // realizamos as comparações, e baseado no opcode, ou a alu do pc recebe 4 normalmente e não realiza um branch, ou recebe o valor imediato e avança/retorna para algum endereço
    case (func)
      3'b000: pc_alu_sel = (EQ & ~clk);
      3'b001: pc_alu_sel = (~EQ & ~clk);
      3'b100: pc_alu_sel = (LS & ~clk);
      3'b101: pc_alu_sel = (~LS & ~clk);
      3'b110: pc_alu_sel = (LU & ~clk);
      3'b111: pc_alu_sel = (~LU & ~clk);
      default: pc_alu_sel = 1'bx;
    endcase
  end

endmodule