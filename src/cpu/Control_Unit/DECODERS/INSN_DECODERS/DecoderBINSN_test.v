`timescale 1ns / 100ps
/* Testbench para teste do Decodificador de instruções do tipo B (branches), que confere
todas as saídas do módulo com as saídas corretas, e ao final retorna o número
de erros, se houver. */
module DecoderBINSN_TB ();

reg [31:0] insn; // reg que contém a instrução
reg pc_alu_sel_c; // reg que contém o valor correto da saída do módulo
reg EQ, LS, LU; // regs que contém o resultado das comparações

// net que contém o sinal de Clock proveniente do gerador
wire clk;

// net contendo a saída do módulo em teste
wire pc_alu_sel;

integer errors; // contador

/* Task verifica se o valor esperado é igual ao valor devolvido pelo módulo */
task Check;
  input pc_alu_sel_x;
  begin
  if (pc_alu_sel_x !== pc_alu_sel) begin
    $display("Error on pc_alu_sel: %b, Expected: %b", pc_alu_sel, pc_alu_sel_x);
    errors = errors + 1;
  end
  end
endtask

// Unidade em teste: decoder de instruções do tipo B
DecoderBINSN UUT (
  .insn(insn),
  .clk(clk), 
  .pc_alu_sel(pc_alu_sel),
  .EQ(EQ),
  .LS(LS),
  .LU(LU)
);

// gerador de Clock
ClockGen C0 (.clk(clk));

initial begin
  errors = 0;
  #10
  // Instrução arbitrária: compara registrador x5 e x4, e caso sejam iguais avança o pc em 8.
  insn = 32'h00520463;
  // para efeito de testes, consideraremos x5 e x4 igual (EQ = 1)
  pc_alu_sel_c = ~clk;
  EQ = 1'b1;
  LS = 1'bx;
  LU = 1'bx;

  #10;
  Check(pc_alu_sel_c);

  // Instrução arbitrária: compara registrador x5 e x4, e caso sejam iguais avança o pc em 8.
  insn = 32'h00520463;
  // para efeito de testes, consideraremos x5 e x4 diferentes (EQ = 0)
  pc_alu_sel_c = 0;
  EQ = 1'b0;
  LS = 1'bx;
  LU = 1'bx;

  #10;
  Check(pc_alu_sel_c);

  $display("Finished, got %d errors", errors);
  $stop;
end
endmodule