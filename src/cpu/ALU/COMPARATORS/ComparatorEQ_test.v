`timescale 1ns / 100ps
/* 
Testbench para o comparador de igualdade, roda para todos as possíveis
saídas de uma subtração entre A e B, porém apenas todas de 16 bits,
já que todas as combinações de 32 bits não é viável
 */
module ComparatorEQ_TB ();
reg [31:0] S; // Subtração A - B
reg correct; // Valor correto
wire EQ; // Valor entregue pelo módulo
integer i, errors; // Contadores

task Check;
    input xpectEQ;
    if (EQ != xpectEQ) begin 
        $display ("Error S: %32b, xpect: %b", S, EQ);
        errors = errors + 1;
    end
endtask

// Unidade em teste: comparador de igualdade
ComparatorEQ UUT (.S(A), .EQ(EQ));

initial begin
    errors = 0;
  
    for (i = 0; i < 65536; i = i + 1) begin
      S = i;
      correct = 0;
      if (S == 32'b0) begin
        correct = 1;
      end
      Check(correct);
    end
    
    $display ("Finished, got %2d errors", errors);
    $stop;
end

endmodule