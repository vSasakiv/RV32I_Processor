module CU (
  input [31:0] INSN,
  input LU, LS, EQ,
  output addr_sel, pc_next_sel, sub_sra, pc_alu_sel,
  output rd_clk, mem_clk,
  output alu_sel_a, alu_sel_b,
  output pc_clk, insn_clk,
  output [1:0] mem_sz,
  output [2:0] mem_sx,
  output [2:0] Func3,
  output [1:0] rd_sel,
  output [4:0] rs1, rs2, rd
);
  wire clk;

  ClockGen C0 (.CLK(clk));
  wire [9:0] code;
  OPDecoder OPD0 (.INSN(INSN), .Code(code));

  INSNDecoderClks IDC0 (.INSN(INSN), .Code(code), .CLK(clk), .EQ(EQ), .LS(LS), .LU(LU), .addr_sel(addr_sel), .pc_next_sel(pc_next_sel), .sub_sra(sub_sra), .pc_alu_sel(pc_alu_sel), .rd_clk(rd_clk), .mem_clk(mem_clk));
  ALUSelA ASA0 (.CODE(code), .alu_sel_A(alu_sel_a));
  ALUSelB ASB0 (.CODE(code), .alu_sel_B(alu_sel_b));
  Func3Mux F3M0 (.CODE(code), .INSN(INSN[14:12]), .FUNC3(Func3));
  RdSel RS0 (.CODE(code), .rd_sel(rd_sel));

  assign rs1 = INSN[19:15];
  assign rs2 = INSN[24:20];
  assign rd = INSN[11:7];
  assign mem_sx = INSN[14:12];
  assign mem_sz = INSN[13:12];
  assign insn_clk = ~clk;
  assign pc_clk = clk;

endmodule