`timescale 1ns / 100ps
/* Testbench para o módulo gerador do sinal CLOCK.
Para uma quantidade "CICLOS" de ciclos do sinal CLOCK, a cada tempo especificado pelo DELAY, verifica se o sinal recebido do módulo é igual ao esperado.
Se algum valor for diferente do esperado ("xpect"), mostra os valores na saída e aumenta a contagem do erros. 
Ao final, mostra a quantidade total de erros obtidos. */
module ClockGen_TB ();
reg correctCLK; // Armazena o valor esperado do sinal CLOCK.
wire CLK;
integer errors, C;
parameter DELAY = 500000000; //Parâmetro arbitrário, tempo entre duas edges do sinal CLOCK.
parameter CICLOS = 10; // Quantidade de ciclos testados.

// task que verifica se a saída do módulo é igual ao valor esperado.
task Check;
    input xpectCLK;
    if (CLK != xpectCLK) begin 
        $display ("Error, CLK: $b, expeted: $b", CLK, xpectCLK);
    errors = errors + 1;
    end
endtask

// módulo testado
ClockGen #(.delay(DELAY)) UUT (.CLK(CLK));


initial begin
    errors = 0;

    for (C = 0; C < CICLOS; C = C + 1) begin // Laço for que executa o teste para "CICLOS" ciclos do sinal CLOCK.
        correctCLK = 0;
        Check (correctCLK);
        #DELAY;
        correctCLK = 1;
        Check (correctCLK);
        #DELAY;
    end
    $display ("Finished, got %2d errors", errors);
    $stop;
end

endmodule
