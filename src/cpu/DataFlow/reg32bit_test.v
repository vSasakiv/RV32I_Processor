/* Testbench para o registrador de 32 bits. Sorteamos valores aleatórios para a entrada
do registrador, verificamos se o valor realmente foi armazenado e por fim ativamos o reset
e verificamos se o valor dele realmente está igual a 0 */
`timescale 1 ns / 100 ps

module reg32bit_TB ();
    reg clk; // entrada sinal de clock
    reg reset; // sinal de reset
    wire [31:0] data_o; // saída do registrador
    reg [31:0] data_i; // entrada do registrador
    integer i;

    // módulo em teste: registrador de 32 bits
    reg32bit UUT (.clk(clk), .data_i(data_i), .data_o(data_o), .rs_i(reset));

    initial begin
        clk = 0;
        reset = 0;
        for (i = 0; i < 50; i = i + 1) begin
            data_i = $urandom;
            #10;
            clk = ~clk;
            #10;
            if (data_o !== data_i) begin
                $display("Error: data_o = %d data_i = %d", data_o, data_i);
            end
            clk = ~clk;
        end
        reset = 1;
        #10
        clk = ~clk;
        #10
        if (data_o !== 32'h00000000) begin
          $display("Error: data_o = %d data_i = %d", data_o, data_i);
        end
        $display("Finished");
        $stop;
    end
endmodule