`timescale 1ns / 100ps
/* Testbench para o módulo decodificador do OPCODE da instrução INSN.
Testa, para cada valor de OPCODE que INSN pode ter, se o valor gerado pelo decodificador é igual ao esperado. 
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module Gate_TB ();

reg [9:0] code, Dec_Data;
wire S;
reg correctS;

integer errors;

task Check;
  input SX;
  if (SX !== S) begin
    $display("Error, S: %b, expected: %b", S, SX);
    errors = errors + 1;
  end
endtask

// módulo testado
Gate UUT (.code(code), .Dec_Data(Dec_Data), .S(S));

initial begin
  errors = 0;
  code = {9'b0, 1'b1};
  Dec_Data = 10'b0100100101;

  correctS = 1;
  #10
  Check(correctS);
  code = {8'b0, 1'b1, 1'b0};
  Dec_Data = 10'b0100100101;

  correctS = 0;
  #10
  Check(correctS);


  $display("Finished, got %d errors", errors);
  $stop;
end
endmodule