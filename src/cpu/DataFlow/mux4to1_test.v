/* Testbench para o módulo do multiplexador 2 para 1, neste teste novamente são sorteados
entrdas aleatórias, e para cada par de entradas, é testado os dois estados possíveis do select,
e isso é exposto ao terminal por meio do $monitor */
`timescale 1 ns / 100 ps

module mux4to1_TB ();
    wire [31:0] data_o; // saída do multiplexador
    reg [1:0] select; // seletor
    reg [31:0] I0, I1, I2, I3; // entradas do multiplexador
    integer i, j;

    // módulo em teste: multiplexaxdor 4 entradas
    mux4to1 UUT (.select(select), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .data_o(data_o));

    initial begin
        $monitor("I0: %h I1: %h I2: %h I3: %h data_o: %h select: %h", I0, I1, I2, I3, data_o, select);
        for (i = 0; i < 50; i = i + 1) begin
          I0 = $urandom;
          I1 = $urandom;
          I2 = $urandom;
          I3 = $urandom;
          for (j = 0; j < 4; j = j + 1) begin
            select = j;
            #10;
          end

        end
        $display("Finished");
        $stop;
    end
    

endmodule