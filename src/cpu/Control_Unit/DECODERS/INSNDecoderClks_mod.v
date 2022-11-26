module INSNDecoderClks (
  input wire [31:0] insn, // Entrada da instrução
  input wire [9:0] code, // Código proveniente do OPDecoder
  input wire clk, // Sinal de Clock
  input wire EQ, LS, LU, // Entradas de comparação
  output wire sub_sra, addr_sel, pc_next_sel, pc_alu_sel,
  // controle de adição/subtração, controle de escolha de endereço da memória e do program counter e entrada da ALU do program counter
  output wire rd_clk, mem_clk // Saídas de clock dos registradores e da memória
);

  // nets auxiliares para realizar ligação nas instâncias dos decoders
  wire sub_sra_IA, sub_sra_R;
  wire pc_alu_sel_B;

  // nets para a concatenação de todos os sinais, os quais se situam na ordem prevista pelo OPDecoder para cada instrução (verificar no módulo OPdecoder)
  wire [9:0] addr_sel_c, pc_next_sel_c, sub_sra_c, pc_alu_sel_c, rd_clk_c, mem_clk_c;

  // instanciação de todos os módulos de decoder
  DecoderBINSN D0 (.insn(insn), .EQ(EQ), .LS(LS), .LU(LU), .pc_alu_sel(pc_alu_sel_B));
  DecoderIINSN_alu D1 (.insn(insn), .sub_sra(sub_sra_IA));
  DecoderRINSN D5 (.insn(insn), .sub_sra(sub_sra_R));

  // concatenação de todos os sinais de saída para ser utilizado no Gate
  assign addr_sel_c = {1'b0, ~clk, 1'b0, ~clk, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
  assign pc_next_sel_c = {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, ~clk};
  assign sub_sra_c = {1'b0, 1'b0, sub_sra_IA, 1'b0, sub_sra_R, 1'b1, 1'b0, 1'bx, 1'b0, 1'b0};
  assign pc_alu_sel_c = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, pc_alu_sel_B, 1'b0,  1'b0, 1'b0, clk};
  assign rd_clk_c = {1'b0, clk, clk, 1'b0, clk, 1'b0, clk, clk, clk, clk};
  assign mem_clk_c = {1'b0, 1'b0, 1'b0, clk, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};

  // instanciação dos gates para cada sinal, os quais retornam diretamente as saídas.
  Gate G0 (.code(code), .Dec_Data(addr_sel_c), .S(addr_sel));
  Gate G1 (.code(code), .Dec_Data(pc_next_sel_c), .S(pc_next_sel));
  Gate G2 (.code(code), .Dec_Data(sub_sra_c), .S(sub_sra));
  Gate G3 (.code(code), .Dec_Data(pc_alu_sel_c), .S(pc_alu_sel));
  Gate G4 (.code(code), .Dec_Data(rd_clk_c), .S(rd_clk));
  Gate G5 (.code(code), .Dec_Data(mem_clk_c), .S(mem_clk));

endmodule