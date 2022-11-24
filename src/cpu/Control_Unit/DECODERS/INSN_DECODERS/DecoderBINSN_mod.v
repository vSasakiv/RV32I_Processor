/* 
Módulo para decodificação de instruções do tipo B branches com instruções de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes para serem enviadas ao circuito
*/
module DecoderBINSN (
  input wire [31:0] insn, // instrução de 32 bits
  input wire clk,
  input wire EQ, LS, LU, // entradas de comparação  
  output reg pc_alu_sel // Sinal que seleciona se qual incremeto será dado ao PC
);
  wire [2:0] func; // net func para auxiliar na legibilidade do código
  assign func = insn[14:12]; 

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