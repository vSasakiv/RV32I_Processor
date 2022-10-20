module INSNDecoderClks (
  input wire [31:0] INSN;
  input wire [9:0] Code;
  input wire CLK;
  input wire EQ, LS, LU, // entradas de comparação

  output wire addr_sel, pc_next_sel,sub_sra,
  output reg pc_alu_sel,
  // controle de adição/subtração controle de escolha de endereço, program counter,
  //e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);
  wire addr_sel_B, addr_sel_IA, addr_sel_IJ, addr_sel_IL, addr_sel_J, addr_sel_R, addr_sel_S, addr_sel_UA, addr_sel_UL;

  wire pc_next_sel_B, pc_next_sel_IA, pc_next_sel_IJ, pc_next_sel_IL, pc_next_sel_J, pc_next_sel_R, pc_next_sel_S, pc_next_sel_UA, pc_next_sel_UL; 

  wire sub_sra_B, sub_sra_IA, sub_sra_IJ, sub_sra_IL, sub_sra_J, sub_sra_R, sub_sra_S, sub_sra_UA, sub_sra_UL;

  wire pc_alu_sel_B, pc_alu_sel_IA, pc_alu_sel_IJ, pc_alu_sel_IL, pc_alu_sel_J, pc_alu_sel_R, pc_alu_sel_S, pc_alu_sel_UA, pc_alu_sel_UL;

  wire rd_clk_B, rd_clk_IA, rd_clk_IJ, rd_clk_IL, rd_clk_J, rd_clk_R, rd_clk_S, rd_clk_UA, rd_clk_UL;

  wire mem_clk_B, mem_clk_IA, mem_clk_IJ, mem_clk_IL, mem_clk_J, mem_clk_R, mem_clk_S, mem_clk_UA, mem_clk_UL;

  wire [9:0] addr_sel_c, pc_next_sel_c, sub_sra_c, pc_alu_sel_c, rd_clk_c, mem_clk_c;

  DecoderBINSN D0 (.INSN(INSN), .CLK(CLK), .EQ(EQ), .LS(LS), .LU(LU), .addr_sel(addr_sel_B), .pc_next_sel(pc_next_sel_B), .sub_sra(sub_sra_B), .pc_alu_sel(pc_alu_sel_B), .rd_clk(rd_clk_B), .mem_clk(mem_clk_B));

  DecoderIINSN_alu D1 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_IA), .pc_next_sel(pc_next_sel_IA), .sub_sra(sub_sra_IA), .pc_alu_sel(pc_alu_sel_IA), .rd_clk(rd_clk_IA), .mem_clk(mem_clk_IA));

  DecoderIINSN_jarl D2 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_IJ), .pc_next_sel(pc_next_sel_IJ), .sub_sra(sub_sra_IJ), .pc_alu_sel(pc_alu_sel_IJ), .rd_clk(rd_clk_IJ), .mem_clk(mem_clk_IJ));

  DecoderIINSN_load D3 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_IL), .pc_next_sel(pc_next_sel_IL), .sub_sra(sub_sra_IL), .pc_alu_sel(pc_alu_sel_IL), .rd_clk(rd_clk_IL), .mem_clk(mem_clk_IL));

  DecoderJINSN D4 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_J), .pc_next_sel(pc_next_sel_J), .sub_sra(sub_sra_J), .pc_alu_sel(pc_alu_sel_J), .rd_clk(rd_clk_J), .mem_clk(mem_clk_J));

  DecoderRINSN D5 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_R), .pc_next_sel(pc_next_sel_R), .sub_sra(sub_sra_R), .pc_alu_sel(pc_alu_sel_R), .rd_clk(rd_clk_R), .mem_clk(mem_clk_R));

  DecoderSINSN D6 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_S), .pc_next_sel(pc_next_sel_S), .sub_sra(sub_sra_S), .pc_alu_sel(pc_alu_sel_S), .rd_clk(rd_clk_S), .mem_clk(mem_clk_S));

  DecoderUINSN_auipc D7 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_UA), .pc_next_sel(pc_next_sel_UA), .sub_sra(sub_sra_UA), .pc_alu_sel(pc_alu_sel_UA), .rd_clk(rd_clk_UA), .mem_clk(mem_clk_UA));

  DecoderUINSN_lui D8 (.INSN(INSN), .CLK(CLK), .addr_sel(addr_sel_UL), .pc_next_sel(pc_next_sel_UL), .sub_sra(sub_sra_UL), .pc_alu_sel(pc_alu_sel_UL), .rd_clk(rd_clk_UL), .mem_clk(mem_clk_UL));

  assign addr_sel_c = {1'b0, addr_sel_IL, addr_sel_IA, addr_sel_S, addr_sel_R, addr_sel_B, addr_sel_UA, addr_sel_UL, addr_sel_IJ, addr_sel_J};

  assign pc_next_sel_c = {1'b0, pc_next_sel_IL, pc_next_sel_IA, pc_next_sel_S, pc_next_sel_R, pc_next_sel_B, pc_next_sel_UA, pc_next_sel_UL, pc_next_sel_IJ, pc_next_sel_J};

  assign sub_sra_c = {1'b0, sub_sra_IL, sub_sra_IA, sub_sra_S, sub_sra_R, sub_sra_B, sub_sra_UA, sub_sra_UL, sub_sra_IJ, sub_sra_J};

  assign pc_alu_sel_c = {1'b0, pc_alu_sel_IL, pc_alu_sel_IA, pc_alu_sel_S, pc_alu_sel_R, pc_alu_sel_B, pc_alu_sel_UA, pc_alu_sel_UL, pc_alu_sel_IJ, pc_alu_sel_J};

  assign rd_clk_c = {1'b0, rd_clk_IL, rd_clk_IA, rd_clk_S, rd_clk_R, rd_clk_B, rd_clk_UA, rd_clk_UL, rd_clk_IJ, rd_clk_J};

  assign mem_clk_c = {1'b0, mem_clk_IL, mem_clk_IA, mem_clk_S, mem_clk_R, mem_clk_B, mem_clk_UA, mem_clk_UL, mem_clk_IJ, mem_clk_J};

  Gate G0 (.Code(Code), .dec_data(addr_sel_c), .S(addr_sel));
  Gate G1 (.Code(Code), .dec_data(pc_next_sel_c), .S(pc_next_sel));
  Gate G2 (.Code(Code), .dec_data(sub_sra_c), .S(sub_sra));
  Gate G3 (.Code(Code), .dec_data(pc_alu_sel_c), .S(pc_alu_sel));
  Gate G4 (.Code(Code), .dec_data(rd_clk_c), .S(rd_clk));
  Gate G5 (.Code(Code), .dec_data(mem_clk_c), .S(mem_clk));

endmodule