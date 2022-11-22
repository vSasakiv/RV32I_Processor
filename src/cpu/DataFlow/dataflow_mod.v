module dataflow (
  input sub_sra, // sub sra alu
  input insn_clk, pc_clk, rd_clk,// clock para reg de instruções
  input reset, // reset
  input pc_next_sel, // seletor pc next
  input pc_alu_sel, // seletor pc alu
  input alu_sel_a, alu_sel_b, // seletor alu
  input addr_sel, // seletor endereço
  input [1:0] rd_sel, // seletor mux para RD
  input [2:0] func, mem_size, // func e memory extension size
  input [4:0] rs1, rs2, rd,
  input [31:0] data_o, // saida da memoria
  output [31:0] addr, // endereço
  output [31:0] insn_out,
  output [31:0] rs2_mem_i, // saida rs2
  output EQ, LS, LU // saídas de comparação
);

  wire [31:0] mem_extend; // saida do memory extender
  wire [31:0] insn; // instrução
  wire [31:0] imm; // imediato feito de acordo com o opcode
  wire [31:0] alu_val; // saida da alu
  wire [31:0] pc;
  wire [31:0] pc_inc;
  wire [31:0] pc_selected;
  wire [31:0] rd_val;
  wire [31:0] pc_alu_selected;
  wire [31:0] rs1_val;
  wire [31:0] rs2_val;
  wire [31:0] alu_val_a, alu_val_b;

  memsx M0 (.mem_value(data_o), .mem_extend(mem_extend), .mem_size(mem_size));

  reg32bit INSNreg (.clk(insn_clk), .rs_i(reset), .data_i(data_o), .data_o(insn));

  immx IMMX0 (.insn(insn), .imm(imm));

  mux2to1 PCNEXTSEL (.select(pc_next_sel), .I0(pc_inc), .I1(alu_val), .data_o(pc_selected));

  reg32bit PCreg (.clk(pc_clk), .rs_i(reset), .data_i(pc_selected), .data_o(pc));

  Adder32b PCADD (.A(pc), .B(pc_alu_selected), .SUB(1'b0), .S(pc_inc));

  mux2to1 PCALUSEL (.select(pc_alu_sel), .I0(32'h00000004), .I1(imm), .data_o(pc_alu_selected));

  mux4to1 RDSEL (.select(rd_sel), .I0(mem_extend), .I1(imm), .I2(alu_val), .I3(pc_inc), .data_o(rd_val));

  regfile REG (.clk(rd_clk), .rs_i(reset), .rd(rd), .rs1(rs1), .rs2(rs2), .rd_in(rd_val), .rs1_out(rs1_val), .rs2_out(rs2_val));

  mux2to1 ALUASEL (.select(alu_sel_a), .I0(rs1_val), .I1(pc), .data_o(alu_val_a));

  mux2to1 ALUBSEL (.select(alu_sel_b), .I0(rs2_val), .I1(imm), .data_o(alu_val_b));

  ALU ALU0 (.A(alu_val_a), .B(alu_val_b), .func(func), .sub_sra(sub_sra), .alu_val(alu_val), .EQ(EQ), .LS(LS), .LU(LU));

  mux2to1 ADDRSEL (.select(addr_sel), .I0(pc), .I1(alu_val), .data_o(addr));

  assign rs2_mem_i = rs2_val;
  assign insn_out = insn;

endmodule