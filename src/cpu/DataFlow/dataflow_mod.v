module dataflow (
  input sub_sra, // sub sra alu
  input insn_clk, pc_clk, rd_clk,// clock para reg de instruções
  input reset, // reset
  input pc_next_sel, // seletor pc next
  input pc_alu_sel, // seletor pc alu
  input alu_a_sel, alu_b_sel, // seletor alu
  input addr_sel, // seletor endereço
  input [1:0] rd_sel, // seletor mux para RD
  input [2:0] func3, mem_s, // func3 e memory extension size
  input [4:0] RSA, RSB, RD,
  input [31:0] dout, // saida da memoria
  output [31:0] addr, // endereço
  output [31:0] insn_out,
  output [31:0] rs2_val, // saida rs2
  output EQ, LS, LU // saídas de comparação
);

  wire [31:0] mem_x; // saida do memory extender
  wire [31:0] insn; // instrução
  wire [31:0] imm; // imediato feito de acordo com o opcode
  wire [31:0] alu; // saida da alu
  wire [31:0] pc;
  wire [31:0] pc_i;
  wire [31:0] pc_selected;
  wire [31:0] rd_val;
  wire [31:0] pc_alu_selected;
  wire [31:0] rsa_val;
  wire [31:0] rsb_val;
  wire [31:0] alu_a, alu_b;

  memsx M0 (.mem_v(dout), .mem_x(mem_x), .mem_s(mem_s));

  reg32bit INSNreg (.clk(insn_clk), .rs_i(reset), .din(dout), .dout(insn));

  immx IMMX0 (.insn(insn), .imm(imm));

  mux2to1 PCNEXTSEL (.select(pc_next_sel), .I0(pc_i), .I1(alu), .dout(pc_selected));

  reg32bit PCreg (.clk(pc_clk), .rs_i(reset), .din(pc_selected), .dout(pc));

  Adder32b PCADD (.A(pc), .B(pc_alu_selected), .SUB(1'b0), .S(pc_i));

  mux2to1 PCALUSEL (.select(pc_alu_sel), .I0(32'h00000004), .I1(imm), .dout(pc_alu_selected));

  mux4to1 RDSEL (.select(rd_sel), .I0(mem_x), .I1(imm), .I2(alu), .I3(pc_i), .dout(rd_val));

  regfile REG (.clk(rd_clk), .rs_i(reset), .rd(RD), .ra(RSA), .rb(RSB), .rd_in(rd_val), .ra_out(rsa_val), .rb_out(rsb_val));

  mux2to1 ALUASEL (.select(alu_a_sel), .I0(rsa_val), .I1(pc), .dout(alu_a));

  mux2to1 ALUBSEL (.select(alu_b_sel), .I0(rsb_val), .I1(imm), .dout(alu_b));

  ALU ALU0 (.A(alu_a), .B(alu_b), .FUNC(func3), .sub_sra(sub_sra), .S(alu), .EQ(EQ), .LS(LS), .LU(LU));

  mux2to1 ADDRSEL (.select(addr_sel), .I0(pc), .I1(alu), .dout(addr));

  assign rs2_val = rsb_val;
  assign insn_out = insn;

endmodule