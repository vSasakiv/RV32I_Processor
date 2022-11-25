`timescale 1ns / 100ps
/* Testbench para teste do Decodificador de instruções do tipo R, que confere
todas as saídas do módulo com as saídas corretas, e ao final retorna o número
de erros, se houver. */
module DecoderRINSN_TB ();

reg [31:0] insn; // reg que contém a instrução

// reg que contém o valore correto da saída do módulo
reg sub_sra_c;

// net que contém o sinal de Clock proveniente do gerador
wire clk;

// net contendo a saída do módulo em teste
wire sub_sra;

integer errors; // contador

/* Task verifica se o valor esperado é igual ao valor devolvido pelo módulo */
task Check;
  input sub_sra_x;
  begin
  if (sub_sra_x !== sub_sra) begin
    $display("Error on sub_sra: %b, Expected: %b", sub_sra, sub_sra_x);
    errors = errors + 1;
  end
  end
endtask

// Unidade em teste: decoder de instruções do tipo R
DecoderRINSN UUT (
  .insn(insn),
  .clk(clk), 
  .sub_sra(sub_sra)
);

// gerador de Clock
ClockGen C0 (.clk(clk));

initial begin
  errors = 0;
  // Instrução arbitrária: soma do registrador x2 com o registrador x15
  // com registrador de destino x1
  insn = 32'h00F100B3;
  sub_sra_c = 0;
  
  #10;
  Check(sub_sra_c);

  // Instrução arbitrária: subtração do registrador x20 com o registrador x2
  // com registrador de destino x1
  insn = 32'h402A00B3;
  sub_sra_c = 1;

  #10;
  Check(sub_sra_c);

  $display("Finished, got %d errors", errors);
  $stop;
end
endmodule