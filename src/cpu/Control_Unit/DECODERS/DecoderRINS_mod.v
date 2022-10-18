/* 
Módulo para decodificação de instruções do tipo R de acordo com
o ISA do risc-v. O módulo recebe a instrução e o sinal de clock
do processador, e retorna todas as saídas relevantes e não relevantes
para serem enviadas ao circuito
*/
module DecoderRINSN (
  input wire [31:0] INSN , // instrução de 32 bits
  input wire CLK, // sinal de Clock
  output wire [4:0] rsa, rsb, rd, // Registradores a serem acessados
  output wire [2:0] func3, // Selecionador de funções da ALU
  output wire [1:0] rd_sel, // Selecionador de entrada para RD
  output wire alu_sel_a, alu_sel_b, sub_sra, addr_sel, pc_next_sel, pc_alu_sel,
  // Controle dos multiplexadores de entrada da ALU, controle de adição/subtração
  // controle de escolha de endereço, program counter, e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  assign rsa = INSN[19:15]; // O RSA, RSB está codificado diretamente na instrução
  assign rsb = INSN[24:20];
  
  assign func3 = INSN[14:12]; // Func3 Também está codificada diretamente na instrução
  assign sub_sra = (~func3[2] & func3[1]) | INSN[30]; // Está codificada no segundo
  // bit mais signifcativo da instrução, e também deverá ser 1 caso a instrução 
  // necessite de uma comparação

  assign alu_sel_a = 0; // Seletores da ALU são setados para receber entrada dos registradores
  assign alu_sel_b = 0;
  assign addr_sel = 0; // O endereço da memória continua sendo o program counter

  assign rd = INSN[11:7]; // O RD está codificado diretamente na instrução
  assign rd_sel = 2'b10; // Selecionamos a saída da alu para o RD
  assign rd_clk = CLK; // O rd_clk é igual ao CLK do processador, que ao subir grava o valor.

  assign pc_next_sel = 0; // O PC continua recebendo o seu valor incrementado em 4
  assign pc_alu_sel = 0; // A ALU do PC contínua recebendo 4

  assign sx_size = 1'bx; // Não importa, já que este bloco não é utilizado na instrução
  assign mem_clk = 0; // É setado para 0, para evitar problemas com gravação de memória.

endmodule