`timescale 1ns / 100ps // Unidade de tempo adotada

/* Módulo do gerador do sinal CLOCK. 
a cada período de tempo, especificado no parâmetro delay, o valor de CLOCK muda, seja de 0 para 1 (rising edge) ou de 1 para 0 (falling edge).*/
module ClockGen (
    output reg clk
);
parameter delay = 5000; // Tempo, na unidade adotada, entre duas edges. 

initial
    clk = 0; // Clock inicial estabelecido como 0;

always 
    #delay clk = ~clk;

endmodule 
