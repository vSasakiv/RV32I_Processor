`timescale 1ns / 100ps
/* 
Testbench para teste do Decodificador de instruções do tipo I load, que confere
todas as saídas do módulo com as saídas corretas, e ao final retorna o número
de erros, se houver. */
module DecoderIINSN_load_TB ();

reg [31:0] INSN; // reg que contém a instrução

// regs que contém os valores corretos de todas as saídas do módulo
reg sub_sra_c, addr_sel_c, pc_next_sel_c, pc_alu_sel_c;
reg rd_clk_c, mem_clk_c;

// net que contém o sinal de Clock proveniente do gerador
wire CLK;

// nets contendo as saídas do módulo em teste
wire sub_sra, addr_sel, pc_next_sel, pc_alu_sel;
wire rd_clk, mem_clk;

integer errors; // contador

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
    errors = errors+1;
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

// Unidade em teste, Decoder I para load
DecoderIINSN_load UUT (
  .INSN(INSN),
  .CLK(CLK), 
  .sub_sra(sub_sra), 
  .addr_sel(addr_sel), 
  .pc_next_sel(pc_next_sel), 
  .pc_alu_sel(pc_alu_sel),
  .rd_clk(rd_clk), 
  .mem_clk(mem_clk)
);

// gerador de Clock
ClockGen C0 (.CLK(CLK));

initial begin
  errors = 0;
  // Instrução arbitrária: carrega o valor no endereço x15 + IMM no
  // registrador x16
  INSN = 32'h0087A803;

  sub_sra_c = 0;
  addr_sel_c = ~CLK;
  pc_next_sel_c = 0;
  pc_alu_sel_c = 0;
  rd_clk_c = CLK;
  mem_clk_c = 0;
  #10;
  Check( 
    sub_sra_c, 
    addr_sel_c, 
    pc_next_sel_c, 
    pc_alu_sel_c, 
    rd_clk_c, 
    mem_clk_c
  );

  $display("Finished, got %d errors", errors);
  $stop;
end
endmodule