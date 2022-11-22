module CU (
  input [31:0] insn,
  input LU, LS, EQ,
  output addr_sel, pc_next_sel, sub_sra, pc_alu_sel,
  output rd_clk, mem_clk,
  output alu_sel_a, alu_sel_b,
  output pc_clk, insn_clk,
  output [1:0] mem_size,
  output [2:0] mem_extend,
  output [2:0] func,
  output [1:0] rd_sel,
  output [4:0] rs1, rs2, rd
);
  wire clk;

  ClockGen C0 (.clk(clk));
  wire [9:0] code;
  OPDecoder OPD0 (.insn(insn), .code(code));

  INSNDecoderclks IDC0 (.insn(insn), .code(code), .clk(clk), .EQ(EQ), .LS(LS), .LU(LU), .addr_sel(addr_sel), .pc_next_sel(pc_next_sel), .sub_sra(sub_sra), .pc_alu_sel(pc_alu_sel), .rd_clk(rd_clk), .mem_clk(mem_clk));
  ALUSelA ASA0 (.code(code), .alu_sel_a(alu_sel_a));
  ALUSelB ASB0 (.code(code), .alu_sel_b(alu_sel_b));
  funcMux F3M0 (.code(code), .insn(insn[14:12]), .func(func));
  RdSel RS0 (.code(code), .rd_sel(rd_sel));

  assign rs1 = insn[19:15];
  assign rs2 = insn[24:20];
  assign rd = insn[11:7];
  assign mem_extend = insn[14:12];
  assign mem_size = insn[13:12];
  assign insn_clk = ~clk;
  assign pc_clk = clk;

endmodule