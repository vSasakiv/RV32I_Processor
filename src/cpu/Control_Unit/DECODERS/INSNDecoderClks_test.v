`timescale 1ns / 100ps
module INSNDecoderClks_TB ();
  reg [31:0] insn;
  reg [9:0] code;
  reg EQ, LS, LU;

  wire clk;

  wire addr_sel, pc_next_sel, sub_sra, pc_alu_sel, rd_clk, mem_clk;

  reg addr_sel_correct, pc_next_sel_correct, sub_sra_correct, pc_alu_sel_correct, rd_clk_correct, mem_clk_correct;
  integer errors;

/* 
Task verifica se o valor esperado é igual ao valor devolvido pelo módulo
*/
task Check;
  input sub_sra_x, addr_sel_x, pc_next_sel_x, pc_alu_sel_x;
  input rd_clk_x, mem_clk_x;

  begin
  if (sub_sra_x !== sub_sra) begin
    $display("Error on sub_sra: %b, Expected: %b", sub_sra, sub_sra_x);
    errors = errors+1;
  end
  if (addr_sel_x !== addr_sel) begin
    $display("Error on addr_sel: %b, Expected: %b", addr_sel, addr_sel_x);
    errors = errors + 1;
  end
  if (pc_alu_sel_x !== pc_alu_sel) begin
    $display("Error on pc_alu_sel: %b, Expected: %b", pc_alu_sel, pc_alu_sel_x);
    errors = errors+1;
  end
  if (pc_next_sel_x !== pc_next_sel) begin
    $display("Error on pc_next_sel: %b, Expected: %b", pc_next_sel, pc_next_sel_x);
    errors = errors+1;
  end
  if (rd_clk_x !== rd_clk) begin
    $display("Error on rd_clk: %b, Expected: %b", rd_clk, rd_clk_x);
    errors = errors+1;
  end
  if (mem_clk_x !== mem_clk) begin
    $display("Error on mem_clk: %b, Expected: %b", mem_clk, mem_clk_x);
    errors = errors+1;
  end
  end
endtask


  INSNDecoderClks UUT (.insn(insn), .code(code), .clk(clk), .EQ(EQ), .LS(LS), .LU(LU), .addr_sel(addr_sel), .pc_alu_sel(pc_alu_sel), .pc_next_sel(pc_next_sel), .sub_sra(sub_sra), .rd_clk(rd_clk), .mem_clk(mem_clk));

  ClockGen C0 (.clk(clk));

  initial begin
    
    errors = 0;
    #10
    // Instrução arbitrária: compara registrador x5 e x4, e caso sejam iguais avança o pc em 8.
    insn = 32'h00520463;
    code = 10'b0000010000;
    // para efeito de testes, consideraremos x5 e x4 igual
    sub_sra_correct = 1;
    addr_sel_correct = 0;
    pc_next_sel_correct = 0;
    pc_alu_sel_correct = ~clk;
    rd_clk_correct = 0;
    mem_clk_correct = 0;

    EQ = 1'b1;
    LS = 1'bx;
    LU = 1'bx;
    
    #10;
    Check( 
      sub_sra_correct, 
      addr_sel_correct, 
      pc_next_sel_correct, 
      pc_alu_sel_correct, 
      rd_clk_correct, 
      mem_clk_correct
    );

    $display("Finished, got %3d errors", errors);
    $stop;
  end


endmodule