/* Módulo que contém a junção de todos os módulos característicos do dataflow */
module dataflow (
  input sub_sra, // sub sra alu
  input insn_clk, pc_clk, rd_clk,// clock para reg de instruções
  input reset, // reset
  input pc_next_sel, // seletor pc next
  input pc_alu_sel, // seletor pc alu
  input alu_sel_a, alu_sel_b, // seletor alu
  input addr_sel, // seletor de endereço para memória RAM
  input [1:0] rd_sel, // seletor mux para RD
  input [2:0] func, mem_size, // func e memory extension size
  input [4:0] rs1, rs2, rd, // seletores de registradores de entrada e saída 
  input [31:0] data_o, // saída da memória
  input [31:0] imm, // valor do imediato
  output [31:0] addr, // endereço para acesso de memória RAM
  output [31:0] insn_out, // saída contendo instrução
  output [31:0] rs2_mem_i, // saída rs2 para memória
  output EQ, LS, LU // saídas de comparação
);

  wire [31:0] mem_extend; // saída do memory extender
  wire [31:0] insn; // instrução
  wire [31:0] alu_val; // saída da alu
  wire [31:0] pc; // net que contém o valor atual do program counter (PC)
  wire [31:0] pc_inc; // net que contém o valor do program counter somado com a entrada do alu_pc
  wire [31:0] pc_selected; // valor que deverá ser o próximo PC, podendo ser um valor da ALU principal ou da própria alu do PC
  wire [31:0] rd_val; // valor que será gravado em um registrador do Regfile
  wire [31:0] pc_alu_selected;  // saída da ALU do PC
  wire [31:0] rs1_val; // valor de saída rs1 do regfile
  wire [31:0] rs2_val; // valor de saída rs2 do regfile
  wire [31:0] alu_val_a, alu_val_b; // valores a e b na entrada da ALU principal
// módulo memory extender, utilizado para corrigir o valor que será carregado a um registrador da Regfile de acordo com a instrução
  memsx M0 (.mem_value(data_o), .mem_extend(mem_extend), .mem_size(mem_size));
  // registrador que contém as instruções sendo atualmente executadas
  reg32bit INSNreg (.clk(insn_clk), .rs_i(reset), .data_i(data_o), .data_o(insn));
  // multiplexador para selecionar o próximo valor do PC
  mux2to1 PCNEXTSEL (.select(pc_next_sel), .I0(pc_inc), .I1(alu_val), .data_o(pc_selected));
  // registrador para o Program Counter (PC)
  reg32bit PCreg (.clk(pc_clk), .rs_i(reset), .data_i(pc_selected), .data_o(pc));
  // ALU do Program Counter, neste caso sendo apenas um somador de 32bits.
  Adder32b PCADD (.A(pc), .B(pc_alu_selected), .SUB(1'b0), .S(pc_inc));
  // multiplexador para seleção da segunda entrada da ALU do Program Counter
  mux2to1 PCALUSEL (.select(pc_alu_sel), .I0(32'h00000004), .I1(imm), .data_o(pc_alu_selected));
  // multiplexador para selecionar qual valor deverá ser gravado no registrador destino presente na Regfile
  mux4to1 RDSEL (.select(rd_sel), .I0(mem_extend), .I1(imm), .I2(alu_val), .I3(pc_inc), .data_o(rd_val));
  // Regfile
  regfile REG (.clk(rd_clk), .rs_i(reset), .rd(rd), .rs1(rs1), .rs2(rs2), .rd_in(rd_val), .rs1_out(rs1_val), .rs2_out(rs2_val));
  // multiplexador para selecionar qual valor irá entrar na ALU geral, podendo ser o PC ou o valor do rs1
  mux2to1 ALUASEL (.select(alu_sel_a), .I0(rs1_val), .I1(pc), .data_o(alu_val_a));
  // multiplexador para selecionar qual valor irá entrar na ALU geral, podendo ser um imediato ou o valor do rs2
  mux2to1 ALUBSEL (.select(alu_sel_b), .I0(rs2_val), .I1(imm), .data_o(alu_val_b));
  // ALU
  ALU ALU0 (.A(alu_val_a), .B(alu_val_b), .func(func), .sub_sra(sub_sra), .alu_val(alu_val), .EQ(EQ), .LS(LS), .LU(LU));
  // multiplexador para selecionar endereço, utilizado em função de store para gravar algum valor.
  mux2to1 ADDRSEL (.select(addr_sel), .I0(pc), .I1(alu_val), .data_o(addr));

  assign rs2_mem_i = rs2_val;
  assign insn_out = insn;

endmodule