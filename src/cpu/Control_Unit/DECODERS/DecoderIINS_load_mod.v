/* 
Módulo para decodificação de instruções do tipo R de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderIINSN_load (
  input wire [31:0] INSN , // instrução de 32 bits
  input wire CLK, // sinal de Clock
  output wire [4:0] rsa, rsb, rd, // Registradores a serem acessados
  output wire [2:0] func3, sx_size, // Selecionador de funções da ALU e extensão de valor de memória
  output wire [1:0] rd_sel, // Selecionador de entrada para RD
  
  output wire alu_sel_a, alu_sel_b, sub_sra, addr_sel, pc_next_sel, pc_alu_sel,
  // Controle dos multiplexadores de entrada da ALU, controle de adição/subtração
  // controle de escolha de endereço, program counter, e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  assign rsa = INSN[19:15]; // O RSA está codificado diretamente na instrução
  assign rsb = 5'bxxxxx; // RSB não importa, já que a instrução é do tipo I
  
  assign func3 = 3'b000; // Func3 deve ser soma, já que a instrução requer a soma de RSA com IMM
  assign sub_sra = 1'b0; // Deve ser zero, já que queremos soma sempre.

  assign alu_sel_a = 0; // Seletor utilizado para receber valor do registrador
  assign alu_sel_b = 1; // Seletor utilizado para receber valor imediato
  assign addr_sel = ~CLK; // o endereço de memória deve iniciar com o resultado da alu,
  // e em seguida deve retornar para o pc, para prosseguir o programa, o que alinha com
  // o clock do processador

  assign rd = INSN[11:7]; // O RD está codificado diretamente na instrução
  assign rd_sel = 2'b00; // Selecionamos a saída da alu para a memória
  assign rd_clk = CLK; // O rd_clk é igual ao CLK do processador, que ao subir grava o valor.

  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign sx_size = INSN[14:12]; // Utilizado para extender valor proveniente da memória
  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.

endmodule