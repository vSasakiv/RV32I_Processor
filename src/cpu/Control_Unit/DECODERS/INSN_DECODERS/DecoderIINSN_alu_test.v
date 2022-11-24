`timescale 1ns / 100ps
/* 
Testbench para teste do Decodificador de instruções do tipo I alu, que confere
todas as saídas do módulo com as saídas corretas, e ao final retorna o número
de erros, se houver. */
module DecoderIINSN_alu_TB ();

reg [31:0] insn; // reg que contém a instrução

// reg que contém os valores correto da saída do módulo
reg sub_sra_c;

// net que contém o sinal de Clock proveniente do gerador
wire clk;

// net contendo a saída do módulo em teste
wire sub_sra;

integer errors; // contador

/* 
Task verifica se o valor esperado é igual ao valor devolvido pelo módulo
*/
task Check;
  input sub_sra_x;
  begin
  if (sub_sra_x !== sub_sra) begin
    $display("Error on sub_sra: %b, Expected: %b", sub_sra, sub_sra_x);
    errors = errors + 1;
  end
  end
endtask

// Unidade em teste, Decoder I para alu
DecoderIINSN_alu UUT (
  .insn(insn),
  .clk(clk), 
  .sub_sra(sub_sra)
);

// gerador de Clock
ClockGen C0 (.clk(clk));

initial begin
  errors = 0;
  // Instrução arbitrária: soma de um registrador com um imediato
  insn = 32'h00A10093;
  sub_sra_c = 0;

  #10;
  Check(sub_sra_c);

  // Instrução arbitrária: shift right aritmético de um registrador com um imediato
  insn = 32'h4027DA13;
  sub_sra_c = 1;

  #10;
  Check(sub_sra_c);

  $display("Finished, got %d errors", errors);
  $stop;
end
endmodule