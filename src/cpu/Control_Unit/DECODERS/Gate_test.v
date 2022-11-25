`timescale 1ns / 100ps
/* Testbench para o módulo GATE.
Testa, para dois valores de code e Dec_Data arbitrários, se o valor gerado pelo gate é igual ao esperado. 
Se algum valor for diferente do esperado, mostra os valores na saída e aumenta a contagem do erros.
Ao final, mostra a quantidade total de erros obtidos */
module Gate_TB ();

reg [9:0] code, Dec_Data; // Código recebido do OPDECODER e os sinais concatenados dos decodificadores
wire S; // net com o sinal que sai do gate
reg correctS; // Reg com o valor correto que o sinal S deve ter

integer errors;

/* Task responsável por verificar se o valor recebido do módulo é igual ao esperado */
task Check;
  input SX;
  if (SX !== S) begin
    $display("Error, S: %b, expected: %b", S, SX);
    errors = errors + 1;
  end
endtask

// módulo testado
Gate UUT (.code(code), .Dec_Data(Dec_Data), .S(S));

/* Atribui valores a code e Dec_Data e registra qual é o valor certo. Após isso, testa o módulo
OBS: Valores arbitrários de code e Dec_Data. Para testar outros, ficar atento a qual valor o correctS deve assumir. */
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