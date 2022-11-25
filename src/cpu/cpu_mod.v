module CPU (
  input reset,
	input wire [31:0] data_o, // saida da memoria
	output mem_clk, 
	output [1:0] mem_size,
	output [31:0] addr, data_i
);

  wire sub_sra; // sub sra alu
  wire insn_clk, pc_clk, rd_clk;// clock para reg de instruções
  wire pc_next_sel; // seletor pc next
  wire pc_alu_sel; // seletor pc alu
  wire alu_sel_a, alu_sel_b; // seletor alu
  wire addr_sel; // seletor endereço 
  wire [1:0] rd_sel; // seletor mux para RD
  wire [2:0] func, mem_extend; // func e memory extension size
  wire [4:0] rs1, rs2, rd;
  wire [31:0] insn, imm, dout, rs2_mem_i;
  wire EQ, LS, LU;

/*   assign data_i[7:0] = rs2_mem_i[31:24];
  assign data_i[15:8] = rs2_mem_i[23:16];
  assign data_i[23:16] = rs2_mem_i[15:8];
  assign data_i[31:24] = rs2_mem_i[7:0];  */

/*   assign dout[7:0] = data_o[31:24];
  assign dout[15:8] = data_o[23:16];
  assign dout[23:16] = data_o[15:8];
  assign dout[31:24] = data_o[7:0]; */


  CU CONTROL0 (
    .addr_sel(addr_sel)
    ,.insn(insn)
    ,.pc_next_sel(pc_next_sel)
    ,.pc_alu_sel(pc_alu_sel)
    ,.sub_sra(sub_sra)
    ,.rd_clk(rd_clk)
    ,.mem_clk(mem_clk)
    ,.alu_sel_a(alu_sel_a)
    ,.alu_sel_b(alu_sel_b)
    ,.pc_clk(pc_clk)
    ,.insn_clk(insn_clk)
    ,.mem_size(mem_size)
    ,.mem_extend(mem_extend)
    ,.func(func)
    ,.rd_sel(rd_sel)
    ,.rs1(rs1)
    ,.rs2(rs2)
    ,.rd(rd)
    ,.EQ(EQ)
    ,.LS(LS)
    ,.LU(LU)
	 ,.imm(imm));
  
  dataflow DF0 (
    .sub_sra(sub_sra)
    ,.insn_out(insn)
    ,.insn_clk(insn_clk)
    ,.pc_clk(pc_clk)
    ,.rd_clk(rd_clk)
    ,.reset(reset)
    ,.pc_next_sel(pc_next_sel)
    ,.pc_alu_sel(pc_alu_sel)
    ,.alu_sel_a(alu_sel_a)
    ,.alu_sel_b(alu_sel_b)
    ,.addr_sel(addr_sel)
    ,.rd_sel(rd_sel)
    ,.func(func)
    ,.mem_extend(mem_extend)
    ,.rs1(rs1)
    ,.rs2(rs2)
    ,.rd(rd)
    ,.data_o(data_o)
    ,.addr(addr)
    ,.rs2_mem_i(data_i)
    ,.EQ(EQ)
    ,.LS(LS)
    ,.LU(LU)
	 ,.imm(imm)
  );



endmodule