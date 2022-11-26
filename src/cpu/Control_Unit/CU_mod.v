/* Módulo da Control Unit do processador.
Recebe a instrução e os sinais resultados de comparações da ALU, emitindo sinais necessários para execução da instrução dada */
module CU (
  input clk,
  input [31:0] insn, // Instrução 
  input LU, LS, EQ, // Sinais resultados de comparações da ALU
  output addr_sel, alu_sel_a, alu_sel_b, pc_next_sel,  pc_alu_sel, // Seletores, sinais que selecionam saídas de multiplexadores 
  output rd_clk, mem_clk, pc_clk, insn_clk, // Clocks, sinais períodicos que controlam circuitos sequênciais 
  output sub_sra, // Sinal que indica se a ALU deve fazer uma adição ou uma subtração, ou se deve realizar um logical ou um arithmetic right shift
  output [31:0] imm, // Valor do imediato
  output [1:0] mem_size, // Sinal que indica o tamanho da dado que será armazenado na memória (instrução store)
  output [2:0] mem_extend, // Sinal que indica como deve ser extendindo o valor que sai da memória (instrução load)
  output [2:0] func, // Sinal que específica uma instrução dentro de um mesmo tipo
  output [1:0] rd_sel, // Seletor do valor que o registrador rd do regfile irá receber 
  output [4:0] rs1, rs2, rd // Endereços no regfile dos registradores de saída rs1 e rs2 e do registrador de destino rd
);

  // Decodificação do opcode em um código - code - que será utilizado para decidir quais sinais emitir
  wire [9:0] code;
  OPDecoder OPD0 (.insn(insn), .code(code));

  // Instanciação dos módulos 
  immx IMMX0 (.insn(insn), .imm(imm), .code(code)); // Gera o valor do imediato
  INSNDecoderClks IDC0 (.insn(insn), .code(code), .clk(clk), .EQ(EQ), .LS(LS), .LU(LU), .addr_sel(addr_sel), .pc_next_sel(pc_next_sel), .sub_sra(sub_sra), .pc_alu_sel(pc_alu_sel), .rd_clk(rd_clk), .mem_clk(mem_clk)); // Gera alguns de clk, seletores e o sub_sra
  ALUSelA ASA0 (.code(code), .alu_sel_a(alu_sel_a), .insn(insn)); // Gera os seletores da entrada A da ALU
  ALUSelB ASB0 (.code(code), .alu_sel_b(alu_sel_b)); //  Gera os seletores da entrada B da ALU
  funcMux F3M0 (.code(code), .insn(insn[14:12]), .func(func)); // Gera o sinal func
  RdSel RS0 (.code(code), .rd_sel(rd_sel)); // Gera o seletor do valor de entrada no rd

  // Sinais que não dependem do opcode, podem ser extraídos diretamente da instrução 
  assign rs1 = insn[19:15];
  assign rs2 = insn[24:20];
  assign rd = insn[11:7];
  assign mem_extend = insn[14:12];
  assign mem_size = insn[13:12];
  assign insn_clk = ~clk;
  assign pc_clk = clk;

endmodule